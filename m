Return-Path: <linux-kernel+bounces-213176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42659906ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E2B2826D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B114E1459F5;
	Thu, 13 Jun 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qYy3iInl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pLa9xefF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UlAtUvpS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PHNvcT6y"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA31144D2F;
	Thu, 13 Jun 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280653; cv=none; b=A+Jogkmo1qYXDLwunLO/QBePJlCfJTTTvpWu1BP4BeK/HF06B8hd0MdYLSuSPk6iNPMMNcT0Iy8ty0JN8RM71p1fw7w7qvLcSvz/c+wSuMyzXeqZKJcHqeRM3waxKbHQVd0IEMQN9qXR/+EeWvFXGkGpPrNAk5ZditDbplm1aUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280653; c=relaxed/simple;
	bh=TEYifB3tq+jSELRSjsUHzPuyB8CHcdPoDhxTb+MmXdU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfzSSvg1KHhHyKNKXKjm+mJTV8BvgeD52v9h58IkYFLcxBI8N6trTGaoFGA7vN4EFI/0zPKa/l8lWVPufLUcDvD+y6LMyRRnM8VfG1DV78cDsfbIvyXw1npGzEp6WWhRxGepII6151JfNWBM3tTFYS9Aji0ebS7vZS9kJ8k5C9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qYy3iInl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pLa9xefF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UlAtUvpS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PHNvcT6y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 56798353B0;
	Thu, 13 Jun 2024 12:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718280650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXPGztoHqvtOAlST9kvAr7GTVlL9Rv/zxYc3IGmY6ow=;
	b=qYy3iInlkDkE/0sb8PU4OWxth2XwiASfmXz2GN+IfjOlHxrRVLwse2Nf6Zet/a+V301AVp
	mcZhgePqr0+tPmZE4FwPNZSCFJ+5U33z3dDMpTKzpUaWEIZwLrSdglZhPpz7mkUcX7326Q
	5EnHAI3lB8Z7FS5f8U68UMZZ6gfx48Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718280650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXPGztoHqvtOAlST9kvAr7GTVlL9Rv/zxYc3IGmY6ow=;
	b=pLa9xefFj76rLWkQEE1MapLpGspFLFBX7r2Vxt0kbpISSZ7WDteNZ/n/GxvFQw6u1lPtfO
	q7Gg56Ew/+r9afDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UlAtUvpS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PHNvcT6y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718280649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXPGztoHqvtOAlST9kvAr7GTVlL9Rv/zxYc3IGmY6ow=;
	b=UlAtUvpSG/TyUpnBu2lKK+slwG/iRUNC0puws6yEiQWk6jltZ9kgMy9/kwNYcrHDsD8KEY
	ijKaZkFvdKFknUUpGE2dyuWYRe9v7IDWgsOYbqwI7lX8DbGfiFe5CorxnfdPzVSEikHbmN
	WeIjV6KHsQdVbtHtE3IhpFC9DUB6shY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718280649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXPGztoHqvtOAlST9kvAr7GTVlL9Rv/zxYc3IGmY6ow=;
	b=PHNvcT6yjNpt14PrjpN6wdt28mWxPxAKYpr9oy8LKgbCn/2behrkVOzeNhlf8gZaOUbIzf
	V54kDVQE/4oLXrCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21E7313A7F;
	Thu, 13 Jun 2024 12:10:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IYAEB8nhamalIgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 13 Jun 2024 12:10:49 +0000
Date: Thu, 13 Jun 2024 14:11:12 +0200
Message-ID: <87frthniu7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Stefan Binding <sbinding@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	<alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>
Subject: Re: [PATCH v1 0/4] Add support for Lenovo Thinkbooks
In-Reply-To: <20240606130351.333495-1-sbinding@opensource.cirrus.com>
References: <20240606130351.333495-1-sbinding@opensource.cirrus.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 56798353B0
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.51 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	BAYES_HAM(-0.00)[29.80%];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, 06 Jun 2024 15:03:47 +0200,
Stefan Binding wrote:
> 
> These laptops do not contain _DSD required to support CS35L41 HDA.
> To workaround this, add support for these laptops into the configuration
> table in cs35l41_hda_property.c.
> Also add the required entries into patch_realtek for this SSID.
> 
> Stefan Binding (4):
>   ALSA: hda: cs35l41: Support Lenovo Thinkbook 16P Gen 5
>   ALSA: hda: cs35l41: Support Lenovo Thinkbook 13x Gen 4
>   ALSA: hda/realtek: Support Lenovo Thinkbook 16P Gen 5
>   ALSA: hda/realtek: Support Lenovo Thinkbook 13x Gen 4

Applied all patches.  I corrected the hex numbers in the patch 3 to
lower cases.


thanks,

Takashi

