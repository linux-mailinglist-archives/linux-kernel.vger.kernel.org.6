Return-Path: <linux-kernel+bounces-320045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C05970566
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF86282BDB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 07:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845454964E;
	Sun,  8 Sep 2024 07:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kvkWWxAI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hU6AsOxY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fVTVBvg3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KmRQ4qlH"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62F41B85F2;
	Sun,  8 Sep 2024 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725781655; cv=none; b=kMZqYFbWkz98nslpxB3b6pNYq/zrd1t2FHDNzfPuyNa/QRjmYZgFfck78rAOF/0TyrVRcLDL3yMG5U05jg5w7caOnwXgv6L7HoWn+MRyOrJ2xPf0FYSxjenKqRVjNlRrFCxpSl+r21vhhTlqAxreBQVezcsgZRViKSB9oBZUdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725781655; c=relaxed/simple;
	bh=5UehFWUt0K1BUTxNcW1HJjuI3+130MQpcU47klPxKzs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrxyiOknC6qyJpfLOvbFb0WAasjoHBnumoxM41QcTPehbv+MCuAmXxpB/D5CUqBSsgw4o0Plo4DSVwjniBFPHtczADD4kQeFokpqXZq1yNYzz+MB7supmCu1yTZaUZ4Dp7uaWEhgbKyivL1Lz5A9hkTlLUzMqseaAtN4aWoWyk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kvkWWxAI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hU6AsOxY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fVTVBvg3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KmRQ4qlH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F3E31F7C6;
	Sun,  8 Sep 2024 07:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725781651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsuLdmXzISZat7fXiN0cO6Jl6Y+DuzGQh+JMXsuwMQs=;
	b=kvkWWxAIQtXtbW+7KEjxmGXWCNwbaeBUjRl8co3w4mRWNzEtM73Fgw2mwd5/7F+bUQA+Za
	3jEKuQdrXfh3ezCdwEIcHxqtQ0JyMLU0B8mi5uy1ZQnbv9OtGfx6aEkWA8M181mudid7TN
	b0OUN5Bo96BsAJHKUiZXX0pK4RkYM0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725781651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsuLdmXzISZat7fXiN0cO6Jl6Y+DuzGQh+JMXsuwMQs=;
	b=hU6AsOxYfeGzW1n9bMff5iccBe+0/lzKu62xMcURQ2YKHynYxEhqRobqKCIi1kYSPjTnDw
	IicdF5OYy3ddtDBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fVTVBvg3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KmRQ4qlH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725781650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsuLdmXzISZat7fXiN0cO6Jl6Y+DuzGQh+JMXsuwMQs=;
	b=fVTVBvg3l/x8eIGBrIlWEX5ETb2u5rKpH+Wi5CZVd6eALBeXg6RD6QrOLuuJIjXZhiooo4
	IqECBJ/f0iVCgUvFEQ4BT30wt9zXNciiHX98dzfsVTvxeacScVCtWfEeNczatB7TZmKCjR
	4KS3dcv4ja2sLPW5XJIB6LAfd2l2BoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725781650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsuLdmXzISZat7fXiN0cO6Jl6Y+DuzGQh+JMXsuwMQs=;
	b=KmRQ4qlHuxcYFgD8wX2WyP/nJNZcred/67/PVXZ1nx5SbWfj4+w0GgDoIX5poUMl6bvkJA
	RYIAvLiDHWYhNSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A06A13ADE;
	Sun,  8 Sep 2024 07:47:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pvVUEJJW3WbOBgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 08 Sep 2024 07:47:30 +0000
Date: Sun, 08 Sep 2024 09:48:17 +0200
Message-ID: <878qw2d1ry.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Joshua Pius <joshuapius@chromium.org>
Cc: alsa-devel@alsa-project.org,
	Joshua Pius <joshuapius@google.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Steven 'Steve' Kendall" <skend@chromium.org>,
	Karol Kosik <k.kosik@outlook.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add logitech Audio profile quirk
In-Reply-To: <20240906211445.3924724-1-joshuapius@google.com>
References: <20240906211445.3924724-1-joshuapius@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 8F3E31F7C6
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[alsa-project.org,google.com,perex.cz,suse.com,chromium.org,outlook.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Fri, 06 Sep 2024 23:14:38 +0200,
Joshua Pius wrote:
> 
> Specify shortnames for the following Logitech Devices: Rally bar, Rally
> bar mini, Tap, MeetUp and Huddle.
> 
> Signed-off-by: Joshua Pius <joshuapius@google.com>

Is this change needed only for UCM profiles?  UCM v2 should be able to
handle better to identify models, and such short name updates aren't
needed for them.

OTOH, I don't mind much to take this kind of small harmless changes
(unless it happens too frequently).  So I'll likely take this, but
just for verifying the situation.


thanks,

Takashi


> ---
>  sound/usb/card.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/usb/card.c b/sound/usb/card.c
> index 778de9244f1e..9c411b82a218 100644
> --- a/sound/usb/card.c
> +++ b/sound/usb/card.c
> @@ -384,6 +384,12 @@ static const struct usb_audio_device_name usb_audio_names[] = {
>  	/* Creative/Toshiba Multimedia Center SB-0500 */
>  	DEVICE_NAME(0x041e, 0x3048, "Toshiba", "SB-0500"),
>  
> +	/* Logitech Audio Devices */
> +	DEVICE_NAME(0x046d, 0x0867, "Logitech, Inc.", "Logi-MeetUp"),
> +	DEVICE_NAME(0x046d, 0x0874, "Logitech, Inc.", "Logi-Tap-Audio"),
> +	DEVICE_NAME(0x046d, 0x087c, "Logitech, Inc.", "Logi-Huddle"),
> +	DEVICE_NAME(0x046d, 0x0898, "Logitech, Inc.", "Logi-RB-Audio"),
> +	DEVICE_NAME(0x046d, 0x08d2, "Logitech, Inc.", "Logi-RBM-Audio"),
>  	DEVICE_NAME(0x046d, 0x0990, "Logitech, Inc.", "QuickCam Pro 9000"),
>  
>  	DEVICE_NAME(0x05e1, 0x0408, "Syntek", "STK1160"),
> -- 
> 2.46.0.598.g6f2099f65c-goog
> 

