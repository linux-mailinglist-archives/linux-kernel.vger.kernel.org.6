Return-Path: <linux-kernel+bounces-213171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E38E906E63
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F127DB246E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46C3145FE1;
	Thu, 13 Jun 2024 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2EHn6btN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wWfWpadM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2EHn6btN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wWfWpadM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3DD145359;
	Thu, 13 Jun 2024 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280341; cv=none; b=gu+NnhCxXyWgo7rzvIcHED3YBiS+te6GLsvWxTYvvw9J4TXsX3Y83edT91TXEMnGngCucZtTs1Abzd9D2fmZ/jlsXPcUttOwE/PNnZPCCH3d5ohKMYEClRNFItDS2t6ughaA8qoAHUfgwnuQPp7GjLIPKIjRHQ0hWP6Ro1HJwQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280341; c=relaxed/simple;
	bh=Yr6Qmiiz97m3lWUH4+OI9PteO/YpPUXHxIVYxvdkpK0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VcGaBHYXSW0r9akb2Hcg9+ufAT67Nkj7e07TeQzXMWab53CTAyffbY63ZUO/THzDCkIDkny9BNy5G8oBgd1zgTbBaf86XyX4yIszcqhcD5oPqleRWi8QH2+aovK7u/SMtPebw5ZAUKm8IMayOJvVbJ7+EYAyQ7EOLX6O6AL5pR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2EHn6btN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wWfWpadM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2EHn6btN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wWfWpadM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8221C5D2DC;
	Thu, 13 Jun 2024 12:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718280337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WT0XyiT40kea3fhb0qgJuObeXLOKk0sgpARLAW3vIjg=;
	b=2EHn6btNnYTS4DIi6PjdCdoXufmvJyCtKdho6BidZP6gbijup35HKBuZXW2mfcmptjFZ1L
	q2IQm4Gpzd7ZRO//WeC9kSusQfl1KILM3RlEIaFHTk03xXfRAXXvMp9TAdGaVVsrzFzXd0
	v78PxHcrLLg2i1MKdepBoboV04KPiiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718280337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WT0XyiT40kea3fhb0qgJuObeXLOKk0sgpARLAW3vIjg=;
	b=wWfWpadMa7xe5qLeB1hemQ1xATPlfXIoAO21Y/xO45S7BZV/nNlXwZF3d3a6tcdbkU9n99
	5oBgSo1Q3OeSzFBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718280337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WT0XyiT40kea3fhb0qgJuObeXLOKk0sgpARLAW3vIjg=;
	b=2EHn6btNnYTS4DIi6PjdCdoXufmvJyCtKdho6BidZP6gbijup35HKBuZXW2mfcmptjFZ1L
	q2IQm4Gpzd7ZRO//WeC9kSusQfl1KILM3RlEIaFHTk03xXfRAXXvMp9TAdGaVVsrzFzXd0
	v78PxHcrLLg2i1MKdepBoboV04KPiiQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718280337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WT0XyiT40kea3fhb0qgJuObeXLOKk0sgpARLAW3vIjg=;
	b=wWfWpadMa7xe5qLeB1hemQ1xATPlfXIoAO21Y/xO45S7BZV/nNlXwZF3d3a6tcdbkU9n99
	5oBgSo1Q3OeSzFBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3800513A87;
	Thu, 13 Jun 2024 12:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uXZbDJHgamb7IAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 13 Jun 2024 12:05:37 +0000
Date: Thu, 13 Jun 2024 14:06:00 +0200
Message-ID: <87h6dxnj2v.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: <tiwai@suse.com>,
	<linux-sound@vger.kernel.org>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<patches@opensource.cirrus.com>,
	<soyer@irl.hu>,
	<shenghao-ding@ti.com>,
	<kevin-lu@ti.com>,
	<baojun.xu@ti.com>,
	<kailang@realtek.com>
Subject: Re: [PATCH v2 0/7] ALSA: hda: Improvements to hda_component
In-Reply-To: <20240603103524.32442-1-simont@opensource.cirrus.com>
References: <20240603103524.32442-1-simont@opensource.cirrus.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Mon, 03 Jun 2024 12:35:17 +0200,
Simon Trimmer wrote:
> 
> This series of patches makes sure that the existing consumers of
> the infrastructure unbind their interface before they begin
> destroying the driver, moves duplicated members from the
> instanced component structures into a new parent structure and
> introduces locking so that consumers of the interface do not use
> stale data.
> 
> v2:
>  - Correct application of sizeof to pointer flagged by kernel test robot
> 
> Simon Trimmer (7):
>   ALSA: hda: cs35l56: Component should be unbound before deconstruction
>   ALSA: hda: cs35l41: Component should be unbound before deconstruction
>   ALSA: hda/tas2781: Component should be unbound before deconstruction
>   ALSA: hda: hda_component: Introduce component parent structure
>   ALSA: hda: hda_component: Change codecs to use component parent
>     structure
>   ALSA: hda: hda_component: Move codec field into the parent
>   ALSA: hda: hda_component: Protect shared data with a mutex

The first three patches look rather like independent fixes.
Could you split those out and add proper Fixes tags, so that stable
trees can pick up?

The rest are a code refactoring and additional protection of the
mutex.


thanks,

Takashi

>  sound/pci/hda/cs35l41_hda.c     | 47 ++++++++++++---------
>  sound/pci/hda/cs35l56_hda.c     | 29 +++++++------
>  sound/pci/hda/hda_component.c   | 75 ++++++++++++++++++++-------------
>  sound/pci/hda/hda_component.h   | 48 ++++++++++++++-------
>  sound/pci/hda/patch_realtek.c   | 17 ++++----
>  sound/pci/hda/tas2781_hda_i2c.c | 37 ++++++++--------
>  6 files changed, 147 insertions(+), 106 deletions(-)
> 
> -- 
> 2.34.1
> 

