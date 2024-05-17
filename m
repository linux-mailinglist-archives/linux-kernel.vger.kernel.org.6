Return-Path: <linux-kernel+bounces-182491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2E58C8BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5811C21F47
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE5013E8BA;
	Fri, 17 May 2024 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NrcYUwXV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JQ/px1ya";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NrcYUwXV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JQ/px1ya"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D3413E3F7;
	Fri, 17 May 2024 17:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715968254; cv=none; b=Qs+ikTQETg+nCqHlqhrDJ4DiAx29jpjpYvy6D3kl1yxiwx+sxp0F9xGPA0m7mOoM8VEqNnJ1Ethp+3X0Vsc3v8FmOYwElcdEiUiITQnECQugutPMAnimKx6z62/2xHFQ1t1R4zm1bSZCecczvwp/8nnpB7Cn8aLHLYY7xh3mwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715968254; c=relaxed/simple;
	bh=yk1t+EjWvbaaz7g+uVK0geVAFCR+QflVpLSr+wtWhGw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYm5o8yF52QtEbPqtjsW9kUPBxzpNYUBAUvpE/FqFvkVqe27CU3Ny5qrSHSxzAcwQVjd2FtrAdJ1OwrmVevdQvC7MwZMWD147Tb0RygihUuY4WABzcF29ysxrUgu7gvUTM0FML9XkyUWJ4F5PRAPrfMuhCEHKxsVw68PqLItHBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NrcYUwXV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JQ/px1ya; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NrcYUwXV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JQ/px1ya; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01115376F1;
	Fri, 17 May 2024 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715968251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0nVe1f27uSe2Mi53MHpPoWcgGznN1HQyO9LTW63aVI=;
	b=NrcYUwXVV1iXaV/Ucu4YPSM/LU6fbE7yjsIgvLw96gG4F5RetJ+SB8QGQ32ReXoxphRwUf
	74x0wOHD1IFh5HKztNBaYDduvJH6qTOB8clIzvDS9E5onobz6xzGis6pmzD8tCIqWGAQdQ
	pW7M+bRMiEZP+2Dy7N9L/TFGRgCyb88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715968251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0nVe1f27uSe2Mi53MHpPoWcgGznN1HQyO9LTW63aVI=;
	b=JQ/px1yaYiEU9+U005X4rkWObQ20U2/hrZhtlrDRsz/wy9aKGFK0wEQbckM2B51O8NvROJ
	64E+3pYsoZfC2qDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NrcYUwXV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="JQ/px1ya"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715968251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0nVe1f27uSe2Mi53MHpPoWcgGznN1HQyO9LTW63aVI=;
	b=NrcYUwXVV1iXaV/Ucu4YPSM/LU6fbE7yjsIgvLw96gG4F5RetJ+SB8QGQ32ReXoxphRwUf
	74x0wOHD1IFh5HKztNBaYDduvJH6qTOB8clIzvDS9E5onobz6xzGis6pmzD8tCIqWGAQdQ
	pW7M+bRMiEZP+2Dy7N9L/TFGRgCyb88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715968251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0nVe1f27uSe2Mi53MHpPoWcgGznN1HQyO9LTW63aVI=;
	b=JQ/px1yaYiEU9+U005X4rkWObQ20U2/hrZhtlrDRsz/wy9aKGFK0wEQbckM2B51O8NvROJ
	64E+3pYsoZfC2qDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A93B513991;
	Fri, 17 May 2024 17:50:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cr2JJ/qYR2alcgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 17 May 2024 17:50:50 +0000
Date: Fri, 17 May 2024 19:51:08 +0200
Message-ID: <871q608gz7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Yunseong Kim <yskelg@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	skhan@linuxfoundation.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] line6: add midibuf init failure handling in line6_init_midi()
In-Reply-To: <a258b613-3697-4f21-a8fd-20b276f63132@gmail.com>
References: <20240516174737.415912-1-yskelg@gmail.com>
	<8734qg260i.wl-tiwai@suse.de>
	<a258b613-3697-4f21-a8fd-20b276f63132@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.de,perex.cz,linuxfoundation.org,kernel.org,lists.linuxfoundation.org,gmail.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 01115376F1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Fri, 17 May 2024 19:10:44 +0200,
Yunseong Kim wrote:
> 
> On 5/17/24 5:32 ¿ÀÈÄ, Takashi Iwai wrote:
> > The allocated object is already freed by snd_line6_midi_free() that is
> > called via rawmidi private_free at its destruction.  So your change
> > would lead to a double-free.
> > 
> > 
> > thanks,
> > 
> > Takashi
> 
> Thanks for the review Takashi.
> 
> I have one question:
> 
> line6_midibuf_destroy() have no NULL check for the memory to free.
> 
> If line6midi->midibuf_in is in this->buf = NULL from
> line6_midibuf_init() with memory allocation failed,
> won't the free(NULL) when accessed by snd_line6_midi_free() to
> line6_midibuf_destroy()?

free(NULL) is fine, it's defined to be noop.
Many codes just call free() unconditionally for that, as it reduces
the code size.


thanks,

Takashi

> In the first patch, I was making a misunderstanding
> Now that you mention it, I can see where it's freeing!
> It helped me a lot in analyzing the driver code.
> 
> Please let me know if I've misunderstood anything.
> 
> Warm Regards,
> Yunseong Kim
> 
> >> ---
> >>  sound/usb/line6/midi.c | 9 +++++++--
> >>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
> >> index 0838632c788e..abcf58f46673 100644
> >> --- a/sound/usb/line6/midi.c
> >> +++ b/sound/usb/line6/midi.c
> >> @@ -283,13 +283,18 @@ int line6_init_midi(struct usb_line6 *line6)
> >>  
> >>  	err = line6_midibuf_init(&line6midi->midibuf_in, MIDI_BUFFER_SIZE, 0);
> >>  	if (err < 0)
> >> -		return err;
> >> +		goto error;
> >>  
> >>  	err = line6_midibuf_init(&line6midi->midibuf_out, MIDI_BUFFER_SIZE, 1);
> >>  	if (err < 0)
> >> -		return err;
> >> +		goto error;
> >>  
> >>  	line6->line6midi = line6midi;
> >>  	return 0;
> >> +
> >> +error:
> >> +	kfree(line6midi);
> >> +	return err;
> >> +
> >>  }
> >>  EXPORT_SYMBOL_GPL(line6_init_midi);
> >> -- 
> >> 2.34.1
> >>

