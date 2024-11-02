Return-Path: <linux-kernel+bounces-393484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D782A9BA133
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 16:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B4D282334
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DD81A0BD8;
	Sat,  2 Nov 2024 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USG+6xhO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E8A185936;
	Sat,  2 Nov 2024 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730561328; cv=none; b=A1zeCJzigJD+E9FZ0Myif9E9sV2Ko+MWGrUcH0UxH5PDc6VNrycA1wxqPi03FOkBIXXN+PhgVxQYMXgBke/Ot/1kadedtvgxHKbQ8Ad+RDzCb8UifmAs8kfY78It6cuGoMfkSzrxX5dsVg++pH+y2SxVt/0rOcYjkbzWbJ4lw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730561328; c=relaxed/simple;
	bh=zAUFqbRnx3QrIZL0lXYiEoGKtF5VPcXttxczM7SZY6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QC9VPIKHfPzteDjepo1UZXg4SzfZymKssh7Aj5gj1FlSVhClHh3xcC1dhDWVXApELqQ9z5FERRKi+tDlDPaEYb5x7M/nb+qQJj1J8cYI/fT5Z8JjW/gwQXaOX80FLT7nGySyglGSri8Z4eazIRqLD/G8a2dAQ635etNB7wIRbzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USG+6xhO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730561325; x=1762097325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zAUFqbRnx3QrIZL0lXYiEoGKtF5VPcXttxczM7SZY6c=;
  b=USG+6xhO3bNumqh7xUYJoV4HD5stEe+mGJbVHV/6jNOc/HzR1hFOJf4W
   n032K2Jp6YXLMS0pVZZSnqB9QRRfrUyu3UmF1w322xyS0nGEbLVBRTfYG
   WWNLGR+DmW1TxZWSaIgSR5+GosHSmSVmeZNtB1qqvKZesMJgCLUN8c0V1
   IqERh5RzmU9qQIhC/v1UGcfI/0oilAyt81C6c5/UHx61oJ7it1iF9IM/k
   hFAUy5992ek6xSC5pzzpiYckcRPVexqERBat8ZW0bBjb5aN4QHMH6Uds/
   0PK7SDWYoxCe7FatHkOor/DIN5GqXE9sdsfHgMDuynKw2lYuWnsc+3GX7
   Q==;
X-CSE-ConnectionGUID: 29cfYB+gSOmDpA3MHll8uA==
X-CSE-MsgGUID: L1zbE58vSRuZXXaR/OmMjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="30411883"
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="30411883"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 08:28:45 -0700
X-CSE-ConnectionGUID: B6v/LPEhTo64evpmnST69g==
X-CSE-MsgGUID: jRQcgbeoT7+OwZQGIUT5vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="83685863"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 02 Nov 2024 08:28:42 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7G3L-000j6H-1q;
	Sat, 02 Nov 2024 15:28:39 +0000
Date: Sat, 2 Nov 2024 23:28:33 +0800
From: kernel test robot <lkp@intel.com>
To: Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org, Conor Dooley <conor@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH 10/11] riscv: mm: Use physical memory aliases to apply
 PMAs
Message-ID: <202411022337.JHozQieV-lkp@intel.com>
References: <20241102000843.1301099-11-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102000843.1301099-11-samuel.holland@sifive.com>

Hi Samuel,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.12-rc5 next-20241101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Holland/dt-bindings-riscv-Describe-physical-memory-regions/20241102-081311
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20241102000843.1301099-11-samuel.holland%40sifive.com
patch subject: [PATCH 10/11] riscv: mm: Use physical memory aliases to apply PMAs
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20241102/202411022337.JHozQieV-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411022337.JHozQieV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411022337.JHozQieV-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "riscv_fixup_memory_alias" [arch/riscv/kvm/kvm.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

