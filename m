Return-Path: <linux-kernel+bounces-313559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9863896A70B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8B81C21062
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C311D86DB;
	Tue,  3 Sep 2024 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0NrSXCL"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32021D6793
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390084; cv=none; b=thYTYVJ8Ff2SD6TFmmNqq8rwVhuN5jNXMIXsIvFMBBIAg54g2b0o2M4qAVZWPaIX+70h1dfZIH/bZSL9a32INdBs7jPfTqH3EMbwBNOqtAfnzSMWpg7oQP4htC0Jwo0pnIFRtSHrP5HoeF1N3SN7JHi5bojKF8+NpZP6FafE6sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390084; c=relaxed/simple;
	bh=UvKaRrOw7SizEU+Eg3t01fFMiofBkP5X9mkQBRTB/EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bvRBszzW/6HsgAh9yYa7Nt/ISLTmg/YDEOjmnG2N22PdtDmQ/cqaCx3aCk3tGv6Ib44YcxqUp8bdCtew4aRNIvpDrPZSFliMTIPE7ctQb7nABiWd27zgBOHy+Dy6Ad+mLxkh6OC1lQIeVRxr9dA+6gVU6Iw8JCY/PMdA/bS5YwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0NrSXCL; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-533de5a88f8so5891720e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 12:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725390081; x=1725994881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luh7BfYLwX/7YYvz9h2M0t/wGSBnpzt8TNRH/XIw5PA=;
        b=d0NrSXCLC0KJW63MG51vBxEav9Hw/Fx/wUivzOhOMtVgyfnfHaJ9Bm/Tqqt7crgblj
         vLOtG4x81UZwmZMwJe/tnU3IUNXvogcIlJJIReCeq3EKtx9juMGYt1Y6XbSVMMxPjEVS
         lHf+c94FqpaeMq5V9W935Uiocr98txkDvx2ObGHLOlnN+o2jcBS3yJ61EKM+jiKL+HAE
         45ZvcVkmhGVPfZ1x3VJH7fUAhwKJXzxq/A4hYYqtBkA1RoD4RXwCg4LC1vyJ+3pOlEeZ
         yFDs4xSsnti60miwaE+AWCgOfX+b88g45qluPTMxbvdh2HUXptWhXFK9wh+kt+++RuHl
         MjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725390081; x=1725994881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luh7BfYLwX/7YYvz9h2M0t/wGSBnpzt8TNRH/XIw5PA=;
        b=Q++dv7MMrc0a8+fee2SNUtK/U6/BU8I29grpRRDjw3fjVZPoDS9kLThwNqBnWFNeDm
         OSf7YOeYEwaAGLXHyRVav5xXxnFuQRgDabTHNIDpb2STZzIvULeKUUbU29b4wVTDwl46
         T6k+40ERzBo91o2dBXvDmrG3GMbdxqxLh8fV0cP1Z2coct3sdjxOWgp+kzBhIzLRd+Dv
         MykK5e+8dr7489wZIlVIETS+UogzUhxSDB6Ix531sRCVI6BJlPW0hQzgqS+Tcx8NrTho
         OXoLkyOx7Wwu4QkUXRmIDbff49VRgOdiN7LLL5a2xITGjymEexDYvRRLu9fB+qsPQkyc
         n/3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIS8vM8+/u4QlP5U+S0X6W1en4C4eMXx+YNLXbM1QWO8G0LvtGhtpu3OCvaI17Fw4aH9MHcRoi1V36dLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt8lTuACz8u1jWN2OejFGS6ztwUzZZrMHkNGZDeznPl5mr9WCJ
	LVJx0aiY2WAhYXL0iMzPmtA8B0dxat+3NLS1hI5xU3Jaxx/bC8l2eVXljwQNMFaLb3cE6slKAdh
	K8y/HojR9jgDNY8kqlt4zhS62q+U=
X-Google-Smtp-Source: AGHT+IFNPZESYuAGmVCQP5ePJ9Xq8JiFFCbwpggP3rkZ0vrJ4cVFwPxC/xT0SxglEUhnoCT9NtCA0Bn4vkbwyIqm5tU=
X-Received: by 2002:a05:651c:1545:b0:2f1:6821:d15c with SMTP id
 38308e7fff4ca-2f61e0b268bmr89081621fa.38.1725390080108; Tue, 03 Sep 2024
 12:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903102342.36957-1-ubizjak@gmail.com> <e01dcb5fc34b4686c7fb32d1644802c164910ecb.camel@xry111.site>
In-Reply-To: <e01dcb5fc34b4686c7fb32d1644802c164910ecb.camel@xry111.site>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 3 Sep 2024 21:01:12 +0200
Message-ID: <CAFULd4b_vemxT_6dWRWmjwZKyVSKyojY0Sw77hppsC+--qbZZQ@mail.gmail.com>
Subject: Re: [PATCH] longsoon/percpu: Simplify _percpu_read() and _percpu_write()
To: Xi Ruoyao <xry111@xry111.site>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 8:57=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> On Tue, 2024-09-03 at 12:23 +0200, Uros Bizjak wrote:
> > +#define _percpu_write(size, _pcp, _val)                               =
       \
> > +do {                                                                 \
> > +     unsigned long __pcp_val =3D __pcpu_cast_##size(_val);            =
 \
> > +                                                                     \
> > +     __asm__ __volatile__ (__pcpu_op_##size("stx") "%[val] $r21, %[ptr=
]      \n" \
>
> Missing a comma before $r21 (as the bot already pointed out).

Oh, indeed... I triple checked the patch and missed the most obvious thing =
:(

BR,
Uros.

>
> > +             :                                                       \
> > +             : [val] "r"(__pcp_val), [ptr] "r"(&(_pcp))              \
> > +             : "memory");                                            \
> > +} while (0)
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University

