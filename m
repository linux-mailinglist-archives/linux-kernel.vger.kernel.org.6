Return-Path: <linux-kernel+bounces-213181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B95AA906F33
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0591C23607
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F311459EE;
	Thu, 13 Jun 2024 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gwOmERsC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LNtBgVTj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gwOmERsC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LNtBgVTj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32100136E00;
	Thu, 13 Jun 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280894; cv=none; b=qHTK5I3SZ6sSiIB/J4m9/3yUz7sQdLXwUgKaoOpOpQb3mRZXMW5N2FqvdoorSf9X0ZGUcU2cnUpnoX2I/nVTfCQgo9bYvWEYJHxR5hQfvwRbHrreV5w5QrFdlNECFecOBockXiauzHO6yGBmS5+SPoCQo1CCUk1WE8eTetbheeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280894; c=relaxed/simple;
	bh=W/olXCZwszEAqxRxi7UK7tdlp0kJsV3lR1lSw6UxG70=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/svjaIWbvSPyP2wb7V3QwfYmWaYSzDhE7bP5suBWJCZ5glsf68D5b+BJeSX7JlqyenIwB+9SRy3KACi1WFIFwJ2bD9Ai468Kzzs35h8wG6DMSKeO5uuHkFzWIHfkg8aAkg6sveQ0sIvYhsg6EwbFAYMDU4dlMU+/X9Gx9LzPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gwOmERsC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LNtBgVTj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gwOmERsC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LNtBgVTj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42B9C353C5;
	Thu, 13 Jun 2024 12:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718280891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYJJaDAiE8Jnnmi5U+ASAdIZI7iCR9QVodqnRXuBBqg=;
	b=gwOmERsCN9Jisej0D2mWfR0CF+yYvljzggdkpfJj7qVd+VT2vQLVdGERnIaT5PubIfvJaA
	4+efjBLW+2xKCPfQcc/KwR7VYsq3/I9Co9iGvsvyensynFWmfISCuu79w9v7NB8u16GPzW
	Gc+c//495/7gzJkPPIP8ltmP8bvg+0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718280891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYJJaDAiE8Jnnmi5U+ASAdIZI7iCR9QVodqnRXuBBqg=;
	b=LNtBgVTjWRTqpp2XQ2vE+B3wRBXOSf2UaZHbBQZLjh+X35P/f4BcmZ11zvnrlim0rN2m+C
	B9/+VIQ7Dajm98BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718280891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYJJaDAiE8Jnnmi5U+ASAdIZI7iCR9QVodqnRXuBBqg=;
	b=gwOmERsCN9Jisej0D2mWfR0CF+yYvljzggdkpfJj7qVd+VT2vQLVdGERnIaT5PubIfvJaA
	4+efjBLW+2xKCPfQcc/KwR7VYsq3/I9Co9iGvsvyensynFWmfISCuu79w9v7NB8u16GPzW
	Gc+c//495/7gzJkPPIP8ltmP8bvg+0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718280891;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XYJJaDAiE8Jnnmi5U+ASAdIZI7iCR9QVodqnRXuBBqg=;
	b=LNtBgVTjWRTqpp2XQ2vE+B3wRBXOSf2UaZHbBQZLjh+X35P/f4BcmZ11zvnrlim0rN2m+C
	B9/+VIQ7Dajm98BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 112BD13A7F;
	Thu, 13 Jun 2024 12:14:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0PcLA7viambcIwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 13 Jun 2024 12:14:51 +0000
Date: Thu, 13 Jun 2024 14:15:14 +0200
Message-ID: <87bk45ninh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: linux@treblig.org
Cc: oleksandr_andrushchenko@epam.com,
	perex@perex.cz,
	tiwai@suse.com,
	xen-devel@lists.xenproject.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: xen-front: remove unused struct 'alsa_sndif_hw_param'
In-Reply-To: <20240601232604.198662-1-linux@treblig.org>
References: <20240601232604.198662-1-linux@treblig.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.25
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.25 / 50.00];
	BAYES_HAM(-2.95)[99.79%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Sun, 02 Jun 2024 01:26:04 +0200,
linux@treblig.org wrote:
> 
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'alsa_sndif_hw_param' has been unused since the original
> commit 1cee559351a7 ("ALSA: xen-front: Implement ALSA virtual sound
> driver").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Thanks, applied.


Takashi

