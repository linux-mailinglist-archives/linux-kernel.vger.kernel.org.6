Return-Path: <linux-kernel+bounces-267174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF98C940DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0D628540A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A2D195B28;
	Tue, 30 Jul 2024 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDqxSAI/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C64018EFE0;
	Tue, 30 Jul 2024 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332259; cv=none; b=hM0takv6rGpErmAmwNrkgiJCp3IpgPBpwT4z2y/nv7BsGR6s3V6v4TdAA5ezvmbqrNt8alvYseY8ZGj6esEW7ahOx8tmQnMTOeMROHhZt7Ede2YZhiY5ulGQI/tDuU8vI5CXi01GNTBaZ4vdIkXDLySDbYFbMLoUdYRajxGb7/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332259; c=relaxed/simple;
	bh=eQ4F1x/lpLxGO5KX65v21lz8EB6jaKNod2yiaHWTOHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOAD4G1JsKRpPW3OBxrE3CI8EV/CYDD7VhmAv4C9o1vo1j9mGsfqq9Bz6+KwkpP90Y8U1rlVo+sC43bqqzErvLqQnyO7eYUZV9uBG2LgIH99yAPeAO0I/SHHdnKOxbtttZFhG7uZfMccR4NzGSn9mWcYTmfuMFtXDgW4hekC5EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDqxSAI/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722332257; x=1753868257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eQ4F1x/lpLxGO5KX65v21lz8EB6jaKNod2yiaHWTOHU=;
  b=gDqxSAI/lWgnwnaZzcjDa32ePLqjrrHcLbJ8GMZQ7jYA7zQq9tmHrRX5
   UXWnD5xq10uSnm8ATuHK6HyYiDMxP0eNXE8u+s1IesJzMnLiHL+KzoUmx
   5TPeEs2vRECrx4LTY2l1qeQlLbY/XznxQxc5cRI6bXp0kD/goBjMmQqsl
   95VQv5G8UQIrMpTYneO5rynQusz3nGEZ5B5AxvD2cd+4n6JkMVEwmkxpz
   fYy1A7u9daA7KDU/SImxvH/wS1JwrQaHR8yWghZygP913UHJ0sou7CWO6
   drT6aQmBaupIB9vxJl1Yw7ks1SM6bviJWlmRiXCteb7cFFlxNKkHQ0BAv
   g==;
X-CSE-ConnectionGUID: 6qX+W8k0TnGsHmFSRMf23w==
X-CSE-MsgGUID: RxkUyNQeQOiwuiYSm1zj/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="37609123"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="37609123"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:37:36 -0700
X-CSE-ConnectionGUID: LKz+kXhGS6K4pP63RiYLZQ==
X-CSE-MsgGUID: CH0h1jCyQo+6eb2XHzFn6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="58605605"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 30 Jul 2024 02:37:33 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYjIQ-000sjU-11;
	Tue, 30 Jul 2024 09:37:30 +0000
Date: Tue, 30 Jul 2024 17:36:47 +0800
From: kernel test robot <lkp@intel.com>
To: Inochi Amaoto <inochiama@outlook.com>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Jinyu Tang <tangjinyu@tinylab.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 3/4] riscv: dts: sophgo: Add mcu device for Milk-V
 Pioneer
Message-ID: <202407301749.K0pFCNLU-lkp@intel.com>
References: <IA1PR20MB4953826DECDCC141A7CDE634BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953826DECDCC141A7CDE634BBB02@IA1PR20MB4953.namprd20.prod.outlook.com>

Hi Inochi,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on robh/for-next linus/master v6.11-rc1 next-20240730]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Inochi-Amaoto/dt-bindings-hwmon-Add-Sophgo-SG2042-external-hardware-monitor-support/20240730-160416
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/IA1PR20MB4953826DECDCC141A7CDE634BBB02%40IA1PR20MB4953.namprd20.prod.outlook.com
patch subject: [PATCH v8 3/4] riscv: dts: sophgo: Add mcu device for Milk-V Pioneer
config: riscv-randconfig-051-20240730 (https://download.01.org/0day-ci/archive/20240730/202407301749.K0pFCNLU-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.1.0
dtschema version: 2024.6.dev4+g23441a4
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407301749.K0pFCNLU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407301749.K0pFCNLU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts:29.1-6 Label or path i2c1 not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

