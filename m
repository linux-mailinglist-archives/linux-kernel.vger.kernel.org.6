Return-Path: <linux-kernel+bounces-197752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A55168D6EAB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 09:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617E91F23982
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 07:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EFE1865B;
	Sat,  1 Jun 2024 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bG+5p/3v"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339DD175A5
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717226855; cv=none; b=dqtPLRWRxmfsw3xXuwZgiiwAmAdYH9Je5jRGLED0ce5PMeeQd7M8XCnChbcLeDFs1p501C5zoRKfsyLX8CNAYrd0Sjro6+C85yiIDBJXoMjAvPgjZTN+/NWKFhXj6Ha+02FkB8q7zjQ6ahxirP8Dtl4QyAwYrgoDw8Tavawl/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717226855; c=relaxed/simple;
	bh=PCJyMuyEUt6FOSKpRSAJIF1DJ6gHGxPxtSzQDAWBqFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ga/gDD05MIx2QNEIHto2npx0qstSz4RsShdgs3Pfsl1C5M4GTD3Eo20V3LhJwKG5RTSMhSyJN0lIIbbw8o2VljkWy53ZpxiASAozdZ2M2acGSYm9NJxU+xPmeMcE+xbiIrwuM+z4Nax9DHf+WoMwac7qI5g1EmVFq82jeqLjX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bG+5p/3v; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95a883101so35488721fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 00:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717226850; x=1717831650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hge4VyxWituyIOOJfd321VcyqziYhhPj3o4Ih55xN00=;
        b=bG+5p/3vyb4go8ANYQmZhD5TOLvBKYOZtyna3vgPdFAicvteo9XLLhyqvcVEfExBcD
         B2Hphqk7brJzIaUXkIJkymckLcBMIzxZWmeo7Q3LFFnkrZ5EGNzEczwBkrnWWxpRAOv7
         nIF3kci1SwqPE0lruSFN6mmekFJ1SDeEvoO77rNAyV5aa/d8bzLVOT2av2RqHAXuzH+T
         tAlMETqBrMLWoqwYofytlpbcK8Dt2NAPIaNMrsWsUYlIGJbi3rcCsDXWnqGTSDAeQOFz
         2KiZXj0wTSiQQwoQtQy+PB/BM/QDDxQUwbMwBkxGOBZ/r1N1P2dKpdAI0+fVDy7Mts1n
         20Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717226850; x=1717831650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hge4VyxWituyIOOJfd321VcyqziYhhPj3o4Ih55xN00=;
        b=AEKYScKNZhckrXns7+F5HkErGmiB9TiXzblsMYKQ9rsN+y58bCvNXYtWdwQwPCFApQ
         b5VE6DGwax+3rQlVA9XxsEo43YmdgQZetN6nwRHyB1nODg+6pUEsQZ4Vfvt5OC+VjpMV
         /vYw81TwHPboX/mmb3Qa1PPuYP/k2puUuJMbzkk9YY/uZxJyLRaxOtWDEvR//pmme2GK
         q/mDZ8S+iPO+KCjdgn8+wntpzTZBxtK6u3x9kwuuZouytBBPBJCf9vDD6u7aQGdcQxgg
         CNKDpNJngc8vKjg59CGsdpGx4pIQijOAFJTe0QI2ykf/5XOBIEcL8z+6MamRwNr6pha+
         7QYw==
X-Forwarded-Encrypted: i=1; AJvYcCVBm+HW2WkquHRQdE9UPogBcnSVpe/S8KTD1efDo4K2KJrYuC5shA1LpEvEp2tFQkCt9waeJ0p9PFIBVcUu7y9bVj/EBERlh3ROHzn9
X-Gm-Message-State: AOJu0YyemAb/mFpY9LA9TdzWU7koZ0/OawkDVXjtYw6cUPqdqAP0AfRj
	uwfUjL+OgmYavVtFD0TSOocDUoPM42uTUunJsq0q0NwfHDiApxEn4hujpWGw79k=
X-Google-Smtp-Source: AGHT+IGNPhItELQLzA+6LD+5jArBZ6BmBN1IYQZrt8rOBPmW+ThPAYNFbxwNdlDHZheUKtu5Am8cBg==
X-Received: by 2002:a2e:6a19:0:b0:2df:b7cf:9607 with SMTP id 38308e7fff4ca-2ea95114215mr28008081fa.22.1717226850126;
        Sat, 01 Jun 2024 00:27:30 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:5de0:5af9:fc8:27d7:ba3d? ([2a10:bac0:b000:5de0:5af9:fc8:27d7:ba3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b838b4asm46873915e9.6.2024.06.01.00.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 00:27:29 -0700 (PDT)
Message-ID: <a54db95c-e22a-4e13-ae4b-6a5a67d1c49b@suse.com>
Date: Sat, 1 Jun 2024 10:27:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
To: Kees Cook <kees@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
 <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
 <202405310923.78257B2B3@keescook>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <202405310923.78257B2B3@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 31.05.24 г. 19:28 ч., Kees Cook wrote:
> On Thu, May 30, 2024 at 09:23:36AM -0700, Jeff Johnson wrote:
>> On 5/30/2024 8:42 AM, Nikolay Borisov wrote:
>>>
>>>
>>> On 29.05.24 г. 21:09 ч., Jeff Johnson wrote:
>>>> As discussed in [1] add a prototype for __fortify_panic() to fix the
>>>> 'make W=1 C=1' warning:
>>>>
>>>> arch/x86/boot/compressed/misc.c:535:6: warning: symbol '__fortify_panic' was not declared. Should it be static?
>>>
>>> Actually doesn't it make sense to have this defined under ../string.h ?
>>> Actually given that we don't have any string fortification under the
>>> boot/  why have the fortify _* functions at all ?
>>
>> I'll let Kees answer these questions since I just took guidance from him :)
> 
> Ah-ha, I see what's happening. When not built with
> CONFIG_FORTIFY_SOURCE, fortify-string.h isn't included. But since misc.c
> has the function definition, we get a warning that the function
> declaration was never seen. This is likely the better solution:

fortify-strings.h is used in include/linux/string.h. However all the 
files in the decompressor are using a local copy of string.h and not the 
kernel-wide. When pre-processing misc.c with FORTIFY_SOURCE enabled 
here's the status:

$ grep -i fortify  arch/x86/boot/compressed/misc.i
void __fortify_panic(const u8 reason, size_t avail, size_t size)

It seems the decompressor is not using fortify-string at all because 
it's not using the global string.h ?



> 
> 
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index b70e4a21c15f..3f21a5e218f8 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -532,7 +532,9 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
>   	return output + entry_offset;
>   }
>   
> +#ifdef CONFIG_FORTIFY_SOURCE
>   void __fortify_panic(const u8 reason, size_t avail, size_t size)
>   {
>   	error("detected buffer overflow");
>   }
> +#endif
> 
> 
> Jeff, can you test this? (I still haven't been able to reproduce the
> warning.)
> 

