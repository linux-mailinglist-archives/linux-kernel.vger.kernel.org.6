Return-Path: <linux-kernel+bounces-420555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A2A9D7C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EFC2825B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F015B54C;
	Mon, 25 Nov 2024 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lq/iQABk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3834E24B26
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732521685; cv=none; b=PhubMkFXlAK6gVEPPxrY5AREphJlxv694UfYaOGXYBIS0Y344k6MNiQ0L0qnJef54sV4xRpAsbVMB4LLCpDkhf2MHGwxYo9qBlHG2CW7cGxG0sQYk+FE0iYBAwhV9/iK0phygwJDbt1K9NRCQ3YDdwdGzNuE9O5G6CkEATl8w3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732521685; c=relaxed/simple;
	bh=VwPin5E1zw6FOQBCxg0G38H2uhottJ6IESfVaNnp7QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQZzheGwxd3eI936fpTxspQQm/80oFBf3xz7WMbpAFjSPK2GEQur/qUiw+wIsSkXVAra6AurZ/qc+JntQz8xBsAPYzv0pFnt25v2B21FjyiVeKJ7DyMYeu2Dg+sSokrUBRj7putPBC/AH4UrgWIjeBrmRCU2TFPkciHQ68sjsL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lq/iQABk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732521683; x=1764057683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VwPin5E1zw6FOQBCxg0G38H2uhottJ6IESfVaNnp7QM=;
  b=lq/iQABkmtd1Py5ejqKN/QwdAG/K02gXZFxsZ+NPcSCn8+TSCW2sJmwA
   b4guQp3Ti710t/FxLaIWWPP3txzIKoRlMSHT3PLoOYjL8RsPAguKOWnL0
   6MnGux9MLJHoGuuaPOroqRbF/usXbnIKcdCpOjm+rqM3QW84oq1R+HO+b
   vCLF1jkAEpnXIGWN5y/ZG3wu4qSRyMSOHkj96O44i3NoK7Gvm3idPMosi
   CjeDNvzwkWXp3Bg09GJORjBA2F12v35HSPRdFmTMe2+eSGgzYPv2MJTaN
   YOltk8MynDyWbxSk+ZcwVEGBd2jXGCFgj7kjYUspMpU3wPBy+wHze11q4
   w==;
X-CSE-ConnectionGUID: Tys0YFoTROS23GSlBdRKjQ==
X-CSE-MsgGUID: yezXZXX/TDeS8UWd3Ykdwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="20204232"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="20204232"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 00:01:11 -0800
X-CSE-ConnectionGUID: Yc6uiQ4dQVWOAHMTpwvGvg==
X-CSE-MsgGUID: v3uwD0VKRai+2fLwq30Oyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="96112005"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 25 Nov 2024 00:01:09 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFU1q-00063d-15;
	Mon, 25 Nov 2024 08:01:06 +0000
Date: Mon, 25 Nov 2024 16:00:47 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] objtool: Add noinstr validation for static
 branches/calls
Message-ID: <202411251530.5P17DWTE-lkp@intel.com>
References: <b5746646456eb030673cdb62c23d69ed83c2702a.1732326588.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5746646456eb030673cdb62c23d69ed83c2702a.1732326588.git.jpoimboe@kernel.org>

Hi Josh,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12 next-20241125]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Poimboeuf/jump_label-Add-annotations-for-validating-noinstr-usage/20241125-105905
base:   linus/master
patch link:    https://lore.kernel.org/r/b5746646456eb030673cdb62c23d69ed83c2702a.1732326588.git.jpoimboe%40kernel.org
patch subject: [PATCH 3/3] objtool: Add noinstr validation for static branches/calls
config: m68k-bvme6000_defconfig (https://download.01.org/0day-ci/archive/20241125/202411251530.5P17DWTE-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241125/202411251530.5P17DWTE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411251530.5P17DWTE-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/static_key.h:1,
                    from include/linux/alloc_tag.h:15,
                    from include/linux/percpu.h:5,
                    from include/linux/percpu_counter.h:14,
                    from include/linux/mm_types.h:21,
                    from include/linux/mmzone.h:22,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from mm/usercopy.c:13:
>> include/linux/jump_label.h:388:9: warning: data definition has no type or storage class
     388 |         ANNOTATE_NOINSTR_ALLOWED(name)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   mm/usercopy.c:204:8: note: in expansion of macro 'DEFINE_STATIC_KEY_FALSE_RO'
     204 | static DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/jump_label.h:388:9: error: type defaults to 'int' in declaration of 'ANNOTATE_NOINSTR_ALLOWED' [-Wimplicit-int]
     388 |         ANNOTATE_NOINSTR_ALLOWED(name)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   mm/usercopy.c:204:8: note: in expansion of macro 'DEFINE_STATIC_KEY_FALSE_RO'
     204 | static DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/jump_label.h:371:39: error: parameter names (without types) in function declaration [-Wdeclaration-missing-parameter-type]
     371 | #define STATIC_KEY_FALSE_INIT (struct static_key_false){ .key = STATIC_KEY_INIT_FALSE, }
         |                                       ^~~~~~~~~~~~~~~~
   include/linux/jump_label.h:387:56: note: in expansion of macro 'STATIC_KEY_FALSE_INIT'
     387 |         struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT;   \
         |                                                        ^~~~~~~~~~~~~~~~~~~~~
   mm/usercopy.c:204:8: note: in expansion of macro 'DEFINE_STATIC_KEY_FALSE_RO'
     204 | static DEFINE_STATIC_KEY_FALSE_RO(bypass_usercopy_checks);
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +388 include/linux/jump_label.h

   369	
   370	#define STATIC_KEY_TRUE_INIT  (struct static_key_true) { .key = STATIC_KEY_INIT_TRUE,  }
 > 371	#define STATIC_KEY_FALSE_INIT (struct static_key_false){ .key = STATIC_KEY_INIT_FALSE, }
   372	
   373	#define DEFINE_STATIC_KEY_TRUE(name)	\
   374		struct static_key_true name = STATIC_KEY_TRUE_INIT
   375	
   376	#define DEFINE_STATIC_KEY_TRUE_RO(name)						\
   377		struct static_key_true name __ro_after_init = STATIC_KEY_TRUE_INIT;	\
   378		ANNOTATE_NOINSTR_ALLOWED(name)
   379	
   380	#define DECLARE_STATIC_KEY_TRUE(name)	\
   381		extern struct static_key_true name
   382	
   383	#define DEFINE_STATIC_KEY_FALSE(name)	\
   384		struct static_key_false name = STATIC_KEY_FALSE_INIT
   385	
   386	#define DEFINE_STATIC_KEY_FALSE_RO(name)					\
   387		struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT;	\
 > 388		ANNOTATE_NOINSTR_ALLOWED(name)
   389	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

