Return-Path: <linux-kernel+bounces-373203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E49A53B8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456721C20A91
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B82191F7C;
	Sun, 20 Oct 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQSr/2Ls"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE6128F4
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729423437; cv=none; b=sWO/UeMnnrgvAid+x8XHla+EO2t9i1SxhqrndeFPgO5SRtQah2hM+BMsdmdXijoCQdeoP4PGKXxItealpNonZOnOEQI2qBTgBwmKage9jl/3gSJTuqiJnLOyU5OvKaGCtWtbSRrdwmbUcdM/cxdUJP1r+xyJ31oTxo2ulY9Nagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729423437; c=relaxed/simple;
	bh=uTSU9Icqm1BH2e3ef1hfcYv/A1CE2ayRieFAHspcG8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kV7asmpNgUuXpWrrPKVJWbyzAtEf+h3UW3VBcbKfDf50bmgEJLHJng+CN7AsOuSl3nz6yr+cVL3MdmZEM/hqjSESdDY2qP3ChPQfLq5MK+eP0bCPbjxEYZbHk/KfJYg/sUDRBj+1Mt7E06jo62fgLAeYCcNH03quS7yXkXtAn2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FQSr/2Ls; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729423433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Lny050tEcGeI2Uox2WgaoIjNCTUW378cFEU6PBnN/8E=;
	b=FQSr/2Ls+SX+RuVcO9qiqzU6pP301S5iXYUrqXMmgoxqo9jmemrmZHSA2HcjMv0xDviJG9
	rk8I/2q4yUPIlbePKQyO2pBPCixCmqQ3YFewf/zD93lnMX1UC1O24yi1CtJCTEuV7lfDr+
	c8q/1bbrsjjPQVvw4QpcazIJ845Syog=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-0Bq2JOcKMKuHdwCk--GJtA-1; Sun, 20 Oct 2024 07:23:52 -0400
X-MC-Unique: 0Bq2JOcKMKuHdwCk--GJtA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43157cff1d1so26870475e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 04:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729423431; x=1730028231;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lny050tEcGeI2Uox2WgaoIjNCTUW378cFEU6PBnN/8E=;
        b=o3n+YSRbUGOfXdOPpqJ7qYwM99j34WM62gkOBDWklzUm/b1n/euFAYcpMIfAAv8FJh
         RbqjWHKAMgHlQveYlaotw88eqjLPZOqbANVKwIqOvpn1NuwhpRTiBfYVCk+m2VQ/BgXb
         8j7py2wO3BDBKXJyTUpHogVtrpT84WObktii7EiYGZ7Xxsr/WI9A5JvUF+bo6SWu/VSt
         N0g8EaGvTm2bFByZ0oQpZcxUwWWjNjZgzDz4NHUcd7NZ6rGjD2RQ8dvd50dnsumPaXD8
         ucdv6xLIktB2BPujazfSq5ZdUS8jqgJxHNrX+RxkvAEBoIyY76gBTBVzMcNxNCcEC0IN
         dRcg==
X-Forwarded-Encrypted: i=1; AJvYcCUSB7ut4sKXvWzIlFHB49J8IH8zpQ1j13OEcsTNkKWLjAInKLKA+KFRCXNoUB6mqqursn9XanPdKcy7U1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiHIYTyW6ip8+89g6URWAqZj/Nj/M76QTmA97YbRQnQYeptd40
	4WCQqYykjpAXhk9Jsxasi+1ntKXLnRx3Cbg/2DUlU+HgLy8ibRtoxNSL4/q7BI8ewT+DU3FePNX
	70k2j+iQGLfynLmH/WNeqTFlrR3pEVyP7QTHYgV9eP4hi9hxVpDiJKbGKSl4Q9g==
X-Received: by 2002:a5d:40c3:0:b0:37c:d23f:e464 with SMTP id ffacd0b85a97d-37eb487c2d3mr5023188f8f.38.1729423431166;
        Sun, 20 Oct 2024 04:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcwDTX8341anZv1s4YlXjYOHvwjt0tzPfZ/65jz10bcvacK48CpasaYoZJiAZepxSATlDbGg==
X-Received: by 2002:a5d:40c3:0:b0:37c:d23f:e464 with SMTP id ffacd0b85a97d-37eb487c2d3mr5023178f8f.38.1729423430796;
        Sun, 20 Oct 2024 04:23:50 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.144.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0b9432fsm1543123f8f.83.2024.10.20.04.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 04:23:50 -0700 (PDT)
Message-ID: <8889dc3b-d672-41c3-8d11-e88861b7b38e@redhat.com>
Date: Sun, 20 Oct 2024 13:23:46 +0200
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
 <1baf4159-ce53-4a75-99bf-adf4b89dd07b@redhat.com>
 <ZwgTUNCOIh2xwU6e@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <ZwgTUNCOIh2xwU6e@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 19:48, Sean Christopherson wrote:
> On Thu, Oct 10, 2024, Paolo Bonzini wrote:
>> On 10/9/24 17:04, Sean Christopherson wrote:
>>> Now that KVM loads from vcpu_array if and only if the target index is
>>> valid with respect to online_vcpus, i.e. now that it is safe to erase a
>>> not-fully-onlined vCPU entry, revert to storing into vcpu_array before
>>> success is guaranteed.
>>>
>>> If xa_store() fails, which _should_ be impossible, then putting the vCPU's
>>> reference to 'struct kvm' results in a refcounting bug as the vCPU fd has
>>> been installed and owns the vCPU's reference.
>>>
>>> This was found by inspection, but forcing the xa_store() to fail
>>> confirms the problem:
>>>
>>>    | Unable to handle kernel paging request at virtual address ffff800080ecd960
>>>    | Call trace:
>>>    |  _raw_spin_lock_irq+0x2c/0x70
>>>    |  kvm_irqfd_release+0x24/0xa0
>>>    |  kvm_vm_release+0x1c/0x38
>>>    |  __fput+0x88/0x2ec
>>>    |  ____fput+0x10/0x1c
>>>    |  task_work_run+0xb0/0xd4
>>>    |  do_exit+0x210/0x854
>>>    |  do_group_exit+0x70/0x98
>>>    |  get_signal+0x6b0/0x73c
>>>    |  do_signal+0xa4/0x11e8
>>>    |  do_notify_resume+0x60/0x12c
>>>    |  el0_svc+0x64/0x68
>>>    |  el0t_64_sync_handler+0x84/0xfc
>>>    |  el0t_64_sync+0x190/0x194
>>>    | Code: b9000909 d503201f 2a1f03e1 52800028 (88e17c08)
>>>
>>> Practically speaking, this is a non-issue as xa_store() can't fail, absent
>>> a nasty kernel bug.  But the code is visually jarring and technically
>>> broken.
>>>
>>> This reverts commit afb2acb2e3a32e4d56f7fbd819769b98ed1b7520.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Michal Luczaj <mhal@rbox.co>
>>> Cc: Alexander Potapenko <glider@google.com>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Reported-by: Will Deacon <will@kernel.org>
>>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>>> ---
>>>    virt/kvm/kvm_main.c | 14 +++++---------
>>>    1 file changed, 5 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>> index fca9f74e9544..f081839521ef 100644
>>> --- a/virt/kvm/kvm_main.c
>>> +++ b/virt/kvm/kvm_main.c
>>> @@ -4283,7 +4283,8 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
>>>    	}
>>>    	vcpu->vcpu_idx = atomic_read(&kvm->online_vcpus);
>>> -	r = xa_reserve(&kvm->vcpu_array, vcpu->vcpu_idx, GFP_KERNEL_ACCOUNT);
>>> +	r = xa_insert(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCOUNT);
>>> +	BUG_ON(r == -EBUSY);
>>>    	if (r)
>>>    		goto unlock_vcpu_destroy;
>>> @@ -4298,12 +4299,7 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, unsigned long id)
>>>    	kvm_get_kvm(kvm);
>>>    	r = create_vcpu_fd(vcpu);
>>>    	if (r < 0)
>>> -		goto kvm_put_xa_release;
>>> -
>>> -	if (KVM_BUG_ON(xa_store(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, 0), kvm)) {
>>> -		r = -EINVAL;
>>> -		goto kvm_put_xa_release;
>>> -	}
>>> +		goto kvm_put_xa_erase;
>>
>> I also find it a bit jarring though that we have to undo the insertion. This
>> is a chicken-and-egg situation where you are pick one operation B that will
>> have to undo operation A if it fails.  But what xa_store is doing, is
>> breaking this deadlock.
>>
>> The code is a bit longer, sure, but I don't see the point in complicating
>> the vcpu_array invariants and letting an entry disappear.
> 
> But we only need one rule: vcpu_array[x] is valid if and only if 'x' is less than
> online_vcpus.  And that rule is necessary regardless of whether or not vcpu_array[x]
> is filled before success is guaranteed.

Even if the invariant is explainable I still find xa_erase to be uglier 
than xa_release, but maybe it's just me.

The reason I'm not fully convinced by the explanation is that...

> I'm not concerned about the code length, it's that we need to do _something_ if
> xa_store() fails.  Yeah, it should never happen, but knowingly doing nothing feels
> all kinds of wrong.

... it seems to me that this is not just an issue in KVM code; it should 
apply to other uses of xa_reserve()/xa_store() as well.  If xa_store() 
fails after xa_reserve(), you're pretty much using the xarray API 
incorrectly... and then, just make it a BUG()?  I know that BUG() is 
frowned upon, but if the API causes invalid memory accesses when used 
incorrectly, one might as well fail as early as possible and before the 
invalid memory access becomes exploitable.

> I don't like BUG(), because it's obviously very doable to
> gracefully handle failure.

Yes, you can by using a different API.  But the point is that in the 
reserve/store case the insert failure becomes a reserve failure, never a 
store failure.

Maybe there should be an xa_store_reserved() that BUGs on failure, I 
don't know.

Paolo


