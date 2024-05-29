Return-Path: <linux-kernel+bounces-193277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D138D29B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2A328410F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21C615A858;
	Wed, 29 May 2024 00:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g6uXwrdI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7F3139CF6;
	Wed, 29 May 2024 00:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716944269; cv=none; b=m5Ggl67Ap+0ahZw3/xvR9Gb7LKgNDEDQocua1/88jTyTWDvt81YjcmGoOXL3m+DG9WgBTQlkvSkISdihFw9pctnLOp2g1qGOxPQQ5G7aOGgCUgGYy+JITrHWwS1g1iHAbDVS+RwgmRSf2rWFBwoPB7gOn7mwOo7G8Ruv1nBWYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716944269; c=relaxed/simple;
	bh=9PMDHi0i2X7JYHYfsjL5TSPtAzVp+Z//KwjHgfx3R6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eU6M2BNtd6He87w4SVCrZylVIkmM4bkVnwk29SKgRqMAJ4S/3+RcMmR4VLHWEWStzG5z7nxFw5yc8xXF/wtKySFfyEDBeutg1IsTFXem55HtERx6htkNpqYtqUdtcsz1m6H3MyDQVkrrnwZB4GP58HBphEvmLtwtHSJQBM3JU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g6uXwrdI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716944267; x=1748480267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9PMDHi0i2X7JYHYfsjL5TSPtAzVp+Z//KwjHgfx3R6M=;
  b=g6uXwrdIxHqlF7i0gWIPf4/mJ3jZbdecPCBIMGXfI+IMlXdryPg6OkG0
   EHiBVelux3MyUwllYdc4UKLIWX5Cw+t3XffbTw1pcD11yADxVRB6O/FYq
   ZhhhkvSfbUGvkH8g8U2aRhInaJuk09EaPKZeNrrkKi2oEotTxXiy+CuUN
   NV4Bn1z3cDzJQ/qgB3a/Hcn/r85AZIgqnfWWd5aD/8FCah/Hy2rQJvND7
   eBo+ojZvK98d4lbPgvHo9RCBwLpzsy9I5EkZAPk+prxM6B7QGiVJxMhTH
   0BgeYWMkubeDmMTseP0Om800PuLKRlwhf2I6+suqhvWVIY8cwQkSEys+M
   g==;
X-CSE-ConnectionGUID: pWa5x9XnQL2Vf6I7JATkXQ==
X-CSE-MsgGUID: hOY17jcWT/SdN7/rMDeZow==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="24738016"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="24738016"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 17:57:46 -0700
X-CSE-ConnectionGUID: 9XYhmVTTSMK9lfuGzBmNlA==
X-CSE-MsgGUID: XvW19c5xTcKwgSa5g6SciA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35317869"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 28 May 2024 17:57:42 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sC7dL-000Cwn-2I;
	Wed, 29 May 2024 00:57:39 +0000
Date: Wed, 29 May 2024 08:57:13 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: Re: [PATCH 5/5] riscv: dts: sophgo: Add LicheeRV Nano board device
 tree
Message-ID: <202405290822.4dIYJxLq-lkp@intel.com>
References: <20240527-sg2002-v1-5-1b6cb38ce8f4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-sg2002-v1-5-1b6cb38ce8f4@bootlin.com>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Bonnefille/dt-bindings-interrupt-controller-Add-SOPHGO-SG2002-plic/20240527-183235
base:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
patch link:    https://lore.kernel.org/r/20240527-sg2002-v1-5-1b6cb38ce8f4%40bootlin.com
patch subject: [PATCH 5/5] riscv: dts: sophgo: Add LicheeRV Nano board device tree
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20240529/202405290822.4dIYJxLq-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240529/202405290822.4dIYJxLq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405290822.4dIYJxLq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> make[6]: *** No rule to make target 'arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano.dtb', needed by 'arch/riscv/boot/dts/sophgo/'.
   make[6]: Target 'arch/riscv/boot/dts/sophgo/' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

