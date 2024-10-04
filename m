Return-Path: <linux-kernel+bounces-349942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1E798FDA3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F17B21ED4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09400136338;
	Fri,  4 Oct 2024 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rImMVdri";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o/xS5/yN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rImMVdri";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o/xS5/yN"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41071D5AC1;
	Fri,  4 Oct 2024 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728025320; cv=none; b=e1KPaBpox9+RdRjpfeTfGMSw1oQOa93bDAo0LfiIgJci8OnuzjJ3upGmGfdcikCTRFHEB0MMnFDz5CMP0TFmbIxEzQ/bchO/BVO2fo7MFhgqK2q1O1GpqG/jfe5UPfiBR+zxJLGxl+TSwOQ0Dp9l+Eo5ynR7WoMxhEMv9LEmIFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728025320; c=relaxed/simple;
	bh=LZPdeKacXrGLg2WiOlHHYjqPjjEVvPjadbmgFF9quN4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoT98E6IE24mHNFTFhLB0u+uvClznAV0lPxxdXgF6U5c4mnUyKWox4tDDVOrexftLTHj10Z6AOOb1E2NygliiliHxBunYowZpWXijG3SQlVFs57W2ulgkySo8ebd2VHX2KTfSK0QK4CeDWMfxUdN/bEySAfjhRucCACCB1yIAAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rImMVdri; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o/xS5/yN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rImMVdri; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=o/xS5/yN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC7E31FEE2;
	Fri,  4 Oct 2024 07:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728025316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60XLaIx5K0B3dtX6es6h0An7O/1mPGoJi/yafLyNw2c=;
	b=rImMVdril6s8kovKm4xumpvcXJgeyP5ChTWU62O/NpOplrmAOm4H9nVEP2zvH56muwws2F
	PLr1Sav6zM+lHSsmsosgF46jM9CwNF5nH349ZNjNrYn13/Y6cTTJkyFI8+sm0wcYQmtMaK
	gAXcAf9Bdl2UzdQwsvkweRXevZsw6S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728025316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60XLaIx5K0B3dtX6es6h0An7O/1mPGoJi/yafLyNw2c=;
	b=o/xS5/yNMZwQurCqv9QzKkq8YZK9rPFnJnXDOMA+nDxnCy0mCUQyULv4Nk13UJwp4Nv7jO
	8gjGK20qqOHnATBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728025316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60XLaIx5K0B3dtX6es6h0An7O/1mPGoJi/yafLyNw2c=;
	b=rImMVdril6s8kovKm4xumpvcXJgeyP5ChTWU62O/NpOplrmAOm4H9nVEP2zvH56muwws2F
	PLr1Sav6zM+lHSsmsosgF46jM9CwNF5nH349ZNjNrYn13/Y6cTTJkyFI8+sm0wcYQmtMaK
	gAXcAf9Bdl2UzdQwsvkweRXevZsw6S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728025316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=60XLaIx5K0B3dtX6es6h0An7O/1mPGoJi/yafLyNw2c=;
	b=o/xS5/yNMZwQurCqv9QzKkq8YZK9rPFnJnXDOMA+nDxnCy0mCUQyULv4Nk13UJwp4Nv7jO
	8gjGK20qqOHnATBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A692713A55;
	Fri,  4 Oct 2024 07:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SKppJ+SS/2ZtXAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 04 Oct 2024 07:01:56 +0000
Date: Fri, 04 Oct 2024 09:02:50 +0200
Message-ID: <87v7y8mjtx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH] ALSA: gus: Fix some error handling paths related to get_bpos() usage
In-Reply-To: <d9ca841edad697154afa97c73a5d7a14919330d9.1727984008.git.christophe.jaillet@wanadoo.fr>
References: <d9ca841edad697154afa97c73a5d7a14919330d9.1727984008.git.christophe.jaillet@wanadoo.fr>
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
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[wanadoo.fr];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[wanadoo.fr];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 03 Oct 2024 21:34:01 +0200,
Christophe JAILLET wrote:
> 
> If get_bpos() fails, it is likely that the corresponding error code should
> be returned.
> 
> Fixes: a6970bb1dd99 ("ALSA: gus: Convert to the new PCM ops")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is speculative. Review with care.

It looks correct.  Applied now.  Thanks!


Takashi

