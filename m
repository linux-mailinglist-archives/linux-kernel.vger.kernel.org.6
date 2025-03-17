Return-Path: <linux-kernel+bounces-564594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 130D3A657F1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F97A189281C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B92B19992D;
	Mon, 17 Mar 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1j8rgfE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10714198E60
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228696; cv=none; b=ucwDY34UgsvTp6Kc619R4lPLKAa4Q3hwRgdYA+ejP4XOppYxfUw6lBLJc/r7SVe2kfzKYY24HIE2yDm0mg3wyP2zpxMLMijTekTq4AfkyCcEpDuYZnAYR1mF+JJsS0PdoEPjVZVYPITu/dim8/irh1Ty4n61Lhiy+QOLEKbc/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228696; c=relaxed/simple;
	bh=yPsbtuwsa4dg18otYlvwqaOwnLR1SLPkLsQO2VYuNEA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K69FNXWzMdZ4MMWgBMZ1Z+2pVA1UEYe/m3kUm0+2BQRlX7+3hTe/e9+bri8C8Kbd7YvsmGf02OTFN2KEu6B48Q9D71WNt6ztX3BwO6/7enRnzIxoma7BnptyryNyjItRpv2hNjr2ARsOp/Yr12AZC8DsluceT3ZVc8iq2bUpt5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1j8rgfE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742228695; x=1773764695;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yPsbtuwsa4dg18otYlvwqaOwnLR1SLPkLsQO2VYuNEA=;
  b=W1j8rgfEICuPSlVj93QG24I3K9mC2Y+r1y0Vx1nKWP/q5gW9Ei6PQ5wq
   37fXETbe/ZB7UFVJxUdYQvcQR9dxtUvJqAgunrb6hyRjWc53TdZixRGmx
   dlVOQ/bA09iqWTAiNf6keRgPw4pXjbpEBzh/2gfLHKHpnSWRFf6A96wX0
   iD3D0CQCDIffx4GzOTXMWuu6mtL2PE+cN9gh9XR26IcTbBg1SnXvE9JuC
   pq67KfbuR8EGo69SA6Fee8UPQ7+dtjlQZp6ebB0Bqw79he41mPHPkUwZx
   +GE9pYJSa+F8PopV/p+W8hLw0sZbhFnzLBlc6Yx2E7/SSuUYfICzUkjtk
   Q==;
X-CSE-ConnectionGUID: RtxKO9SkS8+PI8VlN9T8KQ==
X-CSE-MsgGUID: YeSLHwKbSLGEif/Fa45qEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="53958053"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="53958053"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 09:24:54 -0700
X-CSE-ConnectionGUID: +mZsOqybREqic2ZyAMjmGw==
X-CSE-MsgGUID: qXr5u2cPTS2myOiPZTq0kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="152851450"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 17 Mar 2025 09:24:53 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuDGl-000CvN-00;
	Mon, 17 Mar 2025 16:24:51 +0000
Date: Tue, 18 Mar 2025 00:24:04 +0800
From: kernel test robot <lkp@intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: sound/soc/codecs/snd-soc-wcd934x.o: warning: objtool:
 .text.wcd934x_slim_irq_handler: unexpected end of section
Message-ID: <202503180044.oH9gyPeg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4701f33a10702d5fc577c32434eb62adde0a1ae1
commit: 9ea22713227397b56a2b36a68c8bda13f0b43d70 ASoC: codecs: wcd934x: Handle nicer probe deferral and simplify with dev_err_probe()
date:   9 months ago
config: x86_64-randconfig-102-20250317 (https://download.01.org/0day-ci/archive/20250318/202503180044.oH9gyPeg-lkp@intel.com/config)
compiler: clang version 20.1.0 (https://github.com/llvm/llvm-project 24a30daaa559829ad079f2ff7f73eb4e18095f88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250318/202503180044.oH9gyPeg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503180044.oH9gyPeg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/snd-soc-wcd934x.o: warning: objtool: .text.wcd934x_slim_irq_handler: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

