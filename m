Return-Path: <linux-kernel+bounces-264656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A7493E6C4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 17:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24099281BB5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C781140369;
	Sun, 28 Jul 2024 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZWQWIA2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996B978C83
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722181632; cv=none; b=JekFcvrcEm6ZALpgXZ61+VBXOrBh0OGPsvOsegsmFbwLQjyq1Pd4q+uyDMZb755sCeugKupP7OPs7nhMdZVaMKj2gnUBjdwuq7WFvVO1MzYkHsgJWcWj//XXncLfqMdqOCGtnugoLmR2C0g9N009QPioCF5QnJjJkzzhkONi0Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722181632; c=relaxed/simple;
	bh=jg9TuuMt2qdO/frE72GsxGgRR6DhfDVw1Nc/K1dVGTE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KPimLtCYm7scoHjK5k6dXfmdt+Wm+VkUpSQ/NJqp23STVYokMQ6M7uOq0AtWb+qezZvkgShgqSyOHRpBToTdNDP32DtIuHVyekj79SeTDeSAKUgr4njS8C9vna3hxt9Bwpv5ijsRNJLl1d676+5UlAfYqxtkkFOGOCeEKSfWl0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZWQWIA2; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722181630; x=1753717630;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jg9TuuMt2qdO/frE72GsxGgRR6DhfDVw1Nc/K1dVGTE=;
  b=HZWQWIA2G145R+JthR3O8ZZSmADu7UuIvsUguavP2NoFcqsTPpZ/UaFF
   lnqLtdJSjfSB4IvFC6PGFo4vJnB8VwrwQGvhbpr8TONQSw4CnsqVljTQR
   h1guJTnbNz0nD42fcov+cGeJOcmA7g+a1dLuWgCtbJi98qYwNmg7umWft
   2XTf9Ktg3bmkRbymsQbXRRbeexwA1WTEhntz78bBli/3ZOvZLs/WsQ2Lx
   iy8Xm4IZkhggXj97QdAU08v74idq115GJkSdqZxazEORS0k6LsVeQoBxh
   WGxKtRpKNxP7qIg+ksdZVTch9z3Hc6J6owmR6zx2G4J/fg3cgJXUJlS0O
   A==;
X-CSE-ConnectionGUID: /GMc8M5lSVqWujss8zqHyw==
X-CSE-MsgGUID: /dOleHBbSY20yUc2c8HPOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="42447346"
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="42447346"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 08:47:10 -0700
X-CSE-ConnectionGUID: s7JnBuJtTKeWidR/pQSuEg==
X-CSE-MsgGUID: OoqXKrZHS8eQ4PfGHrLznQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="54321294"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 28 Jul 2024 08:47:09 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sY670-000qvO-1G;
	Sun, 28 Jul 2024 15:47:06 +0000
Date: Sun, 28 Jul 2024 23:46:27 +0800
From: kernel test robot <lkp@intel.com>
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/dma-buf/udmabuf.o: warning: objtool:
 get_sg_table.isra.0+0x94: unreachable instruction
Message-ID: <202407282344.RDPzYUGa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5437f30d3458ad36e83ab96088d490ebfee844d8
commit: 0c8b91ef5100eaed3d64123ac91ac4739fccf15c udmabuf: add back support for mapping hugetlb pages
date:   2 weeks ago
config: loongarch-randconfig-r121-20240728 (https://download.01.org/0day-ci/archive/20240728/202407282344.RDPzYUGa-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240728/202407282344.RDPzYUGa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407282344.RDPzYUGa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/dma-buf/udmabuf.o: warning: objtool: get_sg_table.isra.0+0x94: unreachable instruction


objdump-func vmlinux.o get_sg_table.isra.0:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

