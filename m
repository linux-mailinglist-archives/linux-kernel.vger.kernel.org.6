Return-Path: <linux-kernel+bounces-399951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8818D9C06E6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E95F1F211B5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AA3212D14;
	Thu,  7 Nov 2024 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JlpjGINu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7p+O5oeG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="li+YKeYe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qjhD7veW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6920FA81;
	Thu,  7 Nov 2024 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984647; cv=none; b=ndnCmeQHnpzyKBY0l2ek6ftMBlReLomY2+VSKhNJ59WBapwGQ7Vi4/q3HImtLCaZ8wwtp6TzHfszwlqaueGYoHPkvBpSft1+EHxuZ0YvtanOR3Sm1dw9BLBLTHYnIPv8o2JibbFC4eNiz18yP+gFXN9oI6wc1QqjusX8hmX1TDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984647; c=relaxed/simple;
	bh=vDqgovRvMgphw5tf+kmVrAuS2l4DsjIinILy2iRNZpA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=stnkqE04TPb06dZAxZZAETur29vmPQjHx08fLicbU2P+PAFQGw3y4ZjdUEvF846R7ooycsXD3hRe7yz2czlOWViHS7uFxFPUqFsiibm5v8wsbjParYTLxdIGlGtz9xERjmwPLGPYGmWllMW0tCEOuUblZ7hu1FcSOXlCiG7FQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JlpjGINu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7p+O5oeG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=li+YKeYe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qjhD7veW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0F00226C6;
	Thu,  7 Nov 2024 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730984644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CL8MWn98BwavmsKhCZf3gomXJlZ9cc1qGYfWgaXtDdw=;
	b=JlpjGINu3X562POuGKB3BQTVrXw7h53487j3FpZHIuDu2DN/vWz4YrOUOBxA8CcV6uwRxG
	eh7TnICSe86Zwbizv1Qno/lbuGVP56UI43trqStFl5ZcQNib42wIwghFNLfqMcWecEFnPJ
	USR2kl4y6IznaedzkbZVtSlYxz2w9Is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730984644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CL8MWn98BwavmsKhCZf3gomXJlZ9cc1qGYfWgaXtDdw=;
	b=7p+O5oeGTu/XdsCRTZw/sHGrXn3jLTiOacgP3QpL4l/WNLvwB+TsaviuG7hn5dB8+FACYq
	1Adf4RQ8SFTJHUCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=li+YKeYe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qjhD7veW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730984643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CL8MWn98BwavmsKhCZf3gomXJlZ9cc1qGYfWgaXtDdw=;
	b=li+YKeYetWDWiXd9p0+VTnbKYMo13vNxaGzIgcfRiwMchnmT5ng2bx/CN0kdRVoXYdtWtj
	b+ydn1EgX7FtBx98uFinUGwTxEn8XeDCfdHC86tRq8IjGHUSbxdtTDExm4T9ruKO5u1AGk
	ZjuTA7TC1CVxLmqV5I/z371k7TM9NXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730984643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CL8MWn98BwavmsKhCZf3gomXJlZ9cc1qGYfWgaXtDdw=;
	b=qjhD7veWdC4TLRFytrCrhe1RbFVm8iJvzpUhRyU6aCcun8+9rtH65Fhx/Wy/erpgy436uS
	qBxgY9/nosNCZYCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B19EB1394A;
	Thu,  7 Nov 2024 13:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i/02KsO6LGd+PwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 07 Nov 2024 13:04:03 +0000
Date: Thu, 07 Nov 2024 14:04:03 +0100
Message-ID: <875xozi4ak.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,	Paul Cercueil <paul@crapouillou.net>,
	Simona Vetter <simona.vetter@ffwll.ch>,	Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	linux-usb@vger.kernel.org,	Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,	"linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: usb: gadget: Add support for USB MIDI 2.0 function driver
In-Reply-To: <5f54ffd0-b5fe-4203-a626-c166becad362@gmail.com>
References: <5f54ffd0-b5fe-4203-a626-c166becad362@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: F0F00226C6
X-Spam-Level: 
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01
X-Spam-Flag: NO

On Thu, 07 Nov 2024 13:30:12 +0100,
Colin King (gmail) wrote:
> 
> Hi,
> 
> Static analysis has found a minor issue in the following commit:
> 
> commit 8b645922b22303cec4628dbbbf6c8553d1cdec87
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Tue Jul 25 08:22:00 2023 +0200
> 
>     usb: gadget: Add support for USB MIDI 2.0 function driver
> 
> The issue is in function f_midi2_set_alt in
> drivers/usb/gadget/function/f_midi2.c as follows:
> 
>         if (intf != midi2->midi_if || alt > 1)
>                 return 0;
> 
>         if (alt == 0)
>                 op_mode = MIDI_OP_MODE_MIDI1;
>         else if (alt == 1)
>                 op_mode = MIDI_OP_MODE_MIDI2;
>         else
>                 op_mode = MIDI_OP_MODE_UNSET;
> 
> 
> the first if statement will return if alt is 2 or more, so at the
> following cascaded if/else if/else statement alt is either 0 or 1,
> hence the final else that sets op_mode = MIDI_OP_MODE_UNSET can never
> be reached.
> 
> Either the last else statement is redundant and can be removed, or the
> first if statement needs to check for alt > 2 rather than > 1. I'm not
> sure which one is the valid fix to make. Any ideas?

We can fix in either way, as it won't happen practically :)
I guess I thought of alt < 0, but it's an unsigned int, so this is
nonsense.  I'd rather drop the redundant else statement.


thanks,

Takashi

