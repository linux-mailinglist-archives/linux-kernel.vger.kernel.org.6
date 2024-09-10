Return-Path: <linux-kernel+bounces-323401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96246973CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B913D1C21741
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCFB19EEB4;
	Tue, 10 Sep 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfqJcOfc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205616F2FD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984035; cv=none; b=Nuvo52Y6sDyri/bn39BHADHFAXjBXLn2Pzbx1nEEYptYaY4UKVgj88JWfD+QHHCd+WCC3SpgOdUw6nLlogHYIBJRDWDz4OD9ZzJFy8DMRGsbv3Dee92+Smt89WQDRpagLe8fHs2yF3JJaWs05PxEQ8oXhKI92QDWT6t7PAUecmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984035; c=relaxed/simple;
	bh=JWVM4otOQv+jJECOz+CBNEA9+udXOfIUbaqPpk6TaU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/oo6g/YXT/1Pa7Uwlsm2s0lXFuS++h8XwQ6c8eoePbCGTeSNDFIv3qddu2mYmkNfog2+2nIGrp4ef9AdJAPvajXy2mN27DtptbF04+wsla5QoM79KK514TALiI7Yti8XC5Vj+rXSFeDo5z41EIUubxxJjjOHHu1GYJWgpT21sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hfqJcOfc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725984033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0fzvPsoHOWoNs9nSW3FtSoniFPK0US8xYTqjU6a+Y3A=;
	b=hfqJcOfcLa5TZ078QgTTMOOae5LO37dBM6weVKPgmT+4p1POZgHP2l2bZsKBLaVUgqzo96
	ow4x2/If2k5QrQ8Qe812G/Z8/mPAAoVis/vC+HOZX2BlkSkTGeKQW8Un5Ux1Eiy5k6RlMg
	yAPQypMyGu7SlAxmr8NcOPkkblA5AK8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-U15rG-IpNA-INmlOy0IA-Q-1; Tue, 10 Sep 2024 12:00:31 -0400
X-MC-Unique: U15rG-IpNA-INmlOy0IA-Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb080ab53so22238625e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984030; x=1726588830;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0fzvPsoHOWoNs9nSW3FtSoniFPK0US8xYTqjU6a+Y3A=;
        b=GtKLzOuLd9YE/l/mktYUeV5p14aQApUSARJkN8mo6wnsYBtM6K1nl9owZbn0CNyHnG
         ka2O4jN+VWv4r/gPOPFMbLe4o3imvTt2de0qu0mknRBnUZlnCOWNLTLYc1F5PNThZyC7
         FhcC/41Q4j/iU3nazMH7yzAMmRmYqivlC9UENJIZh+G28bBkvh8ySoxrMzyyFt6o47Ci
         XnioumBMMmSK+dvSde1onD8oIbtjOxz7NZiQ/AGtA1/f6mKuyiN0Y+5UxIxVji0pR0DR
         PrqnCwO/6Bz2kL95tBkrrjkY0t3cj12NnHBB/w+xmJTHsxHqM+qWd+DSUxWRokPkYDcR
         BXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpNyetgN632nh8QjRNBnlONj+RpXeTAUtGgoOi9clhpNC1sAWLMSyfnHFE7A4zEv4F84/Xa+pSO3VuEzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi8gcw9hQTTvtUOQACu79HkB3tiCo/wAdVDua8cFV8DsZMcSXP
	EasDbioPMUYKIEsk+j4DDG2XO8rP3LZFTHZeGDgtAmcV/VSAk76TRUqh1mVlkBNIgqRRBu57bwy
	I1gb1ZtagKcCFX5Qct3aPZ+wuCLjmw2W1jl/Y4Z3GOinYjfPkosVfAMaj+uY6Gw==
X-Received: by 2002:a05:600c:1f09:b0:42c:b8cc:205a with SMTP id 5b1f17b1804b1-42cb8cc232emr51348485e9.32.1725984029892;
        Tue, 10 Sep 2024 09:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL3Y3rYT7nowu89mnGE6HKg6HDefzJ9gLIqcT2MASsILGiC5/JIgRFgYGOK8zXXpEda6OGbw==
X-Received: by 2002:a05:600c:1f09:b0:42c:b8cc:205a with SMTP id 5b1f17b1804b1-42cb8cc232emr51348215e9.32.1725984029292;
        Tue, 10 Sep 2024 09:00:29 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-378956d35dasm9268133f8f.67.2024.09.10.09.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 09:00:28 -0700 (PDT)
Message-ID: <89657f96-0ed1-4543-9074-f13f62cc4694@redhat.com>
Date: Tue, 10 Sep 2024 18:00:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/25] KVM: TDX: Add placeholders for TDX VM/vCPU
 structures
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, seanjc@google.com,
 kvm@vger.kernel.org
Cc: kai.huang@intel.com, isaku.yamahata@gmail.com,
 tony.lindgren@linux.intel.com, xiaoyao.li@intel.com,
 linux-kernel@vger.kernel.org, Isaku Yamahata <isaku.yamahata@intel.com>
References: <20240812224820.34826-1-rick.p.edgecombe@intel.com>
 <20240812224820.34826-2-rick.p.edgecombe@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240812224820.34826-2-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 00:47, Rick Edgecombe wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Add TDX's own VM and vCPU structures as placeholder to manage and run
> TDX guests.  Also add helper functions to check whether a VM/vCPU is
> TDX or normal VMX one, and add helpers to convert between TDX VM/vCPU
> and KVM VM/vCPU.
> 
> TDX protects guest VMs from malicious host.  Unlike VMX guests, TDX
> guests are crypto-protected.  KVM cannot access TDX guests' memory and
> vCPU states directly.  Instead, TDX requires KVM to use a set of TDX
> architecture-defined firmware APIs (a.k.a TDX module SEAMCALLs) to
> manage and run TDX guests.
> 
> In fact, the way to manage and run TDX guests and normal VMX guests are
> quite different.  Because of that, the current structures
> ('struct kvm_vmx' and 'struct vcpu_vmx') to manage VMX guests are not
> quite suitable for TDX guests.  E.g., the majority of the members of
> 'struct vcpu_vmx' don't apply to TDX guests.
> 
> Introduce TDX's own VM and vCPU structures ('struct kvm_tdx' and 'struct
> vcpu_tdx' respectively) for KVM to manage and run TDX guests.  And
> instead of building TDX's VM and vCPU structures based on VMX's, build
> them directly based on 'struct kvm'.
> 
> As a result, TDX and VMX guests will have different VM size and vCPU
> size/alignment.
> 
> Currently, kvm_arch_alloc_vm() uses 'kvm_x86_ops::vm_size' to allocate
> enough space for the VM structure when creating guest.  With TDX guests,
> ideally, KVM should allocate the VM structure based on the VM type so
> that the precise size can be allocated for VMX and TDX guests.  But this
> requires more extensive code change.  For now, simply choose the maximum
> size of 'struct kvm_tdx' and 'struct kvm_vmx' for VM structure
> allocation for both VMX and TDX guests.  This would result in small
> memory waste for each VM which has smaller VM structure size but this is
> acceptable.
> 
> For simplicity, use the same way for vCPU allocation too.  Otherwise KVM
> would need to maintain a separate 'kvm_vcpu_cache' for each VM type.
> 
> Note, updating the 'vt_x86_ops::vm_size' needs to be done before calling
> kvm_ops_update(), which copies vt_x86_ops to kvm_x86_ops.  However this
> happens before TDX module initialization.  Therefore theoretically it is
> possible that 'kvm_x86_ops::vm_size' is set to size of 'struct kvm_tdx'
> (when it's larger) but TDX actually fails to initialize at a later time.
> 
> Again the worst case of this is wasting couple of bytes memory for each
> VM.  KVM could choose to update 'kvm_x86_ops::vm_size' at a later time
> depending on TDX's status but that would require base KVM module to
> export either kvm_x86_ops or kvm_ops_update().
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

The ugly part here is the type-unsafety of to_vmx/to_tdx.  We probably 
should add some "#pragma poison" of to_vmx/to_tdx: for example both can 
be poisoned in pmu_intel.c after the definition of 
vcpu_to_lbr_records(), while one of them can be poisoned in 
sgx.c/posted_intr.c/vmx.c/tdx.c.  Not a strict requirement though.

Paolo


