Return-Path: <linux-kernel+bounces-256497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407BF934F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF512810C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C2E1419BA;
	Thu, 18 Jul 2024 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qjGuezHe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h6xBmlay";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qjGuezHe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h6xBmlay"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0718E2AF18
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313960; cv=none; b=u3l7Hll3jdBE1gSwyg6MdKDFiyaYExjfiwQPSB+y6F13dhm3vPb0QMOq9HnyFWbpb5GmemkuRM7w2oS4AMIB5SAG9jgF2sUKPmLNzHhyH4DQGf6l2Wx0PoR5KeI1u5g3bs/PaFSzRO1vmX5/jb6EJdTyc83sI+mQ+BU2Jlign7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313960; c=relaxed/simple;
	bh=jKKPfmiq1BZstorpqgUaWt3UtIZEC4y7SGOw3fnh27I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlyYBIK32IyOt/2eIkzGDCxO3SinaaXgNOtpJytj5vqblELwDLMgvjKRP6Pty4DzduZ9DeBWbuCenVK+foMwnIKwlxbcWBSxu3+fsrznuM/XTLgj4p/Bfss/iC+DLkaFUaQwRRSRXdAYFcMwip0dHasys64bhlV6GufCgUTqK/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qjGuezHe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h6xBmlay; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qjGuezHe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h6xBmlay; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1C4361FBF2;
	Thu, 18 Jul 2024 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721313957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKlk4dAQ+4CO151rlnqHradhM/+S38g4Bf/PHUpYSmE=;
	b=qjGuezHetbAGlWQ7IuReyBTRFSjuFNFwsWj7TMvV+IXL52czlv2Ua1iL2jkgkhauJztIzU
	vdLXbSbNPrLSUIy28LA4zl1iD9knfqBKaUnXDB8kKu/t29sFqXg1lV4uecSBZEhwwGxEFC
	vt/l0IaKUhdCOvfIiF543Po1dWSILvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721313957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKlk4dAQ+4CO151rlnqHradhM/+S38g4Bf/PHUpYSmE=;
	b=h6xBmlay97b8FQBKERtJesp/Uj4+moco/A+wm2vOdmxCcwDiaxDu1MFT6+Fv/lWRHutFU6
	cN6Xi4t1MpgpqrBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qjGuezHe;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=h6xBmlay
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721313957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKlk4dAQ+4CO151rlnqHradhM/+S38g4Bf/PHUpYSmE=;
	b=qjGuezHetbAGlWQ7IuReyBTRFSjuFNFwsWj7TMvV+IXL52czlv2Ua1iL2jkgkhauJztIzU
	vdLXbSbNPrLSUIy28LA4zl1iD9knfqBKaUnXDB8kKu/t29sFqXg1lV4uecSBZEhwwGxEFC
	vt/l0IaKUhdCOvfIiF543Po1dWSILvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721313957;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JKlk4dAQ+4CO151rlnqHradhM/+S38g4Bf/PHUpYSmE=;
	b=h6xBmlay97b8FQBKERtJesp/Uj4+moco/A+wm2vOdmxCcwDiaxDu1MFT6+Fv/lWRHutFU6
	cN6Xi4t1MpgpqrBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1026136F7;
	Thu, 18 Jul 2024 14:45:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TlXeMaQqmWZvHwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Jul 2024 14:45:56 +0000
Date: Thu, 18 Jul 2024 16:46:30 +0200
Message-ID: <87le1yvjuh.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v2] ALSA: usb-audio: Fix microphone sound on HD webcam.
In-Reply-To: <20240718060756.15322-1-wangdich9700@163.com>
References: <20240718060756.15322-1-wangdich9700@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 1C4361FBF2
X-Spam-Flag: NO
X-Spam-Score: 0.49
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,vger.kernel.org,alsa-project.org,lists.infradead.org,kylinos.cn];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Thu, 18 Jul 2024 08:07:56 +0200,
wangdicheng wrote:
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
> ---
> V1 -> V2: align the space,Update code to v6.8-rc3,and make modifications based on it

Just one minor issue: the mail address of your Signed-off-by is
different from the From address.  Try to make them consistent.


thanks,

Takashi

