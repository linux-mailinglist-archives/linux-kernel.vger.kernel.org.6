Return-Path: <linux-kernel+bounces-425195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D1C9DBEBE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39ED52817DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0966026A;
	Fri, 29 Nov 2024 02:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJOXS7+Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313EB182D0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 02:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732848426; cv=none; b=OelG2Ev3SEHou7EhFaqPSbohMF4t4lDzw4Gs56GvtdbFqqboo+f9Zmm2txv9CeaMW+QTLam+jX0XpI4dvdojvAAO9e+3iT6Nq4K7Bm8G823iWpWU4YvYhpJDeRFg1q9QfKbQdExkWanZWYsgdkJZuOuSnWnOyICf0pGS6ZmLtEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732848426; c=relaxed/simple;
	bh=Iyi+W+JKz0EAQaKtqkrUOsmAFLfBMZSMkSfcKblxaS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MemCT/Z9ddAmLtL+bF7XUBjWI7iiz1YiSMSQt77sC6s5bzZpz+Jf/h0H3t2iUiImJfnMNuVJd+/UXVRZsoJOF+r6oA9ys0DPveOLlV6krbmN5muTsalfzovsKy9oy1Z/JLKOMVgdxCDssl2kYkSbN7qCVw2iAChgFz5sLLxPXZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJOXS7+Y; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732848424; x=1764384424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iyi+W+JKz0EAQaKtqkrUOsmAFLfBMZSMkSfcKblxaS8=;
  b=QJOXS7+YF3XW45xR8hrwwBcgzdh82kjiQHNuVp17g3KIRMdr1XKDX85g
   XJcIcSDSfmUOgK33oJelkPSWeBEmfkbAzU/52dKCo5aBEgRwBizsWZ9e4
   dhQ8nzj2xz8OvYDdLiduCWKN7IhrGU5YEU8XXipXu4yxaQb+EsR2aquQh
   n+uSJv01cxjmQi5jV8iw6aHxB7ffdtkgiMjj9IVXWvWhGsKFu361TxtUY
   SAaZM5vPBT+cmeMolDH0+GockupKIiVXkxv3VzVNshYmFhEMIHjXXnzn0
   +VH7gRTBlFf/nQu92klVA6yrtF7tTUKHMIg53hzWhs4WglctWKjQDwLDz
   A==;
X-CSE-ConnectionGUID: lfBghFRvTyCk5TZ+bsuYpA==
X-CSE-MsgGUID: XIWf7fJgTU6s9BMSkxyENA==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="33137819"
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="33137819"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 18:47:04 -0800
X-CSE-ConnectionGUID: OcwmjXnURpODgunOkehPOg==
X-CSE-MsgGUID: eL24zCVPSSGLJuhXw/TONg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,194,1728975600"; 
   d="scan'208";a="92554387"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 28 Nov 2024 18:46:57 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGr1y-000AGR-2s;
	Fri, 29 Nov 2024 02:46:54 +0000
Date: Fri, 29 Nov 2024 10:46:18 +0800
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
Subject: Re: [PATCH v3 1/2] kexec: Consolidate
 machine_kexec_mask_interrupts() implementation
Message-ID: <202411291047.R9P698b2-lkp@intel.com>
References: <20241128201027.10396-2-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128201027.10396-2-farbere@amazon.com>

Hi Eliav,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes tip/irq/core arm64/for-next/core linus/master v6.12 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eliav-Farber/kexec-Consolidate-machine_kexec_mask_interrupts-implementation/20241129-041259
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20241128201027.10396-2-farbere%40amazon.com
patch subject: [PATCH v3 1/2] kexec: Consolidate machine_kexec_mask_interrupts() implementation
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20241129/202411291047.R9P698b2-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241129/202411291047.R9P698b2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411291047.R9P698b2-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   kernel/kexec_core.c: In function 'machine_kexec_mask_interrupts':
>> kernel/kexec_core.c:1085:24: error: implicit declaration of function 'irq_desc_get_chip' [-Werror=implicit-function-declaration]
    1085 |                 chip = irq_desc_get_chip(desc);
         |                        ^~~~~~~~~~~~~~~~~
>> kernel/kexec_core.c:1085:22: warning: assignment to 'struct irq_chip *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1085 |                 chip = irq_desc_get_chip(desc);
         |                      ^
>> kernel/kexec_core.c:1097:38: error: invalid use of undefined type 'struct irq_chip'
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                      ^~
>> kernel/kexec_core.c:1097:51: error: implicit declaration of function 'irqd_irq_inprogress' [-Werror=implicit-function-declaration]
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                                   ^~~~~~~~~~~~~~~~~~~
>> kernel/kexec_core.c:1097:76: error: invalid use of undefined type 'struct irq_desc'
    1097 |                 if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
         |                                                                            ^~
   kernel/kexec_core.c:1098:29: error: invalid use of undefined type 'struct irq_chip'
    1098 |                         chip->irq_eoi(&desc->irq_data);
         |                             ^~
   kernel/kexec_core.c:1098:44: error: invalid use of undefined type 'struct irq_desc'
    1098 |                         chip->irq_eoi(&desc->irq_data);
         |                                            ^~
   kernel/kexec_core.c:1100:25: error: invalid use of undefined type 'struct irq_chip'
    1100 |                 if (chip->irq_mask)
         |                         ^~
   kernel/kexec_core.c:1101:29: error: invalid use of undefined type 'struct irq_chip'
    1101 |                         chip->irq_mask(&desc->irq_data);
         |                             ^~
   kernel/kexec_core.c:1101:45: error: invalid use of undefined type 'struct irq_desc'
    1101 |                         chip->irq_mask(&desc->irq_data);
         |                                             ^~
   kernel/kexec_core.c:1103:25: error: invalid use of undefined type 'struct irq_chip'
    1103 |                 if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
         |                         ^~
   kernel/kexec_core.c:1103:43: error: implicit declaration of function 'irqd_irq_disabled'; did you mean 'arch_irqs_disabled'? [-Werror=implicit-function-declaration]
    1103 |                 if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
         |                                           ^~~~~~~~~~~~~~~~~
         |                                           arch_irqs_disabled
   kernel/kexec_core.c:1103:66: error: invalid use of undefined type 'struct irq_desc'
    1103 |                 if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
         |                                                                  ^~
   kernel/kexec_core.c:1104:29: error: invalid use of undefined type 'struct irq_chip'
    1104 |                         chip->irq_disable(&desc->irq_data);
         |                             ^~
   kernel/kexec_core.c:1104:48: error: invalid use of undefined type 'struct irq_desc'
    1104 |                         chip->irq_disable(&desc->irq_data);
         |                                                ^~
   cc1: some warnings being treated as errors


vim +/irq_desc_get_chip +1085 kernel/kexec_core.c

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
> 1085			chip = irq_desc_get_chip(desc);
  1086			if (!chip)
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
> 1097			if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

