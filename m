Return-Path: <linux-kernel+bounces-425229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711999DBF18
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3ABCB21A93
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06618155741;
	Fri, 29 Nov 2024 04:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cesLQixy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D915383A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732855401; cv=none; b=fVzTvOZfSq3DDvEY3Vxpm2vD3ljUu81RNjqcWEuBkrGj52hmtriShstnzn5nAKGFCoj9dVkDOk6qHbCwp/xd4R4BG/j2BEV0E7H4lNGlRSlrzinzHWGmLMqVt4/A/3gjOrewpxEmQ0YDeTL3FZlqzTE1vAxx/VxcPWkdOBToLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732855401; c=relaxed/simple;
	bh=9j9UtBCv2PeFtRp7xh7w5s2/nPgIOCo2sIEPHBxiREU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwEVOHnmq4tC95lYTAfWTnvw5V31TOu71DWI9ZVGr2K3TwpRKLH//Zxo1GUFF/3/9E7+GKusouAqe38eZbmCpSq2UAclNLndNSKr1KDez8nfCEQKPC6nMAqkUyxoSRFQTQeCV6BfG/1sOtKdVH3Ywl2zCh+ZnDPEpxUn0BqPtH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cesLQixy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732855399; x=1764391399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9j9UtBCv2PeFtRp7xh7w5s2/nPgIOCo2sIEPHBxiREU=;
  b=cesLQixyYLPogzNGXFVluPY4nb5I9AI94GFINL9ULWZnpvCrrZ6p4JZh
   qlvncvv9dEQz8yfhfvDXuQj9Ay7cz1F/m6iUGLfrsK1HUxn+h18ky3Xu6
   O49Ofg2Y711QBmpNCSWGjlCYjGr3JbMzVKDAjQRt6rn1Ivd2UGRfXOEHq
   JaPmVodAsiXT8oDrJd8nBxaTtLSRJInKWXU8CVjFdG5+w8Mr6AsjhEn1j
   Fh/0K1OLrEq2EyaJtPmz8xcASqt+fSt2arWTh4g9auwlZigunw02DEiPy
   lcYgSPe62Zah/prxuw65nT6CMikZGLyNdnJDWoygvwoDgovEE18shMpW4
   Q==;
X-CSE-ConnectionGUID: bkwiXJ0WTT+biBo9Np7DJg==
X-CSE-MsgGUID: 28OwXna6RqKij99DYHQP7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="44460424"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="44460424"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 20:43:18 -0800
X-CSE-ConnectionGUID: Jp79vHlZQie9htAmyJEFWA==
X-CSE-MsgGUID: L0PTf+eMTSqbkmvDig1DjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="92710199"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 28 Nov 2024 20:43:11 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGsqT-000ALf-0C;
	Fri, 29 Nov 2024 04:43:09 +0000
Date: Fri, 29 Nov 2024 12:42:13 +0800
From: kernel test robot <lkp@intel.com>
To: Eliav Farber <farbere@amazon.com>, linux@armlinux.org.uk,
	catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
	maddy@linux.ibm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, tglx@linutronix.de, ebiederm@xmission.com,
	akpm@linux-foundation.org, bhe@redhat.com, hbathini@linux.ibm.com,
	sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
	songshuaishuai@tinylab.org, takakura@valinux.co.jp,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	kexec@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, jonnyc@amazon.com
Subject: Re: [PATCH v3 2/2] kexec: Prevent redundant IRQ masking by checking
 state before shutdown
Message-ID: <202411291251.RwA1dKZL-lkp@intel.com>
References: <20241128201027.10396-3-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128201027.10396-3-farbere@amazon.com>

Hi Eliav,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes tip/irq/core arm64/for-next/core linus/master v6.12 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eliav-Farber/kexec-Consolidate-machine_kexec_mask_interrupts-implementation/20241129-041259
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20241128201027.10396-3-farbere%40amazon.com
patch subject: [PATCH v3 2/2] kexec: Prevent redundant IRQ masking by checking state before shutdown
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20241129/202411291251.RwA1dKZL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411291251.RwA1dKZL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411291251.RwA1dKZL-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/kexec_core.c: In function 'machine_kexec_mask_interrupts':
   kernel/kexec_core.c:1085:24: error: implicit declaration of function 'irq_desc_get_chip' [-Werror=implicit-function-declaration]
    1085 |                 chip = irq_desc_get_chip(desc);
         |                        ^~~~~~~~~~~~~~~~~
   kernel/kexec_core.c:1085:22: warning: assignment to 'struct irq_chip *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1085 |                 chip = irq_desc_get_chip(desc);
         |                      ^
>> kernel/kexec_core.c:1086:31: error: implicit declaration of function 'irqd_is_started' [-Werror=implicit-function-declaration]
    1086 |                 if (!chip || !irqd_is_started(&desc->irq_data))
         |                               ^~~~~~~~~~~~~~~
   kernel/kexec_core.c:1086:52: error: invalid use of undefined type 'struct irq_desc'
    1086 |                 if (!chip || !irqd_is_started(&desc->irq_data))
         |                                                    ^~
   kernel/kexec_core.c:1097:38: error: invalid use of undefined type 'struct irq_chip'
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                      ^~
   kernel/kexec_core.c:1097:51: error: implicit declaration of function 'irqd_irq_inprogress' [-Werror=implicit-function-declaration]
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                                   ^~~~~~~~~~~~~~~~~~~
   kernel/kexec_core.c:1097:76: error: invalid use of undefined type 'struct irq_desc'
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                                                            ^~
   kernel/kexec_core.c:1098:29: error: invalid use of undefined type 'struct irq_chip'
    1098 |                         chip->irq_eoi(&desc->irq_data);
         |                             ^~
   kernel/kexec_core.c:1098:44: error: invalid use of undefined type 'struct irq_desc'
    1098 |                         chip->irq_eoi(&desc->irq_data);
         |                                            ^~
>> kernel/kexec_core.c:1100:17: error: implicit declaration of function 'irq_shutdown'; did you mean 'timer_shutdown'? [-Werror=implicit-function-declaration]
    1100 |                 irq_shutdown(desc);
         |                 ^~~~~~~~~~~~
         |                 timer_shutdown
   cc1: some warnings being treated as errors


vim +/irqd_is_started +1086 kernel/kexec_core.c

  1075	
  1076	void machine_kexec_mask_interrupts(void)
  1077	{
  1078		unsigned int i;
  1079		struct irq_desc *desc;
  1080	
  1081		for_each_irq_desc(i, desc) {
  1082			struct irq_chip *chip;
  1083			int check_eoi = 1;
  1084	
  1085			chip = irq_desc_get_chip(desc);
> 1086			if (!chip || !irqd_is_started(&desc->irq_data))
  1087				continue;
  1088	
  1089			if (IS_ENABLED(CONFIG_ARM64)) {
  1090				/*
  1091				 * First try to remove the active state. If this fails, try to EOI the
  1092				 * interrupt.
  1093				 */
  1094				check_eoi = irq_set_irqchip_state(i, IRQCHIP_STATE_ACTIVE, false);
  1095			}
  1096	
  1097			if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
  1098				chip->irq_eoi(&desc->irq_data);
  1099	
> 1100			irq_shutdown(desc);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

