Return-Path: <linux-kernel+bounces-533145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CED39A4561E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8876167F59
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0E1269AEA;
	Wed, 26 Feb 2025 06:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXK4vy1L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A545028C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553158; cv=none; b=ZW+15JAa8/hVdWnAMdInwG0dIEVyvEO0ARh90GB59fRGMeft2H8sGPdZg9Zob8H/RfX0SMoTUojPrReQgbOXaoY1Q5+89VJ3kkK4Z1NOGv63TLbWN1jeItuTHeKt9/mCmaNmWSS/WL3dSlzxG9IIi3M9X3iMaCD3Q7c8zHJNjVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553158; c=relaxed/simple;
	bh=i9Fh231eCe1o+vaJqKd1MErsCQbbRl1mPJHwK4j7QBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kw/D2ojVl+Lm/J3xWRdOVZ9u7VdTeQSEeNHaIaTBdSXcFVMeQy2PBNX+a33m4ddq6/KjpxgW+T3FKc/ivVHqZT2o2vI9knhzQW77aDqXnCdlmjbIztAeP/P0+cJunVX9DrHI6AW0B9hyZFcNQn9SQ/IH5AP0M37YxQiySs8iV+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXK4vy1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E30C4CEE7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740553158;
	bh=i9Fh231eCe1o+vaJqKd1MErsCQbbRl1mPJHwK4j7QBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AXK4vy1LwYhBChoXfW23LDo4vF6/2ffz0uzQ/kP5L2sRLeULr7HSQqOHtA8zg3icH
	 ftlH3piK+uW5c20avYuc5dv7ETk6FhvEf2Xr9mA0uc4BdWAJmwJKpI92nn0Jd6/S0u
	 P2IOYyy/rT+yxbkrmnggjaTodMqGsDO4qstIb9pJNnE0d4lQ/nzUHCtikqp9UYduJk
	 xYepJ/49nOZf0VwbZY9t2WMxWH/Lj+qEX77xGGRifP57trg7p/PnyvVmxP/Zo0E/aa
	 f+JXYZRcSpElJe/Kcj8PPtUGLh09OxNJ5Ip/ja4jJbIHdhTJGUuZ2G33fSQAh6JJic
	 kykcDlHRfiqGQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3061513d353so68062491fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:59:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaIUqvYnHLB8MteY+yCb2xUQUNV7zZ0aPdYhA8hOxXkH05hu8bIA4EUjbwyEH7eP1j0iEGNOaxoW9XMXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdC2LTNSQ4DlaBuF3R8LubLGOP7J+RsS22zViHm6DJKrlyjP1Z
	WGeoPInJfN/OyAvaFakGHAJSMoNyztyyWSGit4o8vXPluShkjL1t1S9+umZ28Hnxxye6WwKT7lp
	55CMQCODt1mq0t+XYismlLhV6hpo=
X-Google-Smtp-Source: AGHT+IGJUHQ0oCfCacezzvAX7nE8+L56RS5OfdIe8o1rSXaBLume4oTSoD0StSwo7SIgHIipD4oFTbz/3EcuVlFmdaw=
X-Received: by 2002:a2e:9ac6:0:b0:308:e9ae:b5a1 with SMTP id
 38308e7fff4ca-30a5b171680mr71421791fa.2.1740553156558; Tue, 25 Feb 2025
 22:59:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225114638.2038006-1-ryan.roberts@arm.com>
 <CAMj1kXHNO+iB4vNFz-4tR_9CPzv96hn+RW=eqyZXMGy_AySDpw@mail.gmail.com> <20250226001047.GA24197@willie-the-truck>
In-Reply-To: <20250226001047.GA24197@willie-the-truck>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 26 Feb 2025 07:59:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXH=tPuM+irCsKgycUTbts8h9vD4m3tEtw51YFzWafdSUA@mail.gmail.com>
X-Gm-Features: AWEUYZl2QSSVv7QzbSm03vo1Ancy8Ooa7VLWsuo79PHpgXlIEoyJxiWGc6pBfF4
Message-ID: <CAMj1kXH=tPuM+irCsKgycUTbts8h9vD4m3tEtw51YFzWafdSUA@mail.gmail.com>
Subject: Re: [PATCH v1] arm64/mm: Fix Boot panic on Ampere Altra
To: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Luiz Capitulino <luizcap@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 01:10, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Feb 25, 2025 at 07:05:35PM +0100, Ard Biesheuvel wrote:
> > Apologies for the breakage, and thanks for the fix.
> >
> > I have to admit that I was a bit overzealous here: there is no point
> > yet in using the sanitised value, given that we don't actually
> > override the PA range in the first place. This is something I've
> > prototyped for Android use, so that linear map randomization can be
> > force enabled on CPUs with a wide PArange, but right now, mainline
> > does not have that capability, and so I'd be inclined to just revert
> > the hunk that introduces the call to read_sanitised_ftr_reg() into
> > arm64_memblock_init(), especially given the fact that commit
> > 62cffa496aac was tagged for stable, and was already pulled into 6.13
> > and 6.12
> >
> > In any case, it would be good if we could get a fix into Linus's tree asap
>
> Makes sense. So the patch below?
>

Yes, but please don't forget the cc:stable

To the patch below,

Acked-by: Ard Biesheuvel <ardb@kernel.org>


> --->8
>
> From b76ddd40dd6fe350727a4b2ec50709fd919d8408 Mon Sep 17 00:00:00 2001
> From: Ryan Roberts <ryan.roberts@arm.com>
> Date: Tue, 25 Feb 2025 11:46:36 +0000
> Subject: [PATCH] arm64/mm: Fix Boot panic on Ampere Altra
>
> When the range of present physical memory is sufficiently small enough
> and the reserved address space for the linear map is sufficiently large
> enough, The linear map base address is randomized in
> arm64_memblock_init().
>
> Prior to commit 62cffa496aac ("arm64/mm: Override PARange for !LPA2 and
> use it consistently"), we decided if the sizes were suitable with the
> help of the raw mmfr0.parange. But the commit changed this to use the
> sanitized version instead. But the function runs before the register has
> been sanitized so this returns 0, interpreted as a parange of 32 bits.
> Some fun wrapping occurs and the logic concludes that there is enough
> room to randomize the linear map base address, when really there isn't.
> So the top of the linear map ends up outside the reserved address space.
>
> Since the PA range cannot be overridden in the first place, restore the
> mmfr0 reading logic to its state prior to 62cffa496aac, where the raw
> register value is used.
>
> Reported-by: Luiz Capitulino <luizcap@redhat.com>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Closes: https://lore.kernel.org/all/a3d9acbe-07c2-43b6-9ba9-a7585f770e83@redhat.com/
> Fixes: 62cffa496aac ("arm64/mm: Override PARange for !LPA2 and use it consistently")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Link: https://lore.kernel.org/r/20250225114638.2038006-1-ryan.roberts@arm.com
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/mm/init.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9c0b8d9558fc..ccdef53872a0 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -279,12 +279,7 @@ void __init arm64_memblock_init(void)
>
>         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>                 extern u16 memstart_offset_seed;
> -
> -               /*
> -                * Use the sanitised version of id_aa64mmfr0_el1 so that linear
> -                * map randomization can be enabled by shrinking the IPA space.
> -                */
> -               u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
> +               u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
>                 int parange = cpuid_feature_extract_unsigned_field(
>                                         mmfr0, ID_AA64MMFR0_EL1_PARANGE_SHIFT);
>                 s64 range = linear_region_size -
> --
> 2.48.1.658.g4767266eb4-goog
>

