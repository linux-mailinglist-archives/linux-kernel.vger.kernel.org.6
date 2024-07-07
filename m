Return-Path: <linux-kernel+bounces-243698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CD7929956
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 20:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4151C2099E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 18:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460FD6BFB5;
	Sun,  7 Jul 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgRBs1o5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424A55894
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720377478; cv=none; b=Apq6rw200Duj15utfyv4/rxhTMy1A/1mdoWOLTIZiVDSiOBkX6NFjmyAMUo+2GibrLZSwNiVRD60vOW2aZdOyr/QjEXFNGVF0UYOQSMaceq7junFARIKcJ5d565qhHQwNnw6SJSpMdeo4DvLlK4XL3pH4zn2rV7X/qTEuc6pajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720377478; c=relaxed/simple;
	bh=RxGEpbKWApa5morGNO0MUBCI3yuMnrNq9trSxfiILtk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Or9cEagHiT85ouVniUytCN73I3nG2AVFOM2NE5k71bF11sPs3fawRI2jhEi7CRjlArCrc9swYkvNHivPuaYPSn+zOciyPmfg731O1PyCbL3d5I2jBYS4h+gASe8t/4RiNJVSrJJt7WeZsykATcWbRmDhPYjdrcIByPyFOkP9pAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgRBs1o5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720377476; x=1751913476;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RxGEpbKWApa5morGNO0MUBCI3yuMnrNq9trSxfiILtk=;
  b=TgRBs1o59eQUJJ6iqv+kFcN+KKe8alwCYJgm/0PVsH0rePCQOrahwJ/0
   0RRdV6c7a6Aw9Mah82YZdoXCzy93gfnMXReDLJJc0sGklCistrW4afoHM
   +LChQMqoZBLTG4PROmbByVtmkv5WmKHOy0v7CKpJ3LiMen7oFvkdIwvat
   HHl/2b0YOQf8brIGqruxN4AmWC9NfKkCSxSf/a+AJ3AHKarlVCIdr6jaG
   gCikpCW8OTzG3ne+GzLMwIRUb49xUAPEtlullZlwZgm6H2wyLr8/yLZ9X
   kF5VQH4YbAaNlxr59/iJjTWqSsD6I1835hD0PmnXqnSL6ift4vDtiDEBx
   g==;
X-CSE-ConnectionGUID: 0S3fUF50S46t8BsMIfcILw==
X-CSE-MsgGUID: yszj2LIOQ32Jj4Nb7ABtmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="28181278"
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="28181278"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 11:37:56 -0700
X-CSE-ConnectionGUID: JsnRAchvQMidC8ra/Py/gg==
X-CSE-MsgGUID: h+IevadLQ+OamofUf8ECHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="51653702"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 07 Jul 2024 11:37:55 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sQWlk-000VBw-2B;
	Sun, 07 Jul 2024 18:37:52 +0000
Date: Mon, 8 Jul 2024 02:37:21 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 init_tracefs.isra.0+0x3a4 (section: .text.unlikely) -> initcall_level_names
 (section: .init.data)
Message-ID: <202407080201.odoMhKgZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c6653f49e4fd3b0d52c12a1fc814d6c5b234ea15
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   12 months ago
config: xtensa-randconfig-r036-20220501 (https://download.01.org/0day-ci/archive/20240708/202407080201.odoMhKgZ-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240708/202407080201.odoMhKgZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407080201.odoMhKgZ-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
>> WARNING: modpost: vmlinux: section mismatch in reference: init_tracefs.isra.0+0x3a4 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: bitmap_equal+0x18 (section: .text.unlikely) -> __setup_str_initcall_blacklist (section: .init.rodata)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

