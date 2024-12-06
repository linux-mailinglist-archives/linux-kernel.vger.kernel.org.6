Return-Path: <linux-kernel+bounces-435028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEFB9E6E94
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B25B281FC9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42C9204084;
	Fri,  6 Dec 2024 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u37M/cNI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oe4CIw8r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u37M/cNI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oe4CIw8r"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8774E201006;
	Fri,  6 Dec 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489554; cv=none; b=VOrDgV5j5yAbjAoP38nZ4mVG/Or4sLoTy7SZBFVaW6386UpSLBHGsv3uG9NlC5dgvtuoD+/GyVLyh+wCLG0/rBOshzw2BXOhwbBVfoxmj2Vwl2hKBnNZl898W+FDTnoU/E8Ln2MkJX1pwxCbKaDDsg7gwczo1Cs7oT4djjJCPA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489554; c=relaxed/simple;
	bh=IiDFzbtUC6tGJvkfabA6g8PDJfQlwY9sHpir1X28Rro=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OG8k4xAYtddBNAWgaelTJluCSnuiH1rePgF4rPPTLzJIJ46EH7Laxm6YacsIT3ibjWHq2CJjyHunMGbfghnkXlF4jurNAPxcw1xuiFl+SXgENSZhf2/G0LWrINmwhVqX3fiYuRUiQdJaPdfOhqoSvyN1Lelzy61zoyxZjc0xwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u37M/cNI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oe4CIw8r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u37M/cNI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oe4CIw8r; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92281210F8;
	Fri,  6 Dec 2024 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733489549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2OuCvqgVh+5HH+wLZzsP2rOaALcuPL4ok2eCIQtx9c=;
	b=u37M/cNIuCsbZvPny3Cd7bJsPyl0Lj2wZIGr/FF+WwDni6s2Zw9gUVKruEiCc+QmPp4T5D
	GUK+kWMQKM/GtrIbwKLe7/MJY+PBZbJ1BDonNFc4mRT4XGAbB5CRC03LdiLTbHsc6jXb7E
	5VKzikOC6igzzWMgEgdMHIjiuNWuBPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733489549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2OuCvqgVh+5HH+wLZzsP2rOaALcuPL4ok2eCIQtx9c=;
	b=oe4CIw8rNktj08pcThDxJZOTx2S5qwx/KrdynssCnzSHxnlL3FPh8J2KhYTLsHDMi+u8aF
	pB+YKrvjKGpcGQCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="u37M/cNI";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oe4CIw8r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733489549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2OuCvqgVh+5HH+wLZzsP2rOaALcuPL4ok2eCIQtx9c=;
	b=u37M/cNIuCsbZvPny3Cd7bJsPyl0Lj2wZIGr/FF+WwDni6s2Zw9gUVKruEiCc+QmPp4T5D
	GUK+kWMQKM/GtrIbwKLe7/MJY+PBZbJ1BDonNFc4mRT4XGAbB5CRC03LdiLTbHsc6jXb7E
	5VKzikOC6igzzWMgEgdMHIjiuNWuBPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733489549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2OuCvqgVh+5HH+wLZzsP2rOaALcuPL4ok2eCIQtx9c=;
	b=oe4CIw8rNktj08pcThDxJZOTx2S5qwx/KrdynssCnzSHxnlL3FPh8J2KhYTLsHDMi+u8aF
	pB+YKrvjKGpcGQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 584CB138A7;
	Fri,  6 Dec 2024 12:52:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ehdEFI3zUmeFSwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 06 Dec 2024 12:52:29 +0000
Date: Fri, 06 Dec 2024 13:52:28 +0100
Message-ID: <87plm5rn1v.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: liujing <liujing@cmss.chinamobile.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	drhodes@opensource.cirrus.com,
	jbrunet@baylibre.com,
	broonie@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: cmipci: Modify the incorrect format specifier
In-Reply-To: <20241206021647.2343-1-liujing@cmss.chinamobile.com>
References: <20241206021647.2343-1-liujing@cmss.chinamobile.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 92281210F8
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Fri, 06 Dec 2024 03:16:47 +0100,
liujing wrote:
> 
> Replace %d with %u in snprintf() because it is "unsigned int".
> 
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>

I applied this one, but please keep in mind that we don't have to
convert all those cases blindly.  The code there is correct even with
"%d", as the value can't be a negative value.

That said, if you keep working on a similar case, you'd better study
the code more closely and judge whether it really "fixes" any real
bug or not, before submitting patches at the next time.


thanks,

Takashi

