Return-Path: <linux-kernel+bounces-264926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8397893EA41
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8A71F21A31
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 00:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDA92119;
	Mon, 29 Jul 2024 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8kklQHa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132423CE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722212671; cv=none; b=thEJU05Oho58NoOVVZtlJOPT323jj6DiGU1QFUXi1GOqti3+Kx1OjJtqhWaRvqzanmOpKfgonE72t5FudaGU8AjSvXbnNbBp7oxWRVmrXfz4kryIT/FcTQ03fY/oDCD2135XCLHXqMuEbtorCHOHrxN5MnjbkKKGWFny3kNBiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722212671; c=relaxed/simple;
	bh=2rUdhiyMtvotEXvhQWzJQbm/BPzmARed0w5ZOz4WRgM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FRJd3ZYAgdOcHz08qnh8da0iipTUFF/QcFjnI1IeXV9J2QgYoUKVaHJB+TjnXeuLyr4ycSxSwXYIFPKM84Y1STJ3hWXekBfyJQ38AnM5ECrrA+qZ/m0HJ6c147cRHqChEoEbFvAN7tBvOvEEjAvrCRBNEWECmMEH6KZjY1OI8BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8kklQHa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722212668; x=1753748668;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2rUdhiyMtvotEXvhQWzJQbm/BPzmARed0w5ZOz4WRgM=;
  b=M8kklQHaVW5alZ86OZQ5N2KM7LhD6sUwgGo1QOxPH2AmmD3L5kY+D84s
   yV1+msR5Pxi1ic5k182WsetiVv9rNK7cvl9acp12Z1l62ki2+S6XxbfEd
   YewMagj9fzNLh4biodqbH+qfYr+P4vOLwVSMj7M8a3yEvdV0HlUfFTzUL
   ZVwkRtvwJNRiQuCRTHMlromOCoovmFEAFF7nttmcs9mWJmVdRnBq7+ePz
   5kPiubRfClRDXVpyTFGppC/DoHc12McnMpNgfNAoA6+xIUwSlVPh/YHhn
   PCghk9e30p1LXm0QqQnNevYxHZq02IAgjzjA1SPNiGtQogG6V75bSYHMl
   w==;
X-CSE-ConnectionGUID: OFWzxQTeQ4eL3nkxaFxLCw==
X-CSE-MsgGUID: ggyWUEQrQTKky0rBd+uLUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="23799646"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="23799646"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 17:24:28 -0700
X-CSE-ConnectionGUID: C1TxtJZCSW2WF5xhmuLV3g==
X-CSE-MsgGUID: 8uQE4nLXQ+mTMZ23ZaNLsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="77038344"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 28 Jul 2024 17:24:27 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYEBc-000rGs-33;
	Mon, 29 Jul 2024 00:24:24 +0000
Date: Mon, 29 Jul 2024 08:23:56 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: sound/sh/sh_dac_audio.c:166:51: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202407290821.VLAGtgbv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8400291e289ee6b2bf9779ff1c83a291501f017b
commit: 2f432f4702134fac27677f13aba69ed830984f75 ALSA: sh: Convert to generic PCM copy ops
date:   12 months ago
config: sh-randconfig-r133-20240729 (https://download.01.org/0day-ci/archive/20240729/202407290821.VLAGtgbv-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240729/202407290821.VLAGtgbv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407290821.VLAGtgbv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/sh/sh_dac_audio.c:166:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *dst @@     got char * @@
   sound/sh/sh_dac_audio.c:166:51: sparse:     expected void [noderef] __iomem *dst
   sound/sh/sh_dac_audio.c:166:51: sparse:     got char *
   sound/sh/sh_dac_audio.c:185:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem * @@     got char * @@
   sound/sh/sh_dac_audio.c:185:37: sparse:     expected void volatile [noderef] __iomem *
   sound/sh/sh_dac_audio.c:185:37: sparse:     got char *
   sound/sh/sh_dac_audio.c: note: in included file:
   arch/sh/include/cpu-sh3/cpu/dac.h:38:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/cpu-sh3/cpu/dac.h:38:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/cpu-sh3/cpu/dac.h:38:21: sparse:     got unsigned int
   arch/sh/include/cpu-sh3/cpu/dac.h:39:14: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/cpu-sh3/cpu/dac.h:39:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/cpu-sh3/cpu/dac.h:39:14: sparse:     got unsigned int

vim +166 sound/sh/sh_dac_audio.c

   158	
   159	static int snd_sh_dac_pcm_copy(struct snd_pcm_substream *substream,
   160				       int channel, unsigned long pos,
   161				       struct iov_iter *src, unsigned long count)
   162	{
   163		/* channel is not used (interleaved data) */
   164		struct snd_sh_dac *chip = snd_pcm_substream_chip(substream);
   165	
 > 166		if (copy_from_iter_toio(chip->data_buffer + pos, src, count))
   167			return -EFAULT;
   168		chip->buffer_end = chip->data_buffer + pos + count;
   169	
   170		if (chip->empty) {
   171			chip->empty = 0;
   172			dac_audio_start_timer(chip);
   173		}
   174	
   175		return 0;
   176	}
   177	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

