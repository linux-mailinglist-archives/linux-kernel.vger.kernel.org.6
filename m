Return-Path: <linux-kernel+bounces-318858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DBF96F438
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED616B23320
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA271CCB38;
	Fri,  6 Sep 2024 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XG6o253m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TgaQHSO1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XG6o253m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TgaQHSO1"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8311CB313;
	Fri,  6 Sep 2024 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625479; cv=none; b=rx2qp9FpT3vLKfXgDNbrBlNfRwQw0Gti0yhL/3qldyMs4KObuEokzQZkOrxtpeYJP+Hu0W98tC6SBudu+C47brj06FSYtXDC7qa2nHXSLsnQinh7obSG0PBj7zt677gs4CeZ6dj9LPu+q9kz1ChqeXluuOkK2NX1g8WpSLqgLQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625479; c=relaxed/simple;
	bh=NZ8Fyqvj2HAAbz8F+ChhhG7uGUbUEAK0XSvkZFqRXb8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPzMDHAw3RlzuSt+9rnXmjmG4Lrw7GFGWaq8UEwWX3CpvfjiVdeRav2w4S+9QTLBKKQXaSiz8hcAxRYmSxYvWi6ou3zpBPcVy5xzXczTOZ3defa9Krs0lCPGgA1Fliak3AXVimYxEQaWWT9P6Wjq0VafSC+Rg39VC+001k12PJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XG6o253m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TgaQHSO1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XG6o253m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TgaQHSO1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 672E11F8B5;
	Fri,  6 Sep 2024 12:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725625469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yuYwwjtBdSx6z1Ov0ocE8YGqazxBIJRUoxnqWkRqRas=;
	b=XG6o253m+4CABVVHtZMOh6y/zu030i/EcXV8ZBTTeePTCoEDXNzq2Lx284idpBBNBWQLQv
	GZ8TBYrEKCfMbqh1hG8aYcaJnxpFxtWKMxUst9X84Su7CGV8mD7YHqknfs32P75IVn7GXS
	FWctmukSyUUIAFIszcIq8ZxcTf9Qa3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725625469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yuYwwjtBdSx6z1Ov0ocE8YGqazxBIJRUoxnqWkRqRas=;
	b=TgaQHSO16oJHt3Xm0jCb2HNddJGGZdsFALJkT6huVFQq2LBkG9Jwne/QowfVgy3cmvd5d9
	/YhcpXPyR68zQxAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725625469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yuYwwjtBdSx6z1Ov0ocE8YGqazxBIJRUoxnqWkRqRas=;
	b=XG6o253m+4CABVVHtZMOh6y/zu030i/EcXV8ZBTTeePTCoEDXNzq2Lx284idpBBNBWQLQv
	GZ8TBYrEKCfMbqh1hG8aYcaJnxpFxtWKMxUst9X84Su7CGV8mD7YHqknfs32P75IVn7GXS
	FWctmukSyUUIAFIszcIq8ZxcTf9Qa3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725625469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yuYwwjtBdSx6z1Ov0ocE8YGqazxBIJRUoxnqWkRqRas=;
	b=TgaQHSO16oJHt3Xm0jCb2HNddJGGZdsFALJkT6huVFQq2LBkG9Jwne/QowfVgy3cmvd5d9
	/YhcpXPyR68zQxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CF76136A8;
	Fri,  6 Sep 2024 12:24:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H65uDX302mb/DwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 06 Sep 2024 12:24:29 +0000
Date: Fri, 06 Sep 2024 14:25:15 +0200
Message-ID: <87jzfpdl5g.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] ALSA: IEC958 definition for consumer status channel update
In-Reply-To: <20240906093422.2976550-1-jbrunet@baylibre.com>
References: <20240906093422.2976550-1-jbrunet@baylibre.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,baylibre.com:email];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 06 Sep 2024 11:34:16 +0200,
Jerome Brunet wrote:
> 
> Add 128kHz, 352.4kHz, 384kHz and 705.6kHz.
> These definitions have been found working on eARC using a Murideo
> Seven Generator.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
> 
>  Hi,
> 
>  As explained in the commit description, I don't a have strong references
>  to back the new values up. I've found them through testing.
> 
>  The value must exist somehow since the related sample rates are allowed
>  over an IEC958 link. It would be better to get confirmation from the
>  actual specification rather than just rely on testing.
> 
>  I don't mind if this does not get applied. I just want to make the
>  data public, giving others the possibility to confirm or deny it.

I find it makes sense to have definitions.  At least, it doesn't break
alone :)

Unless anyone raises objection, I'm going to apply it for 6.12 later.


thanks,

Takashi

