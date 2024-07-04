Return-Path: <linux-kernel+bounces-240938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674C49274D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8DA1C21D9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEFB1AC24E;
	Thu,  4 Jul 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E6OuKYMn"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FD617556E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092028; cv=none; b=QTefuIa37sKLhGFZr7SS7fl7JDjmVtPYzK90MaCPxqnrmIWOIlmI3PrBfIdxbk1eDOvJAz0frvAdhtPtSCB/z22rGqmJiUUoIsNk2Ps4dFHyHrI0UnSwMmfbStmNYmYBntyqZw9eYuU2vC5NOFTGnOFXUA387Rk8rJhmej53I58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092028; c=relaxed/simple;
	bh=feVOajcRAOowu9jr1WFh3drlTvkosgv6L/IHLhbPFpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VER+UAWle4DOgIALL8vU7HzAWr6ZebRpLi4ZejQLVP/dS3Qr2TAglIprhBnjjuP3oLkQTBwk76wDB5sK1JGPSuF4pbkqfhUFv4o8g1wwifsaVsUESd5Oc7yAV8ZRSjVU/WsWOANZx22ILyf3y4lVI7OQQ4u3NhqdoyYE/L0FtZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E6OuKYMn; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so6427591fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720092023; x=1720696823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbkftaEmTJGCSX4dzrEq26pkqSap1560H03B71GhYKI=;
        b=E6OuKYMnrkiEUXHbWQZ3pbCF68a66uffsgcXwQ97ZWECWcIxinBV2ux8HHzbTCeWOV
         T1ppUP2mG08aQwRvceRlIu6PNvBJ5sV81QfQC6WrSFdsxEOyWteAIIe8z+8sigiho99Y
         P4YGms9Mx0jXuN/lY1AOcBD3plU/jr2tiUCzGF/Pr3ubgcdPfjmh4j/jZHnJzCZgIrGV
         Okn19xUlQfFVlAmemRgpf5BmZGOGWIxLPMPoyeAOKsiykVbjW+2le85nbiLqTsmZuVSC
         zR0aRiF1SNtzBttywco1opA+elV+Dk8KO5kC9OqbGANKUWHXlcCIE/MRaf2Kx9LYxwb4
         hRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720092023; x=1720696823;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbkftaEmTJGCSX4dzrEq26pkqSap1560H03B71GhYKI=;
        b=G/2d+ygUS7Vtikcker3XwmCkhkcgnNfw1iBxFr1UaSGcbBdIqjhQ8CMT7jeBMjzvwM
         cfx27KyZEvET+TeOZerNZUsbEaHgPirOKjiMwu6qxrKSbvjTZMEwpHhqWNTjO9ux+wIU
         ZSNDwbuBHeJNjNrk48qWmBhSlMKn4IwqB8aTOvNCpcczG2xC+NwAQ2FgFsXSd+MezT3B
         vYx7x7l91AcUs5VCSunmRB6UVjtZa2duQaf9SOIi95A74x1EoeyfA0fXJ5iZropNANMp
         DDLHXhB8YXMActQJPAoqa0+B+gRQhIa+vboEFLwYclxSOl6iQRmwECf7Fn3IZ8QuZ/hL
         6WJg==
X-Forwarded-Encrypted: i=1; AJvYcCXFvWNt2t0/yes/u5V6N4/RAtR8J+elRTSs+ltHH/RlCMV8SsKre1lxP8sGb/DmIat1/HlABrKfBJkxgSLqg25+C2gaKGJGUu+ItJyo
X-Gm-Message-State: AOJu0YyWk6my7ErTj6Tiq7Qdj9jN+Djx3Hb8wflyeungBtAINEZLUQY2
	TAPfi61ldikKsecSssNHSgB31uvkjPvJCw28X4RKd46/9iZ9FEpwYz8GS/wvT9A=
X-Google-Smtp-Source: AGHT+IED78L/WkqhhPcy783ISXimf8NOIsrjkke0O9Iu1HbG88dAHumaCNTXbQ5+/mtmlxL8joTLfw==
X-Received: by 2002:a2e:2c0b:0:b0:2ee:8749:d4a1 with SMTP id 38308e7fff4ca-2ee8ed66d8amr9735801fa.10.1720092023008;
        Thu, 04 Jul 2024 04:20:23 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:757f:bfc7:3301:6664:5531? ([2a10:bac0:b000:757f:bfc7:3301:6664:5531])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a25193csm20704205e9.34.2024.07.04.04.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jul 2024 04:20:22 -0700 (PDT)
Message-ID: <48e5f704-c683-43ca-bb5e-0fb691eab4d5@suse.com>
Date: Thu, 4 Jul 2024 14:20:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] x86/fred: Parse cmdline param "fred=" in
 cpu_parse_early_param()
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
 andrew.cooper3@citrix.com, houwenlong.hwl@antgroup.com
References: <20240703085426.274801-1-xin@zytor.com>
 <20240703085426.274801-2-xin@zytor.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240703085426.274801-2-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3.07.24 г. 11:54 ч., Xin Li (Intel) wrote:
> Depending on whether FRED will be used, sysvec_install() installs
> a system interrupt handler into FRED system vector dispatch table
> or IDT.  However FRED can be disabled later in trap_init(), after
> sysvec_install() is called.  E.g., the HYPERVISOR_CALLBACK_VECTOR
> handler is registered with sysvec_install() in kvm_guest_init(),
> which is called in setup_arch() but way before trap_init().  IOW,
> there is a gap between FRED is available and available but disabled.
> As a result, when FRED is available but disabled, its IDT handler
> is not installed thus spurious_interrupt() will be invoked.
> 
> Fix it by parsing cmdline param "fred=" in cpu_parse_early_param()
> to minimize the gap between FRED is available and available but
> disabled.
> 
> Fixes: 3810da12710a ("x86/fred: Add a fred= cmdline param")
> Reported-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> ---
>   arch/x86/kernel/cpu/common.c |  5 +++++
>   arch/x86/kernel/traps.c      | 26 --------------------------
>   2 files changed, 5 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index d4e539d4e158..9a904fe7c829 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1510,6 +1510,11 @@ static void __init cpu_parse_early_param(void)
>   	if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
>   		setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
>   
> +	/* Minimize the gap between FRED is available and available but disabled. */
> +	arglen = cmdline_find_option(boot_command_line, "fred", arg, sizeof(arg));
> +	if (arglen != strlen("on") || strcmp(arg, "on"))


Just make this check :

ret = cmdline_find_option(...)
if (ret < 0 || strcmp()))

A lot more straightforward

> +		setup_clear_cpu_cap(X86_FEATURE_FRED);
> +
>   	arglen = cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof(arg));
>   	if (arglen <= 0)
>   		return;
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 4fa0b17e5043..6afb41e6cbbb 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -1402,34 +1402,8 @@ DEFINE_IDTENTRY_SW(iret_error)
>   }
>   #endif
>   
> -/* Do not enable FRED by default yet. */
> -static bool enable_fred __ro_after_init = false;
> -
> -#ifdef CONFIG_X86_FRED
> -static int __init fred_setup(char *str)
> -{
> -	if (!str)
> -		return -EINVAL;
> -
> -	if (!cpu_feature_enabled(X86_FEATURE_FRED))
> -		return 0;
> -
> -	if (!strcmp(str, "on"))
> -		enable_fred = true;
> -	else if (!strcmp(str, "off"))
> -		enable_fred = false;
> -	else
> -		pr_warn("invalid FRED option: 'fred=%s'\n", str);
> -	return 0;
> -}
> -early_param("fred", fred_setup);
> -#endif
> -
>   void __init trap_init(void)
>   {
> -	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred)
> -		setup_clear_cpu_cap(X86_FEATURE_FRED);
> -
>   	/* Init cpu_entry_area before IST entries are set up */
>   	setup_cpu_entry_areas();
>   

