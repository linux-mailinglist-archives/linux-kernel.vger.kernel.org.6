Return-Path: <linux-kernel+bounces-251837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D94930A74
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 17:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487D41F2198F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6203D1369B1;
	Sun, 14 Jul 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="St3OEl4V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="weOEtTC2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="St3OEl4V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="weOEtTC2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61657F;
	Sun, 14 Jul 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720969687; cv=none; b=VCqPevWN4h/pcelI91RGFFGpnoPG0bN+WC6AWWxc5Mq+wn8f3OY4XsGMZk/JlGQRuENVDUOamQs4XbrWk/aW6TU2aJVtFkjjvy5+S+9CBWw5Va8C7qY8SEdB0kj0M/Q4U+nAWtLYUYOnzpog8l4QhCnWvGgzew/6Gzg1jH6pOYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720969687; c=relaxed/simple;
	bh=z4uK2wz50/+ujGk9dJ81N+qx8v2u0ifn7szdlEIhXlo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZOHJpg4t6ZVKy0yVlhAwF8TwHHztiVGVuNaoSS2jNhcqaqYTxBjDGPOwCvtVZ5IEwOzZ79io5Xvpxo4uSiU2TnmWvCdNIBOlZIhZt59ltSPhtHLaTPjHdCFcFNvKY0Esp3obNKwEVNPlZMOlgypy0I9CzGTo5pCqKghutNZIs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=St3OEl4V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=weOEtTC2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=St3OEl4V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=weOEtTC2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB04621B5E;
	Sun, 14 Jul 2024 15:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720969683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYPEFvMyvQnlHJU4/kVrIFPFji0CTb8hIhM4cc7C55I=;
	b=St3OEl4VAkZQVkqRax03ojQdHs9WU5t4kM0blBL41d8wJLqpJBjv7YE30w5QfWKAc371QC
	ll9NHjwsBbma3VNAA7bOstDz1Gz291QIvprhCEEEBU2ndL5GPNxTJM0+A1wRkvEERaHq5F
	9sQJTuPXOHn5LrE5g/wiM+jx0O7R2ZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720969683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYPEFvMyvQnlHJU4/kVrIFPFji0CTb8hIhM4cc7C55I=;
	b=weOEtTC2AQBugRRFZOQMc1U71r1qrqH6ZkLcCjSzzCpKwcQFUPJynGzUMpm9t5C8I/i2Lk
	mqMYgPRCdykKsdDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=St3OEl4V;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=weOEtTC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1720969683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYPEFvMyvQnlHJU4/kVrIFPFji0CTb8hIhM4cc7C55I=;
	b=St3OEl4VAkZQVkqRax03ojQdHs9WU5t4kM0blBL41d8wJLqpJBjv7YE30w5QfWKAc371QC
	ll9NHjwsBbma3VNAA7bOstDz1Gz291QIvprhCEEEBU2ndL5GPNxTJM0+A1wRkvEERaHq5F
	9sQJTuPXOHn5LrE5g/wiM+jx0O7R2ZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1720969683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYPEFvMyvQnlHJU4/kVrIFPFji0CTb8hIhM4cc7C55I=;
	b=weOEtTC2AQBugRRFZOQMc1U71r1qrqH6ZkLcCjSzzCpKwcQFUPJynGzUMpm9t5C8I/i2Lk
	mqMYgPRCdykKsdDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 670D21389C;
	Sun, 14 Jul 2024 15:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hy9oF9Ppk2YQAwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 14 Jul 2024 15:08:03 +0000
Date: Sun, 14 Jul 2024 17:08:36 +0200
Message-ID: <87ikx8c8p7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Cc: tiwai@suse.com,
	perex@perex.cz,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable headset mic on Positivo SU C1400
In-Reply-To: <20240712180642.22564-1-edson.drosdeck@gmail.com>
References: <20240712180642.22564-1-edson.drosdeck@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: BB04621B5E
X-Spam-Flag: NO
X-Spam-Score: 1.99
X-Spam-Level: *
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.99 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Action: no action
X-Spamd-Bar: +

On Fri, 12 Jul 2024 20:06:42 +0200,
Edson Juliano Drosdeck wrote:
> 
> Positivo SU C1400 is equipped with ALC256, and it needs
> ALC269_FIXUP_ASPIRE_HEADSET_MIC quirk to make its headset mic work.
> 
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

Thanks, applied now.


Takashi

