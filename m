Return-Path: <linux-kernel+bounces-174265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C28538C0C52
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FAD2B2244F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B714B149DE5;
	Thu,  9 May 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bb/8n/y1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ui0kQ/Gs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kEF1Qade";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3MeOmRFc"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87727149C6D;
	Thu,  9 May 2024 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242442; cv=none; b=eJdoLslLo1t7y8mANMy8FwBTc7XUhAl07ZRLkz2oDkAY4hSsTI8U774howqXqtmnGuHdvLKMOQ3TPDQ5k7haNpVjCAwe7NycDksoeuQlRSJcq8P+ID1dKFApcx800PWFFaBQXlV8/1SUaO4CqTBlM9a5sCkiNwIXgCcJNTo0Sf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242442; c=relaxed/simple;
	bh=C1+cC2PmS3JnHtCEEjDWYLV1Z0/biU7APqqmr/1IrIE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOYUVZXtP9QQIqoNmc8MZ/4IMqJOpncnh/tiQU0L+8vFpZnXEsjS7ivl2qhzjR+8pEx/MVOPZ8lqOQ50teZwlH2sZltvAseoEAN5lyGJxN8ydivfVv+LFQQDcqTLH4nuV8zBQV58vM9Swgsdzk9gIpg/U24eOgb3zE6x1xAhrr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bb/8n/y1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ui0kQ/Gs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kEF1Qade; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3MeOmRFc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51FDA5FA72;
	Thu,  9 May 2024 08:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715242438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1Wu7N6byPVboE3rdUC7zL9Eq6yvwdKjLQ5dDI/khmk=;
	b=Bb/8n/y19pz+BlZP9keaWv0I0MKuotzdlQ75FhZcop6w34fGAYcMUeR7nVR1uPJzvz5JTb
	ljt+xXTFM42MRv8k6ZObNPjLAyGeQnBJhtibFs+kXX6te9sBsYkINPDcUN7ZYsrQOPAXcD
	KoTkOm11YMoBB6QhaeFRlddsVqwYFuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715242438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1Wu7N6byPVboE3rdUC7zL9Eq6yvwdKjLQ5dDI/khmk=;
	b=ui0kQ/Gslkq0wssH4iiB/zeULPKhAGOHCyYMeXHtl6bewkUHtFzgCTw5T3jVqo7a8lybIw
	p3vpi5uomoLAOHDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715242437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1Wu7N6byPVboE3rdUC7zL9Eq6yvwdKjLQ5dDI/khmk=;
	b=kEF1QadeyYYTa5HsIR0q6rtROnea4eBJayIQhjk7qkcPezJgJF5as6P2FMr3xLc8Xq76mU
	m+xOjUkdT86vmij56s6YyX+g57i3Fxmsh4bMdAFdcPu3NwbL65CeslB76doawH+AaNVEfi
	cwdsso2d9C5CX06VydfIwUKnqu5ak5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715242437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1Wu7N6byPVboE3rdUC7zL9Eq6yvwdKjLQ5dDI/khmk=;
	b=3MeOmRFcBCb7UOtaivsoCQ9qZMgTrplIS08icmxYK6uM6s9uRCmSbNwPrQDKDsCKdyJBGW
	G9bgr+GdzjWUzJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 293FA13941;
	Thu,  9 May 2024 08:13:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /OTQCMWFPGYtGgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 09 May 2024 08:13:57 +0000
Date: Thu, 09 May 2024 10:14:12 +0200
Message-ID: <877cg3bdwr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Steven 'Steve' Kendall <skend@chromium.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add name for HP Engage Go dock
In-Reply-To: <20240508-usb-audio-hp-engage-go-dock-v1-1-9e2984d49e63@chromium.org>
References: <20240508-usb-audio-hp-engage-go-dock-v1-1-9e2984d49e63@chromium.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.22 / 50.00];
	BAYES_HAM(-2.92)[99.67%];
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,chromium.org:email]
X-Spam-Score: -3.22
X-Spam-Flag: NO

On Thu, 09 May 2024 00:29:25 +0200,
Steven 'Steve' Kendall wrote:
> 
> This dock previously presented as 'generic USB Audio'.
> UCM may now be applied specific to this dock.
> 
> Signed-off-by: Steven 'Steve' Kendall <skend@chromium.org>

Thanks, applied now to for-next branch.


Takashi

