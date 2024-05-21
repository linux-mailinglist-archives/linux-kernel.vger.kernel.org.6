Return-Path: <linux-kernel+bounces-185170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A2D8CB182
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FD57B23F61
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A24E1474C6;
	Tue, 21 May 2024 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="1PDxK98a"
Received: from out0-217.mail.aliyun.com (out0-217.mail.aliyun.com [140.205.0.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0414535F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305825; cv=none; b=OgSrBi/sWwvAsMqxmzzNWWFagd/f2VmiZkczUMkkaVOGG9jTdjlaa8kjVPav0915DBDLG+eQZ+T6XXjsqMS0uPZc3AzX9fDbE7oox3TMiXpPxZ/N+kKD/bO40WBxAMfKiD/VewhfK5H+TYBu+ZkEOAog4wUCFX2ZH47x1WVUFss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305825; c=relaxed/simple;
	bh=7cMYQjWrFB8NyPN7IxbC0FNw72IWwl12mZnaAWXxAHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToGjCm+hhNa5SR6t10U03UREMCfqNbwOmEhbMpHpotbCW1ReXGbqTnoIm/Ljattxxi4gWvk9N/iBPg+WyZHwb2tBWjyKqVPu4MbfV83AwT/SPzAnQB2klPtBX/FglL39itEYyRPtJE6EKRsrRXFN1tXBk+i8LkLnDBHTJQL299w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=1PDxK98a; arc=none smtp.client-ip=140.205.0.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716305815; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0F8utKmHBsqT5aaZ1shtTgjkR7zRzQ1wD7Atj7HfE5s=;
	b=1PDxK98ajQsWd/viW0gggAq08f+ifUj2FceeJqLSs6nXi9MYzV7VPNV2Xk9K12oxMUybl/GA+3vakqhG03qn7nKdVet9x3d0hHzLCDRhuWiC6UUebIWMacK+eYVsAJPFBDajnhr0FHKUcbAuLKmkt0cFS3VN1292lk/1uyNsYPU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033038033188;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---.XjOK43f_1716305812;
Received: from 30.236.49.195(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XjOK43f_1716305812)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 23:36:53 +0800
Message-ID: <7d00705a-8a6b-48a5-8aba-7e789c536e2e@antgroup.com>
Date: Tue, 21 May 2024 23:36:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mm: Refactor update_mmu_tlb()
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 chenhuacai@kernel.org, tsbogend@alpha.franken.de, paul.walmsley@sifive.com,
 palmer@dabbelt.com, chris@zankel.net, jcmvbkbc@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 ryan.roberts@arm.com, ioworker0@gmail.com, libang.linux@gmail.com
References: <20240518074914.52170-1-libang.li@antgroup.com>
 <20240518074914.52170-3-libang.li@antgroup.com>
 <4650b888-d90f-40e3-8c53-c9949e539959@redhat.com>
Content-Language: en-US
From: "Bang Li" <libang.li@antgroup.com>
In-Reply-To: <4650b888-d90f-40e3-8c53-c9949e539959@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

Thanks for you review!

On 2024/5/21 17:36, David Hildenbrand wrote:
> On 18.05.24 09:49, Bang Li wrote:
>> Remove update_mmu_tlb() from those architectures and define
>> generically via update_mmu_tlb_range(), removing the ability
>> for arches to override it.
> 
> I'd suggest something like
> 
> "mm: implement update_mmu_tlb() using update_mmu_tlb_range()
> 
> Let's make update_mmu_tlb() simply a generic wrapper around 
> update_mmu_tlb_range(). Only the latter can now be overridden by the 
> architecture. We can now remove __HAVE_ARCH_UPDATE_MMU_TLB as well.
> "

Agree! Thank you for your suggestion, I will modify it in the next version

> 
> [...]
> 
>> +#ifndef update_mmu_tlb_range
>> +static inline void update_mmu_tlb_range(struct vm_area_struct *vma,
>> +                unsigned long address, pte_t *ptep, unsigned int nr)
>> +{
>> +}
>> +#endif
> 
> With that in patch #1

Thanks again.
Bang

> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

