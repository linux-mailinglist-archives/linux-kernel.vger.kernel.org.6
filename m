Return-Path: <linux-kernel+bounces-567378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2241A68546
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 07:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C63B19C2363
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB9124EA9F;
	Wed, 19 Mar 2025 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQlkWVfZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C861DE8B8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 06:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742366875; cv=none; b=rNdebSKkEEJBE4CqOEybLPXRnRPlM8wZ6agVisQHGxwvApPWh+yOp0rmY01aoE7oCv56DMlFT5KDm0twty9HTzCNt4P4B3aFQDgaNOLz0/PoLcagMSFBmy4pI2b6labz5K2QNneAvBPjyw+G/qhLBKI1K1HqtNlSMbd+POcnvds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742366875; c=relaxed/simple;
	bh=aXpwSrXMpTN4xjqFOZzObGNQjtZP/JUauYagQka7Ek4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FuzdtZW40VmojjIjFWMUwKV6YREyOonSk0V6/g08H6/CFs+OBBo2DiMo1oo+u219qrBzHZJc2jfgxFGhd6JJYDFYjqu6AfsqRTSpszqr10akIwEyI12ULEAP+PrnRA4q5DxLmE5iAhzMMt+CrOLj1/JZhZU4tpPkX6DARY6SxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQlkWVfZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742366874; x=1773902874;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aXpwSrXMpTN4xjqFOZzObGNQjtZP/JUauYagQka7Ek4=;
  b=gQlkWVfZwFUqowC0/5ZVXywbWHQMZWTiD6qb7Rt9Ygf+IDQA/4KrBsx1
   ERa8qNo458d9LE8l5gsqWC0WOPqJMTsSetot208Q4zfp0are41YQ6KXw4
   fiNhzpxvzJvTHUKp3PiXX58sPGg4aDP8KTIG9yj6VfQ2KIf5IeMdMrgp1
   1r5abDnPOoqc+CI1f2Y79JUCnZdW/VfMb2p0SzvKO8iHzPF9Z2+eZSM/r
   /xZAUFhzRajjtLn9YHG/IypNWQ9AUcUVwjptOaLzoNsnCMjd+pMQdp1Qw
   RXQojOzuZbDX7n/9rg7PvQEUKT5VdU6GY1IkkwtD3hF00ga/sHN13CaFd
   Q==;
X-CSE-ConnectionGUID: PEpWUVoATUW4x17u3nd6Ig==
X-CSE-MsgGUID: zqrQrSOvQcm+tXX+ok71eA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43708168"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43708168"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:47:53 -0700
X-CSE-ConnectionGUID: StrOZa8hQGCV6TRYlIgGOw==
X-CSE-MsgGUID: F2VV/fkQSHmM4llit9iaGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="159634600"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 18 Mar 2025 23:47:52 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tunDR-000ERY-2R;
	Wed, 19 Mar 2025 06:47:49 +0000
Date: Wed, 19 Mar 2025 14:46:52 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: [tip:objtool/core 5/13] drivers/misc/lkdtm/lkdtm.o: warning:
 objtool: execute_location+0x39: skipping duplicate warning(s)
Message-ID: <202503191453.uFfxQy5R-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core
head:   73070466ed3b5e4620e03c159ee12a570b171d08
commit: 0a7fb6f07e3ad497d31ae9a2082d2cacab43d54a [5/13] objtool: Increase per-function WARN_FUNC() rate limit
config: x86_64-randconfig-007-20250319 (https://download.01.org/0day-ci/archive/20250319/202503191453.uFfxQy5R-lkp@intel.com/config)
compiler: clang version 20.1.0 (https://github.com/llvm/llvm-project 24a30daaa559829ad079f2ff7f73eb4e18095f88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503191453.uFfxQy5R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503191453.uFfxQy5R-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/misc/lkdtm/lkdtm.o: warning: objtool: execute_location+0x23: relocation to !ENDBR: .text+0x1378
   drivers/misc/lkdtm/lkdtm.o: warning: objtool: execute_location+0x2e: relocation to !ENDBR: .text+0x1370
>> drivers/misc/lkdtm/lkdtm.o: warning: objtool: execute_location+0x39: skipping duplicate warning(s)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

