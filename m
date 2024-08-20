Return-Path: <linux-kernel+bounces-293182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2CE957BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072841C23AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A02A3F9C5;
	Tue, 20 Aug 2024 03:04:42 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6EF12B8B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724123081; cv=none; b=Bnl1stoH3PJzi9sa+aRDsYDCALdA8z/Mc1J6rDCI4Wi1jX/9pzeGSYdvXmgW82VGXuxJmlNXJK6uLVL1oJm5Cd7bW44J/qJS1af20/2KlIyTI7m3rI+JSRe51V27QhXwrcNtaApHvzVo3cn0O+b5LLrocmf6MznEvLBep2Z3OmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724123081; c=relaxed/simple;
	bh=x58EV9CSQF0ME2P8SLA0b6+PuMyhPNCNIXzNGYKJ4kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QBTJV+ugC4a/7u1exhIlmLsg203HlqunUTz49E2bHR7a3aTz/wirAPuuBDfn52G/CPTMn7fNJzGWsJawsODA1jK5l4pgqAPpmvQGotYgwR9ydTBoF5aqnhyZ9aI1uDnqqHGny00kjZjQEKz4ywfFt2sxt39BaUwnMpcTUrDTZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WnvMF3YS8z1j6lf;
	Tue, 20 Aug 2024 10:59:37 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 99D3514010C;
	Tue, 20 Aug 2024 11:04:36 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 20 Aug 2024 11:04:36 +0800
Message-ID: <52808e24-923d-4758-a08f-7bba87fc42b0@huawei.com>
Date: Tue, 20 Aug 2024 11:04:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] f2fs: convert f2fs_write_end() to use folio
To: Chao Yu <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
References: <20240819012023.3871272-1-chao@kernel.org>
 <20240819012023.3871272-2-chao@kernel.org>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <20240819012023.3871272-2-chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100002.china.huawei.com (7.185.36.130) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi,

在 2024/8/19 9:20, Chao Yu 写道:
> Convert to use folio, so that we can get rid of 'page->index' to
> prepare for removal of 'index' field in structure page [1].
> 
> [1] https://lore.kernel.org/all/Zp8fgUSIBGQ1TN0D@casper.infradead.org/
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/f2fs/data.c | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 9e1ade13060c..e114d738b6b4 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3378,7 +3378,7 @@ void f2fs_write_failed(struct inode *inode, loff_t to)
>   }
>   
>   static int prepare_write_begin(struct f2fs_sb_info *sbi,
> -			struct page *page, loff_t pos, unsigned len,
> +			struct folio *folio, loff_t pos, unsigned int len,
>   			block_t *blk_addr, bool *node_changed)
>   {
>   	struct inode *inode = folio->mapping->host;
> @@ -3425,7 +3425,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
>   				set_page_private_inline(ipage);
>   			goto out;
>   		}
> -		err = f2fs_convert_inline_page(&dn, page);
> +		err = f2fs_convert_inline_page(&dn, folio_page(folio, 0));
>   		if (err || dn.data_blkaddr != NULL_ADDR)
>   			goto out;
>   	}
> @@ -3629,7 +3629,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>   	folio = page_folio(page);
>   
>   	if (f2fs_is_atomic_file(inode))
> -		err = prepare_atomic_write_begin(sbi, folio, pos, len
> +		err = prepare_atomic_write_begin(sbi, folio, pos, len,
This has been changed in the first patch, it is redundant here.
>   					&blkaddr, &need_balance, &use_cow);
>   	else
>   		err = prepare_write_begin(sbi, folio, pos, len,
> @@ -3698,7 +3698,8 @@ static int f2fs_write_end(struct file *file,
>   			loff_t pos, unsigned len, unsigned copied,
>   			struct page *page, void *fsdata)
>   {
> -	struct inode *inode = page->mapping->host;
> +	struct folio *folio = page_folio(page);
> +	struct inode *inode = folio->mapping->host;
>   
>   	trace_f2fs_write_end(inode, pos, len, copied);
>   
> @@ -3707,17 +3708,17 @@ static int f2fs_write_end(struct file *file,
>   	 * should be PAGE_SIZE. Otherwise, we treat it with zero copied and
>   	 * let generic_perform_write() try to copy data again through copied=0.
>   	 */
> -	if (!PageUptodate(page)) {
> +	if (!folio_test_uptodate(folio)) {
>   		if (unlikely(copied != len))
>   			copied = 0;
>   		else
> -			SetPageUptodate(page);
> +			folio_mark_uptodate(folio);
>   	}
>   
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>   	/* overwrite compressed file */
>   	if (f2fs_compressed_file(inode) && fsdata) {
> -		f2fs_compress_write_end(inode, fsdata, page->index, copied);
> +		f2fs_compress_write_end(inode, fsdata, folio->index, copied);
>   		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
>   
>   		if (pos + copied > i_size_read(inode) &&
> @@ -3730,10 +3731,10 @@ static int f2fs_write_end(struct file *file,
>   	if (!copied)
>   		goto unlock_out;
>   
> -	set_page_dirty(page);
> +	folio_mark_dirty(folio);
>   
>   	if (f2fs_is_atomic_file(inode))
> -		set_page_private_atomic(page);
> +		set_page_private_atomic(folio_page(folio, 0));
>   
>   	if (pos + copied > i_size_read(inode) &&
>   	    !f2fs_verity_in_progress(inode)) {

