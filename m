Return-Path: <linux-kernel+bounces-238642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78044924D4E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B133E1C21E4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 01:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720C61C2E;
	Wed,  3 Jul 2024 01:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YpQcY8jE"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FCB1FAA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 01:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719971501; cv=none; b=k/0uRAem/ml8DaN6NGuS5by7ZUvUxR0IvVF/f4T1Q5nZ79YI3Xs7WtEDjL6NcX8Lkb47Xvn9ZIjlIX8ahaBatbJZzzaC+y21zeQe9w1X/cEDHtRt5PCuXGYePR+FnKOXPCIvXC5DuhEeI0MRc2UPTh6L9TCT91Dt4JybGWTzItM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719971501; c=relaxed/simple;
	bh=wXopNP9HWVqJyjeNRwiufXtz3LV4hLaHvrXDn9SMyfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBSsrOYUG9/uDKDDU+VfEccrhXxP5F6cFmph34cbnfjzVuIkC95Z0flpjjtvBMqVGI+ycw1YrFn0Te6xHO+ACNrjmasYY0HBNqmAmzSOn2W8ZeMoW9gbLfVh78InSdDUUm20NFM+SY0B3ItYn4J4RaZ71H3mhq3I8vR73j1o27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YpQcY8jE; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719971491; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9ySc3bYg15NcsW1Q0nlz2/qGVTHyuUlAyowi9v5Eek0=;
	b=YpQcY8jE0tDqOnBjhjAMR8fYzQTXGAj0pc5hiMfYp4kJtnnxkYrRPYfdNfvpObvqpjbPTW4TQufunCOkxvXm6eCLUHm0MFyfhUmaR6mMoBOiP1LPrkfFo2FMOA+gboIENy6delQmmY7Mz2FAP35JBqzAkPgdLppdIbpKlRx6LUU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W9kB2Z-_1719971489;
Received: from 30.97.56.62(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9kB2Z-_1719971489)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 09:51:30 +0800
Message-ID: <c629363c-2f26-4503-a94e-c04ba96b98d6@linux.alibaba.com>
Date: Wed, 3 Jul 2024 09:51:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix] mm: fix crashes from deferred split racing folio
 migration
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>,
 Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <baohua@kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <29c83d1a-11ca-b6c9-f92e-6ccb322af510@google.com>
 <da6bad97-18b8-4cd0-9dcc-b60fb20b7a84@linux.alibaba.com>
 <ec3a5d94-1985-f66d-1aa8-3783fe498f5a@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ec3a5d94-1985-f66d-1aa8-3783fe498f5a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/7/3 00:15, Hugh Dickins wrote:
> On Tue, 2 Jul 2024, Baolin Wang wrote:
>> On 2024/7/2 15:40, Hugh Dickins wrote:
>>> Even on 6.10-rc6, I've been seeing elusive "Bad page state"s (often on
>>> flags when freeing, yet the flags shown are not bad: PG_locked had been
>>> set and cleared??), and VM_BUG_ON_PAGE(page_ref_count(page) == 0)s from
>>> deferred_split_scan()'s folio_put(), and a variety of other BUG and WARN
>>> symptoms implying double free by deferred split and large folio migration.
>>>
>>> 6.7 commit 9bcef5973e31 ("mm: memcg: fix split queue list crash when large
>>> folio migration") was right to fix the memcg-dependent locking broken in
>>> 85ce2c517ade ("memcontrol: only transfer the memcg data for migration"),
>>> but missed a subtlety of deferred_split_scan(): it moves folios to its own
>>> local list to work on them without split_queue_lock, during which time
>>> folio->_deferred_list is not empty, but even the "right" lock does nothing
>>> to secure the folio and the list it is on.
>>>
>>> Fortunately, deferred_split_scan() is careful to use folio_try_get(): so
>>> folio_migrate_mapping() can avoid the race by folio_undo_large_rmappable()
>>> while the old folio's reference count is temporarily frozen to 0 - adding
>>> such a freeze in the !mapping case too (originally, folio lock and
> 
> (I should have added "isolation and" into that list of conditions.)
> 
>>> unmapping and no swap cache left an anon folio unreachable, so no freezing
>>> was needed there: but the deferred split queue offers a way to reach it).
>>
>> Thanks Hugh.
>>
>> But after reading your analysis, I am concerned that the
>> folio_undo_large_rmappable() and deferred_split_scan() may still encounter a
>> race condition with the local list, even with your patch.
>>
>> Suppose folio A has already been queued into the local list in
>> deferred_split_scan() by thread A, but fails to 'folio_trylock' and then
>> releases the reference count. At the same time, folio A can be frozen by
>> another thread B in folio_migrate_mapping(). In such a case,
>> folio_undo_large_rmappable() would remove folio A from the local list without
>> *any* lock protection, creating a race condition with the local list iteration
>> in deferred_split_scan().
> 
> It's a good doubt to raise, but I think we're okay: because Kirill
> designed the deferred split list (and its temporary local list) to
> be safe in that way.
> 
> You're right that if thread B's freeze to 0 wins the race, thread B
> will be messing with a list on thread A's stack while thread A is
> quite possibly running; but thread A will not leave that stack frame
> without taking again the split_queue_lock which thread B holds while
> removing from the list.
> 
> We would certainly not want to introduce such a subtlety right now!
> But never mind page migration, this is how it has always worked when
> racing with the folio being freed at the same time - maybe
> deferred_split_scan() wins the freeing race and is the one to remove
> folio from deferred split list, or maybe the other freer does that.

Yes, thanks for explanation. And after thinking more, the 
'list_for_each_entry_safe' in deferred_split_scan() can maintain the 
list iteration safety, so I think this is safe.

> I forget whether there was an initial flurry of races to be fixed when
> it came in, but it has been stable against concurrent freeing for years.
> 
> Please think this over again: do not trust my honeyed words!
> 
>>
>> Anyway, I think this patch can still fix some possible races. Feel free to
>> add:
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Thanks, but I certainly don't want this to go into the tree if it's
> still flawed as you suggest.

Now I have no doubt for this fix, and please continue to keep my 
Reviewed-by tag, thanks.

