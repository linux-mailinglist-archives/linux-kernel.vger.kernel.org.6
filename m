Return-Path: <linux-kernel+bounces-301222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A324295EDF2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E97285E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7FE146A61;
	Mon, 26 Aug 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="foRn9Rjw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pX/D7tYO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="foRn9Rjw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pX/D7tYO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C0B12C544;
	Mon, 26 Aug 2024 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724666466; cv=none; b=kWEVuYsWvg/sM59dnFuG4L4PlzkBGLuwuE9NACyG3YQ7HUkQ0h44cFGmBYmPlSMlhYqh8d8yC7saviv8BzPFX978/gHhk+W6uhdpc/pIzAnNSu1ok9X02R/QwSRu8xwiEhWEjf+Jet7zVxZzkSvm2/zkjy+JiT31t3unNGHtWCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724666466; c=relaxed/simple;
	bh=Qa0x2aJ36ZI+30OPot7ebFxp+rXfMZB4d404jrw3rm0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o62OlgVitaRQNpBytjKjhfbMHyiPJ5VXawlFJBqbRp16LJo9fIDG2ZgKpVV7E3Q7SZ4xVV3zc+GtwDeLqa5EnFP1tmXx5IcNs+IInclxd/GN7Z6SuaORtqjU7sEldenZmVldltV9sYGZtDUQw0yURmHZfpRZcpyfR6gXEqx908k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=foRn9Rjw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pX/D7tYO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=foRn9Rjw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pX/D7tYO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1AB1219A7;
	Mon, 26 Aug 2024 10:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724666458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLjQvx1Iw+blgciXlCuxZQqPUe6hj0Rwui1+Ws1wEig=;
	b=foRn9Rjw8lBWdoRjRG9w8ErWJgqbknlt0K5AgKLSjjsBfILb7cneisBKy3vcXXFVlEi0qF
	XVzfVhY72l/XGsigD/k2DD1560fnItYrISI0lDEg1JGv5iEF40rMPJMgQnUpy7H/P8OkO9
	jcDDge3JKX5jH+TPIippU1ZRfspaVFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724666458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLjQvx1Iw+blgciXlCuxZQqPUe6hj0Rwui1+Ws1wEig=;
	b=pX/D7tYOz1Wxh6nkXgj3uH6g1FTkq1aKDjgF+Rn9fbzz9y8QnFlIweQ7VFbxsNhYwiLIyb
	x1rcIJ4ra9uTgaCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=foRn9Rjw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="pX/D7tYO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724666458; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLjQvx1Iw+blgciXlCuxZQqPUe6hj0Rwui1+Ws1wEig=;
	b=foRn9Rjw8lBWdoRjRG9w8ErWJgqbknlt0K5AgKLSjjsBfILb7cneisBKy3vcXXFVlEi0qF
	XVzfVhY72l/XGsigD/k2DD1560fnItYrISI0lDEg1JGv5iEF40rMPJMgQnUpy7H/P8OkO9
	jcDDge3JKX5jH+TPIippU1ZRfspaVFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724666458;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mLjQvx1Iw+blgciXlCuxZQqPUe6hj0Rwui1+Ws1wEig=;
	b=pX/D7tYOz1Wxh6nkXgj3uH6g1FTkq1aKDjgF+Rn9fbzz9y8QnFlIweQ7VFbxsNhYwiLIyb
	x1rcIJ4ra9uTgaCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AD7D1398D;
	Mon, 26 Aug 2024 10:00:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZWF4IFpSzGaneQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 26 Aug 2024 10:00:58 +0000
Date: Mon, 26 Aug 2024 12:01:42 +0200
Message-ID: <87h6b7iovt.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: soxiebing <soxiebing@163.com>
Cc: tiwai@suse.de,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: fix snd_hda_bus_reset when single_cmd is not supported
In-Reply-To: <20240826091958.44375-1-soxiebing@163.com>
References: <20240821014238.338864-1-soxiebing@163.com>
	<20240826091958.44375-1-soxiebing@163.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: B1AB1219A7
X-Spam-Level: 
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.51
X-Spam-Flag: NO

On Mon, 26 Aug 2024 11:19:58 +0200,
soxiebing wrote:
> 
> >On Wed, 21 Aug 2024 03:42:38 +0200,
> >soxiebing wrote:
> >> 
> >> From: songxiebing <songxiebing@kylinos.cn>
> >> 
> >> When an azx_get_desponse timeout occurs, ensure that bus_reset
> >> can be used when fallback_to_single_cmd is not supported.
> >> 
> >> Signed-off-by: songxiebing <songxiebing@kylinos.cn>
> >
> >Why do you need to change?  Does it fix any real problem you faced?
> 
> Thanks for reply, i am testing all these days, but the problem is
> still exists even if using bus reset.
>
> The problem i encountered is that hda_call_codec_resume returned 
> timeout of 120 seconds(defined CONFIG_DPM_WATCHDOG)) when doing s4, 
> azx_get_response timeout occured, it is a low probability event.
> 
> To avoid exceeding 120s, can i change the count value to 3 in 
> hda_set_power_state ?

So the change you suggested isn't for any real "fix" but to allow the
possible workaround with single_cmd to be applicable somehow in a
different form.  Then we should rather try debugging the original
issue, instead of change it.

Does the response timeout happen *during* the S4 suspend, or during S4
resume, or after S4 resume?

To be noted, the behavior you changed is only for the single_cmd
option is set explicitly, so it's more or less the designed behavior,
and I don't think it's good to change blindly.


Takashi

