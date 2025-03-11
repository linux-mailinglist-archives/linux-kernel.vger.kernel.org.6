Return-Path: <linux-kernel+bounces-555901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE53FA5BE12
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BFC3B21A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD8223F377;
	Tue, 11 Mar 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ujTQ3EAb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O3/J1HCl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XMWEg1dV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ibb0p54z"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0046D23F366
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741689597; cv=none; b=NZTk2OchYiOPVF9lvplvGgelF8cgDKkI/TLDXD2MpJvY2Ae5IvQc1iYdwxTQM/2ER46qArauffdMfStPMGK4q8oSMJh1kM7fdSihkTTPb6aOlpD1LJchAKjvB2HDZ8To6wjBdN26hCDbS6Ts4ulFq7p11QP3aDZK85pS71zbJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741689597; c=relaxed/simple;
	bh=1A9DqrzvgSP86RmLS/8pQLub1nZ9094OoP56S8a3cAo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXAhGoPyBG2IxyP1XZXQPoVthAGOAqGWhvfLMhcKdot7SoHzeDtoVr3XS/PToBYyNIF9+6s7/oXv6fCWhDBDY1oC/umc6Vs1iphdPauA12C1ruVLCBYVv2Xczj01YDKzq2ZPy2MWUyHSMVFNKkv+vSc2V+8qyseLcIdW8DCQXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ujTQ3EAb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O3/J1HCl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XMWEg1dV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ibb0p54z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0C7D1F38F;
	Tue, 11 Mar 2025 10:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741689593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cEeSDF9TWGQ/1xesuqvaCoH529P6am/sq2wj9HJQAh0=;
	b=ujTQ3EAb+BXCFd/pHq4Qg/4ICUHWbYLSguQvTAkEQr4esyNtMLEdGxm58dPtQk9SC9FlGy
	dqBwl/aDTAGnJNbrf75xdqwQq5MLWyjoEEZQeFYtsGvZk4Sg0tro3PFs5qFICxALVr7WnV
	qEiwGQ2ma2v15AXSFR8gjozovSBJjOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741689593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cEeSDF9TWGQ/1xesuqvaCoH529P6am/sq2wj9HJQAh0=;
	b=O3/J1HClwYJ0FB/vhWcUYlaxAZU7EQOKY1LFDT+h+X5DdBwgf6nfDQ4onjlGUCIiwoMaSy
	ZL9jEn3f/ZgQ0YCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XMWEg1dV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ibb0p54z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741689592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cEeSDF9TWGQ/1xesuqvaCoH529P6am/sq2wj9HJQAh0=;
	b=XMWEg1dVtvKKQxwDIX3ENQ33pXDx8XwKEAWf/T+b9N44878c/yRgWSAP7JOErSo0kM9BLX
	0PCQYb3Ljpdph3u0Y4Pfpjf0xXfmmo3sTzqNupqRY6WltA3vxcbVfkXJkJNBL5WEXZIwf4
	6FmnzNENkkv5aFFV6/mHbF0L4jguohg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741689592;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cEeSDF9TWGQ/1xesuqvaCoH529P6am/sq2wj9HJQAh0=;
	b=ibb0p54zvpl/dM2TPpHsdaoUTDk5ET+sTlS3GpModKg+i3UvwmBdXbNaqyWDN3yuPJua4D
	5W7NVjtBwzyocvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96AB9132CB;
	Tue, 11 Mar 2025 10:39:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hdQ6JPgS0GdaCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 11 Mar 2025 10:39:52 +0000
Date: Tue, 11 Mar 2025 11:39:52 +0100
Message-ID: <87tt7zyhon.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: chester.a.unal@arinc9.com,
	"Chester A. Unal via B4 Relay" <devnull+chester.a.unal.arinc9.com@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	alexander.scholten@xpedite-tech.com,
	dwayne.dupreez@xpedite-tech.com,
	zenon@xpedite-tech.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Limit Internal Microphone boost for ALC3246
In-Reply-To: <20250309-for-sound-alc256-dell-v1-1-aacd84853907@arinc9.com>
References: <20250309-for-sound-alc256-dell-v1-1-aacd84853907@arinc9.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: C0C7D1F38F
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[chester.a.unal.arinc9.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01
X-Spam-Flag: NO

On Sun, 09 Mar 2025 13:39:36 +0100,
Chester A. Unal via B4 Relay wrote:
> 
> From: "Chester A. Unal" <chester.a.unal@arinc9.com>
> 
> Internal Microphone is too loud on Dell Latitude 5490, Dell Device
> [1028:0816], which has got ALC3246. I suppose this is the case for all
> devices with ALC3246 which is ALC256 for Dell devices. Therefore, limit the
> Internal Microphone boost for ALC3246. Change
> ALC255_FIXUP_DELL1_MIC_NO_PRESENCE to
> ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST which includes the former fixup.
> 
> Signed-off-by: Chester A. Unal <chester.a.unal@arinc9.com>

Thanks for the patch.

The code replaces the quirk entry for a pin-quirk table, and it
implies that this change will influence on all models that have this
pin table pattern, which is a bit risky to change.
IMO, a safer option would be to add an explicit PCI SSID quirk entry
for your device pointing to ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST.

> ---
> I don't know ALSA or the Intel HDA specification very well so feel free to
> correct any incorrect information in the patch log.
> 
> I experience another issue with this laptop that is also there on ALC3204.
> Headphones output loops back to Headset Microphone. So if I record with
> this microphone, sysystem audio is recorded as well. I have tried a fair
> share of fixups by compiling snd-hda-codec-realtek.ko with different fixups
> applied for "0x10ec0256, 0x1028", replacing the existing module in
> /lib/modules, and then rebooting.

The "headphone" mic means to use the pin used for the headphone output
as the mic input.  If turned on, the pin usage is switched from the
output to the input, hence no playback from there any longer.
And, a headphone can be indeed used physically as a mic (although the
tone is very soft) -- so it's the expected behavior.

OTOH, "headset" mic is different; it has both the headset output pin
and the headset mic pin that work individually.

> ALC2XX_FIXUP_HEADSET_MIC makes Headset Microphone appear unplugged. But I
> can see on the OS that it detects voice, so, it works. When it appears
> unplugged, Headphones output won't loop back to it. This fixup also makes
> Speakers appear unavailable and makes Microphone disappear, as
> ALC255_FIXUP_DELL1_MIC_NO_PRESENCE won't apply anymore.

If the headset isn't detected by plugging to the headset jack, that's
a bug to be fixed.  Please elaborate the behavior.


thanks,

Takashi

