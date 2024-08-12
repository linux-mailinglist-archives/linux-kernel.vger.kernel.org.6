Return-Path: <linux-kernel+bounces-283268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8553394EF59
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108851F223DA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EF317E473;
	Mon, 12 Aug 2024 14:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="taJArure";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yoR3bJ7j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="taJArure";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yoR3bJ7j"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E157C17D375;
	Mon, 12 Aug 2024 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472285; cv=none; b=O1EPP4GfijQqgDZqTvn1v7U6TqAeftB6dRz7zkKHriOyhxkHSGpl1qYF5brAAYeV1V3cFLcZZFLvTmfI37INYITQALdtcHSA1JPLuyIoctSKJivWhkgKYhllD4BeRTdfKeMAbDrczwDH2tZmU+QLFI2XZgpW+I/g3ueodiSSdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472285; c=relaxed/simple;
	bh=0IMl1bfeC+mpvUnmjhOlZzM90nLDudJOkCgz/deavQ0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4PxMQ/6r+Q0GZHFVhEbjXemz2eY6CVigXR1IKmL2xLcNTLznAtYn+lNric0H220/BDAY+LzAQgY+65YnZ3ZnQ+Y8iw66OoB21S4WXIS5nDRZo0HjqsDV7thM4noEyRmuSv5l80oRb7wTB0IXM1r2GnvsY8lOSo5DX+Zg/LsPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=taJArure; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yoR3bJ7j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=taJArure; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yoR3bJ7j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1ACF22547;
	Mon, 12 Aug 2024 14:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723472281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgwrbRvcmyrz9rnkkW28Z20g/Fi7G3YkQ8cEUO+uRTg=;
	b=taJArureUKGscNxgLXv/mmNnlswnRC6YNSD7uLTmGBNBFE1tpuQyQnOtJ7A2r4ewBxZKEo
	jgtape4w3JCuru8zokmZisyyh8sNluzhXHijwp7MG2B+orVGmdiI69CmqEwRlyeA+YT2TM
	jSJGB0ZZURW+dcPo5GYxiOH2Lo5Sf7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723472281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgwrbRvcmyrz9rnkkW28Z20g/Fi7G3YkQ8cEUO+uRTg=;
	b=yoR3bJ7jBNUOJyC+D5ybLZSvsgONrXsLm1cFzj3DZVjoVPmuvj/CrtNyZextvifHxwJkaX
	oTgpWQSTMjEVM4Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=taJArure;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yoR3bJ7j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723472281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgwrbRvcmyrz9rnkkW28Z20g/Fi7G3YkQ8cEUO+uRTg=;
	b=taJArureUKGscNxgLXv/mmNnlswnRC6YNSD7uLTmGBNBFE1tpuQyQnOtJ7A2r4ewBxZKEo
	jgtape4w3JCuru8zokmZisyyh8sNluzhXHijwp7MG2B+orVGmdiI69CmqEwRlyeA+YT2TM
	jSJGB0ZZURW+dcPo5GYxiOH2Lo5Sf7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723472281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgwrbRvcmyrz9rnkkW28Z20g/Fi7G3YkQ8cEUO+uRTg=;
	b=yoR3bJ7jBNUOJyC+D5ybLZSvsgONrXsLm1cFzj3DZVjoVPmuvj/CrtNyZextvifHxwJkaX
	oTgpWQSTMjEVM4Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1714713A23;
	Mon, 12 Aug 2024 14:18:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ix75A5kZumaaDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 12 Aug 2024 14:18:01 +0000
Date: Mon, 12 Aug 2024 16:18:40 +0200
Message-ID: <87wmklddtr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Karol Kosik <k.kosik@outlook.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Steven 'Steve' Kendall" <skend@chromium.org>,
	Alexander Tsoy <alexander@tsoy.me>,
	wangdicheng <wangdicheng@kylinos.cn>,
	Kenny Levinsen <kl@kl.wtf>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Christos Skevis <xristos.thes@gmail.com>,
	"Geoffrey D. Bennett" <g@b4.vu>,
	Sarah Grant <s@srd.tw>,
	Stefan Stistrup <sstistrup@gmail.com>,
	Johan Carlsson <johan.carlsson@teenage.engineering>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: usb-audio: Support multiple control interfaces
In-Reply-To: <AS8P190MB1285893F4735C8B32AD3886BEC852@AS8P190MB1285.EURP190.PROD.OUTLOOK.COM>
References: <87plqfjwdl.wl-tiwai@suse.de>
	<AS8P190MB1285893F4735C8B32AD3886BEC852@AS8P190MB1285.EURP190.PROD.OUTLOOK.COM>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: A1ACF22547
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,chromium.org,tsoy.me,kylinos.cn,kl.wtf,linux.intel.com,gmail.com,b4.vu,srd.tw,teenage.engineering,vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 12 Aug 2024 02:29:56 +0200,
Karol Kosik wrote:
> 
> Registering Numark Party Mix II fails with error 'bogus bTerminalLink 1'.
> The problem stems from the driver not being able to find input/output
> terminals required to configure audio streaming. The information about
> those terminals is stored in AudioControl Interface. Numark device
> contains 2 AudioControl Interfaces and the driver checks only one of them.
> 
> According to the USB standard, a device can have multiple audio functions,
> each represented by Audio Interface Collection. Every audio function is
> considered to be closed box and will contain unique AudioControl Interface
> and zero or more AudioStreaming and MIDIStreaming Interfaces.
> 
> The Numark device adheres to the standard and defines two audio functions:
> - MIDIStreaming function
> - AudioStreaming function
> It starts with MIDI function, followed by the audio function. The driver
> saves the first AudioControl Interface in `snd_usb_audio` structure
> associated with the entire device. It then attempts to use this interface
> to query for terminals and clocks. However, this fails because the correct
> information is stored in the second AudioControl Interface, defined in the
> second Audio Interface Collection.
> 
> This patch introduces a structure holding association between each
> MIDI/Audio Interface and its corresponding AudioControl Interface,
> instead of relying on AudioControl Interface defined for the entire
> device. This structure is populated during usb probing phase and leveraged
> later when querying for terminals and when sending USB requests.
> 
> Alternative solutions considered include:
> - defining a quirk for Numark where the order of interface is manually
> changed, or terminals are hardcoded in the driver. This solution would
> have fixed only this model, though it seems that device is USB compliant,
> and it also seems that other devices from this company may be affected.
> What's more, it looks like products from other manufacturers have similar
> problems, i.e. Rane One DJ console
> - keeping a list of all AudioControl Interfaces and querying all of them
> to find required information. That would have solved my problem and have
> low probability of breaking other devices, as we would always start with
> the same logic of querying first AudioControl Interface. This solution
> would not have followed the standard though.
> 
> This patch preserves the `snd_usb_audio.ctrl_intf` variable, which holds
> the first AudioControl Interface, and uses it as a fallback when some
> interfaces are not parsed correctly and lack an associated AudioControl
> Interface, i.e., when configured via quirks.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217865
> 
> Signed-off-by: Karol Kosik <k.kosik@outlook.com>

Applied now to for-next branch.  Thanks!


Takashi

