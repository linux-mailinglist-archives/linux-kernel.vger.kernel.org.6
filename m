Return-Path: <linux-kernel+bounces-426562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FBC9DF4FD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 09:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8411B21529
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 08:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BF07E111;
	Sun,  1 Dec 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ITeIIuyg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YHr2rI6r";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ITeIIuyg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YHr2rI6r"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC2022081;
	Sun,  1 Dec 2024 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733041602; cv=none; b=ORp1u0mwASUdV2xRzdtY8NPfHX/1zUYgc1R9SO0YqKBh9ACPp7SbOWTAo1IXZaayHvlhMChKUNdd6nMY54sCZFjnESSeWUBAx5Nk5eJwXaZUNd9f/aRiY1yBhrYa4W1mb6jpIev7MVNxfYJ79WQCiAxJFSvHkFkAHY/9v8iKbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733041602; c=relaxed/simple;
	bh=k9jV+qhuQjLA8QthSGTHJaeL+S0rJ4eENb6YgvN++BQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxFyufxfS3aMh56ogVn+1TO1gSYkBsq/eLpdW0ybotBqx6sYLED3StlVoip5qPpsZjjkidEhJqiKc6lfnolhwlaEhsP6nlOwyJfiCNdaFl/f0V/USJiugMm30hHIAyKA75nc+knGtw7fzE0OoAH7mp/EoNLFVXUbj4cGIEWKjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ITeIIuyg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YHr2rI6r; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ITeIIuyg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YHr2rI6r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BC0951F381;
	Sun,  1 Dec 2024 08:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733041591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QlCGY3VXWIIx1N88Q3QkSALEnAwR0tAAHcBGO1Col+k=;
	b=ITeIIuygyo69rcMHD4VgIHGXAMcSZNkWT8gjg7KjCUv8SCnBvwUKNjEr5bLwC4x7TaCSb8
	uGq5teMM1UZAnjWGvcQXEC2PfMYkIMMj7JFhzv3YVtGwHj5O9bT9o5SL+IR+ktQ1Pre1AS
	n8W1qnqYa/Y9vlVrj2G6zsqXssJtWG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733041591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QlCGY3VXWIIx1N88Q3QkSALEnAwR0tAAHcBGO1Col+k=;
	b=YHr2rI6rkB7RthHw1QzQhWyJzHoLOJG8KMcCWIbH8ZGePOiZW8ebPVbWUWEvk2QCrYyI9m
	Ys63t5LLFMWOL4AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733041591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QlCGY3VXWIIx1N88Q3QkSALEnAwR0tAAHcBGO1Col+k=;
	b=ITeIIuygyo69rcMHD4VgIHGXAMcSZNkWT8gjg7KjCUv8SCnBvwUKNjEr5bLwC4x7TaCSb8
	uGq5teMM1UZAnjWGvcQXEC2PfMYkIMMj7JFhzv3YVtGwHj5O9bT9o5SL+IR+ktQ1Pre1AS
	n8W1qnqYa/Y9vlVrj2G6zsqXssJtWG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733041591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QlCGY3VXWIIx1N88Q3QkSALEnAwR0tAAHcBGO1Col+k=;
	b=YHr2rI6rkB7RthHw1QzQhWyJzHoLOJG8KMcCWIbH8ZGePOiZW8ebPVbWUWEvk2QCrYyI9m
	Ys63t5LLFMWOL4AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51890138A5;
	Sun,  1 Dec 2024 08:26:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dPAQErcdTGfnQAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 01 Dec 2024 08:26:31 +0000
Date: Sun, 01 Dec 2024 09:26:30 +0100
Message-ID: <87cyib4xmx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kailang Yang <kailang@realtek.com>
Cc: Hridesh MG <hridesh699@gmail.com>,
    Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Joshua Grisham <josh@joshuagrisham.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 1/2] ALSA: hda/realtek: Fix headset mic on Acer Nitro 5
In-Reply-To: <CALiyAokt1zY4a6F0DTpyYAmu38D1Fk0k0QvsFtXYHzQ7suS38A@mail.gmail.com>
References: <20241114-alc287-nitro5-v1-0-72e5bf2275c3@gmail.com>
	<20241114-alc287-nitro5-v1-1-72e5bf2275c3@gmail.com>
	<87iksmq8ho.wl-tiwai@suse.de>
	<CALiyAo=5aLbYEyRWWw7QscTk6cXy5qckHToiPL6h4fKM9=skLg@mail.gmail.com>
	<87ed387ioq.wl-tiwai@suse.de>
	<CALiyAo=awTsGQnGH5UPB7dF5QsZ2AFkKv5LcJkJRXV9sv51iqQ@mail.gmail.com>
	<CALiyAokt1zY4a6F0DTpyYAmu38D1Fk0k0QvsFtXYHzQ7suS38A@mail.gmail.com>
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
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,perex.cz,suse.com,lwn.net,opensource.cirrus.com,joshuagrisham.com,vger.kernel.org,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 30 Nov 2024 19:58:26 +0100,
Hridesh MG wrote:
> 
> > know. I'll make an attempt to understand the cases and process
> > coefficients before sending v2.
> I did a deep dive into the code and frankly I'm a bit stumped right
> now since it appears that the code for the headset type detection was
> written by Kailang Yang from Realtek and i could not understand it
> since I'm not sure where to look for documentation on realtek codec
> processing coefficients.
> 
> To rephrase what I had meant earlier, type detection for the ALC287 is
> currently not supported. I made an educated guess and added the codec
> to an existing block of code, which detected it as CTIA. However, I
> have no way of verifying if this guess is correct. Do you have any
> advice on what my next steps should be?

Kailang, could you check that?


thanks,

Takashi

