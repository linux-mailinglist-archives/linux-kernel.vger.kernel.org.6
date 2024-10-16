Return-Path: <linux-kernel+bounces-368389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D045C9A0F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BBD7285DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC4520F5AB;
	Wed, 16 Oct 2024 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRjC+ivn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC7D20E026
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094848; cv=none; b=IKC3IWofBIvqXUqDnuP1Z2zN5KBTKA8IDfbgpdeeA+QmDFakwko7Fo3ttjyQI6RJezFLYLsPZ7ykGv8W4K7DLUFsYdVCjyZjz2MhG/amyCpXm0VvhFlHJtDwhLkbtdMvTC0H2mBVbyFhWsnOMTImNluTyUw7MVbFitJacfhfLw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094848; c=relaxed/simple;
	bh=+Dua7Z0GJyzlQBV+rd2Hbe6TGrUQcvL/edukW/JnAzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRwtqWC32t2j//Ri5/ChOLWww3LQLcCcjfRnIQ3Urdqosn2L8Y96bcm6u9P4nT892mu5XX9t3jZw90r+XSLnPrZb24umb108dsg1WQKiwZ53sSg3pRs3Q+TT3vPiG3meZutRAHVgPN2UhIJhlCFvSkpQz8VTELEb0EDf/xYqRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRjC+ivn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16C9C4CEC5;
	Wed, 16 Oct 2024 16:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729094845;
	bh=+Dua7Z0GJyzlQBV+rd2Hbe6TGrUQcvL/edukW/JnAzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRjC+ivnzJyeNxqZzYEK3W1UZPmK6LvTscyPiuMkafdtHM6wH7Y+9txDLo+rHMpe4
	 +KI3cjvKKuRXhTVa4Pc2avzpSXXUmj9fwD5twM0rMeXOlPHJ1/FLD0meLEpUsYr+MQ
	 B7hY4gw486vmAuMbiQrRR3PtgMmUDEQ0UF/CKKyAQbK+rbSRK0/YEPhv+GU9Wg7iST
	 BPENyegB/4wsfZa0RW8Rt6jNnuUdbiNAtVksdQcqscyPfxHrqdC0YJG6K59lniw/HT
	 uiR6cik+DpAnSB0PLagz3pHXTiBGg2gT2MtkZIgKWOg7LonJV0XkekVaJ2UdqIpzIV
	 9FdeeGRTA7Y2g==
Date: Wed, 16 Oct 2024 16:07:24 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to parse temperature correctly in
 f2fs_get_segment_temp()
Message-ID: <Zw_kvFpU53626D90@google.com>
References: <20241016082038.607358-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016082038.607358-1-chao@kernel.org>

On 10/16, Chao Yu wrote:
> In __get_segment_type(), __get_segment_type_6() may return
> CURSEG_COLD_DATA_PINNED or CURSEG_ALL_DATA_ATGC log type, but
> following f2fs_get_segment_temp() can only handle persistent
> log type, fix it.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h    |  5 +++--
>  fs/f2fs/file.c    |  4 ++--
>  fs/f2fs/segment.c | 33 +++++++++++++++++++++++++--------
>  fs/f2fs/segment.h |  4 ----
>  4 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index ce00cb546f4a..bda61d7ca8dd 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1019,7 +1019,7 @@ static inline void set_new_dnode(struct dnode_of_data *dn, struct inode *inode,
>  #define NR_CURSEG_PERSIST_TYPE	(NR_CURSEG_DATA_TYPE + NR_CURSEG_NODE_TYPE)
>  #define NR_CURSEG_TYPE		(NR_CURSEG_INMEM_TYPE + NR_CURSEG_PERSIST_TYPE)
>  
> -enum {
> +enum log_type {
>  	CURSEG_HOT_DATA	= 0,	/* directory entry blocks */
>  	CURSEG_WARM_DATA,	/* data blocks */
>  	CURSEG_COLD_DATA,	/* multimedia or GCed data blocks */
> @@ -3758,7 +3758,8 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
>  			block_t old_addr, block_t new_addr,
>  			unsigned char version, bool recover_curseg,
>  			bool recover_newaddr);
> -int f2fs_get_segment_temp(int seg_type);
> +enum temp_type f2fs_get_segment_temp(struct f2fs_sb_info *sbi,
> +						enum log_type seg_type);
>  int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  			block_t old_blkaddr, block_t *new_blkaddr,
>  			struct f2fs_summary *sum, int type,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 0e07231dc093..92d7c62eba29 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4858,8 +4858,8 @@ static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
>  {
>  	struct inode *inode = iter->inode;
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> -	int seg_type = f2fs_rw_hint_to_seg_type(sbi, inode->i_write_hint);
> -	enum temp_type temp = f2fs_get_segment_temp(seg_type);
> +	enum log_type type = f2fs_rw_hint_to_seg_type(sbi, inode->i_write_hint);
> +	enum temp_type temp = f2fs_get_segment_temp(sbi, type);
>  
>  	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
>  	submit_bio(bio);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 859d70bbc5e7..3ed689157891 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3582,18 +3582,35 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>  	}
>  }
>  
> -int f2fs_get_segment_temp(int seg_type)
> +enum temp_type f2fs_get_segment_temp(struct f2fs_sb_info *sbi,
> +						enum log_type type)
>  {
> -	if (IS_HOT(seg_type))
> -		return HOT;
> -	else if (IS_WARM(seg_type))
> -		return WARM;
> -	return COLD;
> +	struct curseg_info *curseg = CURSEG_I(sbi, type);
> +	enum temp_type temp;

To avoid static compilier complaint:

error: variable 'temp' is used uninitialized whenever switch default is taken

let's assign one.

	enum temp_type temp = COLD;

> +
> +	switch (curseg->seg_type) {
> +	case CURSEG_HOT_NODE:
> +	case CURSEG_HOT_DATA:
> +		temp = HOT;
> +		break;
> +	case CURSEG_WARM_NODE:
> +	case CURSEG_WARM_DATA:
> +		temp = WARM;
> +		break;
> +	case CURSEG_COLD_NODE:
> +	case CURSEG_COLD_DATA:
> +		temp = COLD;
> +		break;
> +	default:
> +		f2fs_bug_on(sbi, 1);
> +	}
> +
> +	return temp;
>  }
>  
>  static int __get_segment_type(struct f2fs_io_info *fio)
>  {
> -	int type = 0;
> +	enum log_type type;
>  
>  	switch (F2FS_OPTION(fio->sbi).active_logs) {
>  	case 2:
> @@ -3609,7 +3626,7 @@ static int __get_segment_type(struct f2fs_io_info *fio)
>  		f2fs_bug_on(fio->sbi, true);
>  	}
>  
> -	fio->temp = f2fs_get_segment_temp(type);
> +	fio->temp = f2fs_get_segment_temp(fio->sbi, type);
>  
>  	return type;
>  }
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 55a01da6c4be..6a23bb1d16a2 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -34,10 +34,6 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
>  	f2fs_bug_on(sbi, seg_type >= NR_PERSISTENT_LOG);
>  }
>  
> -#define IS_HOT(t)	((t) == CURSEG_HOT_NODE || (t) == CURSEG_HOT_DATA)
> -#define IS_WARM(t)	((t) == CURSEG_WARM_NODE || (t) == CURSEG_WARM_DATA)
> -#define IS_COLD(t)	((t) == CURSEG_COLD_NODE || (t) == CURSEG_COLD_DATA)
> -
>  #define IS_CURSEG(sbi, seg)						\
>  	(((seg) == CURSEG_I(sbi, CURSEG_HOT_DATA)->segno) ||	\
>  	 ((seg) == CURSEG_I(sbi, CURSEG_WARM_DATA)->segno) ||	\
> -- 
> 2.40.1

