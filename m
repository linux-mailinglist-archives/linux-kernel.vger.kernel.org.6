Return-Path: <linux-kernel+bounces-292220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C809956CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D43B1C215D8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0821C16CD02;
	Mon, 19 Aug 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k531YdWB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CffRlm4N";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0qelt+5J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FMwXPTiF"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9A716132F;
	Mon, 19 Aug 2024 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076338; cv=none; b=BZIAsgt6Z9BhPEiOv/W84R/z1RSX05DEnbpneM9I3/0oMQ/uLSG6TMdPepmgS9Xm9rUyrEnZE2ZM5HkjokO7AxP9UwAFF4Vn72grA+TMpGFD0lpHMm4cWYUcIadKhO17IUKhNMVV/ZVCd5i61axw/W5lie1ngCQVNrtDCt6SVm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076338; c=relaxed/simple;
	bh=JjQrXq52ivA3bXvyL6iHny67CLCQUXQgAj4NnLRwNnE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARbl+Ll20Hv60ZPb5PkQeKhtyzyDDoItvJscXo76grPZPIowCMJ5YWD/NYxD4sfJE56z1ODHAPzRgFzwMJD6KJHmQDoNEl1xX4DVg6r96sbBGp0zFKnpsMu+tjRCVTTOaqgER6LdjsWPiR2b/2gtUygSzg6dK+J3KKk9bZm8a7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k531YdWB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CffRlm4N; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0qelt+5J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FMwXPTiF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B691421EFB;
	Mon, 19 Aug 2024 14:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724076335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Hqg0KhQWd4wi8yzEWL33OI6ZQJuDjdv5rNkCZ7m87U=;
	b=k531YdWBwO0sAbDPea+CoeZpKctIXw5ak2UD1/VdQFzhCG7v9aO27hgEHrq+tfJzYVHzr/
	TJNrKPe2ecL51do4TrFVVeb0hSuM2PjpZBx7yBxYAz3IlOZ09Hag0O7KwRP6VIaROlSza6
	TRVYOCQfAtpWyLTmzTt9Eh6MFqq4+bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724076335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Hqg0KhQWd4wi8yzEWL33OI6ZQJuDjdv5rNkCZ7m87U=;
	b=CffRlm4NWd5fY2+Nf+JTw5YxqexNJGtA4MO3FCsLQQINa0JjvC/QZ7ulVS4s/1xDSO3YUc
	fd28mU5hlplNyUAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724076333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Hqg0KhQWd4wi8yzEWL33OI6ZQJuDjdv5rNkCZ7m87U=;
	b=0qelt+5JjbHgntX2+MKxTJ5lrrYE3WFgEIk4PmLZ3shyiIAZ/2ujnQ8PavtVotgLYjgObk
	rlXKfUZe1TsAwg62RO+kEgRHqdq7M+A4hNsI1WrmVXKUdlyed2c9Ko7IOc6BRNZIhYTzq1
	CjWpiQXHjLOMXgDP8d897pjg5kuKnJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724076333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Hqg0KhQWd4wi8yzEWL33OI6ZQJuDjdv5rNkCZ7m87U=;
	b=FMwXPTiF8axbBQshj3QXAao5sEhOvDn/c57b65XJdmxkcE+1v4C0MK6IBhYBc+1s8+XN7r
	G5ahrVa4Z4mAdCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85EFE1397F;
	Mon, 19 Aug 2024 14:05:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HMV1Hy1Rw2ZCAgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Aug 2024 14:05:33 +0000
Date: Mon, 19 Aug 2024 16:06:15 +0200
Message-ID: <8734n0vc88.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda/realtek: Convert existing CS35L56 products to use autodetect fixup function
In-Reply-To: <20240819123736.111946-1-simont@opensource.cirrus.com>
References: <20240819123736.111946-1-simont@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,cirrus.com:email,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Mon, 19 Aug 2024 14:37:36 +0200,
Simon Trimmer wrote:
> 
> The existing CS35L56 products can make use of the fixup function that
> works out the component binding details so we can remove the fixed
> configuration fixup functions.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>

Looks like a nice cleanup.
Applied to for-next branch now.  Thanks.


Takashi

