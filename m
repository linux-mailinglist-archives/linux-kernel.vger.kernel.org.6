Return-Path: <linux-kernel+bounces-201709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A308FC20B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6375D1C22552
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7EA64CCC;
	Wed,  5 Jun 2024 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1IO6QpY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD0F4F5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717556252; cv=none; b=ZK/i5/rinXs6EUaKi17yreEqhCRoV7Wv3wKaLNiTZ+2EVYk0vALYwe4CZ70AVuG1iZl9DDe9Oc2yf3bGI+8IXbcDWeQFpZM48pElIKHD7njAZnhQGWZXl+OFr9isCWIla8T/3GC2WEw9eWEpYLYiy+PVRhAsKLjaGZm3z78bPBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717556252; c=relaxed/simple;
	bh=zqIYO9BzSN1LDae0aTBf7tpRJ8j6uIDWU51OwWoWq6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dqL19+oHT3rtS28xvUdmXA+VO6dxaLikEw7uXyxIu+IYjk4Xf5LqI3wPQ30miElgQ3SzPH+Es1FkZSfDjx6/gXSRUDoqUfjAub1w6iBQWTqI+DFXuu6QSFVWl7yMs3dv1bxxPbf5D4FyB584gS7zpWeYAoYcNkFNmvSLM6Qd7tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1IO6QpY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717556251; x=1749092251;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zqIYO9BzSN1LDae0aTBf7tpRJ8j6uIDWU51OwWoWq6Q=;
  b=b1IO6QpYI+oIFZdUr6XzAFYIxhscGVEwbUneWvaJ73QGWWJAawq1JwZT
   2wDWNAfW7somx0sqGzyrurlC+gRwy1I4i3WYBDbG3n2wzUVVS8eb2rm0D
   ICEeJnjBPwVpqeRs8Yb0Reg73Iwd2r2wCKKKS8DDGa6AmUBu6fSJXT52y
   2gPloF0CwkA8Ob8XQNSa2aELO7aFAbA3VQX6/ZzUqthmm/oGqvFHrHAR6
   Kuhl3wDNzfl101mQGn7p14bl9moXMKkyrSV11qE7pqDfeu1W56OLucMkE
   DdTQNIOdAsvVAWrK7YqpMne37S57HxLhzBec/4BYYsXcMq9N/GGQ0/Zf2
   g==;
X-CSE-ConnectionGUID: yJdku6q0Soud51EZtFmSeQ==
X-CSE-MsgGUID: yzTOoVkmSDyQtz2PS8bQHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36656334"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="36656334"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 19:57:29 -0700
X-CSE-ConnectionGUID: y5LYIWfTTJC3PAdfgLiwsQ==
X-CSE-MsgGUID: R07tjbPHS2ulXBQqilhlEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="41878495"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 04 Jun 2024 19:57:27 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEgq5-0000q5-0R;
	Wed, 05 Jun 2024 02:57:25 +0000
Date: Wed, 5 Jun 2024 10:57:14 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: riscv32-linux-ld: section .pci_fixup VMA [c24ca560,c24cce0f]
 overlaps section .bss VMA [c24ca000,c28db687]
Message-ID: <202406051002.tzOkENbg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   32f88d65f01bf6f45476d7edbe675e44fb9e1d58
commit: 54e47eade73046e860634736d2651ddc118ca694 Add Renesas PMIC RAA215300 and built-in RTC
date:   12 months ago
config: riscv-randconfig-r035-20230728 (https://download.01.org/0day-ci/archive/20240605/202406051002.tzOkENbg-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406051002.tzOkENbg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406051002.tzOkENbg-lkp@intel.com/

All errors (new ones prefixed by >>):

   riscv32-linux-ld: section .data LMA [00550000,009c697f] overlaps section .text LMA [0008ba9c,01eff1bb]
>> riscv32-linux-ld: section .pci_fixup VMA [c24ca560,c24cce0f] overlaps section .bss VMA [c24ca000,c28db687]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

