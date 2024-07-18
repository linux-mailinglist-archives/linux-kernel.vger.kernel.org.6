Return-Path: <linux-kernel+bounces-256544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E33D8935001
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E982282652
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C8D1448C9;
	Thu, 18 Jul 2024 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aGughunY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6KlUwaHt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aGughunY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6KlUwaHt"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17BC143C55
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316973; cv=none; b=c/jUAneGfus8wCNmeTiH4yrTUuuXsvN/naI/JavRkEuc253lfQ2fS/8+mhuJEnYOMHpIVjzQFvZ+KOOP+U79qg9HP5mcG9sUOPDexgaV8OFWW7J6lpmKSovxmwbDy0dlSL5VaL3fSQEE8HbhMA04A+aDptpI3igAjtpU7ncyDuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316973; c=relaxed/simple;
	bh=EPk55vtVVOGG0WBDbaVEAZ0EcmpdcpX8XphKJSpydSg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eG+/kHWNFJqf3ALxT7qXaB2YCyVbnn4w65sgk/BK2s2dwKIcOTO4h4cWnDV7FIGwkblA7cW15j+SiujxUGxGWvMjeU/f7XBlLO/mM7NP6Tc4fXTZYPyQSHG0TUx06YxxDcrP4v4ExhR/vNvWQ793abjqcuaNHTwBIwBjLRgkHb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aGughunY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6KlUwaHt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aGughunY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6KlUwaHt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3501B219F7;
	Thu, 18 Jul 2024 15:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721316969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yCQGOCdj0k9IIWZ/dv2P5anlkuuHGnwdNdth1ScTvAY=;
	b=aGughunYPBWnQPly93A2947/SJsWfm0RFc2mD1oATnyP9ahPOPARd6viGCcy+kBxvYDu8N
	D0HCQlAVJPudZJ1pik/QYtE4o840DPnLpMVMTUwvuv36YGe3QlZoRw4CkvV0p98RJXAQfo
	HG9a+RT3RGwIjSw/4s2F/FBYpixBccg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721316969;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yCQGOCdj0k9IIWZ/dv2P5anlkuuHGnwdNdth1ScTvAY=;
	b=6KlUwaHtFro6zJpzJ0UsVwX6sL+SCCHgS2lhcueQ6dTL/dd3oUXYIfpxN9cmyKRvAO+ti+
	RuOlwq/3E+1+U2CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aGughunY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6KlUwaHt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721316969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yCQGOCdj0k9IIWZ/dv2P5anlkuuHGnwdNdth1ScTvAY=;
	b=aGughunYPBWnQPly93A2947/SJsWfm0RFc2mD1oATnyP9ahPOPARd6viGCcy+kBxvYDu8N
	D0HCQlAVJPudZJ1pik/QYtE4o840DPnLpMVMTUwvuv36YGe3QlZoRw4CkvV0p98RJXAQfo
	HG9a+RT3RGwIjSw/4s2F/FBYpixBccg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721316969;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yCQGOCdj0k9IIWZ/dv2P5anlkuuHGnwdNdth1ScTvAY=;
	b=6KlUwaHtFro6zJpzJ0UsVwX6sL+SCCHgS2lhcueQ6dTL/dd3oUXYIfpxN9cmyKRvAO+ti+
	RuOlwq/3E+1+U2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9E201379D;
	Thu, 18 Jul 2024 15:36:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vjLYM2g2mWbNLgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Jul 2024 15:36:08 +0000
Date: Thu, 18 Jul 2024 17:36:42 +0200
Message-ID: <878qxyvhit.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	Bard Liao <bard.liao@intel.com>
Subject: Re: ld.lld: error: undefined symbol: iosf_mbi_available
In-Reply-To: <69dfb1e2-eac6-4cd4-a9d3-caaa7f36f9b9@linux.intel.com>
References: <202407160704.zpdhJ8da-lkp@intel.com>
	<05954a59-2bef-4262-bd91-cfe21d2381f2@linux.intel.com>
	<20240717202806.GA728411@thelio-3990X>
	<87wmljw485.wl-tiwai@suse.de>
	<d121ec31-0861-4324-8f53-6e06eaf60233@linux.intel.com>
	<87le1zvzw9.wl-tiwai@suse.de>
	<9a0eba2e-9933-43bb-ab3b-0480bf1d34a4@linux.intel.com>
	<87frs6vj4m.wl-tiwai@suse.de>
	<69dfb1e2-eac6-4cd4-a9d3-caaa7f36f9b9@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 3501B219F7

On Thu, 18 Jul 2024 17:16:54 +0200,
Pierre-Louis Bossart wrote:
> 
> 
> >>>> diff --git a/sound/soc/intel/common/soc-intel-quirks.h
> >>>> b/sound/soc/intel/common/soc-intel-quirks.h
> >>>> index de4e550c5b34..ae67853f7e2e 100644
> >>>> --- a/sound/soc/intel/common/soc-intel-quirks.h
> >>>> +++ b/sound/soc/intel/common/soc-intel-quirks.h
> >>>> @@ -11,7 +11,9 @@
> >>>>
> >>>>  #include <linux/platform_data/x86/soc.h>
> >>>>
> >>>> -#if IS_ENABLED(CONFIG_X86)
> >>>> +#if IS_ENABLED(CONFIG_X86) && \
> >>>> +       (IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL) || \
> >>>> +        IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI))
> >>>>
> >>>>  #include <linux/dmi.h>
> >>>>  #include <asm/iosf_mbi.h>
> >>>>
> >>>> also at https://github.com/thesofproject/linux/pull/5114
> >>>
> >>> I'm afraid it's not enough, either.  It's included in
> >>> sound/soc/sof/intel/atom.c, and this one can be built-in by selected
> >>> from others while CONFIG_SND_SOC_SOF_BAYTRAIL=m.  And, the reverse
> >>> selection is done from CONFIG_SND_SOC_SOF_BAYTRAIL -- so
> >>> CONFIG_IOSF_MBI can be m as well, and this can lead to the unresolved
> >>> symbol from the built-in atom.c.
> >>
> >> Fair point, I was only looking at the reported failure where Baytrail
> >> was completely disabled.
> >>
> >> I am not sure though if it makes sense to split hair in N dimensions.
> >> Building Merrifield as y and Baytrail as m is a corner case that
> >> shouldn't exist at all. And it's only an academic compilation issue, in
> >> practice using 'y' would fail at run-time due to the usual firmware load
> >> dependencies...
> > 
> > Surely this kind of bug won't hit anyone in practical use, but it's
> > only about the randconfig failures.  The original report is in the
> > same category, after all.
> > 
> > Maybe another (rather easier) workaround would be to use
> > IS_REACHABLE(), something like below.  This should fix the original
> > issue and the potential mess-up of kconfig dependencies.
> 
> The simplest solution works for me :-)
> 
> Do you want me to send a patch with your Suggested-by: tag or do it
> yourself?

If you can send from your side, it'd be more appreciated ;)


thanks,

Takashi

> 
> > --- a/sound/soc/intel/common/soc-intel-quirks.h
> > +++ b/sound/soc/intel/common/soc-intel-quirks.h
> > @@ -11,7 +11,7 @@
> >  
> >  #include <linux/platform_data/x86/soc.h>
> >  
> > -#if IS_ENABLED(CONFIG_X86)
> > +#if IS_REACHABLE(CONFIG_IOSF_MBI)
> >  
> >  #include <linux/dmi.h>
> >  #include <asm/iosf_mbi.h>

