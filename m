Return-Path: <linux-kernel+bounces-223911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3DD911A69
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D52284657
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D59E12CDBE;
	Fri, 21 Jun 2024 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZZbpZ2x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887BFBF3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947950; cv=none; b=YKIeEXW8CZidyab0LzHUvlobjD5gTIambYsdl2yVm2Pzn+lMIbTXD7RkfmXThzMilrswS+3sEJH4EBqbBSJMoEvM13ZocdbKAAkplg/spdsXHYIdnnduMmyQyxeMjQUJnrONv8qPzbfjqPY9EXSK9hXDFcKAaHINMbIj34yJUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947950; c=relaxed/simple;
	bh=A2Cfg+xAAwVj9TakTKUkVW0tFfkQR+aQMfv+fqDHTvs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZwXVPqQvfs2V8AZ4oPcCBbDan1UXfZO1iJ6MfeCrvxUX2ocXbhf/nozvYax44Hu+Zc1xBc9+7N06U9TBjII0cGDpl6MyNWE0RjVb7G0oySaZIkQ+wZfy5v8OfKYBMcINGll4PG4ERujk88Y1/L+e67bywMia6aWJxxqJKku3vBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZZbpZ2x; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718947949; x=1750483949;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A2Cfg+xAAwVj9TakTKUkVW0tFfkQR+aQMfv+fqDHTvs=;
  b=mZZbpZ2x9ZWJjAnGySSIA4N3qUhrZbS/JnEy65hQbcdD3gmGFuB/HmPp
   0dN0QSnrObJnkNnLJ81YdNyF6pARxqaUEx8kq0TyJyJGNe/br/2/LVC4W
   EO2a/Xvfjf95MFipV5F2fue6ZgQ9ZBI2GaZwDYKRhiHfIIoNUPGU5AbDk
   SmCazcMyxqnB7vemLqawnbENDQ5PJHVuXQwWx/OhGkkS0SqItwiJWXcY2
   bmGGS+YXXUHUGHKt2S9rMiXUNsZ3S9qidJS6gIUbBNAtkvqySRBvSpp10
   RIYBPlbvCvw2k1xPagqLLrfhOtd0IKJx4YDFkntWvp0JUNCiH+d8Af2Ws
   w==;
X-CSE-ConnectionGUID: sEPojny7T/uGKdsw7s+jWA==
X-CSE-MsgGUID: ot0NzeQkRmaavhrgORybWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15798496"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="15798496"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 22:32:29 -0700
X-CSE-ConnectionGUID: oQux34xuQaaPYfgXs2UyBA==
X-CSE-MsgGUID: VIQwFODVSJ62QwJuNa0ylw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="43155510"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 20 Jun 2024 22:32:28 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKWsr-0008GG-1p;
	Fri, 21 Jun 2024 05:32:25 +0000
Date: Fri, 21 Jun 2024 13:31:41 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: io_uring/memmap.o: warning: objtool: unexpected relocation symbol
 type in .rela.discard.reachable
Message-ID: <202406211339.BCuCbD2g-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   50736169ecc8387247fe6a00932852ce7b057083
commit: f15ed8b4d0ce2c0831232ff85117418740f0c529 io_uring: move mapping/allocation helpers to a separate file
date:   10 weeks ago
config: loongarch-randconfig-r071-20240620 (https://download.01.org/0day-ci/archive/20240621/202406211339.BCuCbD2g-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240621/202406211339.BCuCbD2g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406211339.BCuCbD2g-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> io_uring/memmap.o: warning: objtool: unexpected relocation symbol type in .rela.discard.reachable

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

