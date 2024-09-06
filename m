Return-Path: <linux-kernel+bounces-319438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9C996FC9B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B7CB24DB7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B91D6C6C;
	Fri,  6 Sep 2024 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kN7IYbPM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133F81B85DA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725654117; cv=none; b=UZuqtnHkKzKWu23YETaokWWttWaUE+etcPnmP0w5juMDeD/rUXZ/XWKTL1Y+LnpqQMrnrP4zdq78c7mR88NJj7pAgzVTEQrMIk3GIBJexe8pgCiwZ0gcpz70eMXBFbBsLMPfJpen9h1er+6y0xTSpvB0OJvji8Oqv4VRuxf2Y+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725654117; c=relaxed/simple;
	bh=Z0faJocwXpaa07ctahBkmuiWBOl1Ec3JVsHkN4X5lOo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PM9LOe/rqKiJv2Ne0BDX2KwL8M475ETm9cVgnMBatvNoq5haR6EFbERmQVM1h6fWr0tq7jfCJAIYFkhPQupEZHNmoix0TSseGyNaq2ho8R2og3WmUNRYp4DyxEiRvTT77nNalqoGK7Fo4rt5BmDmox/5TDHmxc38TJR7D8hkbA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kN7IYbPM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725654115; x=1757190115;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z0faJocwXpaa07ctahBkmuiWBOl1Ec3JVsHkN4X5lOo=;
  b=kN7IYbPMRjqfK/JrxBsC+Sa5bkzPV8tZPXzi3Xa2SQDHBHwSm2Px4Q7Q
   vjArI9q5SpgJEk+2e+jWdGwBsb7cj05W57+2yUHZuSG/YfjKVpf7Q2rIq
   N1HIA+aQRJiN5y+xYla7biGGsJrscrCUk6ODgtLMGwa18kVjYw2xSqr+n
   KUxf6iXbU+5a6hXAF7NZcJwNA3LQtips/XOcfSOiaOUPZ4ZLi7Qe/I33F
   rGVi/5x0gvW6v+y74ZCzo8WFLRktxyBCb/fnHjcmHP82/PH9MqXT8XG4H
   ydcYdhML56zIn9IiiL7uz6qZSmkXn/jsfZNIqFMIPAAQCxbuRUCgBwpcZ
   w==;
X-CSE-ConnectionGUID: stYGSjRqS8WAwYojJY32PA==
X-CSE-MsgGUID: mdXvuw2tR6qBBX/S/pLuSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="46951372"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="46951372"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 13:21:55 -0700
X-CSE-ConnectionGUID: rYFXymkkTF2dJ87q2mrc+w==
X-CSE-MsgGUID: RnhK9HN8RuqrYxwZKheaXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="70847751"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 06 Sep 2024 13:21:54 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smfSp-000BgJ-08;
	Fri, 06 Sep 2024 20:21:51 +0000
Date: Sat, 7 Sep 2024 04:20:51 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: {standard input}:4719: Error: opcode not supported on this
 processor: mips32r6 (mips32r6) `dmfgc0 $6,$9,7'
Message-ID: <202409070438.79SGqcTc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b831f83e40a24f07c8dcba5be408d93beedc820f
commit: a640d6762a7d404644201ebf6d2a078e8dc84f97 MIPS: mipsregs: Set proper ISA level for virt extensions
date:   7 months ago
config: mips-randconfig-r111-20240819 (https://download.01.org/0day-ci/archive/20240907/202409070438.79SGqcTc-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409070438.79SGqcTc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409070438.79SGqcTc-lkp@intel.com/

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:4719: Error: opcode not supported on this processor: mips32r6 (mips32r6) `dmfgc0 $6,$9,7'
>> {standard input}:4731: Error: opcode not supported on this processor: mips32r6 (mips32r6) `dmtgc0 $2,$9,7'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

