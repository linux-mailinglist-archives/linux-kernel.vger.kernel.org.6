Return-Path: <linux-kernel+bounces-194639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA58D3F56
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E988528A0E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6687F1C6883;
	Wed, 29 May 2024 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLZLoDP1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7113B290
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717013067; cv=none; b=XS5ppo3leqN3QuE3RkTyOATUM2zhbnzOfTPKxDqmi08RenM11o/0NdsTxxS9PqF5Rcu8omg7jfdQdqSAU00LwWJsqcEnC4tvWkZMvMciIgNfN3kyip1xHLlx23ms3sT4P9oUc+zPXgQr5CopsoGrDlNVZImOp0arg7sOrUhqVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717013067; c=relaxed/simple;
	bh=EWUWJngpPUFGlRBMALS5nfZudOsfs/z+V2AeIjEwW/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ldg/LbPrVBkCA1LM0tbrixhf8X0C/dgePv8rmwWiLMMnVjV4xcx/v4PdgAUC+fG7XsAFsnU7tE08iF2C85atp8843BsWzxLiMpfxZo05jzDqPIBhATiX10eoV9thoMDfsQOIXG38wxQhs8z7bKqAEXEJmbMm90B3DpCmHqDr6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLZLoDP1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717013065; x=1748549065;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EWUWJngpPUFGlRBMALS5nfZudOsfs/z+V2AeIjEwW/8=;
  b=aLZLoDP1tzkLeP4+on+gCszYjP/M8wr2UsSoXgOqsNF4Fx7kL5AFZEfK
   ncIHPkGMydmWDJP3dSINRagSyxpaFurLiGZOBdzdeRI3XSOMsZT17gdIA
   ZoWiGp+kI/uBRWa9thNLAmY4XulBIe2H1TiHx2jnzOL0EyG8kYbAXU7xP
   oNcu7cYzT09izBsggyeZci6G1sHblhdYjadEYJ9dR3ZlKg4LTjCqJS1Eb
   EV6mViZIVnW/lzb27FCPPIfKlY9x0vFnlleqT4LD7pjt7OXKooNx3MYyp
   54GBxFxkosgDcQbkFgjyXwy/WBaENFiZVSiR8nTneLpor0vYu3PBhDt2f
   A==;
X-CSE-ConnectionGUID: tzSOMFkKRAikGRQznysfdg==
X-CSE-MsgGUID: pje/noaES8CsxQSBx0VN9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13572261"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13572261"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 13:04:25 -0700
X-CSE-ConnectionGUID: fqct1rU/R12QtAkODSN13w==
X-CSE-MsgGUID: UZgpRGBDT0K/6mmWUEe5Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35504775"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 29 May 2024 13:04:22 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCPX0-000E9H-3B;
	Wed, 29 May 2024 20:04:19 +0000
Date: Thu, 30 May 2024 04:03:55 +0800
From: kernel test robot <lkp@intel.com>
To: Youling Tang <youling.tang@linux.dev>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, x86@kernel.org,
	linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 1/2] x86: Remove the prefetch() specific implementation
 on x86_64
Message-ID: <202405300328.eZmSYZrP-lkp@intel.com>
References: <20240529032059.899347-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529032059.899347-1-youling.tang@linux.dev>

Hi Youling,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/master]
[also build test ERROR on linus/master v6.10-rc1 next-20240529]
[cannot apply to tip/auto-latest tip/x86/core bp/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/prefetch-Add-ARCH_HAS_PREFETCH-definition-when-the-architecture-is-not-defined/20240529-112345
base:   tip/master
patch link:    https://lore.kernel.org/r/20240529032059.899347-1-youling.tang%40linux.dev
patch subject: [PATCH 1/2] x86: Remove the prefetch() specific implementation on x86_64
config: x86_64-buildonly-randconfig-006-20240530 (https://download.01.org/0day-ci/archive/20240530/202405300328.eZmSYZrP-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240530/202405300328.eZmSYZrP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405300328.eZmSYZrP-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/soc/fsl/dpio/dpio-service.c: In function 'dpaa2_io_store_next':
>> drivers/soc/fsl/dpio/dpio-service.c:745:17: error: implicit declaration of function 'prefetch'; did you mean 'prefetchw'? [-Werror=implicit-function-declaration]
     745 |                 prefetch(&s->vaddr[s->idx]);
         |                 ^~~~~~~~
         |                 prefetchw
   cc1: some warnings being treated as errors
--
   drivers/soc/fsl/dpio/qbman-portal.c: In function 'qbman_swp_dqrr_next_direct':
>> drivers/soc/fsl/dpio/qbman-portal.c:1213:17: error: implicit declaration of function 'prefetch'; did you mean 'prefetchw'? [-Werror=implicit-function-declaration]
    1213 |                 prefetch(qbman_get_cmd(s,
         |                 ^~~~~~~~
         |                 prefetchw
   cc1: some warnings being treated as errors


vim +745 drivers/soc/fsl/dpio/dpio-service.c

780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  703  
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  704  /**
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  705   * dpaa2_io_store_next() - Determine when the next dequeue result is available.
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  706   * @s: the dpaa2_io_store object.
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  707   * @is_last: indicate whether this is the last frame in the pull command.
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  708   *
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  709   * When an object driver performs dequeues to a dpaa2_io_store, this function
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  710   * can be used to determine when the next frame result is available. Once
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  711   * this function returns non-NULL, a subsequent call to it will try to find
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  712   * the next dequeue result.
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  713   *
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  714   * Note that if a pull-dequeue has a NULL result because the target FQ/channel
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  715   * was empty, then this function will also return NULL (rather than expecting
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  716   * the caller to always check for this. As such, "is_last" can be used to
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  717   * differentiate between "end-of-empty-dequeue" and "still-waiting".
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  718   *
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  719   * Return dequeue result for a valid dequeue result, or NULL for empty dequeue.
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  720   */
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  721  struct dpaa2_dq *dpaa2_io_store_next(struct dpaa2_io_store *s, int *is_last)
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  722  {
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  723  	int match;
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  724  	struct dpaa2_dq *ret = &s->vaddr[s->idx];
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  725  
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  726  	match = qbman_result_has_new_result(s->swp, ret);
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  727  	if (!match) {
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  728  		*is_last = 0;
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  729  		return NULL;
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  730  	}
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  731  
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  732  	s->idx++;
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  733  
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  734  	if (dpaa2_dq_is_pull_complete(ret)) {
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  735  		*is_last = 1;
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  736  		s->idx = 0;
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  737  		/*
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  738  		 * If we get an empty dequeue result to terminate a zero-results
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  739  		 * vdqcr, return NULL to the caller rather than expecting him to
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  740  		 * check non-NULL results every time.
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  741  		 */
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  742  		if (!(dpaa2_dq_flags(ret) & DPAA2_DQ_STAT_VALIDFRAME))
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  743  			ret = NULL;
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  744  	} else {
f1e250bf365962 drivers/soc/fsl/dpio/dpio-service.c            Ioana Ciocoi Radulescu 2018-12-14 @745  		prefetch(&s->vaddr[s->idx]);
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  746  		*is_last = 0;
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  747  	}
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  748  
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  749  	return ret;
780b626323d721 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Roy Pledge             2017-03-13  750  }
53639c64c686f0 drivers/staging/fsl-mc/bus/dpio/dpio-service.c Laurentiu Tudor        2017-11-17  751  EXPORT_SYMBOL_GPL(dpaa2_io_store_next);
e80081c34b0358 drivers/soc/fsl/dpio/dpio-service.c            Roy Pledge             2018-12-18  752  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

