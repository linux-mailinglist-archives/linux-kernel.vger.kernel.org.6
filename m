Return-Path: <linux-kernel+bounces-347534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2478798D3FB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64258B216F8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EFB1CFEB9;
	Wed,  2 Oct 2024 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GOdpU4M5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t/y8CWsA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p1DWUJwv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZdUL2ELC"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1481D0140
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874299; cv=none; b=FQQwe3Ypj5UJJ84x2R88WhqyGXRQ3p5BDZ34CQGqgy6f7tiZ/lKoTXyr5bSa7pZ9HqwjaoJikfnTm5zb8Iza/NViJXfHFm/aQGEn5QEYrWXWBzTyBzobad3ttkAqy0pMoxTGt5vBUEb46gENvMVqmYYIjsHSfRLcAnYYGNmJGhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874299; c=relaxed/simple;
	bh=+sxI/yM2/OPWuiDLeZvEAG/zEfA7Wgh2sCtiEevaink=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7i3bd5lCX/TstC60klvLVRGUjoAADz9GcJQNQUvvN5UAGSLOJYmUvJdAinr1OuKuUz4HbhyPG38MFVmlzVbzZS1n3mx2eB9mFrssh3l/y6yQfC33+l+UUr0DDGzbXAO+MWVKL8b9DwyzTJ6htc2OMKINF1fG+4VurwO17tCGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GOdpU4M5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t/y8CWsA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p1DWUJwv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZdUL2ELC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E093E21C6A;
	Wed,  2 Oct 2024 13:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727874295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0RhIy2sXd6TNKxqqlMg6j06lm9bWxUtEprieqUaOOM=;
	b=GOdpU4M5Re4SHs7wpploFfzxGtraxTtl9phg1wjWN4t9DE9wQMCSH3THL9sWoCwsNj6qGd
	HidyiqJGIoUzdtKoUG9HrA2S9vaKzworSEeN6pzn1nIFfBPtoXosSgOJofCZVs/qYedKXJ
	q2jydsWZF1ey/wfCBBo3lvr4NfYgdkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727874295;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0RhIy2sXd6TNKxqqlMg6j06lm9bWxUtEprieqUaOOM=;
	b=t/y8CWsAJ2mZL8kwfBVJ1r1zVB74ChGoLmvAlZTXM6poNNaMhLy9G+d9NvPU9t+WHdFuRj
	t8n2nTN1ppbK0lCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=p1DWUJwv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZdUL2ELC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727874293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0RhIy2sXd6TNKxqqlMg6j06lm9bWxUtEprieqUaOOM=;
	b=p1DWUJwvGv4NRgeTLf1B2w2/irZUTMBBU1sJS2rDf4t+7kW0gXcKuQPc+unNrnJYYT5fpR
	/Tl5C0jxSisJXbj03upxVyM3IP9g5wrg+s+XCZdt9I9XS+Y+eWNa3eT+1YB8lC29Nz+1fb
	x8u7YmK9CckwuuOzVvU7azDazxDZ6ZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727874293;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i0RhIy2sXd6TNKxqqlMg6j06lm9bWxUtEprieqUaOOM=;
	b=ZdUL2ELCoOfEnOUlFM2trLYFkcpat8mL1yjgVFuooE4TSt3kP4EMIX8eRbFi+HiGkhBVtl
	W1WDjFv+w+AnniBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D596613A6E;
	Wed,  2 Oct 2024 13:04:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UkQfNPVE/WYlFgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Oct 2024 13:04:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 96740A08CB; Wed,  2 Oct 2024 15:04:49 +0200 (CEST)
Date: Wed, 2 Oct 2024 15:04:49 +0200
From: Jan Kara <jack@suse.cz>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: jack@suse.com, zhaomengmeng@kylinos.cn, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] udf: refactor
 udf_current_aext()/udf_next_aext()/inode_bmap() to handle error
Message-ID: <20241002130449.44uagv3y4urjj6ch@quack3>
References: <20241001115425.266556-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001115425.266556-1-zhaomzhao@126.com>
X-Rspamd-Queue-Id: E093E21C6A
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 01-10-24 19:54:22, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> syzbot reports a udf slab-out-of-bounds at [1] and I proposed a fix patch,
> after talking with Jan, a better way to fix this is to refactor 
> udf_current_aext() and udf_next_aext() to differentiate between error and
> "hit EOF".
> This series refactor udf_current_aext(), udf_next_aext() and inode_bmap(),
> they take pointer to etype to store the extent type, return 1 when 
> getting etype success, return 0 when hitting EOF and return -errno when
> err. It has passed the syz repro test.
> 
> [1]. https://lore.kernel.org/all/0000000000005093590621340ecf@google.com/

Thanks! I did some minor code-style updates to the patches and picked them
up to my tree.

								Honza

> 
> changelog:
> v3:
> ----
>  - Change function return rules, On error, ret < 0, on EOF ret == 0, 
> on success ret == 1.
>  - minor fix on return check
> 
> v2:
> ----
>  - Take advices of Jan to fix the error handling code
>  - Check all other places that may involves EOF and error checking
>  - Add two macros the simply the error checking of extent
>  - https://lore.kernel.org/all/20240926120753.3639404-1-zhaomzhao@126.com/
> 
> v1:
> ----
>  - https://lore.kernel.org/all/20240918093634.12906-1-zhaomzhao@126.com/
> 
> Zhao Mengmeng (3):
>   udf: refactor udf_current_aext() to handle error
>   udf: refactor udf_next_aext() to handle error
>   udf: refactor inode_bmap() to handle error
> 
>  fs/udf/balloc.c    |  27 +++++---
>  fs/udf/directory.c |  23 +++++--
>  fs/udf/inode.c     | 167 +++++++++++++++++++++++++++++----------------
>  fs/udf/partition.c |   6 +-
>  fs/udf/super.c     |   3 +-
>  fs/udf/truncate.c  |  41 ++++++++---
>  fs/udf/udfdecl.h   |  15 ++--
>  7 files changed, 190 insertions(+), 92 deletions(-)
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

