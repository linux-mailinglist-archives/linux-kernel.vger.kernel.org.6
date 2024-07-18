Return-Path: <linux-kernel+bounces-256197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1399D934A93
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF23286906
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A6E7FBB7;
	Thu, 18 Jul 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HpeAowGg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t/4+r5pS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HpeAowGg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t/4+r5pS"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15747A724
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293160; cv=none; b=EGSY7Z1ogbg9w/A7FH5kd7oTBriSsZxBvsYeTOzWY9au/Q2yTvmJQp7rAhBfmW8Kgz9Xm4wXNcQVX8oa0HbFXikCRXXx2p7g1uBoIVKxN5x4PY5LVOyFQzQ7dJQ6IdDYMhKiSpLvH870nVB19veUTdXEq1P3ARjFqg4Zt1DD1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293160; c=relaxed/simple;
	bh=wz8IiRkcZgv3AiR1NM0I7Wc/BLVh3PkZKC1ObL2zxJk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXmA5PK2KystdLj25INbzCv7iD1AhFq1I9MCV0lJ0O0XuslVH2B1FxmjYBcg4xY9JEM9jnaNXUGX9kVrBgkVIjn/d1ybZ4i4m71d30TrElbL2fE98DVY4io2jLYlXUY72e4qCfyLAz4lgGLzFUCVyQ1OvZnzvslSYKxxQ+BpUfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HpeAowGg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t/4+r5pS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HpeAowGg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t/4+r5pS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0F3D21A8F;
	Thu, 18 Jul 2024 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721293156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utMazb4YJyWnwpovRzbfw4mOb5XBTZiQfEYQejjRCKI=;
	b=HpeAowGgijmzJlQ2fHr9Ke4E8ndQjKdgLo4ZmT9bvqUyYvOmAlH5A5RzRmnzm+tWPtqhxT
	dumgBS+DofYoQHa60Rk/q4/BKoa+8ivejDz/lP7+YwOEZ3/C0zWLCcUJEK2msfuEWKVf6O
	dhemWs3kXNw249sTpABAzIhDbwQKwG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721293156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utMazb4YJyWnwpovRzbfw4mOb5XBTZiQfEYQejjRCKI=;
	b=t/4+r5pSZQrE5sinesuQb3hYQn+bS8tUtIyUe3xYjWqvRZFc0KQ9x9+dQPZgaO/7fLPmKg
	XUKs5W61akjd3XCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721293156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utMazb4YJyWnwpovRzbfw4mOb5XBTZiQfEYQejjRCKI=;
	b=HpeAowGgijmzJlQ2fHr9Ke4E8ndQjKdgLo4ZmT9bvqUyYvOmAlH5A5RzRmnzm+tWPtqhxT
	dumgBS+DofYoQHa60Rk/q4/BKoa+8ivejDz/lP7+YwOEZ3/C0zWLCcUJEK2msfuEWKVf6O
	dhemWs3kXNw249sTpABAzIhDbwQKwG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721293156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utMazb4YJyWnwpovRzbfw4mOb5XBTZiQfEYQejjRCKI=;
	b=t/4+r5pSZQrE5sinesuQb3hYQn+bS8tUtIyUe3xYjWqvRZFc0KQ9x9+dQPZgaO/7fLPmKg
	XUKs5W61akjd3XCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D153136F7;
	Thu, 18 Jul 2024 08:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9ukRJWTZmGbuLgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Jul 2024 08:59:16 +0000
Date: Thu, 18 Jul 2024 10:59:50 +0200
Message-ID: <87le1zvzw9.wl-tiwai@suse.de>
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
In-Reply-To: <d121ec31-0861-4324-8f53-6e06eaf60233@linux.intel.com>
References: <202407160704.zpdhJ8da-lkp@intel.com>
	<05954a59-2bef-4262-bd91-cfe21d2381f2@linux.intel.com>
	<20240717202806.GA728411@thelio-3990X>
	<87wmljw485.wl-tiwai@suse.de>
	<d121ec31-0861-4324-8f53-6e06eaf60233@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Thu, 18 Jul 2024 10:23:40 +0200,
Pierre-Louis Bossart wrote:
> 
> 
> 
> On 7/18/24 09:26, Takashi Iwai wrote:
> > On Wed, 17 Jul 2024 22:28:06 +0200,
> > Nathan Chancellor wrote:
> >>
> >> On Wed, Jul 17, 2024 at 01:43:35PM +0200, Pierre-Louis Bossart wrote:
> >>>
> >>>
> >>> On 7/16/24 01:07, kernel test robot wrote:
> >>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >>>> head:   3e7819886281e077e82006fe4804b0d6b0f5643b
> >>>> commit: 8d4ba1be3d2257606e04aff412829d8972670750 ASoC: SOF: pci: split PCI into different drivers
> >>>> date:   3 years, 4 months ago
> >>>
> >>> This doesn't seem to be a problem on the latest code? was it intentional
> >>> to report a problem on such an old commit?
> >>
> >> It's still reproducible at commit 8b0f0bb27c32 ("Merge tag
> >> 'fs_for_v6.11-rc1' of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs") for me,
> >> using either LLVM or GCC with the configuration linked below:
> 
> I can't compile this branch - errors in unrelated parts of the code, but
> indeed there's a problem when IOSF_MBI=y and Baytrail is not selected.
> 
> >>   ld.lld: error: undefined symbol: iosf_mbi_available
> >>   >>> referenced by atom.c
> >>   >>>               sound/soc/sof/intel/atom.o:(atom_machine_select) in archive vmlinux.a
> >>
> >>   ld.lld: error: undefined symbol: iosf_mbi_read
> >>   >>> referenced by atom.c
> >>   >>>               sound/soc/sof/intel/atom.o:(atom_machine_select) in archive vmlinux.a
> >>
> >>   .../gcc/14.1.0/bin/i386-linux-ld: sound/soc/sof/intel/atom.o: in function `atom_machine_select':
> >>   atom.c:(.text+0x1b9): undefined reference to `iosf_mbi_available'
> >>   .../gcc/14.1.0/bin/i386-linux-ld: atom.c:(.text+0x1e3): undefined reference to `iosf_mbi_read'
> > 
> > Yours looks different from the original report, and indeed this must
> > be a missing fix.
> > 
> > Does the following change cover it?
> > 
> > 
> > thanks,
> > 
> > Takashi
> > 
> > --- a/sound/soc/sof/intel/Kconfig
> > +++ b/sound/soc/sof/intel/Kconfig
> > @@ -19,6 +19,7 @@ config SND_SOC_SOF_INTEL_ATOM_HIFI_EP
> >  	tristate
> >  	select SND_SOC_SOF_INTEL_COMMON
> >  	select SND_SOC_SOF_INTEL_HIFI_EP_IPC
> > +	select IOSF_MBI if X86 && PCI
> >  	help
> >  	  This option is not user-selectable but automagically handled by
> >  	  'select' statements at a higher level.
> > @@ -44,7 +45,6 @@ config SND_SOC_SOF_BAYTRAIL
> >  	select SND_SOC_SOF_INTEL_COMMON
> >  	select SND_SOC_SOF_INTEL_ATOM_HIFI_EP
> >  	select SND_SOC_SOF_ACPI_DEV
> > -	select IOSF_MBI if X86 && PCI
> >  	help
> >  	  This adds support for Sound Open Firmware for Intel(R) platforms
> >  	  using the Baytrail, Braswell or Cherrytrail processors.
> 
> I don't think it's the 'right' fix Takashi.
> 
> The problem is that we end-up using the iosf_mbi_read() routine by
> including the soc-intel-quirks.h header file blindly for all X66
> platforms - even when Baytrail is not used.
> 
> Adding IOSF support for Tangiger doesn't seem right to me, it's not a
> real dependency.
> 
> We can be more restrictive and only use the helper for Baytrail, and use
> a fallback if Baytrail is not used.
> 
> diff --git a/sound/soc/intel/common/soc-intel-quirks.h
> b/sound/soc/intel/common/soc-intel-quirks.h
> index de4e550c5b34..ae67853f7e2e 100644
> --- a/sound/soc/intel/common/soc-intel-quirks.h
> +++ b/sound/soc/intel/common/soc-intel-quirks.h
> @@ -11,7 +11,9 @@
> 
>  #include <linux/platform_data/x86/soc.h>
> 
> -#if IS_ENABLED(CONFIG_X86)
> +#if IS_ENABLED(CONFIG_X86) && \
> +       (IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL) || \
> +        IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI))
> 
>  #include <linux/dmi.h>
>  #include <asm/iosf_mbi.h>
> 
> also at https://github.com/thesofproject/linux/pull/5114

I'm afraid it's not enough, either.  It's included in
sound/soc/sof/intel/atom.c, and this one can be built-in by selected
from others while CONFIG_SND_SOC_SOF_BAYTRAIL=m.  And, the reverse
selection is done from CONFIG_SND_SOC_SOF_BAYTRAIL -- so
CONFIG_IOSF_MBI can be m as well, and this can lead to the unresolved
symbol from the built-in atom.c.


Takashi

