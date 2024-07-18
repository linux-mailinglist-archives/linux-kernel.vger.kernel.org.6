Return-Path: <linux-kernel+bounces-256496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12F8934F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BBE1C21D55
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC61428E6;
	Thu, 18 Jul 2024 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xfbJPynj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OFCdJaBu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xfbJPynj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OFCdJaBu"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAF812F5A1;
	Thu, 18 Jul 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313896; cv=none; b=XVQ7oFm/N/5vqOnB3vxeAK5wb3wpe8kfHUqXM9lTyrfiMWR2aRifvLpg1MHKBtGVH4jc3UNi9jWsm1oFytod/enaR4/KUB/K8Vy1De7eKyaQShA3RTgeACvKWkXx+6j5x80lZ1E22ANL6LrHPRq2ZUQRozLXhRV/YFka4/VfW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313896; c=relaxed/simple;
	bh=QOMftjxopqrdPolElgrkNok+9rZHCWk9f/wxM291T0c=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFd/2wzptf1Hs2GVhtHPBG4eEuh984BB6QcP7qC9FS89p3i2sZnEjmyZOvdcUu8MCmLhC8e/0aFxYWKZR8tlVFF1ALJMUcwf6Ub9liEAreAT+7iAiE1teyhxpK364YyC8vpSoN3x8UGMqoUAKu4brDGqvFyJ60kaQCLPBiIboSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xfbJPynj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OFCdJaBu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xfbJPynj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OFCdJaBu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63EFC1FBF1;
	Thu, 18 Jul 2024 14:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721313893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62UzqyHcb5qg23qSy74KPb+SpJCu5vHT+MajU0HqhhQ=;
	b=xfbJPynjEeer6VSEzkjPx5UdKyQGmUcMUw3kYTeobXfuBYsrz4x5FH0lEVGosGa9yAudHx
	czs9A0SXuUEAzeDolfhWPJTWISyyeI7LvQY/FdqkG5broW2uXXDOpzYu3kXtRKGbDubQFj
	As4LCUMxjme8z0yT+55Oo1yBYdXpams=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721313893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62UzqyHcb5qg23qSy74KPb+SpJCu5vHT+MajU0HqhhQ=;
	b=OFCdJaBuzfc4qDaFBqNR1YTui5KjNuFgl1u+pkoFDu4Q689xrP8mA23XIB25QO3VYB/Mow
	bLn86yfBe+kD6BCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721313893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62UzqyHcb5qg23qSy74KPb+SpJCu5vHT+MajU0HqhhQ=;
	b=xfbJPynjEeer6VSEzkjPx5UdKyQGmUcMUw3kYTeobXfuBYsrz4x5FH0lEVGosGa9yAudHx
	czs9A0SXuUEAzeDolfhWPJTWISyyeI7LvQY/FdqkG5broW2uXXDOpzYu3kXtRKGbDubQFj
	As4LCUMxjme8z0yT+55Oo1yBYdXpams=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721313893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=62UzqyHcb5qg23qSy74KPb+SpJCu5vHT+MajU0HqhhQ=;
	b=OFCdJaBuzfc4qDaFBqNR1YTui5KjNuFgl1u+pkoFDu4Q689xrP8mA23XIB25QO3VYB/Mow
	bLn86yfBe+kD6BCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F850136F7;
	Thu, 18 Jul 2024 14:44:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M59RDmUqmWYHHwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Jul 2024 14:44:53 +0000
Date: Thu, 18 Jul 2024 16:45:26 +0200
Message-ID: <87msmevjw9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Seunghun Han <kkamagui@gmail.com>
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book Pro 360
In-Reply-To: <20240718080908.8677-1-kkamagui@gmail.com>
References: <20240718080908.8677-1-kkamagui@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Thu, 18 Jul 2024 10:09:08 +0200,
Seunghun Han wrote:
> 
> Samsung Galaxy Book Pro 360 (13" 2022 NT935QDB-KC71S) with codec SSID
> 144d:c1a4 requires the same workaround to enable the speaker amp
> as other Samsung models with the ALC298 codec.
> 
> Signed-off-by: Seunghun Han <kkamagui@gmail.com>

Thanks, applied now.


Takashi

