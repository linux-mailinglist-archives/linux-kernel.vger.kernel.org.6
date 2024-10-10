Return-Path: <linux-kernel+bounces-359025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C9C998685
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50E41C2376D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61C91C7B6E;
	Thu, 10 Oct 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEYcRWmz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CEC1C6F40
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564385; cv=none; b=cV1GaVzGPWVd4F5OCrqHQlE/pGT+fhhkzi5MUJi8vme395WMV7lmQlAFpfpuJJpKMrzy/cYiyGdpnWC3DQGzS9D73KLbcveLefiJnpWlUDRCWtCwm4DhZrwNXrWb6HRO7u5w6l7CsfsgiADumW/REelz/8lMiuftCiTbseJvspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564385; c=relaxed/simple;
	bh=gB/Bxcsggt/d/+PHWcnc10XGSm/R2PwjjQ6YpCvpjUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvRnqD9H36DkMiAWisS6N7tDLVwk2nTBGD0Zm3jbkm3nVOU8N7oCSzeLnB6JT/XYWvAUXR5CjX+M4M8O1d163pUTy6awtAAiSGNn4t5/VVdIXPmCbfsO3nsLMrfoLKWzgGVxhntxV+s15iNb3g9pxf+e7sSdfXlViXZ6T8F7S3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KEYcRWmz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728564382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Pp428+o6AOVfMNyGufRXb57C/mbuEZh30bGw/01Jeok=;
	b=KEYcRWmzEdLgttKIAm9Sg8P9Pjrw9/5w20fsTDGSjqPMbUoP7fpoocDnvtEWcPFZudGrXe
	xXnamOZ/Uor0vnhRpFgx8HkLRuzY5ajj/qqhvOccvzIO0Fo6S2QOmwH4/lXV9gfiNRSQXD
	Bg5iXizCL1uGbkh/5fx0yKdGluB9+GM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-GEK0mGu8MyS9VOb8rJKsZw-1; Thu, 10 Oct 2024 08:46:21 -0400
X-MC-Unique: GEK0mGu8MyS9VOb8rJKsZw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a9959df649aso68991366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728564378; x=1729169178;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pp428+o6AOVfMNyGufRXb57C/mbuEZh30bGw/01Jeok=;
        b=QwA6GvN78yF7A/XX0QI0gSdJxsEeyRWShjsZSvrrBHHd7qQrQy5JNCm1VSmaR4KHKW
         IX3KTuyZqXlX85N2d+vtpRE8S3BT5splM5p6+A2yishg0kAy/tlie6m2TqIHXuM6Id7o
         7X4coYIDq5kuQqvp1fT3/2PF6j0Vl066yMWsv9ycQmLqTyOqmQMnr81bYP2Wgq4bZ5s4
         e6Dbvtzh8SjvL6q9je4kWuLRvGLVFEYDDFuhjC6jz/br5ydDuIjsGIYNv0itqUGDjTc8
         Ww/wlxixFhFRzcB69feKPEgjfB+Slinhy0mV26ilbeCTGH731eR8pMeyfWkDEaubDeZq
         LVcA==
X-Forwarded-Encrypted: i=1; AJvYcCXi8Ff7VQZijzzQMTq9VrSFbqbuP/uD/uHYu1OWsLvmLJGZ4EyMkRhtMYu9X/4t5BJJlYasFEuNxhgLcKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgd3k3CnWrGOUjLPIHGe0HHld3vPluMDStqn/SlZg8mVkvohrX
	gzwfAdoMEMSwwPtNwpEZn0VCGcI/LJTcKd+zSmg1cm4qR8DQkaH3rEz0Dv6Ak4sAuA5LlpvUvlH
	XvqQDillzgfqO7OLKGsysFxtJ9289l7+7Tl/x9Cfwiz6FZMsFuYJAapoqJeY8ZU5bWu631aO0
X-Received: by 2002:a17:907:940d:b0:a99:4eac:bb98 with SMTP id a640c23a62f3a-a998d31c068mr569316666b.51.1728564378468;
        Thu, 10 Oct 2024 05:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZQJ0C4cv3iGhR09yajySYTcDf+yHyYkfG33sSJXo+9rrIeBRewHZY6fgvqwKjME2LxydoDg==
X-Received: by 2002:a17:907:940d:b0:a99:4eac:bb98 with SMTP id a640c23a62f3a-a998d31c068mr569314266b.51.1728564378020;
        Thu, 10 Oct 2024 05:46:18 -0700 (PDT)
Received: from [192.168.10.81] ([151.81.124.37])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7ec4cd0sm84679966b.1.2024.10.10.05.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 05:46:17 -0700 (PDT)
Message-ID: <1baf4159-ce53-4a75-99bf-adf4b89dd07b@redhat.com>
Date: Thu, 10 Oct 2024 14:46:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] Revert "KVM: Fix vcpu_array[0] races"
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, Michal Luczaj <mhal@rbox.co>,
 Alexander Potapenko <glider@google.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>
References: <20241009150455.1057573-1-seanjc@google.com>
 <20241009150455.1057573-5-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241009150455.1057573-5-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/24 17:04, Sean Christopherson wrote:
> Now that KVM loads from vcpu_array if and only if the target index is
> valid with respect to online_vcpus, i.e. now that it is safe to erase a
> not-fully-onlined vCPU entry, revert to storing into vcpu_array before
> success is guaranteed.
> 
> If xa_store() fails, which _should_ be impossible, then putting the vCPU's
> reference to 'struct kvm' results in a refcounting bug as the vCPU fd has
> been installed and owns the vCPU's reference.
> 
> This was found by inspection, but forcing the xa_store() to fail
> confirms the problem:
> 
>   | Unable to handle kernel paging request at virtual address ffff800080ecd960
>   | Call trace:
>   |  _raw_spin_lock_irq+0x2c/0x70
>   |  kvm_irqfd_release+0x24/0xa0
>   |  kvm_vm_release+0x1c/0x38
>   |  __fput+0x88/0x2ec
>   |  ____fput+0x10/0x1c
>   |  task_work_run+0xb0/0xd4
>   |  do_exit+0x210/0x854
>   |  do_group_exit+0x70/0x98
>   |  get_signal+0x6b0/0x73c
>   |  do_signal+0xa4/0x11e8
>   |  do_notify_resume+0x60/0x12c
>   |  el0_svc+0x64/0x68
>   |  el0t_64_sync_handler+0x84/0xfc
>   |  el0t_64_sync+0x190/0x194
>   | Code: b9000909 d503201f 2a1f03e1 52800028 (88e17c08)
> 
> Practically speaking, this is a non-issue as xa_store() can't fail, absent
> a nasty kernel bug.  But the code is visually jarring and technically
> broken.
> 
> This reverts commit afb2acb2e3a32e4d56f7fbd819769b98ed1b7520.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Michal Luczaj <mhal@rbox.co>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   virt/kvm/kvm_main.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index fca9f74e9544..f081839521ef 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4283,7 +4283,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
>   	}
>   
>   	vcpu->vcpu_idx = atomic_read(&kvm->online_vcpus);
> -	r = xa_reserve(&kvm->vcpu_array, vcpu->vcpu_idx, GFP_KERNEL_ACCOUNT);
> +	r = xa_insert(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCOUNT);
> +	BUG_ON(r == -EBUSY);
>   	if (r)
>   		goto unlock_vcpu_destroy;
>   
> @@ -4298,12 +4299,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
>   	kvm_get_kvm(kvm);
>   	r = create_vcpu_fd(vcpu);
>   	if (r < 0)
> -		goto kvm_put_xa_release;
> -
> -	if (KVM_BUG_ON(xa_store(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, 0), kvm)) {
> -		r = -EINVAL;
> -		goto kvm_put_xa_release;
> -	}
> +		goto kvm_put_xa_erase;

I also find it a bit jarring though that we have to undo the insertion. 
This is a chicken-and-egg situation where you are pick one operation B 
that will have to undo operation A if it fails.  But what xa_store is 
doing, is breaking this deadlock.

The code is a bit longer, sure, but I don't see the point in 
complicating the vcpu_array invariants and letting an entry disappear.

The rest of the series is still good, of course.

Paolo

>   	/*
>   	 * Pairs with smp_rmb() in kvm_get_vcpu.  Store the vcpu
> @@ -4318,10 +4314,10 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
>   	kvm_create_vcpu_debugfs(vcpu);
>   	return r;
>   
> -kvm_put_xa_release:
> +kvm_put_xa_erase:
>   	mutex_unlock(&vcpu->mutex);
>   	kvm_put_kvm_no_destroy(kvm);
> -	xa_release(&kvm->vcpu_array, vcpu->vcpu_idx);
> +	xa_erase(&kvm->vcpu_array, vcpu->vcpu_idx);
>   unlock_vcpu_destroy:
>   	mutex_unlock(&kvm->lock);
>   	kvm_dirty_ring_free(&vcpu->dirty_ring);


