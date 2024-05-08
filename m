Return-Path: <linux-kernel+bounces-173218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE158BFD33
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159A42837CA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5038A4C618;
	Wed,  8 May 2024 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A5DXGb1u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wOTWj4is";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JrNPEmWn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qy9DZuab"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FBA8F40;
	Wed,  8 May 2024 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715171623; cv=none; b=sAszNAgIoBHx5NawnGwcNXR66vUsWTkS6O+9IkxZPC8gDqrSWJ8F+tqDEsIjX/u0rb8lz8Rmgv6LfqkeYQuJSlVfiuAm/TspTWxr5mrVl5wvtDyEoGgxzfCiz3/F6N+T69++ZRlwtdGg2m+UEqgks4RSaYitKhS2ARJAQLKajcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715171623; c=relaxed/simple;
	bh=kce2VuM911zea0WWKrZ2+wtK3+AoRFxMWuJEmXU7RDw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/Ipbe08CeoAsORtbk+Nwsk6ndXQ1miUaNNwHQxUHjWrOxlXoo0gZ8qrGWbVIRpN3GM2KDngdj27rHf7iNbRBUN/8A8wCQxLH1DRGE9KI0Yl/MwoR66kjwM+ujiN1i2t9gThYcpx4KRxPKbiL1XUhIh3TR3HyIjSpcL2i5nPr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A5DXGb1u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wOTWj4is; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JrNPEmWn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qy9DZuab; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE870338EB;
	Wed,  8 May 2024 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715171619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IZED0/uUxjpa9QqexclyJrsYKjLLxeptrfiihIyhvys=;
	b=A5DXGb1uD6y75Ek6pRwaUHxYNQgh3kO2eVKsN697rMw+4gynG3fiwz8kwfnZqihljM51Ox
	48k6qJ4Ivhi3wli+rVRFYTSi/v7p4soJ1pv+JuWoEMfuH1RZj8zGeFtc0ONgsUXF6pGQT5
	Pj32B6g6vLfItxe3+JJMoWx4QCUULKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715171619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IZED0/uUxjpa9QqexclyJrsYKjLLxeptrfiihIyhvys=;
	b=wOTWj4isJ7EYMVY3XyMwnPp4t58frQbf1K4INoMGv8PCUZju+vkpwDZ2laaimbsCuIsU8g
	jlbo+ul+UK8vbVAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JrNPEmWn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Qy9DZuab
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715171618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IZED0/uUxjpa9QqexclyJrsYKjLLxeptrfiihIyhvys=;
	b=JrNPEmWnuJI2vmbtwXSUhSku2QevDGVlS0MboQzL7MEJsRWVeW3UIvagEt9ku9AwWktFdH
	/KkDq96YZkmsqJg5o09Nbd0zzE6PVhVR32RAC8rZZysaJPBVJiLGTC6ZD02JylvE683hsl
	u4vRUQ084g1lPlUNobyWV/zSuMaZ60M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715171618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IZED0/uUxjpa9QqexclyJrsYKjLLxeptrfiihIyhvys=;
	b=Qy9DZuab3G83VHtAJq5RBuKTBHDnAYUz9y0H8zt1v6kZ841S+EWLXaPWORh6zV77HSUIrx
	fpw705+B88wlMCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B46B61386E;
	Wed,  8 May 2024 12:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lNWRKiJxO2YUXQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 08 May 2024 12:33:38 +0000
Date: Wed, 08 May 2024 14:33:53 +0200
Message-ID: <875xvocwjy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>
Subject: Re: [PATCH] ALSA: hda/cs_dsp_ctl: Use private_free for control cleanup
In-Reply-To: <20240508095627.44476-1-rf@opensource.cirrus.com>
References: <20240508095627.44476-1-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.49
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EE870338EB
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.49 / 50.00];
	BAYES_HAM(-2.98)[99.89%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Wed, 08 May 2024 11:56:27 +0200,
Richard Fitzgerald wrote:
> 
> Use the control private_free callback to free the associated data
> block. This ensures that the memory won't leak, whatever way the
> control gets destroyed.
> 
> The original implementation didn't actually remove the ALSA
> controls in hda_cs_dsp_control_remove(). It only freed the internal
> tracking structure. This meant it was possible to remove/unload the
> amp driver while leaving its ALSA controls still present in the
> soundcard. Obviously attempting to access them could cause segfaults
> or at least dereferencing stale pointers.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: 3233b978af23 ("ALSA: hda: hda_cs_dsp_ctl: Add Library to support CS_DSP ALSA controls")
> ---
> This replaces my earlier "keep it simple" attempt at cleanup.
> I decided that implementing private_free is the only sensible
> way to fix the cleanup.

Applied now.  Thanks.


Takashi

