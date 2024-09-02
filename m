Return-Path: <linux-kernel+bounces-310618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762E1967F27
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972471C21B3C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02340154BE4;
	Mon,  2 Sep 2024 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GJIdhNf4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ol2GGfqp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GJIdhNf4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ol2GGfqp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9876048;
	Mon,  2 Sep 2024 06:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725257368; cv=none; b=td09xgc99YnwM9TmF0/KWCk17c1Ds1xg3uqhv7W4wA+X+gxAhFVThD9UAC679T7TQ23Xe39y4JCF0feYQfRRF1/4MCqFL5YGhNLu+ocvpWrJBagHcpGLUCIPxh2exRMhoABbC5WfPgzPgk7TArg702eH1zxA3Ayr3+NjPcjh1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725257368; c=relaxed/simple;
	bh=80vzDC1M71YofRs8I41+2XUbnm/juJQahz6UdeElVhU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GB5FTgrpWhQE9TekagIv4os8qEJzk/hiW8rhCvRk8fruS/1L/labEpkbAgS4vWy5YjQkrQw5XvXMZvTfVibAhxErdcoEbcQUqM0tfjysujqerWTt3wv99JDXh38CalhaS2SEuhOIe6pv+uhzvaWhrvu3+klJG1gQ/XjRzyi6rKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GJIdhNf4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ol2GGfqp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GJIdhNf4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ol2GGfqp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6A191210FB;
	Mon,  2 Sep 2024 06:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725257364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJ0HGpSdKwTgjuO6ki3+u3E9/tO34Vc+A9OSsK9kFeU=;
	b=GJIdhNf4eF8O1Nz8Ryh6nI0JssjjhMoMFYbNY7uJ74LsMl+/hdOe7YAHez64D17Ocflbsu
	ylDvfsHkM6e6Mcgg0G6fUtVgIEc6AoIyP+3iQemS3wd1IsyG5kKlVRV8J3Qp5jWp/CzItp
	Twle0oQFRB1Pu+gTAyuum0ibKSAJWRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725257364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJ0HGpSdKwTgjuO6ki3+u3E9/tO34Vc+A9OSsK9kFeU=;
	b=ol2GGfqpNFZRnVn899+YElIXMK/FlNqIJeuSX9p9jbP8Iy8mR+RxnA8chG+Yw3AefzleFP
	6H6ejrlDrJA+pEDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725257364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJ0HGpSdKwTgjuO6ki3+u3E9/tO34Vc+A9OSsK9kFeU=;
	b=GJIdhNf4eF8O1Nz8Ryh6nI0JssjjhMoMFYbNY7uJ74LsMl+/hdOe7YAHez64D17Ocflbsu
	ylDvfsHkM6e6Mcgg0G6fUtVgIEc6AoIyP+3iQemS3wd1IsyG5kKlVRV8J3Qp5jWp/CzItp
	Twle0oQFRB1Pu+gTAyuum0ibKSAJWRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725257364;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LJ0HGpSdKwTgjuO6ki3+u3E9/tO34Vc+A9OSsK9kFeU=;
	b=ol2GGfqpNFZRnVn899+YElIXMK/FlNqIJeuSX9p9jbP8Iy8mR+RxnA8chG+Yw3AefzleFP
	6H6ejrlDrJA+pEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2018613AE5;
	Mon,  2 Sep 2024 06:09:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yWYpBpRW1WZgFwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 02 Sep 2024 06:09:24 +0000
Date: Mon, 02 Sep 2024 08:10:09 +0200
Message-ID: <8734mik2m6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Asahi Lina <lina@asahilina.net>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	"Geoffrey D. Bennett" <g@b4.vu>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Mark Hills <mark@xwax.org>,
	Arun Raghavan <arun@arunraghavan.net>,
	Cyan Nyan <cyan.vtb@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: usb-audio: Add quirk for RME Digiface USB
In-Reply-To: <20240902-rme-digiface-v1-1-6e88472a2744@asahilina.net>
References: <20240902-rme-digiface-v1-0-6e88472a2744@asahilina.net>
	<20240902-rme-digiface-v1-1-6e88472a2744@asahilina.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,b4.vu,sakamocchi.jp,xwax.org,arunraghavan.net,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -1.80
X-Spam-Flag: NO

On Sun, 01 Sep 2024 23:31:50 +0200,
Asahi Lina wrote:
> 
> From: Cyan Nyan <cyan.vtb@gmail.com>
> 
> Add trivial support for audio streaming on the RME Digiface USB. Binds
> only to the first interface to allow userspace to directly drive the
> complex I/O and matrix mixer controls.
> 
> Signed-off-by: Cyan Nyan <cyan.vtb@gmail.com>
> [Lina: Added 2x/4x sample rate support & boot/format quirks]
> Co-developed-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  sound/usb/quirks-table.h | 190 ++++++++++++++++++++++++++++++++++++++++++++++-
>  sound/usb/quirks.c       |  58 +++++++++++++++
>  2 files changed, 247 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
> index 73abc38a5400..47fd18791396 100644
> --- a/sound/usb/quirks-table.h
> +++ b/sound/usb/quirks-table.h
> @@ -4546,6 +4546,194 @@ YAMAHA_DEVICE(0x7010, "UB99"),
>  		}
>  	}
>  },
> -
> +{
> +	/* Only claim interface 0 */
> +	.match_flags = USB_DEVICE_ID_MATCH_VENDOR |
> +		       USB_DEVICE_ID_MATCH_PRODUCT |
> +		       USB_DEVICE_ID_MATCH_INT_CLASS |
> +		       USB_DEVICE_ID_MATCH_INT_NUMBER,
> +	.idVendor = 0x2a39,
> +	.idProduct = 0x3f8c,
> +	.bInterfaceClass = USB_CLASS_VENDOR_SPEC,
> +	.bInterfaceNumber = 0,
> +	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
> +		.ifnum = QUIRK_ANY_INTERFACE,
> +		.type = QUIRK_COMPOSITE,
(snip)

Recently the quirk tables are rewritten with macros.
See the commit d79e13f8e8abb5cd3a2a0f9fc9bc3fc750c5b06f
    ALSA: usb-audio: Replace complex quirk lines with macros
in for-next branch of sound.git tree.

Could you try to apply to your new entries, too?


thanks,

Takashi

