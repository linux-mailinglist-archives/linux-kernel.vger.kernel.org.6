Return-Path: <linux-kernel+bounces-285805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F409512FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC9F28250D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE8C376F5;
	Wed, 14 Aug 2024 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pP9jP1GG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A5364AE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723605427; cv=none; b=UnhrfRi2E2JSW2ouPwe4gkPTCTpJIF0UGnszv9PDh+eiX4IjoxuzY1FVAYUi7psVADB+FQq838tUGGYpbAVIlW642AMIOtfMv6WX6Lrz/HG9XGGn49D8RO153TOPxW4VoQEK1/bl2isNpVn1yTSL6mxU4b4koPbiiUqMujQSdB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723605427; c=relaxed/simple;
	bh=FBn0TJzuKz5QlU+SwuU8/v8NAWJNdKV4Pp/tO+xkdIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWeq+4BMJ5KbJ3kK0f77YSPShSgXoWsk6Ibn+1CovTgrdWMiH1IjkwB8kokOICd/eMAFtNKVnbxpMXsMTgv51OrlEy+0t1DlwPtn6+JEt26v4+qJKZgjaZY3mKZmJ4nJzrdtd2d1io+OqZvlDTofCYoUZsroHozYzSSWFJzrlWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pP9jP1GG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2BEC32782;
	Wed, 14 Aug 2024 03:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723605426;
	bh=FBn0TJzuKz5QlU+SwuU8/v8NAWJNdKV4Pp/tO+xkdIQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pP9jP1GGTkN8tV4RHK5EGNMuqebUsIXqDhOlgjvnzD+02gVodq945CfZbnD2M4Epo
	 PW8b8A8+zc+/ZLrpuBB/nSoEL/Ea++J3pgX3vMm/VHN48sD2Lyo/oWu78Hfi58Kx0x
	 1gG9NydpJ8GiEXJnBQHHybwO48Gabd1uGLCvNkXsxHXklb6BZj+3dgr8DmJpsuLxHK
	 YEW4h8UNQzZXFZsW+/On0uG+8LjB59dbFZ9fOjxHywjFi/JipWnq2v/YgJXbkRo1P6
	 dabso4rpQ5Fpwqd90BMfIhXbsyvBplXY/STwbLEP9a20RqAMykP1f9BHqv/bPUNlkb
	 i18xuzXIHfn+Q==
Message-ID: <cb4e93f9-1a60-4f98-9690-263fbbe7a99e@kernel.org>
Date: Wed, 14 Aug 2024 11:17:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] f2fs: convert f2fs_compress_ctx_add_page() to use
 folio
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240813141331.417067-1-chao@kernel.org>
 <ZrvdD6EVJAik1b5w@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZrvdD6EVJAik1b5w@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/14 6:24, Jaegeuk Kim wrote:
> Could you please test this series? I hit kernel hang along with refcount warning
> in f2fs_put_dic, when running fsstress. You can reproduce it quickly.

---
  fs/f2fs/data.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9e21cfe11cc7..4f4e76c33611 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2322,7 +2322,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
  			}
  		}

-		if (bio_add_folio(bio, folio, blocksize, 0) < blocksize)
+		if (!bio_add_folio(bio, folio, blocksize, 0))
  			goto submit_and_realloc;

  		ctx = get_post_read_ctx(bio);
-- 
2.40.1

After applying this, it doesn't complain now.

Thanks,

> 
> On 08/13, Chao Yu wrote:
>> onvert to use folio, so that we can get rid of 'page->index' to
>> prepare for removal of 'index' field in structure page [1].
>>
>> [1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/
>>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/compress.c | 14 +++++++-------
>>   fs/f2fs/data.c     |  4 ++--
>>   fs/f2fs/f2fs.h     |  2 +-
>>   3 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index 990b93689b46..eb5cd1457ffc 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -160,17 +160,17 @@ void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse)
>>   		cc->cluster_idx = NULL_CLUSTER;
>>   }
>>   
>> -void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page)
>> +void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct folio *folio)
>>   {
>>   	unsigned int cluster_ofs;
>>   
>> -	if (!f2fs_cluster_can_merge_page(cc, page->index))
>> +	if (!f2fs_cluster_can_merge_page(cc, folio->index))
>>   		f2fs_bug_on(F2FS_I_SB(cc->inode), 1);
>>   
>> -	cluster_ofs = offset_in_cluster(cc, page->index);
>> -	cc->rpages[cluster_ofs] = page;
>> +	cluster_ofs = offset_in_cluster(cc, folio->index);
>> +	cc->rpages[cluster_ofs] = folio_page(folio, 0);
>>   	cc->nr_rpages++;
>> -	cc->cluster_idx = cluster_idx(cc, page->index);
>> +	cc->cluster_idx = cluster_idx(cc, folio->index);
>>   }
>>   
>>   #ifdef CONFIG_F2FS_FS_LZO
>> @@ -1093,7 +1093,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>>   		if (PageUptodate(page))
>>   			f2fs_put_page(page, 1);
>>   		else
>> -			f2fs_compress_ctx_add_page(cc, page);
>> +			f2fs_compress_ctx_add_page(cc, page_folio(page));
>>   	}
>>   
>>   	if (!f2fs_cluster_is_empty(cc)) {
>> @@ -1123,7 +1123,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>>   		}
>>   
>>   		f2fs_wait_on_page_writeback(page, DATA, true, true);
>> -		f2fs_compress_ctx_add_page(cc, page);
>> +		f2fs_compress_ctx_add_page(cc, page_folio(page));
>>   
>>   		if (!PageUptodate(page)) {
>>   release_and_retry:
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index e9570f4e0f21..100b6526717f 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -2429,7 +2429,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
>>   		if (ret)
>>   			goto set_error_page;
>>   
>> -		f2fs_compress_ctx_add_page(&cc, &folio->page);
>> +		f2fs_compress_ctx_add_page(&cc, folio);
>>   
>>   		goto next_page;
>>   read_single_page:
>> @@ -3161,7 +3161,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>>   			if (f2fs_compressed_file(inode)) {
>>   				folio_get(folio);
>> -				f2fs_compress_ctx_add_page(&cc, &folio->page);
>> +				f2fs_compress_ctx_add_page(&cc, folio);
>>   				continue;
>>   			}
>>   #endif
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 51fd5063a69c..df436dd3aac1 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -4322,7 +4322,7 @@ bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
>>   bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
>>   				int index, int nr_pages, bool uptodate);
>>   bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
>> -void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page);
>> +void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct folio *folio);
>>   int f2fs_write_multi_pages(struct compress_ctx *cc,
>>   						int *submitted,
>>   						struct writeback_control *wbc,
>> -- 
>> 2.40.1


