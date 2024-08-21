Return-Path: <linux-kernel+bounces-295377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA21D959A35
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F2E1F234AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0508E199957;
	Wed, 21 Aug 2024 11:01:16 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7129D19
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238075; cv=none; b=AQQWDoIssknU1z/p/ZJSZYxiAM97Yb/66uWBDkSSLSRhj4CiyJ7l59BdxeW4YZ+atdw8l3/wU+ZqXVXcorNLfD76PhnFG64x5JOb42gL5pHlNMSAwb4vhWeF37vzltgVM4IQ9sDcj9Kb4sf9do73gKAyweE+4nA0UFCEYedFUbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238075; c=relaxed/simple;
	bh=7q6y3kIeI+lfISK+vzGTVINbhv1pAI9MIfIT/znMgEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=I8l4QIlGbEEwWPsfp8A/tsPZs493J1bsmSKi/sQsOlD+iFiZezJGhZ0JSoum5OO4lCqlZgrEGJWo5C93zrtZS56HKf8gbh0W1sllUytN5/tXAb6z/RR26oNvtSRi8EOLu7SgtTXoAgv/9e6eThufNO0Bm+RgINhg1OuNnMKp3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wpjv01NRJz20mDW;
	Wed, 21 Aug 2024 18:56:28 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id D3A5D180019;
	Wed, 21 Aug 2024 19:01:09 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 21 Aug 2024 19:01:09 +0800
Message-ID: <ca0a1d1a-106a-432a-be01-d5b3b5d697ea@huawei.com>
Date: Wed, 21 Aug 2024 19:01:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] f2fs: convert f2fs_submit_page_read() to use folio
To: Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
References: <20240820145507.1372905-1-chao@kernel.org>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <20240820145507.1372905-1-chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100025.china.huawei.com (7.185.36.37) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi,

在 2024/8/20 22:54, Chao Yu 写道:
> Convert to use folio, so that we can get rid of 'page->index' to
> prepare for removal of 'index' field in structure page [1].
> 
> [1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/f2fs/data.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 4f4e76c33611..0655fddfc4ba 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1086,7 +1086,7 @@ static struct bio *f2fs_grab_read_bio(struct inode *inode, block_t blkaddr,
>   }
>   
>   /* This can handle encryption stuffs */
> -static int f2fs_submit_page_read(struct inode *inode, struct page *page,
> +static int f2fs_submit_page_read(struct inode *inode, struct folio *folio,
>   				 block_t blkaddr, blk_opf_t op_flags,
>   				 bool for_write)
>   {
> @@ -1094,14 +1094,14 @@ static int f2fs_submit_page_read(struct inode *inode, struct page *page,
>   	struct bio *bio;
>   
>   	bio = f2fs_grab_read_bio(inode, blkaddr, 1, op_flags,
> -					page->index, for_write);
> +					folio->index, for_write);
>   	if (IS_ERR(bio))
>   		return PTR_ERR(bio);
>   
>   	/* wait for GCed page writeback via META_MAPPING */
>   	f2fs_wait_on_block_writeback(inode, blkaddr);
>   
> -	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
> +	if (!bio_add_folio(bio, folio, PAGE_SIZE, 0)) {
>   		iostat_update_and_unbind_ctx(bio);
>   		if (bio->bi_private)
>   			mempool_free(bio->bi_private, bio_post_read_ctx_pool);
> @@ -1269,7 +1269,7 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
>   		return page;
>   	}
>   
> -	err = f2fs_submit_page_read(inode, page, dn.data_blkaddr,
> +	err = f2fs_submit_page_read(inode, page_folio(page), dn.data_blkaddr,
>   						op_flags, for_write);
>   	if (err)
>   		goto put_err;
> @@ -3668,8 +3668,8 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>   			goto fail;
>   		}
>   		err = f2fs_submit_page_read(use_cow ?
> -				F2FS_I(inode)->cow_inode : inode, page,
> -				blkaddr, 0, true);
> +				F2FS_I(inode)->cow_inode : inode,
> +				page_folio(page), blkaddr, 0, true);
>   		if (err)
>   			goto fail;
>   
I have tested this patchset with fsstress and got any issue.

Reviewed-by: Li Zetao <lizetao1@huawei.com>

Thanks,
Li Zetao.

