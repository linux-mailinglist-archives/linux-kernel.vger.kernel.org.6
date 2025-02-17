Return-Path: <linux-kernel+bounces-517428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1341AA380C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062EC3B4F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AFD21660D;
	Mon, 17 Feb 2025 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tSUQytZg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="i+JJnmf1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rqdRjxYl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4lHxSGIK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB272165E2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789572; cv=none; b=V+fZxVwtV++gtaMSjw1GsL5EBdjfqxmD9GTQBqhDhcdE8LLRapVbAInraRMp0ExX3UHIQM194fKzc8oQGVJQmxQlap5bCEPnRwdTgasIpJhzuBNZe0ZyYtLgAkq7aZRYH7OmhgNN9lhhY+87zBkhm3uuRD9/hjTSq4pjT5oRtWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789572; c=relaxed/simple;
	bh=XsPofMlwaGD3zcR39VFyUslgAULhSgkeXoKsp62uwO0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPCCBIgWbRmev6WGzpHR3ZxiWDZduv7JH+MSV/ChXfzYZcD6pt8wgrCVhSxtEVDHrBJmWccwhSuCgNEd3lJ+TQAY1OQa2jP31gv2X2cUvRv+ADpiFGL0ZW7vNDlVLTq4Mrd7pQ7h0emUN+IFVXmbIa0mjx7a6a7ovrh2yR+ZsCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tSUQytZg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=i+JJnmf1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rqdRjxYl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4lHxSGIK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E21F61F74B;
	Mon, 17 Feb 2025 10:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739789567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5eHS7xZ358IVZ2DZTp3DR6SGgQGl4CshkWErAir12E=;
	b=tSUQytZgwDLWwvLgCQeWCPXTCn/oOabGy+jtQGzEWnkfVfGc/BY1O+aIgRiooS86Wqz6wr
	fM+hUoJNZvOswA8HhKj215DhpH0Vb5CFoeJ4xkmw/H9Y3gIs2xZeh7OMSfjXZiQcgdDg5J
	xDpZqEVdUsFSe4SF9vJdohHvlcfiKYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739789567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5eHS7xZ358IVZ2DZTp3DR6SGgQGl4CshkWErAir12E=;
	b=i+JJnmf1bMJNV1+mgw78zAeo4xGP8ZuQO2jWr9nPW13DVBq4c39YBhi+DdsTeCsZqOosrk
	ZF5a4qojTOze6xCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rqdRjxYl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4lHxSGIK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739789566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5eHS7xZ358IVZ2DZTp3DR6SGgQGl4CshkWErAir12E=;
	b=rqdRjxYl0kgb7uILke1B+MxyOwZ/ATlMFhYuaUAz0SMpxJYt6SZBB9xvb2Ixx6Gd833Vt0
	uivMEZg1mFz6M2SzeAD9Hcv12U22OP8ZR9DtCdQuGoR68M3D8qDKWBp6Xf8SB2gfEMiHOR
	SETnAT4h8/P33Y3yJJkNLjpsCzF3jE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739789566;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C5eHS7xZ358IVZ2DZTp3DR6SGgQGl4CshkWErAir12E=;
	b=4lHxSGIKFh47xVx5d9UIvN8Xfgx/9vcy7Tr+tN3iGXkrG8GGD+IEZvQMavHGfnPTG1ixEJ
	+wmuHEJ6fsIn2XCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E3051379D;
	Mon, 17 Feb 2025 10:52:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4oEEDP4Us2fpWAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 17 Feb 2025 10:52:46 +0000
Date: Mon, 17 Feb 2025 11:52:45 +0100
Message-ID: <87h64s972a.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Shuming Fan <shumingf@realtek.com>,
	Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable PC beep passthrough for HP EliteBook 855 G7
In-Reply-To: <a02344f2-3b99-41ea-af64-8d2bcb01e435@maciej.szmigiero.name>
References: <7461f695b4daed80f2fc4b1463ead47f04f9ad05.1739741254.git.mail@maciej.szmigiero.name>
	<87jz9o99ef.wl-tiwai@suse.de>
	<a02344f2-3b99-41ea-af64-8d2bcb01e435@maciej.szmigiero.name>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: E21F61F74B
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 17 Feb 2025 11:17:31 +0100,
Maciej S. Szmigiero wrote:
> 
> On 17.02.2025 11:02, Takashi Iwai wrote:
> > On Sun, 16 Feb 2025 22:31:03 +0100,
> > Maciej S. Szmigiero wrote:
> >> 
> >> PC speaker works well on this platform in BIOS and in Linux until sound
> >> card drivers are loaded. Then it stops working.
> >> 
> >> There seems to be a beep generator node at 0x1a in this CODEC
> >> (ALC269_TYPE_ALC215) but it seems to be only connected to capture mixers
> >> at nodes 0x22 and 0x23.
> >> If I unmute the mixer input for 0x1a at node 0x23 and start recording
> >> from its "ALC285 Analog" capture device I can clearly hear beeps in that
> >> recording.
> >> 
> >> So the beep generator is indeed working properly, however I wasn't able to
> >> figure out any way to connect it to speakers.
> >> 
> >> However, the bits in the "Passthrough Control" register (0x36) seems to
> >> work at least partially: by zeroing "B" and "h" and setting "S" I can at
> >> least make the PIT PC speaker output appear either in this laptop speakers
> >> or headphones (depending on whether they are connected or not).
> >> 
> >> 
> >> There are some caveats, however:
> >> * If the CODEC gets runtime-suspended the beeps stop so it needs HDA beep
> >> device for keeping it awake during beeping.
> >> 
> >> * If the beep generator node is generating any beep the PC beep passthrough
> >> seems to be temporarily inhibited, so the HDA beep device has to be
> >> prevented from using the actual beep generator node - but the beep device
> >> is still necessary due to the previous point.
> >> 
> >> * In contrast with other platforms here beep amplification has to be
> >> disabled otherwise the beeps output are WAY louder than they were on pure
> >> BIOS setup.
> >> 
> >> 
> >> Unless someone (from Realtek probably) knows how to make the beep generator
> >> node output appear in speakers / headphones using PC beep passthrough seems
> >> to be the only way to make PC speaker beeping actually work on this
> >> platform.
> >> 
> >> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> >> ---
> >> 
> >> Since more than 6 weeks has now passed since the previous version of this
> >> patch was posted, yet no better or other solution was provided I'm
> >> re-submitting an updated version of the original patch.
> >>      This solution has been working fine for me on this platform
> >> all that time,
> >> without any obvious issues.
> >>      Changes from v1:
> >> * Correct the typo in !IS_ENABLED(CONFIG_INPUT_PCSPKR) code that the
> >> kernel test robot found.
> >>      * Change codec_warn() into dev_warn_once(hda_codec_dev(codec))
> >> to avoid spamming the kernel log at runtime PM CODEC re-init.
> > 
> > This is really a thing to be checked by Realtek people at first, as
> > it's very vendor-specific thing.
> > 
> > Kailang, please check this.
> 
> Realtek people has been asked to comment/provide alternative solution
> 3 times in last 6 weeks:
> On the original v1 submission, by your message from Jan 12, by my
> message on Feb 2.
> 
> Looking at https://lore.kernel.org/linux-sound/?q=f%3Arealtek
> it seems Kailang sent two e-mails about unrelated cases to linux-sound
> during that time.
> 
> To be honest, I don't understand why Realtek people don't comment
> on this since I would think that's a rather simple matter without any
> truly confidential aspects but on the other hand this fact should *not*
> permanently block fixing PC beep on this platform.
> 
> So I think there should be some deadline here for the vendor response -
> like 1 month more or so?

Sorry, I don't like that kind of attitude.

If the patch were perfectly fine, I'd have already taken.  But there
is a thing that can't be validated without the confirmation from the
vendor, and that's not what we can accept because it's supposed to
work on your machine -- that's only one special use case, and it
doesn't qualify to prove the safety.

In general, Kailang (and Realtek) has been helpful over decades for
HD-audio stuff development, but they might be busy sometimes.  Let's
keep asking until catching their attention, at first.

> > And, except for that, I'm still concerned by the behavior change.
> 
> AFAIK most sound card drivers in ALSA were developed without any docs,
> and the register that's being changed is unofficially documented in ALSA:
> https://docs.kernel.org/sound/hd-audio/realtek-pc-beep.html
> 
> Also, the behavior change is clearly limited to this single laptop
> platform (HP EliteBook 855 G7) so the "blast radius" is very limited.

If you were the only user of this laptop in the world, I wouldn't be
concerned, sure :)  But certainly that's not the case.

> > Also the caveat you mentioned about the runtime PM raises some doubt,
> > too.
> 
> I think it's simply because the CODEC get re-initialized when it comes
> out of runtime PM sleep so if we print a message there then it would
> be printed each time the CODEC resumed from runtime PM sleep.
> 
> That's why I changed to print this hint about CONFIG_INPUT_PCSPKR
> just once per CODEC device.

Well, but this runtime PM has to be turned off manually, otherwise the
beep gets broken, right?  This is already some trade-off, so it's not
super trivial to apply the suggested change blindly.

I thought that the input beep infrastructure may work with multiple
input beep devices, and it usually triggers the all beep devices?
If so, you can still keep the HD-audio beep (even though it doesn't do
actually output) so that it can manage the runtime PM of HD-audio
device at beeping, too.


thanks,

Takashi

