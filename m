Return-Path: <linux-kernel+bounces-350030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBE898FEE8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2ED1F2281C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E9C13D503;
	Fri,  4 Oct 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qAWulZVI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q1v8H98C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qAWulZVI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q1v8H98C"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6F13C810;
	Fri,  4 Oct 2024 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728030304; cv=none; b=UcvL9ujdK6A2zX+4TDQZzBidG8DrvzG+b6/6xNQ0zTDRao76716dhVpo9BmFLTewbgjzZZI0HMi6BnV1u0eb+JkeWtzNxIyIosR3pj412n++Fume8G5+CpOoXVvAjFJyrrk5dD52t16EaKAjbMThLmZrVp4TgvER39VCPCqXDys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728030304; c=relaxed/simple;
	bh=kEtZfjO1cFf2dqeUqn3yUw3hXQzDL0kwAhldAv5SE7A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ddof0JisYm2HPsTwITrUAZmn2lrl1//UVRFG1kOln8IreuXxGpxiqJFT9KFfcK0C/8k2a7y7OK6ug5Ngq9FGDdDg5Jj/PdDkjT1RziyYN8gxSYEfE/iNQ25kD4Pr+731wJEDJ9uJ7BKec5THlpKuu+r5UeCH+BA34/HZ0tqPIXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qAWulZVI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q1v8H98C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qAWulZVI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q1v8H98C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 144451FB91;
	Fri,  4 Oct 2024 08:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728030301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ac5BUvnjyZ2mQgkwpda1ad9P9Ze6M0e1i8mt340OuIM=;
	b=qAWulZVIyr4Mso9RMUFbOBd34H4eX/7fcEm7RrKbn9HZCq+SkhS1XDTR1J9SqHJB15JW68
	WgxuTU5StG0jk6OtB9UhrPC33Y3FlgAx/N5nqM1lfVaDPm0TB0isMOWB+Il6q+hBBG7h+R
	4gk7u6DzgU6lMmd8CjQ7RerazzVTvSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728030301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ac5BUvnjyZ2mQgkwpda1ad9P9Ze6M0e1i8mt340OuIM=;
	b=Q1v8H98CpxJ0RpPlgpjhUIvdeKNDg0e9vWE20Jq62HZO9jsJufYG6/hyv0m0aae1w71CZr
	+Md8EzvWD042p7Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qAWulZVI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Q1v8H98C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728030301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ac5BUvnjyZ2mQgkwpda1ad9P9Ze6M0e1i8mt340OuIM=;
	b=qAWulZVIyr4Mso9RMUFbOBd34H4eX/7fcEm7RrKbn9HZCq+SkhS1XDTR1J9SqHJB15JW68
	WgxuTU5StG0jk6OtB9UhrPC33Y3FlgAx/N5nqM1lfVaDPm0TB0isMOWB+Il6q+hBBG7h+R
	4gk7u6DzgU6lMmd8CjQ7RerazzVTvSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728030301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ac5BUvnjyZ2mQgkwpda1ad9P9Ze6M0e1i8mt340OuIM=;
	b=Q1v8H98CpxJ0RpPlgpjhUIvdeKNDg0e9vWE20Jq62HZO9jsJufYG6/hyv0m0aae1w71CZr
	+Md8EzvWD042p7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7C2113A6E;
	Fri,  4 Oct 2024 08:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ODmUK1ym/2aUdQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 04 Oct 2024 08:25:00 +0000
Date: Fri, 04 Oct 2024 10:25:54 +0200
Message-ID: <87iku8mfzh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christoffer Sandberg <cs@tuxedo.de>
Cc: Jerry Luo <jerryluo225@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	christian@heusel.eu,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	regressions@lists.linux.dev,
	wse@tuxedocomputers.com
Subject: Re: [REGRESSION][BISECTED] Audio volume issues since 4178d78cd7a8
In-Reply-To: <dbc783cc2608ac63ffd420b1dc3eeaa9@tuxedo.de>
References: <87jzfbh5tu.wl-tiwai@suse.de>
	<ea6e5168-238f-41f5-9600-36b75ed990a1@gmail.com>
	<87jzetk2l0.wl-tiwai@suse.de>
	<b38b5947482a5ca4b55e0ddb908c2f34@tuxedo.de>
	<87seteli51.wl-tiwai@suse.de>
	<d348ca06-38ca-474f-8673-dff2248331e5@gmail.com>
	<dbc783cc2608ac63ffd420b1dc3eeaa9@tuxedo.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 144451FB91
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,heusel.eu,vger.kernel.org,perex.cz,lists.linux.dev,tuxedocomputers.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO

On Fri, 04 Oct 2024 10:18:10 +0200,
Christoffer Sandberg wrote:
> 
> 
> 
> On 2.10.2024 23:28, Jerry Luo wrote:
> > On 10/2/24 10:00 AM, Takashi Iwai wrote:
> >> On Wed, 02 Oct 2024 10:21:22 +0200,
> >> Christoffer Sandberg wrote:
> >>> 
> >>> 
> >>> On 30.9.2024 09:44, Takashi Iwai wrote:
> >>>> On Mon, 23 Sep 2024 21:37:42 +0200,
> >>>> Jerry Luo wrote:
> >>>>> 
> >>>>> Hi Takashi,
> >>>>> 
> >>>>> On Mon, 16 Sep 2024 19:22:05 +0200,
> >>>>> 
> >>>>> Takashi Iwai wrote:
> >>>>> 
> >>>>>      Could you give alsa-info.sh output from both working and
> >>>>> non-working
> >>>>>      cases?  Run the script with --no-upload option and attach the
> >>>>> outputs.
> >>>>> 
> >>>>>      thanks,
> >>>>> 
> >>>>>      Takashi
> >>>>> 
> >>>>> Issue now reappear, output from alsa-info.sh are attached. If they
> >>>>> are still
> >>>>> needed.
> >>>> Thanks.  The obvious difference seems to be the assignment of two
> >>>> DACs
> >>>> 0x10 and 0x11 for headphone and speaker outputs.
> >>>> 
> >>>> Christoffer, how are those on your machines?
> >>> I attached alsa-info from the Sirius Gen2 device.
> >>> 
> >>> Comparing the working/nonworking of Jerry, yeah, the assignment of
> >>> 0x10 and 0x11 looks switched around. I don't see what difference this
> >>> would make. Also, node 0x22 has "bass speaker" controls in the
> >>> non-working version.
> >>> 
> >>> Comparing the Sirius Gen2 alsa-info with Jerrys, to me it looks like
> >>> the non-working version corresponds to our working version.
> >>> 
> >>> I would expect the non-working version to happen all the time though
> >>> with regards to the "bass speaker" controls. Why would this only
> >>> happen sometimes?
> >> Thanks!  The assignment of DACs depend on the pins and topology, so it
> >> can be a bit sensitive.
> >> 
> >> Now looking more closely at both outputs, I wonder how the commit
> >> breaks pang14.  Maybe it has a PCI SSID 2782:12c5 (or 12c3) while the
> >> codec SSID is 2782:12b3?  If so, the patch below should fix.
> 
> Interesting, you're right, PCI SSID c3/c5 and codec SSID c3/c5 for the
> Siriuses.
> 
> I had a look around. In patch_realtek there are some cases where codec
> SSID match is needed as well. Would it be better/safer to directly do
> this immediately or keep it as an exception where it breaks or for
> known sensitive models/brands?

It needs a better handling, yes.  OTOH, the driver became gigantic and
it's very tough to change the basic matching stuff.  That is, we can't
flip from PCI SSID to codec SSID out of sudden, as it'll break
certainly many other systems.

What I have in mind is to add an extra flag to the matching table to
indicate the codec SSID matching, something like:

--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -282,6 +282,7 @@ struct hda_fixup {
 	int type;
 	bool chained:1;		/* call the chained fixup(s) after this */
 	bool chained_before:1;	/* call the chained fixup(s) before this */
+	bool match_codec_ssid:1; /* match with codec SSID instead of PCI SSID */
 	int chain_id;
 	union {
 		const struct hda_pintbl *pins;

Although this will help in this case, many of existing code do check
codec ID in addition to PCI SSID, and this flag won't help for them as
is.

> >> Could you guys try it and verify whether it fixes for Pangolin and
> >> doesn't break Sirius?
> >> 
> >> 
> >> Takashi
> >> 
> > It does seems to fix the issue on Pangolin. It might worth mention
> > that the headphone output will have the same issue when the speaker is
> > not working. Now they are all good. Thanks!
> > 
> > 
> > Jerry
> 
> Tested on our devices, both speakers still active.
> 
> That's an ok from my side as well, thanks!

OK, I'll submit it properly and merge for the next PR.


thanks,

Takashi

