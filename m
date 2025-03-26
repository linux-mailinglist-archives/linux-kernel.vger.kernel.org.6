Return-Path: <linux-kernel+bounces-577492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89161A71DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12053170DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AEE2192F5;
	Wed, 26 Mar 2025 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NA8XzC+G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fq2PC/xB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A64a30eR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rlnu3tGI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B919E7E2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011836; cv=none; b=opYz9DyE1n0J9n1/FvQ7babgApBUEsnrCJHLc+QEaKAWcuXFKkMMfjEE/uheh2BJuTVnH/Npvb7eVZ8vWFamn7ps9f9+1vfuWJBdDlCtSSriuij8kwpEadhbV+bVjjCGQ5czUqJ56cmrZ2sElIA0XJc13LULkmCQLHUiZ31GALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011836; c=relaxed/simple;
	bh=y2Bavw+fb2yGj75P8FeHHge6IUp29GnDyZ5KZhxnMMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aO6PLdBkM7P/m+gkOrYr7B/EpbtWVxoK3pHCqBkJoNYHETnawvFZ7dqScCcV2vPGLawKMEDl5af4Lmih09hXlg/YMnzjRnmrBASts7sJNoZulmgVNCLAVX9Fj73cvtJLl2PEasGUJLv8GgQ9lFmQxYNksrlI+A4L8qcP+lxRSo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NA8XzC+G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fq2PC/xB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A64a30eR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rlnu3tGI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD79D1F391;
	Wed, 26 Mar 2025 17:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743011833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LhbcJbX1E8/sAF7u3AaRHNUnCD+wtvVbag4T1LGLR+c=;
	b=NA8XzC+GdycsBYmAjlliy8ESatOWuxEPezBNghytnk9a61smBlukKctAbo/jGlg2YpY+uZ
	GnjwxWy3yP92QS8Grg3dBwNa/phqi7dwFRQ0tyQeZSMYD7niCeV1Ujz2CKRlUTC7xPLecS
	L8I3QQOXsVk/ykL7z85ttA9NscGcIWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743011833;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LhbcJbX1E8/sAF7u3AaRHNUnCD+wtvVbag4T1LGLR+c=;
	b=fq2PC/xB0VbE7J02pWhwhw+rJ6afTye8pGkXMtRrUNRy96Kdj2Z2hzTQyPRnlkdkh8UJxI
	6erv2gZ4kZqZ3tBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743011832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LhbcJbX1E8/sAF7u3AaRHNUnCD+wtvVbag4T1LGLR+c=;
	b=A64a30eRyCtwt9FsPVJ+Budx2+5Nf6/7G4KdWkD+RdwKy7vL5+Y9i+CuXMxP30QFt6+ryr
	loFOr8gFxorbU+vz4qavFhl2TBY7QabOYQLpMJ1QqQjXOBIf9JEKuA4jhXZXKYBGV+zz9D
	nwNl/61Zz3x/wWLcploDIvLpiV254u4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743011832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LhbcJbX1E8/sAF7u3AaRHNUnCD+wtvVbag4T1LGLR+c=;
	b=Rlnu3tGIwA1JdrPyQnRbeubVAmPp7LweN6VUaHryfWNuIu14+8iYuNRdGBtBXvmNHPj8uF
	BoC/ZXPOKlmd19BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B972B1374A;
	Wed, 26 Mar 2025 17:57:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a9IBLfg/5Gc3DQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 26 Mar 2025 17:57:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4C7F2A082A; Wed, 26 Mar 2025 18:57:08 +0100 (CET)
Date: Wed, 26 Mar 2025 18:57:08 +0100
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: jack@suse.cz, hch@infradead.org, James.Bottomley@hansenpartnership.com, 
	david@fromorbit.com, rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, 
	song@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gost.dev@samsung.com
Subject: Re: [RFC 4/6] ext4: replace kthread freezing with auto fs freezing
Message-ID: <ii74e3kgrkamwkx3md6mkalmmzffi6c6ieoebepu6e7bsrjikg@acalyy2cmi6b>
References: <20250326112220.1988619-1-mcgrof@kernel.org>
 <20250326112220.1988619-5-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326112220.1988619-5-mcgrof@kernel.org>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 26-03-25 04:22:18, Luis Chamberlain wrote:
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 0d523e9fb3d5..ae235ec5ff3a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6782,7 +6782,7 @@ static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
>  
>  static bool ext4_trim_interrupted(void)
>  {
> -	return fatal_signal_pending(current) || freezing(current);
> +	return fatal_signal_pending(current);
>  }

I think this is wrong. ext4_trim_interrupted() gets called from a normal
process that's doing fstrim (which can take a long time and we don't want
to block system suspend with it). So IMO this should stay as is.

Otherwise the patch looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

