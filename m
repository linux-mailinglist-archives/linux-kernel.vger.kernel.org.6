Return-Path: <linux-kernel+bounces-343531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BECA989C24
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9E71F21CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C7157A5C;
	Mon, 30 Sep 2024 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HOmP1KJ3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yTc5MB+g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HOmP1KJ3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yTc5MB+g"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AFE17BA6;
	Mon, 30 Sep 2024 08:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683368; cv=none; b=qG3XPxaYwir/Xzz/xCx+/+pES5PUf2LYWnn8M+4OUHaY1n/63JJfwtuej2jeHZhRDEwcOiL79VbsKf/40+D7Q2gv1LHr/kuQmyEBFGR52t20aAzmdO+IjLx2XWkRUcHD0kfU2Rc5bADIlDxHy5bUXdbddSPeryhrf5MQlZUYSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683368; c=relaxed/simple;
	bh=MB43YxyE/IqT0xiOmWbs9gs9eK7cQudzi/huB4jslwg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGN1NOS739YSu3JeE8Hi+yGsE9KO90XR4BV6lZeZOjF5QWl9bmezErIaLK6eDKSvZFE50eWzhrr4p+fbdeTFqNKkgIFrKC1FjviE8VR5Zwmlq2ajivzettKIpTheuDS6HWe+PMU9m9Q2DwAHoJIxSCFaPuhC95waPiX0g6/4DiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HOmP1KJ3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yTc5MB+g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HOmP1KJ3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yTc5MB+g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16DC021A3C;
	Mon, 30 Sep 2024 08:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727683365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1tTj0cKM1mYe8CJTSoy2Nf4xAnQpmVN3FYHvotOfusw=;
	b=HOmP1KJ3khfQG0Ofy5XHP2lry3bs9VA+NIgnBMwKKmqc/4iZSjSZk6QObCyl52Kwgf4TpP
	U4044RyTkwWpC4CBlkoGKbT7j6W7acb7x0Hk+N5lIMtzsZ5Y0VtGGEjX291IeTDZn1RRoy
	bPEa29wimtWnHDZi4qHAH2nRVsDNpPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727683365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1tTj0cKM1mYe8CJTSoy2Nf4xAnQpmVN3FYHvotOfusw=;
	b=yTc5MB+gB/cANsMul/S1zYJ8RXK/RGCjzN9Uh1XS8WxwtssyM6634FNvvXgN5kvU4B/4OG
	I43RgWqHcLuGK8Bw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HOmP1KJ3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yTc5MB+g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727683365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1tTj0cKM1mYe8CJTSoy2Nf4xAnQpmVN3FYHvotOfusw=;
	b=HOmP1KJ3khfQG0Ofy5XHP2lry3bs9VA+NIgnBMwKKmqc/4iZSjSZk6QObCyl52Kwgf4TpP
	U4044RyTkwWpC4CBlkoGKbT7j6W7acb7x0Hk+N5lIMtzsZ5Y0VtGGEjX291IeTDZn1RRoy
	bPEa29wimtWnHDZi4qHAH2nRVsDNpPA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727683365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1tTj0cKM1mYe8CJTSoy2Nf4xAnQpmVN3FYHvotOfusw=;
	b=yTc5MB+gB/cANsMul/S1zYJ8RXK/RGCjzN9Uh1XS8WxwtssyM6634FNvvXgN5kvU4B/4OG
	I43RgWqHcLuGK8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C711913A8B;
	Mon, 30 Sep 2024 08:02:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fyhBLyRb+ma4EwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Sep 2024 08:02:44 +0000
Date: Mon, 30 Sep 2024 10:03:37 +0200
Message-ID: <87cyklk1pi.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?GB2312?B?uvrBrMfa?= <hulianqin@vivo.com>
Cc: "perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"mbarriolinares@gmail.com" <mbarriolinares@gmail.com>,
	"wangdicheng@kylinos.cn" <wangdicheng@kylinos.cn>,
	"mmccarthy@mcintoshlabs.com" <mmccarthy@mcintoshlabs.com>,
	"xristos.thes@gmail.com" <xristos.thes@gmail.com>,
	"cyan.vtb@gmail.com"
	<cyan.vtb@gmail.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA: usb-audio: Add delay quirk for VIVO USB-C HEADSET
In-Reply-To: <TYUPR06MB62177E629E9DEF2401333BF7D2692@TYUPR06MB6217.apcprd06.prod.outlook.com>
References: <TYUPR06MB62177E629E9DEF2401333BF7D2692@TYUPR06MB6217.apcprd06.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 16DC021A3C
X-Spam-Level: 
X-Spamd-Result: default: False [-1.98 / 50.00];
	BAYES_HAM(-2.97)[99.88%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,gmail.com,kylinos.cn,mcintoshlabs.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.98
X-Spam-Flag: NO

On Wed, 25 Sep 2024 05:16:29 +0200,
ºúÁ¬ÇÚ wrote:
> 
> From: Lianqin Hu <hulianqin@vivo.com>
> 
> Audio control requests that sets sampling frequency sometimes fail on
> this card. Adding delay between control messages eliminates that problem.
> 
> Signed-off-by: Lianqin Hu <hulianqin@vivo.com>

Applied now.  Thanks.


Takashi

