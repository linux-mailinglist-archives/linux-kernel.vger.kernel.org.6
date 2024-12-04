Return-Path: <linux-kernel+bounces-430739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4427A9E34E1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097C42815A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790C61AF0DC;
	Wed,  4 Dec 2024 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLXRU+qo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13B1AF0BE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299163; cv=none; b=c6OtLoiqsgJfX/7LTOPe2UEAXH2Dm0wKZEWnZanaMakEson53VIJnIrSsfFjBjKSv19J02h6aMW2K45GX5JKoNNvZb1iceZnDqvWZoTbJIQ5oiuckZr78E/q3zlwfJ0MJVKfKmg11rSlqfQQPAhez9iY2hPTGLegBAvxD02JaHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299163; c=relaxed/simple;
	bh=XIEHGCqreTw+ORKCtuR9e4T+BF8y6+n+wQMsizFGr+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trceYsWdTungyFX6TrSZsFqa8q7HRt8VIQUi59KOVajYFMG8y6HOAkSzdBLuyv1qGOo57diXpeU3FoAwaXJcIUzT0kFpUggwNl51VZ00Lc8gXz0sAB7smmn/rn9AHUXFxniwV9q79M0IZbaLIPb/R1nYF7wVZYSgSpmJZR9DbLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLXRU+qo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733299162; x=1764835162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XIEHGCqreTw+ORKCtuR9e4T+BF8y6+n+wQMsizFGr+4=;
  b=mLXRU+qogJRZOWYAUDef+c3DlYOCc1oXGEXJek5KGXAZog9r41hm2Hmu
   85pV+AOfrsfQaJSB87mjGg/H1x2ovxufze8JTRe9By8C/ObTXOlj3mzZE
   n6QiGoNiZDE0vuBoOZZm3+q90InngCOBqKxBVBNKLQkwa/hxEzv9IMNVP
   gJuIzU0vzpw2SNj9MWEePzgmez87DAczMvz6U8hkeJ+WPOsuMyUoIO7M0
   6RV5omARUHQ2GomG0HG9tzjmi1LTenoAZe6Bq7mDssUnGFKyzm1OC1mwh
   1dgsVdc6MEk1KEkuqtC48WoiIGq2aak3Y1KAo2cJ4qGNOqdJFMz9osN4t
   g==;
X-CSE-ConnectionGUID: dHkJhE2rQL2XjKA4HY8gCw==
X-CSE-MsgGUID: NBKRPRXFQNO6BHZzWuk5Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37489233"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="37489233"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 23:59:22 -0800
X-CSE-ConnectionGUID: mRxel38nTZipVAaFzuEDaw==
X-CSE-MsgGUID: cOuTFytwSK2tZ5iZbTirqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98707724"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 23:59:20 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIkHy-0002jH-17;
	Wed, 04 Dec 2024 07:59:15 +0000
Date: Wed, 4 Dec 2024 15:58:05 +0800
From: kernel test robot <lkp@intel.com>
To: Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, x86@kernel.org,
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2] x86/nmi: Add an emergency handler in nmi_desc & use
 it in nmi_shootdown_cpus()
Message-ID: <202412041510.eJUQbvy7-lkp@intel.com>
References: <20241203150732.182065-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203150732.182065-1-longman@redhat.com>

Hi Waiman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/master]
[also build test WARNING on tip/x86/core tip/auto-latest bp/for-next linus/master v6.13-rc1 next-20241203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/x86-nmi-Add-an-emergency-handler-in-nmi_desc-use-it-in-nmi_shootdown_cpus/20241204-105505
base:   tip/master
patch link:    https://lore.kernel.org/r/20241203150732.182065-1-longman%40redhat.com
patch subject: [PATCH v2] x86/nmi: Add an emergency handler in nmi_desc & use it in nmi_shootdown_cpus()
config: i386-buildonly-randconfig-001 (https://download.01.org/0day-ci/archive/20241204/202412041510.eJUQbvy7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041510.eJUQbvy7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041510.eJUQbvy7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/nmi.c:250: warning: Function parameter or struct member 'type' not described in 'set_emergency_nmi_handler'
>> arch/x86/kernel/nmi.c:250: warning: Function parameter or struct member 'handler' not described in 'set_emergency_nmi_handler'


vim +250 arch/x86/kernel/nmi.c

   239	
   240	/**
   241	 * set_emergency_nmi_handler - Set emergency handler
   242	 * @handler - the emergency handler to be stored
   243	 * Return: 0 if success, -EEXIST if a handler had been stored
   244	 *
   245	 * Atomically set an emergency NMI handler which, if set, will be invoked
   246	 * before all the other handlers in the linked list. If a NULL handler is
   247	 * passed in, it will clear it.
   248	 */
   249	int set_emergency_nmi_handler(unsigned int type, nmi_handler_t handler)
 > 250	{
   251		struct nmi_desc *desc = nmi_to_desc(type);
   252		nmi_handler_t orig = NULL;
   253	
   254		if (!handler) {
   255			orig = READ_ONCE(desc->emerg_handler);
   256			WARN_ON_ONCE(!orig);
   257		}
   258	
   259		if (try_cmpxchg(&desc->emerg_handler, &orig, handler))
   260			return 0;
   261		if (WARN_ON_ONCE(orig == handler))
   262			return 0;
   263		WARN_ONCE(1, "%s: failed to set emergency NMI handler!\n", __func__);
   264		return -EEXIST;
   265	}
   266	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

