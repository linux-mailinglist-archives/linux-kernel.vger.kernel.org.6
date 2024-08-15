Return-Path: <linux-kernel+bounces-288164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D522C9536AC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ECD51F21CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED311AD3F3;
	Thu, 15 Aug 2024 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wQJT5lrq"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364E71AB53B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734482; cv=none; b=ZSXpKMu/XNCd/DjHRsisJA2T21YvoYAtOsCc547pWNQKGaDE/qmF0magqxrtuLCA1ts/QhiGHpz78k+oMhNdwsR8rKiY6d+0bStqueUSJm+tuGmOqybOyL5th5fNwhG71iJyn5ydbZG1HnMO5Ybmsjqof5TPnc6Z4PN9u3Xm3G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734482; c=relaxed/simple;
	bh=O7Gj4FPw3G7uLAU4MEGR/F0KrwTcd+1Rxuwc21U9P1U=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MFcNhi4K12HtT6DxTERMKavknfSgFTNYRrQxbMCEmNw+K6MEJRotQRHz6KixMhcD/MdMAAd1z0gQF+/aFsH4hn7lObqyy7ClVVH6sRFf0VoX5vpGw1QKs2KQZrfXgsAcgKXVTkS67oaN5oA7S2WzuyKsa2dybmCT/e111nHVVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wQJT5lrq; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A8084421F7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 15:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1723734475;
	bh=O7Gj4FPw3G7uLAU4MEGR/F0KrwTcd+1Rxuwc21U9P1U=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=wQJT5lrqEKK7bwMEepHVYnOfk/d2rpGQAxTYcpCkwpmAaiwiVXmeg0Jl7HZO6THoj
	 g7dTKEFT4Kqh01TKDvIYtlg9lRgq7O32xHc4g6vPM/7T3esp5cVQbTu/zRybZLXxVS
	 g4/RsK56vUYmEF7jDPFQxrUpGErEV9E4is1t5KAuKaF6AWxuF68UOgIDKfu0wCE+kk
	 nq0EPQANskYGQmUqem7LcvayssRfLR2InhEYxutVI9lT3Xma4Ts9eKV6UKPcGar2oE
	 7HPXaE2wHrYaEOQv+sTR8cnqVToBltU4PV6BFtH9MwceFaOEeXem3taKr2k/ZiQeTJ
	 c5JKZuszJf+xQ==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4501aa4886fso11500661cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723734474; x=1724339274;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O7Gj4FPw3G7uLAU4MEGR/F0KrwTcd+1Rxuwc21U9P1U=;
        b=OgJArY7OTf3PbL85azND4ByRgkmg6/WjVCqQC0wimQW7jmfCeRdOanrfiTc8wRT1bI
         /xftQ5HOQsDpXnZeqUfgVyEG2Tm/LRvE+IF5FN7xRPO3ucNUmLOmbJuQPb6OuGWNBzxa
         Pa1TuoW9MJxZGBruR1NsAHHX226UFAPu6OOVgkko1JSeESo5dq5gYjO5sWzdVOutUr9X
         6btmCJWQGRUU8mhI1QoXegeMhTatOguF4l4CNTIoD4kiugs0wnp0SFLmFbwIzP0UcC9v
         UFUqnK7YVvIQ5NOgVoBQiCOX2hUej7UF/wCAn0bhxd6Pkrn2vR+V4K826sW7B+koP/9u
         Yebw==
X-Gm-Message-State: AOJu0YwUw2UHGwh7iMY/lNr7XFKQ9ZCDkqJvUKRgqAV/YP1yEUXTBrLl
	+rCKDpCS4MDoHsZEUUJ6fApnVL+JXYJyflhWD+VDVxOz1B7BGi3y9iQk3kZYPpJAs3f8OiYYOJ2
	qK19NwrXwVV064POSfrmouEowUqw8y6cBpN5a5fV5C4WpV1MxD3EbwhP6tkJy1W/sm03yZC2JTx
	CmpNrFmXYhqurQam1ChAB1b2kHuI6rpwwJaxq0wkkmTOWZEIAX7IGZ
X-Received: by 2002:ac8:1199:0:b0:453:6c9f:ec5a with SMTP id d75a77b69052e-4536c9fef86mr16626291cf.22.1723734474060;
        Thu, 15 Aug 2024 08:07:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEQrMUB6uwmlpoSPzE4Q46pTqZ42Lh5kb+mFo2U+8h2TWgZ0fwtNPmKmP2B+Kwln77U5qhE7GkLX7KM8FZ/xk=
X-Received: by 2002:ac8:1199:0:b0:453:6c9f:ec5a with SMTP id
 d75a77b69052e-4536c9fef86mr16625871cf.22.1723734473624; Thu, 15 Aug 2024
 08:07:53 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Aug 2024 11:07:53 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <be1db8f5-af55-48a4-be7a-5e8a1a5e25c4@sifive.com>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx> <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
 <87ttfmm2ns.ffs@tglx> <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
 <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com>
 <87plqalyd4.ffs@tglx> <686d61c4-e7ac-4dca-a7fd-decdd72e84d9@sifive.com>
 <87h6blnaf1.ffs@tglx> <CAK9=C2V7oL023=u6nodJs76k_0yHZ8PTJs=n1QFqDWCcCnG9kw@mail.gmail.com>
 <be1db8f5-af55-48a4-be7a-5e8a1a5e25c4@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 15 Aug 2024 11:07:53 -0400
Message-ID: <CAJM55Z9kKqs-kMubsGsRkS6E2Y4ur1MmwD+1XFvGP=UVNrJvRg@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
To: Samuel Holland <samuel.holland@sifive.com>, Anup Patel <apatel@ventanamicro.com>, 
	Thomas Gleixner <tglx@linutronix.de>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Samuel Holland wrote:
> On 2024-08-15 9:16 AM, Anup Patel wrote:
> > On Thu, Aug 15, 2024 at 7:41=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >>
> >> On Thu, Aug 15 2024 at 08:32, Samuel Holland wrote:
> >>> On 2024-08-15 8:16 AM, Thomas Gleixner wrote:
> >>>> Yes. So the riscv timer is not working on this thing or it stops
> >>>> somehow.
> >>>
> >>> That's correct. With the (firmware) devicetree that Emil is using, th=
e OpenSBI
> >>> firmware does not have a timer device, so it does not expose the (opt=
ional[1])
> >>> SBI time extension, and sbi_set_timer() does nothing.
> >>
> >> Sigh. Does RISCV really have to repeat all mistakes which have been ma=
de
> >> by x86, ARM and others before? It's known for decades that the kernel
> >> relies on a working timer...
> >
> > My apologies for the delay in finding a fix for this issue.
> >
> > Almost all RISC-V platforms (except this one) have SBI Timer always
> > available and Linux uses a better timer or Sstc extension whenever
> > it is available.
>
> So this is the immediate solution: add the CLINT to the firmware devicetr=
ee so
> that the SBI time extension works, and Linux will boot without any code c=
hanges,
> albeit with a higher-overhead clockevent device.

But this will mean that you can't update your kernel to v6.9 or newer witho=
ut
reflashing OpenSBI and u-boot. That's still a regression right?

/Emil

