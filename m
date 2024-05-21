Return-Path: <linux-kernel+bounces-184346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910DA8CA5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C15B280D85
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 01:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFD68F47;
	Tue, 21 May 2024 01:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e+grLTuk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC17D51E;
	Tue, 21 May 2024 01:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716254744; cv=none; b=Nkdmummhpz2aNN0lsHoR9WgcgwA37EbetbOC+7uLf1H7jt4zPwJwNiVSJt5t++/NxN3u7addRDVwxyoKOMHiFROjMqPhyJqUE8OBNcV+M4eNr9eciBY3B4bTlOlkgHyCK+MWs/vBBlKCauwfHL5Fr8wKJy2Dfvb+B8tzAlm2DHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716254744; c=relaxed/simple;
	bh=80zdN7jBfAaGCbw8JdOy2vh14EoH8nth0rDhlL0UdKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWCU6ZRJLPTDlW+WyDbPM+MR72TcFoImGA7fXxOqw6T11NoyuWuZdhGMKHA2NtjISImheESveZmATpDLlim8lDrnk0noD2t9UP2lYK+pb34DiQEId+WcKVYH/UL6Yr9gS2JqAsnM88aRv5ObZEiIWUCLjH7MgXtFq71FEJhZC30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e+grLTuk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716254742; x=1747790742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=80zdN7jBfAaGCbw8JdOy2vh14EoH8nth0rDhlL0UdKs=;
  b=e+grLTukoWIul5KOz0p6s62Cx+kjWtI6Lw+RjrmNaKMEjgWVKqGgGGab
   zmQP2K4RmsWchphRUxt9f6zQoQs8uOsXMAWXgnOLcoJjApAl/FrORM82G
   d9CORCYmrXpVlwjauRyOPJ8N8syGhIZg8LhrsU1vh7AxtrcemwLOy1gYf
   L8bPoliSJU6yRpN0Tycit2aBuhXFTqL4q+hURmdBYr6yse/OPtVY/v/ym
   OASbEu/COzNJXdYsvMYN3D+Rb89Wt0aZPQUw7dlsrJx+74ptQYFsgacw8
   kg4RYTeIQ3HTtz7AMatAHDbm94LoIKwsfAh3cEPWNhL06XovMKbKCyxqm
   g==;
X-CSE-ConnectionGUID: UC3UNUR7SYe6tMXxST1BdQ==
X-CSE-MsgGUID: MBVCDa2sRw6fx12ZTlkpbw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12261390"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12261390"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 18:25:42 -0700
X-CSE-ConnectionGUID: x843YUg/RJO56KjYuaUP1Q==
X-CSE-MsgGUID: pH5vquoqTUCG9M4aqGLW4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="37114089"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 20 May 2024 18:25:38 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9EFz-0005MM-3C;
	Tue, 21 May 2024 01:25:35 +0000
Date: Tue, 21 May 2024 09:25:01 +0800
From: kernel test robot <lkp@intel.com>
To: andrey.konovalov@linux.dev, Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Tejun Heo <tj@kernel.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcov, usb: disable interrupts in
 kcov_remote_start_usb_softirq
Message-ID: <202405210908.bv3U0RAQ-lkp@intel.com>
References: <20240520205856.162910-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520205856.162910-1-andrey.konovalov@linux.dev>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus westeri-thunderbolt/next linus/master v6.9 next-20240520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/andrey-konovalov-linux-dev/kcov-usb-disable-interrupts-in-kcov_remote_start_usb_softirq/20240521-050030
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240520205856.162910-1-andrey.konovalov%40linux.dev
patch subject: [PATCH] kcov, usb: disable interrupts in kcov_remote_start_usb_softirq
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240521/202405210908.bv3U0RAQ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240521/202405210908.bv3U0RAQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405210908.bv3U0RAQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/fork.c:92:
   include/linux/kcov.h: In function 'kcov_remote_start_usb_softirq':
>> include/linux/kcov.h:132:1: warning: no return statement in function returning non-void [-Wreturn-type]
     132 | static inline unsigned long kcov_remote_start_usb_softirq(u64 id) {}
         | ^~~~~~


vim +132 include/linux/kcov.h

   119	
   120	static inline void kcov_task_init(struct task_struct *t) {}
   121	static inline void kcov_task_exit(struct task_struct *t) {}
   122	static inline void kcov_prepare_switch(struct task_struct *t) {}
   123	static inline void kcov_finish_switch(struct task_struct *t) {}
   124	static inline void kcov_remote_start(u64 handle) {}
   125	static inline void kcov_remote_stop(void) {}
   126	static inline u64 kcov_common_handle(void)
   127	{
   128		return 0;
   129	}
   130	static inline void kcov_remote_start_common(u64 id) {}
   131	static inline void kcov_remote_start_usb(u64 id) {}
 > 132	static inline unsigned long kcov_remote_start_usb_softirq(u64 id) {}
   133	static inline void kcov_remote_stop_softirq(unsigned long flags) {}
   134	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

