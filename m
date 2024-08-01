Return-Path: <linux-kernel+bounces-270900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE9C9446CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1671F2526E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174E316EB54;
	Thu,  1 Aug 2024 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUJsQAsl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A269B16E87D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501732; cv=none; b=E0yDkUYYm1H+fxmgvQdHRG3ISluoNsocvoMuWbZpB1TVXYEe03xXCe+OG3EO1pRpJHN7KLpvaCTthkD6JRfXblpKrsvAe1oFBb9MrRyWDsRpSfaGc0OpSD2q0V1DQR7CN/eyGfNFDlLpuHgK9PzbUn5vCVz/0Lw9A2wO67VYW8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501732; c=relaxed/simple;
	bh=jpLHtKJrpleUll3YJJmgsTSqdK54vV3K6J5Ec0lFWIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uc9yyK41KSyjn+meerRW/EaS8TM99EIlYZaWotNVl164HbVG+7DOuofWHpdmwnvGNA5OPXH9o3NIOZ55Vo6kCAW3BrQjtC9AapTO+6zlSgiNr+fgsxr1LoymowyaTv8BtMwledB57+sT05AXZuUaQJcLLIZYZnwu4184WB2A9gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUJsQAsl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722501729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/oAZCrKkIwmTZw2CVNzqY04RpgZ4DIAq4doUcO9qgpg=;
	b=TUJsQAslp3XXBVg/4Jgz2V3G6Bno+wKxJagknz1qnZbsyH4wo22+t0teFGvZtljemd1ipQ
	CwNM+1TBHJ1H8Wv9cTL1p1n94FQ1nHPItBBpTHhEG12WfEJem5C5oU3/pjMDV5VFoPr6O7
	tAH3jN2w88cEOmxC53W2p4WC5PQFCuU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-aVFGvEbDP127lyPFp3rRHg-1; Thu, 01 Aug 2024 04:42:08 -0400
X-MC-Unique: aVFGvEbDP127lyPFp3rRHg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-36848f30d39so3152402f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501727; x=1723106527;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/oAZCrKkIwmTZw2CVNzqY04RpgZ4DIAq4doUcO9qgpg=;
        b=Ln+hWAIFtsryw01JdXOW0NRsg3jnPXDCb4thlxhH4xPrQwxkxIxK8++dKq7hPklttv
         JDaohPrcPyu5DmVH28jLHcaqKBgeufDeB+liraR5g+lGycFn4/L2qVBaXpcNRFeuIbpL
         hr5TXsN+hTM/x27d+1MGAZXhp/ArbgqEnGKFzdf5ItD4Y6NfaUf1rasMigarKQFmoKkx
         OPWQkYgSdOxm6nPlfdQALSOlx9z1HL8gCKnFgm1ozPVauACsNqT5DjRtrShmAfK5oSeq
         DmUua8/wtgs+2aSHJKB1BvxV/Dx9rRt0xpu4RTLSG+uasGfNMFUxS7qAxGNuSsnvLJ9b
         CRRA==
X-Forwarded-Encrypted: i=1; AJvYcCU4aYwAGNaEGV6GNIfdwh0C02aZBTgVIq+USiQK9JgzLySzECTFPRaJ7KP6ZF4ULLDhEbwfjUlkJgwTHd2JMkEuDTkkmbySDPqO7qcC
X-Gm-Message-State: AOJu0YyouopfklOCj9LMO5/0+VSwuyidc/QYy9lJB9TqGHTPvE0TuED9
	ft/kdK+NHy+tkF7T9jOlyfaJLQTc6w343z+2EfElkeqQ8uhvtQYIw2RspmMdU8gzfmfWZ7Scw2P
	YB7c0/zEyErf8W2+sP4Qoty3bYDYMi1bK6CzezC0pDY5dWbj8vgOf9JbAvXcsSA==
X-Received: by 2002:a5d:4310:0:b0:368:4bc0:9211 with SMTP id ffacd0b85a97d-36baacd28e2mr1009069f8f.17.1722501727016;
        Thu, 01 Aug 2024 01:42:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2tzq5/hLz8rhEYo6kAcqv/nyYlmfGuSogtt0IkUkByA/xBYlRUXJRNp0brk6N0ZR11DPGsQ==
X-Received: by 2002:a5d:4310:0:b0:368:4bc0:9211 with SMTP id ffacd0b85a97d-36baacd28e2mr1009055f8f.17.1722501726455;
        Thu, 01 Aug 2024 01:42:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fce64sm18847318f8f.61.2024.08.01.01.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 01:42:06 -0700 (PDT)
Message-ID: <3b82e195-5871-4880-9ce5-d01bb751f471@redhat.com>
Date: Thu, 1 Aug 2024 10:42:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Race condition observed between page migration and page fault
 handling on arm64 machines
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 willy@infradead.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240801081657.1386743-1-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240801081657.1386743-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.08.24 10:16, Dev Jain wrote:
> I and Ryan had a discussion and we thought it would be best to get feedback
> from the community.
> 
> The migration mm selftest currently fails on arm64 for shared anon mappings,
> due to the following race:

Do you mean MAP_SHARED|MAP_ANON or MAP_PRIVATE|MAP_ANON_fork? Because 
you note shmem below, I assume you mean MAP_SHARED|MAP_ANON

> 
> Migration:						Page fault:
> try_to_migrate_one():					handle_pte_fault():
> 1. Nuke the PTE						PTE has been deleted => do_pte_missing()
> 2. Mark the PTE for migration				PTE has not been deleted but is just not "present" => do_swap_page()
>

In filemap_fault_recheck_pte_none() we recheck under PTL to make sure 
that a temporary pte_none() really was persistent pte_none() and not a 
temporary pte_none() under PTL.

Should we do something similar in do_fault()? I see that we already do 
something like that on the "!vma->vm_ops->fault" path.

But of course, there is a tradeoff between letting migration 
(temporarily) fail and grabbing the PTL during page faults.

-- 
Cheers,

David / dhildenb


