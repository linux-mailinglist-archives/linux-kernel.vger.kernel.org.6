Return-Path: <linux-kernel+bounces-541904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849BBA4C338
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F129166CA2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1746F213E75;
	Mon,  3 Mar 2025 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPXfH+av"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B528BEE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011490; cv=none; b=lzzuQbF1ZQAi5RbmvmA726enOH7NiBfONfjQN7F67tDpMDpN7Mr8jemcRk8rPDA+9jtpdHbmFxSqU6Z922raDkgOnWsef0KJ2/MY4AL/gvKZo6F4AzT1IIr1HbQyE4E1ngWUu+xdxYs0zMd3o4I0o5g2YBArfFDASo93l9xRGTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011490; c=relaxed/simple;
	bh=BUM9ttkYbtJjW3C8zKc+o016L2T9uUvJDr+BTba3W78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IyYZ4WOMraYco0nQXkzV6JlCBmkWF0Sk4C3kQaqP5zGelF5XeFCmkwEW0Qwzo3XLGmpqQxHJVeH2bTQfGX3GV9g8DVCcDxNHd7Qy6j4AaIsjyPGeCSo1sTg6ftBw2jlowG3jqkgIzVi5LMsHFQqh28zhxEMzch+CEXHaFLW7gXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RPXfH+av; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741011487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wpjej3MTc3XOacT0vWjYbsIvrY+TVNTNDbp8vW97joQ=;
	b=RPXfH+avcTLpFxWF4e1qF7NV2LeVylzeYlTFWAqxgW9tqUQ6RPBFilaVWnRMX/8/txqONQ
	FQFdPkZVJCXFAgAcPtstM55N43HyfgiT2fpRt8JnupjwerdwMsSkSmg96kwZfrYRvjHXdR
	zJGiZnm1+VEdJl5841vawB2CyPOe/08=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-QKQhFV3KNtOZgp_D0dCTfA-1; Mon, 03 Mar 2025 09:17:56 -0500
X-MC-Unique: QKQhFV3KNtOZgp_D0dCTfA-1
X-Mimecast-MFC-AGG-ID: QKQhFV3KNtOZgp_D0dCTfA_1741011476
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8a1eb7148so65359386d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 06:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741011476; x=1741616276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wpjej3MTc3XOacT0vWjYbsIvrY+TVNTNDbp8vW97joQ=;
        b=hW9fqMfOgQFAcSKKpmhrDxhfDHjwAbWKC7+TLXLXZveHAqiJtcPnYsoAYovBGCct32
         /18RVtTwA79wiPT9ZT3r0vX12Ule5BMGJ88+j1hhdHzFyL6EutmNuriLEYUngK4aqt1j
         bTSU3mNDx55f3rgjvwuyggBN15Q+q8497yCrsWwGKFZlvDfnqQ01nKxePKKSWkzlAuhI
         SmZgRsGx/S1Hcnr/Mf8Z0mlZ6TkMhEgGyzwvy862DI47XGwAEem08ErnOa4kAi8Z9/VJ
         iHb7XJlLO5hYEXeXBQXJepOL+SzUwOs5YEGZ5tTZPy9Vji/JoJEQyKsphKaNhLBzwWZC
         m6KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCp1zi6a++2COJ3WELpqf6ihlweHRPLjNjGPIgHfOiilRoWbXHKqo1eeXfCs/OU4IEQuKUKSEmzvLXGyY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl4bGMs2IGNBQMFufPfcp8Kk8bZubq0gzjYaTm+RVW1mVFRkf6
	OGzkFi7RsRtu7lFv3fojeMF9SHyJjaJdzDFNX7TxL4FxoDnIySS3d6e+EGXHRAFOxrgkihQxFqX
	EIgISrGU+GyDgc0EcdinK/VdmSLQcEb3hmzy6tLL3wcsrKxRpqWI6xbXgVS591w==
X-Gm-Gg: ASbGncuqNcI8HH+JwIXbWk6c//OrXz7jRCuNRlFBXsI3UDtMn+jdQSXi4sDy05D+AZw
	BcQqnREcwrr1/wPC/iBLf+H+2Vd5J/5tYdHhT5znzl+ec0vgkG1pRKbKuAACMF8GLh3Hb3gF7ss
	eRO4xhCHvMUnRAQHjb4e2PlCWftSwqIcEenLVgMr+SZzIZbNYNUTCRlzoC0H9NCw+tdQTrolWqp
	M9FWojrvz2A+mIU0j5aacm2xos38KqIC/DlzzI4s3mqGaaBQ8T+wkDhxpUUoPcR/KDWYA1w3U/n
	n2mSiC8rQVKi/EoV
X-Received: by 2002:ad4:596c:0:b0:6e4:4012:b6f1 with SMTP id 6a1803df08f44-6e8a0c87aadmr199731266d6.3.1741011475924;
        Mon, 03 Mar 2025 06:17:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmuW2YklpwiY35WaKDpDsU1ARThxbZZn04wnIPZGm7kflmoV5fmkgK0Cghft8CcoGbqMJqGg==
X-Received: by 2002:ad4:596c:0:b0:6e4:4012:b6f1 with SMTP id 6a1803df08f44-6e8a0c87aadmr199730956d6.3.1741011475548;
        Mon, 03 Mar 2025 06:17:55 -0800 (PST)
Received: from [192.168.40.164] ([70.105.235.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e897661633sm53378136d6.58.2025.03.03.06.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:17:55 -0800 (PST)
Message-ID: <427fec88-2a74-471e-aeb6-a108ca8c4336@redhat.com>
Date: Mon, 3 Mar 2025 09:17:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Philipp Rudo <prudo@redhat.com>, Pingfan Liu <piliu@redhat.com>,
 Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <dhildenb@redhat.com>, Michal Hocko <mhocko@suse.cz>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <04904e86-5b5f-4aa1-a120-428dac119189@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/3/25 3:25 AM, David Hildenbrand wrote:
> On 20.02.25 17:48, Jiri Bohac wrote:
>> Hi,
>>
>> this series implements a way to reserve additional crash kernel
>> memory using CMA.
>>
>> Link to the v1 discussion:
>> https://lore.kernel.org/lkml/ZWD_fAPqEWkFlEkM@dwarf.suse.cz/
>> See below for the changes since v1 and how concerns from the
>> discussion have been addressed.
>>
>> Currently, all the memory for the crash kernel is not usable by
>> the 1st (production) kernel. It is also unmapped so that it can't
>> be corrupted by the fault that will eventually trigger the crash.
>> This makes sense for the memory actually used by the kexec-loaded
>> crash kernel image and initrd and the data prepared during the
>> load (vmcoreinfo, ...). However, the reserved space needs to be
>> much larger than that to provide enough run-time memory for the
>> crash kernel and the kdump userspace. Estimating the amount of
>> memory to reserve is difficult. Being too careful makes kdump
>> likely to end in OOM, being too generous takes even more memory
>> from the production system. Also, the reservation only allows
>> reserving a single contiguous block (or two with the "low"
>> suffix). I've seen systems where this fails because the physical
>> memory is fragmented.
>>
>> By reserving additional crashkernel memory from CMA, the main
>> crashkernel reservation can be just large enough to fit the
>> kernel and initrd image, minimizing the memory taken away from
>> the production system. Most of the run-time memory for the crash
>> kernel will be memory previously available to userspace in the
>> production system. As this memory is no longer wasted, the
>> reservation can be done with a generous margin, making kdump more
>> reliable. Kernel memory that we need to preserve for dumping is
>> never allocated from CMA. User data is typically not dumped by
>> makedumpfile. When dumping of user data is intended this new CMA
>> reservation cannot be used.
> 
> 
> Hi,
> 
> I'll note that your comment about "user space" is currently the case, but will likely not hold in the long run. The assumption you are making is that only user-space memory will be allocated from MIGRATE_CMA, which is not necessarily the case. Any movable allocation will end up in there.
> 
> Besides LRU folios (user space memory and the pagecache), we already support migration of some kernel allocations using the non-lru migration framework. Such allocations (which use __GFP_MOVABLE, see __SetPageMovable()) currently only include
> * memory balloon: pages we never want to dump either way
> * zsmalloc (->zpool): only used by zswap (-> compressed LRU pages)
> * z3fold (->zpool): only used by zswap (-> compressed LRU pages)
> 
> Just imagine if we support migration of other kernel allocations, such as user page tables. The dump would be missing important information.
> 
IOMMUFD is a near-term candidate for user page tables with multi-stage iommu support with going through upstream review atm.
Just saying, that David's case will be a norm in high-end VMs with performance-enhanced guest-driven iommu support (for GPUs).

> Once that happens, it will become a lot harder to judge whether CMA can be used or not. At least, the kernel could bail out/warn for these kernel configs.
> 
I don't think the aforementioned focus is to use CMA, but given its performance benefits, it won't take long to be the next perf improvement step taken.

>>
>> There are five patches in this series:
>>
>> The first adds a new ",cma" suffix to the recenly introduced generic
>> crashkernel parsing code. parse_crashkernel() takes one more
>> argument to store the cma reservation size.
>>
>> The second patch implements reserve_crashkernel_cma() which
>> performs the reservation. If the requested size is not available
>> in a single range, multiple smaller ranges will be reserved.
>>
>> The third patch updates Documentation/, explicitly mentioning the
>> potential DMA corruption of the CMA-reserved memory.
>>
>> The fourth patch adds a short delay before booting the kdump
>> kernel, allowing pending DMA transfers to finish.
> 
> 
> What does "short" mean? At least in theory, long-term pinning is forbidden for MIGRATE_CMA, so we should not have such pages mapped into an iommu where DMA can happily keep going on for quite a while.
> 
Hmmm, in the case I mentioned above, should there be a kexec hook in multi-stage IOMMU support for the hypervisor/VMM to invalidate/shut-off stage 2 mappings asap (a multi-microsecond process) so
DMA termination from VMs is stunted ?  is that already done today (due to 'simple', single-stage, device assignment in a VM)?

> But that assumes that our old kernel is not buggy, and doesn't end up mapping these pages into an IOMMU where DMA will just continue. I recall that DRM might currently be a problem, described here [1].
> 
> If kdump starts not working as expected in case our old kernel is buggy, doesn't that partially destroy the purpose of kdump (-> debug bugs in the old kernel)?
> 
> 
> [1] https://lore.kernel.org/all/Z6MV_Y9WRdlBYeRs@phenom.ffwll.local/T/#u
> 


