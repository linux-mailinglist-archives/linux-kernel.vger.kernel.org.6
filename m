Return-Path: <linux-kernel+bounces-285686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B0E951149
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A895D1F23AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9C1AD59;
	Wed, 14 Aug 2024 00:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGRdqHEP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A39445
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723597125; cv=none; b=Uk+FWnztwuXshfXYfvW6E+ZX+vyK/MLXu6W0hLhaXdUrFey1FeVR1huoiNDCTHxnYCVRQHvh8Lo4/WsBg1AnWVW6CYkAx0wKLsP+ihVHIiVFHwSkQw+fKC0YOEhQaSwVQ+Os7azLdL3hvTWuNGZFfLn6+cbOWQj6FGUp48Q89TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723597125; c=relaxed/simple;
	bh=KDEpbRprnacmNiAaCY2Q/eGuX74con43zqyU2XmoaqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2d/kCeZBIJY1LSAU9kbnJyLjytoK3kozuJgRRJ3AQn5gXYJkm1DceLYZ6B+/IUc1cMkV3Dv/Nw66SiCgQLXBukP+fAIeG9skXG9agsesbS5WpugcEXas9Snj/I6If1GSY6ufKVx7FI9xTzNbdb9RbeuAc8/zSRgu68NQ2kudYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGRdqHEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11257C32782;
	Wed, 14 Aug 2024 00:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723597125;
	bh=KDEpbRprnacmNiAaCY2Q/eGuX74con43zqyU2XmoaqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nGRdqHEPP2gIRpXuDo02vpuXhEjZdSpSa3Gultwoz00NcSZeFELzt0wh/m75W/FE6
	 fRaQczG38xhHK93SlvbIHx+sQOWYUEEB4LxDpfw2gK1yAc1H1HHSjTKzYQr6p9VOlX
	 1QrV+9LLaoPImpEZ2HkvMPoOK4Pcj1W4VDx50ETusUcj8OIFTzvMSIRognjPA3nZ+x
	 2mZqvsyBV5yGkJcMG1Cm5irS/prjjnbBkt+GTmgTD5AsJ1zFQpnXNZUoNujISh75uc
	 a8g9c89Zj02DCnmX4+8n2B5XAi9X2O83HJ35Lefp1gON07G500loE99QJl4qqMsyy2
	 +cPkY0dKo2TVA==
Message-ID: <b94a0805-0c20-4309-98f6-85a4e0b5a7f2@kernel.org>
Date: Wed, 14 Aug 2024 08:58:37 +0800
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>
References: <20240813141331.417067-1-chao@kernel.org>
 <ZrvdD6EVJAik1b5w@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZrvdD6EVJAik1b5w@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/14 6:24, Jaegeuk Kim wrote:
> Could you please test this series? I hit kernel hang along with refcount warning

Oops, I've did fstest before sending this patchset, however I missed to
cover w/ compression testcase..., so, too rush to push the patchset, sorry.

Will check and fix it soon.

Thanks,

> in f2fs_put_dic, when running fsstress. You can reproduce it quickly.
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


