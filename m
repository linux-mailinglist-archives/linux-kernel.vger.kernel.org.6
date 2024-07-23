Return-Path: <linux-kernel+bounces-259572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B6E9398A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7162E1C219B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 03:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3294213B5B4;
	Tue, 23 Jul 2024 03:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNTDBx/u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742DB134407
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 03:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721705417; cv=none; b=gAjvgaTGM0ocMNDxF69luuBQN0zGSjH3gQBfPC7LnEKrSQIeJcPmkngWnKNGKVi8EIrwWYfg3NuT5nvylYDtzBGoXlVOs9di4kpIZNt4cuTaCBmZbfw7CacYFdzPVzCNO0dfHqjncYaZGlGERtsQGW0kU8JuBTKaYy7l1SM6LLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721705417; c=relaxed/simple;
	bh=nLnwoI7YeS9ALlvLqh0epIkBFGQRYQaAvU2pGkV1qB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVSCd9hiyBIeoDKiB3DpO7t6VvPehtGYGgUI1XnZStaSP7FAysT7wgPLqeNoUmx/x5xGH3+vGp4LZiDyOtixEzwYvvc/YkyiZouZz5Y0Ypxh8XYMSd1hf0wf6sEuwF4W5vpBcvkFRgahCZa+H0bfCsYEcKjPuv0VfK6Xnv2ALnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNTDBx/u; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721705415; x=1753241415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nLnwoI7YeS9ALlvLqh0epIkBFGQRYQaAvU2pGkV1qB0=;
  b=VNTDBx/uNXwK0gef8+S35SeKo30ndEOFYCQCjYRYPVh/aABZVj1hv1oo
   KMWfMxvYXBIihPTK2oYkRpo/eET2v3/ovUrOT9uiX8niEuFAuRajqTgcD
   KXiOL7nxx4bPBVLIZh/9TG6n3IyCXQv8UOco+M2DkZclevJZStCsRftRg
   5VyPi68X61BGd3HRykhkXis55XO7kjSPKvKyotvakEdoMRwDtjv/sjjQq
   8x7vbJOZ7fDGBigHz9LPLTIGdAfa3MHlmuVvzWW/4mQq5Miw9w6hZ9YUH
   IQy9HgE2wpl49Z4ego9cTkpVO+ykAu2S2RdzhlpF2UMyixGa++8qVPjeQ
   A==;
X-CSE-ConnectionGUID: Pgu9V2MGRxSVXAqjwK6Uyw==
X-CSE-MsgGUID: SKWhGpnLTmWOHk02M4xvjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19433689"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="19433689"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 20:30:15 -0700
X-CSE-ConnectionGUID: nSvWO+nXRZCdt6ilpccYyQ==
X-CSE-MsgGUID: g8CC6jAvQ9Gjqc+Oi9Un+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="83108108"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 22 Jul 2024 20:30:12 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sW6E6-000lbo-1g;
	Tue, 23 Jul 2024 03:30:10 +0000
Date: Tue, 23 Jul 2024 11:29:14 +0800
From: kernel test robot <lkp@intel.com>
To: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 07/19] printk: Add helpers for flush type logic
Message-ID: <202407231135.jtSVw3hi-lkp@intel.com>
References: <20240722171939.3349410-8-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722171939.3349410-8-john.ogness@linutronix.de>

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on b18703ea7157f62f02eb0ceb11f6fa0138e90adc]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ogness/printk-nbcon-Clarify-nbcon_get_default_prio-context/20240723-015154
base:   b18703ea7157f62f02eb0ceb11f6fa0138e90adc
patch link:    https://lore.kernel.org/r/20240722171939.3349410-8-john.ogness%40linutronix.de
patch subject: [PATCH printk v3 07/19] printk: Add helpers for flush type logic
config: arm-randconfig-004-20240723 (https://download.01.org/0day-ci/archive/20240723/202407231135.jtSVw3hi-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad154281230d83ee551e12d5be48bb956ef47ed3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240723/202407231135.jtSVw3hi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407231135.jtSVw3hi-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/printk/printk.c:23:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from kernel/printk/printk.c:61:
>> kernel/printk/internal.h:188:26: error: call to undeclared function 'is_printk_deferred'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     188 |                         if (prefer_offload || is_printk_deferred())
         |                                               ^
   kernel/printk/internal.h:188:26: note: did you mean '_printk_deferred'?
   include/linux/printk.h:218:5: note: '_printk_deferred' declared here
     218 | int _printk_deferred(const char *s, ...)
         |     ^
   In file included from kernel/printk/printk.c:61:
   kernel/printk/internal.h:237:8: error: call to undeclared function 'is_printk_deferred'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     237 |                         if (is_printk_deferred())
         |                             ^
   1 warning and 2 errors generated.


vim +/is_printk_deferred +188 kernel/printk/internal.h

   172	
   173	/*
   174	 * Decide while console flushing methods are to be used. Used
   175	 * for all flushing except when flushing from emergency state.
   176	 *
   177	 * Set @prefer_offload to true if the context is only interested in
   178	 * offloading. Then offloading types will be set instead of direct,
   179	 * if appropriate.
   180	 */
   181	static inline void printk_get_console_flush_type(struct console_flush_type *ft, bool prefer_offload)
   182	{
   183		memset(ft, 0, sizeof(*ft));
   184	
   185		switch (nbcon_get_default_prio()) {
   186		case NBCON_PRIO_NORMAL:
   187			if (have_legacy_console || have_boot_console) {
 > 188				if (prefer_offload || is_printk_deferred())
   189					ft->legacy_offload = true;
   190				else
   191					ft->legacy_direct = true;
   192			}
   193	
   194			if (have_nbcon_console && !have_boot_console)
   195				ft->nbcon_atomic = true;
   196			break;
   197	
   198		case NBCON_PRIO_EMERGENCY:
   199			/*
   200			 * Skip. The consoles will be flushed when exiting emergency
   201			 * state. See printk_get_emergency_console_flush_type().
   202			 */
   203			break;
   204	
   205		case NBCON_PRIO_PANIC:
   206			if (have_nbcon_console && !have_boot_console)
   207				ft->nbcon_atomic = true;
   208	
   209			/*
   210			 * In panic, if nbcon atomic printing occurs, the legacy
   211			 * consoles must remain silent until explicitly allowed.
   212			 */
   213			if (legacy_allow_panic_sync || !ft->nbcon_atomic)
   214				ft->legacy_direct = true;
   215			break;
   216	
   217		default:
   218			WARN_ON_ONCE(1);
   219			break;
   220		}
   221	}
   222	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

