Return-Path: <linux-kernel+bounces-399070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 034EE9BFA85
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F566B21FB6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6176920E034;
	Wed,  6 Nov 2024 23:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5wNrCx8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6074B20D4FE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730937526; cv=none; b=XyXCKZlY2kdV6HbhDRnhjLjHe7fSLVFQwBdeD6ENuwn95ah7+lOryPOJhki9X+G75xFctu7fh1bLqmCrF1n59Ia1G0QZnUG7HTewabj9X7DW5ojeamUkNuycxkUbpfufhy9ybb1VEoM1yeylsWqGddM/PuGFv6lX4kddiStwirs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730937526; c=relaxed/simple;
	bh=hNLUmVI0XIE1sSHTXGqPa6jNx4G+gM0tdom7cXKrWMM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bJ2ww067kEtSCnetRo/EjcJY/eLCDCnG5cB5fU1SkUo6Q625EnSZiNxIbwArpB53S0QgDolLRgi29TqisqmUi3aRuI6n/x8YtK0OWa1YaIDZx+rsWtICqvytJsIe715QkFycOMBHnidwxydTkkR1bqamoC4Kf/j/44Qm0FVgqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5wNrCx8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730937524; x=1762473524;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hNLUmVI0XIE1sSHTXGqPa6jNx4G+gM0tdom7cXKrWMM=;
  b=G5wNrCx85ZbbfHF1pNT3HSqPnRDOmaizRsxceuOQtqTk+22ykm9DWa3i
   ttcoi1nByUdKg2x2DCqydyvBA32QyJJhN5KvB8GXSRqSQP0pw78RKwqWo
   rNs/OorSR32Lc8zpXW8guIwADfEFbWh5NaA+uyEbnwUbjqiBhuHp6W2sY
   yZnvy5SN4ef2c3M5u1Hy0JUcWSkHWh+bjeKZ4hQfhiG1iHX5u1gYQI/lA
   ZZIaTHU9awUBS9jx/JQFpfh56FrUuh9F54A5sVZihTRQ7eBtuVNJuDVW/
   adSjcsEpQgcAhaYr/370udDkL3AgrCVyFg0tfWp8LKon0vwOPo5MrJO9D
   g==;
X-CSE-ConnectionGUID: rPQgbTNbSq27YX3LRKPr3A==
X-CSE-MsgGUID: 5W+Rp5FYRcWFRG/rwFZnHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30169098"
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="30169098"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 15:58:44 -0800
X-CSE-ConnectionGUID: Q4uQwBs0T5aEWDxGDYKj/Q==
X-CSE-MsgGUID: 287zlRXWTqGwuJB/D2zrDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="89429028"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 06 Nov 2024 15:58:42 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8pv6-000pY0-1J;
	Wed, 06 Nov 2024 23:58:40 +0000
Date: Thu, 7 Nov 2024 07:57:58 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Justin Stitt <justinstitt@google.com>
Subject: vmlinux.o: warning: objtool: gntdev_copy+0x381: stack state
 mismatch: cfa1=4+96 cfa2=-1+0
Message-ID: <202411070755.aWgLgIN8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f43b15692129904ccc064180fa2dd796ba3843a5
commit: 9bf4e919ccad613b3596eebf1ff37b05b6405307 Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()
date:   7 months ago
config: x86_64-randconfig-104-20241106 (https://download.01.org/0day-ci/archive/20241107/202411070755.aWgLgIN8-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411070755.aWgLgIN8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411070755.aWgLgIN8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: gntdev_copy+0x381: stack state mismatch: cfa1=4+96 cfa2=-1+0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

