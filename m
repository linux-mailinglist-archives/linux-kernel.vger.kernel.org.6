Return-Path: <linux-kernel+bounces-519294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F590A39B22
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5DD17405E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D2923ED6A;
	Tue, 18 Feb 2025 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="teE0M/Wb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZZxwPXdv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="teE0M/Wb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZZxwPXdv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043FD1AED5C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878801; cv=none; b=jRGZiwFzGM1bp+QmA0BuYi5IxNomL6d04pSwQkazf1gaIH+sqwBs/l1sHS8FZ5SMe7dBJl9Oci5rDS3AsPhUVbkykqK0bEuuqUK2VHGUYS6fsnScHxssDuNPVx30iI/aEleN/rL8UtOdF9JlDFqkC1ZHp6Qvvk0NB1qabXb2SS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878801; c=relaxed/simple;
	bh=YAOhoExo9uFyUTnaMmDU9LC8Sh+3aQK5UBcgWoh1V7c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHHpbQyK8GNbtOB15E6NnC2ocJhzUFtm0X+Njc3yClYVJqNlb1bwFSbKUf9v4cxuxeUU3jaKkGwywfmxGEukaMjVEtEAEiJxZxDZjagdQB595IEGnd2w5xdXje5h3fKd5wK5EzPBGHw/baDXwIDgtD6jUimKKthZ9MEv8Uhtd5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=teE0M/Wb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZZxwPXdv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=teE0M/Wb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZZxwPXdv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 142761F396;
	Tue, 18 Feb 2025 11:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739878797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGp9Y7QBbTCowpC82AAZ/8SUfWBJRStkalWWx8EvBpg=;
	b=teE0M/Wb7L2BCJg8MGl0eUB//LPUS+q84uAuNWNQGlLBavX5CJzvnLJ+88Z9Jm5+8Daor4
	g72YDr3UU6omHTDvWKMICFGq4VptFmN4YTk6Xi37CAJ2DLPHY9SfOu0eZMknCYzzE64Bfb
	C78uAstL7T6IUGGwpt4IWks6WDBw0f4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739878797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGp9Y7QBbTCowpC82AAZ/8SUfWBJRStkalWWx8EvBpg=;
	b=ZZxwPXdvwamMZcycvcamXZ0075s/Y3JzUrqtM56xqZnJfz7mcgdDTBoLbTWlipc/CZaQqn
	whtbG4mprzORLMAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739878797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGp9Y7QBbTCowpC82AAZ/8SUfWBJRStkalWWx8EvBpg=;
	b=teE0M/Wb7L2BCJg8MGl0eUB//LPUS+q84uAuNWNQGlLBavX5CJzvnLJ+88Z9Jm5+8Daor4
	g72YDr3UU6omHTDvWKMICFGq4VptFmN4YTk6Xi37CAJ2DLPHY9SfOu0eZMknCYzzE64Bfb
	C78uAstL7T6IUGGwpt4IWks6WDBw0f4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739878797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wGp9Y7QBbTCowpC82AAZ/8SUfWBJRStkalWWx8EvBpg=;
	b=ZZxwPXdvwamMZcycvcamXZ0075s/Y3JzUrqtM56xqZnJfz7mcgdDTBoLbTWlipc/CZaQqn
	whtbG4mprzORLMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8084F13A1D;
	Tue, 18 Feb 2025 11:39:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q1jHG4xxtGcGJAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 18 Feb 2025 11:39:56 +0000
Date: Tue, 18 Feb 2025 12:39:55 +0100
Message-ID: <87h64r5vn8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Takashi Iwai <tiwai@suse.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] ALSA: usb-audio: drain may fail with multi-port close race
In-Reply-To: <Z7RnUwatOnxYxNfI-jkeeping@inmusicbrands.com>
References: <20250217111647.3368132-1-jkeeping@inmusicbrands.com>
	<8734gc8prr.wl-tiwai@suse.de>
	<Z7OCJ2DikMvhAxVf-jkeeping@inmusicbrands.com>
	<87zfij65hd.wl-tiwai@suse.de>
	<Z7RnUwatOnxYxNfI-jkeeping@inmusicbrands.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Tue, 18 Feb 2025 11:56:19 +0100,
John Keeping wrote:
> 
> On Tue, Feb 18, 2025 at 09:07:26AM +0100, Takashi Iwai wrote:
> > On Mon, 17 Feb 2025 19:38:31 +0100,
> > John Keeping wrote:
> > > 
> > > On Mon, Feb 17, 2025 at 06:06:16PM +0100, Takashi Iwai wrote:
> > > > On Mon, 17 Feb 2025 12:16:46 +0100,
> > > > John Keeping wrote:
> > > > > 
> > > > > I'm seeing a bug where data sometimes fails to send on USB MIDI devices
> > > > > with multiple ports which seems to be a result of a race around closing
> > > > > ports introduced by commit 0125de38122f0 ("ALSA: usb-audio: Cancel
> > > > > pending work at closing a MIDI substream").
> > > > > 
> > > > > The scenario is essentially this program:
> > > > > 
> > > > > 	snd_rawmidi_t *port0, *port1;
> > > > > 	snd_rawmidi_open(NULL, &port0, "hw:0,0,0", 0);
> > > > > 	snd_rawmidi_open(NULL, &port1, "hw:0,0,1", 0);
> > > > > 
> > > > > 	snd_rawmidi_write(port0, data, len);
> > > > > 
> > > > > 	snd_rawmidi_close(port1);
> > > > > 	snd_rawmidi_close(port0);
> > > > > 
> > > > > What happens seems to be the following:
> > > > > 
> > > > > 	write(port0)
> > > > > 	`- snd_usbmidi_output_trigger
> > > > > 	   `- queue_work()
> > > > >         close(port1)
> > > > > 	`- snd_usbmidi_output_close
> > > > > 	   `- cancel_work_sync()	# Work has not yet started here
> > > > > 	close(port0)
> > > > > 	`- snd_rawmidi_drain_output
> > > > > 	   # Times out because nothing is processing outbound data!
> > > > > 
> > > > > The two ports interact like this because they are on the same endpoint,
> > > > > so should the work only be cancelled when the last endpoint is closed?
> > > > 
> > > > How about the following patch work?
> > > > It's a band-aid, but should suffice.  The callback is already
> > > > protected with rawmidi open_mutex.
> > > 
> > > Yes, this patch fixes it and is
> > > 
> > > Tested-by: John Keeping <jkeeping@inmusicbrands.com>
> > 
> > Thank you for quick testing!
> > 
> > Looking at the code again, I think the suggested fix isn't right.
> > It still allows some pending work accessing the freed object.
> > 
> > Could you test the following one-liner instead?
> 
> Tested-by: John Keeping <jkeeping@inmusicbrands.com>
> 
> The patch below also fixes the issue.  Thanks!

OK, I'm going to submit and merge the proper patch.


thanks,

Takashi

