Return-Path: <linux-kernel+bounces-293249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B40957C81
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5471F24EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8A1146592;
	Tue, 20 Aug 2024 04:38:58 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E463C52F88
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724128737; cv=none; b=mIiHX8x6hRcJBARUzVnM9gEhw6xMwtOWnRbasoiDZSjB5Da5CkYEZyIpjVLnJTq1n1+vwUwWUED3auunlCdT/pw/l8CoxQA2qIyGkvpe7D+RvKvdKMBglt7tg680NV2CmPyzhxMPf7sCe7khVjl4jvMll/hQ94/lPZowoSVmfeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724128737; c=relaxed/simple;
	bh=MWv2UE8dfBapkYpw2cubCe4K+mk38Ji3pVAB/r/6ftA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=re6YFj03sWOo/JdQBnGAmTEnxha02YY48ydGIAGHo1gTnRnD+5MMoEgR2/+07irunNRpIR4nZCIgmvi7Q5gsESz8AwHdfvU8EL+fxwWj4oKcH69+QtYgjdgb1yoH102SFqRqcvYIHoy+drlFHCaBvz53pyNKQbLP/pst1ZY4iEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WnxYL0nRFzyQy8;
	Tue, 20 Aug 2024 12:38:30 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A1E3180101;
	Tue, 20 Aug 2024 12:38:51 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 20 Aug 2024 12:38:50 +0800
Message-ID: <a36db618-e7df-4c15-ad6f-876d8cc2bde5@huawei.com>
Date: Tue, 20 Aug 2024 12:38:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] f2fs: convert f2fs_write_begin() to use folio
To: Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
References: <20240820034654.698236-1-chao@kernel.org>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <20240820034654.698236-1-chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100005.china.huawei.com (7.185.36.185) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi,

在 2024/8/20 11:46, Chao Yu 写道:
> Convert to use folio, so that we can get rid of 'page->index' to
> prepare for removal of 'index' field in structure page [1].
> 
> [1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - fix compile error.
>   fs/f2fs/data.c | 44 +++++++++++++++++++++++---------------------
>   1 file changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 0655fddfc4ba..85ac05c3655a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3378,11 +3378,11 @@ void f2fs_write_failed(struct inode *inode, loff_t to)
>   }
>   
>   static int prepare_write_begin(struct f2fs_sb_info *sbi,
> -			struct page *page, loff_t pos, unsigned len,
> +			struct folio *folio, loff_t pos, unsigned int len,
>   			block_t *blk_addr, bool *node_changed)
>   {
> -	struct inode *inode = page->mapping->host;
> -	pgoff_t index = page->index;
> +	struct inode *inode = folio->mapping->host;
> +	pgoff_t index = folio->index;
>   	struct dnode_of_data dn;
>   	struct page *ipage;
>   	bool locked = false;
> @@ -3419,13 +3419,13 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>   
>   	if (f2fs_has_inline_data(inode)) {
>   		if (pos + len <= MAX_INLINE_DATA(inode)) {
> -			f2fs_do_read_inline_data(page_folio(page), ipage);
> +			f2fs_do_read_inline_data(folio, ipage);
>   			set_inode_flag(inode, FI_DATA_EXIST);
>   			if (inode->i_nlink)
>   				set_page_private_inline(ipage);
>   			goto out;
>   		}
> -		err = f2fs_convert_inline_page(&dn, page);
> +		err = f2fs_convert_inline_page(&dn, folio_page(folio, 0));
>   		if (err || dn.data_blkaddr != NULL_ADDR)
>   			goto out;
>   	}
> @@ -3518,12 +3518,12 @@ static int __reserve_data_block(struct inode *inode, pgoff_t index,
>   }
>   
>   static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
> -			struct page *page, loff_t pos, unsigned int len,
> +			struct folio *folio, loff_t pos, unsigned int len,
>   			block_t *blk_addr, bool *node_changed, bool *use_cow)
>   {
> -	struct inode *inode = page->mapping->host;
> +	struct inode *inode = folio->mapping->host;
>   	struct inode *cow_inode = F2FS_I(inode)->cow_inode;
> -	pgoff_t index = page->index;
> +	pgoff_t index = folio->index;
>   	int err = 0;
>   	block_t ori_blk_addr = NULL_ADDR;
>   
> @@ -3566,6 +3566,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>   	struct inode *inode = mapping->host;
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct page *page = NULL;
> +	struct folio *folio;
>   	pgoff_t index = ((unsigned long long) pos) >> PAGE_SHIFT;
>   	bool need_balance = false;
>   	bool use_cow = false;
> @@ -3625,22 +3626,23 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>   	/* TODO: cluster can be compressed due to race with .writepage */
>   
>   	*pagep = page;
> +	folio = page_folio(page);
>   
>   	if (f2fs_is_atomic_file(inode))
> -		err = prepare_atomic_write_begin(sbi, page, pos, len,
> +		err = prepare_atomic_write_begin(sbi, folio, pos, len,
>   					&blkaddr, &need_balance, &use_cow);
>   	else
> -		err = prepare_write_begin(sbi, page, pos, len,
> +		err = prepare_write_begin(sbi, folio, pos, len,
>   					&blkaddr, &need_balance);
>   	if (err)
>   		goto fail;
>   
>   	if (need_balance && !IS_NOQUOTA(inode) &&
>   			has_not_enough_free_secs(sbi, 0, 0)) {
> -		unlock_page(page);
> +		folio_unlock(folio);
>   		f2fs_balance_fs(sbi, true);
> -		lock_page(page);
> -		if (page->mapping != mapping) {
> +		folio_lock(folio);
> +		if (folio->mapping != mapping) {
>   			/* The page got truncated from under us */
>   			f2fs_put_page(page, 1);
>   			goto repeat;
> @@ -3649,18 +3651,18 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>   
>   	f2fs_wait_on_page_writeback(page, DATA, false, true);
>   
> -	if (len == PAGE_SIZE || PageUptodate(page))
> +	if (len == PAGE_SIZE || folio_test_uptodate(folio))
>   		return 0;
>   
>   	if (!(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode) &&
>   	    !f2fs_verity_in_progress(inode)) {
> -		zero_user_segment(page, len, PAGE_SIZE);
> +		folio_zero_segment(folio, len, folio_size(folio));
>   		return 0;
>   	}
>   
>   	if (blkaddr == NEW_ADDR) {
> -		zero_user_segment(page, 0, PAGE_SIZE);
> -		SetPageUptodate(page);
> +		folio_zero_segment(folio, 0, folio_size(folio));
> +		folio_mark_uptodate(folio);
>   	} else {
>   		if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
>   				DATA_GENERIC_ENHANCE_READ)) {
> @@ -3669,16 +3671,16 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>   		}
>   		err = f2fs_submit_page_read(use_cow ?
>   				F2FS_I(inode)->cow_inode : inode,
> -				page_folio(page), blkaddr, 0, true);
> +				folio, blkaddr, 0, true);
>   		if (err)
>   			goto fail;
>   
> -		lock_page(page);
> -		if (unlikely(page->mapping != mapping)) {
> +		folio_lock(folio);
> +		if (unlikely(folio->mapping != mapping)) {
>   			f2fs_put_page(page, 1);
>   			goto repeat;
>   		}
> -		if (unlikely(!PageUptodate(page))) {
> +		if (unlikely(!folio_test_uptodate(folio))) {
>   			err = -EIO;
>   			goto fail;
>   		}I want to apply your patch set for testing, but there is a conflict on 
the master branch of linux-next. Maybe it depends on a certain 
pre-patch. Please let me know, thank you.

   Applying: f2fs: convert f2fs_write_begin() to use folio
   error: patch failed: fs/f2fs/data.c:3566
   error: fs/f2fs/data.c: patch does not apply
   Patch failed at 0001 f2fs: convert f2fs_write_begin() to use folio

Thanks,
Li Zetao.

