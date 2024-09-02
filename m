Return-Path: <linux-kernel+bounces-310809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3848196817B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BA01C21D53
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BAD181310;
	Mon,  2 Sep 2024 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zXr6mN9k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SIuxL+OC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zXr6mN9k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SIuxL+OC"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDCE14D702;
	Mon,  2 Sep 2024 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264932; cv=none; b=jYIFr/h7meI6CrIHNKBpdwR8Lt6jlFsCBx2EEIF/6yIJVxbXRbG9oKL7hqeqIVr5VfyHVbD3+KZeHCBqlerot+LVRh2Cd9+iRfv3+2mNnwpcTkRz2iiMKHybemeIKgXQwjB+UZF/wPbnPNafbIsVZkvodz1RfIEy5PkuM/WhwNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264932; c=relaxed/simple;
	bh=K70LkoQx+9PYr4ObqhrAS/sDQx0Qit2c+Y8k+OVu8Og=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTSy+HzFiz8hpTto8LDxT2B96ph48qdP5JidjZ38o4ieMyTZ3qEqHsw627qYTDZDOQRJecX7ObDlyvW14EMzQ7NY9AServtnIvi4b3pw4HEA2Dep+KbFNccy6QERG9vaMa2odafI4Ak7wwVZsHBfeaujoAtygLgd3ilJKRVgbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zXr6mN9k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SIuxL+OC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zXr6mN9k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SIuxL+OC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B1B291FB9D;
	Mon,  2 Sep 2024 08:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725264928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y9nZtS3ICNPKS1JtyX5ow5n7qfdISmYsEdl7+U0m94=;
	b=zXr6mN9kra48ncrK36ii1aiyPXWKnU9CZcQWp35oJsxOVU18Td2RrqqtDUbmUIRi4TZVfY
	diPe9ofvdUg+ADrEE2eFpVuG5iHYtFNEHGidz2X9eC0oLAtBq6JQ5sQskekvNFbix9+NyF
	Zgj0O7I2Wny/INX+4YDKL8rwSA+jgTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725264928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y9nZtS3ICNPKS1JtyX5ow5n7qfdISmYsEdl7+U0m94=;
	b=SIuxL+OCctp8C54nwVMumYuIv89K4h+hOLFnZ6W5ZsZUtm1UEoWU1X2bpWfZhvtnFicdIM
	2Rx1bbgVjqrM56BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725264928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y9nZtS3ICNPKS1JtyX5ow5n7qfdISmYsEdl7+U0m94=;
	b=zXr6mN9kra48ncrK36ii1aiyPXWKnU9CZcQWp35oJsxOVU18Td2RrqqtDUbmUIRi4TZVfY
	diPe9ofvdUg+ADrEE2eFpVuG5iHYtFNEHGidz2X9eC0oLAtBq6JQ5sQskekvNFbix9+NyF
	Zgj0O7I2Wny/INX+4YDKL8rwSA+jgTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725264928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Y9nZtS3ICNPKS1JtyX5ow5n7qfdISmYsEdl7+U0m94=;
	b=SIuxL+OCctp8C54nwVMumYuIv89K4h+hOLFnZ6W5ZsZUtm1UEoWU1X2bpWfZhvtnFicdIM
	2Rx1bbgVjqrM56BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A43A13AE5;
	Mon,  2 Sep 2024 08:15:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iia+GCB01WZNPQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 02 Sep 2024 08:15:28 +0000
Date: Mon, 02 Sep 2024 10:16:14 +0200
Message-ID: <87r0a2ii7l.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Asahi Lina <lina@asahilina.net>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Mark Hills <mark@xwax.org>,
	Arun Raghavan <arun@arunraghavan.net>,
	Cyan Nyan <cyan.vtb@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: usb-audio: Add quirk for RME Digiface USB
In-Reply-To: <3980ad8b-d27c-482e-bbb7-3b243ecc8744@asahilina.net>
References: <20240902-rme-digiface-v1-0-6e88472a2744@asahilina.net>
	<20240902-rme-digiface-v1-1-6e88472a2744@asahilina.net>
	<8734mik2m6.wl-tiwai@suse.de>
	<3980ad8b-d27c-482e-bbb7-3b243ecc8744@asahilina.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,perex.cz,suse.com,b4.vu,sakamocchi.jp,xwax.org,arunraghavan.net,gmail.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 02 Sep 2024 10:12:18 +0200,
Asahi Lina wrote:
> 
> 
> 
> On 9/2/24 3:10 PM, Takashi Iwai wrote:
> > On Sun, 01 Sep 2024 23:31:50 +0200,
> > Asahi Lina wrote:
> >>
> >> From: Cyan Nyan <cyan.vtb@gmail.com>
> >>
> >> Add trivial support for audio streaming on the RME Digiface USB. Binds
> >> only to the first interface to allow userspace to directly drive the
> >> complex I/O and matrix mixer controls.
> >>
> >> Signed-off-by: Cyan Nyan <cyan.vtb@gmail.com>
> >> [Lina: Added 2x/4x sample rate support & boot/format quirks]
> >> Co-developed-by: Asahi Lina <lina@asahilina.net>
> >> Signed-off-by: Asahi Lina <lina@asahilina.net>
> >> ---
> >>  sound/usb/quirks-table.h | 190 ++++++++++++++++++++++++++++++++++++++++++++++-
> >>  sound/usb/quirks.c       |  58 +++++++++++++++
> >>  2 files changed, 247 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
> >> index 73abc38a5400..47fd18791396 100644
> >> --- a/sound/usb/quirks-table.h
> >> +++ b/sound/usb/quirks-table.h
> >> @@ -4546,6 +4546,194 @@ YAMAHA_DEVICE(0x7010, "UB99"),
> >>  		}
> >>  	}
> >>  },
> >> -
> >> +{
> >> +	/* Only claim interface 0 */
> >> +	.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
> >> +		       USB_DEVICE_ID_MATCH_PRODUCT |
> >> +		       USB_DEVICE_ID_MATCH_INT_CLASS |
> >> +		       USB_DEVICE_ID_MATCH_INT_NUMBER,
> >> +	.idVendor = 0x2a39,
> >> +	.idProduct = 0x3f8c,
> >> +	.bInterfaceClass = USB_CLASS_VENDOR_SPEC,
> >> +	.bInterfaceNumber = 0,
> >> +	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
> >> +		.ifnum = QUIRK_ANY_INTERFACE,
> >> +		.type = QUIRK_COMPOSITE,
> > (snip)
> > 
> > Recently the quirk tables are rewritten with macros.
> > See the commit d79e13f8e8abb5cd3a2a0f9fc9bc3fc750c5b06f
> >     ALSA: usb-audio: Replace complex quirk lines with macros
> > in for-next branch of sound.git tree.
> > 
> > Could you try to apply to your new entries, too?
> 
> Sure! Note that I open-coded the USB match because I need to add
> USB_DEVICE_ID_MATCH_INT_NUMBER (to stop the driver from binding to and
> claiming all interfaces, QUIRK_DATA_IGNORE() is not enough for that).
> Should I leave it like that (since it's the only case so far) or do you
> want me to introduce another macro for that case?

The open-code with match_flags is fine, you can keep that.
If we have other similar cases, we can introduce a macro for cleanup
later, too.


> I'll rewrite the quirk info stuff with the macros for v2. I'll also
> remove USB_ENDPOINT_USAGE_IMPLICIT_FB since I'm pretty sure that does
> nothing here (at first I thought I could get it to pick up the implicit
> FB with that but I ended up having to specify the sync/implicit_fb stuff
> explicitly).

Sounds good.  Thanks!


Takashi

