Return-Path: <linux-kernel+bounces-347481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F37ED98D340
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C553B23D52
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC00C1CF7C7;
	Wed,  2 Oct 2024 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0DycPmAj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="47dHSWNp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0DycPmAj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="47dHSWNp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1C1CF7B9
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872154; cv=none; b=eR7wxmcNgGtS2h9E+/si91qesUGc3gbSacz4ESBHI0AHz+AuWWZa2fuJRTr6Gc1kzmYTyUaDG5fvdXXlYhcNnCLEj9hqRz2LC5JZQ9UDMhw8koCQ6Q7fjKWIfdyKbtvO61PQktkoHnIMd5aniQ67FAQPsUqDwnchK7kTgZkSWAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872154; c=relaxed/simple;
	bh=si8QYx0nItUctL+2ZVYiadl23Z65CD2hZuDCi/W1o5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqEkcFGtguHHEvS2PPy6sCSH1JqO7rzh3UVmnHbSUNkWYSblvmiiyBTn+TZAGnHWHEHKbIXCgVc7rZNlp1vYYR5+vC0UCj/g/HRQq5L6IkqjogCfGns1Q706q82P4MvcqPuLyFF131XpzhNBalDv9h3ffz7S6jgcPkV/vJtQKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0DycPmAj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=47dHSWNp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0DycPmAj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=47dHSWNp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73B6121BDB;
	Wed,  2 Oct 2024 12:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727872150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/J13xSZXixZJRkCGYQdfEnsmXt7iHgz1b8qTBEU29Vk=;
	b=0DycPmAjyw15C6ZuukEppCfgdNl9u40sZwilZEG2zYoOsVULSRLbppOPRC26N391TCQGCM
	WVDUdKK/Ab5+mWrYZzbs5xMazENEd7v/iQG/oxzj2Zk9eMLeTyNcsmkqXYyMGWpqJRNaRq
	g5+Em7w9XRovUgeoxjSel/nhy2aKKB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727872150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/J13xSZXixZJRkCGYQdfEnsmXt7iHgz1b8qTBEU29Vk=;
	b=47dHSWNpbvm3Lq/SDWdYgko4+GmbUPPVgfUDhLEYTRvqBbmFjiGHQWOc2AIX0RTwPhqDXW
	yAIJGkbyJ6opdWDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0DycPmAj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=47dHSWNp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727872150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/J13xSZXixZJRkCGYQdfEnsmXt7iHgz1b8qTBEU29Vk=;
	b=0DycPmAjyw15C6ZuukEppCfgdNl9u40sZwilZEG2zYoOsVULSRLbppOPRC26N391TCQGCM
	WVDUdKK/Ab5+mWrYZzbs5xMazENEd7v/iQG/oxzj2Zk9eMLeTyNcsmkqXYyMGWpqJRNaRq
	g5+Em7w9XRovUgeoxjSel/nhy2aKKB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727872150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/J13xSZXixZJRkCGYQdfEnsmXt7iHgz1b8qTBEU29Vk=;
	b=47dHSWNpbvm3Lq/SDWdYgko4+GmbUPPVgfUDhLEYTRvqBbmFjiGHQWOc2AIX0RTwPhqDXW
	yAIJGkbyJ6opdWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E42713A6E;
	Wed,  2 Oct 2024 12:29:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3T39FpY8/WaeCgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 02 Oct 2024 12:29:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0ADB5A08CB; Wed,  2 Oct 2024 14:29:10 +0200 (CEST)
Date: Wed, 2 Oct 2024 14:29:09 +0200
From: Jan Kara <jack@suse.cz>
To: Gianfranco Trad <gianf.trad@gmail.com>
Cc: jack@suse.com, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] udf: fix uninit-value use in udf_get_fileshortad
Message-ID: <20241002122909.ak4itmqzg4b2icsx@quack3>
References: <20240925071355.t4w3thcfvfpou7gu@quack3>
 <20240925074613.8475-3-gianf.trad@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925074613.8475-3-gianf.trad@gmail.com>
X-Rspamd-Queue-Id: 73B6121BDB
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[8901c4560b7ab5c2f9df];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Wed 25-09-24 09:46:15, Gianfranco Trad wrote:
> Check for overflow when computing alen in udf_current_aext to mitigate
> later uninit-value use in udf_get_fileshortad KMSAN bug[1].
> After applying the patch reproducer did not trigger any issue[2].
> 
> [1] https://syzkaller.appspot.com/bug?extid=8901c4560b7ab5c2f9df
> [2] https://syzkaller.appspot.com/x/log.txt?x=10242227980000
> 
> Reported-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8901c4560b7ab5c2f9df
> Tested-by: syzbot+8901c4560b7ab5c2f9df@syzkaller.appspotmail.com
> Suggested-by: Jan Kara <jack@suse.com>
> Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>

Thanks. I've added the patch to my tree.

								Honza

> ---
> 
> Notes:
> 	changes in v2:
> 		- use check_add_overflow helper to check for overflow.
> 	
> 	link to v1: https://lore.kernel.org/all/20240919195227.412583-1-gianf.trad@gmail.com/T/
> 
>  fs/udf/inode.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 4726a4d014b6..811a035b600f 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -2215,9 +2215,10 @@ int8_t udf_current_aext(struct inode *inode, struct extent_position *epos,
>  		if (!epos->offset)
>  			epos->offset = sizeof(struct allocExtDesc);
>  		ptr = epos->bh->b_data + epos->offset;
> -		alen = sizeof(struct allocExtDesc) +
> -			le32_to_cpu(((struct allocExtDesc *)epos->bh->b_data)->
> -							lengthAllocDescs);
> +		if (check_add_overflow(sizeof(struct allocExtDesc),
> +					le32_to_cpu(((struct allocExtDesc *)epos->bh->b_data)
> +						->lengthAllocDescs), &alen))
> +			return -1;
>  	}
>  
>  	switch (iinfo->i_alloc_type) {
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

