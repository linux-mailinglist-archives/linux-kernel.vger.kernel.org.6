Return-Path: <linux-kernel+bounces-341700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D52E9883E3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E37AB24350
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C85518B477;
	Fri, 27 Sep 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kKPtDwqD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pUE0oEvx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kKPtDwqD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pUE0oEvx"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E749413D889
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438779; cv=none; b=su9whPV7x3MEEngE4WMn11G7Y0SHVekJd74oNeuBFnt7zzP0AToQZ/aF2CaYu+2KECMmBuDzbMHlRGq0XMBbzdEfJmkX0JuBfgTdFODXbNhhP0GqlxQ2NgBdftC6RWtfyLwSl4mhWbuwCP241vH80z89BKQPr+WCU61VkwGEsY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438779; c=relaxed/simple;
	bh=/IXRJ5K9Q5RlRRVn1z5FS2KFrDfuCw2/9imGrzQlWLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQ6ynL+P/Tso3EEIbNCDZnUe1iYREdcXRQkopS0cxccg9ufC9XdDpqcuyyE/13l9KoN7Ny15XuVdYwDFMIwFcaCYUeqitMxl3jMCSnifBWoNIDdnO4sxOqp5+MrDl49FItbRYBn6++4V0wB5ZabMeubzBBhVWRMCtsYkTnC3kMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kKPtDwqD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pUE0oEvx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kKPtDwqD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pUE0oEvx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0799C1FB6A;
	Fri, 27 Sep 2024 12:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727438775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6/rLacMMUqaRmHotAFumxoIQjlS0hP/1/SPCnzHqlSc=;
	b=kKPtDwqDdoyI4iSGNOIYcwXgXsMEVX2F9NI9LuJAI2Ffg8GdnxbhMH+PJYOMP0ZJvT8Mhc
	UgEd7YvtulHzyK/rjicHTMaZ/Vxv6a7wLyKnAooln5wckRHNF20tpbMK29qn5yfiWRDlHn
	o12FG6C5jjBS5atOPf28nWuA9FJKFU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727438775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6/rLacMMUqaRmHotAFumxoIQjlS0hP/1/SPCnzHqlSc=;
	b=pUE0oEvxQtKWP3SjOEvnq+KyYGnuuGlGWGKUvia28vB++xkovouGZraEMEpIoJCJfKYmbz
	6qOgTaqZPZGgb9Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727438775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6/rLacMMUqaRmHotAFumxoIQjlS0hP/1/SPCnzHqlSc=;
	b=kKPtDwqDdoyI4iSGNOIYcwXgXsMEVX2F9NI9LuJAI2Ffg8GdnxbhMH+PJYOMP0ZJvT8Mhc
	UgEd7YvtulHzyK/rjicHTMaZ/Vxv6a7wLyKnAooln5wckRHNF20tpbMK29qn5yfiWRDlHn
	o12FG6C5jjBS5atOPf28nWuA9FJKFU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727438775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6/rLacMMUqaRmHotAFumxoIQjlS0hP/1/SPCnzHqlSc=;
	b=pUE0oEvxQtKWP3SjOEvnq+KyYGnuuGlGWGKUvia28vB++xkovouGZraEMEpIoJCJfKYmbz
	6qOgTaqZPZGgb9Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC36813A73;
	Fri, 27 Sep 2024 12:06:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IielObaf9mZ1eAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Sep 2024 12:06:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AE647A0826; Fri, 27 Sep 2024 14:06:14 +0200 (CEST)
Date: Fri, 27 Sep 2024 14:06:14 +0200
From: Jan Kara <jack@suse.cz>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: jack@suse.com, zhaomengmeng@kylinos.cn, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] udf: refactor udf_next_aext() to handle error
Message-ID: <20240927120614.gui56kr2t24htwba@quack3>
References: <20240926120753.3639404-1-zhaomzhao@126.com>
 <20240926120753.3639404-3-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926120753.3639404-3-zhaomzhao@126.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[126.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[126.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 26-09-24 20:07:52, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> Since udf_current_aext() has error handling, udf_next_aext() should have
> error handling too. Besides, when too many indirect extents found in one
> inode, return -EFSCORRUPTED; when reading block failed, return -EIO.
> 
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> Suggested-by: Jan Kara <jack@suse.cz>

This patch looks good to me now.

								Honza

> ---
>  fs/udf/balloc.c    | 22 +++++++----
>  fs/udf/directory.c | 10 ++++-
>  fs/udf/inode.c     | 99 ++++++++++++++++++++++++++++++----------------
>  fs/udf/super.c     |  3 +-
>  fs/udf/truncate.c  | 23 ++++++++---
>  fs/udf/udfdecl.h   |  5 ++-
>  6 files changed, 110 insertions(+), 52 deletions(-)
> 
> diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
> index d8fc11765d61..99cf8fbc805e 100644
> --- a/fs/udf/balloc.c
> +++ b/fs/udf/balloc.c
> @@ -370,6 +370,7 @@ static void udf_table_free_blocks(struct super_block *sb,
>  	struct extent_position oepos, epos;
>  	int8_t etype;
>  	struct udf_inode_info *iinfo;
> +	int err = 0;
>  
>  	mutex_lock(&sbi->s_alloc_mutex);
>  	iinfo = UDF_I(table);
> @@ -384,7 +385,7 @@ static void udf_table_free_blocks(struct super_block *sb,
>  	epos.bh = oepos.bh = NULL;
>  
>  	while (count &&
> -	       (etype = udf_next_aext(table, &epos, &eloc, &elen, 1)) != -1) {
> +	       !(err = udf_next_aext(table, &epos, &eloc, &elen, &etype, 1))) {
>  		if (((eloc.logicalBlockNum +
>  			(elen >> sb->s_blocksize_bits)) == start)) {
>  			if ((0x3FFFFFFF - elen) <
> @@ -435,6 +436,9 @@ static void udf_table_free_blocks(struct super_block *sb,
>  		}
>  	}
>  
> +	if (UDF_EXT_ERR(err))
> +		goto error_return;
> +
>  	if (count) {
>  		/*
>  		 * NOTE: we CANNOT use udf_add_aext here, as it can try to
> @@ -460,8 +464,6 @@ static void udf_table_free_blocks(struct super_block *sb,
>  		else if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_LONG)
>  			adsize = sizeof(struct long_ad);
>  		else {
> -			brelse(oepos.bh);
> -			brelse(epos.bh);
>  			goto error_return;
>  		}
>  
> @@ -479,10 +481,10 @@ static void udf_table_free_blocks(struct super_block *sb,
>  			__udf_add_aext(table, &epos, &eloc, elen, 1);
>  	}
>  
> +error_return:
>  	brelse(epos.bh);
>  	brelse(oepos.bh);
>  
> -error_return:
>  	mutex_unlock(&sbi->s_alloc_mutex);
>  	return;
>  }
> @@ -498,6 +500,7 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
>  	struct extent_position epos;
>  	int8_t etype = -1;
>  	struct udf_inode_info *iinfo;
> +	int err = 0;
>  
>  	if (first_block >= sbi->s_partmaps[partition].s_partition_len)
>  		return 0;
> @@ -517,12 +520,15 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
>  	eloc.logicalBlockNum = 0xFFFFFFFF;
>  
>  	while (first_block != eloc.logicalBlockNum &&
> -	       (etype = udf_next_aext(table, &epos, &eloc, &elen, 1)) != -1) {
> +	       !(err = udf_next_aext(table, &epos, &eloc, &elen, &etype, 1))) {
>  		udf_debug("eloc=%u, elen=%u, first_block=%u\n",
>  			  eloc.logicalBlockNum, elen, first_block);
>  		; /* empty loop body */
>  	}
>  
> +	if (UDF_EXT_ERR(err))
> +		goto err_out;
> +
>  	if (first_block == eloc.logicalBlockNum) {
>  		epos.offset -= adsize;
>  
> @@ -539,6 +545,7 @@ static int udf_table_prealloc_blocks(struct super_block *sb,
>  		alloc_count = 0;
>  	}
>  
> +err_out:
>  	brelse(epos.bh);
>  
>  	if (alloc_count)
> @@ -560,6 +567,7 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
>  	struct extent_position epos, goal_epos;
>  	int8_t etype;
>  	struct udf_inode_info *iinfo = UDF_I(table);
> +	int ret = 0;
>  
>  	*err = -ENOSPC;
>  
> @@ -584,7 +592,7 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
>  	epos.bh = goal_epos.bh = NULL;
>  
>  	while (spread &&
> -	       (etype = udf_next_aext(table, &epos, &eloc, &elen, 1)) != -1) {
> +	       !(ret = udf_next_aext(table, &epos, &eloc, &elen, &etype, 1))) {
>  		if (goal >= eloc.logicalBlockNum) {
>  			if (goal < eloc.logicalBlockNum +
>  					(elen >> sb->s_blocksize_bits))
> @@ -612,7 +620,7 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
>  
>  	brelse(epos.bh);
>  
> -	if (spread == 0xFFFFFFFF) {
> +	if (UDF_EXT_ERR(ret) || spread == 0xFFFFFFFF) {
>  		brelse(goal_epos.bh);
>  		mutex_unlock(&sbi->s_alloc_mutex);
>  		return 0;
> diff --git a/fs/udf/directory.c b/fs/udf/directory.c
> index 93153665eb37..82922a4ae425 100644
> --- a/fs/udf/directory.c
> +++ b/fs/udf/directory.c
> @@ -166,13 +166,19 @@ static struct buffer_head *udf_fiiter_bread_blk(struct udf_fileident_iter *iter)
>   */
>  static int udf_fiiter_advance_blk(struct udf_fileident_iter *iter)
>  {
> +	int8_t etype = -1;
> +	int err = 0;
> +
>  	iter->loffset++;
>  	if (iter->loffset < DIV_ROUND_UP(iter->elen, 1<<iter->dir->i_blkbits))
>  		return 0;
>  
>  	iter->loffset = 0;
> -	if (udf_next_aext(iter->dir, &iter->epos, &iter->eloc, &iter->elen, 1)
> -			!= (EXT_RECORDED_ALLOCATED >> 30)) {
> +	err = udf_next_aext(iter->dir, &iter->epos, &iter->eloc, &iter->elen,
> +			    &etype, 1);
> +	if (UDF_EXT_ERR(err))
> +		return err;
> +	else if (UDF_EXT_EOF(err) || etype != (EXT_RECORDED_ALLOCATED >> 30)) {
>  		if (iter->pos == iter->dir->i_size) {
>  			iter->elen = 0;
>  			return 0;
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 3be59aa8d4fd..6c4f104e2bf7 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -545,6 +545,7 @@ static int udf_do_extend_file(struct inode *inode,
>  	} else {
>  		struct kernel_lb_addr tmploc;
>  		uint32_t tmplen;
> +		int8_t tmptype;
>  
>  		udf_write_aext(inode, last_pos, &last_ext->extLocation,
>  				last_ext->extLength, 1);
> @@ -554,8 +555,12 @@ static int udf_do_extend_file(struct inode *inode,
>  		 * more extents, we may need to enter possible following
>  		 * empty indirect extent.
>  		 */
> -		if (new_block_bytes)
> -			udf_next_aext(inode, last_pos, &tmploc, &tmplen, 0);
> +		if (new_block_bytes) {
> +			err = udf_next_aext(inode, last_pos, &tmploc, &tmplen,
> +					    &tmptype, 0);
> +			if (UDF_EXT_ERR(err))
> +				goto out_err;
> +		}
>  	}
>  	iinfo->i_lenExtents += add;
>  
> @@ -674,8 +679,10 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
>  		extent.extLength = EXT_NOT_RECORDED_NOT_ALLOCATED;
>  	} else {
>  		epos.offset -= adsize;
> -		etype = udf_next_aext(inode, &epos, &extent.extLocation,
> -				      &extent.extLength, 0);
> +		err = udf_next_aext(inode, &epos, &extent.extLocation,
> +				    &extent.extLength, &etype, 0);
> +		if (UDF_EXT_ERR(err))
> +			goto out;
>  		extent.extLength |= etype << 30;
>  	}
>  
> @@ -712,11 +719,11 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>  	loff_t lbcount = 0, b_off = 0;
>  	udf_pblk_t newblocknum;
>  	sector_t offset = 0;
> -	int8_t etype;
> +	int8_t etype, tmpetype;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
>  	udf_pblk_t goal = 0, pgoal = iinfo->i_location.logicalBlockNum;
>  	int lastblock = 0;
> -	bool isBeyondEOF;
> +	bool isBeyondEOF = false;
>  	int ret = 0;
>  
>  	prev_epos.offset = udf_file_entry_alloc_offset(inode);
> @@ -748,9 +755,12 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>  		prev_epos.offset = cur_epos.offset;
>  		cur_epos.offset = next_epos.offset;
>  
> -		etype = udf_next_aext(inode, &next_epos, &eloc, &elen, 1);
> -		if (etype == -1)
> +		ret = udf_next_aext(inode, &next_epos, &eloc, &elen, &etype, 1);
> +		if (UDF_EXT_EOF(ret)) {
> +			isBeyondEOF = true;
>  			break;
> +		} else if (ret < 0)
> +			goto out_free;
>  
>  		c = !c;
>  
> @@ -771,8 +781,12 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>  	 * Move prev_epos and cur_epos into indirect extent if we are at
>  	 * the pointer to it
>  	 */
> -	udf_next_aext(inode, &prev_epos, &tmpeloc, &tmpelen, 0);
> -	udf_next_aext(inode, &cur_epos, &tmpeloc, &tmpelen, 0);
> +	ret = udf_next_aext(inode, &prev_epos, &tmpeloc, &tmpelen, &tmpetype, 0);
> +	if (UDF_EXT_ERR(ret))
> +		goto out_free;
> +	ret = udf_next_aext(inode, &cur_epos, &tmpeloc, &tmpelen, &tmpetype, 0);
> +	if (UDF_EXT_ERR(ret))
> +		goto out_free;
>  
>  	/* if the extent is allocated and recorded, return the block
>  	   if the extent is not a multiple of the blocksize, round up */
> @@ -793,10 +807,9 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>  	}
>  
>  	/* Are we beyond EOF and preallocated extent? */
> -	if (etype == -1) {
> +	if (isBeyondEOF) {
>  		loff_t hole_len;
>  
> -		isBeyondEOF = true;
>  		if (count) {
>  			if (c)
>  				laarr[0] = laarr[1];
> @@ -832,7 +845,6 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>  		endnum = c + 1;
>  		lastblock = 1;
>  	} else {
> -		isBeyondEOF = false;
>  		endnum = startnum = ((count > 2) ? 2 : count);
>  
>  		/* if the current extent is in position 0,
> @@ -846,15 +858,17 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>  
>  		/* if the current block is located in an extent,
>  		   read the next extent */
> -		etype = udf_next_aext(inode, &next_epos, &eloc, &elen, 0);
> -		if (etype != -1) {
> +		ret = udf_next_aext(inode, &next_epos, &eloc, &elen, &etype, 0);
> +		if (!ret) {
>  			laarr[c + 1].extLength = (etype << 30) | elen;
>  			laarr[c + 1].extLocation = eloc;
>  			count++;
>  			startnum++;
>  			endnum++;
> -		} else
> +		} else if (UDF_EXT_EOF(ret))
>  			lastblock = 1;
> +		else
> +			goto out_free;
>  	}
>  
>  	/* if the current extent is not recorded but allocated, get the
> @@ -1172,6 +1186,7 @@ static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
>  	int start = 0, i;
>  	struct kernel_lb_addr tmploc;
>  	uint32_t tmplen;
> +	int8_t tmpetype;
>  	int err;
>  
>  	if (startnum > endnum) {
> @@ -1189,14 +1204,19 @@ static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
>  			 */
>  			if (err < 0)
>  				return err;
> -			udf_next_aext(inode, epos, &laarr[i].extLocation,
> -				      &laarr[i].extLength, 1);
> +			err = udf_next_aext(inode, epos, &laarr[i].extLocation,
> +				      &laarr[i].extLength, &tmpetype, 1);
> +			if (UDF_EXT_ERR(err))
> +				return err;
>  			start++;
>  		}
>  	}
>  
>  	for (i = start; i < endnum; i++) {
> -		udf_next_aext(inode, epos, &tmploc, &tmplen, 0);
> +		err = udf_next_aext(inode, epos, &tmploc, &tmplen, &tmpetype, 0);
> +		if (UDF_EXT_ERR(err))
> +			return err;
> +
>  		udf_write_aext(inode, epos, &laarr[i].extLocation,
>  			       laarr[i].extLength, 1);
>  	}
> @@ -2168,15 +2188,15 @@ void udf_write_aext(struct inode *inode, struct extent_position *epos,
>   */
>  #define UDF_MAX_INDIR_EXTS 16
>  
> -int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
> -		     struct kernel_lb_addr *eloc, uint32_t *elen, int inc)
> +int udf_next_aext(struct inode *inode, struct extent_position *epos,
> +		  struct kernel_lb_addr *eloc, uint32_t *elen, int8_t *etype,
> +		  int inc)
>  {
> -	int8_t etype;
>  	unsigned int indirections = 0;
>  	int err = 0;
>  
> -	while ((err = udf_current_aext(inode, epos, eloc, elen, &etype, inc))) {
> -		if (err || etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
> +	while ((err = udf_current_aext(inode, epos, eloc, elen, etype, inc))) {
> +		if (err || *etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
>  			break;
>  
>  		udf_pblk_t block;
> @@ -2185,7 +2205,7 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
>  			udf_err(inode->i_sb,
>  				"too many indirect extents in inode %lu\n",
>  				inode->i_ino);
> -			return -1;
> +			return -EFSCORRUPTED;
>  		}
>  
>  		epos->block = *eloc;
> @@ -2195,11 +2215,11 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
>  		epos->bh = sb_bread(inode->i_sb, block);
>  		if (!epos->bh) {
>  			udf_debug("reading block %u failed!\n", block);
> -			return -1;
> +			return -EIO;
>  		}
>  	}
>  
> -	return !err ? etype : -1;
> +	return err;
>  }
>  
>  int udf_current_aext(struct inode *inode, struct extent_position *epos,
> @@ -2267,12 +2287,14 @@ static int udf_insert_aext(struct inode *inode, struct extent_position epos,
>  	if (epos.bh)
>  		get_bh(epos.bh);
>  
> -	while ((etype = udf_next_aext(inode, &epos, &oeloc, &oelen, 0)) != -1) {
> +	while (!(err = udf_next_aext(inode, &epos, &oeloc,
> +				     &oelen, &etype, 0))) {
>  		udf_write_aext(inode, &epos, &neloc, nelen, 1);
>  		neloc = oeloc;
>  		nelen = (etype << 30) | oelen;
>  	}
> -	err = udf_add_aext(inode, &epos, &neloc, nelen, 1);
> +	if (UDF_EXT_EOF(err))
> +		err = udf_add_aext(inode, &epos, &neloc, nelen, 1);
>  	brelse(epos.bh);
>  
>  	return err;
> @@ -2287,6 +2309,7 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
>  	struct udf_inode_info *iinfo;
>  	struct kernel_lb_addr eloc;
>  	uint32_t elen;
> +	int err = 0;
>  
>  	if (epos.bh) {
>  		get_bh(epos.bh);
> @@ -2302,10 +2325,11 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
>  		adsize = 0;
>  
>  	oepos = epos;
> -	if (udf_next_aext(inode, &epos, &eloc, &elen, 1) == -1)
> +	err = udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1);
> +	if (UDF_EXT_ERR(err))
>  		return -1;
>  
> -	while ((etype = udf_next_aext(inode, &epos, &eloc, &elen, 1)) != -1) {
> +	while (!(err = udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1))) {
>  		udf_write_aext(inode, &oepos, &eloc, (etype << 30) | elen, 1);
>  		if (oepos.bh != epos.bh) {
>  			oepos.block = epos.block;
> @@ -2315,6 +2339,11 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
>  			oepos.offset = epos.offset - adsize;
>  		}
>  	}
> +	if (UDF_EXT_ERR(err)) {
> +		brelse(epos.bh);
> +		brelse(oepos.bh);
> +		return -1;
> +	}
>  	memset(&eloc, 0x00, sizeof(struct kernel_lb_addr));
>  	elen = 0;
>  
> @@ -2370,6 +2399,7 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
>  	loff_t lbcount = 0, bcount = (loff_t) block << blocksize_bits;
>  	int8_t etype;
>  	struct udf_inode_info *iinfo;
> +	int err = 0;
>  
>  	iinfo = UDF_I(inode);
>  	if (!udf_read_extent_cache(inode, bcount, &lbcount, pos)) {
> @@ -2379,12 +2409,13 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
>  	}
>  	*elen = 0;
>  	do {
> -		etype = udf_next_aext(inode, pos, eloc, elen, 1);
> -		if (etype == -1) {
> +		err = udf_next_aext(inode, pos, eloc, elen, &etype, 1);
> +		if (UDF_EXT_EOF(err)) {
>  			*offset = (bcount - lbcount) >> blocksize_bits;
>  			iinfo->i_lenExtents = lbcount;
> -			return -1;
>  		}
> +		if (err < 0)
> +			return -1;
>  		lbcount += *elen;
>  	} while (lbcount <= bcount);
>  	/* update extent cache */
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 3460ecc826d1..8c34224e1aee 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -2482,13 +2482,14 @@ static unsigned int udf_count_free_table(struct super_block *sb,
>  	uint32_t elen;
>  	struct kernel_lb_addr eloc;
>  	struct extent_position epos;
> +	int8_t etype;
>  
>  	mutex_lock(&UDF_SB(sb)->s_alloc_mutex);
>  	epos.block = UDF_I(table)->i_location;
>  	epos.offset = sizeof(struct unallocSpaceEntry);
>  	epos.bh = NULL;
>  
> -	while (udf_next_aext(table, &epos, &eloc, &elen, 1) != -1)
> +	while (!udf_next_aext(table, &epos, &eloc, &elen, &etype, 1))
>  		accum += (elen >> table->i_sb->s_blocksize_bits);
>  
>  	brelse(epos.bh);
> diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
> index 16db2613401d..af06f7101859 100644
> --- a/fs/udf/truncate.c
> +++ b/fs/udf/truncate.c
> @@ -69,6 +69,7 @@ void udf_truncate_tail_extent(struct inode *inode)
>  	int8_t etype = -1, netype;
>  	int adsize;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
> +	int err = 0;
>  
>  	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB ||
>  	    inode->i_size == iinfo->i_lenExtents)
> @@ -85,7 +86,7 @@ void udf_truncate_tail_extent(struct inode *inode)
>  		BUG();
>  
>  	/* Find the last extent in the file */
> -	while ((netype = udf_next_aext(inode, &epos, &eloc, &elen, 1)) != -1) {
> +	while (!(err = udf_next_aext(inode, &epos, &eloc, &elen, &netype, 1))) {
>  		etype = netype;
>  		lbcount += elen;
>  		if (lbcount > inode->i_size) {
> @@ -101,7 +102,7 @@ void udf_truncate_tail_extent(struct inode *inode)
>  			epos.offset -= adsize;
>  			extent_trunc(inode, &epos, &eloc, etype, elen, nelen);
>  			epos.offset += adsize;
> -			if (udf_next_aext(inode, &epos, &eloc, &elen, 1) != -1)
> +			if (!udf_next_aext(inode, &epos, &eloc, &elen, &netype, 1))
>  				udf_err(inode->i_sb,
>  					"Extent after EOF in inode %u\n",
>  					(unsigned)inode->i_ino);
> @@ -110,7 +111,8 @@ void udf_truncate_tail_extent(struct inode *inode)
>  	}
>  	/* This inode entry is in-memory only and thus we don't have to mark
>  	 * the inode dirty */
> -	iinfo->i_lenExtents = inode->i_size;
> +	if (UDF_EXT_EOF(err))
> +		iinfo->i_lenExtents = inode->i_size;
>  	brelse(epos.bh);
>  }
>  
> @@ -124,6 +126,8 @@ void udf_discard_prealloc(struct inode *inode)
>  	int8_t etype = -1;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
>  	int bsize = i_blocksize(inode);
> +	int8_t tmpetype = -1;
> +	int err = 0;
>  
>  	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB ||
>  	    ALIGN(inode->i_size, bsize) == ALIGN(iinfo->i_lenExtents, bsize))
> @@ -132,16 +136,22 @@ void udf_discard_prealloc(struct inode *inode)
>  	epos.block = iinfo->i_location;
>  
>  	/* Find the last extent in the file */
> -	while (udf_next_aext(inode, &epos, &eloc, &elen, 0) != -1) {
> +	while (!(err = udf_next_aext(inode, &epos, &eloc, &elen, &tmpetype,
> +				     0))) {
>  		brelse(prev_epos.bh);
>  		prev_epos = epos;
>  		if (prev_epos.bh)
>  			get_bh(prev_epos.bh);
>  
> -		etype = udf_next_aext(inode, &epos, &eloc, &elen, 1);
> +		err = udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1);
> +		if (err < 0)
> +			break;
>  		lbcount += elen;
>  	}
> -	if (etype == (EXT_NOT_RECORDED_ALLOCATED >> 30)) {
> +	if (UDF_EXT_ERR(err))
> +		goto out;
> +
> +	if (!err && etype == (EXT_NOT_RECORDED_ALLOCATED >> 30)) {
>  		lbcount -= elen;
>  		udf_delete_aext(inode, prev_epos);
>  		udf_free_blocks(inode->i_sb, inode, &eloc, 0,
> @@ -150,6 +160,7 @@ void udf_discard_prealloc(struct inode *inode)
>  	/* This inode entry is in-memory only and thus we don't have to mark
>  	 * the inode dirty */
>  	iinfo->i_lenExtents = lbcount;
> +out:
>  	brelse(epos.bh);
>  	brelse(prev_epos.bh);
>  }
> diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
> index a902652450dd..206077da9968 100644
> --- a/fs/udf/udfdecl.h
> +++ b/fs/udf/udfdecl.h
> @@ -172,8 +172,9 @@ extern int udf_add_aext(struct inode *, struct extent_position *,
>  extern void udf_write_aext(struct inode *, struct extent_position *,
>  			   struct kernel_lb_addr *, uint32_t, int);
>  extern int8_t udf_delete_aext(struct inode *, struct extent_position);
> -extern int8_t udf_next_aext(struct inode *, struct extent_position *,
> -			    struct kernel_lb_addr *, uint32_t *, int);
> +extern int udf_next_aext(struct inode *inode, struct extent_position *epos,
> +			 struct kernel_lb_addr *eloc, uint32_t *elen,
> +			 int8_t *etype, int inc);
>  extern int udf_current_aext(struct inode *inode, struct extent_position *epos,
>  			    struct kernel_lb_addr *eloc, uint32_t *elen,
>  			    int8_t *etype, int inc);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

