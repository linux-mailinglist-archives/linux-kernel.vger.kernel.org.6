Return-Path: <linux-kernel+bounces-292541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77809570AA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C3328345D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40135176FDB;
	Mon, 19 Aug 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bhfv68Wb"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3A4965B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085979; cv=none; b=RJvN5AkCBQyzaEDPVwbwmLe9UmwjRy/5W9eY6mQoBBCHW9JGkkLZ+CsK1GZB4ctdoXKtf0PIH7t/OHcUk9CVUoyoDrukOZdOpXrXoiGjcvJ0p99F5l6wzr7C1ia0qLoDD3JevXcsnsoUOj0pDYCdmYUwvSR7FDRb/1HHHyU6FSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085979; c=relaxed/simple;
	bh=4Zm2aY38wQUKInxgHuMrVp3FTi32iwRINTkf8PLyzIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X44PuhGkLF01N5O9FcDMf4zM5SHVQlhNml1cvzCbkDVfMKZ3i3pXaUo/vO1jJT/vMscIS+9KAE6pnV5fBSfH8wWs13jmO+zINHjkrLyeejAv4IM+YmGIQZ2VIMxSXRLI1p29rhzy9sQ9OsvZkuCLkbUds+tjJ6roa9GBHRwZU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bhfv68Wb; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso53520041fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724085975; x=1724690775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Z7g9H1uuN368sbZwFL2P/UunOJpGy+71L7MEI5Gqco=;
        b=Bhfv68Wbv9Smj0Llmr2FCqT2yK0fyMG8+cCqauvogxQyMcYGzt/corJd4Awfrt984J
         EwHRlpT4DJ1ZIlmKuowlw11RyrfgDHp+xnVIIpcyxlb6pGb1pof/7e0lhGyxhew9fgol
         B/xQo5kqR4x3AECNUDgzlNVO/TJ+NpL2Nqn8V5RoUCOuYvDzaBLiNHwtc4KQ4Nv5puBE
         s7FdbG9iD8GVxIvB8gbvBhHHff6hRsONYisSoBK9DR4HeRdXVPvQAYP4eAIt8v/4CtUd
         PnzDVtCeFUXlz557ySU1moYc9B5L1G4UKkJH7+GBM3qvVoBRxAp2p5YAUrJfh3yaS20M
         WVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724085975; x=1724690775;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Z7g9H1uuN368sbZwFL2P/UunOJpGy+71L7MEI5Gqco=;
        b=Dh4vJQYSuYbzTRI1JboaNp2WKMkn4ntoP9/AZnxUhRXLMZ4tgi/431McrgFecsHLvY
         8AMTbmqnK+dPAzoaSamxC7Q5e6kpKXuHM/nT59zAXaXKSM/kFm8Y+3lN1CIy7lalan/a
         LasqDumgfwf5dHXY1oG59jr1dz4JikXq491k+Eo4SIoVs16wV+PbrYhtIA2M0izKZQ3j
         B2DI47tB+s/tk6/9z2gQwtat6gDlWJOxV7r+ayHqTGNBHodq7MHGRWYJLM0dalAV3tqB
         kd1R9wg3fnBlOs2GdNc/onyHBTBtRgzMQJpr5KmCYV5fRK4BP9d6kxbSe9BJHj7b9+ee
         VagA==
X-Forwarded-Encrypted: i=1; AJvYcCVR4pDR6LOr3K43GJB1/5BcVKpDWgr6TUNhnWMokptoWFUmOwMM3FcgVM0n/E6Jec/6tEEUu4kHOACS7ze7z3gF/WYHGHne0dyx6Hv6
X-Gm-Message-State: AOJu0YyrmgjVje4SbEYj1iflp2+A70hJptmvi3iNw/6SFOyowg3AA7A0
	Nztwzz9TX824l57E6Ci6tWzGSLHa3MeO4lEuNo9VRyeMeXcyFEYGS6lLYzEEh2s=
X-Google-Smtp-Source: AGHT+IGuv7SyKEaIn/yQTA5OF0LPxA1KQdVqiDZ65XXA3A41gdwd0QgZ27gUJmx+DBdupjL/FSj4UA==
X-Received: by 2002:a05:651c:544:b0:2f1:a7f8:810f with SMTP id 38308e7fff4ca-2f3be5de18cmr80508331fa.36.1724085975365;
        Mon, 19 Aug 2024 09:46:15 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:7717:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:7717:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbbe29a6sm5772026a12.13.2024.08.19.09.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:46:15 -0700 (PDT)
Message-ID: <4fcff880-30e2-44f8-aa45-6444a3eaa398@suse.com>
Date: Mon, 19 Aug 2024 19:46:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/25] KVM: TDX: create/free TDX vcpu structure
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 pbonzini@redhat.com, kvm@vger.kernel.org
Cc: kai.huang@intel.com, isaku.yamahata@gmail.com,
 tony.lindgren@linux.intel.com, xiaoyao.li@intel.com,
 linux-kernel@vger.kernel.org, Isaku Yamahata <isaku.yamahata@intel.com>
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-18-rick.p.edgecombe@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <20240812224820.34826-18-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13.08.24 г. 1:48 ч., Rick Edgecombe wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Implement vcpu related stubs for TDX for create, reset and free.
> 
> For now, create only the features that do not require the TDX SEAMCALL.
> The TDX specific vcpu initialization will be handled by KVM_TDX_INIT_VCPU.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> uAPI breakout v1:
>   - Dropped unnecessary WARN_ON_ONCE() in tdx_vcpu_create().
>     WARN_ON_ONCE(vcpu->arch.cpuid_entries),
>     WARN_ON_ONCE(vcpu->arch.cpuid_nent)
>   - Use kvm_tdx instead of to_kvm_tdx() in tdx_vcpu_create() (Chao)
> 
> v19:
>   - removed stale comment in tdx_vcpu_create().
> 
> v18:
>   - update commit log to use create instead of allocate because the patch
>     doesn't newly allocate memory for TDX vcpu.
> 
> v16:
>   - Add AMX support as the KVM upstream supports it.
> --
> 2.46.0
> ---
>   arch/x86/kvm/vmx/main.c    | 44 ++++++++++++++++++++++++++++++++++----
>   arch/x86/kvm/vmx/tdx.c     | 41 +++++++++++++++++++++++++++++++++++
>   arch/x86/kvm/vmx/x86_ops.h | 10 +++++++++
>   arch/x86/kvm/x86.c         |  2 ++
>   4 files changed, 93 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index c079a5b057d8..d40de73d2bd3 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -72,6 +72,42 @@ static void vt_vm_free(struct kvm *kvm)
>   		tdx_vm_free(kvm);
>   }
>   
> +static int vt_vcpu_precreate(struct kvm *kvm)
> +{
> +	if (is_td(kvm))
> +		return 0;
> +
> +	return vmx_vcpu_precreate(kvm);
> +}
> +
> +static int vt_vcpu_create(struct kvm_vcpu *vcpu)
> +{
> +	if (is_td_vcpu(vcpu))
> +		return tdx_vcpu_create(vcpu);
> +
> +	return vmx_vcpu_create(vcpu);
> +}
> +
> +static void vt_vcpu_free(struct kvm_vcpu *vcpu)
> +{
> +	if (is_td_vcpu(vcpu)) {
> +		tdx_vcpu_free(vcpu);
> +		return;
> +	}
> +
> +	vmx_vcpu_free(vcpu);
> +}
> +
> +static void vt_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
> +{
> +	if (is_td_vcpu(vcpu)) {
> +		tdx_vcpu_reset(vcpu, init_event);
> +		return;
> +	}
> +
> +	vmx_vcpu_reset(vcpu, init_event);
> +}
> +
>   static int vt_mem_enc_ioctl(struct kvm *kvm, void __user *argp)
>   {
>   	if (!is_td(kvm))
> @@ -108,10 +144,10 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
>   	.vm_destroy = vt_vm_destroy,
>   	.vm_free = vt_vm_free,
>   
> -	.vcpu_precreate = vmx_vcpu_precreate,
> -	.vcpu_create = vmx_vcpu_create,
> -	.vcpu_free = vmx_vcpu_free,
> -	.vcpu_reset = vmx_vcpu_reset,
> +	.vcpu_precreate = vt_vcpu_precreate,
> +	.vcpu_create = vt_vcpu_create,
> +	.vcpu_free = vt_vcpu_free,
> +	.vcpu_reset = vt_vcpu_reset,
>   
>   	.prepare_switch_to_guest = vmx_prepare_switch_to_guest,
>   	.vcpu_load = vmx_vcpu_load,
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 531e87983b90..18738cacbc87 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -377,6 +377,47 @@ int tdx_vm_init(struct kvm *kvm)
>   	return 0;
>   }
>   
> +int tdx_vcpu_create(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_tdx *kvm_tdx = to_kvm_tdx(vcpu->kvm);
> +
> +	/* TDX only supports x2APIC, which requires an in-kernel local APIC. */
> +	if (!vcpu->arch.apic)
> +		return -EINVAL;

nit: Use kvm_apic_present()

<snip>

