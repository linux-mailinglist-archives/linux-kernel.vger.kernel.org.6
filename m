Return-Path: <linux-kernel+bounces-355508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D843D995347
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D7F1C25AB9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4221E0492;
	Tue,  8 Oct 2024 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I8HycxXH"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106491DE2A2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400904; cv=none; b=OEbfUWOL5cC55Hw8tCqBeuvvxbgi/FqJgaxV0uEEcDix5KjJdjyGEtH713ItuPze6VdbTGDf3Nd8bosWlOSmiCYW+xO0SSZ7s2hnMT5yCAzF1WnpCTicsBj0wtituMdxinmc3OKqVgso8iJh05BrpQem1FCjnwBFSjQA1sjK8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400904; c=relaxed/simple;
	bh=K66KWMBPjVH0OVESPPQh4cSjFAyaUe0wTtbiApLg6b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBhgXfrA9cOVoB+UsFFepnz/fG4uG2wM9pBYgfLpRw6w3mqRTWEKCF3Q7IvnuR0PTXWlbUEChFkXARLRkcomw1arjDNfHMbH6PsRsKWPqcD5Y4Kz3G840pmRSbYfE8lcM42fgzrqaPFVXQ4pUyoulhc6amT80Zdai19UoJf1uHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I8HycxXH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9950d27234so354601366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728400900; x=1729005700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0uTEik9c7cvBhLJHFarbkDVuyP6KlLAgwEk28t7jrM=;
        b=I8HycxXHI6k7ih5WDMYx3d5St78mftJT9AlTIrMVDuTZcnC14DTEhq6fAKjwTXk7Bo
         mJDoeyGzQv3rGyBJG7xBiVT/DURel6kbhEkkz6J7NHvPC96pUDQpCJxRNIj8vsymxRwo
         bjt5tdznPQeyyItZwfqLU9x3p2kvhHOMR5PZYLRlxfnx1rwO1OULNU8g4bOyJczs2i0K
         aVhpMzc8+B5DMBf4DYBBE33vZuOH10IJh8MDl2glA6Tl52SDXI/xKQKANXx7lkqEsA6Y
         B1xDMRjoAHVvkRDPcR+UBWekTa1/9kMOck8nWV39OWt8E2n+mXIZehTtrSG9BJEcowFk
         fxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400900; x=1729005700;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0uTEik9c7cvBhLJHFarbkDVuyP6KlLAgwEk28t7jrM=;
        b=ie2lOOpM+yR99s7UsWUyo6tpO8qGPv8xO/t9wiQUetCwKAT+RzNdhLMMEimfDm7rjm
         PuTEicDRlCxsLouftDRTu+IsZdLWmtjvAnmhbdu66eRpi7myWQa5TuuvJpOx7d+2B6a7
         hSqQKJnlqZlNwak6nD2gchfD3h+ya/Uvzviz40PYO/GnwYuZ44PezMytYG8epUR2BID2
         A5v4moEH6eQS/qakxlFj0iz6b1GXwAX0e+dB8Wmw+4rtGgAFj74d2sBojv/72ucdIrWe
         dZTJOfwJrtBsZ3mqAIAxUcTFw6dRf3eaSoOZOWR6m4SRPIa4F3QixHr5duA+M6IS4WV0
         wl+w==
X-Gm-Message-State: AOJu0YxS5BFGaOl/zVa4Nwa3M3H9tjJBVUFIHeQ6BempB2j6ORB+DT9T
	qUZoJ9S4CXq8KIXxeYeGtEFikK5NZBVQksFmGCoDerWC2S10A1Xu3xG3M6kpU58=
X-Google-Smtp-Source: AGHT+IFRqVA/8Z27gw2Vqilf+n4GAgGy/z1K2qrcYraGslYE9QToL5TRWspit1cjcofxee/UXf1SWw==
X-Received: by 2002:a17:907:7247:b0:a99:537d:5d10 with SMTP id a640c23a62f3a-a99537d602dmr684124866b.0.1728400900277;
        Tue, 08 Oct 2024 08:21:40 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7465:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7465:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99527e8e15sm296981966b.181.2024.10.08.08.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 08:21:40 -0700 (PDT)
Message-ID: <e5dd614a-9d01-4439-9005-b75d4ad38968@suse.com>
Date: Tue, 8 Oct 2024 18:21:38 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/34] x86/bugs: Restructure ssb mitigation
To: David Kaplan <david.kaplan@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
References: <20240912190857.235849-1-david.kaplan@amd.com>
 <20240912190857.235849-16-david.kaplan@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240912190857.235849-16-david.kaplan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12.09.24 г. 22:08 ч., David Kaplan wrote:
> Restructure ssb to use select/apply functions to create consistent
> vulnerability handling.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>   arch/x86/kernel/cpu/bugs.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 32ebe9e934fe..c996c1521851 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -65,6 +65,7 @@ static void __init spectre_v2_user_select_mitigation(void);
>   static void __init spectre_v2_user_update_mitigation(void);
>   static void __init spectre_v2_user_apply_mitigation(void);
>   static void __init ssb_select_mitigation(void);
> +static void __init ssb_apply_mitigation(void);
>   static void __init l1tf_select_mitigation(void);
>   static void __init mds_select_mitigation(void);
>   static void __init mds_update_mitigation(void);
> @@ -223,6 +224,7 @@ void __init cpu_select_mitigations(void)
>   	spectre_v2_apply_mitigation();
>   	retbleed_apply_mitigation();
>   	spectre_v2_user_apply_mitigation();
> +	ssb_apply_mitigation();
>   	mds_apply_mitigation();
>   	taa_apply_mitigation();
>   	mmio_apply_mitigation();
> @@ -2211,13 +2213,26 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
>   		break;
>   	}
>   
> +	return mode;
> +}
> +
> +static void ssb_select_mitigation(void)
> +{
> +	ssb_mode = __ssb_select_mitigation();
> +
> +	if (boot_cpu_has_bug(X86_BUG_SPEC_STORE_BYPASS))
> +		pr_info("%s\n", ssb_strings[ssb_mode]);
> +}

nit: While at it simply open code __ssb_select_mitigation() here.

<snip>

