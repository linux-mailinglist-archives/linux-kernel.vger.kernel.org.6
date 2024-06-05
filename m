Return-Path: <linux-kernel+bounces-202262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C96858FCA74
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC971F22E61
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1883193062;
	Wed,  5 Jun 2024 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZqqxsZ+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130F38F6A;
	Wed,  5 Jun 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586918; cv=none; b=nJyUkfMMh7Pf1Yez71aZ2770+o28eApbssSJprmOTqjgKd2kYLaKZH+/STU2lpiYm8cLBUVyEmTSMm84/pdl0S01obKgJn2f72/n/pVnCkTon7Ffyq0kdpqtykTQxuj59UguBVt2Q9lKyQBo/NEwCfyhWLeMootZGPmfe0K4EfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586918; c=relaxed/simple;
	bh=LZF9UrI54WCbcmYJmTKIePobwE96awTpAKL5pDTIjVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qp7ReEE9MrFAtg5OfsWYq4q+uwEiJ3do+5SPnM1bcLMmi7kxouibMTQmxc26EV9M25Ep3AzXS0caPpNLZdfW1ErVZVlguM5b9gYaBwsW7Niq3an7Kkbo5p0tsE5jIIkJtpSV1BGMIt2YkfNblUOFNOQ0b0d5++5mYQ0/k0loJOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZqqxsZ+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717586916; x=1749122916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LZF9UrI54WCbcmYJmTKIePobwE96awTpAKL5pDTIjVU=;
  b=kZqqxsZ+A2Qh9fEGVKwsfwZ0i7NWx2ggTa5TK4h7xJ8Vreok9BszaTDd
   S0NSxE6X1unQ8gX1W2FrF+mOTGLjeSTYuwegGbpeaIvzu2JtNIMZAgxlK
   PfYYUabU1yRTYAiMTQLFpEQy0D5ClGQ6VAVnewyMr/O/9CE9v57LVocFq
   NhCDSt8f1ROkc6i7uSH99tjQ15p5XGntzqamuviV4WRVCWC/MhJ83WMEz
   hbyxig/BoJtQkkc4Rzj/CJ11dm42oGCt+Xna09poD1+ivhk5rRozvpli+
   5poZcsFT1yTC9fgt7owaXlHw4SgQwswD2L/UauRTxxs9Ba2Lb1Z8rAKDY
   A==;
X-CSE-ConnectionGUID: SGXppLIURMSxLCa8Um8MKQ==
X-CSE-MsgGUID: a5yEQk7UQXyX+PA98Yraiw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14304991"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14304991"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:28:35 -0700
X-CSE-ConnectionGUID: wisKOJgcSDShxkJdQHiBSw==
X-CSE-MsgGUID: iujfoEyuT0+YDLdY0lhqmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="42001639"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 05 Jun 2024 04:28:33 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEooh-0001S2-1i;
	Wed, 05 Jun 2024 11:28:31 +0000
Date: Wed, 5 Jun 2024 19:28:30 +0800
From: kernel test robot <lkp@intel.com>
To: bo liu <bo.liu@senarytech.com>, perex@perex.cz, tiwai@suse.com
Cc: oe-kbuild-all@lists.linux.dev, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, bo liu <bo.liu@senarytech.com>
Subject: Re: [PATCH] ALSA: hda/senarytech: add senarytech codec support
Message-ID: <202406051902.R67SGht9-lkp@intel.com>
References: <20240603093429.25511-1-bo.liu@senarytech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603093429.25511-1-bo.liu@senarytech.com>

Hi bo,

kernel test robot noticed the following build errors:

[auto build test ERROR on tiwai-sound/for-next]
[also build test ERROR on tiwai-sound/for-linus linus/master v6.10-rc2 next-20240605]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/bo-liu/ALSA-hda-senarytech-add-senarytech-codec-support/20240603-181658
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20240603093429.25511-1-bo.liu%40senarytech.com
patch subject: [PATCH] ALSA: hda/senarytech: add senarytech codec support
config: sparc64-randconfig-r081-20240605 (https://download.01.org/0day-ci/archive/20240605/202406051902.R67SGht9-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406051902.R67SGht9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406051902.R67SGht9-lkp@intel.com/

All errors (new ones prefixed by >>):

   sound/pci/hda/patch_senarytech.c: In function 'patch_senary_auto':
>> sound/pci/hda/patch_senarytech.c:219:43: error: macro "senary_auto_parse_beep" passed 1 arguments, but takes just 0
     219 |         err = senary_auto_parse_beep(codec);
         |                                           ^
   sound/pci/hda/patch_senarytech.c:76: note: macro "senary_auto_parse_beep" defined here
      76 | #define senary_auto_parse_beep()        0
         | 
>> sound/pci/hda/patch_senarytech.c:219:15: error: 'senary_auto_parse_beep' undeclared (first use in this function); did you mean 'senary_auto_parse_eapd'?
     219 |         err = senary_auto_parse_beep(codec);
         |               ^~~~~~~~~~~~~~~~~~~~~~
         |               senary_auto_parse_eapd
   sound/pci/hda/patch_senarytech.c:219:15: note: each undeclared identifier is reported only once for each function it appears in


vim +/senary_auto_parse_beep +219 sound/pci/hda/patch_senarytech.c

   191	
   192	static int patch_senary_auto(struct hda_codec *codec)
   193	{
   194		struct senary_spec *spec;
   195		int err;
   196	
   197		codec_info(codec, "%s: BIOS auto-probing.\n", codec->core.chip_name);
   198	
   199		spec = kzalloc(sizeof(*spec), GFP_KERNEL);
   200		if (!spec)
   201			return -ENOMEM;
   202		snd_hda_gen_spec_init(&spec->gen);
   203		codec->spec = spec;
   204		codec->patch_ops = senary_auto_patch_ops;
   205	
   206		senary_auto_parse_eapd(codec);
   207		spec->gen.own_eapd_ctl = 1;
   208	
   209		if (!spec->gen.vmaster_mute.hook && spec->dynamic_eapd)
   210			spec->gen.vmaster_mute.hook = senary_auto_vmaster_hook;
   211	
   212		snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
   213	
   214		err = snd_hda_parse_pin_defcfg(codec, &spec->gen.autocfg, NULL,
   215					       spec->parse_flags);
   216		if (err < 0)
   217			goto error;
   218	
 > 219		err = senary_auto_parse_beep(codec);
   220		if (err < 0)
   221			goto error;
   222	
   223		err = snd_hda_gen_parse_auto_config(codec, &spec->gen.autocfg);
   224		if (err < 0)
   225			goto error;
   226	
   227		/* Some laptops with Senary chips show stalls in S3 resume,
   228		 * which falls into the single-cmd mode.
   229		 * Better to make reset, then.
   230		 */
   231		if (!codec->bus->core.sync_write) {
   232			codec_info(codec,
   233				   "Enable sync_write for stable communication\n");
   234			codec->bus->core.sync_write = 1;
   235			codec->bus->allow_bus_reset = 1;
   236		}
   237	
   238		snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
   239	
   240		return 0;
   241	
   242	 error:
   243		senary_auto_free(codec);
   244		return err;
   245	}
   246	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

