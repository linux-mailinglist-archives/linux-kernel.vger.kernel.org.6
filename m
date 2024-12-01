Return-Path: <linux-kernel+bounces-426565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948429DF507
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 09:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1A6281209
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90D170832;
	Sun,  1 Dec 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ypOy1oFP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LdHcn0iV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ypOy1oFP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LdHcn0iV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972726FD5;
	Sun,  1 Dec 2024 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733043021; cv=none; b=OIxRc00ZjZbLjpPyg/nOyo/Crt6+fso8N8RTDm99lLZ3gw9KFl9EAnEGTszIoX4K+q/YU11KdkMf+EkJdeeTl7+Zl/vyArO+3bOzNom0G8y6hsQ5BQS5B85sB7lORJ6mApmpPvTVd+ryWLoWDOaYQH6wdI5Vi1rD6cyjDJ+mXzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733043021; c=relaxed/simple;
	bh=sKD2WcL6nKwv/zWuSKLygnkpjjHw8gSGmmTbB+dXB94=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4sWqNwqk1VphAC+ZVQ3P2KkswnCYxytBTO4YLWKPiAyHXfieiQoAIEjwSHFYDhWMXq2wNxOfB0Mw9MOu0rFNilg5BOGr2XwnwMyijV/COTGePpIeJA48CkVrraCjESjKtyWIH1PFCP2IRDesgZrlS5VrNLPfThbOUoMwBwoySk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ypOy1oFP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LdHcn0iV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ypOy1oFP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LdHcn0iV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 648E21F381;
	Sun,  1 Dec 2024 08:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733043015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ukjwVbA0sB93ZtyfEpzdDYliCeSpHegsUwPvMpVMSI=;
	b=ypOy1oFPm/Aesc+LS/cSs2ntuBhlvzCSgNjWlojZ2AmeV0Y2M5L8N+ixVf/OWge0vg35VT
	+mMP79PwZHSJXXiGu2cUzt0SvubwNzT7te4ukhmIQvlu0sU0lju2XyshCMpzW15TmU0PJq
	/bVLZYnOIKkqiGKwJV1AtoPwgV23+FE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733043015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ukjwVbA0sB93ZtyfEpzdDYliCeSpHegsUwPvMpVMSI=;
	b=LdHcn0iVp616JON9hgB9fkHFHbbN1sqetpZD65Kl1EM0HIs6ZDyHYF+te+NG+gcuGTyuF6
	CXT6BaQmYNi5vJAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733043015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ukjwVbA0sB93ZtyfEpzdDYliCeSpHegsUwPvMpVMSI=;
	b=ypOy1oFPm/Aesc+LS/cSs2ntuBhlvzCSgNjWlojZ2AmeV0Y2M5L8N+ixVf/OWge0vg35VT
	+mMP79PwZHSJXXiGu2cUzt0SvubwNzT7te4ukhmIQvlu0sU0lju2XyshCMpzW15TmU0PJq
	/bVLZYnOIKkqiGKwJV1AtoPwgV23+FE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733043015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ukjwVbA0sB93ZtyfEpzdDYliCeSpHegsUwPvMpVMSI=;
	b=LdHcn0iVp616JON9hgB9fkHFHbbN1sqetpZD65Kl1EM0HIs6ZDyHYF+te+NG+gcuGTyuF6
	CXT6BaQmYNi5vJAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 340B613974;
	Sun,  1 Dec 2024 08:50:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WRUqC0cjTGeiRgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 01 Dec 2024 08:50:15 +0000
Date: Sun, 01 Dec 2024 09:50:14 +0100
Message-ID: <87ed2rzt15.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Marie Ramlow <me@nycode.dev>
Cc: Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: add mixer mapping for Corsair HS80
In-Reply-To: <20241130165240.17838-1-me@nycode.dev>
References: <20241130165240.17838-1-me@nycode.dev>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 30 Nov 2024 17:52:40 +0100,
Marie Ramlow wrote:
> 
> The Corsair HS80 RGB Wireless is a USB headset with a mic and a sidetone
> feature. It has the same quirk as the Virtuoso series.
> This labels the mixers appropriately, so applications don't
> move the sidetone volume when they actually intend to move the main
> headset volume.
> 
> Signed-off-by: Marie Ramlow <me@nycode.dev>

Thanks, applied now.


Takashi

