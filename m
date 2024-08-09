Return-Path: <linux-kernel+bounces-280587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E31F94CC7A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22F61C220C5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC48618EFC1;
	Fri,  9 Aug 2024 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZYekwGaQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wcRnPAI2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZYekwGaQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wcRnPAI2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE5112FB34;
	Fri,  9 Aug 2024 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192922; cv=none; b=paCNUK9E9p+ocU6Mj42TlHb1oOK34dl7vaImLZ4xQy75P2HEHxO5hKNzaHOLfPw2hQwDhw8ZnTznVKnwOnzj5VyS4RNuD/Ct84FeTidzuA06HEs+PxnoBAdhhsinapBJqpNucVWingslELHQJv1v/RVcnK8+80Q7PSnU0vtNzfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192922; c=relaxed/simple;
	bh=Lsrix0a9mPAkh++sDpeUPRDGIMXvv+WDXlhgbmW2LXY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWFvCkQ8EuU/prXQy9IW8Mh87eu+rArwQZ3yXAb51Qj3ncvLeqjJRW0EDLU3D4fgxQYe081yRNkZ3hzEz76CXMQwwudKx8VdPCUlBYVc6Ng70rtrT5rTKko+OOXQvHFMqKrCP953CzEWZ+RpYsxBOhTFPkmrUjrWr5lYyf5tFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZYekwGaQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wcRnPAI2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZYekwGaQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wcRnPAI2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B397D21EF6;
	Fri,  9 Aug 2024 08:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723192918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRiurSnhbX0Q0d4QpIJcDdBXPtjc29Jx8x6UeMt8HO8=;
	b=ZYekwGaQc3Pn2w66kA9qJvI12iyHfEtvTHrOJU6CDDld4uuFOXjIBl6DtqYpr+iE+2rEab
	pgekBwbAhr7obK8ktk0hyP7wJJAw7JBZjtuP9BxVZSRP/gFKSCByKlSiyV8EeerucZ2Zji
	wr3+1o0TSOgXodUlu7BjMk1OikBV98M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723192918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRiurSnhbX0Q0d4QpIJcDdBXPtjc29Jx8x6UeMt8HO8=;
	b=wcRnPAI2xdlVPfQpoRqCgJsmawCUrh34oCFGWkOnB8GkjT0e8KcLlysiuqDio0+bYCjFpj
	Go3QCpi5WE6XaBDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZYekwGaQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wcRnPAI2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723192918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRiurSnhbX0Q0d4QpIJcDdBXPtjc29Jx8x6UeMt8HO8=;
	b=ZYekwGaQc3Pn2w66kA9qJvI12iyHfEtvTHrOJU6CDDld4uuFOXjIBl6DtqYpr+iE+2rEab
	pgekBwbAhr7obK8ktk0hyP7wJJAw7JBZjtuP9BxVZSRP/gFKSCByKlSiyV8EeerucZ2Zji
	wr3+1o0TSOgXodUlu7BjMk1OikBV98M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723192918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRiurSnhbX0Q0d4QpIJcDdBXPtjc29Jx8x6UeMt8HO8=;
	b=wcRnPAI2xdlVPfQpoRqCgJsmawCUrh34oCFGWkOnB8GkjT0e8KcLlysiuqDio0+bYCjFpj
	Go3QCpi5WE6XaBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7569213A7D;
	Fri,  9 Aug 2024 08:41:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xtA5G1bWtWZ6KAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 09 Aug 2024 08:41:58 +0000
Date: Fri, 09 Aug 2024 10:42:37 +0200
Message-ID: <87seve6q9u.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Amadeusz =?ISO-8859-2?Q?S=B3awi=F1ski?=
 <amadeuszx.slawinski@linux.intel.com>,	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ALSA: pcm: add support for 128kHz sample rate
In-Reply-To: <1jcymixfou.fsf@starbuckisacylon.baylibre.com>
References: <20240628122429.2018059-1-jbrunet@baylibre.com>
	<20240628122429.2018059-2-jbrunet@baylibre.com>
	<326792b9-e706-4ab0-a1e8-cc48943e357d@linux.intel.com>
	<874j99434a.wl-tiwai@suse.de>
	<1j4j90hurv.fsf@starbuckisacylon.baylibre.com>
	<87ed84rnk7.wl-tiwai@suse.de>
	<1jcymixfou.fsf@starbuckisacylon.baylibre.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,suse.com,perex.cz,alsa-project.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: B397D21EF6

On Fri, 09 Aug 2024 10:29:05 +0200,
Jerome Brunet wrote:
> 
> 
> >> 
> >> Apart from the problem reported in sound/usb/caiaq/audio.c, is there
> >> another clean up expected ?
> >
> > The change for caiaq/audio.c is rather a "fix" :)
> > As a cleanup, I meant, whether this extension can be applied to the
> > other existing drivers that already use 128kHz with RATE_KNOT and an
> > extra list.
> 
> Grepping in sound/ for 128000, I've found only 3 files which could
> benefit from solely adding 128kHz to the defined rates:
> 
> * sound/pci/cmipci.c
> * sound/pci/rme9652/hdsp.c
> * sound/pci/rme9652/hdspm.c
> 
> The rest are unsing other rates which require the use of RATE_KNOT.
> The most regular rates being 12kHz and 24kHz. Adding those as well could
> help in:
> 
> * sound/soc/codecs/adau1977.c
> * sound/soc/fsl/fsl_asrc.c
> * sound/soc/fsl/fsl_easrc.c
> * sound/soc/intel/avs/pcm.c
> 
> I admit that's a fairly low number of drivers, maybe it is not worth it
> at this stage.
> 
> Takashi, Mark, what is your preference ? Should I:
>  * tweak the spdif codec to use RATE_KNOT ?
>  * add just 128kHz, fixing the 3 file above ?
>  * add 12 and 24kHz as well ?
> 
> I don't really mind one way or the other.

If there are multiple instances, it's fine to extend the standards.
Then we can clean up them as well.


thanks,

Takashi

