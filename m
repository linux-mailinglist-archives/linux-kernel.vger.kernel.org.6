Return-Path: <linux-kernel+bounces-229059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E7C916A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C907D1F22697
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEA4176FB2;
	Tue, 25 Jun 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="118XsX4c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5x0tBgGB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="118XsX4c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5x0tBgGB"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571B176FA7;
	Tue, 25 Jun 2024 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325557; cv=none; b=huceT+1VPbfkjV13Ou3+dY4DL+mpdItmYxxAqFCwWOVmyqg/dmVzJyGYlFe3dfPc9ifdvDvQ6t/wBIF5x8G1ol3hlc/pmADhDceyVSnavtfNCMHTxY38r7MmCFkrmmwIrL3arbLaXE1WIAYGHirb9dyL9JRQTPOUli7w8bgXjgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325557; c=relaxed/simple;
	bh=m6PWOWp/hNkt3iN22+iRD/P4J010HMxBMpdZByi81YM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4/80F0IYh6BtvQ6hStEbON0CqRA8PhP6pDTJ7Oj6w+V7P4c4J4Az1YgBZhJWOfTm21HGZeqqmbZrmYUtQ0toxeBYqmrZYdV2yZQuBQQMqYUun65DUt8TQxtQtTUhLCTS0MjBY2UM/0HKvN2hWBh4UiLL6D1V3CIwYy2gMSssME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=118XsX4c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5x0tBgGB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=118XsX4c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5x0tBgGB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F41241F88B;
	Tue, 25 Jun 2024 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719325554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/zhzKQU/pPdoICo/ozlTnhxdzCab8RfWqCotEqhN9A=;
	b=118XsX4cUv5qk7X5aWXsBfHPVGoPwUTUVsKIlDjzmDt3XwP88Pa8JcBlc5A3dGziaj+j6U
	0eSK/wRHBpiqgI6LmvVPcgkEWuzvXsHCr70E0OOXkae4n3PrSkbxjgKSym1Li7WreSVtIj
	6NLcdWwwXJp6YJa93cZYbK0UUKZWv+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719325554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/zhzKQU/pPdoICo/ozlTnhxdzCab8RfWqCotEqhN9A=;
	b=5x0tBgGBedVEaWjkEfLNW8O5i7KvLOG4jN4jX9mV6d1NfaYUB6clNU2a73IbQF72NpQgXO
	t/Q3LJAEcfpxsOAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719325554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/zhzKQU/pPdoICo/ozlTnhxdzCab8RfWqCotEqhN9A=;
	b=118XsX4cUv5qk7X5aWXsBfHPVGoPwUTUVsKIlDjzmDt3XwP88Pa8JcBlc5A3dGziaj+j6U
	0eSK/wRHBpiqgI6LmvVPcgkEWuzvXsHCr70E0OOXkae4n3PrSkbxjgKSym1Li7WreSVtIj
	6NLcdWwwXJp6YJa93cZYbK0UUKZWv+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719325554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R/zhzKQU/pPdoICo/ozlTnhxdzCab8RfWqCotEqhN9A=;
	b=5x0tBgGBedVEaWjkEfLNW8O5i7KvLOG4jN4jX9mV6d1NfaYUB6clNU2a73IbQF72NpQgXO
	t/Q3LJAEcfpxsOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF8F31384C;
	Tue, 25 Jun 2024 14:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1qomLnHTembfKwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 25 Jun 2024 14:25:53 +0000
Date: Tue, 25 Jun 2024 16:26:21 +0200
Message-ID: <87msn9ksj6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Rauty <rautyrauty@gmail.com>
Cc: wzhd@ustc.edu,
	Gergo Koteles <soyer@irl.hu>,
	alsa-devel@alsa-project.org,
	tiwai@suse.com,
	perex@perex.cz,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	simont@opensource.cirrus.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable headset mic on IdeaPad 330-17IKB 81DM
In-Reply-To: <CAGpJQTGR5WKuHUFGFUC286TUkOXYgcqigZRDb4K5deyE9uuz8w@mail.gmail.com>
References: <20240615125457.167844-1-rauty@altlinux.org>
	<2c9ba341bc95d4b9010bf5f8794c0d14b1c57dc9.camel@irl.hu>
	<CAGpJQTHoBAixmxta2WuZfjHjiK9GXF=hkfPyV7PBD5rt9Z_0WA@mail.gmail.com>
	<CAGpJQTGqxEkfp003QLsp-syUgzDFCmHSmNaoOaem0ZMVf7_=bg@mail.gmail.com>
	<c0a9e15e7926e098bdea97a7d31c32427e0910c9.camel@irl.hu>
	<871q4lm9dp.wl-tiwai@suse.de>
	<CAGpJQTFF=gKN2h105dGhBOEhN0Q1Tpj5hJWpSdQ_-nCoUTzj5A@mail.gmail.com>
	<87tthhktdz.wl-tiwai@suse.de>
	<87sex1kt6t.wl-tiwai@suse.de>
	<CAGpJQTGR5WKuHUFGFUC286TUkOXYgcqigZRDb4K5deyE9uuz8w@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[suse.de:email,alsa-info.sh:url,imap1.dmz-prg2.suse.org:helo];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,alsa-info.sh:url,alsa-project.org:url,imap1.dmz-prg2.suse.org:helo]

On Tue, 25 Jun 2024 16:16:56 +0200,
Rauty wrote:
> 
> On Tue, 25 Jun 2024 at 17:11, Takashi Iwai <tiwai@suse.de> wrote:
> > Zihao, do you still have the access to this machine?
> > If yes, could you give alsa-info.sh output, or a proc file output?
> 
> He sent it to me:
> https://alsa-project.org/db/?f=268601dbdb76f9a4c18d71e210091ffed4bf2818

Great.  Could you also give the one for IdeaPad 330?


thanks,

Takashi

