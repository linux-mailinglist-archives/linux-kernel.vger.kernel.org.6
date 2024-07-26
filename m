Return-Path: <linux-kernel+bounces-262906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E4993CE8A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8851F23E94
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965BF176AA3;
	Fri, 26 Jul 2024 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dfAjCbXV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+SJQ8dsx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dfAjCbXV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+SJQ8dsx"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23521548EE;
	Fri, 26 Jul 2024 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721977655; cv=none; b=W+Hk/HbjGoFwnETaQVLCbTjH5n1W8bb2iD/LgJGdQ73wwCsRK0DehBY73HyB9B8DJ+MHX0WQl+u9aEr2KokIaH1UrKD9dlm4YMPMlTJzsz/WTcFwq2g7LuDWrUz0Y5NEcolx2G9ruklKZlqPaABR9ViivSgoq/iebK8k6/qAugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721977655; c=relaxed/simple;
	bh=pgTJnZC1Z1ijfVBAlpiMVk9RkOn68pFBBhgkoMd+oOI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaXQWtXT4phQlueWpqP2258/99eqj2EZB+7Ow0cd+5hnTScYXD4YTEbX2EwOHI2Hiwr6maAA4d0QHzK6KiHznFimhl3/BbP1d5PTe2CabeLMMItcvVeNu+Xr3zIPiMK8k+s+DmBgzcYIAqpPBGWJpyWobE3vY0zzB++td/CO5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dfAjCbXV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+SJQ8dsx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dfAjCbXV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+SJQ8dsx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 446271F871;
	Fri, 26 Jul 2024 07:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721977652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNojGv8R08gqdVJ3FDYCOLdZ/qIMRHlJVSJJ5bMiuGI=;
	b=dfAjCbXVPJUEY+/2wT2ZdBsJ9YBF1C92tgb4K/KplX2r23nANffhpHXNX049gAFMjvwNxW
	O2Y1u6xPQ+DCs95CIin+X7zQKzH1KDhisf1IZua42oMS4EZcTooElBrd736jbI9t/0jZI3
	5OE3m/p8g+hkzvVvGBiyn2hTDC5Gq5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721977652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNojGv8R08gqdVJ3FDYCOLdZ/qIMRHlJVSJJ5bMiuGI=;
	b=+SJQ8dsx1onLogUvhQLDt/rq3ik8RsInY6fCsYRnjnUv172EGu7DPZO9oGPxvHotvh7okW
	ibr+jSgR3GbXdtCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dfAjCbXV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+SJQ8dsx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721977652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNojGv8R08gqdVJ3FDYCOLdZ/qIMRHlJVSJJ5bMiuGI=;
	b=dfAjCbXVPJUEY+/2wT2ZdBsJ9YBF1C92tgb4K/KplX2r23nANffhpHXNX049gAFMjvwNxW
	O2Y1u6xPQ+DCs95CIin+X7zQKzH1KDhisf1IZua42oMS4EZcTooElBrd736jbI9t/0jZI3
	5OE3m/p8g+hkzvVvGBiyn2hTDC5Gq5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721977652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNojGv8R08gqdVJ3FDYCOLdZ/qIMRHlJVSJJ5bMiuGI=;
	b=+SJQ8dsx1onLogUvhQLDt/rq3ik8RsInY6fCsYRnjnUv172EGu7DPZO9oGPxvHotvh7okW
	ibr+jSgR3GbXdtCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11F21138A7;
	Fri, 26 Jul 2024 07:07:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c7rvATRLo2bQGgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 26 Jul 2024 07:07:32 +0000
Date: Fri, 26 Jul 2024 09:08:06 +0200
Message-ID: <87r0bghbqh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: soxiebing <soxiebing@163.com>
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	songxiebing <songxiebing@kylinos.cn>,
	bo liu <bo.liu@senarytech.com>
Subject: Re: [PATCH] ALSA: hda: conexant: Fix headset auto detect fail in the polling mode
In-Reply-To: <20240726012342.8645-1-soxiebing@163.com>
References: <20240726012342.8645-1-soxiebing@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.31 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 446271F871
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.31

On Fri, 26 Jul 2024 03:23:42 +0200,
soxiebing wrote:
> 
> From: songxiebing <songxiebing@kylinos.cn>
> 
> This patch(7aeb25908648) only handles the unsol_event reporting during

It should be rather "The previous fix (7aeb25908648)".  "This" points
the very patch you send now :)

> interrupts and does not include the polling mode used to set jackroll_ms,
> so now we are replacing it with snd_hda_jack_detect_enable_callback.
> 
> Fixes: 7aeb25908648 ("Fix headset auto detect fail in cx8070 and SN6140")

Don't drop "ALSA: hda/conexant:" prefix but copy the full subject line.

> Co-developed-by: bo liu <bo.liu@senarytech.com>

Usually Co-developed-by is followed by a Signed-off-by of that
author.

> Signed-off-by: songxiebing <songxiebing@kylinos.cn>

And, I noticed a typo in the patch that broke the compilation:

> -static void cx_update_headset_mic_vref(struct hda_codec *codec, unsigned int res)
> +static void cx_update_headset_mic_vref(struct hda_codec *codec, struct hda_jack_callback *event)
>  {
> -	unsigned int phone_present, mic_persent, phone_tag, mic_tag;
> -	struct conexant_spec *spec = codec->spec;
> +	unsigned int mic_persent;

... here.

Please make sure that the patch really works before submission.
Also, run scripts/checkpatch.pl for checking the coding style and the
patch formalities.


thanks,

Takashi

