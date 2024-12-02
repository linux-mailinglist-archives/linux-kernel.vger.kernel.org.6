Return-Path: <linux-kernel+bounces-427516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD989E0242
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5024B16CE65
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C101F1D86C4;
	Mon,  2 Dec 2024 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="il9t9uvf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OOpSWjti";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q4XvLasg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DnjBhUUs"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1A1FECA4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142503; cv=none; b=XcebG9JUeDiBuHCqtds5+tbnRMiKlvb1bpkZ7vmmfzbq66Mp6t6wWse2b43q7zsgqTBA6EDIUXkOSwkgluJdOnG54p8njiEsxotQtHNbjUyBr2k6iPDfim06byLNd8j5IY59C0xljwyQ2kO390ld+/7lzv8GHe6waGOop0KNgIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142503; c=relaxed/simple;
	bh=Tk0qjwQEMkywcdSa+PIfyd8CV/01dTFMtqqbV8op3Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikZSqiqCarMFiEqvdlk0CqLQTYE7wL0XG3nv+AjOOVB/HXFYXOc272K+qN+hbdxLrMBqxOQpzOwq5CSLXV3bf0OTbYOKoMoIYVWMy32AL4ComzleGh/DzM7rIv6rqgpLsMmRgKNhzof0o2rIH1CY0uMIT3eZJvWnqd0HwLeoOJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=il9t9uvf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OOpSWjti; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q4XvLasg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DnjBhUUs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD3EB1F749;
	Mon,  2 Dec 2024 12:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733142499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unXMwnv3ss+xZaSObiyKzh7O7H0Eu6amrmtuMsJ1clk=;
	b=il9t9uvfJWYuGHttHnZ7XyicsZFLhpx7A+fEQwX0XwoJdJCiixnPZxVIusfmm38gKjxaqi
	ef2JBAx+j9DDmTdwyYz6WMC/M/RTKiUYDCYin8msXGHeFXn+KRwA3GyKwSzHESK/YpsCGW
	HUKNumgUUa1wGYQzypVY6wA1+zrz6bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733142499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unXMwnv3ss+xZaSObiyKzh7O7H0Eu6amrmtuMsJ1clk=;
	b=OOpSWjtihIUMHvvRmiovZQ7iA/OyqtF4Lvzl2Yf9IgVFDi4Bw8+PnXYstelL+rqgJ5Srtk
	ge5N8U7AHr4M0kAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=q4XvLasg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DnjBhUUs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733142498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unXMwnv3ss+xZaSObiyKzh7O7H0Eu6amrmtuMsJ1clk=;
	b=q4XvLasg0W2po2ydOI9wyLaCMiZ8CFuMKcLZHGGjnXUu+gujfGv4uUOsBPbzC7I5j3a/UF
	FyBPNRz/cxSFSgJ01jjCrVQiHQO2IC7p09FrLsgVjzvU1wFPfBVsZkDJXq/yYudh9MoXld
	QgwNm5I+NNGNtJBQcMzaDf6iwn+kvbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733142498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unXMwnv3ss+xZaSObiyKzh7O7H0Eu6amrmtuMsJ1clk=;
	b=DnjBhUUs0J3lNCb6MnpbBLOc2QvKevNfnR8mvgybrFrvy50zGPoqdVyPoNC8GYDOE7e8t+
	TuGRrrK6ztvH6bAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3EBA13A31;
	Mon,  2 Dec 2024 12:28:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zrW7M+KnTWd0dQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Dec 2024 12:28:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8D517A07B4; Mon,  2 Dec 2024 13:28:18 +0100 (CET)
Date: Mon, 2 Dec 2024 13:28:18 +0100
From: Jan Kara <jack@suse.cz>
To: Leo Stone <leocstone@gmail.com>
Cc: syzbot+5df2d3fa14f2d3e49305@syzkaller.appspotmail.com, jack@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: Prevent rmdir of deleted directories
Message-ID: <20241202122818.4zzg6lmspgzukkwv@quack3>
References: <6747ce03.050a0220.253251.0066.GAE@google.com>
 <20241202004104.20604-2-leocstone@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202004104.20604-2-leocstone@gmail.com>
X-Rspamd-Queue-Id: DD3EB1F749
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[5df2d3fa14f2d3e49305];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Sun 01-12-24 16:41:02, Leo Stone wrote:
> The syzbot reproducer mounts a UDF image with the undelete option
> enabled. It then creates a directory, and eventually attempts to call
> rmdir on it 65 times. Because the undelete option is set, the
> directory still gets found in udf_fiiter_find_entry(), and the link
> count of its parent directory is decremented until it triggers the
> warning in drop_nlink().
> 
> Prevent directories with the FID_FILE_CHAR_DELETED flag set from being
> deleted again.
> 
> #syz test
> 
> Reported-by: syzbot+5df2d3fa14f2d3e49305@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5df2d3fa14f2d3e49305
> Signed-off-by: Leo Stone <leocstone@gmail.com>

Thanks for looking into this but the fix is already queued into my tree and
I'll send it to Linus today.

								Honza

> ---
>  fs/udf/namei.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index 78a603129dd5..0a577b7459de 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -504,6 +504,12 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
>  	if (ret)
>  		goto out;
>  
> +	if (iter.fi.fileCharacteristics & FID_FILE_CHAR_DELETED) {
> +		udf_warn(inode->i_sb,
> +			 "tried to rmdir a directory that was already deleted\n");
> +		ret = -ENOENT;
> +		goto end_rmdir;
> +	}
>  	ret = -EFSCORRUPTED;
>  	tloc = lelb_to_cpu(iter.fi.icb.extLocation);
>  	if (udf_get_lb_pblock(dir->i_sb, &tloc, 0) != inode->i_ino)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

