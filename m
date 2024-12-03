Return-Path: <linux-kernel+bounces-428760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B39E1300
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59657164541
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC403172BB9;
	Tue,  3 Dec 2024 05:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FUsVCdYx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB101514EE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 05:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733205227; cv=none; b=IE/ytzp77A6xg4RA9M4mXy+VUldp+eswtT7BKuPfMJNfhJ0QBGkqAehHHnKStaOloWvjJ97qgsxc6uUJmuXe5GqobA2JDR8Kg3z77ghuLASjCly+c4e31wBNd9r64CnNSe+Lb1Kvlj6kP8/RzA2ZdmZF9GJ/6vkP+hGIPIJFvoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733205227; c=relaxed/simple;
	bh=wofRX0m3r117sJa2D2dT5iLz2lvmZl/pxixXx8Zrnx4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NhPj0MLX4cIQ4RBo6C9z2WWJraoM0QzxGs0BPhwRusXc/ycpQHh808q412u2ssv/0agnHxMl9YFh6XchzNdlbExP/aP9CqgpGH1Kg1HYetg0o1YbGuEb+6F+oPHu6S6vOMJfzT+cHKihn6WFJRi2wOetF3YzJ4FSl9n3kXdWPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FUsVCdYx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733205225; x=1764741225;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wofRX0m3r117sJa2D2dT5iLz2lvmZl/pxixXx8Zrnx4=;
  b=FUsVCdYxBAjbjKjxIaxnQc68nxBqVMghMzRLYDDUZq3cfxylMPCo54fz
   C/5MordpWggE7OPNRkP/lOUxXhcwZIRiCondNXUeraDPaMVTr4D10djH7
   dI27zjzQfwk5wLO/bR9hUOeQoWn/cF/Oa8pnZl4VJN3YFT8+21z2YjhSR
   kePGcKLYa2mUxiUyytvcm+8iG2VKPOBNckbF3sVigAg7765GLsHcK6VqO
   cBvswtGDvW3oSDDbVDH2ktryJlYjdwt2ea73zRbw7E5nUqShTMEKILwy4
   6MxDkfodnVOzCP0XHdUwHbHlbeS5UNiA4Gwc85J1KSzJDKb26PYlQwOUp
   A==;
X-CSE-ConnectionGUID: 8JC2pVpfRT+UNXh7lbRY5Q==
X-CSE-MsgGUID: ojPqwvWCStOgNPAxmM9MYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="43885730"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="43885730"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 21:53:45 -0800
X-CSE-ConnectionGUID: K6czh/W3T2uzZpv+bUXgdw==
X-CSE-MsgGUID: Jn/YszaERHqTQ5QUl0BFkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="97390970"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 02 Dec 2024 21:53:43 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tILqv-0000BL-1a;
	Tue, 03 Dec 2024 05:53:41 +0000
Date: Tue, 3 Dec 2024 13:53:09 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: drivers/mux/adg792a.c:134:34: warning: unused variable
 'adg792a_of_match'
Message-ID: <202412031354.XH7wsNeh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
commit: 879a52379704e479237d0b97822fd9302fed0675 iio: multiplexer: Make use of device properties
date:   2 years, 8 months ago
config: x86_64-randconfig-005-20240106 (https://download.01.org/0day-ci/archive/20241203/202412031354.XH7wsNeh-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031354.XH7wsNeh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031354.XH7wsNeh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mux/adg792a.c:134:34: warning: unused variable 'adg792a_of_match' [-Wunused-const-variable]
     134 | static const struct of_device_id adg792a_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~
   1 warning generated.


vim +/adg792a_of_match +134 drivers/mux/adg792a.c

afda08c4caa9489 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  133  
afda08c4caa9489 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14 @134  static const struct of_device_id adg792a_of_match[] = {
afda08c4caa9489 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  135  	{ .compatible = "adi,adg792a", },
afda08c4caa9489 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  136  	{ .compatible = "adi,adg792g", },
afda08c4caa9489 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  137  	{ }
afda08c4caa9489 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  138  };
afda08c4caa9489 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  139  MODULE_DEVICE_TABLE(of, adg792a_of_match);
afda08c4caa9489 drivers/mux/mux-adg792a.c Peter Rosin 2017-05-14  140  

:::::: The code at line 134 was first introduced by commit
:::::: afda08c4caa9489511557def51e322a5f2142a2f mux: adg792a: add mux controller driver for ADG792A/G

:::::: TO: Peter Rosin <peda@axentia.se>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

