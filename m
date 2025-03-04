Return-Path: <linux-kernel+bounces-543919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842EBA4DB6A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99448189625D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7266D1FF7B4;
	Tue,  4 Mar 2025 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BPLurmrQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FwaEmFZn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BPLurmrQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FwaEmFZn"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD971FF7AC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085476; cv=none; b=nI5ZFI34aKaEa/wHfpqpB7MrFTuXSPlBoJblKF9JbAeYKZ0OkTR1SHQ3NUKHhfxPEGACaDxozz3WDuIP54YlFdiCDnavh9o27ehlSVVa7Nx1XR5b8137wYU8mzYSY4hjkgWlwVBFMGje4y0bbX/eMxELimmleACXQEPOf5jf7AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085476; c=relaxed/simple;
	bh=ThBMwYug522ffTxIg9dj+CgK6WkcX1WAxIdTYy6IoaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQVhMSiUVW/qeA7OJa4XzGjm4ieuPw30DjSHnUzS0KZFf3X7a9Kq3+k6OUVArIjdWMF/oHYbDMBZNtJoJa9kEfCvV2AV0wBwChoN/IjhwPGgczws+eS4unvjyi29rBDL43twfH/BEYlCZfmlPa5NXD4EgLObQrJcAVT6bpIyrbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BPLurmrQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FwaEmFZn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BPLurmrQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FwaEmFZn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C21F1F393;
	Tue,  4 Mar 2025 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741085473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU3smIycQT9MjQ4GLwsssdlVXwc7elZMY/A7sUeeWhU=;
	b=BPLurmrQ3oFJdqSZUBdE7WRt7WOHkabw9pgHLwVgofOT1PPTJs8UwZ4Af/awp4TtVF/YdW
	syCQPA/k4sSmcXSTc+LXGs9qWb4G9l8Z2dxXxWiAV0mNiC5VTttNShqIpdw7wGyNjuYhfp
	JbLSxirAqD4z5uRT7/a6a6iWdTrKALI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741085473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU3smIycQT9MjQ4GLwsssdlVXwc7elZMY/A7sUeeWhU=;
	b=FwaEmFZnTf5xQFACU7tvOF6aocbG1wVm6tn4dQuSPoY62TRl5ScdMhceoL/onXH7w3SFQy
	PppvLITPLR9XTMCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741085473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU3smIycQT9MjQ4GLwsssdlVXwc7elZMY/A7sUeeWhU=;
	b=BPLurmrQ3oFJdqSZUBdE7WRt7WOHkabw9pgHLwVgofOT1PPTJs8UwZ4Af/awp4TtVF/YdW
	syCQPA/k4sSmcXSTc+LXGs9qWb4G9l8Z2dxXxWiAV0mNiC5VTttNShqIpdw7wGyNjuYhfp
	JbLSxirAqD4z5uRT7/a6a6iWdTrKALI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741085473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CU3smIycQT9MjQ4GLwsssdlVXwc7elZMY/A7sUeeWhU=;
	b=FwaEmFZnTf5xQFACU7tvOF6aocbG1wVm6tn4dQuSPoY62TRl5ScdMhceoL/onXH7w3SFQy
	PppvLITPLR9XTMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00A5A1393C;
	Tue,  4 Mar 2025 10:51:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2WIdACHbxmfsaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Mar 2025 10:51:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BCA57A0912; Tue,  4 Mar 2025 11:51:08 +0100 (CET)
Date: Tue, 4 Mar 2025 11:51:08 +0100
From: Jan Kara <jack@suse.cz>
To: cgzones@googlemail.com
Cc: Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, cocci@inria.fr, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 03/11] ext4: reorder capability check last
Message-ID: <kmfmwblxeav63y3noxb65pkrzw5nggbrwxblgtzt3ntag4gwrz@bz3r2vpnkozb>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
 <20250302160657.127253-2-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250302160657.127253-2-cgoettsche@seltendoof.de>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[googlemail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[googlemail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Sun 02-03-25 17:06:39, Christian Göttsche wrote:
> From: Christian Göttsche <cgzones@googlemail.com>
> 
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/balloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index 8042ad873808..c48fd36b2d74 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -649,8 +649,8 @@ static int ext4_has_free_clusters(struct ext4_sb_info *sbi,
>  	/* Hm, nope.  Are (enough) root reserved clusters available? */
>  	if (uid_eq(sbi->s_resuid, current_fsuid()) ||
>  	    (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) && in_group_p(sbi->s_resgid)) ||
> -	    capable(CAP_SYS_RESOURCE) ||
> -	    (flags & EXT4_MB_USE_ROOT_BLOCKS)) {
> +	    (flags & EXT4_MB_USE_ROOT_BLOCKS) ||
> +	    capable(CAP_SYS_RESOURCE)) {
>  
>  		if (free_clusters >= (nclusters + dirty_clusters +
>  				      resv_clusters))
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

