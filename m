Return-Path: <linux-kernel+bounces-254914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5702693393B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB346B21F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470539AE3;
	Wed, 17 Jul 2024 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pxa78rQj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GWmGvZw7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pxa78rQj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GWmGvZw7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C038F97;
	Wed, 17 Jul 2024 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205586; cv=none; b=foZ/bBntqIQKcOZB+GIeCpBAakUSolaC3B0PNHU+WvMoI4iyMd4Wxq8w9lpaXzSHg0tkCVu0U6ahfIJK1GDti9MfUqByPH5vyu2dOdRGnRRgNStgwTPXbMR5mUwILmjpInI22sDDxU9Z/+0sbqMfl3V8IdtNssOPrLUn/haAi8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205586; c=relaxed/simple;
	bh=opPt7tqdT8LfI+IabmLzugjEK+EwOUpc8JG+FLZUkAs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=geikVEu+qymdHCCup5Tug9WH1LEkPgq5qAflyl9XFIhpIqbyZ14YocR9QO7eYqIkSQ9jHS2WitmrhNopeBtucySKJByocCLQT/DCw2+kgMtLBvPCiGOQToe/x4wgWjI2Rwt9AwkoDk6QEtpZ0rl7O3ex0zqlelUYjH0H7oPCFuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pxa78rQj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GWmGvZw7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pxa78rQj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GWmGvZw7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 606CE21B48;
	Wed, 17 Jul 2024 08:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721205583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWd77CskmZAw29o1fnPllLrLsoYpfLesmhhj3Kakj/E=;
	b=pxa78rQj+nX9KXEEB6YNzJPZuY1dvGoDwIBF3G4/JXiUYv3/EqHWprGj7JV8APvb3v8a+c
	9btJdgY2D6i0VYZGmPK37UsKZk7wGcPrpvj4zUIkfthoYWDvbKTX1IAj6w/AWRu+/wJbVe
	MHReJvZ0GjowdiimMEzzKVB7Halp5LA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721205583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWd77CskmZAw29o1fnPllLrLsoYpfLesmhhj3Kakj/E=;
	b=GWmGvZw7pLd9+mfqz7ssyUO63zC7WhKK80q6aRwea4Xpg3tVO0tWTQj8K+bQJSxvFlAXX4
	aK5Me0k/Pt1Y0CAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pxa78rQj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GWmGvZw7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721205583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWd77CskmZAw29o1fnPllLrLsoYpfLesmhhj3Kakj/E=;
	b=pxa78rQj+nX9KXEEB6YNzJPZuY1dvGoDwIBF3G4/JXiUYv3/EqHWprGj7JV8APvb3v8a+c
	9btJdgY2D6i0VYZGmPK37UsKZk7wGcPrpvj4zUIkfthoYWDvbKTX1IAj6w/AWRu+/wJbVe
	MHReJvZ0GjowdiimMEzzKVB7Halp5LA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721205583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aWd77CskmZAw29o1fnPllLrLsoYpfLesmhhj3Kakj/E=;
	b=GWmGvZw7pLd9+mfqz7ssyUO63zC7WhKK80q6aRwea4Xpg3tVO0tWTQj8K+bQJSxvFlAXX4
	aK5Me0k/Pt1Y0CAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 218FA1368F;
	Wed, 17 Jul 2024 08:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KdLbBk+Dl2a2FgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 17 Jul 2024 08:39:43 +0000
Date: Wed, 17 Jul 2024 10:40:15 +0200
Message-ID: <87y160xvgw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: lars@metafoo.de,
	perex@perex.cz,
	tiwai@suse.com,
	broonie@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH] ALSA: pcm_dmaengine: Don't synchronize DMA channel when DMA is paused
In-Reply-To: <1721198693-27636-1-git-send-email-shengjiu.wang@nxp.com>
References: <1721198693-27636-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[metafoo.de,perex.cz,suse.com,kernel.org,vger.kernel.org,alsa-project.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 606CE21B48

On Wed, 17 Jul 2024 08:44:53 +0200,
Shengjiu Wang wrote:
> 
> When suspended, the DMA channel may enter PAUSE state if dmaengine_pause()
> is supported by DMA.
> At this state, dmaengine_synchronize() should not be called, otherwise
> the DMA channel can't be resumed successfully.
> 
> Fixes: e8343410ddf0 ("ALSA: dmaengine: Synchronize dma channel after drop()")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Thanks, applied now.


Takashi

