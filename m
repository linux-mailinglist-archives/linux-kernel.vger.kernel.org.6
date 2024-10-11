Return-Path: <linux-kernel+bounces-360799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 021DA999FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31EF61C21510
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83AE20C49A;
	Fri, 11 Oct 2024 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0ZgGEb+Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LwNn/VY5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ngy1J+yb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WM6/2M1N"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8589520C47F;
	Fri, 11 Oct 2024 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638007; cv=none; b=BVpkt/e/QBAvlnSWfx2/iWtdEM5vSkgXi+jsAbnV6eoiQlUj+PIogeGgvBEP/uMbtmxGeA75YUft9FmU/R/VKULRR5pUDFG5PEYVO1AuaVqJNV4K72Ln3Jg0FHE0io8F+XTOCoTPY4cL6WuSIv9OcPfg3Jc4YRHnQpXckFm4hok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638007; c=relaxed/simple;
	bh=I0zPs4tdC3JVFAT1NNhbRPgYh1D19zKmb9vE6Hb3gJw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d89NuPdJkQoAgsPc2eD7/0TzrPZ0gYc0+oPQGRQOC8G1dh1gNKpxlHUjoAGQ6tkWS+YTX3+qsLjSqTk+gev5tkfLi6GClp/bX0KSCm7o8kwm6QvL0hI07jq2vdv1GtiM2pSpFw+e5CSaovaXMG+MRVhnXp4+2wV0/Z9DREITCnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0ZgGEb+Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LwNn/VY5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ngy1J+yb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WM6/2M1N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EACC1F811;
	Fri, 11 Oct 2024 09:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728638003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mM41zVvInbeLJExnZbxsbwWFDARvVW/YdPw96Mjt1pw=;
	b=0ZgGEb+Y1PJ8kmiOhwxKUz1mVh25Nj0GyiN7GPBfiBWXl8KOAO7VAq1mFkpQ1qUbSNV1N1
	iSjP+bJWSPhSMqBZNO/MANbcyWKsciSZdRMT6/walxnImYIbDCdxcKGObLhABxAq4EvWRt
	InbFX2qBZO5XoiWCwOgcfD8x4sd6z7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728638003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mM41zVvInbeLJExnZbxsbwWFDARvVW/YdPw96Mjt1pw=;
	b=LwNn/VY5Yemw4BjtbLwqGHODAhMcCs/WqHItAuciGysh/662UDcW6wvHFuEw/jtyhVW4yU
	QiegFMtW8mvHtuCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ngy1J+yb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="WM6/2M1N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728638002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mM41zVvInbeLJExnZbxsbwWFDARvVW/YdPw96Mjt1pw=;
	b=Ngy1J+ybeJtccoGItFV9lgBm3V+oC/oY8326qgqCSli7L4yo7+P2fYowK9hE0dUsSh7Cu4
	1As1AJIxMnnnr7XO9wk8naZlBnQn8M+Wwi/6hBifQ4OIIdl9MZdpDaAwVrNl73DTIWIVc1
	BzClw5nqW/VWFHRLZvayaunvTnMhbUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728638002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mM41zVvInbeLJExnZbxsbwWFDARvVW/YdPw96Mjt1pw=;
	b=WM6/2M1NoKBtyBOLilqOrXqHdwfj3E7OL6MeIz8L9rSNGxyjQG8wiG+ItiJUWQLAoTWBoF
	G/t/f4a7s9IfBjBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD1B9136E0;
	Fri, 11 Oct 2024 09:13:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XXWzNDHsCGfhKQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 11 Oct 2024 09:13:21 +0000
Date: Fri, 11 Oct 2024 11:14:18 +0200
Message-ID: <87msjbm26t.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Murad Masimov <m.masimov@maxima.ru>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Vitaly
 Rodionov <vitalyr@opensource.cirrus.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: Re: [PATCH] ALSA: hda/cs8409: Fix possible NULL dereference
In-Reply-To: <20241010221649.1305-1-m.masimov@maxima.ru>
References: <20241010221649.1305-1-m.masimov@maxima.ru>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 1EACC1F811
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,maxima.ru:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Fri, 11 Oct 2024 00:16:45 +0200,
Murad Masimov wrote:
> 
> If snd_hda_gen_add_kctl fails to allocate memory and returns NULL, then
> NULL pointer dereference will occur in the next line.
> 
> Since dolphin_fixups function is a hda_fixup function which is not supposed
> to return any errors, add simple check before dereference, ignore the fail.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 20e507724113 ("ALSA: hda/cs8409: Add support for dolphin")
> Signed-off-by: Murad Masimov <m.masimov@maxima.ru>

Thanks, applied.


Takashi

