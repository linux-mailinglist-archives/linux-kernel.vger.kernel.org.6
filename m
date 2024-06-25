Return-Path: <linux-kernel+bounces-228398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F03915F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5862A1F234DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EA61465A4;
	Tue, 25 Jun 2024 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="J8y0My6B"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7204C802
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299099; cv=none; b=qZ5wpI37DvuCZH9GBTmiQHTv183+xQGe6XoPRRXlczx0+Dv7QLPx6OgMVza555hOKwgTuokYm4+VV+Mn8eytQvRtYY+Pnar7rM96NEsaS19NAfWU3pY+tZvFZp0x+zFY61qXXxipNY8mRtBA46YmEHGnVSBo17H7f6p58FSzf94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299099; c=relaxed/simple;
	bh=mnKX0CK10jeL2AUmQJ/q/5xM6jCHBJ6hOtyIRt3jvms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a53TeOdXvoON578YkT/8Mo0s/mBBcqsI/uSBbg6JxDrOwh4Zp/1WYJFMBHZO3yt1dVHV9c6uYqA798OzcDTz2kCDcl/Qyic+RsItQlyKxPLBFnKWXQp9iK41fGDYMyNXzQLAeJ/OGf33nCwpbEz3glT3QYz2Eejvkf6WDVIOn+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=J8y0My6B; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719299094; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TCyWfIxYZ617Lw6Wt/fo0of1TWM+Fz/03YPYZQgvzOo=;
	b=J8y0My6B38xJPND5IOxc2M2+QxwzmDUjB0MZyXvziBB1KPYjMkBNFc5KDVqWfD6tX7FLt2ukdinKBRzsK7t0w85Ry4JmmaKD0Fc1NoNJUNLw3FEPUbHK12ts7ZhDENFWy4Gdod2G2NlQ8hzmb1/MUh5ZlEyeM6WO6zMEQN4Xt9c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W9Ekw83_1719299091;
Received: from 30.97.56.75(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9Ekw83_1719299091)
          by smtp.aliyun-inc.com;
          Tue, 25 Jun 2024 15:04:52 +0800
Message-ID: <0e66d3c8-5059-44e4-b015-40eaf2083e80@linux.alibaba.com>
Date: Tue, 25 Jun 2024 15:04:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable] mm: folio_add_new_anon_rmap() careful
 __folio_set_swapbacked()
To: Barry Song <21cnbao@gmail.com>, Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, chrisl@kernel.org,
 david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mhocko@suse.com, ryan.roberts@arm.com, shy828301@gmail.com,
 surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org,
 ying.huang@intel.com, yosryahmed@google.com, yuanshuai@oppo.com,
 yuzhao@google.com
References: <f3599b1d-8323-0dc5-e9e0-fdb3cfc3dd5a@google.com>
 <CAGsJ_4xABUi11ruC5obXvGi3R8zVQx2gzGAeqTGh22bj4xR9Dw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAGsJ_4xABUi11ruC5obXvGi3R8zVQx2gzGAeqTGh22bj4xR9Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/6/25 13:55, Barry Song wrote:
> On Tue, Jun 25, 2024 at 5:00 PM Hugh Dickins <hughd@google.com> wrote:
>>
>> Commit "mm: use folio_add_new_anon_rmap() if folio_test_anon(folio)==
>> false" has extended folio_add_new_anon_rmap() to use on non-exclusive
>> folios, already visible to others in swap cache and on LRU.
>>
>> That renders its non-atomic __folio_set_swapbacked() unsafe: it risks
>> overwriting concurrent atomic operations on folio->flags, losing bits
>> added or restoring bits cleared.  Since it's only used in this risky
>> way when folio_test_locked and !folio_test_anon, many such races are
>> excluded; but, for example, isolations by folio_test_clear_lru() are
>> vulnerable, and setting or clearing active.
>>
>> It could just use the atomic folio_set_swapbacked(); but this function
>> does try to avoid atomics where it can, so use a branch instead: just
>> avoid setting swapbacked when it is already set, that is good enough.
>> (Swapbacked is normally stable once set: lazyfree can undo it, but
>> only later, when found anon in a page table.)
>>
>> This fixes a lot of instability under compaction and swapping loads:
>> assorted "Bad page"s, VM_BUG_ON_FOLIO()s, apparently even page double
>> frees - though I've not worked out what races could lead to the latter.
>>
>> Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> Thanks a lot, Hugh. Sorry for my mistake. I guess we should squash this into
> patch 1/3 "mm: use folio_add_new_anon_rmap() if folio_test_anon(folio) ==
> false"?
> Andrew, could you please help to squash this one?

Hope the commit message written by Hugh can also be squashed into the 
original patch, as it is very helpful to me :)

>> ---
>>   mm/rmap.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index df1a43295c85..5394c1178bf1 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1408,7 +1408,9 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>          VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>>          VM_BUG_ON_VMA(address < vma->vm_start ||
>>                          address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>> -       __folio_set_swapbacked(folio);
>> +
>> +       if (!folio_test_swapbacked(folio))
>> +               __folio_set_swapbacked(folio);
>>          __folio_set_anon(folio, vma, address, exclusive);
>>
>>          if (likely(!folio_test_large(folio))) {
>> --
>> 2.35.3
>>
> 
> Thanks
> Barry

