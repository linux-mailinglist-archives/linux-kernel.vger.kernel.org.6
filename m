Return-Path: <linux-kernel+bounces-171336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D608BE2EE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406B8B214E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B11F15D5CB;
	Tue,  7 May 2024 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KN7qjhQo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MIuc94hQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KN7qjhQo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MIuc94hQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108F15B150
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087097; cv=none; b=ZfnDvI2V9XVBA2PXiqzux76tS1UFrLLyT+kApNFu0KSxThOYOURTAbdU/C0gj/1qFxbXOIghMpQQlh0LXx1zuleBqO5cfNI/GHDHT1fF4Gn6ZnwPyX8m3F0qw6vAuULkna5wJv7jTFzPBycth4wdiUz7YwR8p/nBPSClMLU4g1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087097; c=relaxed/simple;
	bh=1dBXOfKIqa1iWTt+dKLPUl5EtlG+zkg8uA7QiORazBE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LsN+N0pYGeH6Ky3hlLqeYwHP7Wxf7VWZNZNDnezm3QAnYdihdxUmhJBY+FQF7YHBP5OO8D9WiQveiQjCDR6idZgitAFAb1AQaJ9q2qLCiQgT3fWMCQ5i5mqydnzISX8rKTUi65dTU91IrGgHk58XTmzvIiwa+KBsTUIsHXfAF04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KN7qjhQo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MIuc94hQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KN7qjhQo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MIuc94hQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 378AE33F07;
	Tue,  7 May 2024 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715087094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+576eNXIXH7acYOv5kAfJsPPJ6gfQZfnrCWYRgf0fCM=;
	b=KN7qjhQok1Rgk5eCnHvOO1G7k1FDIEqhl/YLpBTSEhS6Jo0RqUjs1jD+Pcn3qZxmmwlKqw
	6+us6hC1Ngj444QwL/M31BqqkNF9bxaMShjpK79i9B2DspWaLmMMcOW79MCawIh2EQZ3WD
	sFQRHnDgAr6CoJVoaDzaokxhMoHOZ4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715087094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+576eNXIXH7acYOv5kAfJsPPJ6gfQZfnrCWYRgf0fCM=;
	b=MIuc94hQmcpaL8AtmDPYt8dIkE4u76HH2Xlw8MP1Z9o1wvsEtkuHTlUyyo6WQQvyaSmIzB
	NilNYFF9TngpRYBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KN7qjhQo;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MIuc94hQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715087094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+576eNXIXH7acYOv5kAfJsPPJ6gfQZfnrCWYRgf0fCM=;
	b=KN7qjhQok1Rgk5eCnHvOO1G7k1FDIEqhl/YLpBTSEhS6Jo0RqUjs1jD+Pcn3qZxmmwlKqw
	6+us6hC1Ngj444QwL/M31BqqkNF9bxaMShjpK79i9B2DspWaLmMMcOW79MCawIh2EQZ3WD
	sFQRHnDgAr6CoJVoaDzaokxhMoHOZ4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715087094;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+576eNXIXH7acYOv5kAfJsPPJ6gfQZfnrCWYRgf0fCM=;
	b=MIuc94hQmcpaL8AtmDPYt8dIkE4u76HH2Xlw8MP1Z9o1wvsEtkuHTlUyyo6WQQvyaSmIzB
	NilNYFF9TngpRYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3C84139CB;
	Tue,  7 May 2024 13:04:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yVP7OvUmOmaFIAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 07 May 2024 13:04:53 +0000
Date: Tue, 07 May 2024 15:05:08 +0200
Message-ID: <87cypxeprv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Baojun Xu <baojun.xu@ti.com>,
	robh+dt@kernel.org,
	lgirdwood@gmail.com,
	perex@perex.cz,
	pierre-louis.bossart@linux.intel.com,
	kevin-lu@ti.com,
	shenghao-ding@ti.com,
	navada@ti.com,
	13916275206@139.com,
	v-po@ti.com,
	niranjan.hy@ti.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com,
	broonie@kernel.org,
	soyer@irl.hu
Subject: Re: [PATCH v4 1/3] ALSA: hda/tas2781: Add tas2781 hda driver based on SPI
In-Reply-To: <ZjD1-NSC3X_7JcQg@smile.fi.intel.com>
References: <20240430072544.1877-1-baojun.xu@ti.com>
	<20240430072544.1877-2-baojun.xu@ti.com>
	<87jzkfm2hp.wl-tiwai@suse.de>
	<ZjD1-NSC3X_7JcQg@smile.fi.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 378AE33F07
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,gmail.com,perex.cz,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,intel.com,irl.hu];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Tue, 30 Apr 2024 15:45:28 +0200,
Andy Shevchenko wrote:
> 
> On Tue, Apr 30, 2024 at 02:58:10PM +0200, Takashi Iwai wrote:
> > On Tue, 30 Apr 2024 09:25:42 +0200, Baojun Xu wrote:
> 
> ...
> 
> > >  snd-hda-cs-dsp-ctls-objs :=		hda_cs_dsp_ctl.o
> > >  snd-hda-scodec-component-objs :=	hda_component.o
> > >  snd-hda-scodec-tas2781-i2c-objs :=	tas2781_hda_i2c.o
> > > +snd-hda-scodec-tas2781-spi-y :=	tas2781_hda_spi.o tas2781_spi_fwlib.o
> > 
> > A nitpicking: better to align with other lines (i.e. with *-objs
> > instead of *-y).
> 
> I object this. The better approach is to have a precursor patch that switches
> to y over objs (the latter is for user space code / tools).

Indeed it can be a good cleanup, yeah.  Let me try.


thanks,

Takashi

