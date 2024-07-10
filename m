Return-Path: <linux-kernel+bounces-248127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE39C92D8A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526F61F25C47
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6B319596F;
	Wed, 10 Jul 2024 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cokYVyHl"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4EE197543
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 18:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720637647; cv=none; b=fd1nOTl818dMSh9lXSE1rBKnIn4x6zcqKBzxx2wuH0sdV7PJpeQnEErEfBsTZbW/fNujtZfLYpMH6Q4NlVwRmKFKeKN/AdiL0WSa/oAwmna45RaHWlr7z0S9wcpnzRbCARrhS2q4GkrwM8/WAI4RXwhmvD5hEwj0qFFp6IJXlWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720637647; c=relaxed/simple;
	bh=2lVJUExPx4oy170EZZ8TlCMjW1DatES4E3tsH6MGB1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnEzvabzPOB4d367CmOAq+B/U0efC7S9tbT0LdacORe6fU32eb2sHvGg8zZFxm4OXm2tCzRRzpGqNXHU9Rc/hmtD6UfrFJrNgpEJSAzr4oy6rYVsW1KMlms3zvWplC9ZUcl+wJGgAze5OvhL3Pm10mKlcQ18UEh/bESYvFnbIOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cokYVyHl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-426526d30aaso711465e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720637641; x=1721242441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qqvy+RCVhIN6GftnBc/LcPvNsXKNazcESkZoy08UdKU=;
        b=cokYVyHl4UXmnaDuZjTw73G9IjMI/oLdIPUeptSnBV/zsp3xx49nCx3aUcZlZY333z
         ghNMwJClzcdyvrS09KFcM3a5HV+B+hjlBN4Y8hnWTynz/PufMa0Hjpr/hfVH+v4HApcS
         G4U6Cghch345Ns0tpJUpwtaj9DG3e8k3l9RFIXQ8JIwqqPsoDK9dI7vRakoMkDYwTR+R
         pxyumTXk+ETpC7hKWFJGtzXKd3qxLTVdivd75G2LYUYv0tYqsxR/gFKqbzlITc8+9fvX
         l0QnMyipVr06Eop6uPg+dpWUnqdn/gc41kJoXQ7zNprSGzACDMNOC0gx2+F9XzJvoUsH
         Ngmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720637641; x=1721242441;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qqvy+RCVhIN6GftnBc/LcPvNsXKNazcESkZoy08UdKU=;
        b=Wq2YQWoAaLVspOmT9mOBTPViEamVa46fTK69Q+b9cYeCXE3KB61Tv1L4SOWF/AlAjJ
         NG2S0cbfGVw8O1FB/Kv62dytj7MVgnlTqmTP5UMzhU9oOvhepzCtmt4ov2mWzD6+s9qY
         Z/kIepGDBmodIkGpZXglULxfTqySrmOgyPIkcQfWYXXSoJoo95bHEym3JikdWy0dEZay
         9vMVsjufGVVbmX2ZyUmMw84JHawg/MGLeMp6X5gDYJ4U7pt7JW+ZQYrlgGK9RRqlNvTx
         R89oZpoaQK9oUWLGL5ZjViXIhXIcj/Apb+GZYqQz/dhe0kV0ALOb5NXBa18+j1TK644k
         4aWA==
X-Forwarded-Encrypted: i=1; AJvYcCWXwZzPNaCo8QnuCag5aTXBic2AMyC+eRf7GG+nL5X40dHMVeUF3MUMvEu6ig/J/wrtE67qc/rXQHJp6TSUaqD+gVGVlcQ80C0Ow9BL
X-Gm-Message-State: AOJu0Yw2QzrUX0NsnQugebEEZFFdwFtY6O5KUv4WMCtpC5tYtcQoTIO9
	pEMXg58w5+A/LNUr9tc50n2nbpRdyM5xHy4tfvqST5Dp43urBygiEcxTXsHRDDE=
X-Google-Smtp-Source: AGHT+IFkHZle0H4d4SNPgUu7tyCXAgkcP7pqt4G1aTXd/t+XjCQjdqg25e2ZjKndfUukIY4fvXeLuQ==
X-Received: by 2002:a05:600c:1715:b0:426:6000:565a with SMTP id 5b1f17b1804b1-426707db79amr44201745e9.16.1720637641469;
        Wed, 10 Jul 2024 11:54:01 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:757f:ac2e:ec43:fe0d:f997? ([2a10:bac0:b000:757f:ac2e:ec43:fe0d:f997])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e0a07sm91243505e9.10.2024.07.10.11.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 11:54:01 -0700 (PDT)
Message-ID: <98b2d56f-767f-4074-a9f2-4d993880e2a5@suse.com>
Date: Wed, 10 Jul 2024 21:53:59 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] x86/fred: Parse cmdline param "fred=" in
 cpu_parse_early_param()
To: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
 andrew.cooper3@citrix.com, houwenlong.hwl@antgroup.com
References: <20240709154048.3543361-1-xin@zytor.com>
 <20240709154048.3543361-2-xin@zytor.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240709154048.3543361-2-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9.07.24 г. 18:40 ч., Xin Li (Intel) wrote:
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
> 
> Change since v1:
> * Use strncmp() instead of strcmp().
> ---
>   arch/x86/kernel/cpu/common.c |  5 +++++
>   arch/x86/kernel/traps.c      | 26 --------------------------
>   2 files changed, 5 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index d4e539d4e158..10a5402d8297 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1510,6 +1510,11 @@ static void __init cpu_parse_early_param(void)
>   	if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
>   		setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
>   
> +	/* Minimize the gap between FRED is available and available but disabled. */
> +	arglen = cmdline_find_option(boot_command_line, "fred", arg, sizeof(arg));
> +	if (arglen != 2 || strncmp(arg, "on", 2))

I'm confused why you keep perverting the calling convention of 
cmdline_find_option. The doc clearly states:

     * Returns the position of that @option (starts counting with 1) 

     * or 0 on not found.  @option will only be found if it is found 

     * as an entire word in @cmdline.  For instance, if @option="car" 

     * then a cmdline which contains "cart" will not match.

You should only care if arglen is non 0, which if it is you check if its 
value equal 'on', why bother with its starting position?

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

