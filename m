Return-Path: <linux-kernel+bounces-329730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1B0979510
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 09:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56A3283EFD
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 07:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474D02209F;
	Sun, 15 Sep 2024 07:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjyFfb9H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06617C7C
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726386341; cv=none; b=AB5E3MWPNFO3NraoySak/hTFEdXzQ7ntsd+diEgrwUbBMJE1TaFi3uONrVz9wLq2B6X0EVHhs2iqqQ4ZeGvGAMHNEHYqfACapnefCGk3CYL8kUrWhfHMBEw9XDWsxHf6p4Hon4FwYHUxovoVps5l1m8buyfKRA5WvF0pSMNrhZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726386341; c=relaxed/simple;
	bh=ln6JdQKZxPzLOTZu5d6+cUSDJEZvAnaWQJ5mqRPyLOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6IudXkQQK+OkGeIcNHoCOPo9PReBZgIFTsuFUYAExYkHnTMlb2pDwV9Ji11yNuSZ4iqR3R2pwc9QZHXHyL9jHjnLtqlX8ZQAuwQbd61RTgVslxVWXzJBt5BeWE16KTSSoJuNDEohTHE5pZ5rG6mizqyfaLEpqKUGKV4prwm0T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjyFfb9H; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726386339; x=1757922339;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ln6JdQKZxPzLOTZu5d6+cUSDJEZvAnaWQJ5mqRPyLOk=;
  b=TjyFfb9HdYZhHwMTXzgrqiTXxC45IBg4q51VMHTgdDQ0kJEJxRTdlVlW
   2o81BAeOrJgz/4UNY77oRr+FDFF0wpLrSwwsjDs2ZdGHBJdRulwGEgSTo
   Ifm2QuRtBEIaKSDCkhHmulOnrAFX60qAW6G1Q0+iyf4K/5PSbMUazmkYi
   caHTMgTXex0t2r45ixc9ZR1QlDYPGzC6TxWLQOxrJTCBXxdFd78dbDRP2
   eSnuBIaGagyNFIb4s934wbh2uiX3cvc/NBuddDJ3tC0eC4MTOLUKymWG3
   YxmNCiRbIB3twwlMzcRXwYBcwN6aR2wkNIhedfP/C0sZ0dfjwi0Ib7q7Q
   A==;
X-CSE-ConnectionGUID: iY9YOBKPTauN3sdcf7Uthg==
X-CSE-MsgGUID: UWZcjR8rS4GJMLGxfYGh7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="25070289"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="25070289"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 00:45:39 -0700
X-CSE-ConnectionGUID: 8SqHzLf2TnmkpkuZpV8jEQ==
X-CSE-MsgGUID: f5XJnoTnTueAo3BE2Fgj4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="68799103"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 15 Sep 2024 00:45:36 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spjwr-0008V4-2W;
	Sun, 15 Sep 2024 07:45:33 +0000
Date: Sun, 15 Sep 2024 15:44:34 +0800
From: kernel test robot <lkp@intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Julius Werner <jwerner@chromium.org>,
	Hugues Bruant <hugues.bruant@gmail.com>,
	intel-gfx@lists.freedesktop.org,
	Brian Norris <briannorris@chromium.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, Borislav Petkov <bp@alien8.de>,
	chrome-platform@lists.linux.dev,
	Javier Martinez Canillas <javierm@redhat.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v3] firmware: coreboot: Don't register a pdev if
 screen_info data is present
Message-ID: <202409151528.CIWZRPBq-lkp@intel.com>
References: <20240913213246.1549213-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913213246.1549213-1-javierm@redhat.com>

Hi Javier,

kernel test robot noticed the following build errors:

[auto build test ERROR on chrome-platform/for-next]
[also build test ERROR on chrome-platform/for-firmware-next linus/master v6.11-rc7 next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Martinez-Canillas/firmware-coreboot-Don-t-register-a-pdev-if-screen_info-data-is-present/20240914-053323
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
patch link:    https://lore.kernel.org/r/20240913213246.1549213-1-javierm%40redhat.com
patch subject: [PATCH v3] firmware: coreboot: Don't register a pdev if screen_info data is present
config: riscv-randconfig-001-20240915 (https://download.01.org/0day-ci/archive/20240915/202409151528.CIWZRPBq-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240915/202409151528.CIWZRPBq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409151528.CIWZRPBq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: screen_info
   >>> referenced by framebuffer-coreboot.c:27 (drivers/firmware/google/framebuffer-coreboot.c:27)
   >>>               drivers/firmware/google/framebuffer-coreboot.o:(framebuffer_probe) in archive vmlinux.a
   >>> referenced by framebuffer-coreboot.c:27 (drivers/firmware/google/framebuffer-coreboot.c:27)
   >>>               drivers/firmware/google/framebuffer-coreboot.o:(framebuffer_probe) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

