Return-Path: <linux-kernel+bounces-260504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFE793AA50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 03:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7B41C22DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 01:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E4D5672;
	Wed, 24 Jul 2024 01:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cok7jgr+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960FE4C84
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721783371; cv=none; b=ilZWblsTxuEdSgaoGIctFfXfa7k6kDCaupfAeS279RIhub2fxypqnsiUATzUM7pRt3GBHBI6KymVOLglD2SPfeuvMKOhPjBmeMibqmslmJuV9r7phzZENo0vBiwglROO0N7TS0IVAJyOfKTCWFEb9jsGdSejj2OU5N3iUM7b3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721783371; c=relaxed/simple;
	bh=Q42/lQRQaj1E1lRN0xProqMMUQqxecd3flW8x1xa8aA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fpmIn/l6C2HI7y0B06d2SFO512kwNl0ssWAHeQQx/8nZ0FTxiHtodG2zHG1SpG+b3+A4FYrUvXsrc/buTIAv2ycwJnTzyKzEzZLIBQrFSFgrZ2befhHxcBtHszQUFl16f4+gL0gYaoTyT87A2SHt/VnK5XLVI734Lmiv2OuO3JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cok7jgr+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721783369; x=1753319369;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q42/lQRQaj1E1lRN0xProqMMUQqxecd3flW8x1xa8aA=;
  b=Cok7jgr+R+s30i66qtxDFQOtq/z3S0dKMNhSaZNMfZVB8ur7JoRZL343
   sD+cNZlRF9sVCF7W71XJnNcVCC5lY5C+0IkJoLGRqWBS9hrfWxfNVbMen
   YrPkZwia8yTKH7Wv9IQXbdKtNiawCY1gT/7Vqv0mDb11/fPEWpv+R9psg
   lE7KpY8xiU9glj/dN2qzHSpQ6V7FyldDQ0cfEPZXSZNl691VeVFY3UkxH
   jUNiBF8mi6yaVaMmlICI1+ktg4mD5ve0rWFsTN8OW2ofAFRzQm/Z4lkBw
   3UOXljcj27a68Go0HcK/kcm4M6bT1YkOlLflAjsr/ef2mnMKpgFBxBQsX
   w==;
X-CSE-ConnectionGUID: +Kr6y0FtRymDePhuXmJy+A==
X-CSE-MsgGUID: iBC/yejxQBWEvBm2EhWRLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="22340128"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="22340128"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 18:09:00 -0700
X-CSE-ConnectionGUID: kxtFO33xSHuHInDtFjiH/Q==
X-CSE-MsgGUID: HJy2zPGvQcuV8J0LZxRUXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="57236836"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 23 Jul 2024 18:08:58 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWQUy-000mWU-0Y;
	Wed, 24 Jul 2024 01:08:56 +0000
Date: Wed, 24 Jul 2024 09:08:32 +0800
From: kernel test robot <lkp@intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: include/soc/fsl/qman.h:383:4: warning: field context_a within
 'struct qm_fqd' is less aligned than 'union (unnamed union at
 include/soc/fsl/qman.h:365:2)' and is usually due to 'struct qm_fqd' being
 packed, which can lead to unaligned accesses
Message-ID: <202407240923.IiSHts5M-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5ad7ff8738b8bd238ca899df08badb1f61bcc39e
commit: 782fe08e9861d00ce8aca370453dd9ceb9a23d50 soc: fsl: qbman: FSL_DPAA depends on COMPILE_TEST
date:   9 days ago
config: arm-randconfig-r123-20240723 (https://download.01.org/0day-ci/archive/20240724/202407240923.IiSHts5M-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad154281230d83ee551e12d5be48bb956ef47ed3)
reproduce: (https://download.01.org/0day-ci/archive/20240724/202407240923.IiSHts5M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407240923.IiSHts5M-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/soc/fsl/qbman/qman_ccsr.c:31:
   In file included from drivers/soc/fsl/qbman/qman_priv.h:31:
   In file included from drivers/soc/fsl/qbman/dpaa_sys.h:46:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2258:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/soc/fsl/qbman/qman_ccsr.c:31:
   In file included from drivers/soc/fsl/qbman/qman_priv.h:33:
>> include/soc/fsl/qman.h:383:4: warning: field context_a within 'struct qm_fqd' is less aligned than 'union (unnamed union at include/soc/fsl/qman.h:365:2)' and is usually due to 'struct qm_fqd' being packed, which can lead to unaligned accesses [-Wunaligned-access]
     383 |         } context_a;
         |           ^
   2 warnings generated.


vim +383 include/soc/fsl/qman.h

c535e923bb97a4 Claudiu Manoil 2016-09-22  346  
c535e923bb97a4 Claudiu Manoil 2016-09-22  347  struct qm_fqd {
c535e923bb97a4 Claudiu Manoil 2016-09-22  348  	/* _res[6-7], orprws[3-5], oa[2], olws[0-1] */
c535e923bb97a4 Claudiu Manoil 2016-09-22  349  	u8 orpc;
c535e923bb97a4 Claudiu Manoil 2016-09-22  350  	u8 cgid;
c535e923bb97a4 Claudiu Manoil 2016-09-22  351  	__be16 fq_ctrl;	/* See QM_FQCTRL_<...> */
c535e923bb97a4 Claudiu Manoil 2016-09-22  352  	__be16 dest_wq;	/* channel[3-15], wq[0-2] */
c535e923bb97a4 Claudiu Manoil 2016-09-22  353  	__be16 ics_cred; /* 15-bit */
c535e923bb97a4 Claudiu Manoil 2016-09-22  354  	/*
c535e923bb97a4 Claudiu Manoil 2016-09-22  355  	 * For "Initialize Frame Queue" commands, the write-enable mask
c535e923bb97a4 Claudiu Manoil 2016-09-22  356  	 * determines whether 'td' or 'oac_init' is observed. For query
c535e923bb97a4 Claudiu Manoil 2016-09-22  357  	 * commands, this field is always 'td', and 'oac_query' (below) reflects
c535e923bb97a4 Claudiu Manoil 2016-09-22  358  	 * the Overhead ACcounting values.
c535e923bb97a4 Claudiu Manoil 2016-09-22  359  	 */
c535e923bb97a4 Claudiu Manoil 2016-09-22  360  	union {
c535e923bb97a4 Claudiu Manoil 2016-09-22  361  		__be16 td; /* "Taildrop": _res[13-15], mant[5-12], exp[0-4] */
c535e923bb97a4 Claudiu Manoil 2016-09-22  362  		struct qm_fqd_oac oac_init;
c535e923bb97a4 Claudiu Manoil 2016-09-22  363  	};
c535e923bb97a4 Claudiu Manoil 2016-09-22  364  	__be32 context_b;
c535e923bb97a4 Claudiu Manoil 2016-09-22  365  	union {
c535e923bb97a4 Claudiu Manoil 2016-09-22  366  		/* Treat it as 64-bit opaque */
c535e923bb97a4 Claudiu Manoil 2016-09-22  367  		__be64 opaque;
c535e923bb97a4 Claudiu Manoil 2016-09-22  368  		struct {
c535e923bb97a4 Claudiu Manoil 2016-09-22  369  			__be32 hi;
c535e923bb97a4 Claudiu Manoil 2016-09-22  370  			__be32 lo;
c535e923bb97a4 Claudiu Manoil 2016-09-22  371  		};
c535e923bb97a4 Claudiu Manoil 2016-09-22  372  		/* Treat it as s/w portal stashing config */
c535e923bb97a4 Claudiu Manoil 2016-09-22  373  		/* see "FQD Context_A field used for [...]" */
c535e923bb97a4 Claudiu Manoil 2016-09-22  374  		struct {
c535e923bb97a4 Claudiu Manoil 2016-09-22  375  			struct qm_fqd_stashing stashing;
c535e923bb97a4 Claudiu Manoil 2016-09-22  376  			/*
c535e923bb97a4 Claudiu Manoil 2016-09-22  377  			 * 48-bit address of FQ context to
c535e923bb97a4 Claudiu Manoil 2016-09-22  378  			 * stash, must be cacheline-aligned
c535e923bb97a4 Claudiu Manoil 2016-09-22  379  			 */
c535e923bb97a4 Claudiu Manoil 2016-09-22  380  			__be16 context_hi;
c535e923bb97a4 Claudiu Manoil 2016-09-22  381  			__be32 context_lo;
c535e923bb97a4 Claudiu Manoil 2016-09-22  382  		} __packed;
c535e923bb97a4 Claudiu Manoil 2016-09-22 @383  	} context_a;
c535e923bb97a4 Claudiu Manoil 2016-09-22  384  	struct qm_fqd_oac oac_query;
c535e923bb97a4 Claudiu Manoil 2016-09-22  385  } __packed;
c535e923bb97a4 Claudiu Manoil 2016-09-22  386  

:::::: The code at line 383 was first introduced by commit
:::::: c535e923bb97a4b361e89a6383693482057f8b0c soc/fsl: Introduce DPAA 1.x QMan device driver

:::::: TO: Claudiu Manoil <claudiu.manoil@nxp.com>
:::::: CC: Scott Wood <oss@buserror.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

