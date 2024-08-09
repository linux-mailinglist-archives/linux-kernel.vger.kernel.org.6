Return-Path: <linux-kernel+bounces-280763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903DE94CED1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843361C20D2A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204C5192B67;
	Fri,  9 Aug 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LRl5cUsO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kz7k4d5A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LRl5cUsO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kz7k4d5A"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0211922DF;
	Fri,  9 Aug 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723199899; cv=none; b=DJP8aKMprA5LuC2i0uFhY5Lzl3v0rYKSkbw5lCnpntc/17mPLyowqzDWzBcSt8wQQF8uRbt9Ethri4HnzS+e0y2Vm4xAAgpOwujEyxgQzoFCLaqA4qHkguI9QFYuQ4fA+Ug17+1JCyY9UMU35K2HOmOLQUS7auto4c+qkMh596I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723199899; c=relaxed/simple;
	bh=p3uIc3PVNaPPInUmAJDLhP4bt5VU5M0pSZR9IAej4Iw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAOxn2JY9tl75OPt9Bhj8OM7EDbNtJxDlSgkJSM4URKlVwYFy9U33pMvKmUfl6Fi7gR/kVF3awmz6KBnXlMrQ2xMU+k62iLA/dDnYNSGU3tURjE1rz7kWLrasO1wo8caWpUlvM0Fz/0g46sYJ5oN/MbGY3Naj5FEJaxcDwphRFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LRl5cUsO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kz7k4d5A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LRl5cUsO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kz7k4d5A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9811F1FF42;
	Fri,  9 Aug 2024 10:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723199895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCmEbjagN7GRGzZSYtTxs0pu0P39Kv6soYpM7KjvXy4=;
	b=LRl5cUsOwLGArb3rRbnS/TaD6dESnSRi7dMLBursXLXCTtjKpYmJSVxA3IxcdioT8+SjZM
	MUAHOrenyfepO52c6wsNNr+2mtZC/C85SA75j5vQ2WkAhjMpYn3ZXWYtzeR7eL1eRuSEHz
	hqTYuZOzBgwVq627FtLpGIXy0/QUWzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723199895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCmEbjagN7GRGzZSYtTxs0pu0P39Kv6soYpM7KjvXy4=;
	b=kz7k4d5AC1/jflcgGMMlKdknL9LUVv6rNWsfwZKNn8A/Ed6TVPwJNLpI52nk41QMpPR4Vx
	MkI2kEO3T3rBicAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LRl5cUsO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kz7k4d5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723199895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCmEbjagN7GRGzZSYtTxs0pu0P39Kv6soYpM7KjvXy4=;
	b=LRl5cUsOwLGArb3rRbnS/TaD6dESnSRi7dMLBursXLXCTtjKpYmJSVxA3IxcdioT8+SjZM
	MUAHOrenyfepO52c6wsNNr+2mtZC/C85SA75j5vQ2WkAhjMpYn3ZXWYtzeR7eL1eRuSEHz
	hqTYuZOzBgwVq627FtLpGIXy0/QUWzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723199895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RCmEbjagN7GRGzZSYtTxs0pu0P39Kv6soYpM7KjvXy4=;
	b=kz7k4d5AC1/jflcgGMMlKdknL9LUVv6rNWsfwZKNn8A/Ed6TVPwJNLpI52nk41QMpPR4Vx
	MkI2kEO3T3rBicAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 650451379A;
	Fri,  9 Aug 2024 10:38:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ceUTF5fxtWacSwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 09 Aug 2024 10:38:15 +0000
Date: Fri, 09 Aug 2024 12:38:54 +0200
Message-ID: <87cymi6kw1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	Simon Trimmer
	<simont@opensource.cirrus.com>
Subject: Re: [PATCH] ALSA: hda: cs35l56: Remove calls to cs35l56_force_sync_asp1_registers_from_cache()
In-Reply-To: <20240809094527.10229-1-rf@opensource.cirrus.com>
References: <20240809094527.10229-1-rf@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: 9811F1FF42
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On Fri, 09 Aug 2024 11:45:27 +0200,
Richard Fitzgerald wrote:
> 
> From: Simon Trimmer <simont@opensource.cirrus.com>
> 
> Commit 5d7e328e20b3 ("ASoC: cs35l56: Revert support for dual-ownership
> of ASP registers")
> replaced cs35l56_force_sync_asp1_registers_from_cache() with a dummy
> implementation so that the HDA driver would continue to build.
> 
> Remove the calls from HDA so that the stub function can be removed.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Since those are the only callers, it'd be easier to get rid of the
definition in include/sound/cs35l56.h together as a single patch.
Otherwise it'll lead to a dependency, which can be difficult when
applied over multiple trees.


thanks,

Takashi

> ---
>  sound/pci/hda/cs35l56_hda.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
> index 96d3f13c5abf..bbfd68a572bf 100644
> --- a/sound/pci/hda/cs35l56_hda.c
> +++ b/sound/pci/hda/cs35l56_hda.c
> @@ -151,10 +151,6 @@ static int cs35l56_hda_runtime_resume(struct device *dev)
>  		}
>  	}
>  
> -	ret = cs35l56_force_sync_asp1_registers_from_cache(&cs35l56->base);
> -	if (ret)
> -		goto err;
> -
>  	return 0;
>  
>  err:
> @@ -1095,9 +1091,6 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
>  
>  	regmap_multi_reg_write(cs35l56->base.regmap, cs35l56_hda_dai_config,
>  			       ARRAY_SIZE(cs35l56_hda_dai_config));
> -	ret = cs35l56_force_sync_asp1_registers_from_cache(&cs35l56->base);
> -	if (ret)
> -		goto dsp_err;
>  
>  	/*
>  	 * By default only enable one ASP1TXn, where n=amplifier index,
> @@ -1123,7 +1116,6 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
>  
>  pm_err:
>  	pm_runtime_disable(cs35l56->base.dev);
> -dsp_err:
>  	cs_dsp_remove(&cs35l56->cs_dsp);
>  err:
>  	gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 0);
> -- 
> 2.39.2
> 

