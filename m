Return-Path: <linux-kernel+bounces-326306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9007897664F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C281B2185D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0292219F42C;
	Thu, 12 Sep 2024 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Js2fqRSf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gOFEknf2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Js2fqRSf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gOFEknf2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B475919341C;
	Thu, 12 Sep 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135487; cv=none; b=Ejg7p2fuVILD5wOOsIBYtMBbNZsCjWe0Ah5tz0TGHXH4iIp2fyM/0KNF/shdqWIXBWuTC3psfydWZaEYKZuWjWlzWqxfC25DujCHJfBEyqP+oj/dbno3LvnuE91IQu8WHvUgd0jgr9sPxziqUvMCeeLq47Ghb/kdrzAoTnzfuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135487; c=relaxed/simple;
	bh=ogvSFFSm7bsuGcIAX+zX4t5EIqX9rz45vkV1Vw1w0Q0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVacEdZ2DSLAQCagMOseDGKk3M8Ns3SA38FFd6fdQvluZRxPGSATXTPEiCM4knr1jhlQlhaJzIQirENDKdl+DUvYngo4JE9M+xRLRMCiegB/n+LchB6RU2dLFIOeJ/nQmg0BuKmDz6X3X0g0OO6vQHJbnTzM5HN6C5cj0C50CQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Js2fqRSf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gOFEknf2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Js2fqRSf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gOFEknf2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9504F21AA4;
	Thu, 12 Sep 2024 10:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726135483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpWTLo4PiQ/ADwGe8YGgwnxDcDKej5qqjnNe59NmPlk=;
	b=Js2fqRSfWmWD+vWHuIZQNqOHkzhT9jpWFBrAAOHwGEBAf+cN+OV2c1zuSNj8BRE/TEA6Or
	06GaTnK34HMdhdxbFEDXLvQCvLvwV/+F4jdyT8bkzQigfuwSc6fUxcQZoMawcBKztmWvgG
	rkZMTuz3iRR32MlLWdxtVd31Gn/txJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726135483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpWTLo4PiQ/ADwGe8YGgwnxDcDKej5qqjnNe59NmPlk=;
	b=gOFEknf2aPxPGNHRWKxnoqYnR0+yk7p1uOCJizbxUJzW+LggluBSW6E95gt0G8PHrNCQhX
	OrI7xkN1ceOcLTBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726135483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpWTLo4PiQ/ADwGe8YGgwnxDcDKej5qqjnNe59NmPlk=;
	b=Js2fqRSfWmWD+vWHuIZQNqOHkzhT9jpWFBrAAOHwGEBAf+cN+OV2c1zuSNj8BRE/TEA6Or
	06GaTnK34HMdhdxbFEDXLvQCvLvwV/+F4jdyT8bkzQigfuwSc6fUxcQZoMawcBKztmWvgG
	rkZMTuz3iRR32MlLWdxtVd31Gn/txJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726135483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IpWTLo4PiQ/ADwGe8YGgwnxDcDKej5qqjnNe59NmPlk=;
	b=gOFEknf2aPxPGNHRWKxnoqYnR0+yk7p1uOCJizbxUJzW+LggluBSW6E95gt0G8PHrNCQhX
	OrI7xkN1ceOcLTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 501E913A73;
	Thu, 12 Sep 2024 10:04:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1G3uEbu84mYFLgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 12 Sep 2024 10:04:43 +0000
Date: Thu, 12 Sep 2024 12:05:31 +0200
Message-ID: <87v7z1yyok.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ALSA: control: prevent some integer overflow issues
In-Reply-To: <0f03d569-9804-4617-a806-f0e5c32399fb@stanley.mountain>
References: <0f03d569-9804-4617-a806-f0e5c32399fb@stanley.mountain>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,linaro.org:email]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Thu, 12 Sep 2024 10:51:14 +0200,
Dan Carpenter wrote:
> 
> I believe the this bug affects 64bit systems as well, but analyzing this
> code is easier if we assume that we're on a 32bit system.  The problem is
> in snd_ctl_elem_add() where we do:
> 
> sound/core/control.c
>   1669          private_size = value_sizes[info->type] * info->count;
>   1670          alloc_size = compute_user_elem_size(private_size, count);
>                                                                   ^^^^^
> count is info->owner.  It's a non-zero u32 that comes from the user via
> snd_ctl_elem_add_user().  So the math in compute_user_elem_size() could
> have an integer overflow resulting in a smaller than expected size.

So this should also use the overflow macro, too, in addition to your
changes?  Something like:

--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1618,7 +1618,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	struct snd_kcontrol *kctl;
 	unsigned int count;
 	unsigned int access;
-	long private_size;
+	size_t private_size;
 	size_t alloc_size;
 	struct user_element *ue;
 	unsigned int offset;
@@ -1666,7 +1666,7 @@ static int snd_ctl_elem_add(struct snd_ctl_file *file,
 	/* user-space control doesn't allow zero-size data */
 	if (info->count < 1)
 		return -EINVAL;
-	private_size = value_sizes[info->type] * info->count;
+	private_size = array_size(value_sizes[info->type], info->count);
 	alloc_size = compute_user_elem_size(private_size, count);
 
 	guard(rwsem_write)(&card->controls_rwsem);


thanks,

Takashi

> 
>   1671
>   1672          guard(rwsem_write)(&card->controls_rwsem);
>   1673          if (check_user_elem_overflow(card, alloc_size))
> 
> The math is check_user_elem_overflow() can also overflow.  Additionally,
> large positive values are cast to negative and thus do not exceed
> max_user_ctl_alloc_size so they are treated as valid.  It should be the
> opposite, where negative sizes are invalid.
> 
>   1674                  return -ENOMEM;
> 
> Fixes: 2225e79b9b03 ("ALSA: core: reduce stack usage related to snd_ctl_new()")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  sound/core/control.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/core/control.c b/sound/core/control.c
> index 4f55f64c42e1..f36af27e68d5 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -1397,9 +1397,9 @@ struct user_element {
>  };
>  
>  // check whether the addition (in bytes) of user ctl element may overflow the limit.
> -static bool check_user_elem_overflow(struct snd_card *card, ssize_t add)
> +static bool check_user_elem_overflow(struct snd_card *card, size_t add)
>  {
> -	return (ssize_t)card->user_ctl_alloc_size + add > max_user_ctl_alloc_size;
> +	return size_add(card->user_ctl_alloc_size, add) > max_user_ctl_alloc_size;
>  }
>  
>  static int snd_ctl_elem_user_info(struct snd_kcontrol *kcontrol,
> @@ -1593,7 +1593,7 @@ static int snd_ctl_elem_init_enum_names(struct user_element *ue)
>  
>  static size_t compute_user_elem_size(size_t size, unsigned int count)
>  {
> -	return sizeof(struct user_element) + size * count;
> +	return size_add(sizeof(struct user_element), size_mul(size, count));
>  }
>  
>  static void snd_ctl_elem_user_free(struct snd_kcontrol *kcontrol)
> -- 
> 2.45.2
> 

