Return-Path: <linux-kernel+bounces-380425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2477A9AEE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564831C24780
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202AB1FC7FE;
	Thu, 24 Oct 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RL6YhmOE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9231FBF4F
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791493; cv=none; b=hgUFjN4hMsO5ECdoFof0t1z3EztFhNWCkx7BKeJ6Dmoy2KEYFKsQ+GcpgKb3ST8QH3pAi4N4GZj77SmIFCdMAxyvx09O8liwMyH0UZCHRbyypwQdwWaSQFyUNPyqtsyjgd9L4Z++njTkwMEDr4QDaZZIG8FRBA4sxvTU4LhKkgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791493; c=relaxed/simple;
	bh=JQlK9Js31W/MBJfsjyZodmRpDZ4UYtd3uRAwTaF+Pfo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YV6RsoqWRCjb4jBexWlUCZEqZdqQ1d6JSH0bkWq58iuPl57dBiXIeqoS2VY8QxDdhB1GlQE/RodtalfA0gJPUjf6SYBS7/W0x+e9SzsD739TBPpO020gIwJPzdThtS5S7y/nIiZE6SYjkziY3jwS3yZtBnLT9Uiu1+WmMs0R0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RL6YhmOE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729791491; x=1761327491;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JQlK9Js31W/MBJfsjyZodmRpDZ4UYtd3uRAwTaF+Pfo=;
  b=RL6YhmOE2GNtVXc5RInFyHVQztP+PDHiOY7DDCfSqLGbbMOh72MHMbzZ
   DgLiacBf/9Ll1xBhfmnw792CyEJTeYZejM3QhW2EmqiGOBQnaMu5FlexW
   UJyQuZ50thaI82woIPk+hUdXWpxPMJSsG/e2vQPCiiOFQATaswWIt8cun
   l9TjLuhZu4ziCAnUB78RylUv9uid147c5vQIxWU3uzCynQzDq+bMWpoJL
   Jg0xLlhj8u6c8NnzqDAYF9mQHvfOsl4zUytzlSqi9aG/wOy0viKTj7Z4Q
   jMr5Ii3CzaUAjtBnhBHrNhGH50LfHd7impBUMDRteOoOMLU7rVVmVgsfS
   g==;
X-CSE-ConnectionGUID: B2ad9Jy/TTKchsBBBUbmgA==
X-CSE-MsgGUID: 9Sw1n8OhTTiqXHj9bt7Zfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40028699"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="40028699"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 10:38:10 -0700
X-CSE-ConnectionGUID: 0ScAU7a5SkKKlfhN2g4Mhw==
X-CSE-MsgGUID: tlEayYB/TW2mMhXHyVgI/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80247296"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 24 Oct 2024 10:38:09 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t41mh-000WnB-0N;
	Thu, 24 Oct 2024 17:38:07 +0000
Date: Fri, 25 Oct 2024 01:37:08 +0800
From: kernel test robot <lkp@intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: sound/soc/soc-core.o: warning: objtool:
 snd_soc_daifmt_parse_format+0x28a: unreachable instruction
Message-ID: <202410250126.0eXFyl64-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2ee9f594da826bea183ed14f2cc029c719bf4da
commit: fe42754b94a42d08cf9501790afc25c4f6a5f631 cpu: Re-enable CPU mitigations by default for !X86 architectures
date:   6 months ago
config: x86_64-randconfig-r061-20241024 (https://download.01.org/0day-ci/archive/20241025/202410250126.0eXFyl64-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241025/202410250126.0eXFyl64-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410250126.0eXFyl64-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from sound/soc/soc-core.c:36:
   In file included from include/sound/pcm.h:15:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   1 warning generated.
>> sound/soc/soc-core.o: warning: objtool: snd_soc_daifmt_parse_format+0x28a: unreachable instruction
--
   In file included from sound/soc/codecs/max98090.c:9:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   1 warning generated.
>> sound/soc/codecs/max98090.o: warning: objtool: max98090_jack_work+0xa8: can't find switch jump table
--
   In file included from sound/soc/codecs/rt5640.c:16:
   In file included from include/linux/i2c.h:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   1 warning generated.
>> sound/soc/codecs/rt5640.o: warning: objtool: rt5640_probe+0x12c: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

