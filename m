Return-Path: <linux-kernel+bounces-269008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5863B942C39
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCB31C21449
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9AE81AC441;
	Wed, 31 Jul 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MH0l6zGU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="etc3uqsc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MH0l6zGU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="etc3uqsc"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63616D4CB;
	Wed, 31 Jul 2024 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422618; cv=none; b=przZ159Y1Q6KK65Ly4qrx9vW+o5Sirbte0gTceV6qp++HkwKnKu1LlvZGc589FOH5/AVGze0zb0Tm0gNTDV0F2j8uqL6iXfPxwGVpLt6pG+pp12gtiU5bZx9L5PvNfUPa1RegCYiWk3ICcnSCLJWLjs2F1ZRAMzoCAdpuPanDTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422618; c=relaxed/simple;
	bh=HkrPAmBxBDD1NkDY0Y+wTWRs9zMfQgr4GMSNwKj1aIc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMzaEHDoBmu4L1nHI6XNw8cFCAM6QRWla2KIgc2mZxA7xDwYbt7No1mwarlmKY7OjQtWI1tQTczJYeH2nOfsxtuGo+PmdnhCQX+yKejZ3ntf3coX+AQshVAWCs3KDGucZr5At4TV9+G2eAG+1Iogp8VtpcABAJ5Ufj3tCzEh4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MH0l6zGU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=etc3uqsc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MH0l6zGU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=etc3uqsc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCDA421A4B;
	Wed, 31 Jul 2024 10:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722422614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZQgYysW88ClS7mhe8zFiEKG7/tVGAp4I4KymFglMe8=;
	b=MH0l6zGUY9utQXE1DGCKjqyLqrWte4exaR0J6+XfOBbprE2CFgdU5mfsklqRYkqVFO1JRv
	9wIVq/qa+/jf7iZdMvT2alHs7nT5Ph6+j+xX0qCNQDQwCZ4L9A/F3P9x444RLJxD6BZL3/
	wLU5IAZhaaJQ+zl3MTa0LBjawm5pkus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722422614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZQgYysW88ClS7mhe8zFiEKG7/tVGAp4I4KymFglMe8=;
	b=etc3uqsc8n8wEr5oD7djCGlpgIyj1T1wS1a1HT5CTObqYpdxPBKpL2kq1Gv/6h5NR+rL4q
	BUqgl9utH7bs3tCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722422614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZQgYysW88ClS7mhe8zFiEKG7/tVGAp4I4KymFglMe8=;
	b=MH0l6zGUY9utQXE1DGCKjqyLqrWte4exaR0J6+XfOBbprE2CFgdU5mfsklqRYkqVFO1JRv
	9wIVq/qa+/jf7iZdMvT2alHs7nT5Ph6+j+xX0qCNQDQwCZ4L9A/F3P9x444RLJxD6BZL3/
	wLU5IAZhaaJQ+zl3MTa0LBjawm5pkus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722422614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JZQgYysW88ClS7mhe8zFiEKG7/tVGAp4I4KymFglMe8=;
	b=etc3uqsc8n8wEr5oD7djCGlpgIyj1T1wS1a1HT5CTObqYpdxPBKpL2kq1Gv/6h5NR+rL4q
	BUqgl9utH7bs3tCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88EB413297;
	Wed, 31 Jul 2024 10:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RgYAIFYVqmaSMAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 31 Jul 2024 10:43:34 +0000
Date: Wed, 31 Jul 2024 12:44:11 +0200
Message-ID: <87v80lyh6s.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v1] ALSA: hda: cs35l41: Stop creating ALSA Controls for firmware coefficients
In-Reply-To: <551e3be0-f436-4db1-ae5c-1ad5a31f68c3@perex.cz>
References: <20240730143748.351651-1-sbinding@opensource.cirrus.com>
	<013bdb56-b940-4881-b881-ad12be7321d0@perex.cz>
	<87zfpxyht3.wl-tiwai@suse.de>
	<551e3be0-f436-4db1-ae5c-1ad5a31f68c3@perex.cz>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10

On Wed, 31 Jul 2024 12:36:19 +0200,
Jaroslav Kysela wrote:
> 
> On 31. 07. 24 12:30, Takashi Iwai wrote:
> > On Tue, 30 Jul 2024 16:55:19 +0200,
> > Jaroslav Kysela wrote:
> >> 
> >> On 30. 07. 24 16:37, Stefan Binding wrote:
> >>> Add a kernel parameter to allow coefficients to be exposed as ALSA controls.
> >>> 
> >>> When the CS35L41 loads its firmware, it has a number of controls to
> >>> affect its behaviour. Currently, these controls are exposed as ALSA
> >>> Controls by default.
> >>> 
> >>> However, nothing in userspace currently uses them, and is unlikely to
> >>> do so in the future, therefore we don't need to create ASLA controls
> >>> for them.
> >>> 
> >>> These controls can be useful for debug, so we can add a kernel
> >>> parameter to re-enable them if necessary.
> >>> 
> >>> Disabling these controls would prevent userspace from trying to read
> >>> these controls when the CS35L41 is hibernating, which ordinarily
> >>> would result in an error message.
> >> 
> >> This is probably not a right argument to add this code. The codec
> >> should be powered up when those controls are accessed or those
> >> controls should be cached by the driver.
> >> 
> >> Although the controls have not been used yet, exposing them in this
> >> way is not ideal.
> >> 
> >> Could you fix the driver (no I/O errors)?
> > 
> > While we should fix the potential errors at hibernation, it's not bad
> > to hide those controls, IMO.  For the normal use cases, it's nothing
> > but a cause of troubles, after all.
> 
> I do not think that the situation is so obvious. Different
> coefficients can be used in various UCM profiles for example.

If that's the supposed use-case, yes.
I doubt it, though, but this needs clarification from Cirrus people.

> But for debugging we have debugfs when the developer thinks that the
> feature is not useful for users. The module parameter solution is not
> good in my eyes.

Yeah, I believe we should disable it unconditionally, and provide a
different way like debugfs in the firmware driver side, too -- again,
if the exposure is only for debugging.


Takashi

