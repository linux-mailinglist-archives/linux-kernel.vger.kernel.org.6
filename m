Return-Path: <linux-kernel+bounces-544069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBACA4DD0D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537DB3A5331
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874662045A1;
	Tue,  4 Mar 2025 11:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2En/zUd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B66204090
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089116; cv=none; b=kj+tJT5wA8CaR7zSkrsygXedvPK3WwEDw8+UtLf/ZewPKWrdwte9PwCItbft7yl2e4QjGkSD/c6LfBfSHkIjFOJOQeYMxOaaLCln23NJzXNzhNfXzjTfbJFGWjOr/wmUXX7JHGM0Sol3xLxJvAKXOlsdU90cwn5XIL/pGmrS6Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089116; c=relaxed/simple;
	bh=yWbmFnDDcW7+/qnqF0tm/sx+AWkJjTYVTQwvn5TuuzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+yCtWyh1sXkR2sRe64FW/s6R3/sj3VqUpcmq9DyXEoGnh/kkrH+BDP2xBUAmWP96exX1uyzedPhS7ViAppNggAkGUBMfYw1nsk9fVXb3O/TWU/PM8ZjITvcY25gdNpB8Pi2CAmnMTIJBFP9hpvavPimPxjm2elYcIZLe9uivMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2En/zUd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741089114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9SvHiAzkhpGOwKIBXJW3ZvTlN3vuL1LXpAI2oO3MJds=;
	b=G2En/zUdshs9KSPmb0UdbXwBt61Fw1+JKcil/1ULflWaud2idU2isoWHu2B3oZEjiayhPF
	xno0vFOVmyU6iTfr4P/ZBDzeDRV50FHkHY5c4n/K+1Bcu7bEl/QSzxdCUY6LnQfpl09VrU
	Yp9EGOKOocFb4cBJe3v1XqLq0QcCdTM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-BYoUoPQWNjix1nMPyStJKA-1; Tue, 04 Mar 2025 06:51:37 -0500
X-MC-Unique: BYoUoPQWNjix1nMPyStJKA-1
X-Mimecast-MFC-AGG-ID: BYoUoPQWNjix1nMPyStJKA_1741089095
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22349ce68a9so31229625ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:51:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089095; x=1741693895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SvHiAzkhpGOwKIBXJW3ZvTlN3vuL1LXpAI2oO3MJds=;
        b=bkxghrvzIIP4w3i2L7Aknv260xoewPHTkwBEh1jMJcuPStz2lz6OCgLakkWgdpih9p
         IhqR00CS6fA4J2N0DZblOHymJl4C/qDT7dN3s+2E6xSJ0xVoPekFQ5T+vqCTJLSFGEDE
         u5+LqLjsNQMWkSXIxeYUQkm++n76USEXXOpRmI7/c0NNhPHWCR3edTdM8JgLut0VUpP7
         rjYTUSLH2euetxjxvGwbLjAFuw8Ygj9PxO71++JKgfX1naWeusIk4GVWPcOuXw7QZWul
         8DJrRTFSgqxXQrtBIO6USjYcZQ9SNGDEhKO+sdVMBgdOeUGpeiYxILrc6aLnwfMVG7am
         bcvw==
X-Forwarded-Encrypted: i=1; AJvYcCUXssTBqid+KIBZQmVfXHnpZxQF5khoqiKRe2jgP46nTifqWBVQEorl1+OPuCC975Z+nTKQ5rIxF8Lxw2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2G95hVFfyCpwFzWewNYMZWGvmvJgbq5c2h8TJ6laG/HB1duSo
	mkF2BFny5XeUKexGXm2ZL1eQakGgcxgGMrH8soIIHvMt2z7Hu2nkYbzUWJp+m8taPoDC+0155Gv
	7GNsVVKMwjYEQOLGgsjGwOAwGnMfNqKdHT2tNGaAPfds7cgrId7Bcz5vtmmUBQQ==
X-Gm-Gg: ASbGnct1eQX1qiogbtm9b5PpHX7A2YFeDhkxT/CG0UIq6uFYZFT5W3Pahw41afUEPz1
	bRJrbbThGc5JbMvoAV4jq17oqX4MwbTvQuVv9Qx3y4sNgBTQF/NWRyA7zUnZ9KTekEUvyrbsscS
	K8r9SRNVX7RWkS2QLV2FVQNDlB6PWzM/Ih0dAFOOAvYQPSK7g7G76jvioDE8JaZgIMZ/Vn0RNhh
	CSp9/w8cumvYFkMO+9bp1oOKi3gKRjClxILXoMLS3kzON6ZWiJQveLd+wMpH0ameVG5j17UeZKb
	5Qa+rBPyFnhC7xIeDQ==
X-Received: by 2002:a17:902:d48f:b0:220:c164:6ee1 with SMTP id d9443c01a7336-2236924786cmr286757035ad.32.1741089095307;
        Tue, 04 Mar 2025 03:51:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqkDc//0lhtuEEGTLRirsOl+2zU34lz3XcWjEj6faC+59ETLrTC0850jV9RLUFK6Nc4S9jqg==
X-Received: by 2002:a17:902:d48f:b0:220:c164:6ee1 with SMTP id d9443c01a7336-2236924786cmr286756495ad.32.1741089094965;
        Tue, 04 Mar 2025 03:51:34 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235052beaasm93466525ad.233.2025.03.04.03.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 03:51:34 -0800 (PST)
Message-ID: <32a09a27-f131-44dd-8959-abb63b2089a8@redhat.com>
Date: Tue, 4 Mar 2025 21:51:26 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 34/45] kvm: rme: Hide KVM_CAP_READONLY_MEM for realm
 guests
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-35-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-35-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:14 AM, Steven Price wrote:
> For protected memory read only isn't supported. While it may be possible
> to support read only for unprotected memory, this isn't supported at the
> present time.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   arch/arm64/kvm/arm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

It's worthy to explain why KVM_CAP_READONLY_MEM isn't supported and its
negative impact. It's something to be done in the future if I'm correct.

 From QEMU's perspective, all ROM data, which is populated by it, can
be written. It conflicts to the natural limit: all ROM data should be
read-only.

QEMU
====
rom_add_blob
   rom_set_mr
     memory_region_set_readonly
       memory_region_transaction_commit
         kvm_region_commit
           kvm_set_phys_mem
             kvm_mem_flags                                    // flag KVM_MEM_READONLY is missed
             kvm_set_user_memory_region
               kvm_vm_ioctl(KVM_SET_USER_MEMORY_REGION2)

non-secure host
===============
rec_exit_sync_dabt
   kvm_handle_guest_abort
     user_mem_abort
       __kvm_faultin_pfn					   // writable == true
         realm_map_ipa
           WARN_ON(!(prot & KVM_PGTABLE_PROT_W)

non-secure host
===============
kvm_realm_enable_cap(KVM_CAP_ARM_RME_POPULATE_REALM)
   kvm_populate_realm
     __kvm_faultin_pfn					  // writable == true
       realm_create_protected_data_page

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 1f3674e95f03..0f1d65f87e2b 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -348,7 +348,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_ONE_REG:
>   	case KVM_CAP_ARM_PSCI:
>   	case KVM_CAP_ARM_PSCI_0_2:
> -	case KVM_CAP_READONLY_MEM:
>   	case KVM_CAP_MP_STATE:
>   	case KVM_CAP_IMMEDIATE_EXIT:
>   	case KVM_CAP_VCPU_EVENTS:
> @@ -362,6 +361,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_COUNTER_OFFSET:
>   		r = 1;
>   		break;
> +	case KVM_CAP_READONLY_MEM:
>   	case KVM_CAP_SET_GUEST_DEBUG:
>   		r = !kvm_is_realm(kvm);
>   		break;

Thanks,
Gavin


