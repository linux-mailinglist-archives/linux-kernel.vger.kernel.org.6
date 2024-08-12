Return-Path: <linux-kernel+bounces-283004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E9594EBC1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650401C2148C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4E4174EE7;
	Mon, 12 Aug 2024 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="naDqM2r3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DDc9XxgE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="naDqM2r3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DDc9XxgE"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1627130495;
	Mon, 12 Aug 2024 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461987; cv=none; b=iNemuiqdDoUjMOw+MZgl+hoGuzPuD0f04AjsoMfSDZUpTUMmszHX1lxEZYo4Rxhzv1FbfY0UoNqEvx7Wp5xyB4uXfUfeXHcZmzQMQdmJB+20dce/rLpacE0IPSs1IKsUrBGbnPWwffToBaea9cCE9J4L00r89YppoQbtYBRf53o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461987; c=relaxed/simple;
	bh=y8AnY0w3xhCC8neb3MrGBLnwuyNZ42E3p1kCNXQVsdE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJvySt9FaGf+5H4c/pT8hj4lTbXBR+JA8lHGf+lfSsp53yc5d+NGxOKSE/5nuTkf61EImmaiVjVJ6ngT5zYRqoK1pPtFW7EBrjkX8RZ2Tgd24PwPKs4PUPsoTzjK/QU2sArGCn674gYcrLtjPOHiWFMYdIugEPyS3YcNq+RSH0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=naDqM2r3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DDc9XxgE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=naDqM2r3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DDc9XxgE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B1A32026B;
	Mon, 12 Aug 2024 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723461983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khiFf9SIP2ZezIcDk+ksvyeFueV9sc4yutkPxw8YTgI=;
	b=naDqM2r3tf69bqrV8/R9VzeApHvRoVzBkFxm1+4/1gtfp0VpU1rolQHBQVM0xm/hO3r822
	BNnP/H/cj+FT9Ztwjwa0swKE9mYkHYWYss2GoK41ExPhVFFKdQHwMKFVxctP/W3nn7vt/7
	6VQDpjXvb0VOuQg3eI9G7iFASfoBF8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723461983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khiFf9SIP2ZezIcDk+ksvyeFueV9sc4yutkPxw8YTgI=;
	b=DDc9XxgEejJK42DXPEFiQ2ROJaGB/lPGiBsg/ARB79gn3iYNkozkGlKYbJ6kW7fRToSQhy
	NGP0B+5LNOtgYUBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723461983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khiFf9SIP2ZezIcDk+ksvyeFueV9sc4yutkPxw8YTgI=;
	b=naDqM2r3tf69bqrV8/R9VzeApHvRoVzBkFxm1+4/1gtfp0VpU1rolQHBQVM0xm/hO3r822
	BNnP/H/cj+FT9Ztwjwa0swKE9mYkHYWYss2GoK41ExPhVFFKdQHwMKFVxctP/W3nn7vt/7
	6VQDpjXvb0VOuQg3eI9G7iFASfoBF8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723461983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khiFf9SIP2ZezIcDk+ksvyeFueV9sc4yutkPxw8YTgI=;
	b=DDc9XxgEejJK42DXPEFiQ2ROJaGB/lPGiBsg/ARB79gn3iYNkozkGlKYbJ6kW7fRToSQhy
	NGP0B+5LNOtgYUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 927C7137BA;
	Mon, 12 Aug 2024 11:26:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id asF1Il7xuWaYVAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 12 Aug 2024 11:26:22 +0000
Date: Mon, 12 Aug 2024 13:27:02 +0200
Message-ID: <87cymedlrt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Jonathan LoBue <jlobue10@gmail.com>,
	perex@perex.cz,
	tiwai@suse.com,
	shenghao-ding@ti.com,
	kailang@realtek.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	derekjohn.clark@gmail.com,
	luke@ljones.dev,
	benato.denis96@gmail.com,
	Kyle Gospodnetich <me@kylegospodneti.ch>,
	Jan Drogehoff <sentrycraft123@gmail.com>,
	Richard Alvarez <alvarez.richard@gmail.com>,
	Miles Montierth <cyber_dopamine@intheblackmedia.com>,
	"Chen, Robin" <robinchen@ti.com>
Subject: Re: [PATCH] ALSA: hda/realtek: tas2781: Fix ROG ALLY X audio
In-Reply-To: <CAGwozwF7aR5UypRTe7tNFR+xOfQ=rhqkzYUgBcYH4_LvO9_zXQ@mail.gmail.com>
References: <20240812045325.47736-1-jlobue10@gmail.com>
	<87frra2ocp.wl-tiwai@suse.de>
	<CAGwozwF7aR5UypRTe7tNFR+xOfQ=rhqkzYUgBcYH4_LvO9_zXQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.60
X-Spamd-Result: default: False [-1.60 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,perex.cz,suse.com,ti.com,realtek.com,alsa-project.org,vger.kernel.org,ljones.dev,kylegospodneti.ch,intheblackmedia.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 12 Aug 2024 09:45:59 +0200,
Antheas Kapenekakis wrote:
> 
> Hi,
> I have spoken with Shenghao and Robin Chen (who I CC) from Texas Instruments.
> 
> There is no such thing as TAS2XXX1EB3. For Ally X, there are two firmware files:
> TAS2XXX1EB30 and TAS2XXX1EB31. Both are licensed with GPL
> according to Shenghao.
> 
> Since the linux driver has no concept of the 0 and 1 suffix, I propose
> we symlink the
> 0 one to TAS2XXX1EB3. If required, the driver can be augmented in the future
> to either choose the 0 or 1 file.

Yes, symlinking in linux-firmware tree makes sense.
It's just a matter of a line in WHENCE file, after all.


Takashi

