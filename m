Return-Path: <linux-kernel+bounces-334484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5950F97D7DA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC694B23733
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9604E17BEC8;
	Fri, 20 Sep 2024 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2z8MPsVt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PAT8OtxC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2z8MPsVt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PAT8OtxC"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8500F176AC5
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726847236; cv=none; b=nnjTmPRJWc/7hRY+BEo/3Cku01bi2niVEU0gziYjH/mZ+diJEBjjRRy35i9f6G9klhW0ivDHDC/9SeL/FhlOLnhcp0dpfdK0G/1I6TV4AJfxb+bIp5RKIo862zojEYshcCgaQnnA9IVMXIzw1eMegRe9mx7MkwiZTXvFr/1R6EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726847236; c=relaxed/simple;
	bh=kqVbgwMwTS82565Ti6pCXogawMUznUK/LYhZ0fqPqXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYot6fBRc4H3uUHi7QGdODsfdnNrp5IC36yxpz4ck8GdrjbOPXbj5SQF4yRRGTOHoNQAvBLF9IWbGByBkxJdSXU04JlNBPzLwnUmXJbmYovlHfn7gPCILefUX2CtmvzOSkoQHVACSwZWJIKtjOfLaYeIby1LNJUnbPD/3HUXJ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2z8MPsVt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PAT8OtxC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2z8MPsVt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PAT8OtxC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0EB1D33A34;
	Fri, 20 Sep 2024 15:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726847230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3m9MhlSmL+bMGFu2eBCkzGukP5BgDCESlSHlhmD47s=;
	b=2z8MPsVt+2tR0rnc9D9YXrQlgApFvQTZbZQn8maIGaeERhqInmUXQqnb5ecoEKULJbZJde
	PLzkmsz9ss9W5SyzD6TqroYMwa+yAjJV9L7e64K1bQ8W1MsPXvTyzuWsvQVoDO++UnWsug
	r0CpUU917gCaiyM3Gcw4uwYF7Ic3BD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726847230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3m9MhlSmL+bMGFu2eBCkzGukP5BgDCESlSHlhmD47s=;
	b=PAT8OtxCQLjEct5LI9qwsqMUDG5vPLeTziLQQo1LkavA6Dh0YgTOww6OD3XaggQKJzk3Gj
	puEwxD8yWevR8kBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2z8MPsVt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PAT8OtxC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726847230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3m9MhlSmL+bMGFu2eBCkzGukP5BgDCESlSHlhmD47s=;
	b=2z8MPsVt+2tR0rnc9D9YXrQlgApFvQTZbZQn8maIGaeERhqInmUXQqnb5ecoEKULJbZJde
	PLzkmsz9ss9W5SyzD6TqroYMwa+yAjJV9L7e64K1bQ8W1MsPXvTyzuWsvQVoDO++UnWsug
	r0CpUU917gCaiyM3Gcw4uwYF7Ic3BD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726847230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3m9MhlSmL+bMGFu2eBCkzGukP5BgDCESlSHlhmD47s=;
	b=PAT8OtxCQLjEct5LI9qwsqMUDG5vPLeTziLQQo1LkavA6Dh0YgTOww6OD3XaggQKJzk3Gj
	puEwxD8yWevR8kBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E30813AE1;
	Fri, 20 Sep 2024 15:47:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 54CzFv2Y7WYbZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Sep 2024 15:47:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D85C1A08BD; Fri, 20 Sep 2024 17:47:01 +0200 (CEST)
Date: Fri, 20 Sep 2024 17:47:01 +0200
From: Jan Kara <jack@suse.cz>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: jack@suse.com, zhaomengmeng@kylinos.cn, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] udf: refactor udf_next_aext() to handle error
Message-ID: <20240920154701.xotlrf37bjlwtg3i@quack3>
References: <20240918093634.12906-1-zhaomzhao@126.com>
 <20240918093634.12906-3-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918093634.12906-3-zhaomzhao@126.com>
X-Rspamd-Queue-Id: 0EB1D33A34
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[126.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[126.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 18-09-24 17:36:33, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> Same as udf_current_aext(), take pointer to etype to store the extent
> type, while return 0 for success and <0 on error.
> 
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

...

> diff --git a/fs/udf/directory.c b/fs/udf/directory.c
> index 93153665eb37..f865538c985d 100644
> --- a/fs/udf/directory.c
> +++ b/fs/udf/directory.c
> @@ -166,13 +166,16 @@ static struct buffer_head *udf_fiiter_bread_blk(struct udf_fileident_iter *iter)
>   */
>  static int udf_fiiter_advance_blk(struct udf_fileident_iter *iter)
>  {
> +	int8_t etype;
> +	int err = 0;

Nit: please add empty line between declaration and the code.

>  	iter->loffset++;
>  	if (iter->loffset < DIV_ROUND_UP(iter->elen, 1<<iter->dir->i_blkbits))
>  		return 0;
>  
>  	iter->loffset = 0;
> -	if (udf_next_aext(iter->dir, &iter->epos, &iter->eloc, &iter->elen, 1)
> -			!= (EXT_RECORDED_ALLOCATED >> 30)) {
> +	err = udf_next_aext(iter->dir, &iter->epos, &iter->eloc, &iter->elen,
> +			    &etype, 1);
> +	if (err || etype != (EXT_RECORDED_ALLOCATED >> 30)) {
>  		if (iter->pos == iter->dir->i_size) {
>  			iter->elen = 0;
>  			return 0;

...

> @@ -555,7 +556,7 @@ static int udf_do_extend_file(struct inode *inode,
>  		 * empty indirect extent.
>  		 */
>  		if (new_block_bytes)
> -			udf_next_aext(inode, last_pos, &tmploc, &tmplen, 0);
> +			udf_next_aext(inode, last_pos, &tmploc, &tmplen, &tmptype, 0);
>  	}
>  	iinfo->i_lenExtents += add;
>  

Hum, this will need error checking but we can leave that for future
patches.

> @@ -674,8 +675,8 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
>  		extent.extLength = EXT_NOT_RECORDED_NOT_ALLOCATED;
>  	} else {
>  		epos.offset -= adsize;
> -		etype = udf_next_aext(inode, &epos, &extent.extLocation,
> -				      &extent.extLength, 0);
> +		udf_next_aext(inode, &epos, &extent.extLocation,
> +				&extent.extLength, &etype, 0);
>  		extent.extLength |= etype << 30;
>  	}
>  
> @@ -712,7 +713,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>  	loff_t lbcount = 0, b_off = 0;
>  	udf_pblk_t newblocknum;
>  	sector_t offset = 0;
> -	int8_t etype;
> +	int8_t etype, tmpetype;
>  	struct udf_inode_info *iinfo = UDF_I(inode);
>  	udf_pblk_t goal = 0, pgoal = iinfo->i_location.logicalBlockNum;
>  	int lastblock = 0;
> @@ -748,8 +749,8 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>  		prev_epos.offset = cur_epos.offset;
>  		cur_epos.offset = next_epos.offset;
>  
> -		etype = udf_next_aext(inode, &next_epos, &eloc, &elen, 1);
> -		if (etype == -1)
> +		ret = udf_next_aext(inode, &next_epos, &eloc, &elen, &etype, 1);
> +		if (ret)
>  			break;

I think here we need to add error handling as well and we should probably
do it in this patch / patch series. If ret is ENODATA, we just break out
from the cycle but if ret is some other error, we need to return that error
from inode_getblk().

> @@ -771,8 +772,8 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>  	 * Move prev_epos and cur_epos into indirect extent if we are at
>  	 * the pointer to it
>  	 */
> -	udf_next_aext(inode, &prev_epos, &tmpeloc, &tmpelen, 0);
> -	udf_next_aext(inode, &cur_epos, &tmpeloc, &tmpelen, 0);
> +	udf_next_aext(inode, &prev_epos, &tmpeloc, &tmpelen, &tmpetype, 0);
> +	udf_next_aext(inode, &cur_epos, &tmpeloc, &tmpelen, &tmpetype, 0);

Again, this should have error handling now.

>  
>  	/* if the extent is allocated and recorded, return the block
>  	   if the extent is not a multiple of the blocksize, round up */
> @@ -793,7 +794,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>  	}
>  
>  	/* Are we beyond EOF and preallocated extent? */
> -	if (etype == -1) {
> +	if (ret < 0) {

I'd prefer ret == -ENODATA to make this explicit.

>  		loff_t hole_len;
>  
>  		isBeyondEOF = true;
> @@ -846,8 +847,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>  
>  		/* if the current block is located in an extent,
>  		   read the next extent */
> -		etype = udf_next_aext(inode, &next_epos, &eloc, &elen, 0);
> -		if (etype != -1) {
> +		if (!udf_next_aext(inode, &next_epos, &eloc, &elen, &etype, 0)) {
>  			laarr[c + 1].extLength = (etype << 30) | elen;
>  			laarr[c + 1].extLocation = eloc;
>  			count++;

And this should be distinguisting between EOF and other errors so that we
don't set lastblock wrongly. Instead we should bail with error.

> @@ -1190,13 +1191,13 @@ static int udf_update_extents(struct inode *inode, struct kernel_long_ad *laarr,
>  			if (err < 0)
>  				return err;
>  			udf_next_aext(inode, epos, &laarr[i].extLocation,
> -				      &laarr[i].extLength, 1);
> +				      &laarr[i].extLength, &tmptype, 1);
>  			start++;
>  		}
>  	}
>  
>  	for (i = start; i < endnum; i++) {
> -		udf_next_aext(inode, epos, &tmploc, &tmplen, 0);
> +		udf_next_aext(inode, epos, &tmploc, &tmplen, &tmptype, 0);
>  		udf_write_aext(inode, epos, &laarr[i].extLocation,
>  			       laarr[i].extLength, 1);
>  	}

Again these two calls should have error handling now. udf_update_extents()
is already able to return errors.

> @@ -2267,7 +2268,7 @@ static int udf_insert_aext(struct inode *inode, struct extent_position epos,
>  	if (epos.bh)
>  		get_bh(epos.bh);
>  
> -	while ((etype = udf_next_aext(inode, &epos, &oeloc, &oelen, 0)) != -1) {
> +	while (!udf_next_aext(inode, &epos, &oeloc, &oelen, &etype, 0)) {
>  		udf_write_aext(inode, &epos, &neloc, nelen, 1);
>  		neloc = oeloc;
>  		nelen = (etype << 30) | oelen;

Here, we should check if udf_next_aext() returned error (other than
ENODATA) and bail in that case instead of trying to insert new extent.

> @@ -2302,10 +2303,10 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
>  		adsize = 0;
>  
>  	oepos = epos;
> -	if (udf_next_aext(inode, &epos, &eloc, &elen, 1) == -1)
> +	if (udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1))
>  		return -1;
>  
> -	while ((etype = udf_next_aext(inode, &epos, &eloc, &elen, 1)) != -1) {
> +	while (!udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1)) {
>  		udf_write_aext(inode, &oepos, &eloc, (etype << 30) | elen, 1);
>  		if (oepos.bh != epos.bh) {
>  			oepos.block = epos.block;
> @@ -2379,8 +2380,7 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
>  	}
>  	*elen = 0;
>  	do {
> -		etype = udf_next_aext(inode, pos, eloc, elen, 1);
> -		if (etype == -1) {
> +		if (udf_next_aext(inode, pos, eloc, elen, &etype, 1)) {
>  			*offset = (bcount - lbcount) >> blocksize_bits;
>  			iinfo->i_lenExtents = lbcount;
>  			return -1;

Again, here we need to distinguish ENODATA from other errors so that we
don't wrongly consider failure to read extent like EOF.

> diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
> index 91b6e2698e7e..b7361222f988 100644
> --- a/fs/udf/truncate.c
> +++ b/fs/udf/truncate.c
> @@ -85,7 +85,7 @@ void udf_truncate_tail_extent(struct inode *inode)
>  		BUG();
>  
>  	/* Find the last extent in the file */
> -	while ((netype = udf_next_aext(inode, &epos, &eloc, &elen, 1)) != -1) {
> +	while (!udf_next_aext(inode, &epos, &eloc, &elen, &netype, 1)) {
>  		etype = netype;
>  		lbcount += elen;
>  		if (lbcount > inode->i_size) {

This should be checking for error (after the loop) so that we don't
accidentally try to truncate extents early in case of error.

> @@ -101,7 +101,7 @@ void udf_truncate_tail_extent(struct inode *inode)
>  			epos.offset -= adsize;
>  			extent_trunc(inode, &epos, &eloc, etype, elen, nelen);
>  			epos.offset += adsize;
> -			if (udf_next_aext(inode, &epos, &eloc, &elen, 1) != -1)
> +			if (!udf_next_aext(inode, &epos, &eloc, &elen, &netype, 1))
>  				udf_err(inode->i_sb,
>  					"Extent after EOF in inode %u\n",
>  					(unsigned)inode->i_ino);
> @@ -132,13 +132,13 @@ void udf_discard_prealloc(struct inode *inode)
>  	epos.block = iinfo->i_location;
>  
>  	/* Find the last extent in the file */
> -	while (udf_next_aext(inode, &epos, &eloc, &elen, 0) != -1) {
> +	while (!udf_next_aext(inode, &epos, &eloc, &elen, &etype, 0)) {
>  		brelse(prev_epos.bh);
>  		prev_epos = epos;
>  		if (prev_epos.bh)
>  			get_bh(prev_epos.bh);
>  
> -		etype = udf_next_aext(inode, &epos, &eloc, &elen, 1);
> +		udf_next_aext(inode, &epos, &eloc, &elen, &etype, 1);
>  		lbcount += elen;
>  	}
>  	if (etype == (EXT_NOT_RECORDED_ALLOCATED >> 30)) {

Again error checking for above two calls plus here we should not depend on
'etype' value after udf_next_aext() returned error. So we'll need another
temporary variable for etype to pass to the first udf_next_aext() call.

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

