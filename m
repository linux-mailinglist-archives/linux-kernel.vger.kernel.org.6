Return-Path: <linux-kernel+bounces-437137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666059E8F85
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D11618B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F66C2163B9;
	Mon,  9 Dec 2024 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D5ewRz26";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w4kuAKxZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D5ewRz26";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w4kuAKxZ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2362E215180;
	Mon,  9 Dec 2024 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738384; cv=none; b=elKeYteRIRzaNLHj2r4SvqpGHNkGtojbrLpWJYohzHNL2v5co/2ju4Gfj281DPZiYuSFbPY+n3xAbp/o6EJGauqYsAlgTQYJ8++PSQjrLwyo54RLYXtzpb7P9eF+d8Xll/T2W3sGeqHDpNghnU4/G7RYKyqUP+CVHId88n3JMEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738384; c=relaxed/simple;
	bh=sK/rGZOH9vbKwqQVsijN/B60nAs93P0rosC2g+OCp9Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IAKzu9m6CTNm6q4i5J1Fd1RUaItjfLTQ2fgycc7cRLthMGe30/CdTQzzvFTofpbnpmAfG3+G2qACab2jDIK6ngOduYxdhIunUHMYZfDO62K+SdQSPvyfjX5/2h7DbtXOl8W8HoZG25tVXlzX4jtmfU1Lw1Gob+y+iwOra3RdRRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D5ewRz26; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w4kuAKxZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D5ewRz26; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w4kuAKxZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E3171F45F;
	Mon,  9 Dec 2024 09:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733738381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MuTMRL8U7AT+lFjCTobj8ruT+PLMF5MKHBpXYVGvKWQ=;
	b=D5ewRz26gNuX0eRQGdVsy3vXibDTE4PO+1Ik9QwVP4JY2m1Je4MV0k8ERsdBc3caw6A4Je
	OwGLOzyCWE85Mt/YQey9Fn6JnorWT81bv9XEDV331INqO6z7PB5hMyEVJKZyjw0rRYg/t+
	9FrH3BInnOhlHMmM76Qb4IqmNbHrlZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733738381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MuTMRL8U7AT+lFjCTobj8ruT+PLMF5MKHBpXYVGvKWQ=;
	b=w4kuAKxZEV3dGYiYnxgvtzihRxJFH/3SnuhMVyYdfSqPufa1j/N1CqnYgDGHdlMWHZtqp5
	cmdFM3qgJllD7dAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733738381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MuTMRL8U7AT+lFjCTobj8ruT+PLMF5MKHBpXYVGvKWQ=;
	b=D5ewRz26gNuX0eRQGdVsy3vXibDTE4PO+1Ik9QwVP4JY2m1Je4MV0k8ERsdBc3caw6A4Je
	OwGLOzyCWE85Mt/YQey9Fn6JnorWT81bv9XEDV331INqO6z7PB5hMyEVJKZyjw0rRYg/t+
	9FrH3BInnOhlHMmM76Qb4IqmNbHrlZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733738381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MuTMRL8U7AT+lFjCTobj8ruT+PLMF5MKHBpXYVGvKWQ=;
	b=w4kuAKxZEV3dGYiYnxgvtzihRxJFH/3SnuhMVyYdfSqPufa1j/N1CqnYgDGHdlMWHZtqp5
	cmdFM3qgJllD7dAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A7EA138D2;
	Mon,  9 Dec 2024 09:59:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qe47AY2/VmcNKwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 09 Dec 2024 09:59:41 +0000
Date: Mon, 09 Dec 2024 10:59:40 +0100
Message-ID: <87v7vt5g8j.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v2 1/2] sound: usb: enable DSD output for ddHiFi TC44C
In-Reply-To: <20241209090529.16134-1-adrian.ratiu@collabora.com>
References: <20241209090529.16134-1-adrian.ratiu@collabora.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 09 Dec 2024 10:05:28 +0100,
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

Applied both patches now.  Thanks.


Takashi

