Return-Path: <linux-kernel+bounces-435039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06A59E6EAC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8172B28518E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 12:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826CC204F74;
	Fri,  6 Dec 2024 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TqMy4JDW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Elc47Ir9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TqMy4JDW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Elc47Ir9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E15464A;
	Fri,  6 Dec 2024 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733489827; cv=none; b=eqxC2/xo0PNilDqf5UuSHKH9ecwVWD8cUdx/eEOQNdxna0h7V1Sw/HxXbyYbYN5CbXWO9ahmbf/3gveYjEtIEOr39k8B3PGgj3qGSN/qUX3c6wHeBKAQH6X42CLq6c5YPhr+TpbSzN6EYPiUy6XjFhXpXPhFN6kHdgaQoEIrkfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733489827; c=relaxed/simple;
	bh=2waGZycGwVjOAgQc5FMBPdcFMUiDwkfcTBe5tct7lxg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbXDY2U/nXTTg/nbh+kKyxl2coxLtYa8XhXSrwga5miA2kXlNT+uqGV91GVxkdUrzzpIGGaIsPkZZ3SSL6O0JH/EtDXAQvBE/dd4uowkWrGx4roOImrMfbPoPgkbrMsB3Snl7uo8FWdqI1tsaL048C7i9BoVvVyMyolPd/YJVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TqMy4JDW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Elc47Ir9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TqMy4JDW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Elc47Ir9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F52F21182;
	Fri,  6 Dec 2024 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733489823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqzgJnL80kY5lG9uArHML4vFv73L5cX+WecJwnnqC0k=;
	b=TqMy4JDWlVZCUZOUzjwsfklHzI0ItoupLBUkw6jiUzMEhTbujI1/Ri4EhTmSGZYXS76zH0
	vQOwAL+RjuXZjGNgF5esruqS2FOf3xnjTr6lgMhusNnVH+xjMO5++RaceAHYhtxUAqnJyh
	tTijWpi0xQ2UNtdLXgCU7Xh56J9fpWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733489823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqzgJnL80kY5lG9uArHML4vFv73L5cX+WecJwnnqC0k=;
	b=Elc47Ir9RZYyIGIN+LMerQ6WRPxUdYkLEjpWLlx2NlaerzuQwupEW7N5iQR5srSmqE4/ZE
	EE9FfURv8l3BHQBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TqMy4JDW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Elc47Ir9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733489823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqzgJnL80kY5lG9uArHML4vFv73L5cX+WecJwnnqC0k=;
	b=TqMy4JDWlVZCUZOUzjwsfklHzI0ItoupLBUkw6jiUzMEhTbujI1/Ri4EhTmSGZYXS76zH0
	vQOwAL+RjuXZjGNgF5esruqS2FOf3xnjTr6lgMhusNnVH+xjMO5++RaceAHYhtxUAqnJyh
	tTijWpi0xQ2UNtdLXgCU7Xh56J9fpWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733489823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqzgJnL80kY5lG9uArHML4vFv73L5cX+WecJwnnqC0k=;
	b=Elc47Ir9RZYyIGIN+LMerQ6WRPxUdYkLEjpWLlx2NlaerzuQwupEW7N5iQR5srSmqE4/ZE
	EE9FfURv8l3BHQBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A99D13647;
	Fri,  6 Dec 2024 12:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1H7UDJ/0UmfsTAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 06 Dec 2024 12:57:03 +0000
Date: Fri, 06 Dec 2024 13:57:02 +0100
Message-ID: <87jzcdrmu9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hridesh MG <hridesh699@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Fix headset mic on Acer Nitro 5
In-Reply-To: <20241205171843.7787-1-hridesh699@gmail.com>
References: <20241205171843.7787-1-hridesh699@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 7F52F21182
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 05 Dec 2024 18:18:42 +0100,
Hridesh MG wrote:
> 
> Add a PCI quirk to enable microphone input on the headphone jack on
> the Acer Nitro 5 AN515-58 laptop.
> 
> Signed-off-by: Hridesh MG <hridesh699@gmail.com>

Thanks, applied now.


Takashi

