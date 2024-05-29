Return-Path: <linux-kernel+bounces-193764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0524E8D31B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4721F282E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88AA16191E;
	Wed, 29 May 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYFBk7nL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="988v7Mth";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYFBk7nL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="988v7Mth"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3C161939;
	Wed, 29 May 2024 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972029; cv=none; b=H1lbJlNl2/lsPFOBPaIhjpaDY+W0HHThH/RgNgtxAVzBeBptAecJJ7JwzwMQHNHb5llRxkieEuvThFkjNf3UsFyfTWXnPzOmOWyu8zMRug814ZGtrjUOIOoi4HOHIjkGzlhWsB59HjPVMKQKphOgiUlDCoWjV2l8Ojg0iKKeTgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972029; c=relaxed/simple;
	bh=UsTpr+1rU4+TFmo7MkcsE7OIRA1jTsvfvI2zrB9TjCs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBHfHsBBZPPOYnGwQMH6mWF5SGWgfsZOpadfxlzCU+hDiYQjJu61IyP2eMvqSD2ceHKbzo+nqgjYYEQe115X1v1KzpfuJOpYpI2fUqz2dim/SzkDmbwKE9N/myxzeK6F7uLjgZ6HQQdsVNTdBS2VBfu4UPYWHBu5yIcNYcm75Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYFBk7nL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=988v7Mth; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYFBk7nL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=988v7Mth; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC95D226B8;
	Wed, 29 May 2024 08:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716972025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbBKhF3GAulpBo4MzpRh8twR2mSvEOnrQ+SwlfalYQk=;
	b=oYFBk7nLchwIDYnWVaVqRRtrp27gRoRH9iHT8SmAU7F+p0LQIA/gZAicx/A4B1CBgfzdjX
	zZRIDq2NEmIIRE8IpTiLah1Dh+LNkxYJX6DOvr/c3Rn9nAFU4YKJow1Y8QBFxVbt8KM3IX
	neaPf660y3DFIhKh/GZpaSIaLWOJ4q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716972025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbBKhF3GAulpBo4MzpRh8twR2mSvEOnrQ+SwlfalYQk=;
	b=988v7MthNzsGgiM2pmmJYyqiQ1IwPkKzygJb+ufkasf4IS2U+VVjpi+ZOYyqysTY9niKKI
	YdW6LEczLXbDmBDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716972025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbBKhF3GAulpBo4MzpRh8twR2mSvEOnrQ+SwlfalYQk=;
	b=oYFBk7nLchwIDYnWVaVqRRtrp27gRoRH9iHT8SmAU7F+p0LQIA/gZAicx/A4B1CBgfzdjX
	zZRIDq2NEmIIRE8IpTiLah1Dh+LNkxYJX6DOvr/c3Rn9nAFU4YKJow1Y8QBFxVbt8KM3IX
	neaPf660y3DFIhKh/GZpaSIaLWOJ4q8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716972025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbBKhF3GAulpBo4MzpRh8twR2mSvEOnrQ+SwlfalYQk=;
	b=988v7MthNzsGgiM2pmmJYyqiQ1IwPkKzygJb+ufkasf4IS2U+VVjpi+ZOYyqysTY9niKKI
	YdW6LEczLXbDmBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A100A1372E;
	Wed, 29 May 2024 08:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QgYIJvnpVmY3agAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 29 May 2024 08:40:25 +0000
Date: Wed, 29 May 2024 10:40:46 +0200
Message-ID: <87plt557u9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: alexandre.belloni@bootlin.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: pcm: fix typo in comment
In-Reply-To: <20240528191850.63314-1-alexandre.belloni@bootlin.com>
References: <20240528191850.63314-1-alexandre.belloni@bootlin.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.27 / 50.00];
	BAYES_HAM(-2.97)[99.89%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -3.27
X-Spam-Flag: NO

On Tue, 28 May 2024 21:18:50 +0200,
alexandre.belloni@bootlin.com wrote:
> 
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Fix the typo in the comment for SNDRV_PCM_RATE_KNOT
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Thanks, applied.


Takashi

