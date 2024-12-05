Return-Path: <linux-kernel+bounces-432638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9115B9E4E02
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CDE1881778
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642EB1AAE09;
	Thu,  5 Dec 2024 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WBOcK7kV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iXQxUYbR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="15Wsd5K5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p5Nhgzku"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450852F56;
	Thu,  5 Dec 2024 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733382723; cv=none; b=kkw9BEJyoUpUIZMh2jHQu1j6Sr4V1NvGWashOmNcYZBi8Z9AXRJ2fZW0q8HfYphl0X3Y7zRvVZKlRcJkgjkh7Do2KBSxKDI7d3Pw/gL3QhAUkCHHjKHFPxlBwpuus9EndMleEbZ/ScHnAyIRN6NJu6lM3nGZigyc2t99LTzb9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733382723; c=relaxed/simple;
	bh=0bpD33XRjFRne0V6W5YWFwG6BOmSOn0iyQQ+B3LQJmw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCpgz8MEETKGqU3Z4C48gR22udVDh3qMD3MzLn3QwFMroXe8b0rWSZAmlm5FZeunhPMBeXDXyF99gGnv0MBnmnR3Odyn3Y3WjKt5qcor5rujFm0b4pug3EggdjS9+snenrQBjBLZ5VunLjlmcyPXqubNVqFWYc7doVeGtFOO3v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WBOcK7kV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iXQxUYbR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=15Wsd5K5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p5Nhgzku; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E361B1F7A3;
	Thu,  5 Dec 2024 07:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733382719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzmsmkeW9wwzcRCDWmqz9BsmyNkQRIT1C9+PvHmpY6I=;
	b=WBOcK7kVC5I2v2s3zWem/vpjihVz363aIPUUj/i7P9zZyQAhn1j9dhH/HffLgC0e11g1GD
	gD0BaioOH/GCbkJ3kk4b35mSe8IFi79ZNf+x0XvdgvvUA0pKwij3GMym/CcdyWdauxqv1C
	jByaBUGpUydL0YO8W5ti7CZISWx/LjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733382719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzmsmkeW9wwzcRCDWmqz9BsmyNkQRIT1C9+PvHmpY6I=;
	b=iXQxUYbRpBYq61M1AT0UosCTTjTmN0UFDQBNAtlIzED9CalfaCpvJwpKOowzl9uqMs8UNJ
	wTFu+HDuntMKg+Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733382718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzmsmkeW9wwzcRCDWmqz9BsmyNkQRIT1C9+PvHmpY6I=;
	b=15Wsd5K55gTDbT1HTgQk1imYIhO8CbcOldnshLZodIBb68fy/MbPLwcJuMmzoyRSLbJ60C
	YD2qFVgVVF7cbLBv07rNbArXLJJBaMN9hSqiz24Z4DA1iDgx3suN78EXn1gByfAntvW3ts
	nNay33wXp0PV3x9T+IHguODfgJQZzpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733382718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dzmsmkeW9wwzcRCDWmqz9BsmyNkQRIT1C9+PvHmpY6I=;
	b=p5NhgzkuwqsTQUGsacNoGwup+CkUotaHIT2hDTQsgf77ruT30tJxCUL3iOV3Fc2IDOV9Gu
	1/pCR9OOtQI6xMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2FE5132EB;
	Thu,  5 Dec 2024 07:11:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LjRqKj5SUWcWWQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 05 Dec 2024 07:11:58 +0000
Date: Thu, 05 Dec 2024 08:11:58 +0100
Message-ID: <87r06mvc1t.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 1/2] sound: usb: enable DSD output for ddHiFi TC44C
In-Reply-To: <20241204151954.658897-1-adrian.ratiu@collabora.com>
References: <20241204151954.658897-1-adrian.ratiu@collabora.com>
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
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Wed, 04 Dec 2024 16:19:53 +0100,
Adrian Ratiu wrote:
> 
> This is a UAC 2 DAC capable of raw DSD on intf 2 alt 4:
> 
> Bus 007 Device 004: ID 262a:9302 SAVITECH Corp. TC44C
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2 [unknown]
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x262a SAVITECH Corp.
>   idProduct          0x9302 TC44C
>   bcdDevice            0.01
>   iManufacturer           1 DDHIFI
>   iProduct                2 TC44C
>   iSerial                 6 5000000001
> .......
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       4
>       bNumEndpoints           2
>       bInterfaceClass         1 Audio
>       bInterfaceSubClass      2 Streaming
>       bInterfaceProtocol      32
>       iInterface              0
> 	AudioStreaming Interface Descriptor:
>           bLength                16
>           bDescriptorType        36
>           bDescriptorSubtype     1 (AS_GENERAL)
>           bTerminalLink          3
>           bmControls             0x00
>           bFormatType            1
>           bmFormats              0x80000000
>           bNrChannels            2
>           bmChannelConfig        0x00000000
>           iChannelNames          0
> .......
> 
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  sound/usb/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> index 00101875d9a8..4897d7de7529 100644
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -2265,6 +2265,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
>  		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
>  	DEVICE_FLG(0x154e, 0x300b, /* Marantz SA-KI RUBY / SA-12 */
>  		   QUIRK_FLAG_DSD_RAW),
> +	DEVICE_FLG(0x262a, 0x9302, /* ddHiFi TC44C */
> +		   QUIRK_FLAG_DSD_RAW),
>  	DEVICE_FLG(0x154e, 0x500e, /* Denon DN-X1600 */
>  		   QUIRK_FLAG_IGNORE_CLOCK_SOURCE),
>  	DEVICE_FLG(0x1686, 0x00dd, /* Zoom R16/24 */

The table is sorted in the ID number order.
Could you put it at the right position?


thanks,

Takashi

