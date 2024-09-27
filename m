Return-Path: <linux-kernel+bounces-341681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52856988389
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 347071F2511B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB7718A6DE;
	Fri, 27 Sep 2024 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3K6/kiWG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xo+LolKF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3K6/kiWG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xo+LolKF"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18B318A93F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438118; cv=none; b=Ol9L66yvg5OVyLvO2fmgC9HKuSkp3LyTyR5CvY/MIobBMxUpYAMJHNQulaHydkWTus6ojH0zGyEAgoeNcNTrqeWndXMIdTOYrq6N+MvRNd5MkbrvThsN4yLZHrP1lLwOpfe3j7Sg5tCYPS/Ir/7e7UmPvbT9SkKx6yl0Lxbn50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438118; c=relaxed/simple;
	bh=9Z2b9M6Fb8HoLu1XVOiyiFZ4EN2UyaeR1jRknfUVMFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpb8URc5dkmfMLkJTr8OC1SehmugjSzIXBzC6DfIybmT3cJcgwBm1eOWJ06aXfECH6CwHPZLV9T0XUbMEgdn4b1BUDUa73xILlwthv0sI/OhQWZ2vO5rnVveYmLeBa84fJmr+sSEeKlYz/u1pKh1u6ksPG7D3hnB/aEc/IT3DPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3K6/kiWG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xo+LolKF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3K6/kiWG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xo+LolKF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDD0B21BA0;
	Fri, 27 Sep 2024 11:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727438113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/3WmS5Gt2NkAv3aG88qqljeWPN827Cnk+c09JDbE/Q=;
	b=3K6/kiWG/OeNmzrlNz92iWQ4Xz3ytwQAbiajY7Ghq49UimiPT0AN103MGjw2sjUpFvFZVL
	eobp6SGErOy6UgoYwQrDhpLHGkNgxobUt0YH7mxIqgq14DHP/QN9LeysIa0R5MUuheoaFO
	YJcUbN1q8kYao4YBWt8chnDLbsGBEbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727438113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/3WmS5Gt2NkAv3aG88qqljeWPN827Cnk+c09JDbE/Q=;
	b=Xo+LolKFPp8AyWHjW21eqqPo8fGHo5BZTlA1G1p5wJVaCe4NQb5Z2ZPoxuV/7W0QUt6qNB
	KXNnGZy2/ULL8yDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="3K6/kiWG";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Xo+LolKF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727438113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/3WmS5Gt2NkAv3aG88qqljeWPN827Cnk+c09JDbE/Q=;
	b=3K6/kiWG/OeNmzrlNz92iWQ4Xz3ytwQAbiajY7Ghq49UimiPT0AN103MGjw2sjUpFvFZVL
	eobp6SGErOy6UgoYwQrDhpLHGkNgxobUt0YH7mxIqgq14DHP/QN9LeysIa0R5MUuheoaFO
	YJcUbN1q8kYao4YBWt8chnDLbsGBEbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727438113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/3WmS5Gt2NkAv3aG88qqljeWPN827Cnk+c09JDbE/Q=;
	b=Xo+LolKFPp8AyWHjW21eqqPo8fGHo5BZTlA1G1p5wJVaCe4NQb5Z2ZPoxuV/7W0QUt6qNB
	KXNnGZy2/ULL8yDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF1B813A73;
	Fri, 27 Sep 2024 11:55:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y/x6KiGd9mbsdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Sep 2024 11:55:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 62B8FA0826; Fri, 27 Sep 2024 13:55:09 +0200 (CEST)
Date: Fri, 27 Sep 2024 13:55:09 +0200
From: Jan Kara <jack@suse.cz>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: jack@suse.com, zhaomengmeng@kylinos.cn, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] udf: refactor udf_current_aext() to handle error
Message-ID: <20240927115509.a6ie4b75c65gjvfu@quack3>
References: <20240926120753.3639404-1-zhaomzhao@126.com>
 <20240926120753.3639404-2-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926120753.3639404-2-zhaomzhao@126.com>
X-Rspamd-Queue-Id: BDD0B21BA0
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 26-09-24 20:07:51, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> As Jan suggested in links below, refactor udf_current_aext() to
> differentiate between error and "hit EOF", it now takes pointer to etype
> to store the extent type, return 0 when get etype success; return -ENODATA
> when hit EOF; return -EINVAL when i_alloc_type invalid. Add two macroes to
> test return value.
> 
> Link: https://lore.kernel.org/all/20240912111235.6nr3wuqvktecy3vh@quack3/
> Signed-off-by: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> Suggested-by: Jan Kara <jack@suse.cz>
...
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

This looks wrong. If udf_current_aext() succeeds, you'll immediately abort
the loop now. I'd rather code this as:

	while (1) {
		err = udf_current_aext(inode, epos, eloc, elen, &etype, inc);
		if (err || etype != (EXT_NEXT_EXTENT_ALLOCDESCS >> 30))
			break;
		...
	}

> diff --git a/fs/udf/udfdecl.h b/fs/udf/udfdecl.h
> index 88692512a466..a902652450dd 100644
> --- a/fs/udf/udfdecl.h
> +++ b/fs/udf/udfdecl.h
> @@ -43,6 +43,9 @@ extern __printf(3, 4) void _udf_warn(struct super_block *sb,
>  #define UDF_NAME_LEN		254
>  #define UDF_NAME_LEN_CS0	255
>  
> +#define UDF_EXT_EOF(err)        ((err) == -ENODATA)
> +#define UDF_EXT_ERR(err)        (((err) < 0) && (!UDF_EXT_EOF(err)))
> +

So I agree the explicit ENODATA checks are a bit ugly but these macros
aren't really much better. How about the following calling convention:

On error, ret < 0, on EOF ret == 0, on success ret == 1. This is a similar
convention as e.g. for read(2) so it is well understood and easy test for
various combinations.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

