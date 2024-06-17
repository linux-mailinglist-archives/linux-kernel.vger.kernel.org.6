Return-Path: <linux-kernel+bounces-217106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C296790AABE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD73A1C21285
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDFE194086;
	Mon, 17 Jun 2024 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="idcH79tF"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2191922C7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618793; cv=none; b=JqLPlBPnhJG4/S8197tzo+SUl1Yb162eFErI5r2H+zLEbGml+5zTJ8MeOsuCTG3b/AsudH0spAGXn0AyyyJR+mWEAJV6YRuFc5q8qCyFdMN01yN9P18v3WBsBLsqeH5cp3JHPgZrHoxkTYGCrq9607mGkvAGpuG2wM+Y2STeebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618793; c=relaxed/simple;
	bh=sWUNyWzeJ1P9kNaINyoEPpwx2VzRq791lEgIfVQ+e8k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WiFvGAUYN+Y2tqMOQYBc/xqIryVXwHYH6tQOOV4kLMyeVMr5KhJDRo4jy8dbwAfu+xQ2qMA6G7fs4aJOhlbf6M4CN7ZibCtF9gakbYYL3s5Hex8v3aqTsLEVG9TiJOMZKhlI0JAkqU7svkgGTm3/U7Q8ekkeH9UbJ1CIasrcj94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=idcH79tF; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=geQNIyMIatZwbN8alJljzy+7QcThplEvKiyRZfzgfS0=;
	b=idcH79tFg4Yd4NdDuBe+XKrhDYCRF4QxirOzxova7ZD424BSv9u6i84d93bHb0
	/gHImfziG5rGZnegI7knZML1AZ4efnfAbWU4x9QuaESBnDKRkm8Bi3to5zK/5MC/
	TPzneaDT2UM+QyihPYGKOB+6+KTwHwu+nxyKm4ArWSsJo=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wD331jkBnBm1R1bCw--.7695S2;
	Mon, 17 Jun 2024 17:50:29 +0800 (CST)
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
To: David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, liuzixing@hygon.cn
References: <0d7a4405-9a2e-4bd1-ba89-a31486155233@redhat.com>
 <dc7a0b61-8d3f-7205-2f6d-c2b12500947a@126.com>
 <776de760-e817-43b2-bd00-8ce96f4e37a8@redhat.com>
 <7063920f-963a-4b3e-a3f3-c5cc227bc877@redhat.com>
 <48150a28-ed48-49ff-9432-9cd30cda4da4@linux.alibaba.com>
 <11ef3deb-d1e3-46d5-97ed-9ba3c1fbbba9@redhat.com>
 <697a9bc2-a655-4035-aa5e-7d3acb23e79d@redhat.com>
 <d6deb928-3466-45ea-939b-cb5aca9bc7b4@linux.alibaba.com>
 <3a368e38-a4cb-413e-a6d9-41c6b3dbd5ae@redhat.com>
 <48fb0e58-16d1-7956-cf35-74741826617a@126.com>
 <ZmR1dVUB5mE2If9t@casper.infradead.org>
 <617f9e36-9334-4630-a6b9-473f2dd570d4@redhat.com>
 <8351052a-5c21-c383-544b-3166e883587c@126.com>
 <a39c8602-3c9c-48fd-9bdb-2089ccccd6bc@redhat.com>
From: yangge1116 <yangge1116@126.com>
Message-ID: <7b69abe5-3782-965c-ec82-5baef84e2d06@126.com>
Date: Mon, 17 Jun 2024 17:50:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a39c8602-3c9c-48fd-9bdb-2089ccccd6bc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD331jkBnBm1R1bCw--.7695S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw17tFW8KF4xXFy3uryDKFg_yoW8trykpF
	yUKF9rKF4qkryqkFnFqr17ArsYy3yrXFy5ZFWxJFy7CF4qqF15KrW8ta15uFy3Jr4Fgr1I
	ka12q3WfWF1UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b8PEfUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiWRIBG2VLaxbqAAAAso



在 2024/6/12 下午3:32, David Hildenbrand 写道:
> On 11.06.24 13:20, yangge1116 wrote:
>>
>>
>> 在 2024/6/9 上午12:03, David Hildenbrand 写道:
>>> On 08.06.24 17:15, Matthew Wilcox wrote:
>>>> On Sat, Jun 08, 2024 at 12:38:49PM +0800, yangge1116 wrote:
>>>>> Can we add a PG_lru_batch flag to determine whether a page is in lru
>>>>> batch?
>>>>> If we can, seems this problem will be easier.
>>>>
>>>> Page flags are in short supply.  You'd need a really good 
>>>> justification.
>>>>
>>>
>>> A flag would not be able to handle the "part of multiple LRU batches"
>>> that should currently possible (when to clear the flag?). Well, if we
>>> have to keep supporting that. If we only to be part in a single LRU
>>> batch, a new flag could work and we could still allow isolating a folio
>>> from LRU while in some LRU batch.
>>
>> Yes, before adding a folio to LRU batch, check whether the folio has
>> been added. Add the folio to LRU batch only if the folio has not been
>> added.
>>
>>>
>>> If we could handle it using the existing flags, that would of course be
>>> better (wondering if we could store more information in the existing
>>> flags by using a different encoding for the different states).
>>
>> If a folio contains more than one page, the folio will not be added to
>> LRU batch. Can we use folio_test_large(folio) to filter?
>>
>> if (!folio_test_large(folio) && drain_allow) {
>>     lru_add_drain_all();
>>     drain_allow = false;
>> }
> 
> I think we should do better than this, and not do arbitrary 
> lru_add_drain_all() calls.
> 

Thanks, I've got another idea.

If we add GUP_PIN_COUNTING_BIAS to folio's ref count before adding to 
LRU batch, we can use folio_maybe_dma_pinned(folio) to check whether the 
folio is in LRU batch. I wonder if it's feasible?


static void folio_batch_add_and_move(struct folio_batch *fbatch,
     struct folio *folio, move_fn_t move_fn)
{
     if (!folio_test_large(folio)) {
         folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);

         if (folio_batch_add(fbatch, folio) && !lru_cache_disabled())
             return;
     }

     folio_batch_move_lru(fbatch, move_fn);
}

if (!folio_test_large(folio) && folio_maybe_dma_pinned(folio) &&
     drain_allow) {
     lru_add_drain_all();
     drain_allow = false;
}



