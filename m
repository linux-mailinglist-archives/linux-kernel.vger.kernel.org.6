Return-Path: <linux-kernel+bounces-284643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4235395037B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1E0B2108B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87886198E6E;
	Tue, 13 Aug 2024 11:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2CQbTlAl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oh4EH4+j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2CQbTlAl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oh4EH4+j"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F82233A;
	Tue, 13 Aug 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548061; cv=none; b=Upcn2NBcnw8Vpf68wvwIq5Fq0qNeY7tFQCKgsUD2E3BSrHJwfCyMDyps118UWajD7mpkrNcodk54SgBrr90YRjqrNminGHpvD0vZRLqGu4qOslTzm4Pyxa8s6MVlpDeZokyX7yELl5zhlt8ESxIeYGmtvwRrRRs0y4SXCvH/Hso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548061; c=relaxed/simple;
	bh=3kJOXslTf0aT+y2O+2l2OOiTEJwmT65z1bNrv99Nq9s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulMuLub39iYUGKWsbIbgPTtCaMCTO552kn+CoMR3c40RmhICXVDo3/CdHeGe+y6guU0kQDy9mQAAr1cAjDpoqKnkcQAYNAmKx71B7XDcH/DXaUJW/af6N1R8ggnTdcl+hPVHTtorakE356CsKNjCbFYr8VFHKxNFg6ZG1nlI3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2CQbTlAl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oh4EH4+j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2CQbTlAl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oh4EH4+j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2AB4C2039B;
	Tue, 13 Aug 2024 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723548058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6m7/XcMcRcJ2DPL8Wpalx9jcjHcF/xwnDFNwr9fCKo4=;
	b=2CQbTlAlFEdWiz9og2n2OIFbZuv2d573yVJ7MEuZ/VHnZ8n7DHa2hxwzauv7lBGoFG0CF7
	yo4NRpLV3o7UiKNdPj4/FWSOLCpH65CkQNnSRcAy22+xq/vI7ApDZh+8ZAbCSkq2WpVAX4
	eCuALIWoGlUkL5o57A8rHquTcHJTu1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723548058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6m7/XcMcRcJ2DPL8Wpalx9jcjHcF/xwnDFNwr9fCKo4=;
	b=oh4EH4+j6ObPB1S6yEb0glJr7IX3uHW4yiQlc6V2e5QC1DEXbaLRc9LT7MklLwz4l/Q4ll
	gONgVsdOoOox62CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723548058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6m7/XcMcRcJ2DPL8Wpalx9jcjHcF/xwnDFNwr9fCKo4=;
	b=2CQbTlAlFEdWiz9og2n2OIFbZuv2d573yVJ7MEuZ/VHnZ8n7DHa2hxwzauv7lBGoFG0CF7
	yo4NRpLV3o7UiKNdPj4/FWSOLCpH65CkQNnSRcAy22+xq/vI7ApDZh+8ZAbCSkq2WpVAX4
	eCuALIWoGlUkL5o57A8rHquTcHJTu1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723548058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6m7/XcMcRcJ2DPL8Wpalx9jcjHcF/xwnDFNwr9fCKo4=;
	b=oh4EH4+j6ObPB1S6yEb0glJr7IX3uHW4yiQlc6V2e5QC1DEXbaLRc9LT7MklLwz4l/Q4ll
	gONgVsdOoOox62CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0808113ABD;
	Tue, 13 Aug 2024 11:20:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vnxeAZpBu2aUawAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Aug 2024 11:20:58 +0000
Date: Tue, 13 Aug 2024 13:21:30 +0200
Message-ID: <87o75wmzwl.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Remove redundant call to hda_cs_dsp_control_remove()
In-Reply-To: <20240813110750.2814-1-rf@opensource.cirrus.com>
References: <20240813110750.2814-1-rf@opensource.cirrus.com>
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
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 13 Aug 2024 13:07:50 +0200,
Richard Fitzgerald wrote:
> 
> The driver doesn't create any ALSA controls for firmware controls, so it
> shouldn't be calling hda_cs_dsp_control_remove().
> 
> commit 34e1b1bb7324 ("ALSA: hda: cs35l56: Stop creating ALSA controls for
> firmware coefficients") removed the call to hda_cs_dsp_add_controls() but
> didn't remove the call for destroying those controls.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: 34e1b1bb7324 ("ALSA: hda: cs35l56: Stop creating ALSA controls for firmware coefficients")

Applied now.

I suppose you'll submit the fix for cs35l41, too?


thanks,

Takashi

