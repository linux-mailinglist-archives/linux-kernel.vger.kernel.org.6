Return-Path: <linux-kernel+bounces-558812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A39EAA5EB87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC73018944E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 06:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E039E1FAC57;
	Thu, 13 Mar 2025 06:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6pq+CI1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C91F9F72
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846204; cv=none; b=Hl1uRCIAQz8st0gvvMTbLw+irz8/4pSGAlMhzK78p7J8UVCZvpkjZxXRD+yZr6KWk3NS4eYEevf2TC2ZPX1EFppjT4R8TIzXcWBIlojnUGxFfz2bMVHwejLqqmhjqoc96WXjv9tfvMNbwEtKfRRpUIQCADMEizf+FbKRjudsDic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846204; c=relaxed/simple;
	bh=epheoX7sjBBeNLQYhjvA1n4fUP7DKzJ46vLVpbCOOe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+g9JHKd2omTRAj/XCNJzLPVfdvkNu5bDKALpMHuWWyNFPfdiSNz7ZLrG6rkLQeqVu4PVDTNSrrvz9mlgB0ibBYNRCd6+3afB2EIeq0MnRGrc/hb2Skp6XE7gab9Uo49ExpWdalHlb/xrDB4V2HKPqsCaXCSLvrMERwx91Hq4L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6pq+CI1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741846201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ccm3JgzdOSGH62qHobc9OF3iYrGg3m8/wnqVF4zJglU=;
	b=Z6pq+CI1j2uZofQ53dpRXG5XBq024e57JhDvLzaR1Bn+snNUmAyD9PItM5x4GZZhPvrq5Z
	JPEelAkd4/5Vw8wfRmIN4NOBKHEBrJLqThw/Cex9kivMch60Z8IPIA05QmxyVGtBqfeVhg
	K+K8he1Vjq5/tn700wGEsqdCt99Y1uc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-_ogULkgTNjC-FYyE7k_jaA-1; Thu, 13 Mar 2025 02:09:59 -0400
X-MC-Unique: _ogULkgTNjC-FYyE7k_jaA-1
X-Mimecast-MFC-AGG-ID: _ogULkgTNjC-FYyE7k_jaA_1741846198
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-224192ff68bso10621705ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 23:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741846198; x=1742450998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ccm3JgzdOSGH62qHobc9OF3iYrGg3m8/wnqVF4zJglU=;
        b=UzVgtAcPmxLqhv5FG2xIKR8JdnjVHqfmZZS/GJNv0ETwdOA9S0+z5p+9+ynsfvbrKN
         XQ0LFWYkFmCv5mmxTiUq0A89tgvuRObLDbLjbJoVo4Zz39Yge/OwqFEVnyUeudHcJ+aq
         6xgIZ0iHAWNrCLvVDPMVccmg9GMBcDahWnTT9hmH7wuvrO7s/ihfmNfgCbADoo3ql05Q
         T2Z1vAtY0f4Rd8TPk6ZVkXb+JK+b1D6YtmRLZpVuGUe6zyeYdp5fnDQw66B2+W1s/e2d
         pf+lxYM2d+yux+Axt/OZ4Lh4VwwqKakSiNvDp8qWgwNy4ndnOnq5ts5HGA/Y0+Y4Er1w
         cdPg==
X-Forwarded-Encrypted: i=1; AJvYcCXKy9yLmZtSQIEo0kCk8nj98pPQ3MTU83g+BErfuLNoaGAo1+yceodOad3JwoeyHgYWwvwrPdyI3V52zow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbF5hAwNu8gF/Vj5E9g6/p+b9PkFGXxnBIG46g7pa2SXJFcKC
	bUIEJ3OQknMZwKcde0dzJVsc+L6KGykklEf+if8RvAXRfc4QTycL3tTiKH9OqEnHgsgl+JtFjDR
	Ra9R80a1ih+DSTEvmMRcPkbe6l1V3YN0o1XQjCQoibWeOv6FEntMF9kjhXSYGwA==
X-Gm-Gg: ASbGncswBjbyuiTFkTlZ/lZsUiogcEMXZw/chphn2vx/Bmc7lYA9grC0HtKgZ8325iU
	IHEOHjW0xNN+Nh+ylFJzEJkMOibs4T/tNu9xfbzBqwoiozam4rphzBNPWnTkQduEJspEJ2RnV4H
	vBKCAik5LArbTa3arpuTGIof6XYpu3kJX6AR5YdoHTbHaNXOhTK2zNq8T2TtttKxuqgJq2/5Xf/
	RNfGhbSwPbyy1s5O30obNeNngLv3+GtTZVM1rcUBvkVoKZmb7Mg7ttvA6uT9L4hK+45250e2Kjk
	xzNtdFPniqkOL6MXBg==
X-Received: by 2002:a17:902:d488:b0:223:3ef1:a30a with SMTP id d9443c01a7336-225931ad489mr119271325ad.45.1741846198236;
        Wed, 12 Mar 2025 23:09:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS/0CiPnvYXrr/SnOgpCHMu4/dKvSfoPKfZt54v9+3wLfVsHrnCrsLrPLUwz74zt1y5GmQxA==
X-Received: by 2002:a17:902:d488:b0:223:3ef1:a30a with SMTP id d9443c01a7336-225931ad489mr119271035ad.45.1741846197900;
        Wed, 12 Mar 2025 23:09:57 -0700 (PDT)
Received: from [192.168.68.55] ([180.233.125.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a403fsm5710305ad.61.2025.03.12.23.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 23:09:57 -0700 (PDT)
Message-ID: <88c66ec3-5b03-4488-9733-ae917cbc0536@redhat.com>
Date: Thu, 13 Mar 2025 16:09:51 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: arm64: Drop sort_memblock_regions()
To: Anshuman Khandual <anshuman.khandual@arm.com>, kvmarm@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 qperret@google.com, maz@kernel.org, oliver.upton@linux.dev,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
References: <20250311043718.91004-1-gshan@redhat.com>
 <34b8242b-529b-4ad5-ac17-e1200965ae1d@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <34b8242b-529b-4ad5-ac17-e1200965ae1d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/25 12:53 PM, Anshuman Khandual wrote:
> On 3/11/25 10:07, Gavin Shan wrote:
>> Drop sort_memblock_regions() and avoid sorting the copied memory
>> regions to be ascending order on their base addresses, because the
>> source memory regions should have been sorted correctly when they
>> are added by memblock_add() or its variants.
>>
>> This is generally reverting commit a14307f5310c ("KVM: arm64: Sort
>> the hypervisor memblocks"). No functional changes intended.
> 
> Just wondering what prompted this change ?
> 

I found the unnecessary sorting by code inspection. Hope there is nothing I
missed and it's why Quentin Perret has been copied, to confirm it. Commit
a14307f5310c was introduced by the initial series [1/2] to support pKVM.

[1] https://lore.kernel.org/kvmarm/20201117181607.1761516-1-qperret@google.com/
[2] https://lore.kernel.org/all/20210319100146.1149909-1-qperret@google.com/

Thanks,
Gavin

>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/pkvm.c | 19 -------------------
>>   1 file changed, 19 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
>> index 930b677eb9b0..d9c9174f89a1 100644
>> --- a/arch/arm64/kvm/pkvm.c
>> +++ b/arch/arm64/kvm/pkvm.c
>> @@ -10,7 +10,6 @@
>>   #include <asm/kvm_mmu.h>
>>   #include <linux/memblock.h>
>>   #include <linux/mutex.h>
>> -#include <linux/sort.h>
>>   
>>   #include <asm/kvm_pkvm.h>
>>   
>> @@ -24,23 +23,6 @@ static unsigned int *hyp_memblock_nr_ptr = &kvm_nvhe_sym(hyp_memblock_nr);
>>   phys_addr_t hyp_mem_base;
>>   phys_addr_t hyp_mem_size;
>>   
>> -static int cmp_hyp_memblock(const void *p1, const void *p2)
>> -{
>> -	const struct memblock_region *r1 = p1;
>> -	const struct memblock_region *r2 = p2;
>> -
>> -	return r1->base < r2->base ? -1 : (r1->base > r2->base);
>> -}
>> -
>> -static void __init sort_memblock_regions(void)
>> -{
>> -	sort(hyp_memory,
>> -	     *hyp_memblock_nr_ptr,
>> -	     sizeof(struct memblock_region),
>> -	     cmp_hyp_memblock,
>> -	     NULL);
>> -}
>> -
>>   static int __init register_memblock_regions(void)
>>   {
>>   	struct memblock_region *reg;
>> @@ -52,7 +34,6 @@ static int __init register_memblock_regions(void)
>>   		hyp_memory[*hyp_memblock_nr_ptr] = *reg;
>>   		(*hyp_memblock_nr_ptr)++;
>>   	}
>> -	sort_memblock_regions();
>>   
>>   	return 0;
>>   }
> 


