Return-Path: <linux-kernel+bounces-301473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 205C095F169
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49541F227E0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8B31714A8;
	Mon, 26 Aug 2024 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jkk4KyOJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EDA15DBBA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675812; cv=none; b=Uuxo4mEpZy5PJl+nswVXX+/LLPN3qTl2BsKSf8isSWL6PkBOT3YIw5eYNAlJXKM9l9pooD5TCHdvmrjlM+JwyEK+gGfjNVffNv/0wNUj+5hjizLGsHMeY7DBeK0s/MqwBxdrJSjQsF1kqOa7qcig3vMlnuyMzDBZoKW/d+O8sEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675812; c=relaxed/simple;
	bh=iWRFUZw7EAU7SCpienX05S6uQTjYRWJKezLcC9Sf7YI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NhcEDUyog1GgFryk0OmWuSo4V+rcj8AEuIw8jpWra6VVbZKFAukQ8N1XWogNnwmYxHMLd+/Z8mQ5AyVOhtWMP0+5hXdGZ8tKS1XTIdIpVCthEbH3QuE6lYUSTusrZyW3OIllaBhDC2EQ82VGI/cvLkciUw/RdeOJR4qZf2IGAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jkk4KyOJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724675809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2mpNv0/zUncpktHjWKY5hkNa40BgmEN2ZaZZ+DFcs/s=;
	b=Jkk4KyOJ5B9LyWira2Fz/mqmN/j+XSoP5jZwO0sY0R/MITMhXQk7F5YCs0OV9cflEWC7p4
	x0HxAtNiCRsjluOntZgm2LSVoGsrH/+HE608OLNoZFJrUXUTbW9ZojL0jo8fD2JEiXJVPu
	SGmycm5NGme6Yo62qAHv9PTmq6I5Sdc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-msJNlUPDOMKLjMjXcHzQQQ-1; Mon, 26 Aug 2024 08:36:48 -0400
X-MC-Unique: msJNlUPDOMKLjMjXcHzQQQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a86a784b1easo277414766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724675807; x=1725280607;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mpNv0/zUncpktHjWKY5hkNa40BgmEN2ZaZZ+DFcs/s=;
        b=lSD4lr4YZSLDDFKp3n1PY0dNFwmQc0F2WmESvV5J7Oojq0rQs6epL1kzeU6YveWqy6
         N+Q3ADFfGkNSQ7Ljfq4KKcv8eFRVGE5/yyBfFyuUQsU/QcBvi9MvF7z41SbmnvweRj1O
         i8X+BTkbaqSVWes4wU14iy2DYagAYaM5LAN48kH9dftfmtTjftQxW+h8lhk3ueHM/kU2
         MAC421ng9tgukvvGm1n41x7V0WH/UJTlX8xqIvFRb1fN4KZaAFCVR5G8vAStQvUr4sVo
         YnslzGj58Kcb4JRwwRZJb0qIC3WVp/hpKNX2cOhg56cN+R+EiwaYLW56dTKgj5s31ODc
         /dug==
X-Forwarded-Encrypted: i=1; AJvYcCVs2q71T+hkTWtiog8xMxjE2RZnf5ITsMCZR5PWmp/S9W19GkLWCIBf9n39tycGoQUN5ZsyRZGswDHwEiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwWKuUqeAfGEDYQO3ukN830HD/bnShsLkJiXajGn8DOyHW7Gn
	fOOQcZDCyarEDPoUGJBFM73DXSoQ51Wbm/pX8iHQ77bUghPFmvDvxYJ0Wz7M8xmIyxOxWdeEnmb
	20yEU8tnRc7n5/hj4aRx2cKE9X/WGQ5XbwEG0blcrQasDv/PlfqCd60DO58wN5Q==
X-Received: by 2002:a17:907:3fa6:b0:a7a:c106:364f with SMTP id a640c23a62f3a-a86a54d198dmr710878166b.43.1724675807274;
        Mon, 26 Aug 2024 05:36:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1RlIEl6d5JcDZs9kvOBnlK+XjHpgx2Ot6NWif/JsEW1r5gRLLOQ2rzpgkzMVRaB/uhIDA9g==
X-Received: by 2002:a17:907:3fa6:b0:a7a:c106:364f with SMTP id a640c23a62f3a-a86a54d198dmr710876466b.43.1724675806721;
        Mon, 26 Aug 2024 05:36:46 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436607sm658029666b.105.2024.08.26.05.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 05:36:46 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: stable@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] x86/hyperv: fix kexec crash due to VP assist page
 corruption
In-Reply-To: <20240826105029.3173782-1-anirudh@anirudhrb.com>
References: <20240826105029.3173782-1-anirudh@anirudhrb.com>
Date: Mon, 26 Aug 2024 14:36:44 +0200
Message-ID: <87zfozxxyb.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anirudh Rayabharam <anirudh@anirudhrb.com> writes:

> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>
> 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go
> online/offline") introduces a new cpuhp state for hyperv initialization.
>
> cpuhp_setup_state() returns the state number if state is CPUHP_AP_ONLINE_DYN
> or CPUHP_BP_PREPARE_DYN and 0 for all other states. For the hyperv case,
> since a new cpuhp state was introduced it would return 0. However,
> in hv_machine_shutdown(), the cpuhp_remove_state() call is conditioned upon
> "hyperv_init_cpuhp > 0". This will never be true and so hv_cpu_die() won't be
> called on all CPUs. This means the VP assist page won't be reset. When the
> kexec kernel tries to setup the VP assist page again, the hypervisor corrupts
> the memory region of the old VP assist page causing a panic in case the kexec
> kernel is using that memory elsewhere. This was originally fixed in dfe94d4086e4
> ("x86/hyperv: Fix kexec panic/hang issues").
>
> Set hyperv_init_cpuhp to CPUHP_AP_HYPERV_ONLINE upon successful setup so that
> the hyperv cpuhp state is removed correctly on kexec and the necessary cleanup
> takes place.
>
> Cc: stable@vger.kernel.org
> Fixes: 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline")
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  arch/x86/hyperv/hv_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 17a71e92a343..81d1981a75d1 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -607,7 +607,7 @@ void __init hyperv_init(void)
>  
>  	register_syscore_ops(&hv_syscore_ops);
>  
> -	hyperv_init_cpuhp = cpuhp;
> +	hyperv_init_cpuhp = CPUHP_AP_HYPERV_ONLINE;

Do we really need 'hyperv_init_cpuhp' at all? I.e. post-change (which
LGTM btw), I can only see one usage in hv_machine_shutdown():

   if (kexec_in_progress && hyperv_init_cpuhp > 0)
           cpuhp_remove_state(hyperv_init_cpuhp);

and I'm wondering if the 'hyperv_init_cpuhp' check is really
needed. This only case where this check would fail is if we're crashing
in between ms_hyperv_init_platform() and hyperv_init() afaiu. Does it
hurt if we try cpuhp_remove_state() anyway?

>  
>  	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
>  		hv_get_partition_id();
> @@ -637,7 +637,7 @@ void __init hyperv_init(void)
>  clean_guest_os_id:
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
>  	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
> -	cpuhp_remove_state(cpuhp);
> +	cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
>  free_ghcb_page:
>  	free_percpu(hv_ghcb_pg);
>  free_vp_assist_page:

-- 
Vitaly


