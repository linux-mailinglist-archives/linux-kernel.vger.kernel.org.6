Return-Path: <linux-kernel+bounces-287784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBC2952C88
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D752820EB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767C41D2F5B;
	Thu, 15 Aug 2024 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKbQ6Jxv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB41C7B6D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716767; cv=none; b=d+yWpGhaHD1RK0pC5JsV06S9qwdAjl1N4jcx2D9fuzpwE6dOtyFk2mK91qH8qQ20ENmbuVeAtuBYA1jmH4lzi6FixQDb6r1UXp6JdrWr0/59rBpVvZ9skFT0bBDQGxRx3T7xGzSW7v/OpupWVmxDCE4Svs1zrMT44fym0whpgGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716767; c=relaxed/simple;
	bh=szI6GiNI6wD3w8Kk9EYmdy5gcQs6K0KSnyYmtTGRPZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bq1Y1yrn0CWl+3zK693fDkyatbLJSwERmnC0NsrhKpPChTvOeYbu4xPOm/tiiQUOh1CXra2sKtqFRNX0tOIurmMi3Rs8BVSMWKGZDk1s6dqSBKZtwvrI9+2p6ZOFySNbdRQ2GvUR/Yw+mO7n5bJ4tVcrqxMLRQA4gAVXflOD51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKbQ6Jxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6830AC32786;
	Thu, 15 Aug 2024 10:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723716766;
	bh=szI6GiNI6wD3w8Kk9EYmdy5gcQs6K0KSnyYmtTGRPZw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qKbQ6JxvK/RC/9bhrdtZLAclqZVM0O21sq1Wot9M6zfUt3BI9TI+uMr8VtRhPshYz
	 vbfC+YJLOdgB4F4i/aMf7IeU4cZdCOCpQeqs76tkHp65ZVS8Lkkw/SuuRQCnXnG9U/
	 5R7T2dcv12o/BCx7HAkftyyZc/mvjWGSttFKpWXA3972qoWpZiZkK8MZIEQSVqFr4y
	 QOUw/zjVCr8XqVGvEG3L6jxt84Jc41Ixh7/9pRwJGdWZ46qAQG6OHsAoA1HSm9c+WB
	 03RX//s7+mtAQZhbOsdfJZ//SF8wfDf76xVXkcratzYrdIY/N39ZLWHKHamD1Mhbdu
	 Qqe4nu1KPa4Kw==
Message-ID: <8dbdca2c-0ef9-4e93-87ca-db275675017f@kernel.org>
Date: Thu, 15 Aug 2024 18:12:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: compress: don't redirty sparse cluster during
 {,de}compress
To: Yeongjin Gil <youngjin.gil@samsung.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>, Sunmin Jeong
 <s_min.jeong@samsung.com>, Jaewook Kim <jw5454.kim@samsung.com>
References: <CGME20240813061105epcas1p4898159104ce2ee12ef6c203c4ab828ff@epcas1p4.samsung.com>
 <20240813061104.1052-1-youngjin.gil@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240813061104.1052-1-youngjin.gil@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/13 14:11, Yeongjin Gil wrote:
> In f2fs_do_write_data_page, when the data block is NULL_ADDR, it skips
> writepage considering that it has been already truncated.
> This results in an infinite loop as the PAGECACHE_TAG_TOWRITE tag is not
> cleared during the writeback process for a compressed file including
> NULL_ADDR in compress_mode=user.
> 
> This is the reproduction process:
> 
> 1. dd if=/dev/zero bs=4096 count=1024 seek=1024 of=testfile
> 2. f2fs_io compress testfile
> 3. dd if=/dev/zero bs=4096 count=1 conv=notrunc of=testfile
> 4. f2fs_io decompress testfile

Good catch!

> 
> To prevent the problem, let's check whether the cluster is fully
> allocated before redirty its pages.
> 
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Sunmin Jeong <s_min.jeong@samsung.com>
> Tested-by: Jaewook Kim <jw5454.kim@samsung.com>
> Signed-off-by: Yeongjin Gil <youngjin.gil@samsung.com>

Need a fixes line?

> ---
>   fs/f2fs/compress.c | 34 ++++++++++++++++++++++++++--------
>   fs/f2fs/f2fs.h     | 12 ++++++++++++
>   fs/f2fs/file.c     | 39 +++++++++++++++++++++------------------
>   3 files changed, 59 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 990b93689b46..09b91d725807 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -945,7 +945,7 @@ static int __f2fs_get_cluster_blocks(struct inode *inode,
>   	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
>   	int count, i;
>   
> -	for (i = 1, count = 1; i < cluster_size; i++) {
> +	for (i = 0, count = 0; i < cluster_size; i++) {
>   		block_t blkaddr = data_blkaddr(dn->inode, dn->node_page,
>   							dn->ofs_in_node + i);
>   
> @@ -956,8 +956,8 @@ static int __f2fs_get_cluster_blocks(struct inode *inode,
>   	return count;
>   }
>   
> -static int __f2fs_cluster_blocks(struct inode *inode,
> -				unsigned int cluster_idx, bool compr_blks)
> +static int __f2fs_cluster_blocks(struct inode *inode, unsigned int cluster_idx,
> +				enum cluster_check_type type)
>   {
>   	struct dnode_of_data dn;
>   	unsigned int start_idx = cluster_idx <<
> @@ -978,10 +978,12 @@ static int __f2fs_cluster_blocks(struct inode *inode,
>   	}
>   
>   	if (dn.data_blkaddr == COMPRESS_ADDR) {
> -		if (compr_blks)
> -			ret = __f2fs_get_cluster_blocks(inode, &dn);
> -		else
> +		if (type == COMPR_BLKS)
> +			ret = 1 + __f2fs_get_cluster_blocks(inode, &dn);
> +		else if (type == COMPR_CLUSTER)
>   			ret = 1;
> +	} else if (type == DECOMPR_BLKS) {
> +		ret = __f2fs_get_cluster_blocks(inode, &dn);
>   	}
>   fail:
>   	f2fs_put_dnode(&dn);
> @@ -991,7 +993,14 @@ static int __f2fs_cluster_blocks(struct inode *inode,
>   /* return # of compressed blocks in compressed cluster */
>   static int f2fs_compressed_blocks(struct compress_ctx *cc)
>   {
> -	return __f2fs_cluster_blocks(cc->inode, cc->cluster_idx, true);
> +	return __f2fs_cluster_blocks(cc->inode, cc->cluster_idx, COMPR_BLKS);
> +}
> +
> +/* return # of raw blocks in non-compressed cluster */
> +static int f2fs_decompressed_blocks(struct inode *inode,
> +				unsigned int cluster_idx)
> +{
> +	return __f2fs_cluster_blocks(inode, cluster_idx, DECOMPR_BLKS);
>   }
>   
>   /* return whether cluster is compressed one or not */
> @@ -999,7 +1008,16 @@ int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
>   {
>   	return __f2fs_cluster_blocks(inode,
>   		index >> F2FS_I(inode)->i_log_cluster_size,
> -		false);
> +		COMPR_CLUSTER);
> +}
> +
> +/* return whether the cluster is filled with raw blocks */
> +bool f2fs_is_non_sparse_cluster(struct inode *inode, pgoff_t index)

f2fs_is_sparse_cluster()?

> +{
> +	unsigned int cluster_idx = index >> F2FS_I(inode)->i_log_cluster_size;
> +
> +	return f2fs_decompressed_blocks(inode, cluster_idx) ==
> +		F2FS_I(inode)->i_cluster_size;
>   }
>   
>   static bool cluster_may_compress(struct compress_ctx *cc)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 51fd5063a69c..6f26c8cb8857 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4302,6 +4302,11 @@ static inline bool f2fs_meta_inode_gc_required(struct inode *inode)
>    * compress.c
>    */
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
> +enum cluster_check_type {
> +	COMPR_CLUSTER,
> +	COMPR_BLKS,
> +	DECOMPR_BLKS

How about?

CLUSTER_IS_COMPR,
CLUSTER_COMPR_BLKS,
CLUSTER_RAW_BLKS

> +};

Can you please add some comments for these enums?

>   bool f2fs_is_compressed_page(struct page *page);
>   struct page *f2fs_compress_control_page(struct page *page);
>   int f2fs_prepare_compress_overwrite(struct inode *inode,
> @@ -4328,6 +4333,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
>   						struct writeback_control *wbc,
>   						enum iostat_type io_type);
>   int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index);
> +bool f2fs_is_non_sparse_cluster(struct inode *inode, pgoff_t index);
>   void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
>   				pgoff_t fofs, block_t blkaddr,
>   				unsigned int llen, unsigned int c_len);
> @@ -4414,6 +4420,12 @@ static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
>   static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi,
>   							nid_t ino) { }
>   #define inc_compr_inode_stat(inode)		do { } while (0)
> +static inline int f2fs_is_compressed_cluster(
> +				struct inode *inode,
> +				pgoff_t index) { return 0; }
> +static inline bool f2fs_is_non_sparse_cluster(
> +				struct inode *inode,
> +				pgoff_t index) { return false; }
>   static inline void f2fs_update_read_extent_tree_range_compressed(
>   				struct inode *inode,
>   				pgoff_t fofs, block_t blkaddr,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 270c32e3385f..fba8b5f216f9 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4220,9 +4220,8 @@ static int f2fs_ioc_decompress_file(struct file *filp)
>   	struct inode *inode = file_inode(filp);
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct f2fs_inode_info *fi = F2FS_I(inode);
> -	pgoff_t page_idx = 0, last_idx;
> -	int cluster_size = fi->i_cluster_size;
> -	int count, ret;
> +	pgoff_t page_idx = 0, last_idx, cluster_idx;
> +	int ret;
>   
>   	if (!f2fs_sb_has_compression(sbi) ||
>   			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
> @@ -4257,10 +4256,15 @@ static int f2fs_ioc_decompress_file(struct file *filp)
>   		goto out;
>   
>   	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +	last_idx >>= fi->i_log_cluster_size;
> +
> +	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
> +		page_idx = cluster_idx << fi->i_log_cluster_size;
> +
> +		if (!f2fs_is_compressed_cluster(inode, page_idx))
> +			continue;
>   
> -	count = last_idx - page_idx;
> -	while (count && count >= cluster_size) {
> -		ret = redirty_blocks(inode, page_idx, cluster_size);
> +		ret = redirty_blocks(inode, page_idx, fi->i_cluster_size);
>   		if (ret < 0)
>   			break;
>   
> @@ -4270,9 +4274,6 @@ static int f2fs_ioc_decompress_file(struct file *filp)
>   				break;
>   		}
>   
> -		count -= cluster_size;
> -		page_idx += cluster_size;
> -
>   		cond_resched();
>   		if (fatal_signal_pending(current)) {
>   			ret = -EINTR;
> @@ -4299,9 +4300,9 @@ static int f2fs_ioc_compress_file(struct file *filp)
>   {
>   	struct inode *inode = file_inode(filp);
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	pgoff_t page_idx = 0, last_idx;
> -	int cluster_size = F2FS_I(inode)->i_cluster_size;
> -	int count, ret;
> +	struct f2fs_inode_info *fi = F2FS_I(inode);
> +	pgoff_t page_idx = 0, last_idx, cluster_idx;
> +	int ret;
>   
>   	if (!f2fs_sb_has_compression(sbi) ||
>   			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
> @@ -4335,10 +4336,15 @@ static int f2fs_ioc_compress_file(struct file *filp)
>   	set_inode_flag(inode, FI_ENABLE_COMPRESS);
>   
>   	last_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
> +	last_idx >>= fi->i_log_cluster_size;
>   
> -	count = last_idx - page_idx;
> -	while (count && count >= cluster_size) {
> -		ret = redirty_blocks(inode, page_idx, cluster_size);
> +	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
> +		page_idx = cluster_idx << fi->i_log_cluster_size;
> +
> +		if (!f2fs_is_non_sparse_cluster(inode, page_idx))

if (f2fs_is_sparse_cluster())
	continue;

Thanks,

> +			continue;
> +
> +		ret = redirty_blocks(inode, page_idx, fi->i_cluster_size);
>   		if (ret < 0)
>   			break;
>   
> @@ -4348,9 +4354,6 @@ static int f2fs_ioc_compress_file(struct file *filp)
>   				break;
>   		}
>   
> -		count -= cluster_size;
> -		page_idx += cluster_size;
> -
>   		cond_resched();
>   		if (fatal_signal_pending(current)) {
>   			ret = -EINTR;


