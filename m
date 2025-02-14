Return-Path: <linux-kernel+bounces-515771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E201A368BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F6E3B23A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9213F1DC99C;
	Fri, 14 Feb 2025 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+uWOWUt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F681FC7F8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739573670; cv=none; b=mqTy0BGsa3MaqWyIMU+hKkFQU4lADy1CL5EoMExSyzW81st58k32Vf6FDPrY2gW7axnBUF04bjS5KFeveTLF+zl71ULkEDHXutx+0pHxcWyRmo2NoejpRnHeOPDz9npvRSz1sRv8+A8rA2LUDnqu9a7bdan3S1VzhMZeY7sOyjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739573670; c=relaxed/simple;
	bh=mM+IHOHqX9keCb0CIsBxrydogFiJLQvXSjhg8rzPHnE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lrmNc8FpUaDSaovgpFXggGINqK2/RO8/0FripsXixQQV1LlRSadQJk20tt1TUNNXIWwyBFDpgaJdF+LfWM/p3Y3EhbeyEGN3RGvm4rsLVE9RKdv6b+I3oGdbzTIw6FwtfQWgpNj4Q4QaoE+fFr156Ztig6Kp/9YP1vGXxe44Hqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+uWOWUt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739573668; x=1771109668;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mM+IHOHqX9keCb0CIsBxrydogFiJLQvXSjhg8rzPHnE=;
  b=h+uWOWUt7OScRKhaDdRQNUJUdyGrNhjhTgFlNx/hPQEdqhUfvFRaKaS9
   VKG6qIZGZ2Eatcze+w8RXo+2TYrkjU+vwNHNlonI7wJc2/Xq20fKjT50Z
   qGpLY7urAh7Bzr9+5ErLlQs/ELcmMHo7ULGia+bOhvCe1Hv6D7UxHVwf1
   G8NIqnqgOvcyKut3f/3ItmMwafK//KGA8d8P4JDCfKGrZfY4XxCFtueOf
   26N3HwEqsKcaaCtkrWICVPG2uicGt1TQd/m50jhxcJvOLW5/+7YTMejhj
   xeTbKhRDskqgI55o1b3/9DpmKpIDIc12PFHn/JIYcbQHMxQREpnjEwir/
   w==;
X-CSE-ConnectionGUID: BZ8BRHNNQDmpFn9s+Z5HdA==
X-CSE-MsgGUID: WbP5qtw6RHmBT5Kh+1dGLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="50547918"
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="50547918"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 14:54:28 -0800
X-CSE-ConnectionGUID: 2+ItscFRQSGcufSNYCe+ew==
X-CSE-MsgGUID: 0Jo5zocQTbizTGcJxBjW2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,287,1732608000"; 
   d="scan'208";a="118684429"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 14 Feb 2025 14:54:26 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tj4Zj-001AGC-3D;
	Fri, 14 Feb 2025 22:54:23 +0000
Date: Sat, 15 Feb 2025 06:54:07 +0800
From: kernel test robot <lkp@intel.com>
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>,
	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: drivers/fpga/versal-fpga.c:78:34: warning: 'versal_fpga_of_match'
 defined but not used
Message-ID: <202502150612.mvNeaQeL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nava,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   04f41cbf03ec7221ab0b179e336f4c805ee55520
commit: 01c54e628932c655e4cd2c6ed0cc688ec6e6f96b fpga: versal-fpga: Add versal fpga manager driver
date:   3 years, 7 months ago
config: sh-randconfig-r032-20230716 (https://download.01.org/0day-ci/archive/20250215/202502150612.mvNeaQeL-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250215/202502150612.mvNeaQeL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502150612.mvNeaQeL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/fpga/versal-fpga.c:78:34: warning: 'versal_fpga_of_match' defined but not used [-Wunused-const-variable=]
      78 | static const struct of_device_id versal_fpga_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~


vim +/versal_fpga_of_match +78 drivers/fpga/versal-fpga.c

    77	
  > 78	static const struct of_device_id versal_fpga_of_match[] = {
    79		{ .compatible = "xlnx,versal-fpga", },
    80		{},
    81	};
    82	MODULE_DEVICE_TABLE(of, versal_fpga_of_match);
    83	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

