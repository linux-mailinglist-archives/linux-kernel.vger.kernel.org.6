Return-Path: <linux-kernel+bounces-249618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB6E92EDE7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D18928112C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEF316D9DE;
	Thu, 11 Jul 2024 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jw5cLUDZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BCA16C852
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719339; cv=none; b=qfR2BrrheK6iU9k3KkB68/HpmrdJuIXttD9S8F+D5YEfoOXOSqtDJJ75+4nBx7ta9JdRskCG01Bugjr4ib1yfDYoZ5yffMfH0cpH9dFYMZ7yheRv0xk+NEXM14bxc1YK12iFz1nNXI66Q3t00LiSElgtg9hCIThRJWzSejh39nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719339; c=relaxed/simple;
	bh=R5km20ASh4eaKlWT6/715jDhOrK6keRoOMzJVdyXJQY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b5/AaiMbjxudYD9Gi4VHS61pCqDNoF4IGSB1qVquBhjvXpOntHVU5t+X5a1ZNlmTCH+D7ZptjxVdpvTy/kZvKrsDAhzcXO25HYsF2zGNMlvXn4/rEkLbLkBBfpgFNzeqzAiQemOstp9bcBJTpRDQNzpnqojYSV22Q2fvrXo41yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jw5cLUDZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720719337; x=1752255337;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=R5km20ASh4eaKlWT6/715jDhOrK6keRoOMzJVdyXJQY=;
  b=Jw5cLUDZ7aJUyzPH9D7reto2i8f6apDoAlVtnvxY80TLKOLmY6cnv/y7
   RmcRSk5t7qSALoOxBEjVemieFw7Xp6odQArSXGRDXfDlw3XUm+N5RWhmH
   FqZthPJ8V8iZQ2FYIBgwbp1DL3SplI/eveu3kUCB+4PofnGSIQMebBlLe
   uKPjqmW8WDarui9CDWnUn/4TyIUtuPFmnZvaCrn8jw4Bue2h5jlki1Hft
   7fuBHCMAhyXzzPOlPyuDz6jytfAtz5chVoZON7JyxCvCToK1GdrXw0NsM
   QNNloKY9+d3wJ7iiHMcJY7rNaPkHt0CY+nScSEzcO4lqWh2Z8nz+oI7aR
   A==;
X-CSE-ConnectionGUID: uB+Bp8c2TDWYix2BoGWlVQ==
X-CSE-MsgGUID: xngH4l4KSwydJgVF0VuPnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18077382"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="18077382"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 10:35:37 -0700
X-CSE-ConnectionGUID: c2tAOJTcR/CTm8c21bMSeQ==
X-CSE-MsgGUID: vTK45dQXSW+nogg7DM45qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48613152"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 11 Jul 2024 10:35:37 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRxhd-000ZaG-1q;
	Thu, 11 Jul 2024 17:35:33 +0000
Date: Fri, 12 Jul 2024 01:34:39 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko]
 undefined!
Message-ID: <202407120131.drjdyGUX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d9a2f29aefdadc86e450308ff056017a209c755
commit: f73edc8951b2de515b5ecc8a357ccd47dd41077e kbuild: unify two modpost invocations
date:   1 year, 9 months ago
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240712/202407120131.drjdyGUX-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240712/202407120131.drjdyGUX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407120131.drjdyGUX-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

