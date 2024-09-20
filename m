Return-Path: <linux-kernel+bounces-334499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1990897D7FF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8B41C22E45
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA9A17DE16;
	Fri, 20 Sep 2024 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fg/Gp5Ri";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wehxRiE6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fg/Gp5Ri";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wehxRiE6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D662EEB5
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726848046; cv=none; b=WmkziTVoX6b82oYuCD5KXrnR44YdkRFKPKBOdPVxjPyjWp+t8FIrFt2Uma3yCWL9sjaYepXYGJ9DWPA/W1TX5+RM/G91rRdp0EKh/7WjDxUMDLi1T7q9lPhJJ+cjf53ek3rOiKDR2oYJ3TIKmnkDGEzS5YAD+IOigOM/bWaHYLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726848046; c=relaxed/simple;
	bh=6Ky0VUzoWBwdCPp+4St1B0uHJQHp1gCOZHSckAyCA3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZx7JRlDtQ0k3oG34JxnELQ/OAgLvdUuOmffPb5o4RpbfDTKx5zJTC+XdeWNdvJXHZWg1UkmI6YC0VLtCiiYcQNQvnchUECd9kEzzeSe5bEOyzJncjuKmzgBYTNnAGmBI+GlJ4PPELbNlbOsnq/ipWRtQQTMtNAJIC2l+CgSs3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fg/Gp5Ri; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wehxRiE6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fg/Gp5Ri; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wehxRiE6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6AF411F7F1;
	Fri, 20 Sep 2024 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726848042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x2girddiHAvtutYz/YIjy6qojmi7N/1T7imU+0mzJLQ=;
	b=fg/Gp5RiGpb8h3F7s6YB8EqT9DjqywiUqWvJmo0ORp0nV3pDO33GgmilzRxHBXCLbY60d+
	oeQM7PWfmDbyvKdSEFcRn4AdWSfS5lTsmk+AV+uk0rL27xAPbcD1Rn7UOobSaUSInD0cp/
	EPy6cgGySYOaySFVzgPCtCdftOP4FqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726848042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x2girddiHAvtutYz/YIjy6qojmi7N/1T7imU+0mzJLQ=;
	b=wehxRiE63px2yTfOKZoplYXiyspfO0A45Up8vm6kNjMgQ8ZP5kB4URCmuMYm7eMqdC9ZGE
	F9yNUWkN2MOEZICw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726848042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x2girddiHAvtutYz/YIjy6qojmi7N/1T7imU+0mzJLQ=;
	b=fg/Gp5RiGpb8h3F7s6YB8EqT9DjqywiUqWvJmo0ORp0nV3pDO33GgmilzRxHBXCLbY60d+
	oeQM7PWfmDbyvKdSEFcRn4AdWSfS5lTsmk+AV+uk0rL27xAPbcD1Rn7UOobSaUSInD0cp/
	EPy6cgGySYOaySFVzgPCtCdftOP4FqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726848042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x2girddiHAvtutYz/YIjy6qojmi7N/1T7imU+0mzJLQ=;
	b=wehxRiE63px2yTfOKZoplYXiyspfO0A45Up8vm6kNjMgQ8ZP5kB4URCmuMYm7eMqdC9ZGE
	F9yNUWkN2MOEZICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E83613AE1;
	Fri, 20 Sep 2024 16:00:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qUl4Iimc7WbmZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Sep 2024 16:00:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0DF29A08BD; Fri, 20 Sep 2024 18:00:37 +0200 (CEST)
Date: Fri, 20 Sep 2024 18:00:37 +0200
From: Jan Kara <jack@suse.cz>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: jack@suse.com, zhaomengmeng@kylinos.cn, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] udf: refactor inode_bmap() to handle error
Message-ID: <20240920160037.i4nla2ccn7rtmb7n@quack3>
References: <20240918093634.12906-1-zhaomzhao@126.com>
 <20240918093634.12906-4-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918093634.12906-4-zhaomzhao@126.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 18-09-24 17:36:34, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> Same as udf_current_aext(), take pointer to etype to store the extent
> type, while return 0 for success and <0 on error. On situations like
> ftruncate, udf_extend_file() can detect errors and bail out early
> without resorting to checking for particular offsets and
> assuming internal behavior of these functions.
> 
> Reported-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7a4842f0b1801230a989
> Tested-by: syzbot+7a4842f0b1801230a989@syzkaller.appspotmail.com
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Overall looks good. I have a few comments below.

> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index ba980ce5e13a..f1b8f0a0d202 100644
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
> +		inode_bmap(inode, map->lblk, &epos, &eloc, &elen, &offset, &etype);

Here we should be checking for error and returning it...

> +		if (etype == (EXT_RECORDED_ALLOCATED >> 30)) {
>  			map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc,
>  							offset);
>  			map->oflags |= UDF_BLK_MAPPED;
> @@ -660,8 +661,10 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
>  	 */
>  	udf_discard_prealloc(inode);
>  
> -	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
> -	within_last_ext = (etype != -1);
> +	err = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset, &etype);
> +	if (err < 0 && err != -ENODATA)
> +		goto out;
> +	within_last_ext = (!err);
>  	/* We don't expect extents past EOF... */
>  	WARN_ON_ONCE(within_last_ext &&
>  		     elen > ((loff_t)offset + 1) << inode->i_blkbits);
> @@ -2363,14 +2366,19 @@ int8_t udf_delete_aext(struct inode *inode, struct extent_position epos)
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
> +	int err = 0;
>  
>  	iinfo = UDF_I(inode);
>  	if (!udf_read_extent_cache(inode, bcount, &lbcount, pos)) {
> @@ -2380,10 +2388,11 @@ int8_t inode_bmap(struct inode *inode, sector_t block,
>  	}
>  	*elen = 0;
>  	do {
> -		if (udf_next_aext(inode, pos, eloc, elen, &etype, 1)) {
> +		err = udf_next_aext(inode, pos, eloc, elen, etype, 1);
> +		if (err < 0) {

OK, you've added the error handling in this patch. That is good. But still
we should be setting offset and i_lenExtents only in -ENODATA case.
Otherwise we just want to return the error.

>  			*offset = (bcount - lbcount) >> blocksize_bits;
>  			iinfo->i_lenExtents = lbcount;
> -			return -1;
> +			return err;
>  		}

...

> @@ -196,10 +197,10 @@ int udf_truncate_extents(struct inode *inode)
>  	else
>  		BUG();
>  
> -	etype = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset);
> +	err = inode_bmap(inode, first_block, &epos, &eloc, &elen, &offset, &etype);
>  	byte_offset = (offset << sb->s_blocksize_bits) +
>  		(inode->i_size & (sb->s_blocksize - 1));
> -	if (etype == -1) {
> +	if (err < 0) {

Here we should be distinguisting -ENODATA (WARN and return 0) and other
error (which we need to return).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

