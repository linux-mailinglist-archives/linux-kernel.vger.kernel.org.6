Return-Path: <linux-kernel+bounces-432643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026749E4E14
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4332188161B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6B11B0F02;
	Thu,  5 Dec 2024 07:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WZmXwyDx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1RzOLloa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WZmXwyDx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1RzOLloa"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA32D1AF0CA;
	Thu,  5 Dec 2024 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383077; cv=none; b=ajdW6hT2hZ9+DjYxgeMz2RRqYZl53f0sf0HH/4NjtcDU9mQ8DMx9KYFMgjw7ff49B9v+5ctMbFLX0csE3CfkgatWxlCiyfXFo++gAM09uQXJC0aAalfiyVOImn/ThsmAskU4jIUWAcrAKfxah4aWX6Zl3SodcUjUaD1WH8dcg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383077; c=relaxed/simple;
	bh=SsPbjv/HRX3XeUDyRp3ofVV+M7CM3ragOxDLii5KcVc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rW91Q7YNrEAr+hdw6fwwpoJpnuYav9xSFfh+SJ5beurxers1FH0boEvozx1gRJ8BZw07xXBH6ZEWyWzJ7Rr2uBpn+VH1ZYx99flm3o9QV66SSmPGi4KcOUM0qI78UyYkRamL/Vpjo7ZPLvuyQUdMNmKW7vm/Sdw0xHYtQIuBuzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WZmXwyDx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1RzOLloa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WZmXwyDx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1RzOLloa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A67FB211F1;
	Thu,  5 Dec 2024 07:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733383073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kzmBtrH8k11Y2CuCacfEPHHm1/ayZwA9S2/UcgigXpw=;
	b=WZmXwyDxko0FGSOl4PZkeSWZIs3QSfGxIZjrPCeZTnYTOVOcXHJroI4pvrzXycMLBOrsfy
	9Yvn4gSSLRhLnTbRX3pgkhJ3kaZy1qd0ujrFBKE2n7lKjCVHrGIbTG604T2ZZuEd/PPOES
	WHa7fMYBDUeHWfZWuvpkutyoPJbTuwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733383073;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kzmBtrH8k11Y2CuCacfEPHHm1/ayZwA9S2/UcgigXpw=;
	b=1RzOLloamMWeZx52/0jUJJj98XuOThho8G6bStvXw42LYlc0eCGTz+DvUuVc28UellOerd
	apju6X2xI9WAshAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733383073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kzmBtrH8k11Y2CuCacfEPHHm1/ayZwA9S2/UcgigXpw=;
	b=WZmXwyDxko0FGSOl4PZkeSWZIs3QSfGxIZjrPCeZTnYTOVOcXHJroI4pvrzXycMLBOrsfy
	9Yvn4gSSLRhLnTbRX3pgkhJ3kaZy1qd0ujrFBKE2n7lKjCVHrGIbTG604T2ZZuEd/PPOES
	WHa7fMYBDUeHWfZWuvpkutyoPJbTuwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733383073;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kzmBtrH8k11Y2CuCacfEPHHm1/ayZwA9S2/UcgigXpw=;
	b=1RzOLloamMWeZx52/0jUJJj98XuOThho8G6bStvXw42LYlc0eCGTz+DvUuVc28UellOerd
	apju6X2xI9WAshAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D6D2132EB;
	Thu,  5 Dec 2024 07:17:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7eJhGaFTUWeRWgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 05 Dec 2024 07:17:53 +0000
Date: Thu, 05 Dec 2024 08:17:53 +0100
Message-ID: <87plm6vbry.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 2/2] sound: usb: format: don't warn that raw DSD is unsupported
In-Reply-To: <20241204151954.658897-2-adrian.ratiu@collabora.com>
References: <20241204151954.658897-1-adrian.ratiu@collabora.com>
	<20241204151954.658897-2-adrian.ratiu@collabora.com>
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
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Wed, 04 Dec 2024 16:19:54 +0100,
Adrian Ratiu wrote:
> 
> UAC 2 & 3 DAC's set bit 31 of the format to signal support for a
> RAW_DATA type, typically used for DSD playback.
> 
> This is correctly tested by (format & UAC*_FORMAT_TYPE_I_RAW_DATA),
> fp->dsd_raw = true; and call snd_usb_interface_dsd_format_quirks(),
> however a confusing and unnecessary message gets printed because
> the bit is not properly tested in the last "unsupported" if test.
> 
> For example:
> 
> usb 7-1: new high-speed USB device number 5 using xhci_hcd
> usb 7-1: New USB device found, idVendor=262a, idProduct=9302, bcdDevice=0.01
> usb 7-1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
> usb 7-1: Product: TC44C
> usb 7-1: Manufacturer: TC44C
> usb 7-1: SerialNumber: 5000000001
> hid-generic 0003:262A:9302.001E: No inputs registered, leaving
> hid-generic 0003:262A:9302.001E: hidraw6: USB HID v1.00 Device [DDHIFI TC44C] on usb-0000:08:00.3-1/input0
> usb 7-1: 2:4 : unsupported format bits 0x100000000
> 
> This last "unsupported format" is actually wrong: we know the
> format is a RAW_DATA which we assume is DSD, so there is no need
> to print the confusing message.
> 
> Thus we update the condition to take into account bit 31 for DSD
> (notice the "format <<= 1;" line above).
> 
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>

IMO, it's better to clear the already checked format bit instead, as
there are two distinct bits depending on the protocol.
That is, something like:

--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -54,6 +54,7 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 
 		if (format & UAC2_FORMAT_TYPE_I_RAW_DATA) {
 			pcm_formats |= SNDRV_PCM_FMTBIT_SPECIAL;
+			format &= ~UAC2_FORMAT_TYPE_I_RAW_DATA;
 			/* flag potentially raw DSD capable altsettings */
 			fp->dsd_raw = true;
 		}
@@ -67,8 +68,10 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
 		sample_width = as->bBitResolution;
 		sample_bytes = as->bSubslotSize;
 
-		if (format & UAC3_FORMAT_TYPE_I_RAW_DATA)
+		if (format & UAC3_FORMAT_TYPE_I_RAW_DATA) {
 			pcm_formats |= SNDRV_PCM_FMTBIT_SPECIAL;
+			format &= ~UAC3_FORMAT_TYPE_I_RAW_DATA;
+		}
 
 		format <<= 1;
 		break;


thanks,

Takashi


> ---
>  sound/usb/format.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/usb/format.c b/sound/usb/format.c
> index 0cbf1d4fbe6e..fe2e0580e296 100644
> --- a/sound/usb/format.c
> +++ b/sound/usb/format.c
> @@ -142,7 +142,7 @@ static u64 parse_audio_format_i_type(struct snd_usb_audio *chip,
>  		pcm_formats |= SNDRV_PCM_FMTBIT_A_LAW;
>  	if (format & BIT(UAC_FORMAT_TYPE_I_MULAW))
>  		pcm_formats |= SNDRV_PCM_FMTBIT_MU_LAW;
> -	if (format & ~0x3f) {
> +	if (format & ~0x10000003F) {
>  		usb_audio_info(chip,
>  			 "%u:%d : unsupported format bits %#llx\n",
>  			 fp->iface, fp->altsetting, format);
> -- 
> 2.45.2
> 

