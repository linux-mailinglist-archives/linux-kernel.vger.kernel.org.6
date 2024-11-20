Return-Path: <linux-kernel+bounces-415397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4979D357D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42D3B2343E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE2C184F;
	Wed, 20 Nov 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xg6UR4JN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nl+bOH05";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xg6UR4JN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nl+bOH05"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DB616EBEE;
	Wed, 20 Nov 2024 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091621; cv=none; b=QKqUlERtTxvnnzWIWEcBWrAcfZ0m+iaAFgG2VDYLuThQFFkeYb4Uv8FCR4KyvXYoyJ/byxVRoUW6P+aES84qpPgBipHpwu1GkKHcj6ZC7thMkTx4opCBYM2S6VWSyT8c8hxY+X2+ATHi6QErG4LulD5hKkcqtNvfYE4ZnchFOHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091621; c=relaxed/simple;
	bh=7Dy3WK0ZggVyQDQeNuJn80H9ug9Qv0xcTRXatgyVWq4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJywqUt7aPaqPkiQfqhQmPmhDx3JKoH6Kdvq7P62JDg4D8vGOghKGb8P1soUA4jcXfn/v2UF3YrxHNtxkY3c9JRefZ+J77mm1cODUYKNpwjGmeI488c5z9vW8gWVtH9veSw972LcYYOl3C0A5UsQRVxRUqmiB/RrGFyLIc9Hui0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xg6UR4JN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nl+bOH05; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xg6UR4JN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nl+bOH05; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72B83219D5;
	Wed, 20 Nov 2024 08:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732091617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WwsJrgxBJQh+/WmDtUMdBFe9Y/Vayl+M/pYgDG1mhRE=;
	b=xg6UR4JNCSj/nj3ILldDDh2aqzYgqvKX/djeFz5EVFELNtXqF+GEVvExmWwLIutmCj1ETd
	qLtrQIBsABcUDd1zkj6jdGFhRA5BLutnDfKLUsS/9P4Jk4CxpysG6Ms74UUm1J2BEnKHmA
	Z3tj7TOLId3UFEj+gOjhx6aJ5Mp2a/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732091617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WwsJrgxBJQh+/WmDtUMdBFe9Y/Vayl+M/pYgDG1mhRE=;
	b=nl+bOH05r1B7poIw7tqbAYNOwEG8+sxZ49TGtGdKu9Mzy6MyemfRiwrNoo7g7pt/7rI7Cw
	ZQSqWIKSlO+jHiAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xg6UR4JN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nl+bOH05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732091617; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WwsJrgxBJQh+/WmDtUMdBFe9Y/Vayl+M/pYgDG1mhRE=;
	b=xg6UR4JNCSj/nj3ILldDDh2aqzYgqvKX/djeFz5EVFELNtXqF+GEVvExmWwLIutmCj1ETd
	qLtrQIBsABcUDd1zkj6jdGFhRA5BLutnDfKLUsS/9P4Jk4CxpysG6Ms74UUm1J2BEnKHmA
	Z3tj7TOLId3UFEj+gOjhx6aJ5Mp2a/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732091617;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WwsJrgxBJQh+/WmDtUMdBFe9Y/Vayl+M/pYgDG1mhRE=;
	b=nl+bOH05r1B7poIw7tqbAYNOwEG8+sxZ49TGtGdKu9Mzy6MyemfRiwrNoo7g7pt/7rI7Cw
	ZQSqWIKSlO+jHiAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FC0A137CF;
	Wed, 20 Nov 2024 08:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6wlSDuGePWdHPwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 20 Nov 2024 08:33:37 +0000
Date: Wed, 20 Nov 2024 09:33:36 +0100
Message-ID: <87v7wi484f.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Leonard Crestez <cdleonard@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] ALSA: usb-audio: Fix missing xrun report in lowlatency mode
In-Reply-To: <874j425pjz.wl-tiwai@suse.de>
References: <25d5b0d8-4efd-4630-9d33-7a9e3fa9dc2b@gmail.com>
	<874j425pjz.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 72B83219D5
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 20 Nov 2024 08:31:44 +0100,
Takashi Iwai wrote:
> 
> On Tue, 19 Nov 2024 22:54:19 +0100,
> Leonard Crestez wrote:
> > 
> > Hello,
> > 
> > I¢m investigating an issue where USB Audio does not properly send
> > XRUN notifications.
> > 
> > The issue can be reproduced with aplay: enable xrun_debug, aplay -D
> > plughw:0 and CTRL-Z - no XRUN message is seen
> > 
> > Disabling lowlatency_playback via modprobe parameter does make this
> > issue go away - XRUNs are reported correctly without any changes.
> > 
> > 
> > After a lot of tracing the following seems to be happening:
> > 
> > - prepare_playback_urb find avail=48, meaning 48 bytes still to-be-played
> > - snd_usb_endpoint_next_packet_size decides that 48 is too little and
> > returns -EAGAIN. Specifically -EAGAIN is returned from
> > next_packet_size
> > - The return value of prepare_playback_urb is propagated through
> > prepare_outbound_urb back to snd_usb_queue_pending_output_urbs
> > - snd_usb_queue_pending_output_urbs receives -EAGAIN from
> > prepare_outbound_urb
> > - since err is -EAGAIN the ctx is pushed back to the ready list and
> > transmission is aborted but notify_xrun is skipped
> > - no more playback?
> > 
> > It is possible to make XRUNs happen by caling notify_xrun even on
> > -EAGAIN, diff looks like this:
> > 
> > diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> > index 568099467dbb..da64ee0cf60a 100644
> > --- a/sound/usb/endpoint.c
> > +++ b/sound/usb/endpoint.c
> > @@ -495,10 +495,11 @@ int snd_usb_queue_pending_output_urbs(struct
> > snd_usb_endpoint *ep,
> >                         break;
> >                 if (err < 0) {
> >                         /* push back to ready list again for -EAGAIN */
> >                         if (err == -EAGAIN) {
> >                                 push_back_to_ready_list(ep, ctx);
> > +                               notify_xrun(ep);
> >                                 break;
> >                         }
> > 
> >                         if (!in_stream_lock)
> >                                 notify_xrun(ep);
> > 
> > 
> > This mail was not formatted as proper patch because this seems very
> > likely incorrect, it undoes an explicit check. What would a correct
> > solution look like?
> 
> The -EAGAIN there itself doesn't mean the crucial xrun yet.  There may
> be still pending URBS to be processed.  The real XRUN happens only
> when there is no URBs pending, hence nothing will be taken further --
> at least for low-latency operation.  (In the case of implicit feedback
> mode, it can be driven by the feedback from the capture stream, and
> the empty URB check might be wrong.)
> 
> Could you check the change below?  (totally untested)

A bit more change would be needed because it can lead to a false xrun
at draining.  At stopping, it shouldn't reach to that code path.
The revised patch is below.


Takashi


--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -403,10 +403,15 @@ static int prepare_inbound_urb(struct snd_usb_endpoint *ep,
 static void notify_xrun(struct snd_usb_endpoint *ep)
 {
 	struct snd_usb_substream *data_subs;
+	struct snd_pcm_substream *psubs;
 
 	data_subs = READ_ONCE(ep->data_subs);
-	if (data_subs && data_subs->pcm_substream)
-		snd_pcm_stop_xrun(data_subs->pcm_substream);
+	if (!data_subs)
+		return;
+	psubs = data_subs->pcm_substream;
+	if (psubs && psubs->runtime &&
+	    psubs->runtime->state == SNDRV_PCM_STATE_RUNNING)
+		snd_pcm_stop_xrun(psubs);
 }
 
 static struct snd_usb_packet_info *
@@ -562,7 +567,10 @@ static void snd_complete_urb(struct urb *urb)
 			push_back_to_ready_list(ep, ctx);
 			clear_bit(ctx->index, &ep->active_mask);
 			snd_usb_queue_pending_output_urbs(ep, false);
-			atomic_dec(&ep->submitted_urbs); /* decrement at last */
+			/* decrement at last, and check xrun */
+			if (atomic_dec_and_test(&ep->submitted_urbs) &&
+			    !snd_usb_endpoint_implicit_feedback_sink(ep))
+				notify_xrun(ep);
 			return;
 		}
 

