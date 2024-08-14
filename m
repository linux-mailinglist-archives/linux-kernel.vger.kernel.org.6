Return-Path: <linux-kernel+bounces-287031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC8A9521DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550CE1C2202B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DA01BD515;
	Wed, 14 Aug 2024 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFyxU3Qx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B645F1BD014
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723659297; cv=none; b=KxkrrD6v3QoalfjuxKghwOFgbQlhsjXkci6NKreAE/TUfVSumobcAjJh4gLWhqnyV96iErFf3hj5SUAhQvQeP/vcQKAVX55lizw5TnMkl7zlxzvuWk1a0RRRmPjZpU+qvEV7PYz1/V/EEzDy9w0NO1g58ko6sISv6mllajXCCHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723659297; c=relaxed/simple;
	bh=i6BkDoLlaoX+JjFd1Eh5Avh6/AbATM1NS+hHzsa1tSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxypFS7/AA93GtjRWwNTnEe0P+BE2sLXW3pzB5za+kS8EHfZQrCco7bZgIenE3MpO9e/oYrU5JLKGlEXh0qJvwNmb6s3ziqaJnudWchXoEofaDpA59Zxl2xXFObfLlwWmbKqNXfczsaGKL1gUfaU0yrPS57mGLRyWcWIYdFtn80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFyxU3Qx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723659294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=umYOps4F9bHTm9Ep0XCxv21fl142J86XVlpY2IGreP4=;
	b=AFyxU3Qx0jN15+lqRuUXauHlcw/O5xhMx5TPJsWhfkGQZvxx+oFeEGwtXeQ/JSFdlEdZQ3
	98F2eTjwp79rCRz6mSuiZ2JXltIj17iXhAQ8xcS3z0+6ZxxWdbfAlOj02GWXTAHTFZ5Koc
	dJl9y65W2IPhT8kJiGwfIfpHqDwBiiA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-9BnljSO4N2W3qQ9Z-s7mnA-1; Wed, 14 Aug 2024 14:14:53 -0400
X-MC-Unique: 9BnljSO4N2W3qQ9Z-s7mnA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-427ffa0c9c7so657205e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723659291; x=1724264091;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umYOps4F9bHTm9Ep0XCxv21fl142J86XVlpY2IGreP4=;
        b=r/dbInlncmhIg7B2E3QcmKGzZyrVOgQ7gFM2H6YQl77J0Vi3rqObsnmMy6pu2PN2V1
         xVJj9br1VkFmiL9yKe3RxAOax62oA76QZZcuiok3qB4Xr2LJKskMhZ6XrczsO969pyqp
         P71G5we8VqmGy2jIf0iTHruYkvWJ0TpRC5uSCquv2stYQwMpJPuZPJPpY7+fuwbIbOlZ
         xaWfjOuzna4q5T3DS9zRN2fMjIAc9wM/UTipN9p6Muy2q59lb/7CzTmmJLoDZnxvRl16
         w5b/fCu2uORIJB3fF/tIspJ0AQuU3T1LCQYcgqI89vgVULiMbqDz8PHvekKzDReP8+mS
         ARQw==
X-Forwarded-Encrypted: i=1; AJvYcCVMxM9QZgq1jZ3DiM1CmmxcnUN+MFFH4eEQ8yuCkpQMkSkjMkk0KW7247tN16dgh8fUUGJG7p65+olYjwerYYcvONbDL+vzPAU97Epi
X-Gm-Message-State: AOJu0YxrzQ3noCa7XiWXP8lyjlY8UEYmDm/Q+LQX3s/CsqJWg2jvrzNz
	RbDKcflbgXeKLjTeS+QMKFQmp5iiZ/+cgK0wXz2QOshZf6nywVMbkB8ft53OWKLD5jbcGYLhJuf
	P/d5yfatG/lK+tMDtO/ys0cOW6TeaQoI4lu8j0PMAsRlRdQAnLUc3yXQhXpVLZnlojc4VRw==
X-Received: by 2002:a05:600c:3b21:b0:426:6f87:65fc with SMTP id 5b1f17b1804b1-429dd23ce14mr30734175e9.17.1723659291423;
        Wed, 14 Aug 2024 11:14:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6lRWgEY+GRw+Y2rxo2WrjU1gDgeDGJu9UBl9Icg/Y/Fj/LoEevNAbPFHDDVjcOvyablY/YQ==
X-Received: by 2002:a05:600c:3b21:b0:426:6f87:65fc with SMTP id 5b1f17b1804b1-429dd23ce14mr30734045e9.17.1723659290916;
        Wed, 14 Aug 2024 11:14:50 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429ded582fcsm26990805e9.44.2024.08.14.11.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 11:14:49 -0700 (PDT)
Message-ID: <c4f7cb72-c0af-433d-ab52-e68728af1446@redhat.com>
Date: Wed, 14 Aug 2024 20:14:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] KVM: Add a module param to allow enabling
 virtualization when KVM is loaded
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>
References: <20240608000639.3295768-1-seanjc@google.com>
 <20240608000639.3295768-5-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240608000639.3295768-5-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/24 02:06, Sean Christopherson wrote:
> Add an off-by-default module param, enable_virt_at_load, to let userspace
> force virtualization to be enabled in hardware when KVM is initialized,
> i.e. just before /dev/kvm is exposed to userspace.  Enabling virtualization
> during KVM initialization allows userspace to avoid the additional latency
> when creating/destroying the first/last VM.  Now that KVM uses the cpuhp
> framework to do per-CPU enabling, the latency could be non-trivial as the
> cpuhup bringup/teardown is serialized across CPUs, e.g. the latency could
> be problematic for use case that need to spin up VMs quickly.
> 
> Enabling virtualizaton during initialization will also allow KVM to setup
> the Intel TDX Module, which requires VMX to be fully enabled, without
> needing additional APIs to temporarily enable virtualization.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>

I think we should enable it by default and wait for someone to complain. 
  Or notice, even.

Paolo

> ---
>   virt/kvm/kvm_main.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 98e52d12f137..7bdd744e4821 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -5495,6 +5495,9 @@ static struct miscdevice kvm_dev = {
>   };
>   
>   #ifdef CONFIG_KVM_GENERIC_HARDWARE_ENABLING
> +static bool enable_virt_at_load;
> +module_param(enable_virt_at_load, bool, 0444);
> +
>   __visible bool kvm_rebooting;
>   EXPORT_SYMBOL_GPL(kvm_rebooting);
>   
> @@ -5645,15 +5648,41 @@ static void kvm_disable_virtualization(void)
>   	unregister_syscore_ops(&kvm_syscore_ops);
>   	cpuhp_remove_state(CPUHP_AP_KVM_ONLINE);
>   }
> +
> +static int kvm_init_virtualization(void)
> +{
> +	if (enable_virt_at_load)
> +		return kvm_enable_virtualization();
> +
> +	return 0;
> +}
> +
> +static void kvm_uninit_virtualization(void)
> +{
> +	if (enable_virt_at_load)
> +		kvm_disable_virtualization();
> +
> +	WARN_ON(kvm_usage_count);
> +}
>   #else /* CONFIG_KVM_GENERIC_HARDWARE_ENABLING */
>   static int kvm_enable_virtualization(void)
>   {
>   	return 0;
>   }
>   
> +static int kvm_init_virtualization(void)
> +{
> +	return 0;
> +}
> +
>   static void kvm_disable_virtualization(void)
>   {
>   
> +}
> +
> +static void kvm_uninit_virtualization(void)
> +{
> +
>   }
>   #endif /* CONFIG_KVM_GENERIC_HARDWARE_ENABLING */
>   
> @@ -6395,6 +6424,10 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
>   
>   	kvm_gmem_init(module);
>   
> +	r = kvm_init_virtualization();
> +	if (r)
> +		goto err_virt;
> +
>   	/*
>   	 * Registration _must_ be the very last thing done, as this exposes
>   	 * /dev/kvm to userspace, i.e. all infrastructure must be setup!
> @@ -6408,6 +6441,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
>   	return 0;
>   
>   err_register:
> +	kvm_uninit_virtualization();
> +err_virt:
>   	kvm_vfio_ops_exit();
>   err_vfio:
>   	kvm_async_pf_deinit();
> @@ -6433,6 +6468,8 @@ void kvm_exit(void)
>   	 */
>   	misc_deregister(&kvm_dev);
>   
> +	kvm_uninit_virtualization();
> +
>   	debugfs_remove_recursive(kvm_debugfs_dir);
>   	for_each_possible_cpu(cpu)
>   		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));


