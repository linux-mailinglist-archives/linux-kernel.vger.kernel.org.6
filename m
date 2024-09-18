Return-Path: <linux-kernel+bounces-332786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA0A97BECC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E308F283AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D6E1C8FD5;
	Wed, 18 Sep 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gymn8Yzq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A692AEEE
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726674211; cv=none; b=tsvHOypyPVYw01O+zaoInrO8e9AQ8xbgFuPfgNifjTuEUmKEtPRuATdcoyGBLv3Ive3BkuSNwIaL77qTqByVCdVzleqFX/64X6bI9h/Rw6mgzcML+8Xj/cgZwiZyYcrvtIEBJ0Oc5h0dlMwkCiOlKo/uncqpzNaKneiA5HNHiZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726674211; c=relaxed/simple;
	bh=JsYZxeqDG/j9PTSN8ABjMQde+hbWnWEbazUsZX2LCWM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HK0DbPPADAyhl/94WciZMxnmBrIbIj1dU6zhUDfRw00KzB5DatMkqu++Dc9aLKwE8HxW7WZS5897S+lalhC7V1QwFY3pM9JbhWCm3p25H0uq0kzEPFDvm1f2Da1lFu3MARrs8iomQ4QKibLU66kGt2zYy0k+a4Faxyb0Mm6nAzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gymn8Yzq; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726674209; x=1758210209;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JsYZxeqDG/j9PTSN8ABjMQde+hbWnWEbazUsZX2LCWM=;
  b=gymn8YzqDC/VOy1QGaFwq5i0q+oochun4I3tnp3yJBbnrZ5mI9myDBvQ
   oj990RyikBqvQ9tQoi8IxVzkMSgQRmIyxt0rZI2NQ2uF142TkcM6U1rCR
   46iIyDyzxXo1Y2oUFOtbTlFyjwb9iJyU4NpNbfaxobt9NXyFGPooU6Lz6
   6sQfhRFghxuUrjiKbAp7/aF4rIcoM2LpsRe9BC9IF43wdJJTmGy6d7vKL
   DmrVh+sC0fi1zb1eVkeKLvIsNeAVpWUYVLvE9cEfb5Ko+eEZrye7cGZnp
   JyRto+BwgxM9Yd9U2oFhtOtbPqG82vT7fgMgSs3cM23cutcIY3TdH8dXI
   w==;
X-CSE-ConnectionGUID: T0pnnii2SCidldcCj8X3tQ==
X-CSE-MsgGUID: srRXvUg+SaS9OmJ7bWlPUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25754381"
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="25754381"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 08:43:29 -0700
X-CSE-ConnectionGUID: ZymnFBovT0OLnyiTppP0Qg==
X-CSE-MsgGUID: 6lGcDi6TTzGcYL5pXenG3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="74417104"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 18 Sep 2024 08:43:27 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqwpw-000CMI-22;
	Wed, 18 Sep 2024 15:43:24 +0000
Date: Wed, 18 Sep 2024 23:42:55 +0800
From: kernel test robot <lkp@intel.com>
To: Jakob Koschel <jkl820.git@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: ld.lld: warning:
 src/consumer/drivers/usb/gadget/udc/max3420_udc.c:842:0: stack frame size
 (13496) exceeds limit (8192) in function 'max3420_thread'
Message-ID: <202409182344.5DqYmhyx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f39757957c11677ceb4600c81888db12b2fef5d
commit: 349fde599db65d4827820ef6553e3f9ee75b8c7c arch: enable HAS_LTO_CLANG with KASAN and KCOV
date:   1 year, 1 month ago
config: x86_64-randconfig-102-20240917 (https://download.01.org/0day-ci/archive/20240918/202409182344.5DqYmhyx-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240918/202409182344.5DqYmhyx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409182344.5DqYmhyx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ld.lld: warning: src/consumer/drivers/usb/gadget/udc/max3420_udc.c:842:0: stack frame size (13496) exceeds limit (8192) in function 'max3420_thread'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

