Return-Path: <linux-kernel+bounces-522165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E19A3C6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F20518965B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406C8214230;
	Wed, 19 Feb 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jm7A/8ZG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB561FECAE
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987968; cv=none; b=ULhBTNLqfVxezS0vylCS5hOv3DR5uBPLot7bCYl/SCq5C2gpOenkBfS+R9vTLjS9UQoVsu4bNY99Q4+nsEl5VzOrHYstgYm2ZvD1YPp1WQNRucxChKi8dp0/vvIvPnyllhB6lm9nboTshu5pqmKXmmKusbes/fkR0G42ZOtOERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987968; c=relaxed/simple;
	bh=dZRPlTg8UwRQsvICOzZrnxpjLEsnFkHU87BP1KT3JfA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LSUZ3nTeOPkExK2fCW/QmxPHLGRdGtdYW3hjJHeHwUqeQw3pd8BVcm2b0t/K5UM4E5fIR0mN9MKnFBzZrT9/pF8DLJCSEhpV4NyUt83h885joEisol/QEYRl4uTjNNCVvQQ1OQ+75J4p4r5cqkwKZDKmrQOBmm5g/5lc+Qt3h8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jm7A/8ZG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739987968; x=1771523968;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dZRPlTg8UwRQsvICOzZrnxpjLEsnFkHU87BP1KT3JfA=;
  b=Jm7A/8ZGBKdUBHFArEX3Z21xCuxmM4MFURailjy6z9yH8utKhd8bYZuI
   mawCjw4RZhGLDxqitxmwwFXlWgNakXquwp46WeJbHfGis53k65gKJ7lfO
   A4avjYyVg4HTGySQ+r68uIuTbenK/+dQEQ/cNxmJR5VLiywbM9eAMscbB
   1URVXSLx0IgIJMOHzDjEHSOa9JCKNqSJbR6Iobunq2Sbr1189ZSoYfMgh
   h4H13vlmTQsOKyk70mob0GIfZ0vb5D6ojGq8I7ZScP3PSh9oD4mMaDaKh
   aJwxwkHXc+Xxms0SvlmztQGTb++sdEq0KM+XaDnaJGqGxdLpNaInZJrbq
   g==;
X-CSE-ConnectionGUID: /zK7FqaCSS+ellYZ8rkCYw==
X-CSE-MsgGUID: yzCI2ShTQJ+PJ75FlyW/oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44508074"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="44508074"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:59:25 -0800
X-CSE-ConnectionGUID: bMFkRCDDQl+JuIoQya6e0A==
X-CSE-MsgGUID: 6lzyRyhlQ5KfUfVG4K+gNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119992342"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 19 Feb 2025 09:37:51 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tko12-0003FZ-0k;
	Wed, 19 Feb 2025 17:37:44 +0000
Date: Thu, 20 Feb 2025 01:37:35 +0800
From: kernel test robot <lkp@intel.com>
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: drivers/i2c/i2c-core-base.c:1420:12: warning: stack frame size
 (1040) exceeds limit (1024) in 'i2c_do_add_adapter'
Message-ID: <202502200154.kBYwSZGe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
commit: 3bfa08fe9ec8dd79e183c88e1275be74191e7bc8 Revert "i2c: Replace list-based mechanism for handling auto-detected clients"
date:   2 weeks ago
config: mips-eyeq6_defconfig (https://download.01.org/0day-ci/archive/20250220/202502200154.kBYwSZGe-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 910be4ff90d7d07bd4518ea03b85c0974672bf9c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250220/202502200154.kBYwSZGe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502200154.kBYwSZGe-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i2c/i2c-core-base.c:1420:12: warning: stack frame size (1040) exceeds limit (1024) in 'i2c_do_add_adapter' [-Wframe-larger-than]
    1420 | static int i2c_do_add_adapter(struct i2c_driver *driver,
         |            ^
   1 warning generated.


vim +/i2c_do_add_adapter +1420 drivers/i2c/i2c-core-base.c

9c1600eda42e52 drivers/i2c/i2c-core.c David Brownell 2007-05-01  1419  
69b0089a6750a0 drivers/i2c/i2c-core.c Jean Delvare   2009-12-06 @1420  static int i2c_do_add_adapter(struct i2c_driver *driver,
69b0089a6750a0 drivers/i2c/i2c-core.c Jean Delvare   2009-12-06  1421  			      struct i2c_adapter *adap)
026526f5afcd42 drivers/i2c/i2c-core.c Jean Delvare   2008-01-27  1422  {
4735c98f8447ac drivers/i2c/i2c-core.c Jean Delvare   2008-07-14  1423  	/* Detect supported devices on that bus, and instantiate them */
4735c98f8447ac drivers/i2c/i2c-core.c Jean Delvare   2008-07-14  1424  	i2c_detect(adap, driver);
4735c98f8447ac drivers/i2c/i2c-core.c Jean Delvare   2008-07-14  1425  
026526f5afcd42 drivers/i2c/i2c-core.c Jean Delvare   2008-01-27  1426  	return 0;
026526f5afcd42 drivers/i2c/i2c-core.c Jean Delvare   2008-01-27  1427  }
026526f5afcd42 drivers/i2c/i2c-core.c Jean Delvare   2008-01-27  1428  

:::::: The code at line 1420 was first introduced by commit
:::::: 69b0089a6750a0435570df3ba8456c77b352af55 i2c: Refactor for_each callbacks

:::::: TO: Jean Delvare <khali@linux-fr.org>
:::::: CC: Jean Delvare <khali@linux-fr.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

