Return-Path: <linux-kernel+bounces-262222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E957B93C2B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74324B21CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CA519AD7D;
	Thu, 25 Jul 2024 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="agEgf15+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gNKq+b1Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="agEgf15+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gNKq+b1Q"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97571132492;
	Thu, 25 Jul 2024 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721912985; cv=none; b=s9jpuTFfT9KXO8lvg8+6zDpxfy8KYdJ54S77ykfDV52nb7Eipf4uyped960FogG0AvJYlxn6PzMRWvFZpWKRCM7iQbfWNi5t3mrP/nrJP7c9UwviOnt+U1xJT/c/9zq0p4njTTx6xrMt+TQLPrCaBSpZl2OH60dbu7XuuaV/zlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721912985; c=relaxed/simple;
	bh=n1gUr2c4GQu5jNGebTPfPhLof3eEJ04vnF3m/uM8RPg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkX9uDoUKJ1HpYUylJUZvlnlZ0aqPeE3+o3UsSCiAF+oxfr9LlpPilnxzl4hL4E9Nm8W9QaMPpTJKNCpJVPF8qTl1jjr/xKwYzQec+ZLpjCR8KHeCxdAb0f3iUTc4ZIaqJPK05cYv92JGEAPFgowWp48kvmsWAW6QqnvRGgxax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=agEgf15+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gNKq+b1Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=agEgf15+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gNKq+b1Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B61F81F45A;
	Thu, 25 Jul 2024 13:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721912981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QKjiNMrsBhBaZ0D8OVqE+BfZnp5dRRJ+v/JWkSJHC9c=;
	b=agEgf15+fX52b43Kz9PD/y77GRLe3F7aQ0VbOd7anvpMOoubM2Hk92S+CrDGR0Wlf7HYw/
	6bRSHfq5Pewm6vE497jxSJ+oEXTmm0dNhCBLvQ2c06SJRB74b1UIb9h0DWqFEdG4kf84fY
	LOkx8B2kohdpMkBV7LjDxl+Jwsv0H1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721912981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QKjiNMrsBhBaZ0D8OVqE+BfZnp5dRRJ+v/JWkSJHC9c=;
	b=gNKq+b1QMPu1QCFADYdDmBWO76i31LVeCWbIl2ry1r3W1y7kBCuqOf0YlKuWKWOj21sZOc
	qXYfOJfmJtjj8gAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721912981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QKjiNMrsBhBaZ0D8OVqE+BfZnp5dRRJ+v/JWkSJHC9c=;
	b=agEgf15+fX52b43Kz9PD/y77GRLe3F7aQ0VbOd7anvpMOoubM2Hk92S+CrDGR0Wlf7HYw/
	6bRSHfq5Pewm6vE497jxSJ+oEXTmm0dNhCBLvQ2c06SJRB74b1UIb9h0DWqFEdG4kf84fY
	LOkx8B2kohdpMkBV7LjDxl+Jwsv0H1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721912981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QKjiNMrsBhBaZ0D8OVqE+BfZnp5dRRJ+v/JWkSJHC9c=;
	b=gNKq+b1QMPu1QCFADYdDmBWO76i31LVeCWbIl2ry1r3W1y7kBCuqOf0YlKuWKWOj21sZOc
	qXYfOJfmJtjj8gAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C38213874;
	Thu, 25 Jul 2024 13:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SnbxHJVOomZRewAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 25 Jul 2024 13:09:41 +0000
Date: Thu, 25 Jul 2024 15:10:16 +0200
Message-ID: <87plr1ipmv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: soxiebing <soxiebing@163.com>
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	songxiebing <songxiebing@kylinos.cn>,
	bo liu <bo.liu@senarytech.com>
Subject: Re: [PATCH] ALSA: hda: conexant: Fix headset auto detect fail in the polling mode
In-Reply-To: <20240725082610.45504-1-soxiebing@163.com>
References: <20240725082610.45504-1-soxiebing@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-0.10 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -0.10

On Thu, 25 Jul 2024 10:26:10 +0200,
soxiebing wrote:
> 
> From: songxiebing <songxiebing@kylinos.cn>
> 
> 'Fixes: 7aeb25908648 ("Fix headset auto detect fail in cx8070 and SN6140")'

The Fixes tag should be put around Signed-off-by.
Also drop the quote ''.

> This patch only handles the unsol_event reporting during interrupts
> and does not include the polling mode used to set jackroll_ms, so
> it's changed to use snd_hda_jack_detect-enable_callback function.

If you mean about the commit above as "this patch", better to
rephrase to be clearer.

The code change itself looks good, through a quick glance.

Could you try to improve the patch description and resubmit?


thanks,

Takashi

