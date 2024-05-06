Return-Path: <linux-kernel+bounces-169726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52B68BCCB1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2F11F22703
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EAF142E89;
	Mon,  6 May 2024 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H4gk8Kik";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NiHy2b2z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H4gk8Kik";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NiHy2b2z"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324D142649
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 11:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994203; cv=none; b=Tmv+fcHd95Pt0cKd/smbx2eC1Knbl4i5+JPNPV3UbAOyRcuZqeVzlq+Lg3yezKGxnmipy/2ox56a3JnY1o3OyX+l/8NmnzoQsRsEYjTgmyinfDD89oHsZg4pfrwOSC5HIyJruSFQLz7ZbDmLS3SFkYQx7QRcCPF3GYVu5I4SRss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994203; c=relaxed/simple;
	bh=KfeNDZbOMz/5HgirkBw+VH6ZB3AxFQuJi99H4YzeQS4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KoEqCq8DFyBePNGkAEFsRj4SvmxYKs0scHNv1L3JN9VDtmv4czF43ATLkkccv9o/gQlHXsRYjQQBlRKiIcJaWKxMVYULeiaqNtZdJMzIdubhx0JllOHZh7iFkrEHYTo5Iy06muxuXjfp07CHxxHdN1k8QTXRfvS9+Z89SaO9yBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H4gk8Kik; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NiHy2b2z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H4gk8Kik; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NiHy2b2z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5CDF73823A;
	Mon,  6 May 2024 11:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714994197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gowNp2KH7bD8yMa7lH80BTRR2VdWE5qZYTZ/ZrSvuQ=;
	b=H4gk8KikEta5sS6RD2QgJqZzfKkjM/xAzC9504SWKNtwMfAoNlzfc1oc1domhLyAO8Fs6X
	EMAUWRpT7Td5NKeLWnQtULCO9sqDf+zV0mmz0Ypk+yymuHNxKFA0gZ5yRnLzdUSYU0QMod
	vorQd2L1xoTIbSj13K2PvTIEaHjG4ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714994197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gowNp2KH7bD8yMa7lH80BTRR2VdWE5qZYTZ/ZrSvuQ=;
	b=NiHy2b2z98WM7GLctBBp4CAqsXirFLOU1f1kOOzHEcynge7N8krmCoXQ7e16O/Pg56LlIG
	xSZcmokcV6L5G/AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=H4gk8Kik;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NiHy2b2z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714994197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gowNp2KH7bD8yMa7lH80BTRR2VdWE5qZYTZ/ZrSvuQ=;
	b=H4gk8KikEta5sS6RD2QgJqZzfKkjM/xAzC9504SWKNtwMfAoNlzfc1oc1domhLyAO8Fs6X
	EMAUWRpT7Td5NKeLWnQtULCO9sqDf+zV0mmz0Ypk+yymuHNxKFA0gZ5yRnLzdUSYU0QMod
	vorQd2L1xoTIbSj13K2PvTIEaHjG4ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714994197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/gowNp2KH7bD8yMa7lH80BTRR2VdWE5qZYTZ/ZrSvuQ=;
	b=NiHy2b2z98WM7GLctBBp4CAqsXirFLOU1f1kOOzHEcynge7N8krmCoXQ7e16O/Pg56LlIG
	xSZcmokcV6L5G/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2CDD13A25;
	Mon,  6 May 2024 11:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wfuaNRS8OGYOKwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 06 May 2024 11:16:36 +0000
Date: Mon, 06 May 2024 13:16:51 +0200
Message-ID: <87r0efgpgc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"robh+dt@kernel.org"
	<robh+dt@kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
	"Lu, Kevin" <kevin-lu@ti.com>,
	"Ding, Shenghao" <shenghao-ding@ti.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"P O, Vijeth" <v-po@ti.com>,
	"Holalu Yogendra, Niranjan" <niranjan.hy@ti.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"soyer@irl.hu" <soyer@irl.hu>
Subject: Re: [EXTERNAL] Re: [PATCH v3 1/3] ALSA: hda/tas2781: Modification for add tas2781 driver for SPI
In-Reply-To: <d96bea0bacc842e0b30a100f43ff264f@ti.com>
References: <20240418040240.2337-1-baojun.xu@ti.com>
	<20240418040240.2337-2-baojun.xu@ti.com>
	<ZiEKc4OTVlOt8llU@smile.fi.intel.com>
	<0c7b29075dc347299602668660adb4b6@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[18];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,gmail.com,perex.cz,ti.com,139.com,alsa-project.org,vger.kernel.org,intel.com,irl.hu];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,ti.com:email,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5CDF73823A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.01

On Mon, 06 May 2024 09:44:05 +0200,
Xu, Baojun wrote:
> 
> Hi Andy
> 
> Thanks for your comments, answer in line:
> 
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: 02 May 2024 18:22
> > To: Xu, Baojun
> > Cc: tiwai@suse.de; robh+dt@kernel.org; lgirdwood@gmail.com; perex@perex.cz; pierre-louis.bossart@linux.intel.com; Lu, Kevin; Ding, Shenghao; Navada Kanyana, Mukund; 13916275206@139.com; P O, Vijeth; Holalu Yogendra, Niranjan; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; liam.r.girdwood@intel.com; yung-chuan.liao@linux.intel.com; broonie@kernel.org; soyer@irl.hu
> > Subject: Re: [EXTERNAL] Re: [PATCH v3 1/3] ALSA: hda/tas2781: Modification for add tas2781 driver for SPI
> > 
> > On Thu, Apr 25, 2024 at 07: 54: 41AM +0000, Xu, Baojun wrote: > > From: Andy Shevchenko <andriy. shevchenko@ linux. intel. com> > > Sent: 18 April 2024 19: 56 > > On Thu, Apr 18, 2024 at 12: 02: 37PM +0800, Baojun Xu wrote: 
> > ZjQcmQRYFpfptBannerStart
> > This message was sent from outside of Texas Instruments.
> > Do not click links or open attachments unless you recognize the source of this email and know the content is safe. If you wish to report this message to IT Security, please forward the message as an attachment to phishing@list.ti.com
> > 
> > ZjQcmQRYFpfptBannerEnd
> > 
> > On Thu, Apr 25, 2024 at 07:54:41AM +0000, Xu, Baojun wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Sent: 18 April 2024 19:56
> > > > On Thu, Apr 18, 2024 at 12: 02: 37PM +0800, Baojun Xu wrote:
> > > > On Thu, Apr 18, 2024 at 12:02:37PM +0800, Baojun Xu wrote:
> > 
> > ...
> > 
> > > > >  sound/pci/hda/Kconfig                           | 15 +++++++++++++++
> > > > >  sound/pci/hda/Makefile                          |  2 ++
> > > >
> > > Is this correct? You are adding a dead "code", isn't it?
> > >
> > > What's mean "dead code"? After add CONFIG_SND_HDA_SCODEC_TAS2781_SPI=m
> > > in my config file, the whole patch code has worked.
> > 
> > Is that file already in the repository?
> > If not, I don't see it in this patch either --> dead code.
> 
> When I integrated CONFIG_SND_HDA_SCODEC_TAS2781_SPI and compiled the whole kernel,
> it used to popup the following message for TAS2781 SPI module in first compile:
>  
>  Build TAS2781 HD-audio side codec support for SPI Bus (SND_HDA_SCODEC_TAS2781_SPI) [N/m/?] (NEW) 
> 
> Normally, selected m. And TAS2781 SPI module would be compiled.

At each patch / commit, the build must be kept successful.
In your case, in the patch 1, you introduced the new driver stuff to
Kconfig and Makefile while there is no actual code for that yet (which
will be added in later patches).  This breaks the build at this
commit (lacking tas2781_hda_spi.c and co), and it's not acceptable.

You have to split patches in sensible manners; those to be logically
split, and yet they must not break builds.


thanks,

Takashi

