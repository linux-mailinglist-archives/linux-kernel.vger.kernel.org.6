Return-Path: <linux-kernel+bounces-173458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C2E8C00A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BE62853F6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A713126F1F;
	Wed,  8 May 2024 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CBz097kq"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FDD84A23
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181027; cv=none; b=YiHsO2eGxwfEfINlT6ssx189MZy1EWFpzsc1o1c/Q4PyEYWDMGctBZNdDfr//zznHJq2e93MjtEA+aiIzXTeuz2n5oYHy9NHHyK7iAiH3QFUxA/CSo5uqfpnroxEoZ8+qOYWOzOiSTF/jEmfnHi9fRq5YWiNVlqGNbrVlg0Qvw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181027; c=relaxed/simple;
	bh=VEMPM4831Yj1mWl6Y2OapJ4pASPVcWMeWjUTlVs+ecU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uzx9c+44K9ce7Dg+gqyKUH0XK8jKIfAwme7yFu8dX9A3mNM5q2kizMv2F7lJMfcdvfLHc8iuo7vJEbmGHOzbod8EloGMtSbznMUuOaoDx9UYkKzLeXOUME1G2LKh1ZV7mzNsDi15urCatdRt2LZvnrwVYvw/URiWEl59bc9kMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CBz097kq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41c7ac71996so35140785e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 08:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715181023; x=1715785823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAXL1b6MFJI6dsIBdZB/KbdribzTrFdzVHtNl6cgpaw=;
        b=CBz097kqREo35rf7NVNz6TFzncGctCpJAr/ULtcWpXj2Zz8Lb4e0OiYN0CbZREYbPU
         cDyb+vasHV9dd644cIwbV+sbEZr3ikmUtoKog5W0d9aP9Icra1ISnvpaZXUeDPc1/iT0
         vDdb6AX0xZOJyCW8KHguPHwSltntW6XdwKJjTJTGP6kZa1pmd5+RPNB2VRoKI0d18rs5
         4/4ZUzfhiyjUz3GacC+o4FcE1YMCGb8YqUOa3jPOPOKbl9F53MtkgHa+qaS8xHZfHYk+
         vG+gbCHXec9kRI4mIOuMDuUYmtmJBr/kA1WC3VZ6DbJMq0uHsj3/CO7NA0A0CCTdQFoV
         5D6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715181023; x=1715785823;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAXL1b6MFJI6dsIBdZB/KbdribzTrFdzVHtNl6cgpaw=;
        b=tm84omsr3JGshkVSLrLvUltVhUOYXO7gV7FsVTt7dJwJG5hQusU3mvDgDo/t+fNNxk
         FmzB84A6nLQL/uQRJeFiWlJH2pW9ARQvNcTlMy9ga+UavD60ywpurHShZxsxSzmAGfLi
         hWywalFRqGFlp4Hge1EhtZYSPsfkZ0c51LYaI580+AIMYlo0NYSYBn9yFtl6iQLIEGtL
         fycreNtVc3ByxEHObe1C/09nPNpVNH2AABKQwXeHpup2Bg4usWlGZvvO7WfQYWQy2Wp+
         EJSng6JywOsTxxqqJjo2bf7Yc4RwRGDG9B9h9ctGn305u1o2p65YreeJqB0oZZge9zIF
         FOKw==
X-Gm-Message-State: AOJu0YwrpYV9XNWayYADBivGsc/qyOhTPukSe0ZfOMc9DskHPJH+MgsW
	qiYRDI4+JwcSPLiJ71gywYSlFiFtLWXmKz9X5ObZifdWsLG+TGUqv4nhgUDyeDU=
X-Google-Smtp-Source: AGHT+IEPMAgMDoouzWaIFjjAkaC34sekBpC6BFD8EA8rEQhOebxrTWw/s2JrH4szPKAj/L6y+eTRwQ==
X-Received: by 2002:a05:600c:458d:b0:41c:503:9a01 with SMTP id 5b1f17b1804b1-41f71ecb256mr21203985e9.25.1715181023244;
        Wed, 08 May 2024 08:10:23 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7315:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7315:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110f3esm26144295e9.29.2024.05.08.08.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 08:10:23 -0700 (PDT)
Message-ID: <f48601e1-e8a6-4161-9a77-32ad10c887de@suse.com>
Date: Wed, 8 May 2024 18:10:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
To: Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, KP Singh <kpsingh@kernel.org>,
 Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, Maksim Davydov <davydov-max@yandex-team.ru>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <66327dcf87284a09ed17ac24227695ea3ba1f287.1715059256.git.jpoimboe@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <66327dcf87284a09ed17ac24227695ea3ba1f287.1715059256.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7.05.24 г. 8:30 ч., Josh Poimboeuf wrote:
> In cloud environments it can be useful to *only* enable the vmexit
> mitigation and leave syscalls vulnerable.  Add that as an option.
> 
> This is similar to the old spectre_bhi=auto option which was removed
> with the following commit:
> 
>    36d4fe147c87 ("x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto")
> 
> with the main difference being that this has a more descriptive name and
> is disabled by default.
> 
> Requested-by: Maksim Davydov <davydov-max@yandex-team.ru>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 12 +++++++++---
>   arch/x86/kernel/cpu/bugs.c                      | 16 +++++++++++-----
>   2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 213d0719e2b7..9c1f63f04502 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6072,9 +6072,15 @@
>   			deployment of the HW BHI control and the SW BHB
>   			clearing sequence.
>   
> -			on   - (default) Enable the HW or SW mitigation
> -			       as needed.
> -			off  - Disable the mitigation.
> +			on     - (default) Enable the HW or SW mitigation as
> +				 needed.  This protects the kernel from
> +				 both syscalls and VMs.
> +			vmexit - On systems which don't have the HW mitigation
> +				 available, enable the SW mitigation on vmexit
> +				 ONLY.  On such systems, the host kernel is
> +				 protected from VM-originated BHI attacks, but
> +				 may still be vulnerable to syscall attacks.
> +			off    - Disable the mitigation.
>   
>   	spectre_v2=	[X86,EARLY] Control mitigation of Spectre variant 2
>   			(indirect branch speculation) vulnerability.
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index ab18185894df..6974c8c9792d 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -1625,6 +1625,7 @@ static bool __init spec_ctrl_bhi_dis(void)
>   enum bhi_mitigations {
>   	BHI_MITIGATION_OFF,
>   	BHI_MITIGATION_ON,
> +	BHI_MITIGATION_VMEXIT_ONLY,
>   };
>   
>   static enum bhi_mitigations bhi_mitigation __ro_after_init =
> @@ -1639,6 +1640,8 @@ static int __init spectre_bhi_parse_cmdline(char *str)
>   		bhi_mitigation = BHI_MITIGATION_OFF;
>   	else if (!strcmp(str, "on"))
>   		bhi_mitigation = BHI_MITIGATION_ON;
> +	else if (!strcmp(str, "vmexit"))
> +		bhi_mitigation = BHI_MITIGATION_VMEXIT_ONLY;
>   	else
>   		pr_err("Ignoring unknown spectre_bhi option (%s)", str);
>   
> @@ -1659,19 +1662,22 @@ static void __init bhi_select_mitigation(void)
>   			return;
>   	}
>   
> +	/* Mitigate in hardware if supported */
>   	if (spec_ctrl_bhi_dis())
>   		return;
>   
>   	if (!IS_ENABLED(CONFIG_X86_64))
>   		return;
>   
> -	/* Mitigate KVM by default */
> -	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
> -	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
> +	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
> +		pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit only\n");
> +		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
> +		return;
> +	}

nit: How about setting CLEAR_BHB_LOOP_ON_VMEXIT unconditionally, then 
afterwards checking if MITIGATION_VMEXIT_ONLY is set and if yes simply 
return, that way you don't duplicate the setup of the VMEXIT code

>   
> -	/* Mitigate syscalls when the mitigation is forced =on */
> +	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall and vm exit\n");
>   	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
> -	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");
> +	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
>   }
>   
>   static void __init spectre_v2_select_mitigation(void)

