Return-Path: <linux-kernel+bounces-215859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380A3909801
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 13:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0DF283E81
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 11:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353003C482;
	Sat, 15 Jun 2024 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="VcdB1RB+"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F510A11
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718451968; cv=none; b=re/0PbCtv/1JVIatvRfI3IuhoyQV4HJI9KeanuKLKRLuTGw144xlvM9kxMJOMrxCTfjYbReBIT+ydWXv7hqGE9rEMJAyP3V0nABfRER57KU0OiHOGryVI6TNmzdxJddBedBHMs9ZZ/MbNat/7ljoWh5DLnd8cnNlPWkcVbRW6ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718451968; c=relaxed/simple;
	bh=ks2Doz7YndF2QhRssO32VbFhAHzz8SzDih4V99Cbh2Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ocbAXpMWPe4N9cAfR2+YxyMiOhq91HpiOBkpk9jfG6Ok9dP2RZ1+erHhz9djhAZylmtW1xm9ovHAwQYHkeHtMx4P3GuXBp/rf28Se2f6ul9rldMyZymzOQ3jdYNzf2BdEG9muD7G1IesRCYUv+gWTxFhCe24j0mqErUvGxOhG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=VcdB1RB+; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version:
	Content-Type; bh=380/jyhTr/zvSS92chsebtdpaNxw5xeITqxnfl6SZXw=;
	b=VcdB1RB+xRofJg3xdBwHi2LkOVU9zi+5WYuXKV05YIAiWYrjjcT8Mc7qSyIm0j
	DtXtK1Fi9Olqsghjeclg/xc6Dvn4VRH4qpn4HpfvNIzX5oC+guL0zXkvuKVhzPcZ
	d4v8slPwqOV7xDOzdRWiMxt/4Vf0aPU/kf4S4hcX5XId0=
Received: from [172.21.21.216] (unknown [118.242.3.34])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3_8ubfm1msv1qBw--.38847S2;
	Sat, 15 Jun 2024 19:44:29 +0800 (CST)
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
Message-ID: <26c86ffe-581b-1012-9974-b3d73e56a03d@126.com>
Date: Sat, 15 Jun 2024 19:44:27 +0800
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
X-CM-TRANSID:_____wD3_8ubfm1msv1qBw--.38847S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw17tFW8KF4xXFy3uryDKFg_yoW8Xw17pF
	1fGF98JFsFkryYyFnrtrn7Arsay3yrJFy5XFy3JFy2kFyqqFy3KrW8ta15ua43Xr4Sgr10
	ka10q3Z3WF1jvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b8PEfUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOh3+G2VEwzIv6AAAsV



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

Thanks, I will prepare the V2.


