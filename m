Return-Path: <linux-kernel+bounces-222195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A1A90FE11
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890C71C212A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3738650288;
	Thu, 20 Jun 2024 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dZslguGu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FbcfHPT3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dZslguGu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FbcfHPT3"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013741803A;
	Thu, 20 Jun 2024 07:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870198; cv=none; b=lmQWoWWvrxTXU5qmKYqNySBzdulEi448xaz6oA24UFCRQcjbQ8aNCa5n0wpkfHjppMIRSG+m5t8EiDnsjhEFJ9HdPdYf5eDX3grNnSIZtNXOlRCq4fWSABgra4zgOp8N1dxQk8WjDd9srMtbwOKo9N9rytjbO89d2pq/GVFTowo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870198; c=relaxed/simple;
	bh=2f1Od9j0kNZ9C125auahTDD/lvFjwmRaaRilrw7OwEQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDwH9wsPeKbr9i6Ikb6B3Hkczu8uPYL93peHTwD7hM6gHpFGf/ux2IvRlMOd0kwbzWlWENoER71l7eRhyyZVJXwyKdk0Hnn3YsSzvHdKKIi5EYKgzMZPUwu6yESyOuDmP43R3H+xnjSHzgEL0hxmbWtaNHEnokgfedN2zfY0DvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dZslguGu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FbcfHPT3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dZslguGu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FbcfHPT3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 11F5D1F7DF;
	Thu, 20 Jun 2024 07:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718870195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BiPM555ZzJD1oXU+hzRkT4qSznj4dFJ5BmzsuFrO3Kc=;
	b=dZslguGuIC0PnEDmP/h3r9mHMqQxpC0J+6i+uqdL2ef3EQzRb+0FRTiVuudmVB/iZ/CanX
	mWg8I9wddNCJNpRoYD8coKj2lPrYwugByUybmIK0OnX9K8AAUrNJ4OFY2xT4joRhv4PC/0
	D9JmHWCPj/HrK2FvTM1IWD2CqqHUzsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718870195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BiPM555ZzJD1oXU+hzRkT4qSznj4dFJ5BmzsuFrO3Kc=;
	b=FbcfHPT3eu99VM/TclJn0m8xWux1UcazMB9ZAqpJrN8v33Vw0AHH9da4E4anPe3E86gylb
	cQ8iiJhmSHfVZ7Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718870195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BiPM555ZzJD1oXU+hzRkT4qSznj4dFJ5BmzsuFrO3Kc=;
	b=dZslguGuIC0PnEDmP/h3r9mHMqQxpC0J+6i+uqdL2ef3EQzRb+0FRTiVuudmVB/iZ/CanX
	mWg8I9wddNCJNpRoYD8coKj2lPrYwugByUybmIK0OnX9K8AAUrNJ4OFY2xT4joRhv4PC/0
	D9JmHWCPj/HrK2FvTM1IWD2CqqHUzsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718870195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BiPM555ZzJD1oXU+hzRkT4qSznj4dFJ5BmzsuFrO3Kc=;
	b=FbcfHPT3eu99VM/TclJn0m8xWux1UcazMB9ZAqpJrN8v33Vw0AHH9da4E4anPe3E86gylb
	cQ8iiJhmSHfVZ7Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2EFF13AC1;
	Thu, 20 Jun 2024 07:56:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QAdILrLgc2blVgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 20 Jun 2024 07:56:34 +0000
Date: Thu, 20 Jun 2024 09:57:00 +0200
Message-ID: <87frt82gj7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lars@metafoo.de,
	perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	shengjiu.wang@gmail.com
Subject: Re: [RESEND PATCH] ALSA: dmaengine_pcm: terminate dmaengine before synchronize
In-Reply-To: <1718851218-27803-1-git-send-email-shengjiu.wang@nxp.com>
References: <1718851218-27803-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[metafoo.de,perex.cz,suse.com,kernel.org,vger.kernel.org,alsa-project.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]

On Thu, 20 Jun 2024 04:40:18 +0200,
Shengjiu Wang wrote:
> 
> When dmaengine supports pause function, in suspend state,
> dmaengine_pause() is called instead of dmaengine_terminate_async(),
> 
> In end of playback stream, the runtime->state will go to
> SNDRV_PCM_STATE_DRAINING, if system suspend & resume happen
> at this time, application will not resume playback stream, the
> stream will be closed directly, the dmaengine_terminate_async()
> will not be called before the dmaengine_synchronize(), which
> violates the call sequence for dmaengine_synchronize().

Hmm, I can't follow this state change.
Do you mean that:
- snd_pcm_drain() is performed for a playback stream
- while draining operation, the system goes to suspend
- the system resumes (but the application doesn't call resume yet)
- The stream is closed (without calling resume)
??

If so, it's rather an inconsistent PCM state in the core side, and can
be fixed by a simple call like below:

-- 8< --
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2700,6 +2700,7 @@ void snd_pcm_release_substream(struct snd_pcm_substream *substream)
 	if (substream->ref_count > 0)
 		return;
 
+	snd_pcm_resume(substream);
 	snd_pcm_drop(substream);
 	if (substream->hw_opened) {
 		if (substream->runtime->state != SNDRV_PCM_STATE_OPEN)
-- 8< --

This will be no-op for the PCM device without SNDRV_PCM_INFO_RESUME.

But, this may need more rework, too; admittedly it imposes the
unnecessary resume of the stream although it shall be stopped and
closed immediately after that.  We may have some optimization in
addition.


thanks,

Takashi

