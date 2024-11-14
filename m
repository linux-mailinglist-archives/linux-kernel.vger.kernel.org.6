Return-Path: <linux-kernel+bounces-409242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 041589C896C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF3E1F2396E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BCD1F8F15;
	Thu, 14 Nov 2024 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="kOP9N2oa"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F981779B8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585827; cv=none; b=QTS/tUQymC2mNL/lr3aG18xrjPbmgYHTlNNtroxFkWaK0802KnFiyXLRHQazFOhcAnTEKaOJe1dx0s8e290XEclcwjgfHp8NT1fK5a4FLX4QsNBEdTWNU/00SW/rdExpoZg8inIMn9j5M111ySzmqzu88PUC1/gLYpF7jdxoGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585827; c=relaxed/simple;
	bh=bsAesQ8wNElCInNlecxx+AAobkX9ILoSk62RfFa4/f0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTBeC1UCY/IUwJ82n0Io9Ac3z3/qP4XBFSBbD/HAAjqriYMs/It/K5QctXRGK9JgWBAoJIriqkaf791C9c4H9BOjc0JthXlWPk0wCWpDzuV6uvoPuHCssPBnrwUTpk92a4PYsKxCvT9DiAmAgS/ELOJta01zWyMjpKVFnGarh5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=kOP9N2oa; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so706746a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1731585824; x=1732190624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vXJ2wWAZ4c6Uxc9zlOJWWR+ECsue7ZkeXqPGbeTDycE=;
        b=kOP9N2oa+hne+799i0cQwtBG5Xlz8AHRFspyGaw9u2JmG5sZ9EprDPQZtH1p1v2F5D
         yQThGfruBJ4dWt9C4PVs7kVopkIx381FfVhMXs7SQmTTIK7Zxwau96UQjZK8fIoxL/YU
         cz7Je5q2bQlDjgN9yj38j9g5xnLJPxuzAW6Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731585824; x=1732190624;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXJ2wWAZ4c6Uxc9zlOJWWR+ECsue7ZkeXqPGbeTDycE=;
        b=m3sWG7doLfABSdSBIuXfxawh31vTe/Ega7OlkZh6f26DxyNpnZ+cqRq8DsO8JIAiwX
         r0dgSsDPXBBaS4kVIcnO2ePvTr/wXlqak4Ti/U4j8W/yRbvl1DcdvOHJkIh6edkMX4uL
         Ons7b13Jk22FzcNofYgOAHG4CuQrve5VlFrTorLKxcKyNkhYx1buNMGv4EWcMTWmzUwa
         bVcHpcX7U71pmlZTIRXAUnG2Cggq+SmzoImBlkawgrsDeg+KewwqWr19aiCCDBNIZLQd
         at+eaNXy6PdfCxF1tXqlKFHmCpb9NimtA6uyovTsQa4XeGkuwJjHX3uwyLncxU4yvOkF
         OUjA==
X-Gm-Message-State: AOJu0YypFvd/PeNT5GyCBXFvYF1L6ubfuwdZCWmfvmXoBjpkp/Nlmb80
	xTWCud+cKH3JiQRoof2TqgsH16XiPke/HUqM/5Rv9ukhNM2LeRYR4uiIb/4H2wA=
X-Google-Smtp-Source: AGHT+IEQluE0+496a6/D7zeXUpGcn+L2k+ffV6vk7WXfAsEN7ZHKOlsR/55qCwZPC0+09wpOX8jWhw==
X-Received: by 2002:a05:6402:35ca:b0:5cf:44b3:36c with SMTP id 4fb4d7f45d1cf-5cf77e90c45mr1449355a12.1.1731585824040;
        Thu, 14 Nov 2024 04:03:44 -0800 (PST)
Received: from [10.125.226.166] ([185.25.67.249])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79c0ac9asm520085a12.54.2024.11.14.04.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 04:03:43 -0800 (PST)
Message-ID: <3f6a84bd-af4a-4ffa-8205-25b2c9084893@citrix.com>
Date: Thu, 14 Nov 2024 12:03:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: x86/amd late microcode thread loading slows down boot
To: Borislav Petkov <bp@alien8.de>,
 Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
References: <ZyulbYuvrkshfsd2@antipodes>
 <6449aa6c-43b1-40eb-ab54-48803481d11b@citrix.com>
 <20241107153036.GCZyzdHEwm9-LPQOzY@fat_crate.local>
 <Zy0p5DT0SOWsCDn7@antipodes>
 <20241114095639.GDZzXJV1EDJlMqv24c@fat_crate.local>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20241114095639.GDZzXJV1EDJlMqv24c@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/11/2024 9:56 am, Borislav Petkov wrote:
> On Thu, Nov 07, 2024 at 09:58:12PM +0100, Thomas De Schampheleire wrote:
>> Boris, perhaps you can propose a more fine-tuned flushing? I'd be happy to try
>> that.
> Let's see if that does the deal too.
>
> Thx.
>
> ---
> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
> index 580636cdc257..4d3c9d00d6b6 100644
> --- a/arch/x86/include/asm/tlb.h
> +++ b/arch/x86/include/asm/tlb.h
> @@ -34,4 +34,8 @@ static inline void __tlb_remove_table(void *table)
>  	free_page_and_swap_cache(table);
>  }
>  
> +static inline void invlpg(unsigned long addr)
> +{
> +	asm volatile("invlpg (%0)" ::"r" (addr) : "memory");

"invlpg %0" :: "m" (*(char *)addr) : "memory"

The compiler can usually do a better job than forcing it into a plain
register.

> +}
>  #endif /* _ASM_X86_TLB_H */
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 31a73715d755..6a73f775ce4c 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -34,6 +34,7 @@
>  #include <asm/setup.h>
>  #include <asm/cpu.h>
>  #include <asm/msr.h>
> +#include <asm/tlb.h>
>  
>  #include "internal.h"
>  
> @@ -489,6 +490,9 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
>  
>  	native_wrmsrl(MSR_AMD64_PATCH_LOADER, (u64)(long)&mc->hdr.data_code);
>  
> +	if (x86_family(bsp_cpuid_1_eax) == 0x17)
> +		invlpg((u64)(long)&mc->hdr.data_code);

Ok, so it's Fam17h specific.  That's good to know.  Any formal statement
on the matter from AMD ?

However, these blobs are 3200 bytes long and come with a good chance of
crossing a page boundary.   If you're invlpg'ing, you need to issue a
second one for the final byte of the image too.

~Andrew

