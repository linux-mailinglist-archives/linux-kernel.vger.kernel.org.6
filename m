Return-Path: <linux-kernel+bounces-415307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1479D3428
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3666B230D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 07:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BFB15990C;
	Wed, 20 Nov 2024 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XqdbHcay";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VDqKZwzK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XqdbHcay";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VDqKZwzK"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55525848C;
	Wed, 20 Nov 2024 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732087909; cv=none; b=rG+a/NLrI6QNk11SKKeCmRUZHD7EFR04mY6m4CeVGrd/8jsnjsZz2VoWZyLAEKuYvEUAF+bEJNipOQxcer0RvFFQTvO5Ell3fBmw68ctAKVh35qlMUH0DRKdNZQX6XbgeWOcViErpTSIjV0LjEmOWgAFVsQ9H1g7jKCpDXY8rsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732087909; c=relaxed/simple;
	bh=UKn6BU/IKhz2dw85zcvYMCFZLSglRHKWiCyia9tFSIw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IM96egUNBQ71i6Utcz7HWFNcU8ZsaZamTCGipqTsc9aBluf2lM9BkOY6ZoAXPNfeTJKGGEjMjWjVvNiMJlp1AGrgorv71t9R5+39dWjsItKOToi04HPyIB/RJt8MLAFszTSveQSuc5iZnolYvkh4KRgIPioS3/cKjdgZikcnsnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XqdbHcay; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VDqKZwzK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XqdbHcay; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VDqKZwzK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A0FE1F795;
	Wed, 20 Nov 2024 07:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732087905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yaRz7nFJONUOYqe7kp7yYdh09C5DFs2nDVKqQd9JhPs=;
	b=XqdbHcayW3PJ0ZvGF5H3yhr21Jb4IXE90dCMnUbS5iBU3X4k/jqUUrlt9QHVgf+hGktrCZ
	R3c0yNh0Hd891CCIEkvFsBqBH/NXAEAQB9jcQH0S9fcgGr6NPi33O5RdqDY3F+jFB4a2Kj
	j1Uod4lJEo4jJJLi1DQCtW/V0h+lGoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732087905;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yaRz7nFJONUOYqe7kp7yYdh09C5DFs2nDVKqQd9JhPs=;
	b=VDqKZwzK5jsEShpj0Kkb2Ar7ZG4B4X71Xmy/kITnebm1zZ+sizXgXG8VbIcd0BtNc9kw1v
	0SqOWqiklRV5HjAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732087905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yaRz7nFJONUOYqe7kp7yYdh09C5DFs2nDVKqQd9JhPs=;
	b=XqdbHcayW3PJ0ZvGF5H3yhr21Jb4IXE90dCMnUbS5iBU3X4k/jqUUrlt9QHVgf+hGktrCZ
	R3c0yNh0Hd891CCIEkvFsBqBH/NXAEAQB9jcQH0S9fcgGr6NPi33O5RdqDY3F+jFB4a2Kj
	j1Uod4lJEo4jJJLi1DQCtW/V0h+lGoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732087905;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yaRz7nFJONUOYqe7kp7yYdh09C5DFs2nDVKqQd9JhPs=;
	b=VDqKZwzK5jsEShpj0Kkb2Ar7ZG4B4X71Xmy/kITnebm1zZ+sizXgXG8VbIcd0BtNc9kw1v
	0SqOWqiklRV5HjAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E19713297;
	Wed, 20 Nov 2024 07:31:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oRrfDWGQPWcWLAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 20 Nov 2024 07:31:45 +0000
Date: Wed, 20 Nov 2024 08:31:44 +0100
Message-ID: <874j425pjz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Leonard Crestez <cdleonard@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC] ALSA: usb-audio: Fix missing xrun report in lowlatency mode
In-Reply-To: <25d5b0d8-4efd-4630-9d33-7a9e3fa9dc2b@gmail.com>
References: <25d5b0d8-4efd-4630-9d33-7a9e3fa9dc2b@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 19 Nov 2024 22:54:19 +0100,
Leonard Crestez wrote:
> 
> Hello,
> 
> I¢m investigating an issue where USB Audio does not properly send
> XRUN notifications.
> 
> The issue can be reproduced with aplay: enable xrun_debug, aplay -D
> plughw:0 and CTRL-Z - no XRUN message is seen
> 
> Disabling lowlatency_playback via modprobe parameter does make this
> issue go away - XRUNs are reported correctly without any changes.
> 
> 
> After a lot of tracing the following seems to be happening:
> 
> - prepare_playback_urb find avail=48, meaning 48 bytes still to-be-played
> - snd_usb_endpoint_next_packet_size decides that 48 is too little and
> returns -EAGAIN. Specifically -EAGAIN is returned from
> next_packet_size
> - The return value of prepare_playback_urb is propagated through
> prepare_outbound_urb back to snd_usb_queue_pending_output_urbs
> - snd_usb_queue_pending_output_urbs receives -EAGAIN from
> prepare_outbound_urb
> - since err is -EAGAIN the ctx is pushed back to the ready list and
> transmission is aborted but notify_xrun is skipped
> - no more playback?
> 
> It is possible to make XRUNs happen by caling notify_xrun even on
> -EAGAIN, diff looks like this:
> 
> diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
> index 568099467dbb..da64ee0cf60a 100644
> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -495,10 +495,11 @@ int snd_usb_queue_pending_output_urbs(struct
> snd_usb_endpoint *ep,
>                         break;
>                 if (err < 0) {
>                         /* push back to ready list again for -EAGAIN */
>                         if (err == -EAGAIN) {
>                                 push_back_to_ready_list(ep, ctx);
> +                               notify_xrun(ep);
>                                 break;
>                         }
> 
>                         if (!in_stream_lock)
>                                 notify_xrun(ep);
> 
> 
> This mail was not formatted as proper patch because this seems very
> likely incorrect, it undoes an explicit check. What would a correct
> solution look like?

The -EAGAIN there itself doesn't mean the crucial xrun yet.  There may
be still pending URBS to be processed.  The real XRUN happens only
when there is no URBs pending, hence nothing will be taken further --
at least for low-latency operation.  (In the case of implicit feedback
mode, it can be driven by the feedback from the capture stream, and
the empty URB check might be wrong.)

Could you check the change below?  (totally untested)


thanks,

Takashi

--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -562,7 +562,10 @@ static void snd_complete_urb(struct urb *urb)
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
 

