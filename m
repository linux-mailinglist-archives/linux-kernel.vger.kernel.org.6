Return-Path: <linux-kernel+bounces-394284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CA29BACDB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795151C21192
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875F718DF7E;
	Mon,  4 Nov 2024 06:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlcoSG20"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6154814A4F7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730703112; cv=none; b=FGujF8JcBCDEJG6k9qS43BK6eLACmGChsbEVWzRc1E4HdvkvydLgqOtlShLrr4Zv4EAWIE3MEQt2Re/AUC2ervOpGhnHNPcfioW89Gvd0wQkwJwsE5hBs4i6O4+ebKWG4x1j61L5MG1aFo+ugX0kDFVU06z6mGnAZKMPhR3WlgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730703112; c=relaxed/simple;
	bh=CNImVzsZlJ7xWiG4UC92lMfsLbazMpimQH9GRzbrG7A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TwvPF9rcEv4BSdWWISKgmDHYzjKe1xZPtCskZvyC0TaQKCS1WjZLgC7BhoGHSyyPfXR74IgscIFVlWz/cKXsfmRqKa//zmBCg4CpNCc20M3gbb1wxhlIGJOq8RMU/2tmMGWAOM5BMU2tQzkCVlLFncGcbwx/B1zgKD4ISc6KMq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlcoSG20; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730703111; x=1762239111;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CNImVzsZlJ7xWiG4UC92lMfsLbazMpimQH9GRzbrG7A=;
  b=ZlcoSG20HOftqoUszZ6+YsfSPIB1ljPS6/GH+lY1oJUPcLg/IZzgBABb
   THMH0c7tuFl1o06/0YsQQiUpQVbQ9hRv5Uqis9o9rPCF+ZdniTSrO3ivy
   Pb/APsaxg8CFZ+NpRzawXOdcya6OzC/f2lPcQdFfiji5PcQrjrgkD/S4f
   P/RTNO62z9H6r62K9K40haETwGbtfVw+GHzXE5V2e9v3FIaGlFQdGCyIY
   8TWeaLSDy8t2eMogN5AnJA8/3udAwOb+P13nP0+mNfszhAIEqsh6YWzkz
   f7EzbiaSqIT9JxH51+ZSSnqqVAteVdQu/585QQrENjy0Q4YbhcPKCEqFd
   w==;
X-CSE-ConnectionGUID: tDDuZuiKQPqmjwEG+oA0mg==
X-CSE-MsgGUID: I4A/hT4jRvWO2ruHiDYoCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="40967700"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="40967700"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 22:51:50 -0800
X-CSE-ConnectionGUID: qR+/SgJNQ62A1DbHEInMig==
X-CSE-MsgGUID: CdSTMi/CR8+cOkr03SOiog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="87496271"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 03 Nov 2024 22:51:48 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7qwE-000kZ3-1P;
	Mon, 04 Nov 2024 06:51:46 +0000
Date: Mon, 4 Nov 2024 14:50:51 +0800
From: kernel test robot <lkp@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: ld.lld: error: undefined symbol: __kcfi_typeid_cpu_v7_smc_switch_mm
Message-ID: <202411041456.ZsoEiD7T-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   59b723cd2adbac2a34fc8e12c74ae26ae45bf230
commit: 1a4fec49efe5273eb2fcf575175a117745f76f97 ARM: 9392/2: Support CLANG CFI
date:   6 months ago
config: arm-randconfig-001-20241104 (https://download.01.org/0day-ci/archive/20241104/202411041456.ZsoEiD7T-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241104/202411041456.ZsoEiD7T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411041456.ZsoEiD7T-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __kcfi_typeid_cpu_v7_smc_switch_mm
   >>> referenced by proc-v7.S:94 (arch/arm/mm/proc-v7.S:94)
   >>>               arch/arm/mm/proc-v7.o:(.text+0x108) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: __kcfi_typeid_cpu_v7_hvc_switch_mm
   >>> referenced by proc-v7.S:105 (arch/arm/mm/proc-v7.S:105)
   >>>               arch/arm/mm/proc-v7.o:(.text+0x124) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

