Return-Path: <linux-kernel+bounces-185200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED738CB1EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185C1281AED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028AD1C6A7;
	Tue, 21 May 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcA+SRQ/"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C021B966
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716307727; cv=none; b=pHnxM7ajStyfGhpOIivNGluueVWIwVf69nfdb+xnVsVFc3GRk18IQIro+h5D5VuF1ajVItmJtzJY0WcD28re6oBcL84YtTtqeVt0jz1LoW6cmOnAJ+550KC+fOgnz2wp412oTZbhaREnJdGPhOWDfpqaljoZNSE42jdIxXQXnAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716307727; c=relaxed/simple;
	bh=EScbAJhMnWocr4XlcHu5oFUWTsT1dHQfIpYWQ9wHPzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n/R54Sa4vof7YwYhdx/2//hgZAWeTR9QqgBqkISwjOohWEOXCafWtmFV2dUwBYopdi7Gvt87peKDeHAOOX9rlOnVEdzSTdCwZ+rUuSKeRx1skBzBa7Ct35pCuqsov0z2yHB7iDb1xxHvm5bFtLVEQA5k9UMcb6e24nS5xYETvrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcA+SRQ/; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23fb9c871c8so2131731fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716307725; x=1716912525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdlcR+6M33gC9GMPkux8N1n3rQUCsLFetSVGqDj9n88=;
        b=PcA+SRQ/dxoKdlJ2VDLNbP24+z9s+utzRJz0mMQ+W/IHI97YBwddQa0a5hvT18UMdU
         BPw4Dnp7bQgA+ZZg16hgRf1TyAUNlae+wiLebgeYBaFGk8NeASpHUm/awBWXqNYhkc9Q
         W0m1uwfNbilvdnuMR/d0RYeYIf864j2leP9XI/+xxBs/j0j0/CmX06+b4SxFcBnOsnsl
         z53VbSBRkLao79SAMHNUMTBUQR0xiaOJuEAJ3etS2NjD5pg3RaR6s7zMdSZ9Cp6vsjMa
         c8xv0FBO+q+XPSI+P2uaX1ENecgCJwlU8Yh8pSvVGkPZ51PuPSQXVQbAUg/arKQAUoiO
         OlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716307725; x=1716912525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdlcR+6M33gC9GMPkux8N1n3rQUCsLFetSVGqDj9n88=;
        b=Yfak9rhNy2CE5bv991DmAUUG6nsise53gmFDQygBN/Qc5eRuDAYx8fpPTy21qKEqpO
         Z4XRNuXZGQ/zUsDLDeBrSOHtOl7lkoelpZjOEabhDwWK7qYIQ/JXqeoRyYHzy0ZfHQr7
         BbPoY3ZsmSwNiq/MqjQ/FRADAKtm8yhkCsAkAJLlK6A1vjrGiazEY6n2f/U3OtIwpwfd
         uXIlUxjCiZ8qdSGJRJPdNqglZZlIoaabJbnTdBMTfpJbbTsmgkAE1nzCpgLzxLOZNczY
         4o0R2N93LzQXwRAxPkPeACE+VUEulLEM1IT8jjtEfoTdTTZ2YdKjK/uvDlli4E0v8MhD
         Nhtw==
X-Forwarded-Encrypted: i=1; AJvYcCXZDFWNy05sY3WAoQUpSBExmjy9yyXQtSMaZaC6toolSCmFbkUsbD+1v1c6elDei80YaHE74U4G8KRenc47DR67OEJossJ0HgMXJYxk
X-Gm-Message-State: AOJu0Yz4EYWi0IpyV6EduW+qQqtEvMqFSGhhYDaIb6dUV0ip/qEg1vG/
	04m2neXtb5Tv9g12JkJcanSzSwOt0KaWY9mV9QZrFUrVX4V9iem5ZiUS96SW16mEJ2ODArfk+UJ
	9D9EtAochpClvOznCjSI1XyKYoBo=
X-Google-Smtp-Source: AGHT+IGaf+YJm5miFPfLDWWqlXlCR7Mlihjs7N9gD5N/yYuIlQGxldHsw1FpznZGTiFW1lYI17g/nrKIPxIFQ2q1TRo=
X-Received: by 2002:a05:6870:a710:b0:234:56db:7c8c with SMTP id
 586e51a60fabf-24172f6720amr36708307fac.57.1716307725027; Tue, 21 May 2024
 09:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-23-jim.cromie@gmail.com>
 <CALwA+Nb8EKBRk+1ejxWhRBhoYf=Arge5TvA-mPzDD95Am+7pYw@mail.gmail.com>
In-Reply-To: <CALwA+Nb8EKBRk+1ejxWhRBhoYf=Arge5TvA-mPzDD95Am+7pYw@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Tue, 21 May 2024 10:08:18 -0600
Message-ID: <CAJfuBxxhTzOOBz_kTc9APGVw==r1fkyk+rdiri3wJAYJZSYoLQ@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 22/33] dyndbg: split multi-query strings with %
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 5:58=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@chromi=
um.org> wrote:
>
> On Thu, May 16, 2024 at 7:45=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com>=
 wrote:
> >
> > Multi-query strings have long allowed:

.. input like:  (Im using it like a verb)

> Missing been ?

this is an alternative.
maybe s/strings/commands/ too

> >
> >   modprobe drm dyndbg=3D"class DRM_UT_CORE +p; class DRM_UT_KMS +p"
> >   modprobe drm dyndbg=3D<<EOX
> >      class DRM_UT_CORE +p
> >      class DRM_UT_KMS +p
> >   EOX
> >

