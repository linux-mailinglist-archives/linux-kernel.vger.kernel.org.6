Return-Path: <linux-kernel+bounces-541729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 504CFA4C0E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474B318972B7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7A72116E5;
	Mon,  3 Mar 2025 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dQV+9IKO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uGlr0zbc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dQV+9IKO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uGlr0zbc"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B61EB18D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005917; cv=none; b=jyB/bIPLf0Z/9pZNHnua8ZrxRGyow9lQ5HJhT2ARjERgEA4WN0b/9BW+o3/qVQG4Rj8yqyepTHLG8Hmq5cSgNjfrMQktGXRCclsePSeo4Nnm+LcDNZAwPdL2sX0W3EM6Rno3F4q38o+crVgwdeBfezfI0FJzAMx0MJzBf9YTiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005917; c=relaxed/simple;
	bh=ctXb+Vk4ikF5d2NAAL8/4EeUfcrsXV7pPJi6G8PMurI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdJc436C590LuulKPVcMhfteX8B+ujU/9QRKEFJk9RaFUGExqPRkkbyKR8xLS72T8VlEiMgwwY1EwStVFx2YNClGtandpm403VMaWxAxR2Uvb8RJriI7hRRByu9PRFprTSMdjC5lgodw+3YIcSzvbBSJy3uTYn0mQWPFv9L3Bqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dQV+9IKO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uGlr0zbc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dQV+9IKO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uGlr0zbc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46C232116B;
	Mon,  3 Mar 2025 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741005914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekAiXbksR6ZxnzQ2JDubU6L33W8b0iyoZPr2f5UoEas=;
	b=dQV+9IKONC+Zp3RrnURVMKcmZm8YLmoEpBHwLS25gjsxU3wlnugSIwcR/jW+n8rNgnwHxO
	yPVKTH6lVYrt4VrSXKWOvsvezGx6RFTioqU/U0KSMNL2P4pCCJV6nm1aN6k+pJnxgkMcS/
	7skmdjfOizTXXiCCRiMyCeI+gInLvmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741005914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekAiXbksR6ZxnzQ2JDubU6L33W8b0iyoZPr2f5UoEas=;
	b=uGlr0zbcdOvJ7MEeSSteK8faUMUrSU8Peqk7EZg3guUJbmWHTgo4+nvBEatk87gfNKv7Ut
	5KUy6IcDcr5XloCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dQV+9IKO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uGlr0zbc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741005914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekAiXbksR6ZxnzQ2JDubU6L33W8b0iyoZPr2f5UoEas=;
	b=dQV+9IKONC+Zp3RrnURVMKcmZm8YLmoEpBHwLS25gjsxU3wlnugSIwcR/jW+n8rNgnwHxO
	yPVKTH6lVYrt4VrSXKWOvsvezGx6RFTioqU/U0KSMNL2P4pCCJV6nm1aN6k+pJnxgkMcS/
	7skmdjfOizTXXiCCRiMyCeI+gInLvmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741005914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekAiXbksR6ZxnzQ2JDubU6L33W8b0iyoZPr2f5UoEas=;
	b=uGlr0zbcdOvJ7MEeSSteK8faUMUrSU8Peqk7EZg3guUJbmWHTgo4+nvBEatk87gfNKv7Ut
	5KUy6IcDcr5XloCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1290713939;
	Mon,  3 Mar 2025 12:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cR3dAlqkxWfzSQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 03 Mar 2025 12:45:14 +0000
Date: Mon, 03 Mar 2025 13:45:13 +0100
Message-ID: <87ldtme10m.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Kailang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable PC beep passthrough for HP EliteBook 855 G7
In-Reply-To: <2fea9fe8-312f-45a0-9bed-455c910fba43@maciej.szmigiero.name>
References: <7461f695b4daed80f2fc4b1463ead47f04f9ad05.1739741254.git.mail@maciej.szmigiero.name>
	<87jz9o99ef.wl-tiwai@suse.de>
	<a02344f2-3b99-41ea-af64-8d2bcb01e435@maciej.szmigiero.name>
	<87h64s972a.wl-tiwai@suse.de>
	<6224620265674b09b5762f908b5158f9@realtek.com>
	<2fea9fe8-312f-45a0-9bed-455c910fba43@maciej.szmigiero.name>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 46C232116B
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 19 Feb 2025 12:16:35 +0100,
Maciej S. Szmigiero wrote:
> 
> Hi Kailang,
> 
> On 19.02.2025 09:32, Kailang wrote:
> > 
> > Hi Maciej S,
> >     Could you test plug headphone then speaker will mute or not?
> >     Below was why I close the beep mode.
> >   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=fcf c9f711d1e2fc7876ac12b1b16c509404b9625
> 
> 
> When I plug headphones then both normal sound playback (ALSA) and PC beep move to headphones.
> The main laptop speaker gets muted indeed.
> 
> I'm testing on kernel 6.12 so the Dell patch above is included.
> 
> >   Hi Takashi,
> >     COEF 0x36 bit 13 was the enable bit for pcbeep passthrough for
> > 0x14.
> >   If this patch no PM issues and speaker can mute by plug headphone or headset,
> >   I think this work for me.
> > 
> 
> Nice, thanks for clarifying.

So, Kailang, is Maciej's patch OK to take from Realtek POV?

If so, feel free to give an Acked-by tag or such for the upstream
inclusion.


thanks,

Takashi

