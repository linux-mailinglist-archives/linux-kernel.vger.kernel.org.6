Return-Path: <linux-kernel+bounces-338105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DA0985361
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 201EAB2290A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD331537AC;
	Wed, 25 Sep 2024 07:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0XFwGSg+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D54eyQq+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0XFwGSg+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D54eyQq+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A4313D62F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727247950; cv=none; b=mizUfD2dVcZ2AxEeNSobG/icTFm4gMMPpbvkFHeRSiMp+bDhy66qZvMSlW7HjcrdDT/7MzVipL/n0N4oxcDJwP/AckJWC0Qn66Kn4JPeSdc1LlUopzCWqCT4bDT0fglvmpbWDaoSgJ6jriJXEyi0h2byHlla2Zi+AwIIbSHGNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727247950; c=relaxed/simple;
	bh=j6KEFY/IEdZVw1ZnPv878iZd+JawJ6cVoKv42dv8BXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7xLKO4tC7nXim8+fyAKaKSg7mEjTIHpJX4/jouV7OWqYb4GU6rPP9mLTVHF7l3+Ch2VY/u7J7aug6sTcsa557EZ+KrJFya5y8DUgOlhkyNIfZvYUWU/6iDuSeuoinANVOcz8HiTWcvgCji1tBkzY5mBeAtTDGB03q8oMeevznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0XFwGSg+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D54eyQq+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0XFwGSg+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D54eyQq+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 452071FB9D;
	Wed, 25 Sep 2024 07:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727247946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5FwztsJJrsZ1NiowiTUpMKZ+weXOKJuzpzW72D1YPg4=;
	b=0XFwGSg+68UyOlmxAAe3FmVToIaeKsoOZeK3iI2AEzizoGS5HUbVLD6/ZTgIMPCDN4//0s
	4Y7mFuocj+7hAlbHl3JDbEYbWmO0zLeoPt/GxHn1C8/v2gvXWGzKdTCVTDHtnmt2ILV6bH
	g9BTlX12DEn8Ezl6Qu+wj4FTvE1faVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727247946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5FwztsJJrsZ1NiowiTUpMKZ+weXOKJuzpzW72D1YPg4=;
	b=D54eyQq+M3QfHrjMwhXUdBOPeM+lGuJKOdMG+sZLOGQX5S7WfKjyJX57SwoJDz17CY4a8G
	UJhTKHl8K+zzCIAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0XFwGSg+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=D54eyQq+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727247946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5FwztsJJrsZ1NiowiTUpMKZ+weXOKJuzpzW72D1YPg4=;
	b=0XFwGSg+68UyOlmxAAe3FmVToIaeKsoOZeK3iI2AEzizoGS5HUbVLD6/ZTgIMPCDN4//0s
	4Y7mFuocj+7hAlbHl3JDbEYbWmO0zLeoPt/GxHn1C8/v2gvXWGzKdTCVTDHtnmt2ILV6bH
	g9BTlX12DEn8Ezl6Qu+wj4FTvE1faVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727247946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5FwztsJJrsZ1NiowiTUpMKZ+weXOKJuzpzW72D1YPg4=;
	b=D54eyQq+M3QfHrjMwhXUdBOPeM+lGuJKOdMG+sZLOGQX5S7WfKjyJX57SwoJDz17CY4a8G
	UJhTKHl8K+zzCIAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36A1F13793;
	Wed, 25 Sep 2024 07:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uL7XDEq282YiaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Sep 2024 07:05:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE483A08A7; Wed, 25 Sep 2024 09:05:30 +0200 (CEST)
Date: Wed, 25 Sep 2024 09:05:30 +0200
From: Jan Kara <jack@suse.cz>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: Jan Kara <jack@suse.cz>, jack@suse.com, zhaomengmeng@kylinos.cn,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] udf: refactor udf_next_aext() to handle error
Message-ID: <20240925070530.cddj4cs4ia7qy6qm@quack3>
References: <20240918093634.12906-1-zhaomzhao@126.com>
 <20240918093634.12906-3-zhaomzhao@126.com>
 <20240920154701.xotlrf37bjlwtg3i@quack3>
 <6b22baa6-a75f-45ff-a0cb-33ae0ecf4720@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b22baa6-a75f-45ff-a0cb-33ae0ecf4720@126.com>
X-Rspamd-Queue-Id: 452071FB9D
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
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[126.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 24-09-24 20:08:56, Zhao Mengmeng wrote:
> On 2024/9/20 23:47, Jan Kara wrote:
> > On Wed 18-09-24 17:36:33, Zhao Mengmeng wrote:
> >> diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
> >> index 91b6e2698e7e..b7361222f988 100644
> >> --- a/fs/udf/truncate.c
> >> +++ b/fs/udf/truncate.c
> >> @@ -85,7 +85,7 @@ void udf_truncate_tail_extent(struct inode *inode)
> >>  		BUG();
> >>  
> >>  	/* Find the last extent in the file */
> >> -	while ((netype = udf_next_aext(inode, &epos, &eloc, &elen, 1)) != -1) {
> >> +	while (!udf_next_aext(inode, &epos, &eloc, &elen, &netype, 1)) {
> >>  		etype = netype;
> >>  		lbcount += elen;
> >>  		if (lbcount > inode->i_size) {
> > 
> > This should be checking for error (after the loop) so that we don't
> > accidentally try to truncate extents early in case of error.
> > 
> Sorry to bother, in case of error(including EOF), it won't go into the loop and
> has chance to call extent_trunc(). After the loop, only some update and clean op,
> 
> 	iinfo->i_lenExtents = inode->i_size;
> 	brelse(epos.bh);
> 
> So I'm a little confused which part of this piece of code needs to change?

So if we are not able to scan until EOF due to error, we should set
i_lenExtents to i_size but you're right this is mostly a cosmetic thing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

