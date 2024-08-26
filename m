Return-Path: <linux-kernel+bounces-301073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 539A995EC07
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4ED5B24351
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33A31411F9;
	Mon, 26 Aug 2024 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ByyHzuUi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="THNvcpbA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ByyHzuUi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="THNvcpbA"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858E813E88B;
	Mon, 26 Aug 2024 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661061; cv=none; b=usMEOfvvfOMggulcEDwyYa43Z+W9Jze4hBxXr0uC65MY/pcmv6ZFlCYhWjNMTNsWgGTFwBiJ+qZcBoEoLE1cGy01o3McVUsjVnTvhHTXhQwpU0ZmIaKBsvNpb+wGQi+9QUifJ7o4qNJfg+q9mwScO6Fzz2wXrM2RyK+Vp2Hjrv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661061; c=relaxed/simple;
	bh=zlOq6nzSXDQwwMQhnBGfqGvM6UKpIa5RGiMtr/kGF5Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1cKGp8rnKRVxII00oz9FUpCsGu3d3OWt+SdGlG0ocFZyHQKVGi2EUlwQHuJ/QuE1LCEXfazeNb4gP99cujCDLe2WZC4WlOXqcCdqioaI/Ywvrvuo9dGVilZpNfEtzmQ5Oqjq+jiD4475fPGqBcCcVeFrYm5sMcqjENXaauHhzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ByyHzuUi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=THNvcpbA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ByyHzuUi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=THNvcpbA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 973461F842;
	Mon, 26 Aug 2024 08:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724661057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5z/Foskk6oOOPhzDe9MSRNPIZuv7Wag2fkkGhke0pk=;
	b=ByyHzuUi4EUdrdnBWqJVwjv5tBOl0RYiA65xnpPUFbI6OYE5+l53FJ089AfxTMcG6HV0Si
	xRTwv/CbHQJGletNWz2oIyCH7qJcII6TaKECoxq1wNZVzHr3GCpx5dDYGEzEXCH4GCvGb4
	nXUtRl0Hnqtw0q5SgnxcnUKnk+whMVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724661057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5z/Foskk6oOOPhzDe9MSRNPIZuv7Wag2fkkGhke0pk=;
	b=THNvcpbAHQUwyeX3XWKhrTc4khB7OFFPUM5KDCaXthwqacg2TzYz2nYYk1+g5O5U0cIOLx
	qV6GPMowxyM2sMAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ByyHzuUi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=THNvcpbA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724661057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5z/Foskk6oOOPhzDe9MSRNPIZuv7Wag2fkkGhke0pk=;
	b=ByyHzuUi4EUdrdnBWqJVwjv5tBOl0RYiA65xnpPUFbI6OYE5+l53FJ089AfxTMcG6HV0Si
	xRTwv/CbHQJGletNWz2oIyCH7qJcII6TaKECoxq1wNZVzHr3GCpx5dDYGEzEXCH4GCvGb4
	nXUtRl0Hnqtw0q5SgnxcnUKnk+whMVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724661057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l5z/Foskk6oOOPhzDe9MSRNPIZuv7Wag2fkkGhke0pk=;
	b=THNvcpbAHQUwyeX3XWKhrTc4khB7OFFPUM5KDCaXthwqacg2TzYz2nYYk1+g5O5U0cIOLx
	qV6GPMowxyM2sMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EC5613724;
	Mon, 26 Aug 2024 08:30:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eKHvEUE9zGamXAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 26 Aug 2024 08:30:57 +0000
Date: Mon, 26 Aug 2024 10:31:41 +0200
Message-ID: <87o75fit1u.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hendrik Borghorst <hendrikborghorst@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] alsa: support HP Pavilion Aero 13-bg0xxx Mute LED
In-Reply-To: <20240825174351.5687-1-hendrikborghorst@gmail.com>
References: <20240824183445.6610-1-hendrikborghorst@gmail.com>
	<20240825174351.5687-1-hendrikborghorst@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 973461F842
X-Spam-Level: 
X-Spamd-Result: default: False [-5.35 / 50.00];
	BAYES_HAM(-2.84)[99.31%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.35
X-Spam-Flag: NO

On Sun, 25 Aug 2024 19:43:47 +0200,
Hendrik Borghorst wrote:
> 
> This patch adds the HP Pavilion Aero 13 (13-bg0xxx) (year 2024) to list of
> quirks for keyboard LED mute indication.
> 
> The laptop has two LEDs (one for speaker and one for mic mute). The
> pre-existing quirk ALC245_FIXUP_HP_X360_MUTE_LEDS chains both the quirk for
> mic and speaker mute.
> 
> Tested on 6.11.0-rc4 with the aforementioned laptop.
> 
> Signed-off-by: Hendrik Borghorst <hendrikborghorst@gmail.com>
> ---
> Changes since v1:
> 	- Moved entry to sorted position (by SSID)

Thanks, applied now.


Takashi

