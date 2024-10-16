Return-Path: <linux-kernel+bounces-368386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB149A0F43
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2068286257
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283D320F5AB;
	Wed, 16 Oct 2024 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmMgAQKC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4911FDF81
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094669; cv=none; b=GZ1iAKyFGjPF/Bwd69tSUYDoTd+Uf8LNRkmvP+rJiT00gbd+IK++ZuQjVWp+dzcW4u9yZCkvb8v8wIOmr2cuMHabWF9+uMUdmTKLN5b4F/3KYAhM1ZE+u6OCdDoK3g7pz11x6M0FGu2w6ZhmVlKuC3uZfb9fjyRcvK8o+scJd7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094669; c=relaxed/simple;
	bh=zuOSy95G7mDcuWKPvFJYP2uNmIQJLYkDJb2JZ/9eicQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izRTR8Mc5MKJUep3fObuEFC4oMSnxhxwK4y7IzRbXnMZQ8mdKlbriznlwu+NRSa2zYMn9mMFiFSs0cJS6U+heQ6TkKgoGSkEluiRhcE+9b/fxq1sJDOdtyOIlwhs8LLwoUw9H1bDu9N4Hak5Tpy5V3K0nuE2EQ4NNbhoJ7IHzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmMgAQKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74751C4CECE;
	Wed, 16 Oct 2024 16:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729094668;
	bh=zuOSy95G7mDcuWKPvFJYP2uNmIQJLYkDJb2JZ/9eicQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UmMgAQKCgYgOyDg1JwnEM5XDeTw8054VjwarH8AowFAe0y8P9kdZUdg55EGRt83Vv
	 YazuM0y28B5xMwMRx3KmrpwO7tS8kiJl0IKInGiktmQCSV15ZOvxusFA69DpqaaYqZ
	 P2cM7DLg5ncX2vn0blWozDG6jUMKHN/gIVpVHS1p0ys8wtM6g9G16U3i42tmEW8pM+
	 7lWaFiE1u2itvZm9fCRXRDiZ7ohPJyydAVm2HN+hVWALEkRzBwzrRf5vtKqbJPi0MC
	 o1fOn6eUfp7GD+OoQblfqk6Ix9MuixOH2OlQb7WaLn0zCgE3TfJuTLcq2ChxstrvHq
	 RsSxukwe00/qQ==
Date: Wed, 16 Oct 2024 16:04:26 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yi Sun <yi.sun@unisoc.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, sunyibuaa@gmail.com,
	niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, ke.wang@unisoc.com
Subject: Re: [RFC PATCH 2/2] f2fs: introduce
 f2fs_invalidate_consecutive_blocks()
Message-ID: <Zw_kCu3J7f7iQrFF@google.com>
References: <20241016052758.3400359-1-yi.sun@unisoc.com>
 <20241016052758.3400359-3-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016052758.3400359-3-yi.sun@unisoc.com>

2573 void f2fs_invalidate_consecutive_blocks(struct f2fs_sb_info *sbi, block_t addr, int cnt)
2574 {
2575         unsigned int segno = GET_SEGNO(sbi, addr);
2576         unsigned int segno2 = GET_SEGNO(sbi, addr + cnt - 1);
2577         struct sit_info *sit_i = SIT_I(sbi);
2578
2579         f2fs_bug_on(sbi, addr == NULL_ADDR || segno != segno2);

This hits a panic here while running fsstress.

On 10/16, Yi Sun wrote:
> When doing truncate, consecutive blocks in the same segment
> can be processed at the same time. So that the efficiency of
> doing truncate can be improved.
> 
> Add f2fs_invalidate_compress_pages_range() only for doing truncate.
> Add check_f2fs_invalidate_consecutive_blocks() only for doing
> truncate and to determine whether the blocks are continuous and
> belong to the same segment.
> 
> Signed-off-by: Yi Sun <yi.sun@unisoc.com>
> ---
>  fs/f2fs/compress.c | 14 ++++++++++++++
>  fs/f2fs/f2fs.h     |  5 +++++
>  fs/f2fs/file.c     | 34 +++++++++++++++++++++++++++++++++-
>  fs/f2fs/segment.c  | 25 +++++++++++++++++++++++++
>  4 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 7f26440e8595..70929a87e9bf 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -2014,6 +2014,20 @@ void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino)
>  	} while (index < end);
>  }
>  
> +void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> +					block_t blkaddr, int cnt)
> +{
> +	if (!sbi->compress_inode)
> +		return;
> +
> +	if (cnt < 1) {
> +		f2fs_bug_on(sbi, 1);
> +		cnt = 1;
> +	}
> +
> +	invalidate_mapping_pages(COMPRESS_MAPPING(sbi), blkaddr, blkaddr + cnt - 1);
> +}
> +
>  int f2fs_init_compress_inode(struct f2fs_sb_info *sbi)
>  {
>  	struct inode *inode;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ce00cb546f4a..99767f35678f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3716,6 +3716,7 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi);
>  int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
>  void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
>  void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr);
> +void f2fs_invalidate_consecutive_blocks(struct f2fs_sb_info *sbi, block_t addr, int cnt);
>  bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
>  int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
>  void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
> @@ -4375,6 +4376,8 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
>  bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
>  								block_t blkaddr);
>  void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino);
> +void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> +					block_t blkaddr, int cnt);
>  #define inc_compr_inode_stat(inode)					\
>  	do {								\
>  		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);		\
> @@ -4432,6 +4435,8 @@ static inline bool f2fs_load_compressed_page(struct f2fs_sb_info *sbi,
>  				struct page *page, block_t blkaddr) { return false; }
>  static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi,
>  							nid_t ino) { }
> +static inline void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
> +						block_t blkaddr, int cnt) { }
>  #define inc_compr_inode_stat(inode)		do { } while (0)
>  static inline int f2fs_is_compressed_cluster(
>  				struct inode *inode,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 7057efa8ec17..634691e3b5f1 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -612,6 +612,18 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
>  	return finish_preallocate_blocks(inode);
>  }
>  
> +static bool check_f2fs_invalidate_consecutive_blocks(struct f2fs_sb_info *sbi,
> +					block_t blkaddr1, block_t blkaddr2)
> +{
> +	if (blkaddr2 - blkaddr1 != 1)
> +		return false;
> +
> +	if (GET_SEGNO(sbi, blkaddr1) != GET_SEGNO(sbi, blkaddr2))
> +		return false;
> +
> +	return true;
> +}
> +
>  void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> @@ -621,6 +633,9 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
>  	int cluster_index = 0, valid_blocks = 0;
>  	int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
>  	bool released = !atomic_read(&F2FS_I(dn->inode)->i_compr_blocks);
> +	block_t con_start;
> +	bool run_invalid = true;
> +	int con_cnt = 1;
>  
>  	addr = get_dnode_addr(dn->inode, dn->node_page) + ofs;
>  
> @@ -652,7 +667,24 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
>  				valid_blocks++;
>  		}
>  
> -		f2fs_invalidate_blocks(sbi, blkaddr);
> +		if (run_invalid)
> +			con_start = blkaddr;
> +
> +		if (count > 1 &&
> +			check_f2fs_invalidate_consecutive_blocks(sbi, blkaddr,
> +				le32_to_cpu(*(addr + 1)))) {
> +			run_invalid = false;
> +
> +			if (con_cnt++ == 1)
> +				con_start = blkaddr;
> +		} else {
> +			run_invalid = true;
> +		}
> +
> +		if (run_invalid) {
> +			f2fs_invalidate_consecutive_blocks(sbi, con_start, con_cnt);
> +			con_cnt = 1;
> +		}
>  
>  		if (!released || blkaddr != COMPRESS_ADDR)
>  			nr_free++;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index f118faf36d35..edb8a78985ba 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2570,6 +2570,31 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
>  	up_write(&sit_i->sentry_lock);
>  }
>  
> +void f2fs_invalidate_consecutive_blocks(struct f2fs_sb_info *sbi, block_t addr, int cnt)
> +{
> +	unsigned int segno = GET_SEGNO(sbi, addr);
> +	unsigned int segno2 = GET_SEGNO(sbi, addr + cnt - 1);
> +	struct sit_info *sit_i = SIT_I(sbi);
> +
> +	f2fs_bug_on(sbi, addr == NULL_ADDR || segno != segno2);
> +	if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
> +		return;
> +
> +	f2fs_truncate_meta_inode_pages(sbi, addr, cnt);
> +	f2fs_invalidate_compress_pages_range(sbi, addr, cnt);
> +
> +	/* add it into sit main buffer */
> +	down_write(&sit_i->sentry_lock);
> +
> +	update_segment_mtime(sbi, addr, 0);
> +	update_sit_entry(sbi, addr, -cnt);
> +
> +	/* add it into dirty seglist */
> +	locate_dirty_segment(sbi, segno);
> +
> +	up_write(&sit_i->sentry_lock);
> +}
> +
>  bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
>  {
>  	struct sit_info *sit_i = SIT_I(sbi);
> -- 
> 2.25.1

