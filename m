Return-Path: <linux-kernel+bounces-286983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B302952121
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F2FCB2688F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38BA1BC9E9;
	Wed, 14 Aug 2024 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUDqD6s5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D601BC06F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656635; cv=none; b=TjojdbQF9jcuZm7zoj9EBLsfJm4olhYtn4bSeBX+TXpwGj/DXkEm1Gsc1/VOkTqP+IpTJmTkK87JcyxLmEGADaqyZe/KQpiFgY7cB13k64rtYJSmxIBg8blxicu6pwpXpJ0DtpjUdWFgkBWcugoBUdwWJ/kFR+90X4zOTpIq4G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656635; c=relaxed/simple;
	bh=tR9AIuV/Hih5/QoJ+aELl7/LQuQC0V96pOHO/uQVFUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfDNOhX9Q1cXXiY4w7Tb47vZB7SVS2VjWhb4rjGXjL52RmjDNpjBlq4/0/a4kNpYdQjsBphYNoDlkVioZWwz1yQgdhmfOn6nD8nmqAWHZvviUnGZePtO8ZKImjvC8YzbKAiT98UZbNnNFQQZiGXSxHBPRso7AyEIqPHY2AKCz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUDqD6s5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723656631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WLCgYy8Fvc6A9OrbKQo4qHfaKt/IrBD5tvAFVwH8lzg=;
	b=SUDqD6s50KnJphEY9ds6N1l1t1gFEFHycGQDBJnkfsDd3DWjVlpuklU1YmmrxeHDQaZCzh
	048qu88hvRy9wAWqt8SnD6yg0iRmj0R3y6ywbtF8Zd+VlGxY9MuedjLGDNEty1o4Jd45dy
	BWy56jvMKv5VH08Iyb5ol5a3SEym8ko=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-mlt1z4JdNn6vdbs6zhXr-g-1; Wed, 14 Aug 2024 13:30:30 -0400
X-MC-Unique: mlt1z4JdNn6vdbs6zhXr-g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428ea5b1479so316155e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723656629; x=1724261429;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WLCgYy8Fvc6A9OrbKQo4qHfaKt/IrBD5tvAFVwH8lzg=;
        b=OX1bRH3CJB4PfDoJR8v/lw/FUTzQI1NqVKtP6MFPkawnyi/c6n/JjCdrj8IKbKMD8h
         852N07GmIRELaB3F2TUtSjRlucwXvP3nRrcoOemATr7prCSkUjJSMRPI8r3kHImnqCiT
         N+WWL+vKg5kqY8PI9RgWeKqjSloDQy4+9gN89z98UVSQWgr/+uBG+abw23RDLtMptmE2
         KeyAvt28t5fuDHW8HXBnug71cLkc/lS7jrYvnyEZE6vn0FTewdtxc4nQ/keNYWtI7WMy
         w+a5k1bVQxEp45knqFrYPjBF4jTTQG1Eaxl2oT6olTq2AkI8Fnzv6vMfjuymBs7pJidk
         nTjw==
X-Forwarded-Encrypted: i=1; AJvYcCUlwZJVsPLebKxHm83cvY724sEPGzCEWVzLp6X4YcyemeuBlk3DI6CK2I3B6nwmlx4a+/4G9ZUlhIhIh2auYQA8+I+dbzxniYvBuXM+
X-Gm-Message-State: AOJu0Yy8qdkYt3pQWyyw6eQihmcOgSLxyJUhrDRqazR4/NINNIFV2s/L
	+408unWfvwuqf/7xmbhRxzbw39/9rDhk974lM4g6zGdtnHsCFm9j882cjtmkU0zQ+nFboMP3Tih
	Nv0uBvt3vXUjv6LKtnhlqo1RDvqIUdlTRetVJJtmqD2HLqj3n1NVmxwrxVjDvDA==
X-Received: by 2002:a05:600c:3143:b0:429:994:41a2 with SMTP id 5b1f17b1804b1-429dd22fea5mr25643735e9.7.1723656629174;
        Wed, 14 Aug 2024 10:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU2BfT2NwuJa2HNPFzoLk1vrbks6dJXAa8I957nKLn8O4it7LS6EYFj9dBGc7B9aDSvDn0lA==
X-Received: by 2002:a05:600c:3143:b0:429:994:41a2 with SMTP id 5b1f17b1804b1-429dd22fea5mr25643545e9.7.1723656628698;
        Wed, 14 Aug 2024 10:30:28 -0700 (PDT)
Received: from [192.168.10.47] ([151.95.101.29])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-429ded1e3f7sm26074525e9.4.2024.08.14.10.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 10:30:27 -0700 (PDT)
Message-ID: <e50240f9-a476-4ace-86aa-f2fd33fbe320@redhat.com>
Date: Wed, 14 Aug 2024 19:30:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/22] KVM: x86/mmu: Try "unprotect for retry" iff there
 are indirect SPs
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>,
 Vishal Annapurve <vannapurve@google.com>,
 Ackerly Tng <ackerleytng@google.com>
References: <20240809190319.1710470-1-seanjc@google.com>
 <20240809190319.1710470-10-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240809190319.1710470-10-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 21:03, Sean Christopherson wrote:
> Try to unprotect shadow pages if and only if indirect_shadow_pages is non-
> zero, i.e. iff there is at least one protected such shadow page.  Pre-
> checking indirect_shadow_pages avoids taking mmu_lock for write when the
> gfn is write-protected by a third party, i.e. not for KVM shadow paging,
> and in the *extremely* unlikely case that a different task has already
> unprotected the last shadow page.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/mmu/mmu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 09a42dc1fe5a..358294889baa 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2736,6 +2736,9 @@ bool kvm_mmu_unprotect_gfn_and_retry(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa)
>   	gpa_t gpa = cr2_or_gpa;
>   	bool r;
>   
> +	if (!vcpu->kvm->arch.indirect_shadow_pages)
> +		return false;

indirect_shadow_pages is accessed without a lock, so here please add a 
note that, while it may be stale, a false negative will only cause KVM 
to skip the "unprotect and retry" optimization.  (This is preexisting in 
reexecute_instruction() and goes away in patch 18, if I'm pre-reading 
that part of the series correctly).

Bonus points for opportunistically adding a READ_ONCE() here and in 
kvm_mmu_track_write().

Paolo

>   	if (!vcpu->arch.mmu->root_role.direct)
>   		gpa = kvm_mmu_gva_to_gpa_write(vcpu, cr2_or_gpa, NULL);
>   


