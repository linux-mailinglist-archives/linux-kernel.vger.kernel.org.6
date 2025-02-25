Return-Path: <linux-kernel+bounces-531974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B59CEA44762
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 320377A79A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D86714A60A;
	Tue, 25 Feb 2025 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/6jA2tb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7484433A0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502681; cv=none; b=h0Yj5ozfsjGnFaXZbSy4V5zP8+he2IU2FMfqut0taIrX9tmkjuaNyEobliCFb6fRj5mFyye9OZ8I/+27O9Ln+bwstvIvz+Vkr5sbjOaHr9XdHvbxnuWmPXE3zBWyIZnanKbkoD8LigOf1c0KW4gdDGmbcjsnZHDn2FO5HOZIsFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502681; c=relaxed/simple;
	bh=lHadaFwuXKvTS43mgu1FF0IwlTVDAMIf1Oa2F5aRmcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOzggrx30dBD9AZHaLRnpD/uYPSxrWYbVc5eriYkl7uP+Uu8zSGeH+JFVN8gP+D5Fyy9PQEjE1a5i7KpBKp9ewsZUGqqUa4HGKMcHj8A3zY1NZIahx681i3kjaaceAbPhX2iecW2PV2YTN81wIETyg//Z8/SWUb90ag376yd7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/6jA2tb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740502678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OsudyBjgePvtjD6+k96cWTwnxq5OCaJZMhVExCjpMvg=;
	b=h/6jA2tbr/WHxTbOhKmiNBXikY2273kWENA0SOd4pFK0Vhnk2DB9Z9b6Rd9Bi8pCrFgQyP
	/VYHi/XBBAv7hpePJkCOb1drylvm+ywcGX6Q8tN1eWS80fH8+MbOPgieQF7aeEDqCWqBYW
	lU8qbb+vKNUAMMFbQSuH9E4R1MepWMM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-U6xp6m18P0yLcM59f5jKjQ-1; Tue, 25 Feb 2025 11:57:57 -0500
X-MC-Unique: U6xp6m18P0yLcM59f5jKjQ-1
X-Mimecast-MFC-AGG-ID: U6xp6m18P0yLcM59f5jKjQ_1740502677
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3f3a3c8eb5cso1193627b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:57:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502677; x=1741107477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OsudyBjgePvtjD6+k96cWTwnxq5OCaJZMhVExCjpMvg=;
        b=ZHMpEKJDeqlJldG8i5VGapUlttWL/VJbwV7Ov5u8+yENEz+ekJpFAx35oEm55q7qBn
         lTkb4KtoQlw7JIIWAUVV44HSXGshnwzYq1Xo/vq0MZ4ENdLJUzs6pSGW1/1oudPNJ2aC
         0J2uUj/Hqlq5Ygi5WyNtgGNKXZ371N8eY9rhWE9npxoVrSD9mYhut/Xqp8UVGiW5d73i
         KsawLiDbWiZabqjFXZ3C7R7fkKnH0R6KgIxlL3F4t7G0nHlvWgw0DC8BA5T2imjRgGgm
         yG0nEKz4nNEOrrf8lGsQvoP7/TK3FEpm3JL0480OrfWByRgbk3eTZWxQeli0t4e6iJfM
         rOuw==
X-Forwarded-Encrypted: i=1; AJvYcCVElfHdkCtYlnCAPGGRHVTlHiVndaJm6vLzJ6aX5TosX57Hb/JanQhq1xUdRlixvL4KRFSdaQjshMQWrew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7opek0tDbY8h15RQbv+BOFLKjXiJKW7j7fImbClX+htYZ36L+
	aL5E8qk9JUoiMpYbQ1ZK7SA2GiXF4oPrJM4nEs1GdLIaDK9MP/iMS/Sn0iEaQvIipJxyDtYfsDq
	RNOUIJhveuFfTQfVXAz6NGldaeM2nQNBRzxLGrMZf8jLShDOqxD7GwRG0PU2HaQ==
X-Gm-Gg: ASbGncv7WvILlYpfQYksLA4smG9+WHghJu4yLv3j8SjkHIYxePnoblOUtzJjeea91hj
	ZeqhHvDqJG81+OWOib+c4mT2oOQs7gVrqH0QGHAeW2YjT3gP3S0xLUq5svmaNPGiQSS4jPpl5zM
	uKz2X86g7suyNIsKv3UPDTmMotW85NUGTObn0niMo55Qf9mbURvM/d5Fj5m1T9m3NbArbbwKXda
	6cAbs/ek9VELAwDgZ+p43oZlw2pezE2Y14EGoqV7eWzRTTGQHMOqtd2h0NtgJbiE/EBXWZ0OUrX
	+l8GAilvBi0+xg4=
X-Received: by 2002:a05:6808:1903:b0:3f4:210e:c104 with SMTP id 5614622812f47-3f540fc0dd6mr2734002b6e.35.1740502676664;
        Tue, 25 Feb 2025 08:57:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcGW+KRgD0DK/WjhCd4m34e6ZDNGDfc7MLwnR+fmh+Jjwhwc+WuFb1+JUAezBr3u90PAFX5A==
X-Received: by 2002:a05:6808:1903:b0:3f4:210e:c104 with SMTP id 5614622812f47-3f540fc0dd6mr2733987b6e.35.1740502676293;
        Tue, 25 Feb 2025 08:57:56 -0800 (PST)
Received: from [192.168.2.110] ([70.52.22.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f541be03b1sm362758b6e.29.2025.02.25.08.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:57:56 -0800 (PST)
Message-ID: <f53be9d0-524e-4bae-8994-aa2baa1b36d3@redhat.com>
Date: Tue, 25 Feb 2025 11:57:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64/mm: Fix Boot panic on Ampere Altra
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250225114638.2038006-1-ryan.roberts@arm.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20250225114638.2038006-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-25 06:46, Ryan Roberts wrote:
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

Yes, this fixes it for me!

I was able to boot v6.14-rc4 one time without your patch, this is probably
what messed up my bisection. But I booted v6.14-rc4 with this patch
multiple times without an issue. I agree this needs to be in for
v6.14 and huge thanks for jumping in and getting this fixed.

Tested-by: Luiz Capitulino <luizcap@redhat.com>

> 
> I'm going to see if it's possible for read_sanitised_ftr_reg() to warn about use
> before initialization. I'll send a follow up patch for that.
> 
> Thanks,
> Ryan
> 
> 
>   arch/arm64/include/asm/cpufeature.h | 9 +++++++++
>   arch/arm64/mm/init.c                | 8 +-------
>   2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index e0e4478f5fb5..2335f44b9a4d 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -1066,6 +1066,15 @@ static inline bool cpu_has_lpa2(void)
>   #endif
>   }
> 
> +static inline u64 cpu_get_parange(void)
> +{
> +	u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
> +
> +	return arm64_apply_feature_override(mmfr0,
> +					    ID_AA64MMFR0_EL1_PARANGE_SHIFT, 4,
> +					    &id_aa64mmfr0_override);
> +}
> +
>   #endif /* __ASSEMBLY__ */
> 
>   #endif
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 9c0b8d9558fc..1b1a61191b9f 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -280,13 +280,7 @@ void __init arm64_memblock_init(void)
>   	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>   		extern u16 memstart_offset_seed;
> 
> -		/*
> -		 * Use the sanitised version of id_aa64mmfr0_el1 so that linear
> -		 * map randomization can be enabled by shrinking the IPA space.
> -		 */
> -		u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
> -		int parange = cpuid_feature_extract_unsigned_field(
> -					mmfr0, ID_AA64MMFR0_EL1_PARANGE_SHIFT);
> +		int parange = cpu_get_parange();
>   		s64 range = linear_region_size -
>   			    BIT(id_aa64mmfr0_parange_to_phys_shift(parange));
> 
> --
> 2.43.0
> 


