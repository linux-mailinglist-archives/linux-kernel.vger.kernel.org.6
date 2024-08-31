Return-Path: <linux-kernel+bounces-309958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E74D896726F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635231F2270F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021E52D61B;
	Sat, 31 Aug 2024 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZmlwFos"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5E1CA9F;
	Sat, 31 Aug 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725118876; cv=none; b=ShnrKBmJSZ35gqkvhAiUoPszftHLYOH/NBkTK1xAgGxOuvzV7ahX//za2L9+F8957c0drGsONkLZPBxdpeGtpMfebYbLPCfDmU3rb5pLj6J/BhPpPhSg9lCxK/a9V2Ji9piJxtvjMRjX0wSInHUwks7bIeTg7zc7Rd2zKXVLWak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725118876; c=relaxed/simple;
	bh=1yRS0gogRh784GbSU5al2JeuuxHmmdz6/2N7DYSOzAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7GyKaJkLw9h5AGrKn4a29vL5iORo8nGrldPe6x6DEOix+MvRynJsf07EKVb7AL+1sWuZ44dFCBRurPrjKUDJDh1Xwjxz95Ff4apsusWXKqqgo0t/2vll2aWTq37aFCdZTM567ioqUpmgpE1h3aeCMH/LLAx6MnlqiUNiy6z0tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZmlwFos; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725118874; x=1756654874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1yRS0gogRh784GbSU5al2JeuuxHmmdz6/2N7DYSOzAE=;
  b=kZmlwFos2YElWPFsbmOorojoTmeAt4Y7RBdMrCluYgmHS20t5UXWKFXb
   fhg2AwRiU1IzhXE7gx+FYNDRPuIqILSDGiOb8lUC7ME2VWUP3wX+UkN1n
   1FmDp4NN9pOyinSHtEr8eMq9t1YdwFqt1bPpwLXlooXgjmXDMEURvwymc
   sDIGZ3/P6R8TtAAnWuxGXtg7vFW08tWOMgD26rJeexk5DIUPSUSFYxRJ2
   n0aLbglkUD7nspqdWMfCZUdecHxx9rk4kvVoZpPAl7AeoRzQgpqZ/Nqbu
   Pd6buEewwqum9ZLwcY3YTNeFn3b6xbh4ecgE4HZiHaso6qWKfAppUz6V+
   w==;
X-CSE-ConnectionGUID: oz+VhlZCTnCijZoCM6IXuw==
X-CSE-MsgGUID: SYF020B3Q3SGs4W7QzhxMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="34365684"
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="34365684"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 08:41:13 -0700
X-CSE-ConnectionGUID: sqe79E9EQbOtEz7nGLuCPw==
X-CSE-MsgGUID: xcrsmA2TQTaiTZu7jMdNYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="94894058"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 31 Aug 2024 08:41:11 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skQDs-0002sY-2c;
	Sat, 31 Aug 2024 15:41:08 +0000
Date: Sat, 31 Aug 2024 23:40:39 +0800
From: kernel test robot <lkp@intel.com>
To: Leo Tsai <antivirus621@gmail.com>, perex@perex.cz, tiwai@suse.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	leo.tsai@cmedia.com.tw, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Add new CM9825 driver
Message-ID: <202408312351.eV8p77QU-lkp@intel.com>
References: <20240830084521.15706-1-antivirus621@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830084521.15706-1-antivirus621@gmail.com>

Hi Leo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Leo-Tsai/ALSA-hda-Add-new-CM9825-driver/20240830-164709
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20240830084521.15706-1-antivirus621%40gmail.com
patch subject: [PATCH] ALSA: hda: Add new CM9825 driver
config: i386-buildonly-randconfig-002-20240831 (https://download.01.org/0day-ci/archive/20240831/202408312351.eV8p77QU-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408312351.eV8p77QU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408312351.eV8p77QU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/pci/hda/patch_cmedia.c:572:12: warning: variable 'spec' is uninitialized when used here [-Wuninitialized]
     572 |         codec_dbg(spec->codec, "Start\n");
         |                   ^~~~
   sound/pci/hda/hda_local.h:735:24: note: expanded from macro 'codec_dbg'
     735 |         dev_dbg(hda_codec_dev(codec), fmt, ##args)
         |                               ^~~~~
   include/sound/hda_codec.h:289:32: note: expanded from macro 'hda_codec_dev'
     289 | #define hda_codec_dev(_dev)     (&(_dev)->core.dev)
         |                                    ^~~~
   include/linux/dev_printk.h:165:18: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                         ^~~
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   sound/pci/hda/patch_cmedia.c:567:23: note: initialize the variable 'spec' to silence this warning
     567 |         struct cmi_spec *spec;
         |                              ^
         |                               = NULL
   1 warning generated.


vim +/spec +572 sound/pci/hda/patch_cmedia.c

   564	
   565	static int patch_cm9825(struct hda_codec *codec)
   566	{
   567		struct cmi_spec *spec;
   568		struct auto_pin_cfg *cfg;
   569		int err, i;
   570		const struct snd_pci_quirk *quirk;
   571	
 > 572		codec_dbg(spec->codec, "Start\n");
   573	
   574		spec = kzalloc(sizeof(*spec), GFP_KERNEL);
   575		if (spec == NULL)
   576			return -ENOMEM;
   577	
   578		codec->spec = spec;
   579		spec->codec = codec;
   580	
   581		/* Detect codec quirk */
   582		quirk = snd_pci_quirk_lookup(codec->bus->pci, cm9825_quirks);
   583		if (quirk)
   584			spec->quirk = quirk->value;
   585		else
   586			spec->quirk = QUIRK_CM9825_STANDARD;
   587	
   588		if (spec->quirk == QUIRK_CM9825_STANDARD)
   589			cm9825_detect_quirk(codec);
   590	
   591		codec_dbg(spec->codec, "spec->quirk %d\n", spec->quirk);
   592	
   593		codec->patch_ops = cmi_auto_patch_ops;
   594		codec->patch_ops.init = CM9825_init;
   595	#ifdef CONFIG_PM
   596		codec->patch_ops.suspend = cm9825_suspend;
   597		codec->patch_ops.resume = cm9825_resume;
   598		codec->patch_ops.check_power_status = snd_hda_gen_check_power_status;
   599	#endif
   600		spec->gen.init_hook = CM9825_init_hook;
   601		/* add hooks */
   602		spec->gen.pcm_playback_hook = cm9825_playback_pcm_hook;
   603	
   604		cfg = &spec->gen.autocfg;
   605		snd_hda_gen_spec_init(&spec->gen);
   606	
   607		if (spec->quirk == (int)QUIRK_CM9825_STANDARD) {
   608			snd_hda_codec_set_name(codec, "CM9825 Standard");
   609			spec->chip_D0_verbs = cm9825_D0_verbs;
   610			spec->chip_D3_verbs = cm9825_D3_verbs;
   611			spec->chip_HP_Present_verbs = cm9825_HP_Present_verbs;
   612			spec->chip_HP_Remove_verbs = cm9825_HP_Remove_verbs;
   613			spec->chip_playback_start_verbs =
   614			    cm9825_std_playback_start_verbs;
   615			spec->chip_playback_stop_verbs = cm9825_std_playback_stop_verbs;
   616		} else if (spec->quirk == (int)QUIRK_CM9825_NCR) {
   617	#ifdef CONFIG_PM
   618			codec->patch_ops.suspend = cm9825_NCR_suspend;
   619			codec->patch_ops.resume = cm9825_NCR_resume;
   620			codec->patch_ops.check_power_status =
   621			    snd_hda_gen_check_power_status;
   622	#endif
   623			snd_hda_codec_set_name(codec, "CM9825 NCR");
   624			snd_hda_sequence_write(codec, cm9825_NCR_TpCon_verbs);
   625			spec->chip_D0_verbs = cm9825_NCR_D0_verbs;
   626			spec->chip_D3_verbs = cm9825_NCR_D3_verbs;
   627			spec->chip_playback_start_verbs =
   628			    cm9825_NCR_playback_start_verbs;
   629			spec->chip_playback_stop_verbs = cm9825_NCR_playback_stop_verbs;
   630	
   631			for (i = 0; i < ARRAY_SIZE(cm9825_ncr_mixer); i++) {
   632				err = snd_hda_add_new_ctls(codec, &cm9825_ncr_mixer[i]);
   633				if (err < 0) {
   634					codec_info(codec, "add new ctls fail: %d\n",
   635						   err);
   636					goto error;
   637				}
   638			}
   639		} else {
   640			snd_hda_codec_set_name(codec, "CM9825 Standard");
   641			spec->chip_D0_verbs = cm9825_D0_verbs;
   642			spec->chip_D3_verbs = cm9825_D3_verbs;
   643			spec->chip_HP_Present_verbs = cm9825_HP_Present_verbs;
   644			spec->chip_HP_Remove_verbs = cm9825_HP_Remove_verbs;
   645			spec->chip_playback_start_verbs =
   646			    cm9825_std_playback_start_verbs;
   647			spec->chip_playback_stop_verbs = cm9825_std_playback_stop_verbs;
   648		}
   649	
   650		err = snd_hda_parse_pin_defcfg(codec, cfg, NULL, 0);
   651		if (err < 0)
   652			goto error;
   653		err = snd_hda_gen_parse_auto_config(codec, cfg);
   654		if (err < 0)
   655			goto error;
   656	
   657		if (spec->quirk == (int)QUIRK_CM9825_STANDARD) {
   658			INIT_DELAYED_WORK(&spec->unsol_hp_work,
   659					  cm9825_unsol_hp_delayed);
   660			cm9825_setup_unsol(codec);
   661		}
   662	
   663		return 0;
   664	
   665	 error:
   666		snd_hda_gen_free(codec);
   667	
   668		codec_info(codec, "Enter err %d\n", err);
   669	
   670		return err;
   671	}
   672	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

