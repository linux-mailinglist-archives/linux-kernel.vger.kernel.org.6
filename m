Return-Path: <linux-kernel+bounces-254908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84569933924
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6F42825EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFB438DD3;
	Wed, 17 Jul 2024 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="boTGgg0K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aSgdXuRK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="boTGgg0K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aSgdXuRK"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC1C10953
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205382; cv=none; b=iWCXFaP5YQzW273MUOwIqGEt91ZLXGDTG7hFVTzD5JhM8BjlEXt9SZoy91FzHywdyD9ao9ZcKx28DPMnnyH76QF369iOnhc7qFhLPZmNj1lCIlveyFwS3jBMJRik3ySm1zeT66YrUFIFFwxfHcgbf/Y2xoQ3h8cnI9jfGAnRl2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205382; c=relaxed/simple;
	bh=rU8hrnUMFC5mTjGXwT69mTGZCmwGdQmcdTJONifb6RA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7fbuyrV0uPGPPwjUASrxttFlRfzjCWSfaHPQloVS+JTI32loIilNVdfUFfqZO3SH/azahSbxRyyQR4uc9eG1ChHJStTk76sG2q2yUxFk6E+8+Ikdrix6BGM5qUleWSDauNTH1NXkJOYN6HBvfYOKUYwn+kbLiKYbBq43NUfSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=boTGgg0K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aSgdXuRK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=boTGgg0K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aSgdXuRK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9829221B85;
	Wed, 17 Jul 2024 08:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721205378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKgkHUOShYpcIArnsFP6wIH0whExRvHJmj2Dadz/tkA=;
	b=boTGgg0KSt6MO5Fa6epB7oYdSqc5p5DEanPLyaVB8xtpPnXnpllmronLtStuWEuyS7CbpD
	kz6xYCAhms+JRk1dgXenuRW6a0geeGiIyPn8reV9rgmz/m71DqDXJiUDbguflafDVVovi+
	RzwcH0YJvYCasQIX4LYEJ657P9BbGKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721205378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKgkHUOShYpcIArnsFP6wIH0whExRvHJmj2Dadz/tkA=;
	b=aSgdXuRKdDmVT4ll2RhzQWpJ6yLKzDewOOGjdw19mqhhGpH5CNh60/1Z0VupI16+1Syy8h
	5k66ejFhhBmPaSBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=boTGgg0K;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aSgdXuRK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721205378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKgkHUOShYpcIArnsFP6wIH0whExRvHJmj2Dadz/tkA=;
	b=boTGgg0KSt6MO5Fa6epB7oYdSqc5p5DEanPLyaVB8xtpPnXnpllmronLtStuWEuyS7CbpD
	kz6xYCAhms+JRk1dgXenuRW6a0geeGiIyPn8reV9rgmz/m71DqDXJiUDbguflafDVVovi+
	RzwcH0YJvYCasQIX4LYEJ657P9BbGKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721205378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WKgkHUOShYpcIArnsFP6wIH0whExRvHJmj2Dadz/tkA=;
	b=aSgdXuRKdDmVT4ll2RhzQWpJ6yLKzDewOOGjdw19mqhhGpH5CNh60/1Z0VupI16+1Syy8h
	5k66ejFhhBmPaSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 512691368F;
	Wed, 17 Jul 2024 08:36:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CMyOEoKCl2acFQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 17 Jul 2024 08:36:18 +0000
Date: Wed, 17 Jul 2024 10:36:51 +0200
Message-ID: <87zfqgxvmk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: wangdicheng <wangdich9700@163.com>
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: Re: [PATCH] ALSA: usb-audio: Fix microphone sound on HD webcam.
In-Reply-To: <20240717075149.6915-1-wangdich9700@163.com>
References: <20240717075149.6915-1-wangdich9700@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,vger.kernel.org,alsa-project.org,lists.infradead.org,kylinos.cn];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 9829221B85

On Wed, 17 Jul 2024 09:51:49 +0200,
wangdicheng wrote:
> 
> From: wangdicheng <wangdicheng@kylinos.cn>
> 
> I own an external usb Webcam, HD webcam, which had low mic volume and
> inconsistent sound quality. Video works as expected.
> 
> (snip)
> [   95.473820][ 1] [   T73] usb 5-2.2: new high-speed USB device number 7 using xhci_hcd
> [   95.773974][ 1] [   T73] usb 5-2.2: New USB device found, idVendor=1bcf, idProduct=2281, bcdDevice= 0.05
> [   95.783445][ 1] [   T73] usb 5-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   95.791872][ 1] [   T73] usb 5-2.2: Product: HD webcam
> [   95.797001][ 1] [   T73] usb 5-2.2: Manufacturer: Sunplus IT Co
> [   95.802996][ 1] [   T73] usb 5-2.2: SerialNumber: 20200513
> [   96.092610][ 2] [ T3680] usb 5-2.2: Warning! Unlikely big volume range (=4096), cval->res is probably wrong.
> [   96.102436][ 2] [ T3680] usb 5-2.2: [5] FU [Mic Capture Volume] ch = 1, val = 0/4096/1
> 
> Set up quirk cval->res to 16 for 256 levels,
> Set GET_SAMPLE_RATE quirk flag to stop trying to get the sample rate.
> Confirmed that happened anyway later due to the backoff mechanism,
> After 3 failures.
> 
> All audio stream on device interfaces share the same values,
> apart from wMaxPacketSize and tSamFreq :
> 
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       4
>       bNumEndpoints           1
>       bInterfaceClass         1 Audio
> 
> Interface Descriptor:
>   bLength                 9
>   bDescriptorType         4
>   bInterfaceNumber        3
>   bAlternateSetting       4
>   bNumEndpoints           1
>   bInterfaceClass         1 Audio
>   bInterfaceSubClass      2 Streaming
>   bInterfaceProtocol      0
>   iInterface              0
>   AudioStreaming Interface Descriptor:
>     bLength                 7
>     bDescriptorType        36
>     bDescriptorSubtype      1 (AS_GENERAL)
>     bTerminalLink           3
>     bDelay                  1 frames
>     wFormatTag         0x0001 PCM
>   AudioStreaming Interface Descriptor:
>     bLength                11
>     bDescriptorType        36
>     bDescriptorSubtype      2 (FORMAT_TYPE)
>     bFormatType             1 (FORMAT_TYPE_I)
>     bNrChannels             1
>     bSubframeSize           2
>     bBitResolution         16
>     bSamFreqType            1 Discrete
>     tSamFreq[ 0]        48000
>   Endpoint Descriptor:
>     bLength                 9
>     bDescriptorType         5
>     bEndpointAddress     0x86  EP 6 IN
>     bmAttributes            5
>       Transfer Type            Isochronous
>       Synch Type               Asynchronous
>       Usage Type               Data
>     wMaxPacketSize     0x0064  1x 100 bytes
>     bInterval               4
>     bRefresh                0
>     bSynchAddress           0
>     AudioStreaming Endpoint Descriptor:
>       bLength                 7
>       bDescriptorType        37
>       bDescriptorSubtype      1 (EP_GENERAL)
>       bmAttributes         0x01
>         Sampling Frequency
>       bLockDelayUnits         0 Undefined
>       wLockDelay         0x0000
> (snip)
> 
> Testing patch provides consistent good sound recording quality and volume range.
> 
> (snip)
> [   95.473820][ 1] [   T73] usb 5-2.2: new high-speed USB device number 7 using xhci_hcd
> [   95.773974][ 1] [   T73] usb 5-2.2: New USB device found, idVendor=1bcf, idProduct=2281, bcdDevice= 0.05
> [   95.783445][ 1] [   T73] usb 5-2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   95.791872][ 1] [   T73] usb 5-2.2: Product: HD webcam
> [   95.797001][ 1] [   T73] usb 5-2.2: Manufacturer: Sunplus IT Co
> [   95.802996][ 1] [   T73] usb 5-2.2: SerialNumber: 20200513
> [   96.110630][ 3] [ T3680] usbcore: registered new interface driver snd-usb-audio
> [   96.114329][ 7] [ T3677] usb 5-2.2: Found UVC 1.00 device HD webcam (1bcf:2281)
> [   96.167555][ 7] [ T3677] usbcore: registered new interface driver uvcvideo
> 
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>

The patch can't be applied cleanly to the latest tree, as the table
has been sorted.  Could you rebase and resubmit?  Also a nitpicking:

> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -2179,6 +2179,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
>  		   QUIRK_FLAG_FIXED_RATE),
>  	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
>  		   QUIRK_FLAG_GET_SAMPLE_RATE),
> +	DEVICE_FLG(0x1bcf, 0x2281, /* FHD Webcam */
> +			QUIRK_FLAG_GET_SAMPLE_RATE),

Please try to align the space.


thanks,

Takashi

