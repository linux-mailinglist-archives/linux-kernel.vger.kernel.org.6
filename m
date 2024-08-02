Return-Path: <linux-kernel+bounces-272294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB589459C0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3F231C22B1B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772341C2312;
	Fri,  2 Aug 2024 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OaKWQNtc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J7fyKT/q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OaKWQNtc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J7fyKT/q"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4039E1BF30F;
	Fri,  2 Aug 2024 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586618; cv=none; b=pQYPJGrS8nKOPlRu/VOJzr3EcCgQ8zJycOxZ9+99+J5OpoR7h7ZxRT+tXRqQxQietE4K2ScCmZAjhDCJ35rdod+hvGKGHxt4wA+gt5fBffvo0Qo1emR/aMiHpyHY80s1lRia+2E5J8zeRRlk/UxtqhgKVTzwVxjdxfq2Pysa3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586618; c=relaxed/simple;
	bh=65RzXJHvkUqmUodSQnw2StnvjyO47CSk2+I0m9aVnqg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIeIv2pyv0Vq93ZJW1TThHqIbHLRosuiT/V8VZ/T3eSgwf8Vba9PYDfOyJFbMoUHzGn1+sB920PIXWTtm2CPgAao3x6W8zaqhdxo6J4KIjzlA4d0d4ArfvZaMspSCGz1YEztemdCU9uSivoRyPDdy2gTUKTRRvb5F4x8srFiryI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OaKWQNtc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J7fyKT/q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OaKWQNtc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J7fyKT/q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5696B21A89;
	Fri,  2 Aug 2024 08:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722586614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pio5Kdh9UwMOT8Wq7vCSSTQuQ8tWE9yeEfnxBE5AReU=;
	b=OaKWQNtckV1F1ft6JWr0QUzWGG/Ef5EV3NA7631X7iuzjB+gwd5BIoqHOBq/WU/Jit2+UL
	dMAuT87d8ICDTJMUjrGgoSwVlr8kv485UJQUhsZiv/tnk5Rgs3t6eYGqOiiHeoX4DBOGfS
	xbpFT2v0AmcmJQ+cIRHBB085IVdcBcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722586614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pio5Kdh9UwMOT8Wq7vCSSTQuQ8tWE9yeEfnxBE5AReU=;
	b=J7fyKT/qgAGeQazWkSz1VP1VryHVOsCtX+UqCD/dF/luF9U2mj/XJ/e4CFROAXiAojruFB
	9aitli9D2FA7PKCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OaKWQNtc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="J7fyKT/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722586614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pio5Kdh9UwMOT8Wq7vCSSTQuQ8tWE9yeEfnxBE5AReU=;
	b=OaKWQNtckV1F1ft6JWr0QUzWGG/Ef5EV3NA7631X7iuzjB+gwd5BIoqHOBq/WU/Jit2+UL
	dMAuT87d8ICDTJMUjrGgoSwVlr8kv485UJQUhsZiv/tnk5Rgs3t6eYGqOiiHeoX4DBOGfS
	xbpFT2v0AmcmJQ+cIRHBB085IVdcBcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722586614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pio5Kdh9UwMOT8Wq7vCSSTQuQ8tWE9yeEfnxBE5AReU=;
	b=J7fyKT/qgAGeQazWkSz1VP1VryHVOsCtX+UqCD/dF/luF9U2mj/XJ/e4CFROAXiAojruFB
	9aitli9D2FA7PKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 386AE1388E;
	Fri,  2 Aug 2024 08:16:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jx91DPaVrGYfFAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 02 Aug 2024 08:16:54 +0000
Date: Fri, 02 Aug 2024 10:17:30 +0200
Message-ID: <877cczibj9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Sound Mailing List <linux-sound@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sound fixes for 6.12-rc1
In-Reply-To: <87a5hvibm6.wl-tiwai@suse.de>
References: <87a5hvibm6.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5696B21A89
X-Spam-Score: -3.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

On Fri, 02 Aug 2024 10:15:45 +0200,
Takashi Iwai wrote:
> 
> Linus,
> 
> please pull sound fixes for v6.11-rc2 from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.11-rc2
> 
> The topmost commit is 478689b5990deb626a0b3f1ebf165979914d6be4
> 
> ----------------------------------------------------------------
> 
> sound fixes for 6.11-rc2
> 
> A small collection of fixes:
> - Revert of FireWire changes that caused a long-time regression
> - Another long-time regression fix for AMD HDMI
> - MIDI2 UMP fixes
> - HD-audio Conexant codec fixes and a qurik

... and ignore the subject line typo :)  It's too early.


Takashi

