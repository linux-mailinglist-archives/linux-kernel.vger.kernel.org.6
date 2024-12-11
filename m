Return-Path: <linux-kernel+bounces-441345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998159ECD1C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA3F1886E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410B4229151;
	Wed, 11 Dec 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dFUYik6k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/rI/mNGe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dFUYik6k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/rI/mNGe"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5467223FD06;
	Wed, 11 Dec 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733923497; cv=none; b=q/onTB0xPYLcEPtYnd2YgqFC+sSV0czthOtWiHR2WfpJEcyyBvSNBMpVCJG6JYlA+ZBCNGj699SPThSQWYechZJniQ3svjf5pI4ntdXfiGje3oBmU8iquOc5LOxcSInQxhZ/UhZcu0af8FvYylFkYr2FMx6rhDKgNwH2w/rUL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733923497; c=relaxed/simple;
	bh=/G0epAGa2I4eS7VibmqWScj9bycsGNh6b10XOlNoZVI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qeDlAaCw2iMTQd1cVYx7AaiY8/Y1o8Bo9DLgSsZHny8LTipcMgEO1Zd5EUgwfjLOhITfYilru5sWJjycLtfUfl/DkAsl0HD3RciEIGUhFQiBONez3EUtG2FxMZnt9LPC6bT64UYWouUKQg8Rru63PCyJ7eOVk75CH+sPdyLJSxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dFUYik6k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/rI/mNGe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dFUYik6k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/rI/mNGe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CF8D1F38C;
	Wed, 11 Dec 2024 13:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733923493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2SguABdKfnUIGO2u23hE0MzTCimieiDIf1ANX09Bwk8=;
	b=dFUYik6kb1+7E4zk8A/LCGc7oVxic5aOvwK43pyVHWVc5xk4Hu16Lu52/OetSvlLajLrQA
	UNqjFqdFE90aUTRXijtAnQE0BgcUBCtikkJI6ciOosSoswuknSeyVxsnRB/HAjROtAVk8v
	FQNuo7NuFifklQPIpDjgRy8Phl/aLf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733923493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2SguABdKfnUIGO2u23hE0MzTCimieiDIf1ANX09Bwk8=;
	b=/rI/mNGeaI1ebPXdqzigSJC0oVlJGm3doxrlTuwsXZ5hUZxbKxI7qjwyOFuuMVoAKUCVIH
	X4p5fZaOOv0tuPCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dFUYik6k;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/rI/mNGe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733923493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2SguABdKfnUIGO2u23hE0MzTCimieiDIf1ANX09Bwk8=;
	b=dFUYik6kb1+7E4zk8A/LCGc7oVxic5aOvwK43pyVHWVc5xk4Hu16Lu52/OetSvlLajLrQA
	UNqjFqdFE90aUTRXijtAnQE0BgcUBCtikkJI6ciOosSoswuknSeyVxsnRB/HAjROtAVk8v
	FQNuo7NuFifklQPIpDjgRy8Phl/aLf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733923493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2SguABdKfnUIGO2u23hE0MzTCimieiDIf1ANX09Bwk8=;
	b=/rI/mNGeaI1ebPXdqzigSJC0oVlJGm3doxrlTuwsXZ5hUZxbKxI7qjwyOFuuMVoAKUCVIH
	X4p5fZaOOv0tuPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13BEC13983;
	Wed, 11 Dec 2024 13:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UQWFA6WSWWdpGAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 11 Dec 2024 13:24:53 +0000
Date: Wed, 11 Dec 2024 14:24:52 +0100
Message-ID: <87zfl21hej.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: sonicvibes: Use str_on_off() helper in snd_sonicvibes_proc_read()
In-Reply-To: <20241210172428.139643-2-thorsten.blum@linux.dev>
References: <20241210172428.139643-2-thorsten.blum@linux.dev>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 3CF8D1F38C
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 10 Dec 2024 18:24:26 +0100,
Thorsten Blum wrote:
> 
> Remove hard-coded strings by using the str_on_off() helper function.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Thanks, applied now.


Takashi

