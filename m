Return-Path: <linux-kernel+bounces-209413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B599790344A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B1A1F29339
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6A3173342;
	Tue, 11 Jun 2024 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jUrIstYK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v5CHyl/Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jUrIstYK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v5CHyl/Z"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF417278D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092150; cv=none; b=juUyLKRAPwxi8FmvZCI0oXcfMCxUh/XHa1GUKBaBKeSH9ILcW8AMU7bebzMWEi1LzoQDUurX8qrhgSkK5S4AvszR9CZ2QwtEPPYwzxsHpzbRkYWoBUdOXD1jSmKczoQ/+SVZGIcFBPMKDiFQgB0pF/8PufWrgq4kET9BacZEmHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092150; c=relaxed/simple;
	bh=3T1usxu2rF5SNBrquIbomMZjVzisbkX0qMq70UIQGKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpJjKDts89kS4XCT/x4EoKTDSruehLA3cCCgQp4Iem2/dUF/UXfdkeTkU45z7LfuFcxW0DEe/23lbNqG4jgH0OIsFbYHsLItC8QK9Wqp3+s4JGQBtihmkT6cqiwikhEs1r2bdyrOSHcc4NmGgLMl3BtgEKGMWYOWc9IDUMq1ez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jUrIstYK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v5CHyl/Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jUrIstYK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v5CHyl/Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3DC161F8AB;
	Tue, 11 Jun 2024 07:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718092146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2SQY+gjyxZXwlts02npl3vzqyLScD2MomXyvFp4aFM0=;
	b=jUrIstYKMGtKxTBSYhMlPFlZ4ecNe51n34r8Df4PZAWFJKEaXlaaPhlp1XD9GzwaMCKabC
	9qiRnnVbuFvBgEbcOmFygyfFV9HUm4VtLFvCMSitKgDA+uKEnVcthXr71lPV3C+HAadR6W
	JTKgOVuOT0IPpdzPKUUyLrMtPBvbfAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718092146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2SQY+gjyxZXwlts02npl3vzqyLScD2MomXyvFp4aFM0=;
	b=v5CHyl/ZPJ+EnmVJJUtf35CF9m8qPvH0L6LuqoP4o2dOuTX6ETHi2x3PLsp7KW3mHjHtaN
	NDhN9Sy1xvL++7Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jUrIstYK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="v5CHyl/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718092146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2SQY+gjyxZXwlts02npl3vzqyLScD2MomXyvFp4aFM0=;
	b=jUrIstYKMGtKxTBSYhMlPFlZ4ecNe51n34r8Df4PZAWFJKEaXlaaPhlp1XD9GzwaMCKabC
	9qiRnnVbuFvBgEbcOmFygyfFV9HUm4VtLFvCMSitKgDA+uKEnVcthXr71lPV3C+HAadR6W
	JTKgOVuOT0IPpdzPKUUyLrMtPBvbfAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718092146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2SQY+gjyxZXwlts02npl3vzqyLScD2MomXyvFp4aFM0=;
	b=v5CHyl/ZPJ+EnmVJJUtf35CF9m8qPvH0L6LuqoP4o2dOuTX6ETHi2x3PLsp7KW3mHjHtaN
	NDhN9Sy1xvL++7Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E20813A55;
	Tue, 11 Jun 2024 07:49:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kws8C3IBaGbhUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 11 Jun 2024 07:49:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CE530A0889; Tue, 11 Jun 2024 09:48:50 +0200 (CEST)
Date: Tue, 11 Jun 2024 09:48:50 +0200
From: Jan Kara <jack@suse.cz>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
	Sergey Shtylyov <s.shtylyov@omp.ru>, lvc-project@linuxtesting.org
Subject: Re: [PATCH] udf: balloc: prevent integer overflow in
 udf_bitmap_free_blocks()
Message-ID: <20240611074850.tiaieba2bswwck6d@quack3>
References: <20240610072523.12002-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610072523.12002-1-r.smirnov@omp.ru>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3DC161F8AB
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Mon 10-06-24 10:25:22, Roman Smirnov wrote:
> An overflow may occur if the function is called with the last
> block and an offset greater than zero. It is necessary to add
> a check to avoid this.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>

Thanks for the patch! Actually there are overflow checks just a few lines
above the place you modify:

        if (bloc->logicalBlockNum + count < count ||
            (bloc->logicalBlockNum + count) > partmap->s_partition_len) {

So please update those to take 'offset' into account instead. Also please
use check_add_overflow() for the integer overflow check.

								Honza

> ---
>  fs/udf/balloc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
> index ab3ffc355949..cd83bbc7d890 100644
> --- a/fs/udf/balloc.c
> +++ b/fs/udf/balloc.c
> @@ -151,6 +151,13 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
>  	block = bloc->logicalBlockNum + offset +
>  		(sizeof(struct spaceBitmapDesc) << 3);
>  
> +	if (block < offset + (sizeof(struct spaceBitmapDesc) << 3)) {
> +		udf_debug("integer overflow: %u + %u + %zu",
> +			  bloc->logicalBlockNum, offset,
> +			  sizeof(struct spaceBitmapDesc) << 3);
> +		goto error_return;
> +	}
> +
>  	do {
>  		overflow = 0;
>  		block_group = block >> (sb->s_blocksize_bits + 3);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

