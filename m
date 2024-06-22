Return-Path: <linux-kernel+bounces-225576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A8A913278
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 09:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BA128558B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 07:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920E314B08A;
	Sat, 22 Jun 2024 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eCh9abAg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB814B082
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719040300; cv=none; b=HBrOMMPv5JRg1M7HlPlnDjGbsUsCPhl5xOxPqJFaV7Io2XuLDWtw86KhU73c5M3AohBWviV/UUjvl5Zfzu6bjekmvjH73hsd+iOVwBQj6Igbjb0A65Dlj3adbOLlCb7QzzL7waaT7I02xfa+cBe/g7C77xp285e9fI3+F+Wtz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719040300; c=relaxed/simple;
	bh=HfdP8M2Yy1b9t3WGreJdoMw0tqG70VVoLXdOEk9RgZE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dY/sIYL/j8MUXYl9p8LY2iCV2u6m3Pdxc99RwPKx2eTvaEpdsnrrng5qzBJ7GDyVd570a0V5tTfOPJgShQHvNAMZ5rPhajf20k3ZFVl5sWdJxlNRGG6X8DVFU7YiMIgJOAjuYuFgqsS6FswCd056jDu/JfxTkWmSOb57G/uUWWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eCh9abAg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719040299; x=1750576299;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HfdP8M2Yy1b9t3WGreJdoMw0tqG70VVoLXdOEk9RgZE=;
  b=eCh9abAg/Utq8rFeh8FHXLjXb54+Z65dYOAjWmYvKFf8ZEfu81wADh+r
   5w6Z0/6Ktu8XXFyLJDcyQkOrjrqrh+jRUko5t8ha23zm14WQ7tPk9LBoX
   5JRyMeo4w85rhT9g/nfUFf3Iy/fvoNws+80iMhc1kMH0BjZ/8gqIxOrpE
   SmEzFu+CvnhwGac9YwPUZ54/Zh48mHOJ41Ndot4Op0jjUBCZCNYs18uLg
   wx3MeIFOZnZVancKZw3rHlj56yjso29Op3Y5BBUDDs6sD6ujGHCF1zJxs
   Nds8Hd5odZ5anOxZkmQLVatQmbQuz7roY/94f1uT7EWaVElZJl8udpjio
   A==;
X-CSE-ConnectionGUID: +MtGzJktQMa9Huqi5WykNg==
X-CSE-MsgGUID: ilJucYGaQFOhs3csFL9nkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="33539732"
X-IronPort-AV: E=Sophos;i="6.08,257,1712646000"; 
   d="scan'208";a="33539732"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 00:11:39 -0700
X-CSE-ConnectionGUID: ILPTNDFKTZyl14Q2IM3toA==
X-CSE-MsgGUID: lKNiu3w9QQCJfjFRKNgt7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,257,1712646000"; 
   d="scan'208";a="43480035"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 22 Jun 2024 00:11:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKuuN-0009Pg-19;
	Sat, 22 Jun 2024 07:11:35 +0000
Date: Sat, 22 Jun 2024 15:11:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: /tmp/ccmuxLwh.s:31: Error: invalid literal constant: pool needs to
 be closer
Message-ID: <202406221517.AGf9p3H9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   35bb670d65fc0f80c62383ab4f2544cec85ac57a
commit: 7582b7be16d0ba90e3dbd9575a730cabd9eb852a kprobes: remove dependency on CONFIG_MODULES
date:   6 weeks ago
config: arm-randconfig-r132-20240622 (https://download.01.org/0day-ci/archive/20240622/202406221517.AGf9p3H9-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240622/202406221517.AGf9p3H9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406221517.AGf9p3H9-lkp@intel.com/

All errors (new ones prefixed by >>):

   /tmp/ccmuxLwh.s: Assembler messages:
>> /tmp/ccmuxLwh.s:31: Error: invalid literal constant: pool needs to be closer

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

