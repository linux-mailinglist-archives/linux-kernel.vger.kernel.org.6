Return-Path: <linux-kernel+bounces-516018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C37A36C0D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 05:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BBF1895D9A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A3717BEC6;
	Sat, 15 Feb 2025 04:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iC2OZ+nH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF315A850
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 04:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739595183; cv=none; b=NEFKuJ+hcmyv0kDaFJJ/L3PPkxPWN6a8R20QCztdsixRh1f0g9mblYNmWHOLFfjYGQ7UWBhi8gBEtDr856FWqCSWixcoteiJ6FgwhqX0dliTbA/O2Uh3lISH7fLkMD1OxjOeoqins4liRuu4ZnJwanPsF4dsPL+bK36WiCORC1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739595183; c=relaxed/simple;
	bh=P0Dn37McRvnTms2m38LeCL7CgUPMmxn+F1yqceNAn/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NEnf9DWF5Yzv0hGHIVeUl/MSIkPS/21C2V3IJPmxLqvAUbXHWmmcq0aox82EggpesNQmtZNi78QoHRQqiJmBfl9wDs6OE9K4Qlbb1uNHvxeDoJzxQvRHnvvsYVcx8Dxx4SuAGlGjGwOYHYUTl/MTYsrsUDrCDYameQZFDXi8zRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iC2OZ+nH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739595182; x=1771131182;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P0Dn37McRvnTms2m38LeCL7CgUPMmxn+F1yqceNAn/8=;
  b=iC2OZ+nHWEKmL1p2J6MPBlIPU8mfMr0TQM1esvF9YKfLQVqxS63nIBAD
   BS0BX5NqIMMEw13++aEvszQq1/Z/3HqIfS/BvNTOJnkILjNwfJ0f3NMh1
   ULvfkEiqu1cOXL03RnjMbn2YGd1yfs+jH/hr/cSL7lgi4m/d2RWnsI0sL
   bHa1DovuchfLK56I70c/muTqIVEpfnP+EpRRYH6EH2RDKRJ8eja1i3SfI
   8QN7zAXgOraTBGpXuch/a8frDmXuL51AZEMv3Ba4Y0innBejaHZXEsa9C
   oGZjQ99U+VnC66bA8nUTbuGwX4LZU1jOe+cUVfC4nFTBw8hMeIZ7+RgRk
   w==;
X-CSE-ConnectionGUID: oHaY7ok1S0SxkWV0TTW5Qg==
X-CSE-MsgGUID: GKdrMzqCSYeFf63IUBJYgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40492584"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="40492584"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 20:53:00 -0800
X-CSE-ConnectionGUID: UUOvsTbOQBylIW9GqFfing==
X-CSE-MsgGUID: sNZRjVBjTOahOdG4k/X27w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118838189"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 14 Feb 2025 20:52:58 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjAAh-001AVv-1G;
	Sat, 15 Feb 2025 04:52:55 +0000
Date: Sat, 15 Feb 2025 12:51:58 +0800
From: kernel test robot <lkp@intel.com>
To: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: [tip:x86/cpu 3/5] ERROR: modpost: "acpi_processor_ffh_play_dead"
 [drivers/acpi/processor.ko] undefined!
Message-ID: <202502151207.FA9UO1iX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
head:   96040f7273e2bc0be1871ad9ed4da7b504da9410
commit: 541ddf31e30022b8e6f44b3a943964e8f0989d15 [3/5] ACPI/processor_idle: Add FFH state handling
config: x86_64-randconfig-077-20250214 (https://download.01.org/0day-ci/archive/20250215/202502151207.FA9UO1iX-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250215/202502151207.FA9UO1iX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502151207.FA9UO1iX-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "acpi_processor_ffh_play_dead" [drivers/acpi/processor.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

