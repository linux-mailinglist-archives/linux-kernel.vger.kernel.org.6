Return-Path: <linux-kernel+bounces-252810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BB7931855
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BD61F21294
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2A21B947;
	Mon, 15 Jul 2024 16:17:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C521C2A3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060256; cv=none; b=ZOw2YqxQ6CP2Mr9fcC9LYsXeOMjI+vXbPboVrL46qB5eupAZPwpQSNVi9h+sNx1zQZNmsT49PZZgTRDobC6zVnZ1Y+SOJ7gy53T/G/ujYRKRcLX7bjbPzM7inkJMRZ0igHP3IzbnhuqDRL3VecZVBlbSJnOvnESdiL8P2J7ZuB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060256; c=relaxed/simple;
	bh=I1uJmAu/OaDH6oiwCqrugP0uBD0PbgiejHqVIh23Zx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAexhPSLdryQfxrc5OzGH98ATN9kWeztm6+I2SKbLioQLxHZCek5/2UJTL/KoANhK0lwHtu2tzeXkw16RbFi7KbFd5IFyTI7ApRv6H/plLktU2qfcath4ChjDlKGfbIPwkPMiFaRYXSo1tPo/qfqkoflT6fou0RE2gbMkzDA8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE67CFEC;
	Mon, 15 Jul 2024 09:17:58 -0700 (PDT)
Received: from [10.57.77.136] (unknown [10.57.77.136])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7D653F73F;
	Mon, 15 Jul 2024 09:17:30 -0700 (PDT)
Message-ID: <98eb5fef-8bf2-4d9d-b1a0-ef8d3c2c6ab7@arm.com>
Date: Mon, 15 Jul 2024 17:17:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/huge_memory: Avoid PMD-size page cache if needed
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Gavin Shan <gshan@redhat.com>,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 willy@infradead.org, baohua@kernel.org, peterx@redhat.com, ziy@nvidia.com,
 william.kucharski@oracle.com, baolin.wang@linux.alibaba.com,
 ddutile@redhat.com, shan.gavin@gmail.com
References: <20240715000423.316491-1-gshan@redhat.com>
 <ea673fe9-beed-43fd-9a54-c683b0c800ce@arm.com>
 <2c3a5213-ca64-48fb-845a-78aae3e8f15f@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2c3a5213-ca64-48fb-845a-78aae3e8f15f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/07/2024 17:13, David Hildenbrand wrote:
> On 15.07.24 12:41, Ryan Roberts wrote:
>> [...]
>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 2aa986a5cd1b..c73ad77fa33d 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -72,14 +72,20 @@ extern struct kobj_attribute shmem_enabled_attr;
>>>   #define THP_ORDERS_ALL_ANON    ((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(1)))
>>>     /*
>>> - * Mask of all large folio orders supported for file THP.
>>> + * Mask of all large folio orders supported for file THP. Folios in a DAX
>>> + * file is never split and the MAX_PAGECACHE_ORDER limit does not apply to
>>> + * it.
>>>    */
>>> -#define THP_ORDERS_ALL_FILE    (BIT(PMD_ORDER) | BIT(PUD_ORDER))
>>> +#define THP_ORDERS_ALL_FILE_DAX        \
>>> +    (BIT(PMD_ORDER) | BIT(PUD_ORDER))
>>
>> Appologies if this was already discussed, but if changing _FILE_DEFAULT to
>> advertise all orders 1-MAX_PAGECACHE_ORDER, shouldn't we also change _FILE_DAX
>> to advertise all orders 1-PUD_ORDER ? Or is DAX literally limited to PTE/PMD/PUD?
> 
> It's limited to that.
> 
> IIUC, it's simply some physical memory area that can be interpreted as small
> folios, PMD-sized folios or PUD-sized folios, and someone (fsdax?) makes the
> decision "how" it is interpreted/setup these folios.
> 
> These folios can only be mapped entirely (single PMD/PUD) or via PTEs, so
> PMD_ORDER+PUD_ORDER is correct.

OK got it. In that case:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> 
> Thanks Gavin!
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 


