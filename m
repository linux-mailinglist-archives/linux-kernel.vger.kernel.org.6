Return-Path: <linux-kernel+bounces-216169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E1C909C3D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 09:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6477D1C21D2B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 07:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6201184114;
	Sun, 16 Jun 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yOIDwBEW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jtzf6lfq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yOIDwBEW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jtzf6lfq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337901836D3;
	Sun, 16 Jun 2024 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718523496; cv=none; b=CR8UNRjXadE1AHPtSRklr9StN6ezuvkmVLVMJtLBb5JFakdiNJYh5jRw2jBoZgHcFuChNXqEQi3OP8smUYHyjkWCCQ4brsYtv7L98D8Mu/1fesJ2KTN/NQFgqVHJyUeRJb6O8uJP5DwUzIMfY44dzo3bmAA6haYnCjoAkeFhv+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718523496; c=relaxed/simple;
	bh=xsJunObOHYvTmkmmNYAdoRsCPO9tBXmwA4HekcNlrJ8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSdIh7DbWnjP04bfKaEpzq4+NHhYnQQ6+StYRgesaiYE+yYke+WDtbcKGltc5TO73a7Vacv5ibsGUcVH8Ls0HgXEC4CXjQZTzf5NdOnaEXFkFNHvzAUTXf5QFacHG0vlTY4W9wA4aweBzUK5YnRFYejdBa9zjDvOG8ivMZZSs7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yOIDwBEW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jtzf6lfq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yOIDwBEW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jtzf6lfq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E5945CCCA;
	Sun, 16 Jun 2024 07:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718523492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Tap0GsPP7pc1P9FCevbnU7pnjtJrdhQybL5YgnNd38=;
	b=yOIDwBEWrttlcFBuJ/SIjpO1wS3Z0EN/rF2yP03WdHVi2yrnRqtUUeU6lsJz638pmoCl6m
	oLH8PWJHohJ3TC/H0578cAT33pQWBdqTlDQyfTL33JcohpQyATz6l48QcdvkKPEqDBm9yi
	V43VXtuHvdA0fDHfbhlR98ABdqIkwNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718523492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Tap0GsPP7pc1P9FCevbnU7pnjtJrdhQybL5YgnNd38=;
	b=jtzf6lfqRKYP52PhyET904lY0Abh8g75Y4TDbmD/+e3GcWIV6xlceLd3FHtYAfajWhWuXs
	PkziJ8lhtyTQoGDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yOIDwBEW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jtzf6lfq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718523492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Tap0GsPP7pc1P9FCevbnU7pnjtJrdhQybL5YgnNd38=;
	b=yOIDwBEWrttlcFBuJ/SIjpO1wS3Z0EN/rF2yP03WdHVi2yrnRqtUUeU6lsJz638pmoCl6m
	oLH8PWJHohJ3TC/H0578cAT33pQWBdqTlDQyfTL33JcohpQyATz6l48QcdvkKPEqDBm9yi
	V43VXtuHvdA0fDHfbhlR98ABdqIkwNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718523492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Tap0GsPP7pc1P9FCevbnU7pnjtJrdhQybL5YgnNd38=;
	b=jtzf6lfqRKYP52PhyET904lY0Abh8g75Y4TDbmD/+e3GcWIV6xlceLd3FHtYAfajWhWuXs
	PkziJ8lhtyTQoGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E75B713AB9;
	Sun, 16 Jun 2024 07:38:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lylBN2OWbmboCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 16 Jun 2024 07:38:11 +0000
Date: Sun, 16 Jun 2024 09:38:36 +0200
Message-ID: <87a5jl5ocj.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ajrat Makhmutov <rautyrauty@gmail.com>
Cc: alsa-devel@alsa-project.org,
	perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	wzhd@ustc.edu,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad 330-17IKB 81DM
In-Reply-To: <20240615125457.167844-1-rauty@altlinux.org>
References: <20240615125457.167844-1-rauty@altlinux.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-5.23 / 50.00];
	BAYES_HAM(-2.72)[98.79%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4E5945CCCA
X-Spam-Flag: NO
X-Spam-Score: -5.23
X-Spam-Level: 

On Sat, 15 Jun 2024 14:54:57 +0200,
Ajrat Makhmutov wrote:
> 
> Headset microphone do not work out of the box with this laptop. This
> quirk fixes it. Zihao Wang specified the wrong subsystem id in his patch.
> 
> Link: https://lore.kernel.org/all/20220424084120.74125-1-wzhd@ustc.edu/
> Fixes: 3b79954fd00d ("ALSA: hda/realtek: Add quirk for Yoga Duet 7 13ITL6 speakers")
> Signed-off-by: Ajrat Makhmutov <rauty@altlinux.org>

Your From address and Signed-off-by address are different.
Could you try to align them?

I can take as-is if inevitably necessary, but usually it's a wrong
sign.


thanks,

Takashi

