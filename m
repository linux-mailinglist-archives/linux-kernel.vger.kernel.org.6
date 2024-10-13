Return-Path: <linux-kernel+bounces-362875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5099BA82
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 19:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112DE1F21C64
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811E01487E1;
	Sun, 13 Oct 2024 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+qM79pE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8707A231CB3;
	Sun, 13 Oct 2024 17:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728839886; cv=none; b=oSqB8W0/kv7tggLRyDs/BSyoUv/RCATrsnRRkp27HalbPf86mxtflvcMYoPwJpkf/AmAutgQYFDqtjrOWmObXVIC6vibr2PybAmXdXGJ1cxOloDu0NfwsFFDbiwkE4RlaE2efsr+3rAbMiTb8XA+OWp6Pr2lw+dV75siy6taVC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728839886; c=relaxed/simple;
	bh=WbydFYAz5ZoV3Bxyd7+H0mgxO9Ixg4pDxJOa+O7WmhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tx89nM2hUAHkfyfn3+buBMEBEMhPAdZzNzJmerGd+DcJN+bbR0kFgpm8AVnTIllSonepDsHGO6XCJUG0hE2jYjUJJxz95bXIRrNWLnZQ33anOtwppe2HrZ+B2hkkVALlj4L3EX+ApNdrGaaJhbIXqfFJOQ63bdw/cQh2qacSTTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+qM79pE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728839884; x=1760375884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WbydFYAz5ZoV3Bxyd7+H0mgxO9Ixg4pDxJOa+O7WmhM=;
  b=V+qM79pEfIlIB/qrcM7BQLsXawC75SBcYkayTNmgUNBCncMvLYX9Y20+
   FP6LEg8O192e9btVvknL8y90uCegKzk6Na0O1pRbcCXXN8GDIjl2l/2dB
   TKtVaGxvkClLmP+n4fBfnTgLlO2sM29uVbMnvnXVwvwgYjB2i1Ho/nf8C
   rQK5bhAiexeUUHAZ59OdWeSvUg9Um0Ji+45gS4LsPdlEOgSAtVejf5qli
   Ov+kyzaeKvHMnCC7plcA33ulPoemfZm9COMQKDyock4RtUa3Hu+vPz+2r
   1LWNADH/zaQkyNTjyUqaXGtsKmkoXdNTGerun/oYvNbNr1LG11erQhH8m
   w==;
X-CSE-ConnectionGUID: LwTOV6SyRzSUZyB4mVcn6Q==
X-CSE-MsgGUID: d4jZUMg8QiOiqMuO599wPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28315575"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28315575"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 10:18:04 -0700
X-CSE-ConnectionGUID: McE/a4jjRLeIzbeAIDSdXw==
X-CSE-MsgGUID: T73fj4mGSc+AlQGTXdLMtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; 
   d="scan'208";a="77228813"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Oct 2024 10:17:59 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t02E8-000EYh-1W;
	Sun, 13 Oct 2024 17:17:56 +0000
Date: Mon, 14 Oct 2024 01:17:48 +0800
From: kernel test robot <lkp@intel.com>
To: Inochi Amaoto <inochiama@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Yangyu Chen <cyy@cyyself.name>, Jinyu Tang <tangjinyu@tinylab.org>,
	Hal Feng <hal.feng@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: oe-kbuild-all@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
Message-ID: <202410140004.WwnrCUnq-lkp@intel.com>
References: <20241009224410.53188-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009224410.53188-3-inochiama@gmail.com>

Hi Inochi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on robh/for-next tip/smp/core linus/master v6.12-rc2 next-20241011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Inochi-Amaoto/dt-bindings-interrupt-controller-Add-Sophgo-SG2044-ACLINT-SSWI/20241010-064628
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20241009224410.53188-3-inochiama%40gmail.com
patch subject: [PATCH v2 2/3] irqchip: add T-HEAD C900 ACLINT SSWI driver
config: riscv-randconfig-r054-20241013 (https://download.01.org/0day-ci/archive/20241014/202410140004.WwnrCUnq-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241014/202410140004.WwnrCUnq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410140004.WwnrCUnq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: ipi_mux_process
   >>> referenced by irq-thead-c900-aclint-sswi.c:38 (drivers/irqchip/irq-thead-c900-aclint-sswi.c:38)
   >>>               drivers/irqchip/irq-thead-c900-aclint-sswi.o:(thead_aclint_sswi_ipi_handle) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: ipi_mux_create
   >>> referenced by err.h:81 (include/linux/err.h:81)
   >>>               drivers/irqchip/irq-thead-c900-aclint-sswi.o:(aclint_sswi_probe) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

