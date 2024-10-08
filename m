Return-Path: <linux-kernel+bounces-354807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA849942CE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF811F2615A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D021E1A0F;
	Tue,  8 Oct 2024 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LpcN1kO/"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625121E1A05
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376380; cv=none; b=Ge4ljVKRy9xE6K54ZuEb/moA3sMFnXgpnat9IcGSf71PaHtQjlBBCyTctk//G923bkWUOmoSXrCnMfY5hezLi0ATOfpURLc3wMdnc2btxXil1hy6bvhpBIXIaAuOYEPstcaWE7RhMrQxzkvYY4pTG+mJXdiovi3xMChkCWvLvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376380; c=relaxed/simple;
	bh=3voXXt2gD2XtsH9MBzvPl6fv3tQNOOo2AOsPsQobxHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixoyi6YiOavyrmHNai9A1KE/dgxQHMNcYWkv9mHRIew6YD3zg1DYpuHdk8Bj5IrhHhwT10ZXvjlDvwkbY6nMtksmSHX+tmq9hUSe6Sewl9cYJuHZtzXi3Em3axKvt4/i+Ne1VeYfc/PmPPLzx0lf8QiTwO/U2Izfw/BAoBjWdkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LpcN1kO/; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c88c9e45c2so11021310a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 01:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728376377; x=1728981177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EU2CUv17rz6EPvRrdgPot+6rUBOWMaurqQUtQY/gK/o=;
        b=LpcN1kO/Kz9Hg6SFd1dZF1IXDf6F+jY4LZsDEefYdrk554Sj+TN4m2ELp4IRBXo7+V
         PP/7RJY8Zc/ID/OtKSRQoohOEUz4WONDEMpeo9id7+9lfjbyg3lpjSMiYhb35wxnxNiV
         c0lBjkaYtLsvz2Dw+mUfQwLLVfUE962IZfwlCA/Zl7Jaw4t7ALQ4zYdkQ/+Y3ocebxVO
         ke0SmAIfQzruSQPmwr1ok2Ah+/ufjvZpt6iJAZyT2fON6old/6CvaJJYpizu6sAGmk8a
         e8nR4Zw5mBSRxhFCaPWATRXaCz4Mc+em8LlVSeEQW+zvsgVDsvhrEKrtty5Tm3Mh7FCT
         74Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728376377; x=1728981177;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EU2CUv17rz6EPvRrdgPot+6rUBOWMaurqQUtQY/gK/o=;
        b=MgqV4A2c2WUThQ+YKh7Vefl4CzOlZQQFv00Vk9vRtLKOecypCpm3tLBDwQFCSoo6Y7
         ZZMBfm5MmL0cuGC6D140eZU6R6a4ru22cULbEfsjo4YERsg3EPqD8Q1VXM0RLotLoXgt
         wxQz5XaivjA30jUSUT2X4Y/Qomtvl3+ALKTCWSn3hrP0n+6sLGBPmpWz8JVqkni3x/ES
         adDF64fTPvdSRg1n6soSY0YlWFCYQNhw7QpSsCzlxOBrh/Ue5VeqiFsguRZhqvCB5vHq
         Tx7AIIx8yEQ9qT7ePTF2Cu968WbNdJk419zJ4OT6yz1ao+AvWD2MCrwczTldV8qawxcB
         9FRw==
X-Gm-Message-State: AOJu0YwFFT90Zu71VCN9K4bEz5JZk9WfhecyWzoipgWXxposcGM8vFpS
	6pcX5Ef+lajydhWjTNQqYmMHIRM5j0KvHlXMNyz90txSG9YUEmiVBwGkPiknPsA=
X-Google-Smtp-Source: AGHT+IHIekOXI0A6JZke/4JBsekTsL4ByveBMyVXKXX6fxp3LT7/Q3Xb8fYhqEJsi/3sdhh4piYovg==
X-Received: by 2002:a17:907:7d8a:b0:a8d:3fb6:33df with SMTP id a640c23a62f3a-a99678aeeeemr264124366b.8.1728376376634;
        Tue, 08 Oct 2024 01:32:56 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7465:5d50:9d67:2279:9c84? ([2a10:bac0:b000:7465:5d50:9d67:2279:9c84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994b0fd6bfsm320808466b.200.2024.10.08.01.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 01:32:56 -0700 (PDT)
Message-ID: <bb0ad741-6474-4668-a895-2554cdcb8b33@suse.com>
Date: Tue, 8 Oct 2024 11:32:54 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/34] x86/bugs: Restructure retbleed mitigation
To: David Kaplan <david.kaplan@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
References: <20240912190857.235849-1-david.kaplan@amd.com>
 <20240912190857.235849-12-david.kaplan@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240912190857.235849-12-david.kaplan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12.09.24 г. 22:08 ч., David Kaplan wrote:
> Restructure retbleed mitigation to use select/update/apply functions to
> create consistent vulnerability handling.  The retbleed_update_mitigation()
> simplifies the dependency between spectre_v2 and retbleed.
> 
> The command line options now directly select a preferred mitigation
> which simplifies the logic.
> 
> Signed-off-by: David Kaplan <david.kaplan@amd.com>
> ---
>   arch/x86/kernel/cpu/bugs.c | 168 ++++++++++++++++---------------------
>   1 file changed, 73 insertions(+), 95 deletions(-)
> 

<snip>

>   static void __init retbleed_select_mitigation(void)
>   {
> -	bool mitigate_smt = false;
> -
>   	if (!boot_cpu_has_bug(X86_BUG_RETBLEED) || cpu_mitigations_off())
>   		return;
>   
> -	switch (retbleed_cmd) {
> -	case RETBLEED_CMD_OFF:
> -		return;
> -
> -	case RETBLEED_CMD_UNRET:
> -		if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY)) {
> -			retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
> -		} else {
> +	switch (retbleed_mitigation) {
> +	case RETBLEED_MITIGATION_UNRET:
> +		if (!IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY)) {
> +			retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
>   			pr_err("WARNING: kernel not compiled with MITIGATION_UNRET_ENTRY.\n");
> -			goto do_cmd_auto;
>   		}
>   		break;
> -
> -	case RETBLEED_CMD_IBPB:
> -		if (!boot_cpu_has(X86_FEATURE_IBPB)) {
> -			pr_err("WARNING: CPU does not support IBPB.\n");
> -			goto do_cmd_auto;
> -		} else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
> -			retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
> -		} else {
> -			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
> -			goto do_cmd_auto;
> +	case RETBLEED_MITIGATION_IBPB:
> +		if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {

This check is redundant, if this leg of the switch is executed it's 
because retbleed_mitigation is already RETBLEED_MITIGATIOB_IBPB.

> +			if (!boot_cpu_has(X86_FEATURE_IBPB)) {
> +				pr_err("WARNING: CPU does not support IBPB.\n");
> +				retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
> +			} else if (!IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
> +				pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
> +				retbleed_mitigation = RETBLEED_MITIGATION_AUTO;
> +			}
>   		}
>   		break;
> -

<snip>

