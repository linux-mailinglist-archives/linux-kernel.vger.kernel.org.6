Return-Path: <linux-kernel+bounces-518129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823C0A38A53
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069951893460
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176FE227BAE;
	Mon, 17 Feb 2025 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LZafiCsE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wWxd7Y1Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LZafiCsE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wWxd7Y1Z"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85FC227B9D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811985; cv=none; b=OKxozIEFN0rt9zwkaliXQpz6GPqXzYs/X/OCZGhJgbxPfmGMJ3V2Ecc5JEFZPjrPK0odygX8VjPg8qFB0M0I4H/eqqFyljSdqhoYeWctMXxatrNk/2TmJfgbZBbWByvMc3XJkKJF1XTpW4eZEqNiXo3bwuJ0sR4/ZSMc90JPinM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811985; c=relaxed/simple;
	bh=xKTOsm+aRmCVcbcAETDeHyhHCbkXZ+Vl8gmezhhwm24=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X54KyVtboDZxdJk/dsjAQ3KYQQkC8ExUB7cKPYJZKdE2tT3C+Q/84JwodsM5K+Q7VTL1OnBmaeSHKM3X5XyP5BXRc+reDpo8UBoL0uYhtS+5A9FFzHMBMzYFhAiSfuqCZhP+T1EQw27C/JM2jSgRBSCubsNlvj5JnSqMCWEbn1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LZafiCsE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wWxd7Y1Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LZafiCsE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wWxd7Y1Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D8CE2118A;
	Mon, 17 Feb 2025 17:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739811982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UfDVsuLhacxyBJCagIZzUENSwreQL/lZSF/d20A7WmM=;
	b=LZafiCsE5HLEO+7oWNb26SZu8Lla3/3PPFm286VmO9V9xaGNsaRUhvjoCQq7ORwkw1CCkb
	sw/0vhxJAtg/MklmyItPyVV5LsknMxANH6LVN/4RFvVj95K6d7aZelBPsbIrZXSMcfxaaE
	vyRgka4ctYe5rvON3mAl6/CH1PQumBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739811982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UfDVsuLhacxyBJCagIZzUENSwreQL/lZSF/d20A7WmM=;
	b=wWxd7Y1ZYjLTOSy2kZpOvBrsycxRG0zeXWMkgB15NtAglEfyMeTsqKM9tttzrgBR2t3rK4
	xdXhTMpCmYFAchCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LZafiCsE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wWxd7Y1Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739811982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UfDVsuLhacxyBJCagIZzUENSwreQL/lZSF/d20A7WmM=;
	b=LZafiCsE5HLEO+7oWNb26SZu8Lla3/3PPFm286VmO9V9xaGNsaRUhvjoCQq7ORwkw1CCkb
	sw/0vhxJAtg/MklmyItPyVV5LsknMxANH6LVN/4RFvVj95K6d7aZelBPsbIrZXSMcfxaaE
	vyRgka4ctYe5rvON3mAl6/CH1PQumBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739811982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UfDVsuLhacxyBJCagIZzUENSwreQL/lZSF/d20A7WmM=;
	b=wWxd7Y1ZYjLTOSy2kZpOvBrsycxRG0zeXWMkgB15NtAglEfyMeTsqKM9tttzrgBR2t3rK4
	xdXhTMpCmYFAchCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9488D1379D;
	Mon, 17 Feb 2025 17:06:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qY0dIY1ss2cZXgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 17 Feb 2025 17:06:21 +0000
Date: Mon, 17 Feb 2025 18:06:16 +0100
Message-ID: <8734gc8prr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] ALSA: usb-audio: drain may fail with multi-port close race
In-Reply-To: <20250217111647.3368132-1-jkeeping@inmusicbrands.com>
References: <20250217111647.3368132-1-jkeeping@inmusicbrands.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 0D8CE2118A
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
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 17 Feb 2025 12:16:46 +0100,
John Keeping wrote:
> 
> I'm seeing a bug where data sometimes fails to send on USB MIDI devices
> with multiple ports which seems to be a result of a race around closing
> ports introduced by commit 0125de38122f0 ("ALSA: usb-audio: Cancel
> pending work at closing a MIDI substream").
> 
> The scenario is essentially this program:
> 
> 	snd_rawmidi_t *port0, *port1;
> 	snd_rawmidi_open(NULL, &port0, "hw:0,0,0", 0);
> 	snd_rawmidi_open(NULL, &port1, "hw:0,0,1", 0);
> 
> 	snd_rawmidi_write(port0, data, len);
> 
> 	snd_rawmidi_close(port1);
> 	snd_rawmidi_close(port0);
> 
> What happens seems to be the following:
> 
> 	write(port0)
> 	`- snd_usbmidi_output_trigger
> 	   `- queue_work()
>         close(port1)
> 	`- snd_usbmidi_output_close
> 	   `- cancel_work_sync()	# Work has not yet started here
> 	close(port0)
> 	`- snd_rawmidi_drain_output
> 	   # Times out because nothing is processing outbound data!
> 
> The two ports interact like this because they are on the same endpoint,
> so should the work only be cancelled when the last endpoint is closed?

How about the following patch work?
It's a band-aid, but should suffice.  The callback is already
protected with rawmidi open_mutex.


thanks,

Takashi

-- 8< --
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1144,8 +1144,11 @@ static int snd_usbmidi_output_open(struct snd_rawmidi_substream *substream)
 static int snd_usbmidi_output_close(struct snd_rawmidi_substream *substream)
 {
 	struct usbmidi_out_port *port = substream->runtime->private_data;
+	struct snd_usb_midi *umidi = substream->rmidi->private_data;
 
-	cancel_work_sync(&port->ep->work);
+	/* cancel at the last close */
+	if (umidi->opened[0] == 1)
+		cancel_work_sync(&port->ep->work);
 	return substream_open(substream, 0, 0);
 }
 

