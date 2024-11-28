Return-Path: <linux-kernel+bounces-424274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DAF9DB286
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7AA31669E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAA81386BF;
	Thu, 28 Nov 2024 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+zVe/Zu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E512C7FD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772354; cv=none; b=SUzDAHJy4/1Oz0zXv877HXCicdCShMGGXY68pE58Sqm74LUu82vz4AegacakJWAvuLvaldi5YUiVjuwQZwDpXEWwm9thXLP5GVnkfAww2fDsz9OdUR8+LNDCFN8PVrMH1RSSScHP4Qi2RIB/6/L+azIxSPidnsndZo8nHuCXaqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772354; c=relaxed/simple;
	bh=B0vZklBwNDmwQMG06w70lemTGYc31gfmnRE1kjX7Cgw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hB3CqpQVJiscGQWqptEb9L+/JgdEwC9Lf6lRAWtTOHifnynctdPo9UhJ0fGgHwEE6azZSPBxVJZ8W8+IAVRkJoe1Vmpd+lWEMqv5SMiaCGhm0fs9ygnBv3qVyGcxzBSvLpqXKOttSGABrIcXwbZ4hVlvBeIKAzf4BLB3wG7/sY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+zVe/Zu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732772352; x=1764308352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B0vZklBwNDmwQMG06w70lemTGYc31gfmnRE1kjX7Cgw=;
  b=c+zVe/Zuke1EvfthYrGkXR4/DAJ+1wDz8djMRTRtF3vj0NXBxfaY+t8u
   jSa0j7EsqBH1+ImIjNXfOa/74Xr23teRZkiE5Az99+JNuqxsBp1vFfml+
   rSyA2NudI8wsEXHrala67MjTkHf+Acd/FX5OYWWR+P7C+ienzQWIOdbG+
   EpHD8BYPmfe9sMldWEjUR97z7NtW90eXO/BGvXjtZx8U4MbC56aBsb1r5
   WvX9RMs4epRgodmFFOk5sAAKLb3PoLzAloQ1DnDUwummWHZhIF7Tcp7Vr
   aqJfVhux+2zBEKO/gnrBUCj+S95VsdAs6QN1bS2ibrkMs8hcT+CFbYX8W
   g==;
X-CSE-ConnectionGUID: FQUP5wv3Rhm43MraJPZS7Q==
X-CSE-MsgGUID: KHzTJwMbQUi54BOvgWFckw==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="33045262"
X-IronPort-AV: E=Sophos;i="6.12,191,1728975600"; 
   d="scan'208";a="33045262"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 21:39:12 -0800
X-CSE-ConnectionGUID: LYtrgb11QLKcuotchUC5sQ==
X-CSE-MsgGUID: YvU0qcPxS3WH+Nl3FDSlLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,191,1728975600"; 
   d="scan'208";a="97222905"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 27 Nov 2024 21:39:10 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGXF6-00096r-0V;
	Thu, 28 Nov 2024 05:39:08 +0000
Date: Thu, 28 Nov 2024 13:38:21 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: sound/sh/sh_dac_audio.c:166:51: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202411281337.I4M07b7i-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b86545e02e8c22fb89218f29d381fa8e8b91d815
commit: 2f432f4702134fac27677f13aba69ed830984f75 ALSA: sh: Convert to generic PCM copy ops
date:   1 year, 3 months ago
config: sh-randconfig-r111-20241122 (https://download.01.org/0day-ci/archive/20241128/202411281337.I4M07b7i-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241128/202411281337.I4M07b7i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411281337.I4M07b7i-lkp@intel.com/

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

