Return-Path: <linux-kernel+bounces-217212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E790ACE4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCA61C21370
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD59194A7D;
	Mon, 17 Jun 2024 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nWdJF3OK"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D01194A73
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623517; cv=none; b=YtugGPm+1ASm94QtA7LbYQWywM04YqvN4cm0meNvxNSlaNidHMV6rKa+7fcK9FgWmLlcArGvzxIrX2hPRlc00uaS61UX5gz+VuEX/umcViuXJ+WeC/C60NP93Bh6wLS78mHvxFtBPIp881SqdSn9iVEQMuWg9geAREzWy7LwVXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623517; c=relaxed/simple;
	bh=SWtJ4Cp00HGbmyycojop7qVlUVh2yCNWVfdQOMypA1I=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=V3yiAeHc3zUb93tdpuQ1h4BuD37z0jLcGgQifW7wP3A0uNADR38xRRIU2ww0idsIke89y/+BbFLYJVGR77WlqZr8xwaX3PzDa6yWwwUAtCprVNRdaz0LYi5OBMExGB8YcS3brpzjKJNQuxBJvILPHCpNnhh62VKn5+TrYT+nfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=nWdJF3OK; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=gDW0ElYtH3AHdoLevCpq9BAOX76kY4zQdLhZsPYPZGU=;
	b=nWdJF3OKpZ5s3twnJL3EvxPDyeQvkm04oX4ikIjnNGo/GvIoin0k5F+j7aYLbP
	srBRq0mm2290LuC9lbpTm3tIuStKq0E4ovzuCUDU2iveVwZDTUE4ME6AuMpvLaY0
	EIwCXaDi5K0Weel9u6P18/Jl4A/ORO/o6FskffARqHYqI=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wDnr7mTHHBmvsVcCw--.823S2;
	Mon, 17 Jun 2024 19:23:01 +0800 (CST)
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
To: David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, 21cnbao@gmail.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 liuzixing@hygon.cn
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
 <7b69abe5-3782-965c-ec82-5baef84e2d06@126.com>
 <87fc95c7-0351-4b05-b68b-9b9364474cae@redhat.com>
From: yangge1116 <yangge1116@126.com>
Message-ID: <813b1141-4050-ead7-ec52-a2b3b8e26fee@126.com>
Date: Mon, 17 Jun 2024 19:22:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87fc95c7-0351-4b05-b68b-9b9364474cae@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr7mTHHBmvsVcCw--.823S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1UCF1DXr1rur4xJF43ZFb_yoWfKFb_Wr
	1kX3Z8C3Z7uw4rKF15ZrW5Jrs2gryYgr1DCF48XF13A34jyw1kZa1kKF1Yka4UJr4SkFsa
	9F15CwsayrnrCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5IFAJUUUUU==
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhUBG2VEw1R5ZQAAsf



在 2024/6/17 下午5:52, David Hildenbrand 写道:
> Why would we want to make folio_maybe_dma_pinned() detection that worse

Just want to fix it using the existing function, seems a little 
unreasonable. I will prepare the V2 using folio_test_lru(folio) to check.

static unsigned long collect_longterm_unpinnable_pages(...)
{
...
     if (!folio_test_lru(folio) && drain_allow) {
         lru_add_drain_all();
         drain_allow = false;
     }
...
}

void folio_mark_lazyfree(struct folio *folio)
{
     if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
        !folio_test_swapcache(folio) && !folio_test_unevictable(folio)) {
         struct folio_batch *fbatch;

         folio_get(folio);
         if (!folio_test_clear_lru(folio)) {
             folio_put(folio);
             return;
         }

         local_lock(&cpu_fbatches.lock);
         fbatch = this_cpu_ptr(&cpu_fbatches.lru_lazyfree);
         folio_batch_add_and_move(fbatch, folio, lru_lazyfree_fn);
         local_unlock(&cpu_fbatches.lock);
     }
}


