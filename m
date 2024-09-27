Return-Path: <linux-kernel+bounces-341704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450AC9883EA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AA1281E57
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D456918B487;
	Fri, 27 Sep 2024 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OzODtyOy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b49g9la3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OzODtyOy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b49g9la3"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFE18B474
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438978; cv=none; b=oidzSJ2A2ZQByykaUh2MqPaZYbFTVVqJToT7V74oZKcioP7Ih/2NE2t7RVcU2x4DM8/fHAWcb6/Gs2/GCXJ2g7wjegT3d7CkgVA0THLt+FO8E8S0Roe8ok0JHKRCR9EDCyt337EbmK9ymvueXb0w8hLtmzzmlTtd2IZcj60xi3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438978; c=relaxed/simple;
	bh=ZaG5/feq9HG4d/YTQXBOZ1Zq4Z9toYcAKgH74UomcD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1WLuzFZnfDuvEb99Usl/I7thI5wQzNt64P1JhhHHfi+OvvL6i2aQAuDnDzuwK7veO8iMQ70E9yYcbX2R6OVuwovLb6pMUNDFJJN8Nq/6H4tnb1CgHb9rUEgpunYn5Nq+Ouv4iqU60yTzuTMdMjnzAKBRXYR7CYd5Ns4NspZB0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OzODtyOy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b49g9la3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OzODtyOy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b49g9la3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3334B21BB5;
	Fri, 27 Sep 2024 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727438974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vQLDYdfZrXF03N0qIGUmcgJc6mC47sf8TnOc/KOxuP4=;
	b=OzODtyOyJmyFvYtUeGdWkXoJAJuKL41rEnJRR+HM9x/Jr2DC89KT1079qP9UW2it8Fz1Lf
	QwjaTFtvmTHnVTLbn5RzE8p++gI7BaPKf+/IRPdIEuGaxt8E7SI8+pRzFiJ+yx1m2+/eCm
	e93uav3o51quW4lI08SXYkoCW5lzegU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727438974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vQLDYdfZrXF03N0qIGUmcgJc6mC47sf8TnOc/KOxuP4=;
	b=b49g9la38r/R/ang5XhHY9p/6dILXYJLl+WQ6cYWr6IPClCQQEz2rOAKCEhublUA+8VzsC
	BGvojqaEpvh3IbDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727438974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vQLDYdfZrXF03N0qIGUmcgJc6mC47sf8TnOc/KOxuP4=;
	b=OzODtyOyJmyFvYtUeGdWkXoJAJuKL41rEnJRR+HM9x/Jr2DC89KT1079qP9UW2it8Fz1Lf
	QwjaTFtvmTHnVTLbn5RzE8p++gI7BaPKf+/IRPdIEuGaxt8E7SI8+pRzFiJ+yx1m2+/eCm
	e93uav3o51quW4lI08SXYkoCW5lzegU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727438974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vQLDYdfZrXF03N0qIGUmcgJc6mC47sf8TnOc/KOxuP4=;
	b=b49g9la38r/R/ang5XhHY9p/6dILXYJLl+WQ6cYWr6IPClCQQEz2rOAKCEhublUA+8VzsC
	BGvojqaEpvh3IbDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2874A13A73;
	Fri, 27 Sep 2024 12:09:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A2XeCX6g9mZheQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Sep 2024 12:09:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D2252A0826; Fri, 27 Sep 2024 14:09:33 +0200 (CEST)
Date: Fri, 27 Sep 2024 14:09:33 +0200
From: Jan Kara <jack@suse.cz>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: jack@suse.com, zhaomengmeng@kylinos.cn, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] udf: refactor inode_bmap() to handle error
Message-ID: <20240927120933.okzud3qdygqplekm@quack3>
References: <20240926120753.3639404-1-zhaomzhao@126.com>
 <20240926120753.3639404-4-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926120753.3639404-4-zhaomzhao@126.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 26-09-24 20:07:53, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> Refactor inode_bmap() to handle error since udf_next_aext() can return
> error now. On situations like ftruncate, udf_extend_file() can now
> detect errors and bail out early without resorting to checking for
> particular offsets and assuming internal behavior of these functions.
> 
> Reported-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7a4842f0b1801230a989
> Tested-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> Suggested-by: Jan Kara <jack@suse.cz>

This patch looks good to me now too. Thanks!

								Honza

> ---
>  fs/udf/directory.c | 13 ++++++++-----
>  fs/udf/inode.c     | 29 ++++++++++++++++++-----------
>  fs/udf/partition.c |  6 ++++--
>  fs/udf/truncate.c  |  8 +++++---
>  fs/udf/udfdecl.h   |  5 +++--
>  5 files changed, 38 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/udf/directory.c b/fs/udf/directory.c
> index 82922a4ae425..4b8bb77eaffa 100644
> --- a/fs/udf/directory.c
> +++ b/fs/udf/directory.c
> @@ -246,6 +246,7 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
>  {
>  	struct udf_inode_info *iinfo = UDF_I(dir);
>  	int err = 0;
> +	int8_t etype;
>  
>  	iter->dir = dir;
>  	iter->bh[0] = iter->bh[1] = NULL;
> @@ -265,9 +266,9 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
>  		goto out;
>  	}
>  
> -	if (inode_bmap(dir, iter->pos >> dir->i_blkbits, &iter->epos,
> -		       &iter->eloc, &iter->elen, &iter->loffset) !=
> -	    (EXT_RECORDED_ALLOCATED >> 30)) {
> +	err = inode_bmap(dir, iter->pos >> dir->i_blkbits, &iter->epos, &iter->eloc,
> +		   &iter->elen, &iter->loffset, &etype);
> +	if (err || etype != (EXT_RECORDED_ALLOCATED >> 30)) {
>  		if (pos == dir->i_size)
>  			return 0;
>  		udf_err(dir->i_sb,
> @@ -463,6 +464,7 @@ int udf_fiiter_append_blk(struct udf_fileident_iter *iter)
>  	sector_t block;
>  	uint32_t old_elen = iter->elen;
>  	int err;
> +	int8_t etype;
>  
>  	if (WARN_ON_ONCE(iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB))
>  		return -EINVAL;
> @@ -477,8 +479,9 @@ int udf_fiiter_append_blk(struct udf_fileident_iter *iter)
>  		udf_fiiter_update_elen(iter, old_elen);
>  		return err;
>  	}
> -	if (inode_bmap(iter->dir, block, &iter->epos, &iter->eloc, &iter->elen,
> -		       &iter->loffset) != (EXT_RECORDED_ALLOCATED >> 30)) {
> +	err = inode_bmap(iter->dir, block, &iter->epos, &iter->eloc, &iter->elen,
> +		   &iter->loffset, &etype);
> +	if (err || etype != (EXT_RECORDED_ALLOCATED >> 30)) {
>  		udf_err(iter->dir->i_sb,
>  			"block %llu not allocated in directory (ino %lu)\n",
>  			(unsigned long long)block, iter->dir->i_ino);
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 6c4f104e2bf7..be9356f0eecf 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -418,10 +418,11 @@ static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
>  		uint32_t elen;
>  		sector_t offset;
>  		struct extent_position epos = {};
> +		int8_t etype;
>  
>  		down_read(&iinfo->i_data_sem);
> -		if (inode_bmap(inode, map->lblk, &epos, &eloc, &elen, &offset)
> -				== (EXT_RECORDED_ALLOCATED >> 30)) {
> +		err = inode_bmap(inode, map->lblk, &epos, &eloc, &elen, &offset, &etype);
> +		if (!err && etype == (EXT_RECORDED_ALLOCATED >> 30)) {
>  			map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc,
>  							offset);
>  			map->oflags |= UDF_BLK_MAPPED;
> @@ -664,8 +665,10 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
>  	 */
>  	udf_discard_prealloc(inode);
>  
> -	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
> -	within_last_ext = (etype != -1);
> +	err = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset, &etype);
> +	if (UDF_EXT_ERR(err))
> +		goto out;
> +	within_last_ext = (!err);
>  	/* We don't expect extents past EOF... */
>  	WARN_ON_ONCE(within_last_ext &&
>  		     elen > ((loff_t)offset + 1) << inode->i_blkbits);
> @@ -2391,13 +2394,17 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
>  	return (elen >> 30);
>  }
>  
> -int8_t inode_bmap(struct inode *inode, sector_t block,
> -		  struct extent_position *pos, struct kernel_lb_addr *eloc,
> -		  uint32_t *elen, sector_t *offset)
> +/*
> + * return 0 when iudf_next_aext() loop success.
> + * return err < 0 and err != -ENODATA indicates error.
> + * return err == -ENODATA indicates hit EOF.
> + */
> +int inode_bmap(struct inode *inode, sector_t block, struct extent_position *pos,
> +	       struct kernel_lb_addr *eloc, uint32_t *elen, sector_t *offset,
> +	       int8_t *etype)
>  {
>  	unsigned char blocksize_bits = inode->i_sb->s_blocksize_bits;
>  	loff_t lbcount = 0, bcount = (loff_t) block << blocksize_bits;
> -	int8_t etype;
>  	struct udf_inode_info *iinfo;
>  	int err = 0;
>  
> @@ -2409,18 +2416,18 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
>  	}
>  	*elen = 0;
>  	do {
> -		err = udf_next_aext(inode, pos, eloc, elen, &etype, 1);
> +		err = udf_next_aext(inode, pos, eloc, elen, etype, 1);
>  		if (UDF_EXT_EOF(err)) {
>  			*offset = (bcount - lbcount) >> blocksize_bits;
>  			iinfo->i_lenExtents = lbcount;
>  		}
>  		if (err < 0)
> -			return -1;
> +			return err;
>  		lbcount += *elen;
>  	} while (lbcount <= bcount);
>  	/* update extent cache */
>  	udf_update_extent_cache(inode, lbcount - *elen, pos);
>  	*offset = (bcount + *elen - lbcount) >> blocksize_bits;
>  
> -	return etype;
> +	return 0;
>  }
> diff --git a/fs/udf/partition.c b/fs/udf/partition.c
> index af877991edc1..c441d4ae1f96 100644
> --- a/fs/udf/partition.c
> +++ b/fs/udf/partition.c
> @@ -282,9 +282,11 @@ static uint32_t udf_try_read_meta(struct inode *inode, uint32_t block,
>  	sector_t ext_offset;
>  	struct extent_position epos = {};
>  	uint32_t phyblock;
> +	int8_t etype;
> +	int err = 0;
>  
> -	if (inode_bmap(inode, block, &epos, &eloc, &elen, &ext_offset) !=
> -						(EXT_RECORDED_ALLOCATED >> 30))
> +	err = inode_bmap(inode, block, &epos, &eloc, &elen, &ext_offset, &etype);
> +	if (err || etype != (EXT_RECORDED_ALLOCATED >> 30))
>  		phyblock = 0xFFFFFFFF;
>  	else {
>  		map = &UDF_SB(sb)->s_partmaps[partition];
> diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
> index af06f7101859..d13ba9fd1309 100644
> --- a/fs/udf/truncate.c
> +++ b/fs/udf/truncate.c
> @@ -208,10 +208,12 @@ int udf_truncate_extents(struct inode *inode)
>  	else
>  		BUG();
>  
> -	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
> +	err = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset, &etype);
>  	byte_offset = (offset << sb->s_blocksize_bits) +
> -		(inode->i_size & (sb->s_blocksize - 1));
> -	if (etype == -1) {
> +		      (inode->i_size & (sb->s_blocksize - 1));
> +	if (UDF_EXT_ERR(err))
> +		return err;
> +	if (UDF_EXT_EOF(err)) {
>  		/* We should extend the file? */
>  		WARN_ON(byte_offset);
>  		return 0;
> diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
> index 206077da9968..a156ed95189a 100644
> --- a/fs/udf/udfdecl.h
> +++ b/fs/udf/udfdecl.h
> @@ -160,8 +160,9 @@ extern struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
>  extern int udf_setsize(struct inode *, loff_t);
>  extern void udf_evict_inode(struct inode *);
>  extern int udf_write_inode(struct inode *, struct writeback_control *wbc);
> -extern int8_t inode_bmap(struct inode *, sector_t, struct extent_position *,
> -			 struct kernel_lb_addr *, uint32_t *, sector_t *);
> +extern int inode_bmap(struct inode *inode, sector_t block,
> +		      struct extent_position *pos, struct kernel_lb_addr *eloc,
> +		      uint32_t *elen, sector_t *offset, int8_t *etype);
>  int udf_get_block(struct inode *, sector_t, struct buffer_head *, int);
>  extern int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
>  				   struct extent_position *epos);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

