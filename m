Return-Path: <linux-kernel+bounces-314825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563A296B991
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893851C217F3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6AB1CF7D7;
	Wed,  4 Sep 2024 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EaQjexoj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SB7B020P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EaQjexoj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SB7B020P"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73311126C01;
	Wed,  4 Sep 2024 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447792; cv=none; b=XGMGgcYKAH9KqbAJt+WiKhdAi0l8O9ZgBNeL+dRSnDFWVdr9eFFfVlubwUNIOLYGP9xdJyPNBLhiw4kFtjVJQioMBo2s63iP2rSi/zTFNXXQeaEpqn2H2lRpE3UJwP0M0+IPalVOvjgav2ajoqC+Uaa1Ie1sCD5hYnJttURuiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447792; c=relaxed/simple;
	bh=POSHEmmMPiFWkRNS4R1ne1iS6VUgUqN337nJAH3tPfk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJgW/cZxe5l6oBZms/w9OcfrGF72nD4yG8/6EwIc5rVX2Sn3sL1lOaClx2a+TqOQwD3ba/iev5+WjrYq8bJPsl1KUNK1fP9e4kLD+7pZi9GSpY2CXoJcpvDVJm8QazNOimPlDPCXTWZiTNErxV++0k2Q3fBmxaDoCIx2jw2cybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EaQjexoj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SB7B020P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EaQjexoj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SB7B020P; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7A3221995;
	Wed,  4 Sep 2024 11:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725447787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjluhCFBVupjaHaDoFi7MHz9yC3FhdBQwXb+BEUEuWc=;
	b=EaQjexojlE6mJkLWU/m7U1W7IeDaTk8eDsVgGTytHvFAHouaqYEPJjYab8teVnhxrDL70R
	STB1x1djsU1MJ5ssnIxSRPjQB0vbrUqELeo4ftoiIt95oyxa+o4/CN2d5WEbi5UzTStETu
	uXlQpD6n57oQkFYWSS8Q1vdv7dPNG1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725447787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjluhCFBVupjaHaDoFi7MHz9yC3FhdBQwXb+BEUEuWc=;
	b=SB7B020P1QZ3sz54U+D+5l1b8quWB0/YVYUbd0nynvO7PftKORtyN5DWTLuDga7lwq/oVW
	vPrzyEe2l/IOKVAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725447787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjluhCFBVupjaHaDoFi7MHz9yC3FhdBQwXb+BEUEuWc=;
	b=EaQjexojlE6mJkLWU/m7U1W7IeDaTk8eDsVgGTytHvFAHouaqYEPJjYab8teVnhxrDL70R
	STB1x1djsU1MJ5ssnIxSRPjQB0vbrUqELeo4ftoiIt95oyxa+o4/CN2d5WEbi5UzTStETu
	uXlQpD6n57oQkFYWSS8Q1vdv7dPNG1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725447787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjluhCFBVupjaHaDoFi7MHz9yC3FhdBQwXb+BEUEuWc=;
	b=SB7B020P1QZ3sz54U+D+5l1b8quWB0/YVYUbd0nynvO7PftKORtyN5DWTLuDga7lwq/oVW
	vPrzyEe2l/IOKVAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89481139E2;
	Wed,  4 Sep 2024 11:03:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pEdWIGs+2GZNNAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 04 Sep 2024 11:03:07 +0000
Date: Wed, 04 Sep 2024 13:03:53 +0200
Message-ID: <87y147isti.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Maximilien Perreault <maximilienperreault@gmail.com>
Cc: alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Support mute LED on HP Laptop 14-dq2xxx
In-Reply-To: <20240904031013.21220-1-maximilienperreault@gmail.com>
References: <20240904031013.21220-1-maximilienperreault@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.29
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.972];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 04 Sep 2024 05:10:13 +0200,
Maximilien Perreault wrote:
> 
> The mute LED on this HP laptop uses ALC236 and requires a quirk to function. This patch enables the existing quirk for the device.
> 
> Signed-off-by: Maximilien Perreault <maximilienperreault@gmail.com>

Applied now.  Thanks.


Takashi

