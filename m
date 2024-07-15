Return-Path: <linux-kernel+bounces-253152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26CD931D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86263B22391
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAC01428E4;
	Mon, 15 Jul 2024 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fyvRKLmI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6020DF4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721084923; cv=none; b=A3FKR1WI8iJQ74rW7qFQfEVbw03LdUU2AXTTZ955BiKiMrCwT9z1j52VV1xfywZ5mJFp1qcA2IBt7oF1/n+/UbHmUdO8gXLRe7XyhdebJOQnW95xAinyxHk/rZ5J1r+x2JB4MB9R2wd5YMkyhyYvhqG8xrtmOEMzAMkaIloK//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721084923; c=relaxed/simple;
	bh=tMYZdaJ9YJC57O+vJdO9CIEXevn6jsn2tI5Uvfm2XuY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VT/D4FGgY7pP9Z7dp7ZMC3NAWPNpGYzRVGogSkZLWiveWTWwu//4kmralJk+/UKMDQazpkNpQmQMPgK5PWnDeWNXXakZc4M8xjXj4WHoasXnLQzVX8xs6gHQtWljzFuF4mCWkVyx7IR9ir4DOc1JYUb+omFSwc2szi5Fg+VvQn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fyvRKLmI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721084922; x=1752620922;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tMYZdaJ9YJC57O+vJdO9CIEXevn6jsn2tI5Uvfm2XuY=;
  b=fyvRKLmIYPzZDzAhrkyS/uM/JDE5UtV0Z9R5FY3d/oUV7oIcW2ib9fg/
   ZDo1TC03VtHtKBawxU39mCdn2QeKqPr5B3/TOlcHN+PQwscaJVBoOnem0
   d36qcPLPHj4gDIFpxyP7d5HXS4adqPrTeiRHdfeQv+YDyA5nQ9MudfXvl
   U9WYBmaheILc3trG1tqbqzfECXemaT0eDRcyn1knD7HOSBixvM7rbtYNL
   ACtepESnda1UUfT9+c9UN27pOcB+v+L9uPTHWUbNk7pO3CAFnNUZHMyAs
   JeJObb3R1Kidz4zNceKIBjWCEF/N1TCQejn9VXeJKc16uUOck6UlqXj2Y
   g==;
X-CSE-ConnectionGUID: lyiMZ/KrT+Cqliu0rgDzww==
X-CSE-MsgGUID: Qyzj3mGIRZWLaGyTZl4vDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18203493"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18203493"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 16:08:41 -0700
X-CSE-ConnectionGUID: tq7gwQmhRvOBhX1fZnGUFA==
X-CSE-MsgGUID: tK/SgEefSuqCRldSRTpZwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="49536378"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 15 Jul 2024 16:08:38 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTUo8-000eda-2J;
	Mon, 15 Jul 2024 23:08:36 +0000
Date: Tue, 16 Jul 2024 07:07:49 +0800
From: kernel test robot <lkp@intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	Bard Liao <bard.liao@intel.com>
Subject: ld.lld: error: undefined symbol: iosf_mbi_available
Message-ID: <202407160704.zpdhJ8da-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e7819886281e077e82006fe4804b0d6b0f5643b
commit: 8d4ba1be3d2257606e04aff412829d8972670750 ASoC: SOF: pci: split PCI into different drivers
date:   3 years, 4 months ago
config: i386-buildonly-randconfig-004-20240716 (https://download.01.org/0day-ci/archive/20240716/202407160704.zpdhJ8da-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240716/202407160704.zpdhJ8da-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407160704.zpdhJ8da-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: iosf_mbi_available
   >>> referenced by byt.c
   >>>               soc/sof/intel/byt.o:(byt_machine_select) in archive sound/built-in.a
--
>> ld.lld: error: undefined symbol: iosf_mbi_read
   >>> referenced by byt.c
   >>>               soc/sof/intel/byt.o:(byt_machine_select) in archive sound/built-in.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

