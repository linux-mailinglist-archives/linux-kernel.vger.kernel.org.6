Return-Path: <linux-kernel+bounces-268989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CFB942BF1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 466A01C22EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA67B1AB537;
	Wed, 31 Jul 2024 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lKgP2ubq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="47hLUtRx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lKgP2ubq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="47hLUtRx"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979FD161311;
	Wed, 31 Jul 2024 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421815; cv=none; b=OM24V6JRMSl2R8BKCJbpanu+PKJDpAnGoYzDbtFZPAC7JQZMbQExjO4MutKPi4jR0UqHhqY63b5snQ1HynTowqlu2BBSYyh898xkRrcIYzMJY5MM5gO7nlgJnuvN8ypS2zTMdtoq/RJqhJtUon+ZCA823LazWbai4bTwubMxvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421815; c=relaxed/simple;
	bh=Ncb9CTSSLlmKgoCRZiTaArzwVM7o0BSNdYG6IQTySMY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ai/xIBDhdkhoGdgcy7B3Quk7iJZ0LE4m+/Ypwa8rI+sA1lg9XHiYdWBhss4y3Pwco05x4C0u6IpEA0NcOtdrP+L8YyYtIWWx/brZHJFsyv4w/gVQsv4cq35M2kNr48ODWVm8ya8Fr1lPPT4Ly2ZwKwCW5E7uFYfI+6CChI3Ut/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lKgP2ubq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=47hLUtRx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lKgP2ubq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=47hLUtRx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C6A4221CD6;
	Wed, 31 Jul 2024 10:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722421811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zApTDqqRMnQ88tdecMBReesZBZBFTQO5WdcU+17HzM=;
	b=lKgP2ubq1Qv+W7jxtJwq2uetX5S0ThzTrZQO6BScyvxNPFEFmG//Ba/XqxXvN6mBP8gA5Q
	/O8xAHMOE1GOVfF2rAiAzTzdfvUVZILJF7CFy9DhS0bOTFo9o8VmhqKWzj4vMzXJhCrO4T
	ujqwF+Q3WxxMj4EcODUQAnopjsIIdtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722421811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zApTDqqRMnQ88tdecMBReesZBZBFTQO5WdcU+17HzM=;
	b=47hLUtRxrkijK5iaAKklCEckDnKtvard7qgPjbs1XdUFgblEk2ZnR4iCAT0KEwl8bK6F0c
	qXxfIE49WFi2F4Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722421811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zApTDqqRMnQ88tdecMBReesZBZBFTQO5WdcU+17HzM=;
	b=lKgP2ubq1Qv+W7jxtJwq2uetX5S0ThzTrZQO6BScyvxNPFEFmG//Ba/XqxXvN6mBP8gA5Q
	/O8xAHMOE1GOVfF2rAiAzTzdfvUVZILJF7CFy9DhS0bOTFo9o8VmhqKWzj4vMzXJhCrO4T
	ujqwF+Q3WxxMj4EcODUQAnopjsIIdtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722421811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zApTDqqRMnQ88tdecMBReesZBZBFTQO5WdcU+17HzM=;
	b=47hLUtRxrkijK5iaAKklCEckDnKtvard7qgPjbs1XdUFgblEk2ZnR4iCAT0KEwl8bK6F0c
	qXxfIE49WFi2F4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A6DB13297;
	Wed, 31 Jul 2024 10:30:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZEKdIDMSqmYHLQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 31 Jul 2024 10:30:11 +0000
Date: Wed, 31 Jul 2024 12:30:48 +0200
Message-ID: <87zfpxyht3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v1] ALSA: hda: cs35l41: Stop creating ALSA Controls for firmware coefficients
In-Reply-To: <013bdb56-b940-4881-b881-ad12be7321d0@perex.cz>
References: <20240730143748.351651-1-sbinding@opensource.cirrus.com>
	<013bdb56-b940-4881-b881-ad12be7321d0@perex.cz>
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

On Tue, 30 Jul 2024 16:55:19 +0200,
Jaroslav Kysela wrote:
> 
> On 30. 07. 24 16:37, Stefan Binding wrote:
> > Add a kernel parameter to allow coefficients to be exposed as ALSA controls.
> > 
> > When the CS35L41 loads its firmware, it has a number of controls to
> > affect its behaviour. Currently, these controls are exposed as ALSA
> > Controls by default.
> > 
> > However, nothing in userspace currently uses them, and is unlikely to
> > do so in the future, therefore we don't need to create ASLA controls
> > for them.
> > 
> > These controls can be useful for debug, so we can add a kernel
> > parameter to re-enable them if necessary.
> > 
> > Disabling these controls would prevent userspace from trying to read
> > these controls when the CS35L41 is hibernating, which ordinarily
> > would result in an error message.
> 
> This is probably not a right argument to add this code. The codec
> should be powered up when those controls are accessed or those
> controls should be cached by the driver.
> 
> Although the controls have not been used yet, exposing them in this
> way is not ideal.
> 
> Could you fix the driver (no I/O errors)?

While we should fix the potential errors at hibernation, it's not bad
to hide those controls, IMO.  For the normal use cases, it's nothing
but a cause of troubles, after all.


thanks,

Takashi

