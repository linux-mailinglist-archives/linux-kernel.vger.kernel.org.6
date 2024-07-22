Return-Path: <linux-kernel+bounces-258965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D9F938F3D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6795B1F21D64
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5DE16CD35;
	Mon, 22 Jul 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YodbXtWz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eFIUdsPP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RvDrWgVF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dbSQVP1h"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBEF3AC36
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721652319; cv=none; b=LJZsYyffb+hgsaVcPjVEQf/FWtsEsfTswMpkTlwXM6NH8I4NvM3t5a51g54w20DXLgzEmeoJHBMJGqK2AJG3BhWxDPmXnChZQl8JfRfxpeCSqRkzTsGnoG96n7rnj7Vsg0hdF6rBs4Pqbl9XJIvyfPQC/kV5Lz2R+to2Q9+niQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721652319; c=relaxed/simple;
	bh=kuaQwPMati7m35nPk4I2tMuXSmbSKoGY0kQGQdeFVQI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSOWMWT6VL4p+917vsSAcOVhuRLenS5iCGEY7TuoPzaxNNwmw4M4+Stu2eESwWXSL0xYCalNYgBNXOWBXkghR1MSvCAoaETZOUblTR+vY32fWdhSM0J0YQIHWUV7vd0M6bjvxZIRIMBRAuWOETN+L5H2ls5K6T1dL40A08czcfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YodbXtWz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eFIUdsPP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RvDrWgVF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dbSQVP1h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED9B71FB6C;
	Mon, 22 Jul 2024 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721652316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/etjPssqXa/0nw7ISXY16x5fVisX+gbyQ66tS2GbOII=;
	b=YodbXtWzJ5c4pOmbh5tCX6X2dDtenyzhOKfQUplqCUGguYKyH5cQ+C8L8S6W+RPVnWiSnY
	DSJ/EnExuKjSgjPgu+SGYzGU9HEw/XtmGOeRBqKb/oSDN2pwNKk7TSAhU/PKbSAxpqEvck
	d+LPoSS2I4QXxqID1zYv5c5/zTuYVyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721652316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/etjPssqXa/0nw7ISXY16x5fVisX+gbyQ66tS2GbOII=;
	b=eFIUdsPPcw+ndDmv4DHB2OdlNwr7lFtvkkBrBT32Zze3SxYZvI76S1kQcE927AGG8p7VYJ
	kd7J8ytnWbn2h8Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721652315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/etjPssqXa/0nw7ISXY16x5fVisX+gbyQ66tS2GbOII=;
	b=RvDrWgVFhs3Oro3DEfs0oWo0WDYCDCS8v5NdVytwCRyLEhAnmSa7rLStJ+EL9f6IkZYsq5
	fCI7wqzB73zbXHPXd/0DAU2UpNKdvme553lBFpbZB+6ZVSYLSSML+ttbWjKjz63kg+etxH
	394TXTRhUJPubY4TSuKf7OUDF+tb1iM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721652315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/etjPssqXa/0nw7ISXY16x5fVisX+gbyQ66tS2GbOII=;
	b=dbSQVP1hau4I5q9Iw6a45CFR7odqRqiVJWA32I5Ue5l6ewG/IhMt3rB1Oyf3j56Rb8hU1o
	JR6H6OuQyy3O3OCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B01BD13A2D;
	Mon, 22 Jul 2024 12:45:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C7bFKVtUnmY1KgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 22 Jul 2024 12:45:15 +0000
Date: Mon, 22 Jul 2024 14:45:49 +0200
Message-ID: <871q3lppc2.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v3] ALSA: usb-audio: Add a quirk for Sonix HD USB Camera
In-Reply-To: <20240722084822.31620-1-wangdich9700@163.com>
References: <20240722084822.31620-1-wangdich9700@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.10
X-Spamd-Result: default: False [-3.10 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,perex.cz,suse.com,vger.kernel.org,alsa-project.org,lists.infradead.org,kylinos.cn];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On Mon, 22 Jul 2024 10:48:22 +0200,
wangdicheng wrote:
> 
> From: wangdicheng <wangdicheng@kylinos.cn>
> 
> Sonix HD USB Camera does not support reading the sample rate which leads
> to many lines of "cannot get freq at ep 0x84".
> This patch adds the USB ID to quirks.c and avoids those error messages.
> 
> (snip)
> [1.789698] usb 3-3: new high-speed USB device number 2 using xhci_hcd
> [1.984121] usb 3-3: New USB device found, idVendor=0c45, idProduct=6340, bcdDevice= 0.00
> [1.984124] usb 3-3: New USB device strings: Mfr=2, Product=1, SerialNumber=0
> [1.984127] usb 3-3: Product: USB 2.0 Camera
> [1.984128] usb 3-3: Manufacturer: Sonix Technology Co., Ltd.
> [5.440957] usb 3-3: 3:1: cannot get freq at ep 0x84
> [12.130679] usb 3-3: 3:1: cannot get freq at ep 0x84
> [12.175065] usb 3-3: 3:1: cannot get freq at ep 0x84
> 
> Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
> ---
> v2 -> v3: Update the insertion order of ID 0c45
> v1 -> v2: Arrange the ID in order

Thanks, applied now.


Takashi

