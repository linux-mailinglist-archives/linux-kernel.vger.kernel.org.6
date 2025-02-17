Return-Path: <linux-kernel+bounces-518249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3228BA38C3E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4203B1401
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A27236A6A;
	Mon, 17 Feb 2025 19:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LEUWTai8"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6AA23537B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820089; cv=none; b=sjoyfzqEdg8WymNnGvSg/0lebFfgMyFiLvgpmMA4wFfOe/0ZI+dGzmYlhmWr4xSwC0y4FdRTVA811m/M1fj8H6eaX8ftQc5bUvNiqJMfz3cmeUahIQtweI9ZnN0HNiBji/0LL2aK4RdAUdi14gb23mbHMfMVgdkLeeN057aIXmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820089; c=relaxed/simple;
	bh=sF4dNgTXt9P2MfDrCOM2x387UotJwcbVDhqQcOqS8qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYZeKGRkSAIta2eYADh7xfOdWBy57LtZ51fhS85zmlmcsGE42DauAV9zupZfnZ0gPqPkpk+AbrTPDbArCnvFgijl8gmKSWZY3HKm5qlQoOM6IoeT/q7nj7ifAgaqnSlxcGcnDN+m2tLLLGNc2A4+cEUMW3ZlWeCBMLfnu5T8m5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LEUWTai8; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso6638188a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739820086; x=1740424886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKWt+CGIeGqmvl6o4duXuS4HEdgdnEPBpkkM9quSgZM=;
        b=LEUWTai8Udvd2WrNJJdiWgmkSZ29O1jrDaGNmecDH4Mp8eTlfEGosra8Esv5mCuw5m
         T9Me4dUURnCS4Q1AvBLazwVJWfgrzR5vjDv3vqvtbXp85LDMlTLVAayc6nea/z2L1Si6
         MGQcIyRe+1HNACMvQWLNExrbFi1uSDOwkYF9grupsFH7SNIWCpUizowy9rKipHfUs9SZ
         3a/Ew7EaFmJ7jzIWopksR9sKhylJZQrp5Axg35LncuRLLTyYOrVVngK3xwAzo+Rn1qR/
         OFLiX7nVKqOeElHZuelI6KDLK2yb7oyIl2hAjgrrr5jjnnLSAR/nco4GLbVaJp7Dd1lr
         cXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739820086; x=1740424886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKWt+CGIeGqmvl6o4duXuS4HEdgdnEPBpkkM9quSgZM=;
        b=p+qh6NkxWWrCWw6CT+x6N8+leTf/mclsn6NfoSTCvYjW0wOVhMdF5pKmqp8++9Vh6j
         pff6vyYnCP0JnmzuuwpklP2rxaiCknIdDcsA/X94zP9zFgthBcDEK90LfjadwyFBaapR
         O26pf6FzWvoOBU382bAvp2sWkf0Vo6IKOxGe5i2Vmh5hi0jCKOMp3w7bb2pyZFufZVhx
         ZXTVta2TV73cALG0ynbn6gUaTNfRi5NT5JWOP5OscWejN0WkLgtAn/7mAtBuvOWF8W+1
         poxoyJyGM2Zthp8EHElN/qTRvQOM5pV7ncShrO5MhNAXTEky63NUC5K7uO6/Rf+W5NHg
         oxjA==
X-Forwarded-Encrypted: i=1; AJvYcCWrzF2UghxcSsstTNQahyqdIgSS4YKp9NcQZu5YkcchSUKzsSIJRUvyQtMMk3HncPDv/8TGA5HVOtdzW2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXmNG6T9SBMxVoTIIqdUhUbGf2ncTwUdcSGnCaXlexuT1CI8we
	FHmdh5m7r8Bk9Cg+D3D+SA2j/Q59St9WK8bHbycPPAvBFaacXNBitTo4SmY3P+FAh2yMFl+6g6+
	TODKnAWtuiDHDX2HM9Q+oFAOipiosgyjBfbBCO5xFPKcH86y2IPPg
X-Gm-Gg: ASbGncuzBsdr3ilwSU+Q6I0QcB9QfFOO6ZdhBvSl4AOJ0U3vxZRrbiV9LAQcuLy5rbq
	kwcdpr4iZgOz3eedFgA6COXgnOgC0oeHa2PzCxrx/KoS2OZOvyzqG5oP2J+T02ELYi4/Xi0pQU6
	aD+VOigEAKblAN4orMEGz/hMpDvuvRHg==
X-Google-Smtp-Source: AGHT+IEap8PYC/gcmteZ5/Wv1Z18lYQy4FdMXowXmrhdhBEF8xkPaOCqgelb/BmzAGvTlxW6HATJTR3fKO7HM9UtNHA=
X-Received: by 2002:a05:6402:268a:b0:5de:594d:e9aa with SMTP id
 4fb4d7f45d1cf-5e03602e4a5mr29725670a12.8.1739820085654; Mon, 17 Feb 2025
 11:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO9wTFgtDGMxgE0QFu7CjhsMzqOm0ydV548j4ZjYz+SCgcRY3Q@mail.gmail.com>
 <CANn89iLjxy3+mTvZpS2ZU4Y_NnPHoQizz=PRXbmj7vO7_OGffQ@mail.gmail.com> <CAO9wTFjaLBbrT7JKBBN=2NMhSRmxzPk_jLSuG=i6Y5anZJnvEA@mail.gmail.com>
In-Reply-To: <CAO9wTFjaLBbrT7JKBBN=2NMhSRmxzPk_jLSuG=i6Y5anZJnvEA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Feb 2025 20:21:14 +0100
X-Gm-Features: AWEUYZl_PHuXaZdgyEUWM3QOrrhFjFhmZ0Rtac0XSGxtCN7MSzV1nZp0v_yrI1I
Message-ID: <CANn89iJmOKiALL9r_9+nyy5bdYwMUEX+LAkmswMyWwNC53yEew@mail.gmail.com>
Subject: Re: [PATCH] net: dev_addr_list: add address length validation in
 __hw_addr_insert function
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, horms@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 8:05=E2=80=AFPM Suchit K <suchitkarunakaran@gmail.c=
om> wrote:
>
> Hi Eric,
> Thanks for the feedback! I'm new to kernel development and still
> finding my way around.
> I wasn't working from a syzbot report on this one; I was just
> exploring the code and felt there is no parameter validation. I went
> ahead and made this change based on that impression. I realized my
> changelog should have been more generic. Sorry about that. Also since
> it's not based on a syzbot report, is it good to have this change?
> Your insights and suggestions would be most welcome. I will make the
> required changes accordingly.
> Thanks.

I think these checks are not necessary.

1) The caller (dev_addr_mod) provides non NULL pointers,
    there is no point adding tests, because if one of them was NULL,
    a crash would occur before hitting this function.

2) Your patch would silently hide a real issue if for some reason
dev->addr_len was too big.

