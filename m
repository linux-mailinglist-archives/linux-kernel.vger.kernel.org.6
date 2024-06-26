Return-Path: <linux-kernel+bounces-230846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837479182A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0B4AB252FB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D401836ED;
	Wed, 26 Jun 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1gN5PEbL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="deSvvtV2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iwYgnCTd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rZbvRSIT"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607BE181BBF;
	Wed, 26 Jun 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409004; cv=none; b=bPU85zGlbgaZFZKIRoAVEdmVhTN7JAGUUV6mqRYMEb46R1lAxVgkLj0V33GilQNU609bImiMrPKdTULm/+kDRoCMpSJTHaSrsU36Wg9fxnAz1OQCS11bNy5fDYB2dFwVHazisQHAs81gHCls4bT1E7lCJFnqj3lfe7BRp1ITJG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409004; c=relaxed/simple;
	bh=Lyzzsprn4wMYB7Y1xc8XY5fUki8frRV0F0tISkFCZ1I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsiHSeyhCWmvRhefod04BjpNYrW0FQ7eF3hL7UXbe5nkRMW/+o87B7BMDTOadSRzSXV8FiEDGJRhHRe4pSTzwVOEfsu+EV3BlZEqpr7r3WuouEcOHLPovFjxBjGWSz3XpoijPwi5h/nSywN+kgrmXQmNLW1wUO3yisv37IewDUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1gN5PEbL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=deSvvtV2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iwYgnCTd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rZbvRSIT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4BB631FB57;
	Wed, 26 Jun 2024 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719409000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Td7Ytuo/3AMMh9vCcaD9IDsQnqmv9XxyYayYcHEQ2a8=;
	b=1gN5PEbLYQfTxYdva0eq2Lf6VpYDo6Mh6yv6Iyo72OmAocvpZk7PYvbeTtB3Od3W7ZB3iJ
	IsjFnnGCS2tG05FgjttWC3EZkUNtdKtAcQX0ay4JlMVLU2Tzlvdr2x0E6O7xyw0OJx21NK
	fkEebv4hUBSdWAeRzfHeIRDiBAFamU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719409000;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Td7Ytuo/3AMMh9vCcaD9IDsQnqmv9XxyYayYcHEQ2a8=;
	b=deSvvtV2iPXbtYWIrQ6YEhTYqiFzGaJCKyHnQBcpI/Jwkxp8VfLjC/GL8NU3rIQcI3fQxX
	/fwvtRzvQFbjDgCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719408999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Td7Ytuo/3AMMh9vCcaD9IDsQnqmv9XxyYayYcHEQ2a8=;
	b=iwYgnCTdJMPCcwHjwQQnusLnrX1pomHRSchIfTOu1YrEM/F07VRaZVTrasoC4pfMtlbD+t
	r8LGuKQ0DXz5bWBJEJmWYAVWqOLdGbo8jxIoX9z8ye5eHlHZt0tK3FCFC0BKQxFkHC4oGP
	J4rN8EKJshNHkQbpdzg9xE8d+NfMNPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719408999;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Td7Ytuo/3AMMh9vCcaD9IDsQnqmv9XxyYayYcHEQ2a8=;
	b=rZbvRSITlxMeAqhSmEfhtbnvNodFbm112/hJX3hUj3gDOih1yvMeQ8g86+ziwiKBBAMY+g
	7kdsswBolMNoOlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0AA413AAD;
	Wed, 26 Jun 2024 13:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jwdXNWYZfGYzQgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 26 Jun 2024 13:36:38 +0000
Date: Wed, 26 Jun 2024 15:37:06 +0200
Message-ID: <87r0cjj059.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,	Amadeusz
 =?ISO-8859-2?Q?S=B3awi=F1ski?= <amadeuszx.slawinski@linux.intel.com>,	Allen
 Ballway <ballway@chromium.org>,	LKML <linux-kernel@vger.kernel.org>,	Brady
 Norander <bradynorander@gmail.com>,	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,	Ranjani Sridharan
 <ranjani.sridharan@linux.intel.com>,	Mark Brown <broonie@kernel.org>,
	linux-sound@vger.kernel.org,	Mark Hasemeyer <markhas@chromium.org>,	Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,	Cezary Rojewski
 <cezary.rojewski@intel.com>
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Azulle Access 4 quirk detection
In-Reply-To: <7bbf1688-4dfd-4a6f-90f2-ee235027c701@roeck-us.net>
References: <20240430212838.1.I77b0636d5df17c275042fd66cfa028de8ad43532@changeid>
	<83e218f9-29f5-4f35-bd0c-b298e3bb9e8c@linux.intel.com>
	<CAEs41JC-vJaMHj6fzmNO=-bu5oURRA-u565sN2=yzBeVtKb=4g@mail.gmail.com>
	<b2375610-4044-49e6-86e9-5c172abb2ffa@linux.intel.com>
	<CAEs41JAPPr3xRR42H6vKic5rVrtV-on4HyT5wNCXxbJtwijnCA@mail.gmail.com>
	<3d44c749-6c81-4c11-9409-b01815fe1a91@linux.intel.com>
	<3d9ef693-75e9-4be0-b1c0-488d3e2d41c5@linux.intel.com>
	<01904abc-5e7c-4006-96d9-83fc5de8bb21@roeck-us.net>
	<fb9ce0ce-dddb-4f88-9ac6-0f6cdd6ccb28@linux.intel.com>
	<7bbf1688-4dfd-4a6f-90f2-ee235027c701@roeck-us.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.intel.com,chromium.org,vger.kernel.org,gmail.com,perex.cz,suse.com,kernel.org,intel.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Wed, 26 Jun 2024 15:09:34 +0200,
Guenter Roeck wrote:
> 
> On 6/26/24 00:04, Pierre-Louis Bossart wrote:
> > 
> > 
> > On 6/25/24 23:37, Guenter Roeck wrote:
> >> On Fri, Jun 21, 2024 at 10:35:31AM +0200, Pierre-Louis Bossart wrote:
> >>> 
> >>> 
> >>> On 6/21/24 08:15, Amadeusz S³awiñski wrote:
> >>>> On 6/20/2024 9:27 PM, Allen Ballway wrote:
> >>>>> I filed a bug and after sharing the requested information it looks
> >>>>> like this device won't work on SOF without vendor support. Given this,
> >>>>> would the original patch returning this device to using HDAudio be
> >>>>> reasonable, or is there an preferred alternative to force this device
> >>>>> into using HDAudio?
> >>>>> 
> >>>> 
> >>>> And can you share link to the issue on mailing list, so someone reading
> >>>> this thread in the future doesn't have to guess where it is? ;)
> >>> 
> >>> https://github.com/thesofproject/linux/issues/4981
> >>> 
> >>> I don't know what to do with this configuration.
> >>> We added a quirk to force SOF to be used for ES8336 devices. It worked
> >>> for some, but not for others. Now we have quite a few ES8336-based
> >>> platforms that are broken with zero support from the vendor, with
> >>> obscure I2C/GPIO/clk issues.
> >>> Are we going to tag each one of them and say 'not supported, use HDMI only'?
> >>> That's pushing a bit the notion of quirk...It would generate an endless
> >>> stream of patches. The alternative is to do nothing and ask that those
> >>> platforms revert to HDMI audio only with a kernel parameter. That latter
> >>> alternative has my vote.
> >>> 
> >> 
> >> Given that this apparently does not work for many ES8336 devices,
> >> would it make more sense to disable SOF support for those by default
> >> and _enable_ them with a kernel parameter ?
> > 
> > Some configurations work, so we would break them.
> > 
> 
> Yes, but for others it is a regression,

Is it?  The speaker should have never worked for them without SOF,
either.


Takashi

> so arguably the change to force-enable
> SOF caused a regression and should either be reverted or fixed such that all
> previously working configurations still work (even more so since fixing
> the problem one-by-one as affected systems are found is being rejected).
> 
> Thanks,
> Guenter
> 

