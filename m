Return-Path: <linux-kernel+bounces-538196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BEEA495A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84171636A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F1A254867;
	Fri, 28 Feb 2025 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uVoDNQ0V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vDXUDRon";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uVoDNQ0V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vDXUDRon"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2D81DE4FA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735958; cv=none; b=BJy93NjHi6GKjT2zk04HDVFUwmHDhm8gzJzTxHPVXEhhTFKJaMq4aj9LFg1ZWnI0Shj3gWM/Gpd+r/oJH3P+8+QDK4PsK+0nI7KQfYomsKBEV35SPY1VdBllEs+gcgqGJh9sa/R6OpM3uN4YbBpgHKeGsWB+tL17QXwxDc+SReo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735958; c=relaxed/simple;
	bh=hiqhnVazLVly2La7BHwSGoBYhBhY6Ydgn9RFJNlag74=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iu04yxnNMSGG+FIu4ahImupqFWuVMWqa0M9Y1NkHuJYpVzdY5VE0gqDPJwyRFlTOTynjTAGl6ZG/NgetKtkEjmM1QcV+s+eSDnPDDF6Jo59jKPgXOeqXyzXqidlrEXDhSnQqEYKbblZnQygUgzjHAS56DHTKqo18R3VXYaBDFos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uVoDNQ0V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vDXUDRon; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uVoDNQ0V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vDXUDRon; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97F831F38F;
	Fri, 28 Feb 2025 09:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740735948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LS/7qy6HiKHKtDsXcA71rpwuUX3wJVLYwNeJyHnEIhE=;
	b=uVoDNQ0VPm3xpOXqmWsHSriQIzfE+b8kaxmXNq+FfOBxpqQ2Raslfn0giuHQTHhLrEpwpA
	1A9Q2EZH3rs67w/HaS4xt+z698tP2/Keh4GbHFrZSbjoEOqpSkHIybGmuHbuFyK9TdyiQF
	i4SUcOtwNKQKB7OpmoGIY4dIPxj5gjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740735948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LS/7qy6HiKHKtDsXcA71rpwuUX3wJVLYwNeJyHnEIhE=;
	b=vDXUDRonM9CIxZJk/P6k+smz/Yg0JvnZZXTwDAfmhq1M0e/Q+IXsmHTfNh9Emjq0HpGCMb
	Lz+LyAvID1hSNcCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uVoDNQ0V;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vDXUDRon
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740735948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LS/7qy6HiKHKtDsXcA71rpwuUX3wJVLYwNeJyHnEIhE=;
	b=uVoDNQ0VPm3xpOXqmWsHSriQIzfE+b8kaxmXNq+FfOBxpqQ2Raslfn0giuHQTHhLrEpwpA
	1A9Q2EZH3rs67w/HaS4xt+z698tP2/Keh4GbHFrZSbjoEOqpSkHIybGmuHbuFyK9TdyiQF
	i4SUcOtwNKQKB7OpmoGIY4dIPxj5gjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740735948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LS/7qy6HiKHKtDsXcA71rpwuUX3wJVLYwNeJyHnEIhE=;
	b=vDXUDRonM9CIxZJk/P6k+smz/Yg0JvnZZXTwDAfmhq1M0e/Q+IXsmHTfNh9Emjq0HpGCMb
	Lz+LyAvID1hSNcCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 508111344A;
	Fri, 28 Feb 2025 09:45:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EVqGEcyFwWfPUwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 28 Feb 2025 09:45:48 +0000
Date: Fri, 28 Feb 2025 10:45:47 +0100
Message-ID: <878qpqcshg.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-sound@vger.kernel.org,
	kailang@realtek.com,
	linux-kernel@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	baojun.xu@ti.com,
	simont@opensource.cirrus.com
Subject: Re: [PATCH v2 0/2] ALSA: hda/realtek: Sort Ally X properly, fix Asus Z13 2025 audio
In-Reply-To: <20250227175107.33432-1-lkml@antheas.dev>
References: <20250227175107.33432-1-lkml@antheas.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 97F831F38F
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 27 Feb 2025 18:51:05 +0100,
Antheas Kapenekakis wrote:
> 
> The Ally X has two quirks in the kernel currently. This is due to the
> previous quirk not being sorted properly, whoopsies. Therefore, only one
> has to stay. During AB testing, the configs were found to be close to
> identical. Around 20 reboots later, it seems they feature a small pop
> when at full volume on boot at an identical probability.
> 
> Then, add the Asus Z13 2025 quirk to the list. In the V1 of this series,
> the Ally config was used, which (see above) is a bit ambitious. Testing
> found that the stock quirk works just as well, so use that instead.
> 
> @Stefan: the Z13 is a big launch for Asus, could we do something to
> expedite things just for this laptop? As far as Bazzite is concerned,
> we shipped the stock quirk as of today, and included the firmware. This
> is moreso for mainline distributions.
> 
> The Z13 was tested with the following firmware files:
> 
> sha256sum *
> 79cc046b2a1a89fd250dadfb47bdcb8a3c3d7df80452079f64e5417b237f4889  cs35l41-dsp1-spk-cali-10431fb3-l0.bin
> 3027249f8a340a8fb0034d67e5af8787789c83e9b3623664dab744668272b54e  cs35l41-dsp1-spk-cali-10431fb3-r0.bin
> a8f3d1735c03383cd8567713e510034b0f98df0264fa7135e6e8186e0ea346de  cs35l41-dsp1-spk-prot-10431fb3-l0.bin
> f0cdcf6d72bc591dec8a7bacba3ad8b46742207807c1e3c7787171de66e6f815  cs35l41-dsp1-spk-prot-10431fb3-r0.bin
> e4e73d47203e0badc913b4a1317d48cb0e1b54d7d737f339148068f0cde34b16  cs35l41-dsp1-spk-prot-10431fb3.wmfw
> 
> Changelog since V1:
>     - Revert Ally X config to use the stock quirk instead
>     - Use a stock quirk for the Z13 too
> 
> Antheas Kapenekakis (2):
>   ALSA: hda/realtek: Remove (revert) duplicate Ally X config
>   ALSA: hda/realtek: Fix Asus Z13 2025 audio

Applied both patches now to for-linus branch.
I added Fixes tag to the former.


thanks,

Takashi

