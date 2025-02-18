Return-Path: <linux-kernel+bounces-518783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF8A3947F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DA3188E0F8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D7C22ACF7;
	Tue, 18 Feb 2025 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jf1SZCwg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O/5UskKI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jf1SZCwg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O/5UskKI"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6034922ACCE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866057; cv=none; b=R3zOf+Y2u1A7fJC8v20j/zGsy4AHHNAp0Agjh4Mok+2SzQF7uhuR0c/NwMzGLLEd3pbqi7TPYDSPZ/NZtSwsCBzkg2C4mqXC5A+eOS52QCNfBQG1vtjuevTfNcxhklYrq9hlwiaJW+prZIuyvg/vEjJfbmhHEEK4m5J5dfj3/gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866057; c=relaxed/simple;
	bh=n8hdxqea0Cii7OvjC4177i8E3IGatQMn5FrjuusoBws=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjzUHefnk+LAjsyxC3uxF26bpTTitgfiruxfSymCi0zOwgnkNeJ1NF8DWQ6c4jRGnntt0KAs4kkoPtKn03EfaPuH6EJyNhaEqMkAFRMZtgHgs2FaYkqZEKSEPdx6jtXJzY9e+yMGpFOuLUKtyQ546/YKXZcafmsmPytU5/pvAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jf1SZCwg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O/5UskKI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jf1SZCwg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O/5UskKI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E6F91F396;
	Tue, 18 Feb 2025 08:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739866048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s8rH66VwakmIVEj/znEtIpDflz8sHWMRIsQr8wdgyxk=;
	b=Jf1SZCwgLmk8GfWDRpkOrvOl/QIM3TVKeZvbvnJhYnkyGtlZWs+Jn59GVY2JQr7HbM3K9P
	Wpp59uJaBLcAxYM0EI1UFLQ2uRP3L24IUcAhrD4Cu5u/DfNlk4+CUIoCpY8EMA730s77iJ
	TffB2+Qn2rRyDkrJVIAGhRwC+SED0iA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739866048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s8rH66VwakmIVEj/znEtIpDflz8sHWMRIsQr8wdgyxk=;
	b=O/5UskKIHAr2Oq0o9YYLVhqkxf51VbheQrA5g/PJWQ62DQJ2HUhaxBbQBSQJARfk6kdC+v
	ha8ttrSvmfVeSlAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739866048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s8rH66VwakmIVEj/znEtIpDflz8sHWMRIsQr8wdgyxk=;
	b=Jf1SZCwgLmk8GfWDRpkOrvOl/QIM3TVKeZvbvnJhYnkyGtlZWs+Jn59GVY2JQr7HbM3K9P
	Wpp59uJaBLcAxYM0EI1UFLQ2uRP3L24IUcAhrD4Cu5u/DfNlk4+CUIoCpY8EMA730s77iJ
	TffB2+Qn2rRyDkrJVIAGhRwC+SED0iA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739866048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s8rH66VwakmIVEj/znEtIpDflz8sHWMRIsQr8wdgyxk=;
	b=O/5UskKIHAr2Oq0o9YYLVhqkxf51VbheQrA5g/PJWQ62DQJ2HUhaxBbQBSQJARfk6kdC+v
	ha8ttrSvmfVeSlAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D648E132C7;
	Tue, 18 Feb 2025 08:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A8v0ML8/tGc4VQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 18 Feb 2025 08:07:27 +0000
Date: Tue, 18 Feb 2025 09:07:26 +0100
Message-ID: <87zfij65hd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Takashi Iwai <tiwai@suse.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] ALSA: usb-audio: drain may fail with multi-port close race
In-Reply-To: <Z7OCJ2DikMvhAxVf-jkeeping@inmusicbrands.com>
References: <20250217111647.3368132-1-jkeeping@inmusicbrands.com>
	<8734gc8prr.wl-tiwai@suse.de>
	<Z7OCJ2DikMvhAxVf-jkeeping@inmusicbrands.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Mon, 17 Feb 2025 19:38:31 +0100,
John Keeping wrote:
> 
> On Mon, Feb 17, 2025 at 06:06:16PM +0100, Takashi Iwai wrote:
> > On Mon, 17 Feb 2025 12:16:46 +0100,
> > John Keeping wrote:
> > > 
> > > I'm seeing a bug where data sometimes fails to send on USB MIDI devices
> > > with multiple ports which seems to be a result of a race around closing
> > > ports introduced by commit 0125de38122f0 ("ALSA: usb-audio: Cancel
> > > pending work at closing a MIDI substream").
> > > 
> > > The scenario is essentially this program:
> > > 
> > > 	snd_rawmidi_t *port0, *port1;
> > > 	snd_rawmidi_open(NULL, &port0, "hw:0,0,0", 0);
> > > 	snd_rawmidi_open(NULL, &port1, "hw:0,0,1", 0);
> > > 
> > > 	snd_rawmidi_write(port0, data, len);
> > > 
> > > 	snd_rawmidi_close(port1);
> > > 	snd_rawmidi_close(port0);
> > > 
> > > What happens seems to be the following:
> > > 
> > > 	write(port0)
> > > 	`- snd_usbmidi_output_trigger
> > > 	   `- queue_work()
> > >         close(port1)
> > > 	`- snd_usbmidi_output_close
> > > 	   `- cancel_work_sync()	# Work has not yet started here
> > > 	close(port0)
> > > 	`- snd_rawmidi_drain_output
> > > 	   # Times out because nothing is processing outbound data!
> > > 
> > > The two ports interact like this because they are on the same endpoint,
> > > so should the work only be cancelled when the last endpoint is closed?
> > 
> > How about the following patch work?
> > It's a band-aid, but should suffice.  The callback is already
> > protected with rawmidi open_mutex.
> 
> Yes, this patch fixes it and is
> 
> Tested-by: John Keeping <jkeeping@inmusicbrands.com>

Thank you for quick testing!

Looking at the code again, I think the suggested fix isn't right.
It still allows some pending work accessing the freed object.

Could you test the following one-liner instead?


Takashi

-- 8< --
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1145,7 +1145,7 @@ static int snd_usbmidi_output_close(struct snd_rawmidi_substream *substream)
 {
 	struct usbmidi_out_port *port = substream->runtime->private_data;
 
-	cancel_work_sync(&port->ep->work);
+	flush_work(&port->ep->work);
 	return substream_open(substream, 0, 0);
 }
 

