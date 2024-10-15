Return-Path: <linux-kernel+bounces-364887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23ED99DA95
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B09B22100
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047A933EA;
	Tue, 15 Oct 2024 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuA34u+Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3A319A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728951258; cv=none; b=DPbjE93MLitOElPBv3FxOOQvWCDHqMT9Rr4mxxBuYpbVkfog56nq+IJyUym2rWxYblTJ6iSRt9LWVK+VpluCTfFD5EUBYFk1os1oWB+1IZ0Bt1P94wVdBMkv2ATY5wuYDJsYIkKmT+JoMEM7SCJRRZnlGLEPh3m93XFhCKgHwCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728951258; c=relaxed/simple;
	bh=Tg7JX687x5251Ku5whEkeIFu+50VBNMoKFGSzdW/FRE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FP4Ef4uHiGfeJrS2Oz+nw53Noe+fP/LpzTQSwZbM9Xl0wr2hFnAhQbDLLCynxbtOPwEHwvc8iUkzMyZbb/uA3HVZoISQaQZy5sf3/12wNefj9nD6JSGFDH/P9F+e1XEClX0/ggWnUIYSY8LJl8gcz1mTQHlaFajrjb+qeSOskq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuA34u+Q; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728951256; x=1760487256;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Tg7JX687x5251Ku5whEkeIFu+50VBNMoKFGSzdW/FRE=;
  b=WuA34u+QXjQf0VdPSoKJMS5/143//FCdmXNCjkha7tAIhm/pI4NkKalf
   s7SB62eqAt3vhpE59xm1IfLpkoUf1yzu7T4UmzGmI2OQX3IVjKBNyfulM
   gNB/6fmW3Z386qvchNY0UWqt6UUeyLCARARaayyX1AUfDEEZj16LKZvFD
   Gl6Mt2yZrjr58IXmdRFh5/z76anonvm+j6P4SATLfXWdhloIQyEchl+YS
   IX4vr1AQOUR2ctun2aLWs2TQml/7JiqjJxSfEPNXezGHoTMZ89K6/7Qtd
   kRUhE5yc2EB+qgPFiHJs7q+9T72gYN7nMid+gVJib8HxIBTgvCI1ALdCp
   A==;
X-CSE-ConnectionGUID: Xww3zuIBTi+xFVFEF01oeQ==
X-CSE-MsgGUID: Iek22BtgQNqGhI8zTKxaIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31201025"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="31201025"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 17:14:16 -0700
X-CSE-ConnectionGUID: 0cSVu3LtTwiUNXSv9M/o4Q==
X-CSE-MsgGUID: wLM6z+8fTGiOes2nTNFf+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="78163062"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 14 Oct 2024 17:14:15 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0VCW-000HLx-0Q;
	Tue, 15 Oct 2024 00:14:12 +0000
Date: Tue, 15 Oct 2024 08:13:21 +0800
From: kernel test robot <lkp@intel.com>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Hari Nagalla <hnagalla@ti.com>, Andrew Davis <afd@ti.com>
Subject: ti_k3_m4_remoteproc.c:undefined reference to
 `devm_ti_sci_get_by_phandle'
Message-ID: <202410150837.FOGlkGvW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eca631b8fe808748d7585059c4307005ca5c5820
commit: ebcf9008a895a2a9416f69e186b56fbade35e12c remoteproc: k3-m4: Add a remoteproc driver for M4F subsystem
date:   8 weeks ago
config: arm-randconfig-001-20241015 (https://download.01.org/0day-ci/archive/20241015/202410150837.FOGlkGvW-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241015/202410150837.FOGlkGvW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410150837.FOGlkGvW-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/remoteproc/ti_k3_m4_remoteproc.o: in function `k3_m4_rproc_probe':
>> ti_k3_m4_remoteproc.c:(.text+0xc24): undefined reference to `devm_ti_sci_get_by_phandle'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

