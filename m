Return-Path: <linux-kernel+bounces-307637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA97C9650A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F621F22FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AEC1BA896;
	Thu, 29 Aug 2024 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7s2wrgb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809491B8EBD
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962664; cv=none; b=cpibENBw9Iy9fCnZJghrCjpYuF11q1SizX/9tACR2l7hiZ6SF0TVyL0HlItQAiIhPyxjhRrHmfnJr/JomVxDxSpDb5Se2ScjLlFDJQToSkn4wsHeJp9uGJnnlho9mhg3/Zn6Rau0mYKHn0fOYw0L7gzBgUkfjuCkAEzf8c/0rK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962664; c=relaxed/simple;
	bh=90PrkfQXjXDSt3P9MYaZ9N9UxQvisazsjLEAubpqp1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KEmbl+ymgyaddSjmFLWBtBYVcQxznfsV0ShxU8dkMbCpWJCLXsawAzYyVKDquoUzWb3PVuPuf0hafqsYzmAIRo7XlnbVQRhajXv/E3kJXMUvhxxYKbc2Db78C8N9s9XR8up/mmUcHlg0mXvIVvLrZNtrW9cU3R02EEvGc4K5aIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7s2wrgb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724962662; x=1756498662;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=90PrkfQXjXDSt3P9MYaZ9N9UxQvisazsjLEAubpqp1Y=;
  b=d7s2wrgb/4oyDhNj4Yk899jehnjiIjvvKcqFObis8Oqo0g7xmZWJGvW2
   hk4aPa9nZPIYLgGh6aLoueg1WImbgZWOaGpGKgFUKaUNk3X9BtZh4komI
   d3Pcq8MzDEP4t+hN/v5FhWHxjljkvxfrMObAhTo8hNlX19YCjQtrxd4/j
   us1SV2plTQr+bsLKMg0PLIxf6ETjkZ1jmL4TXWbop055ZUCoI4EDr96BN
   +ITx//1TIc6bJzSOmsOkkC0GLO0EI/8wUi1S0l//FzDOWn8DREt3aCIEu
   eQs+qEkr7SbLQ+7jWDKXBuOtvXIHSRu6RZZe+I7IZHtn1VnqP+ao/PCIS
   g==;
X-CSE-ConnectionGUID: 0ROQxT/WQXyQMTTWjRiRvg==
X-CSE-MsgGUID: XXwaXbrSQl+6YBQB/5lhxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23728206"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23728206"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 13:17:40 -0700
X-CSE-ConnectionGUID: M0u3IRW6QDShUvyqAePJnQ==
X-CSE-MsgGUID: o9sHamUTTMeZfNhL+bgO9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="94426148"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 29 Aug 2024 13:17:39 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjlaJ-0000hO-1S;
	Thu, 29 Aug 2024 20:17:35 +0000
Date: Fri, 30 Aug 2024 04:16:44 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: arch/mips/boot/dts/realtek/cameo-rtl9302c-2x-rtl8224-2xge.dtb:
 /cpus/cpu@0: failed to match any schema with compatible: ['mips,mips34Kc']
Message-ID: <202408300443.AHb3bGpK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b9dfd9e59367eff5f65ef2a850f2df674f1f1c5
commit: 74beefb5935a67f9fa60f8103e3f69d42d6a08d7 mips: dts: realtek: Add RTL9302C board
date:   7 weeks ago
config: mips-randconfig-051-20240830 (https://download.01.org/0day-ci/archive/20240830/202408300443.AHb3bGpK-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
dtschema version: 2024.6.dev16+gc51125d
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408300443.AHb3bGpK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408300443.AHb3bGpK-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
   arch/mips/boot/dts/realtek/rtl83xx.dtsi:19.11-58.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
   arch/mips/boot/dts/realtek/cameo-rtl9302c-2x-rtl8224-2xge.dtb: /soc/timer@3200: failed to match any schema with compatible: ['realtek,rtl9302-timer', 'realtek,otto-timer']
   arch/mips/boot/dts/realtek/cameo-rtl9302c-2x-rtl8224-2xge.dtb: /soc/timer@3200: failed to match any schema with compatible: ['realtek,rtl9302-timer', 'realtek,otto-timer']
>> arch/mips/boot/dts/realtek/cameo-rtl9302c-2x-rtl8224-2xge.dtb: /cpus/cpu@0: failed to match any schema with compatible: ['mips,mips34Kc']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

