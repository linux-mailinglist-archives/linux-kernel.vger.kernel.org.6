Return-Path: <linux-kernel+bounces-343541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9124989C47
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B925B24C79
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A989D17B4E5;
	Mon, 30 Sep 2024 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DmCvRyfY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FskE9PLO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DmCvRyfY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FskE9PLO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835A41684A5;
	Mon, 30 Sep 2024 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683895; cv=none; b=UUepEciTqDPhOktJ5CbYblYJMYJvmDD+QRpPAUUX977tZeuB8hzzQu4herJrCZfacoV1UgcH/a/90O53851pPYRS6ls8Zr69Jo9NV2c2NznRI59gHZ+AS8NIYAydncb6l44H51iiA/lZYpQn8LURcUstfXwOX//qUgM9L0s5GIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683895; c=relaxed/simple;
	bh=TzB84r0iFDPe/VaTNH2xAUFC3wyMnWjYZ4iaTCQF/Xc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLfRq0ojIAr8krJdEnev5O2MyNXPbsNDYFG7JweNzHMUkb285gmgRf43hZzgcLYqAgAS1mqfU61rzTiy6OuRSL33cvmNMfVbpEkTJ55R0SUQbQDK2g50XzjOyy6M7vlqEszABsQpQQ4ghqngySz/kWd6dU9Kncsovy1pcdwoqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DmCvRyfY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FskE9PLO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DmCvRyfY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FskE9PLO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A648F21A45;
	Mon, 30 Sep 2024 08:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727683890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhwzsLxSvo+Wgucyg8+WppQrJsKAkiBfMHeUqalfwZM=;
	b=DmCvRyfYi27RukWiH3z2cn8gBi6DBL+YsQdGDMJZ0+PZz6fGtyC/xi0Ro+Jm5EdB7E0b38
	sfY4HNva5MxhX0RN/ntU/wr9h9DCuNBFwxD585PezEU8IDPv1Bua3QuHdXSfI4le/59ctH
	D8Xq38TrU+dEiuW4QV8U1g+mRZ+Z5Zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727683890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhwzsLxSvo+Wgucyg8+WppQrJsKAkiBfMHeUqalfwZM=;
	b=FskE9PLOrexbRvjcEa/35qJhtDHy0Xh7XNKtc94zOMryfAiWh8NnR70A5FaHCT/vFOP2F2
	lRnCLwJdyPjUn9BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DmCvRyfY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FskE9PLO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727683890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhwzsLxSvo+Wgucyg8+WppQrJsKAkiBfMHeUqalfwZM=;
	b=DmCvRyfYi27RukWiH3z2cn8gBi6DBL+YsQdGDMJZ0+PZz6fGtyC/xi0Ro+Jm5EdB7E0b38
	sfY4HNva5MxhX0RN/ntU/wr9h9DCuNBFwxD585PezEU8IDPv1Bua3QuHdXSfI4le/59ctH
	D8Xq38TrU+dEiuW4QV8U1g+mRZ+Z5Zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727683890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FhwzsLxSvo+Wgucyg8+WppQrJsKAkiBfMHeUqalfwZM=;
	b=FskE9PLOrexbRvjcEa/35qJhtDHy0Xh7XNKtc94zOMryfAiWh8NnR70A5FaHCT/vFOP2F2
	lRnCLwJdyPjUn9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 741A113A8B;
	Mon, 30 Sep 2024 08:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BwgjGzJd+maQFgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Sep 2024 08:11:30 +0000
Date: Mon, 30 Sep 2024 10:12:23 +0200
Message-ID: <877catk1aw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] ALSA: mixer_oss: Remove some incorrect kfree_const() usages
In-Reply-To: <63ac20f64234b7c9ea87a7fa9baf41e8255852f7.1727374631.git.christophe.jaillet@wanadoo.fr>
References: <63ac20f64234b7c9ea87a7fa9baf41e8255852f7.1727374631.git.christophe.jaillet@wanadoo.fr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: A648F21A45
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[wanadoo.fr];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Thu, 26 Sep 2024 20:17:36 +0200,
Christophe JAILLET wrote:
> 
> "assigned" and "assigned->name" are allocated in snd_mixer_oss_proc_write()
> using kmalloc() and kstrdup(), so there is no point in using kfree_const()
> to free these resources.
> 
> Switch to the more standard kfree() to free these resources.
> 
> This could avoid a memory leak.
> 
> Fixes: 454f5ec1d2b7 ("ALSA: mixer: oss: Constify snd_mixer_oss_assign_table definition")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied now.  Thanks.


Takashi

