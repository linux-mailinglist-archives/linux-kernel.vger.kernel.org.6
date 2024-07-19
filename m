Return-Path: <linux-kernel+bounces-257453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F28937A56
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C467E1F22CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3EF146017;
	Fri, 19 Jul 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hkPwG17Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MiIaMDML";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hkPwG17Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MiIaMDML"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC422CA6;
	Fri, 19 Jul 2024 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405239; cv=none; b=Ww18zKDqzYgf39LJ0Fkna6qTTuAQQerQFpkF1dpmmMakn11WpRC5L4SnQkkjVwZEANZWhPrzUDAza0XRMOjMm/X6YmPCn/sWKRGuDOlCdtv9fjdpuJu3Uhj3kpsjzPhc8Dp2WWGhvE9f8mNZzJbQaU95woZlPaLe2R4eSFtvusM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405239; c=relaxed/simple;
	bh=5yJ1aJIFRAYnggNnRm7jwL4IZa1qbw9Jiq7PbL7HYD8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHVSMb9E5lvy5EZRa9iRJvoa98wP/UuwBMzSKsFPcmfWCyueDeP6fARd4kZ4V3R1ndjYtXNs6z1H6Tocu1bAU898UxvVroBne/QWOLRFUWB2FiE5lXlU3AUydudx022MHbveeQ2VQuhFOsv5VnruGS5OzJgk5E0t2C9yvmWtTbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hkPwG17Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MiIaMDML; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hkPwG17Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MiIaMDML; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C370121198;
	Fri, 19 Jul 2024 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721405235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o5kDd9HhVtKwrV15n8k1AAZB865njtt6+Ye5ZgRQqDA=;
	b=hkPwG17Yb8b6LqIjT50sH4qRk1G8Ufks0RFuhAotwBdD64P0VW4hwMB0gGuBBzcwTd6ngg
	+RvfGIuiFFsUAKeH47fLFQHwwrSI77yGDeb3cCTz6I0I8ozPh0zd0hJy+RP4l6/kTfNpFq
	ZSeDYADseYCm7A4IWbisWvWpbaRxNgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721405235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o5kDd9HhVtKwrV15n8k1AAZB865njtt6+Ye5ZgRQqDA=;
	b=MiIaMDMLj+MHaIuHUqFRCI4vGFmlTYCL8GRU7v+hVKogNOXlL1KMuhC/PQ8CJ0VmIiJZZq
	nroi6cKpwxI53iCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hkPwG17Y;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MiIaMDML
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721405235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o5kDd9HhVtKwrV15n8k1AAZB865njtt6+Ye5ZgRQqDA=;
	b=hkPwG17Yb8b6LqIjT50sH4qRk1G8Ufks0RFuhAotwBdD64P0VW4hwMB0gGuBBzcwTd6ngg
	+RvfGIuiFFsUAKeH47fLFQHwwrSI77yGDeb3cCTz6I0I8ozPh0zd0hJy+RP4l6/kTfNpFq
	ZSeDYADseYCm7A4IWbisWvWpbaRxNgw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721405235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o5kDd9HhVtKwrV15n8k1AAZB865njtt6+Ye5ZgRQqDA=;
	b=MiIaMDMLj+MHaIuHUqFRCI4vGFmlTYCL8GRU7v+hVKogNOXlL1KMuhC/PQ8CJ0VmIiJZZq
	nroi6cKpwxI53iCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6760513808;
	Fri, 19 Jul 2024 16:07:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GgbEFzOPmmZLEgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Jul 2024 16:07:15 +0000
Date: Fri, 19 Jul 2024 18:07:49 +0200
Message-ID: <8734o5s6ui.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Gergo Koteles <soyer@irl.hu>,
	Mark Brown <broonie@kernel.org>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: hda: tas2781: mark const variables as __maybe_unused
In-Reply-To: <20240719095640.3741247-1-arnd@kernel.org>
References: <20240719095640.3741247-1-arnd@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.31
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C370121198
X-Spamd-Result: default: False [-3.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO

On Fri, 19 Jul 2024 11:56:34 +0200,
Arnd Bergmann wrote:
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
> An earlier patch changed the DECLARE_TLV_DB_SCALE declaration, but
> now there are additional static const variables that cause
> the same build warnings:
> 
> In file included from sound/pci/hda/tas2781_hda_i2c.c:23:
> include/sound/tas2781-tlv.h:23:28: error: 'tas2563_dvc_table' defined but not used [-Werror=unused-const-variable=]
>    23 | static const unsigned char tas2563_dvc_table[][4] = {
>       |                            ^~~~~~~~~~~~~~~~~
> In file included from include/sound/tlv.h:10,
>                  from sound/pci/hda/tas2781_hda_i2c.c:22:
> include/sound/tas2781-tlv.h:20:35: error: 'tas2563_dvc_tlv' defined but not used [-Werror=unused-const-variable=]
>    20 | static const DECLARE_TLV_DB_SCALE(tas2563_dvc_tlv, -12150, 50, 1);
>       |                                   ^~~~~~~~~~~~~~~
> 
> Mark them all as unused as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied now.


Takashi

