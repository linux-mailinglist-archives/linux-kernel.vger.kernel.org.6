Return-Path: <linux-kernel+bounces-332153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD82497B618
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 01:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F85D28446E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 23:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1603191F95;
	Tue, 17 Sep 2024 23:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgZFPlT6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A478158DBA;
	Tue, 17 Sep 2024 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726615671; cv=none; b=DTN4Kq6Jm9l/7wZYGqw+LWQCl7AQwl2ZL1l6z4FovAaBSoIyMh+Rnjv55kfirJlP0EXRjlr/u1T0JrgbTy2WoA12l/MgApAA3CJbaQZSf9X4HuUqIn1GE/XleEcMjyWSUfKJxWb4+V7GChxrFIBycRandTnsFfgvQa1V+WQikMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726615671; c=relaxed/simple;
	bh=g/Pmz/qEI8/+jiFosDjqPR6jxKOpIH0jm0dHkxIFKUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjhVfqFgwLlJbZvrXVo14itqDGyE3b+zc6xg8zkBipvK+MZ3V6sB/vz08Y66612IoRW/PEPTAVIg/wh/ZwgWNy7QUQ//IW1Oxx/8VreeekQleSsZ8PKWy3+rLV7I8czbfhq3MxTDupwaKld2oK3fXHKomdcGhtOm7UrNHLNA4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgZFPlT6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726615669; x=1758151669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g/Pmz/qEI8/+jiFosDjqPR6jxKOpIH0jm0dHkxIFKUo=;
  b=JgZFPlT6CWveEHjZsPvLc270RCZmiTKn6BGbBI9K52qwUCfbnRWjtPwa
   xyp5XUNB0pSYTJtTW28nR90SvNi/n+sK4escbhm0zxH/Y4RcuhUC+57Bn
   9xbBesLd6bL8p88/V5zW5VIpZ9uyjPN494KUZEX+ShYp35hy/JgEomFtR
   /d/hb50Q2rFcr6yl4B1Ekh4WIWEbJr9ZmJogopWgXObHKca29sBTMKNH5
   mdCWTxVbNkLlnk3ZwqYPBoEhjh2O0Y5WecTrL1Ikgox192lTKoBlrWSxp
   SUCFbK+mU+gYKwlTIO4J0EN2wv9Wsk171KKu1G0DO8cShhaI+jaCoBqju
   g==;
X-CSE-ConnectionGUID: AEFDbJxqSrukJuXVPcVg6g==
X-CSE-MsgGUID: Kt9jWAqbSiWAmSVsE2xN+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="13564685"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="13564685"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 16:27:49 -0700
X-CSE-ConnectionGUID: g8bjz9r1SHau+a2kJmRXsQ==
X-CSE-MsgGUID: f5WYcql2TvquIJ8/uTGtmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="69836022"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 17 Sep 2024 16:27:47 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqhbl-000BhK-0T;
	Tue, 17 Sep 2024 23:27:45 +0000
Date: Wed, 18 Sep 2024 07:27:43 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: lib/mpi - Extend support for scope-based
 resource management
Message-ID: <202409180725.ZV8DCvII-lkp@intel.com>
References: <bc5ce9ad-acbd-4f3b-91d6-10cf62bf5afc@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc5ce9ad-acbd-4f3b-91d6-10cf62bf5afc@web.de>

Hi Markus,

kernel test robot noticed the following build errors:

[auto build test ERROR on herbert-crypto-2.6/master]
[also build test ERROR on herbert-cryptodev-2.6/master linus/master v6.11 next-20240917]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/crypto-lib-mpi-Extend-support-for-scope-based-resource-management/20240917-173519
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git master
patch link:    https://lore.kernel.org/r/bc5ce9ad-acbd-4f3b-91d6-10cf62bf5afc%40web.de
patch subject: [PATCH] crypto: lib/mpi - Extend support for scope-based resource management
config: i386-buildonly-randconfig-002-20240918 (https://download.01.org/0day-ci/archive/20240918/202409180725.ZV8DCvII-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240918/202409180725.ZV8DCvII-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409180725.ZV8DCvII-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/irqflags.h:17,
                    from arch/x86/include/asm/special_insns.h:10,
                    from arch/x86/include/asm/processor.h:25,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from crypto/dh.c:9:
   include/linux/mpi.h: In function '__free_mpi_free':
>> include/linux/mpi.h:49:48: error: 'T_' undeclared (first use in this function)
      49 | DEFINE_FREE(mpi_free, MPI, if (!IS_ERR_OR_NULL(T_)) mpi_free(T_))
         |                                                ^~
   include/linux/cleanup.h:62:78: note: in definition of macro 'DEFINE_FREE'
      62 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                                                              ^~~~~
   include/linux/mpi.h:49:48: note: each undeclared identifier is reported only once for each function it appears in
      49 | DEFINE_FREE(mpi_free, MPI, if (!IS_ERR_OR_NULL(T_)) mpi_free(T_))
         |                                                ^~
   include/linux/cleanup.h:62:78: note: in definition of macro 'DEFINE_FREE'
      62 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                                                              ^~~~~
>> include/linux/cleanup.h:62:60: warning: unused variable '_T' [-Wunused-variable]
      62 |         static inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                                            ^~
   include/linux/mpi.h:49:1: note: in expansion of macro 'DEFINE_FREE'
      49 | DEFINE_FREE(mpi_free, MPI, if (!IS_ERR_OR_NULL(T_)) mpi_free(T_))
         | ^~~~~~~~~~~


vim +/T_ +49 include/linux/mpi.h

    45	
    46	/*-- mpiutil.c --*/
    47	MPI mpi_alloc(unsigned nlimbs);
    48	void mpi_free(MPI a);
  > 49	DEFINE_FREE(mpi_free, MPI, if (!IS_ERR_OR_NULL(T_)) mpi_free(T_))
    50	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

