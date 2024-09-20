Return-Path: <linux-kernel+bounces-334442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47DB97D754
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59262841E7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A8017CA1B;
	Fri, 20 Sep 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ok6zyiP7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mbzjsvoo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ok6zyiP7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mbzjsvoo"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2BB17C7C9
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726845025; cv=none; b=kD9xUUIQoxsKLgwE0IBAjw0M1T/QDPvf32P6mKRjDtm6bjQtYlgC+H7G6jp9fu/Uu21eyF2WIP5uyrBxk6znT6xSRZEyP2ZeAvvFrTqOZp4EqWTeE/8uYfnBRCf/6anJhJ2/+e7FnlzYTvMBfSpBnF0FF4RVg2j4Ish8jI4z8Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726845025; c=relaxed/simple;
	bh=yXc02NtS3lmToqqXwbBB949he71ABPUrozQ3B5MH2IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GCYbKzS3mZS2a8ZmXqteiUDXmgEqhEX60o/ODHwLIA2rr4ln5aLoamQok1To2pB79OXWP7dbQEJLV32ZbJx2k7L6/V9rVku3vH+2nr3EX6DH71I/LN0oS31lTdawTRTNbZt9bA2gCm3B1J/bhZJhd/voUEYv+wsu1PMMG1zRSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ok6zyiP7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mbzjsvoo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ok6zyiP7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mbzjsvoo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 082D21F7CF;
	Fri, 20 Sep 2024 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726845021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wlN+6/jgbZmclWvDlwlRlrcwqVrnHC5T48AcREsq+I=;
	b=ok6zyiP7LzzceDObhnKAWfJ+AEhIxoW1XJT/nCbPpSGWZv2hjyadcG5LERxSVa0TgAe2Q9
	u0xC+N3ZRbUtAjvcNjz6ShSpIcFUV/5AgabRfU9gxuNgDzdE5wS/JkhdiSaZVpBb4hGKZi
	sUaaLQBhGArZIvn7atrzVqtVStRzF7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726845021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wlN+6/jgbZmclWvDlwlRlrcwqVrnHC5T48AcREsq+I=;
	b=Mbzjsvoovn6tSz4eHkmPw35vYJkHrynW9RGhzRYnr89ZTk/ogw9emma5kcIT2kFyF/yPIt
	bsv0mB5c48hYYNCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ok6zyiP7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Mbzjsvoo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726845021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wlN+6/jgbZmclWvDlwlRlrcwqVrnHC5T48AcREsq+I=;
	b=ok6zyiP7LzzceDObhnKAWfJ+AEhIxoW1XJT/nCbPpSGWZv2hjyadcG5LERxSVa0TgAe2Q9
	u0xC+N3ZRbUtAjvcNjz6ShSpIcFUV/5AgabRfU9gxuNgDzdE5wS/JkhdiSaZVpBb4hGKZi
	sUaaLQBhGArZIvn7atrzVqtVStRzF7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726845021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wlN+6/jgbZmclWvDlwlRlrcwqVrnHC5T48AcREsq+I=;
	b=Mbzjsvoovn6tSz4eHkmPw35vYJkHrynW9RGhzRYnr89ZTk/ogw9emma5kcIT2kFyF/yPIt
	bsv0mB5c48hYYNCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 526C013AA7;
	Fri, 20 Sep 2024 15:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oUEZFFSQ7WZCWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Sep 2024 15:10:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D35EDA08BD; Fri, 20 Sep 2024 17:09:52 +0200 (CEST)
Date: Fri, 20 Sep 2024 17:09:52 +0200
From: Jan Kara <jack@suse.cz>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: jack@suse.com, zhaomengmeng@kylinos.cn, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] udf: refactor udf_current_aext() to handle error
Message-ID: <20240920150952.bqzxuhnvgh6zx5rg@quack3>
References: <20240918093634.12906-1-zhaomzhao@126.com>
 <20240918093634.12906-2-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918093634.12906-2-zhaomzhao@126.com>
X-Rspamd-Queue-Id: 082D21F7CF
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[126.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[126.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 18-09-24 17:36:32, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> As Jan suggested in links below, refactor udf_current_aext() to
> differentiate between error and "hit EOF", it now takes pointer to etype
> to store the extent type, return 0 when get etype success; return -ENODATA
> when hit EOF; return -EINVAL when i_alloc_type invalid.
> 
> Link: https://lore.kernel.org/all/20240912111235.6nr3wuqvktecy3vh@quack3/
> 
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

Two comments below.

> @@ -1999,10 +2000,12 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
>  	if (epos->offset + adsize > sb->s_blocksize) {
>  		struct kernel_lb_addr cp_loc;
>  		uint32_t cp_len;
> -		int cp_type;
> +		int8_t cp_type;
>  
>  		epos->offset -= adsize;
> -		cp_type = udf_current_aext(inode, epos, &cp_loc, &cp_len, 0);
> +		err = udf_current_aext(inode, epos, &cp_loc, &cp_len, &cp_type, 0);
> +		if (err < 0)
> +			goto err_out;
>  		cp_len |= ((uint32_t)cp_type) << 30;
>  
>  		__udf_add_aext(inode, &nepos, &cp_loc, cp_len, 1);
> @@ -2017,6 +2020,9 @@ int udf_setup_indirect_aext(struct inode *inode, udf_pblk_t block,
>  	*epos = nepos;
>  
>  	return 0;
> +err_out:
> +	brelse(epos->bh);
> +	return err;
>  }

So here I don't think we want to release epos->bh. Rather we need to
release 'bh' itself which we have got because we did't replace epos->bh yet
with it.

> @@ -2167,9 +2173,12 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
>  {
>  	int8_t etype;
>  	unsigned int indirections = 0;
> +	int err = 0;
> +
> +	while ((err = udf_current_aext(inode, epos, eloc, elen, &etype, inc))) {
> +		if (err || etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
> +			break;
>  
> -	while ((etype = udf_current_aext(inode, epos, eloc, elen, inc)) ==
> -	       (EXT_NEXT_EXTENT_ALLOCDESCS >> 30)) {
>  		udf_pblk_t block;
>  
>  		if (++indirections > UDF_MAX_INDIR_EXTS) {
> @@ -2190,14 +2199,14 @@ int8_t udf_next_aext(struct inode *inode, struct extent_position *epos,
>  		}
>  	}
>  
> -	return etype;
> +	return err;
>  }

This doesn't look right. Probably it gets fixed up in the following patches
but here should be something like: !err ? etype : -1
to keep udf_next_aext() compatible with its users.

Otherwise the patch looks good.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

