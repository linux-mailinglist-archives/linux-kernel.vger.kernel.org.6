Return-Path: <linux-kernel+bounces-264898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAF293E9F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 00:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E5B7B20F8F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 22:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F04179DC5;
	Sun, 28 Jul 2024 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r9/jcQzM"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2678274
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722204728; cv=none; b=MSP9LeRzIDQ5PjyoR2puA4gcxYE5aBSTY9gFNSu82aoBavVOkU3/sggaEtroHKRFDh+lCCF7W/Kq4if+NIr8HNmKlpw22+6LDdiI0qA9/z2d0b1SiZBM3E8heCXMWXv5GKGJezjVMmEQcIwHyAntycEHJBJ96rUXTk1YyeGqm18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722204728; c=relaxed/simple;
	bh=DqneCZNJdHpYHvrS9Jea1NsFauLawRGSdqgZl2Mgg4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThPIway1b+XRnMbwxhqDP6GfAF8jpLvZBQabqM7soMs2b05x1svptwkQ3ZZOE9hp/ZDUedZAGNl6iTHR8grATd9JwZLlQ1S/HPLM3Cbg8faFELuK0NFd3mHSe+FIWE76Cz+m6L6BKW3IbNAbYb8PsvWGItWC6oTJP9CNk5YnsSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r9/jcQzM; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722204717; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Y8tZ5sw0h13MXZSP5byipzmW9HMCzdG2caajKfL5w7w=;
	b=r9/jcQzMp1vdIG3nxlyiepXK7vlyHvwETa+PC6kbgilQcxjtdsLDir84PTItHRev/evAlhypVb08NudrjqR8IDo2sAcOjleafDYDUxqGGbYTjLvKlJyOwEI9ei8AGMrRO/siYqkIAyUQIT7PhLoSDRNB+oG9KIXgsBIgc13rGoI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032019045;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0WBS6vcy_1722204715;
Received: from 30.27.96.125(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBS6vcy_1722204715)
          by smtp.aliyun-inc.com;
          Mon, 29 Jul 2024 06:11:57 +0800
Message-ID: <04bbfcd0-6eb1-4a5b-ac21-b3cdf1acdc77@linux.alibaba.com>
Date: Mon, 29 Jul 2024 06:11:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
 <Zqa8NTqKuXkTxzBw@casper.infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Zqa8NTqKuXkTxzBw@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/7/29 05:46, Matthew Wilcox wrote:
> On Sun, Jul 28, 2024 at 11:49:13PM +0800, Gao Xiang wrote:
>> It was found by compaction stress test when I explicitly enable EROFS
>> compressed files to use large folios, which case I cannot reproduce with
>> the same workload if large folio support is off (current mainline).
>> Typically, filesystem reads (with locked file-backed folios) could use
>> another bdev/meta inode to load some other I/Os (e.g. inode extent
>> metadata or caching compressed data), so the locking order will be:
> 
> Umm.  That is a new constraint to me.  We have two other places which
> take the folio lock in a particular order.  Writeback takes locks on
> folios belonging to the same inode in ascending ->index order.  It
> submits all the folios for write before moving on to lock other inodes,
> so it does not conflict with this new constraint you're proposing.

BTW, I don't believe it's a new order out of EROFS, if you consider
ext4 or ext2 for example, it will also use sb_bread() (buffer heads
on bdev inode to trigger some meta I/Os),

e.g. take ext2 for simplicity:
   ext2_readahead
     mpage_readahead
      ext2_get_block
        ext2_get_blocks
          ext2_get_branch
             sb_bread     <-- get some metadata using for this data I/O

> 
> The other place is remap_file_range().  Both inodes in that case must be
> regular files,
>          if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
>                  return -EINVAL;
> so this new rule is fine.
> 
> Does anybody know of any _other_ ordering constraints on folio locks?  I'm
> willing to write them down ...

Personally I don't think out any particular order between two folio
locks acrossing different inodes, so I think folio batching locking
always needs to be taken care.

> 
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 20cb9f5f7446..a912e4b83228 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1483,7 +1483,8 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
>>   {
>>   	int rc;
>>   
>> -	folio_lock(folio);
>> +	if (!folio_trylock(folio))
>> +		return -EAGAIN;
>>   	rc = split_folio_to_list(folio, split_folios);
>>   	folio_unlock(folio);
>>   	if (!rc)
> 
> This feels like the best quick fix to me since migration is going to
> walk the folios in a different order from writeback.  I'm surprised
> this hasn't already bitten us, to be honest.

My stress workload explicitly triggers compaction and other EROFS
read loads, I'm not sure if others just test like this too, but:
https://lore.kernel.org/r/20240418001356.95857-1-mcgrof@kernel.org

seems like a similar load.

Thanks,
Gao Xiang

> 
> (ie I don't think this is even necessarily connected to the new
> ordering constraint; I think migration and writeback can already
> deadlock)

