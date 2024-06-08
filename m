Return-Path: <linux-kernel+bounces-206904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24359900F8C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 06:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50561B2355E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 04:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED6517C68;
	Sat,  8 Jun 2024 04:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="VM5PdSUR"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A449717984
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 04:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717821628; cv=none; b=QAYLm1UhvLsjfPSIn86e5M1AZvKI/2NyC0NaOQjVe0MXQdGArZDkdgUkwr20WnvOCBx5U/P5quq6eBisMN4ZIVFiwCcgAEap1oJ5jfVFINBHAzu/AlaDYavx6++tpG1QeCN17KZLN11oIzTG7bKsSlnw318oqWJsI4Qi/sUp/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717821628; c=relaxed/simple;
	bh=U6oal7Ip+u1M1fmvA60ymB/YCAeCyY5dNC920KcELuI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=De8mFyFMrnfaKc6KgVZ6HN3XdZH43HgoY89+Mh2UXjvLnf5OePcmmjOKpWoV1clgx/NKbAwvIew9+ywZAFeuzky8KITYrqBoeiVAd1iByl81gspeOrn5Ea2jD5h4wDRKn1wPp2SpQa7XnoOJrRQvETqPpzUSOb+y82fsQY4QkuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=VM5PdSUR; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=H2TmM8IrQ5a7tztR18Cxx5YmBHs5vMZX2tXrmy3VWxc=;
	b=VM5PdSURfZDLkOyzsWLxMHROk6mml6+/aX40Dt94B0HJlpGXDpXnA8VdmfADCG
	epTBQFHU+KlccqWsHoogPx4IoF3+dZfUen+b7eLMzJmsNA5Mbb+7wJqC3TNnwVwP
	WcFSrnv4Q35IkSkUV13aI8G/w7rO1TE77NKS2Cv9R9xRA=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3f0BZ4GNmTrjuBA--.40426S2;
	Sat, 08 Jun 2024 12:38:51 +0800 (CST)
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
To: David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, liuzixing@hygon.cn
References: <1717498121-20926-1-git-send-email-yangge1116@126.com>
 <0d7a4405-9a2e-4bd1-ba89-a31486155233@redhat.com>
 <dc7a0b61-8d3f-7205-2f6d-c2b12500947a@126.com>
 <776de760-e817-43b2-bd00-8ce96f4e37a8@redhat.com>
 <7063920f-963a-4b3e-a3f3-c5cc227bc877@redhat.com>
 <48150a28-ed48-49ff-9432-9cd30cda4da4@linux.alibaba.com>
 <11ef3deb-d1e3-46d5-97ed-9ba3c1fbbba9@redhat.com>
 <697a9bc2-a655-4035-aa5e-7d3acb23e79d@redhat.com>
 <d6deb928-3466-45ea-939b-cb5aca9bc7b4@linux.alibaba.com>
 <3a368e38-a4cb-413e-a6d9-41c6b3dbd5ae@redhat.com>
From: yangge1116 <yangge1116@126.com>
Message-ID: <48fb0e58-16d1-7956-cf35-74741826617a@126.com>
Date: Sat, 8 Jun 2024 12:38:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3a368e38-a4cb-413e-a6d9-41c6b3dbd5ae@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f0BZ4GNmTrjuBA--.40426S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFykJFyUJw4kKw4xCry5CFg_yoW5Aw4xpF
	WrGasFkF4DGa1Yywn7tr1DZr1FyrW8ta43CF1fCr98ZF9YvFyIkrW8Ka1a9F48Aws5Gr40
	vw4jyFZ7ua4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bOXocUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWQz3G2VLanpPvgABs3



在 2024/6/6 下午3:56, David Hildenbrand 写道:
>>> Some random thoughts about some folio_test_lru() users:
>>>
>>> mm/khugepaged.c: skips pages if !folio_test_lru(), but would fail skip
>>> it either way if there is the unexpected reference from the LRU batch!
>>>
>>> mm/compaction.c: skips pages if !folio_test_lru(), but would fail skip
>>> it either way if there is the unexpected reference from the LRU batch!
>>>
>>> mm/memory.c: would love to identify this case and to a lru_add_drain()
>>> to free up that reference.
>>>
>>> mm/huge_memory.c: splitting with the additional reference will fail
>>> already. Maybe we'd want to drain the LRU batch.
>>
>> Agree.
>>
>>>
>>> mm/madvise.c: skips pages if !folio_test_lru(). I wonder what happens if
>>> we have the same page twice in an LRU batch with different target 
>>> goals ...
>>
>> IIUC, LRU batch can ignore this folio since it's LRU flag is cleared by
>> folio_isolate_lru(), then will call folios_put() to frop the reference.
>>
> 
> I think what's interesting to highlight in the current design is that a 
> folio might end up in multiple LRU batches, and whatever the result will 
> be is determined by the sequence of them getting flushed. Doesn't sound 
> quite right but maybe there was a reason for it (which could just have 
> been "simpler implementation").
> 
>>
>>> Some other users (there are not that many that don't use it for sanity
>>> checks though) might likely be a bit different.
> 
> There are also some PageLRU checks, but not that many.
> 
>>
>> mm/page_isolation.c: fail to set pageblock migratetype to isolate if
>> !folio_test_lru(), then alloc_contig_range_noprof() can be failed. But
>> the original code could set pageblock migratetype to isolate, then
>> calling drain_all_pages() in alloc_contig_range_noprof() to drop
>> reference of the LRU batch.
>>
>> mm/vmscan.c: will call lru_add_drain() before calling
>> isolate_lru_folios(), so seems no impact.
> 
> lru_add_drain() will only drain the local CPU. So if the folio would be 
> stuck on another CPU's LRU batch, right now we could isolate it. When 
> processing that LRU batch while the folio is still isolated, it would 
> currently simply skip the operation.
> 
> So right now we can call isolate_lru_folios() even if the folio is stuck 
> on another CPU's LRU batch.
> 
> We cannot really reclaim the folio as long is it is in another CPU's LRU 
> batch, though (unexpected reference).
> 
>>
>> BTW, we also need to look at the usage of folio_isolate_lru().
> 
> Yes.
> 
>>
>> It doesn’t seem to have major obstacles, but there are many details to
>> analyze :)
> 
> Yes, we're only scratching the surface.
> 
> Having a way to identify "this folio is very likely some CPU's LRU 
> batch"  could end up being quite valuable, because likely we don't want 
> to blindly drain the LRU simply because there is some unexpected 
> reference on a folio [as we would in this patch].
> 

Can we add a PG_lru_batch flag to determine whether a page is in lru 
batch? If we can, seems this problem will be easier.


