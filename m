Return-Path: <linux-kernel+bounces-272602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AF7945EA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25BA2836FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2611E3CDC;
	Fri,  2 Aug 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NDDxfC6J"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBAA1DAC4F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722605165; cv=none; b=QlamKztTi5sFhxyVI6lXYJYk6UngE5QM3BGe+L4nZrXcKIv+hMl/cy1B5kXWHfxLjdO+RLF0TpckmfuTgNM+bEWcrHiyN2frPR99Ks7RKqsr7HdNrSAPNfnr4qozGit3/vzTTO3HApIEZRWFbN+IvyjWRv1L43JeZptI64cpY7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722605165; c=relaxed/simple;
	bh=kroz5WSydeC9uW+TSd0KZzKu56k3VIezekzeKBf9WpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gybJkBY4HV5I0KRBVRpJIvyARRO5TRh/7QxSEhJpTU9RCI9EOq63VNLR3+3yQWidWP7YFG2ZiyZQyiOCV11PV/1gGjIoc+/GWlpGSzUiHfuafltMADqM0eLXPdA71zA0NGP8EHJxIaXOZ4YvrQzZWOeX+pGdivD0uEUhM81nExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NDDxfC6J; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f040733086so93670551fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722605159; x=1723209959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJhmQirVizUqOCgmsekY21nCq2G6MWUHMhqZQdlEfZc=;
        b=NDDxfC6JZLXsKghuQA2X0CNXD9k0LKzfazgBfHEkmERZOp4nKGEOAKIQQ68xTa2FOp
         6BK63hTHI/+jzsvOYJyTdlxaQ1T+m796Y6ZbXOZ2JKkJ8585BbSbnaIL+2F1Z14UYqAQ
         zP4nKvxPJg1iSqUH895cmYNLIoukshYWFoChtatBdHoild7PRq7iRI5PynWgt3IA8ZyB
         ia8DKCo9zx86ysrSuECePR93pq5sYfnQOIrKpN1NRTR2fmDPe7JNYK3TATZNW+7MEE9/
         fLvyJ4pbuw/xTs2rgxHHerg7EHNcy9Z+/YxJDj69PpT26HNdf4Fzl/Qb2rQ2ZL5q4IYL
         OZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722605159; x=1723209959;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJhmQirVizUqOCgmsekY21nCq2G6MWUHMhqZQdlEfZc=;
        b=gb9MDFqqo9WNSndaoFTjy3raDpV4tJEndqlbh+8DOdl/Tpxe2NnGbQVSnb71oxZV4s
         +9jVeVVzTls9k+GSLovtJW6g5/kF0DqtGSELz/24rlcDn+yd+rY/PLpaAQlU5kohSmxs
         8b3IvdhZJc29q2lrMdgnZPIvJYhiUUm2es+N/HlV1D8jWKNixLQTYBKEKRxEozOpX+a5
         y24AqsayGmUf6gYUeOtAjavrE3pOZmMvvDDVEZ/RxvOr+mN1Xv5kFlwn1Z1PaqmJoyMe
         2XZdtmhBr1IGpbUpsqzVZm4PUAtLBWGwW/a8ni0Dp3bW/YxctR69uwvb6PpGIT1mPyW5
         cepw==
X-Forwarded-Encrypted: i=1; AJvYcCUW11+vun32vubvrUDW1LB6Jqp7cgHxtc7tX4pMdMgenTlHCc/LaxNkiubnQS33AMLnsPZLzT0182yMZGmm+owURWDu/GJbL2XCox0b
X-Gm-Message-State: AOJu0Yy1tcFR+mMpFXZV3n8SuamJLZg8IRy5nJv1pS8h4LevhzRHoNsZ
	JGIJY/M6FGPEt54j7/NKiQUuZueRgpOWdB6gZrt+U2i/f7RmGtZK98OTJTfK5Bg=
X-Google-Smtp-Source: AGHT+IHBvsYwfwOgou5WXpOcO14cjQZULKYPfbBjoNyalongwp4wd13+FAnvLOiLZkJZEUFWOqqo9w==
X-Received: by 2002:a2e:88d9:0:b0:2ef:2617:8952 with SMTP id 38308e7fff4ca-2f15aaa8480mr22670781fa.18.1722605159128;
        Fri, 02 Aug 2024 06:25:59 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.143.186])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b92b970sm1125275a12.72.2024.08.02.06.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 06:25:58 -0700 (PDT)
Message-ID: <824e522d-c9e2-4e24-8ce6-aca6573db06a@suse.com>
Date: Fri, 2 Aug 2024 16:25:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] x86/cpu: fix unbootable VMs by inlining memcmp in
 hypervisor_cpuid_base
To: Alexey Dobriyan <adobriyan@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <a9f505a6-fd31-4cfa-a193-d21638bb14f1@p183>
 <304592cf-e4a7-4ba1-baa6-4941c60f0e3c@p183>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <304592cf-e4a7-4ba1-baa6-4941c60f0e3c@p183>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2.08.24 г. 11:50 ч., Alexey Dobriyan wrote:
> If this memcmp() is not inlined then PVH early boot code can call
> into KASAN-instrumented memcmp() which results in unbootable VMs:
> 
> 	pvh_start_xen
> 	xen_prepare_pvh
> 	xen_cpuid_base
> 	hypervisor_cpuid_base
> 	memcmp
> 
> Ubuntu's gcc version 11.4.0 (Ubuntu 11.4.0-1ubuntu1~22.04) inlines
> memcmp with patch and the bug is partially fixed.
> 
> Leave FIXME just in case someone cares enough to compare 3 pairs of
> integers like 3 pairs of integers.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>   arch/x86/include/asm/cpuid.h | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
> index 6b122a31da06..3eca7824430e 100644
> --- a/arch/x86/include/asm/cpuid.h
> +++ b/arch/x86/include/asm/cpuid.h
> @@ -196,7 +196,20 @@ static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
>   	for_each_possible_hypervisor_cpuid_base(base) {
>   		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
>   
> -		if (!memcmp(sig, signature, 12) &&
> +		/*
> +		 * FIXME rewrite cpuid comparators to accept uint32_t[3].
> +		 *
> +		 * This memcmp()
> +		 * a) is called from PVH early boot code
> +		 *    before instrumentation is set up,
> +		 * b) may be compiled to "call memcmp" (not inlined),
> +		 * c) memcmp() itself may be instrumented.
> +		 *
> +		 * Any combination of 2 is fine, but all 3 aren't.
> +		 *
> +		 * Force inline this function call.
> +		 */
> +		if (!__builtin_memcmp(sig, signature, 12) &&

Instead of putting this giant FIXME, why not simply do the comparison as 
ints, i.e ((uint32_t)&sig[0]) == signature1 && ((uitn32_t)&sig[4]) == 
signature2 && ((uint32_t)&sig[8] == signature_3  and be done with it?

>   		    (leaves == 0 || ((eax - base) >= leaves)))
>   			return base;
>   	}
> 

