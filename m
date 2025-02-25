Return-Path: <linux-kernel+bounces-532172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF2FA449D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1403BAD79
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD8519CC06;
	Tue, 25 Feb 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP2e35E9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A714198831
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506749; cv=none; b=TjO9pwR0oR9eC0w7M2LpZOJzFrHhCbYBPtG2fAlgwld9dedGJljmzmb0J2aEhZ4ISDc4nlJhCnQ8VewAE9Jooxh8OQeLXAgFNzofDEWM9rowRamDWHykwwpj1JkdRwreQ6LUQILnjCr+K33cECsQGvxVtr2BwOdOdhXMmq/dHwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506749; c=relaxed/simple;
	bh=BRAREsQXttfbBaJFNuuJoLHpW/7Cxotknsm4alcWLf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a40TbkbjPGFAfyBdDTCfM759+MMPIf43092yeDx5Eady54YAW06YLmQ3Lcci49DigGTRQUxxXDEEdAyjU/D07+zZUHI6JtkFK6sOM3pxabCjbOqbccJAcZklMdBotaN1kiMgIFMnrr51FvCf7AEUkPYiF51A1xDpWsH9d5iCdpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP2e35E9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09006C4CEE8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740506749;
	bh=BRAREsQXttfbBaJFNuuJoLHpW/7Cxotknsm4alcWLf8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GP2e35E9YBjxjyPpNNmL7pj3+Xe/9a1GNBx9vEqE124WDvQj843ZzThHRfFSCh+r7
	 r32IRLAbA/2pot06carICQL6Z4+TDRYVw+xiUDOJoyFDsgSXH+/iG19/Up8Fj8bMPD
	 ai5kjgYbgKqgVT7zGvEvwbBz5ooJ6ACPKvsBH7xEI9/xR6LF4VvQt0lvfVzLXSio/N
	 yZVtzBz0S/VQH/Gyvx2Ra2qzsjYW6fCmj26pN48w2hklef5gBFoaenLZWSxEI/ksw0
	 CJD8XfWkFA6SyKazKaYUgkW/enVrNSLbTAUmxI2xfR2T8wZKKUJ6A2kMNUEp/0ARnQ
	 mXm0sxVLNAGBw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3078fb1fa28so46123291fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:05:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWdJnApnWCoZzMWbZ7CM2u+upbwAsKdVoHae1i+ORszbkUeFuZvrdkeRG+FvBrw2+4Ap01ZmLoqpAZcD5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMH5CGl73feIL9gCkwoxl0L14CSpPdxAjtpEiqsKVW5icpumIr
	zpI8nj699Vo7QAKjH7AFdqNM41kjZKP4uWDByMHqyuwc5Vd6rDkridH0NkGpBKhxV9QcAcVOjEF
	LpNsbJge/jUKN/cSLPwCb9J2tBp0=
X-Google-Smtp-Source: AGHT+IG/KcteHG+7CrMPvm+W3JNssD87+CU129hdHkUloxYU+76h0fMOYVd6Z9x/EzKMffybLgg3O8vDCe+HCJs+JnE=
X-Received: by 2002:a05:6512:2256:b0:545:280e:4b7f with SMTP id
 2adb3069b0e04-54839145111mr8485935e87.27.1740506747092; Tue, 25 Feb 2025
 10:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225114638.2038006-1-ryan.roberts@arm.com>
In-Reply-To: <20250225114638.2038006-1-ryan.roberts@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 25 Feb 2025 19:05:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHNO+iB4vNFz-4tR_9CPzv96hn+RW=eqyZXMGy_AySDpw@mail.gmail.com>
X-Gm-Features: AWEUYZm9KwJjXrKlLld_fAKtjjBFnw9EUOBb72VNhsnHv5iLxQagVJUeFUPPgtE
Message-ID: <CAMj1kXHNO+iB4vNFz-4tR_9CPzv96hn+RW=eqyZXMGy_AySDpw@mail.gmail.com>
Subject: Re: [PATCH v1] arm64/mm: Fix Boot panic on Ampere Altra
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Luiz Capitulino <luizcap@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 12:46, Ryan Roberts <ryan.roberts@arm.com> wrote:
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
> Fix this by intoducing a helper, cpu_get_parange() which reads the raw
> parange value and overrides it with any early override (e.g. due to
> arm64.nolva).
>
> Reported-by: Luiz Capitulino <luizcap@redhat.com>
> Closes: https://lore.kernel.org/all/a3d9acbe-07c2-43b6-9ba9-a7585f770e83@redhat.com/
> Fixes: 62cffa496aac ("arm64/mm: Override PARange for !LPA2 and use it consistently")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>
> This applies on top of v6.14-rc4. I'm hoping this can be merged for v6.14 since
> it's fixing a regression introduced in v6.14-rc1.
>
> Luiz, are you able to test this to make sure it's definitely fixing your
> original issue. The symptom I was seeing was slightly different.
>
> I'm going to see if it's possible for read_sanitised_ftr_reg() to warn about use
> before initialization. I'll send a follow up patch for that.
>

Apologies for the breakage, and thanks for the fix.

I have to admit that I was a bit overzealous here: there is no point
yet in using the sanitised value, given that we don't actually
override the PA range in the first place. This is something I've
prototyped for Android use, so that linear map randomization can be
force enabled on CPUs with a wide PArange, but right now, mainline
does not have that capability, and so I'd be inclined to just revert
the hunk that introduces the call to read_sanitised_ftr_reg() into
arm64_memblock_init(), especially given the fact that commit
62cffa496aac was tagged for stable, and was already pulled into 6.13
and 6.12

In any case, it would be good if we could get a fix into Linus's tree asap


>
>  arch/arm64/include/asm/cpufeature.h | 9 +++++++++
>  arch/arm64/mm/init.c                | 8 +-------
>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index e0e4478f5fb5..2335f44b9a4d 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -1066,6 +1066,15 @@ static inline bool cpu_has_lpa2(void)
>  #endif
>  }
>
> +static inline u64 cpu_get_parange(void)
> +{
> +       u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
> +
> +       return arm64_apply_feature_override(mmfr0,
> +                                           ID_AA64MMFR0_EL1_PARANGE_SHIFT, 4,
> +                                           &id_aa64mmfr0_override);
> +}
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9c0b8d9558fc..1b1a61191b9f 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -280,13 +280,7 @@ void __init arm64_memblock_init(void)
>         if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>                 extern u16 memstart_offset_seed;
>
> -               /*
> -                * Use the sanitised version of id_aa64mmfr0_el1 so that linear
> -                * map randomization can be enabled by shrinking the IPA space.
> -                */
> -               u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
> -               int parange = cpuid_feature_extract_unsigned_field(
> -                                       mmfr0, ID_AA64MMFR0_EL1_PARANGE_SHIFT);
> +               int parange = cpu_get_parange();
>                 s64 range = linear_region_size -
>                             BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
>
> --
> 2.43.0
>

