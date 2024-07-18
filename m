Return-Path: <linux-kernel+bounces-256517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14183934F92
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 17:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6370BB2171C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647E114372D;
	Thu, 18 Jul 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lIBACKp5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Pq7ppfVz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lIBACKp5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Pq7ppfVz"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594F057CB1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314897; cv=none; b=rRFHAEu6fWHgp2PRMdPzsMvzjmM33CZC28PxUCBrQX05LKx/RaFmQosChYr6b4mWXBJ6/9RyJJKtuBEXzbMLvqTkRR3nWg2AKMiJlaKnt91F82xkqw8inhEh6KG1a5iiyN0TIgVDyblwGOp2NsF+AkRHpBuXFhhHvDGxHoQsrhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314897; c=relaxed/simple;
	bh=LMyhhQF6X29lnijo5ftYnRiTUvjB5YGCygk9+VWK5zw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZhcc0ApWVSCoIf34gUvg36DnWyX0cz5pJiiJH+FOJ92ZIiA+NUR2Y9RKuqm0GEQRd2LlDbAWx5QIiFl8XFfR4ANNmH/fgFkG9TAxYcBq9wWn1fureNCFkErSC3LuCwvmt7+tifanH1rbQSR/Y/83W1GSueOjK1U8iH1HioJ0lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lIBACKp5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pq7ppfVz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lIBACKp5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Pq7ppfVz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6F5921C42;
	Thu, 18 Jul 2024 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721314887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yV4TeQugCl71IXXzVmHUMoZ/I9+FLfvcjsxLKdbeKco=;
	b=lIBACKp5slAD5BD3DrgOI1SALDfjWWHfQq536hK0w3/BbZw/hP8TewVrg0PTSzP+SI0LrX
	A7dyGTLMGisTmZjr1NwopdyuVrHSSpz/Ef27aE+j4YN+9teGgbiI4PUFGWcYFzYs80MA8S
	RJMeSntmmPtOb3o3PKb5QEu5ZqJVlYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721314887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yV4TeQugCl71IXXzVmHUMoZ/I9+FLfvcjsxLKdbeKco=;
	b=Pq7ppfVzgL8iqg3BBnoutEo+RqbWsl51Fh+KffZeBrb1R4WzeLloiBdsh6YXFIigT82zJN
	MELimildw9EmP2DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lIBACKp5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Pq7ppfVz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721314887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yV4TeQugCl71IXXzVmHUMoZ/I9+FLfvcjsxLKdbeKco=;
	b=lIBACKp5slAD5BD3DrgOI1SALDfjWWHfQq536hK0w3/BbZw/hP8TewVrg0PTSzP+SI0LrX
	A7dyGTLMGisTmZjr1NwopdyuVrHSSpz/Ef27aE+j4YN+9teGgbiI4PUFGWcYFzYs80MA8S
	RJMeSntmmPtOb3o3PKb5QEu5ZqJVlYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721314887;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yV4TeQugCl71IXXzVmHUMoZ/I9+FLfvcjsxLKdbeKco=;
	b=Pq7ppfVzgL8iqg3BBnoutEo+RqbWsl51Fh+KffZeBrb1R4WzeLloiBdsh6YXFIigT82zJN
	MELimildw9EmP2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67294136F7;
	Thu, 18 Jul 2024 15:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rfjSF0cumWY1JAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Jul 2024 15:01:27 +0000
Date: Thu, 18 Jul 2024 17:02:01 +0200
Message-ID: <87frs6vj4m.wl-tiwai@suse.de>
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
In-Reply-To: <9a0eba2e-9933-43bb-ab3b-0480bf1d34a4@linux.intel.com>
References: <202407160704.zpdhJ8da-lkp@intel.com>
	<05954a59-2bef-4262-bd91-cfe21d2381f2@linux.intel.com>
	<20240717202806.GA728411@thelio-3990X>
	<87wmljw485.wl-tiwai@suse.de>
	<d121ec31-0861-4324-8f53-6e06eaf60233@linux.intel.com>
	<87le1zvzw9.wl-tiwai@suse.de>
	<9a0eba2e-9933-43bb-ab3b-0480bf1d34a4@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: A6F5921C42
X-Spam-Flag: NO
X-Spam-Score: 0.49
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spamd-Bar: /

On Thu, 18 Jul 2024 11:12:24 +0200,
Pierre-Louis Bossart wrote:
> 
> 
> 
> >>> --- a/sound/soc/sof/intel/Kconfig
> >>> +++ b/sound/soc/sof/intel/Kconfig
> >>> @@ -19,6 +19,7 @@ config SND_SOC_SOF_INTEL_ATOM_HIFI_EP
> >>>  	tristate
> >>>  	select SND_SOC_SOF_INTEL_COMMON
> >>>  	select SND_SOC_SOF_INTEL_HIFI_EP_IPC
> >>> +	select IOSF_MBI if X86 && PCI
> >>>  	help
> >>>  	  This option is not user-selectable but automagically handled by
> >>>  	  'select' statements at a higher level.
> >>> @@ -44,7 +45,6 @@ config SND_SOC_SOF_BAYTRAIL
> >>>  	select SND_SOC_SOF_INTEL_COMMON
> >>>  	select SND_SOC_SOF_INTEL_ATOM_HIFI_EP
> >>>  	select SND_SOC_SOF_ACPI_DEV
> >>> -	select IOSF_MBI if X86 && PCI
> >>>  	help
> >>>  	  This adds support for Sound Open Firmware for Intel(R) platforms
> >>>  	  using the Baytrail, Braswell or Cherrytrail processors.
> >>
> >> I don't think it's the 'right' fix Takashi.
> >>
> >> The problem is that we end-up using the iosf_mbi_read() routine by
> >> including the soc-intel-quirks.h header file blindly for all X66
> >> platforms - even when Baytrail is not used.
> >>
> >> Adding IOSF support for Tangiger doesn't seem right to me, it's not a
> >> real dependency.
> >>
> >> We can be more restrictive and only use the helper for Baytrail, and use
> >> a fallback if Baytrail is not used.
> >>
> >> diff --git a/sound/soc/intel/common/soc-intel-quirks.h
> >> b/sound/soc/intel/common/soc-intel-quirks.h
> >> index de4e550c5b34..ae67853f7e2e 100644
> >> --- a/sound/soc/intel/common/soc-intel-quirks.h
> >> +++ b/sound/soc/intel/common/soc-intel-quirks.h
> >> @@ -11,7 +11,9 @@
> >>
> >>  #include <linux/platform_data/x86/soc.h>
> >>
> >> -#if IS_ENABLED(CONFIG_X86)
> >> +#if IS_ENABLED(CONFIG_X86) && \
> >> +       (IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL) || \
> >> +        IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI))
> >>
> >>  #include <linux/dmi.h>
> >>  #include <asm/iosf_mbi.h>
> >>
> >> also at https://github.com/thesofproject/linux/pull/5114
> > 
> > I'm afraid it's not enough, either.  It's included in
> > sound/soc/sof/intel/atom.c, and this one can be built-in by selected
> > from others while CONFIG_SND_SOC_SOF_BAYTRAIL=m.  And, the reverse
> > selection is done from CONFIG_SND_SOC_SOF_BAYTRAIL -- so
> > CONFIG_IOSF_MBI can be m as well, and this can lead to the unresolved
> > symbol from the built-in atom.c.
> 
> Fair point, I was only looking at the reported failure where Baytrail
> was completely disabled.
> 
> I am not sure though if it makes sense to split hair in N dimensions.
> Building Merrifield as y and Baytrail as m is a corner case that
> shouldn't exist at all. And it's only an academic compilation issue, in
> practice using 'y' would fail at run-time due to the usual firmware load
> dependencies...

Surely this kind of bug won't hit anyone in practical use, but it's
only about the randconfig failures.  The original report is in the
same category, after all.

Maybe another (rather easier) workaround would be to use
IS_REACHABLE(), something like below.  This should fix the original
issue and the potential mess-up of kconfig dependencies.


Takashi

--- a/sound/soc/intel/common/soc-intel-quirks.h
+++ b/sound/soc/intel/common/soc-intel-quirks.h
@@ -11,7 +11,7 @@
 
 #include <linux/platform_data/x86/soc.h>
 
-#if IS_ENABLED(CONFIG_X86)
+#if IS_REACHABLE(CONFIG_IOSF_MBI)
 
 #include <linux/dmi.h>
 #include <asm/iosf_mbi.h>

