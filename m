Return-Path: <linux-kernel+bounces-223825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 086549118E0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB701F23482
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC98F8528F;
	Fri, 21 Jun 2024 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="X9cMNfo+"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF382899
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 03:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718938875; cv=none; b=piaESg1gQtoHdDJ5IJDdERfL/p5OoOSZAgXiBDgfJljiwjeEwP4eTf7Btrd+XLSSEUVbkFrUqj2PKS2f34GGtgZC/+eIA4ySnGiRbI4497/zicLIE7J7g5mnpZK0UKBt0fE4O51c2iAmZ3/ocRbWUebFofkFROd6aJOcUbjifLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718938875; c=relaxed/simple;
	bh=T42/A0l4/jfAh5+q9xr8uYc+BrdXsp8hh0BbKZRn4dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YO5TlJ+FdoKpHdooIdCb1up6ihMx8WHHPPTDa9EdLoJnqYYIvWez1qs5qbD6kVc9E741SDF0/8gYsNR6avhuQhO1dUvqGUWRrWTUOz9IxZfyZ/jNelvrAoTRTPhbHSc/amCwLL7rrpSN6DV9UYU11riaIJqXmnwONpRPjElTc/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=X9cMNfo+; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24c0dbd2866so831483fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 20:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718938872; x=1719543672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhH4UzFO6eCWAfNDZXl4qF39oiAH3m5hA5swtcyFl4o=;
        b=X9cMNfo+Uz3lxUZOGKyWLUaeYBfdXbLDq4s7dRRYpodzkeid88BoF9x2FZ2ioHa1t3
         +g/Gmk9v48rhd4/135rIS+hY4pK9eEQydPSNCBoV3ldm4cy+ARfTsyk+jjuaEYZPmYg6
         IrkOAAAIBBfTooyhGbFuPSMM2Z/JM99L32F7URGd7+twTkkvkDzvHw3p8FDsjPpC77vO
         ra/iy9otbFH9PEcNZSKRN/e269pcXRrUQQmBB9/Duy3ofzIULxisQ8rvx4/rqd+qlWg9
         kLPIdfy425CV9dw9lRAEFW3gYuVSaf5WqI66TbMGQctXDW8N4Zq6mm8C7wQvUQ7vyVTO
         gTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718938872; x=1719543672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhH4UzFO6eCWAfNDZXl4qF39oiAH3m5hA5swtcyFl4o=;
        b=fdBLlq+HM2JFBncjEs55rrGJzR35brTe4zmgbCy47FiaFy5WAa/PMVCdvq9URKe3or
         EIBg9r5uhmeEZxVokTvKZTvoHNywjPppXJTKujhyLQHzQ7SASChP/MyVl7Mj+QiO5nmx
         emX2rjO0y4F0K7RMEfLcca3lyZSPLyNIz10ONuL1eT9K6UtEdqW5Mv726HYdYAlgvIuW
         9Rc1Uyg27Kuu+IPIgKc3+tPVBdSxN2u/Etd4s+3NJ4N5R7kNyTe4qaDns9tEwb55M5dQ
         RFLlZE/gVoRxt1mFgsD1p/27IQkiJfUM1mQV4pTxv9bT5Fpui3KXLIXxOb1uKlTjCE5f
         sdyg==
X-Forwarded-Encrypted: i=1; AJvYcCXZvHPjZJXJBMA8LjtaNhTsUWnyewQFpewydYmDOBgG0/yxbsYaemyG+ro03G2g0MWLZ2j9FSsimsntnCLL6r0h/HVIHflo0M4n5Wf1
X-Gm-Message-State: AOJu0YxN7Hhyx8x6JUzOXP6XDIm5mdWGqS0hFF+JzgYI8fv3h9nqseCf
	WJE0ovg1f1nJQm20qnTYavKyxQhYUo1SWM23Oto+AggPaQfei572gJYP00MhKF/BJhkhZi0YitD
	UtP7VSecbK7WHzC2p+ZpQ10IHstsBTcnFR009Zw==
X-Google-Smtp-Source: AGHT+IGyFusLAIbhi8rnMuNWECpZj7QZvd3djKvKk4GFt8o8t2VKFxpjQUmUU64qgidV9DbQZc3wAs4aLywxdskKhs8=
X-Received: by 2002:a05:6870:970e:b0:24c:b80e:ee1b with SMTP id
 586e51a60fabf-25c94d70a03mr8284877fac.50.1718938871743; Thu, 20 Jun 2024
 20:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618114653.12485-1-cuiyunhui@bytedance.com>
 <2BA519C8-D258-4D98-AD49-AC7D30D8B0D2@jrtc27.com> <3c20c9f15cd7a9fb1f2e88560c1b089ac8032898.camel@icenowy.me>
In-Reply-To: <3c20c9f15cd7a9fb1f2e88560c1b089ac8032898.camel@icenowy.me>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 21 Jun 2024 11:01:00 +0800
Message-ID: <CAEEQ3w=HZptMOgXp2Rtuz-VtzPabN=h5N3=3wS4AMk3Lo7E7FQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: Provide the frequency of mtime via hwprobe
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Jessica Clarke <jrtc27@jrtc27.com>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Evan Green <evan@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, costa.shul@redhat.com, 
	Andy Chiu <andy.chiu@sifive.com>, samitolvanen@google.com, linux-doc@vger.kernel.org, 
	linux-riscv <linux-riscv@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Icenowy,

On Wed, Jun 19, 2024 at 7:51=E2=80=AFAM Icenowy Zheng <uwu@icenowy.me> wrot=
e:
>
> =E5=9C=A8 2024-06-18=E6=98=9F=E6=9C=9F=E4=BA=8C=E7=9A=84 18:11 +0100=EF=
=BC=8CJessica Clarke=E5=86=99=E9=81=93=EF=BC=9A
> > On 18 Jun 2024, at 12:46, Yunhui Cui <cuiyunhui@bytedance.com> wrote:
> > >
> > > From: Palmer Dabbelt <palmer@rivosinc.com>
> > >
> > > A handful of user-visible behavior is based on the frequency of the
> > > machine-mode time.
> > >
> > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >
> > I would suggest referring to the user-mode CSR instead, i.e. =E2=80=9Ct=
ime=E2=80=9D
> > rather than =E2=80=9Cmtime=E2=80=9D throughout in names and description=
s, since
> > that=E2=80=99s
> > the thing that user-mode software is actually reading from.
>
> Agree. MTIME isn't even a thing defined in RISC-V ISA -- it's part of
> the ACLINT timer spec, but before ACLINT gets widely accepted, it's
> just some SiFive thing that got copied by many other vendors (and
> vendors such as T-Head even provides CLINT w/o MTIME register (well
> because these T-Head cores have reference source code available, this
> is because of their CPU design uses an external counter fed as TIME
> register)).

Okay, Thanks for your suggestions,  I think this modification is more
appropriate:

RISC-V: Provide the frequency of time counter via hwprobe

A handful of user-visible behavior is based on the frequency of the
time counter.

What do you think ?

>
> >
> > Jess
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>

Thanks,
Yunhui

