Return-Path: <linux-kernel+bounces-236410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8693391E1DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF251F23545
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102915FA9F;
	Mon,  1 Jul 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ypyVO43S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jdz4wQxt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ypyVO43S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jdz4wQxt"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6527615FCFC;
	Mon,  1 Jul 2024 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842845; cv=none; b=ozhO2mE6xa60ouIVPLkqFwgIP3bKjQjbrwRpUxMmwIV1oVptjSUZ8ESZgonFiGOPbvJ+S6jdJL2+9T8rr+VDp6WzuEFBrbz7G6vkyEk79KSadqW3XZghwVCmwoq/+cQR3kOMMPrn1od21M7xbpjJErNnSugolR2FRaVDEbrpl2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842845; c=relaxed/simple;
	bh=ZBAKGJAGSV+H/m3GHtG7ymiIUhr5IvN5TH2knK9pQeQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdV+2Evs4ZR1DxgxwL65DfLETJJED932RzmDuMq3p7UR1Y//+pUgLAgAkf8nvfldgueRsafap1LskOPwEmvXMmTb+T7C6EdZ5lQqiKkMGWuAFwIOGBOaIoXD5a49htPDGBQRkxgqTn5G3xhwTjNOiEnAe3I5T1Tp3fKauSWJrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ypyVO43S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jdz4wQxt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ypyVO43S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jdz4wQxt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 860A821954;
	Mon,  1 Jul 2024 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719842841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtlzkwrZIIJkT3HCBs0N620wqfDVAZr83yziKKaWSIw=;
	b=ypyVO43SuVxHKsVYL8+0ubJ1+z1a2UyQ8o/ttHeSuON0kDc7avDTiHiuMN1rJ8ERMd0K0H
	0d5Y79KIc2VKpHpAOrTBkWG39ZdQR2UmNI59k1t4c8e/XGloOCpQJcuVG7VRUFAAaBxOfA
	eIkMEm1n9sQpZo7XnAQsGdk6WrsskEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719842841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtlzkwrZIIJkT3HCBs0N620wqfDVAZr83yziKKaWSIw=;
	b=jdz4wQxtr0hJaag6rzWLpiC53E17IuqslE959yaZ5XQB4cOftaoxCieQJ+jFxEQq6mNaRn
	dJ/4rgJoYaPMOKDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719842841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtlzkwrZIIJkT3HCBs0N620wqfDVAZr83yziKKaWSIw=;
	b=ypyVO43SuVxHKsVYL8+0ubJ1+z1a2UyQ8o/ttHeSuON0kDc7avDTiHiuMN1rJ8ERMd0K0H
	0d5Y79KIc2VKpHpAOrTBkWG39ZdQR2UmNI59k1t4c8e/XGloOCpQJcuVG7VRUFAAaBxOfA
	eIkMEm1n9sQpZo7XnAQsGdk6WrsskEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719842841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtlzkwrZIIJkT3HCBs0N620wqfDVAZr83yziKKaWSIw=;
	b=jdz4wQxtr0hJaag6rzWLpiC53E17IuqslE959yaZ5XQB4cOftaoxCieQJ+jFxEQq6mNaRn
	dJ/4rgJoYaPMOKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40C5813800;
	Mon,  1 Jul 2024 14:07:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qokbDhm4gmZRaAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 01 Jul 2024 14:07:21 +0000
Date: Mon, 01 Jul 2024 16:07:49 +0200
Message-ID: <874j99434a.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Amadeusz =?ISO-8859-2?Q?S=B3awi=F1ski?=
 <amadeuszx.slawinski@linux.intel.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ALSA: pcm: add support for 128kHz sample rate
In-Reply-To: <326792b9-e706-4ab0-a1e8-cc48943e357d@linux.intel.com>
References: <20240628122429.2018059-1-jbrunet@baylibre.com>
	<20240628122429.2018059-2-jbrunet@baylibre.com>
	<326792b9-e706-4ab0-a1e8-cc48943e357d@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,suse.com,perex.cz,alsa-project.org,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Mon, 01 Jul 2024 10:50:02 +0200,
Amadeusz S³awiñski wrote:
> 
> On 6/28/2024 2:23 PM, Jerome Brunet wrote:
> > The usual sample rate possible on an SPDIF link are
> > 32k, 44.1k, 48k, 88.2k, 96k, 172.4k and 192k.
> > 
> > With higher bandwidth variant, such as eARC, and the introduction of 8
> > channels mode, the spdif frame rate may be multiplied by 4. This happens
> > when the interface use an IEC958_SUBFRAME format.
> > 
> > The spdif 8 channel mode rate list is:
> > 128k, 176.4k, 192k, 352.8k, 384k, 705.4k and 768k.
> > 
> > All are already supported by ASLA expect for the 128kHz one.
> > Add support for it but do not insert it the SNDRV_PCM_RATE_8000_192000
> > macro. Doing so would silently add 128k support to a lot of HW which
> > probably do not support it.
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> 
> From what I remember the recommendation is to not add new rates, but
> use SNDRV_PCM_RATE_KNOT for all rates not included already.

In general yes -- unless the new rate is used for significant amount
of drivers.

So this case is a sort of on a border line; if it's only for ASoC
SPDIF codec driver, I'd rather implement with an extra rate list
instead of extending the common bits (that has some potential risks by
breaking the existing numbers).  OTOH, if we can take this for further
cleanups of the existing requirement of 128khz rate, we can go with
it.


thanks,

Takashi

