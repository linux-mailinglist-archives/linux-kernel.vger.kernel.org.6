Return-Path: <linux-kernel+bounces-256081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 735229348BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95751F22568
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8272B74058;
	Thu, 18 Jul 2024 07:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="poFAvwBd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oRN5uQXj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="poFAvwBd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oRN5uQXj"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD36F2E5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287548; cv=none; b=FgB6sEIXxv4BALIU92BsDef83COCTo/t/gBiLdQ8HpdkwXUcJeQXp8srO/q89C6q+bE3/qyl9dpZfPpkg8s+xOjMjm4EAy1ESM7joPkR5+1TxMzLG31KWhZF2ZYxaHagLgEmso2mFqTBdKRZntimGzsW6m70xxravcL4CfFwKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287548; c=relaxed/simple;
	bh=0H4XV8TOISM3Gt1+8SMaDb8bfqGOnzwUgxRHRqrmJTE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOAkdWrOOrEGY2wxo00rY17Lh8gzWoOTtxgXC3J4QN7s3SCXcTo8BkHFuLi5scS4gs2W0oBQtR3hxIupHm3dEOK58uKVAdzCQjHF51xnNXQueEs6PvN6ZP4lN3h64mfBFQMVIxXgdx157PCJ/z+fY3lu7SsDGJxOBhvKvwhDFPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=poFAvwBd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oRN5uQXj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=poFAvwBd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oRN5uQXj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 686A621A80;
	Thu, 18 Jul 2024 07:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721287545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mq/1yoSlo6cu8qdLhhM1bAep0Jfw5LSOtI55xWrH4fg=;
	b=poFAvwBdFdvIjnhpANGHGAjF+VZTGg/xJTb4lE5UhxoMQRfCNO0RHtXFKEGXCOJpDUD+Uk
	AWGtggcEcwduSuQd2Pb5btF/vxtpcpy2w7Sg8TdqmvW4vC6cvf0Lg84gje3fFiQ8eEq1T/
	jHpGCtyEJb2P4VmRvftqucD9+pgkWsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721287545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mq/1yoSlo6cu8qdLhhM1bAep0Jfw5LSOtI55xWrH4fg=;
	b=oRN5uQXjXNTqmxAvZNARP1zp8p/uVJifhqXhBGP4A3I5X+Vakn7gmjX39KDshqvrxH8vVV
	sJ4ayCWiSYN3XhBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721287545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mq/1yoSlo6cu8qdLhhM1bAep0Jfw5LSOtI55xWrH4fg=;
	b=poFAvwBdFdvIjnhpANGHGAjF+VZTGg/xJTb4lE5UhxoMQRfCNO0RHtXFKEGXCOJpDUD+Uk
	AWGtggcEcwduSuQd2Pb5btF/vxtpcpy2w7Sg8TdqmvW4vC6cvf0Lg84gje3fFiQ8eEq1T/
	jHpGCtyEJb2P4VmRvftqucD9+pgkWsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721287545;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mq/1yoSlo6cu8qdLhhM1bAep0Jfw5LSOtI55xWrH4fg=;
	b=oRN5uQXjXNTqmxAvZNARP1zp8p/uVJifhqXhBGP4A3I5X+Vakn7gmjX39KDshqvrxH8vVV
	sJ4ayCWiSYN3XhBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F7F81379D;
	Thu, 18 Jul 2024 07:25:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jA96BnnDmGZwEAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 18 Jul 2024 07:25:45 +0000
Date: Thu, 18 Jul 2024 09:26:18 +0200
Message-ID: <87wmljw485.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	kernel test robot <lkp@intel.com>,
	llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	Bard Liao <bard.liao@intel.com>
Subject: Re: ld.lld: error: undefined symbol: iosf_mbi_available
In-Reply-To: <20240717202806.GA728411@thelio-3990X>
References: <202407160704.zpdhJ8da-lkp@intel.com>
	<05954a59-2bef-4262-bd91-cfe21d2381f2@linux.intel.com>
	<20240717202806.GA728411@thelio-3990X>
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

On Wed, 17 Jul 2024 22:28:06 +0200,
Nathan Chancellor wrote:
> 
> On Wed, Jul 17, 2024 at 01:43:35PM +0200, Pierre-Louis Bossart wrote:
> > 
> > 
> > On 7/16/24 01:07, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   3e7819886281e077e82006fe4804b0d6b0f5643b
> > > commit: 8d4ba1be3d2257606e04aff412829d8972670750 ASoC: SOF: pci: split PCI into different drivers
> > > date:   3 years, 4 months ago
> > 
> > This doesn't seem to be a problem on the latest code? was it intentional
> > to report a problem on such an old commit?
> 
> It's still reproducible at commit 8b0f0bb27c32 ("Merge tag
> 'fs_for_v6.11-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs") for me,
> using either LLVM or GCC with the configuration linked below:
> 
>   ld.lld: error: undefined symbol: iosf_mbi_available
>   >>> referenced by atom.c
>   >>>               sound/soc/sof/intel/atom.o:(atom_machine_select) in archive vmlinux.a
> 
>   ld.lld: error: undefined symbol: iosf_mbi_read
>   >>> referenced by atom.c
>   >>>               sound/soc/sof/intel/atom.o:(atom_machine_select) in archive vmlinux.a
> 
>   .../gcc/14.1.0/bin/i386-linux-ld: sound/soc/sof/intel/atom.o: in function `atom_machine_select':
>   atom.c:(.text+0x1b9): undefined reference to `iosf_mbi_available'
>   .../gcc/14.1.0/bin/i386-linux-ld: atom.c:(.text+0x1e3): undefined reference to `iosf_mbi_read'

Yours looks different from the original report, and indeed this must
be a missing fix.

Does the following change cover it?


thanks,

Takashi

--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -19,6 +19,7 @@ config SND_SOC_SOF_INTEL_ATOM_HIFI_EP
 	tristate
 	select SND_SOC_SOF_INTEL_COMMON
 	select SND_SOC_SOF_INTEL_HIFI_EP_IPC
+	select IOSF_MBI if X86 && PCI
 	help
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level.
@@ -44,7 +45,6 @@ config SND_SOC_SOF_BAYTRAIL
 	select SND_SOC_SOF_INTEL_COMMON
 	select SND_SOC_SOF_INTEL_ATOM_HIFI_EP
 	select SND_SOC_SOF_ACPI_DEV
-	select IOSF_MBI if X86 && PCI
 	help
 	  This adds support for Sound Open Firmware for Intel(R) platforms
 	  using the Baytrail, Braswell or Cherrytrail processors.

