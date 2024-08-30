Return-Path: <linux-kernel+bounces-309574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26194966CF5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A2D283F10
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78ED18E35D;
	Fri, 30 Aug 2024 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVV48Rb8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FA318C033
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725061366; cv=none; b=onAYCYslEz8l6AD4pmGJPc8A9ej3NumosspunIl2UQGatcYTd3m5u9u6xrtwH7gvgS1ly+k5FAz4vq1MJs15XcU06Qro9AO5bnj8KPu25x87ao2chMXFbvAEpX7q+UKFwSNt3Yq8HK0FCJWv6G4MBndQaPzYMkr1S3Z8VramZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725061366; c=relaxed/simple;
	bh=1kfSTdoRWlVrECYNdQYmVRtHiehdc3tjOp7eh+JAOmE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mCw3CWUtZb1CeXSyiq8sosmuZAeJZ7Y9rSxWmu2FA0bhYrdObEuiz4bWneVY5ymOPkks0tTVyA1p7UxPuQHdCAg4aBYm5hLez9G9SAqn18wVRksyclnWDp3ZKpG2O2oZEMKtf6VcLSQETT4Sf9zNv5QjNJ92YlG500GezNntlsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVV48Rb8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725061364; x=1756597364;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1kfSTdoRWlVrECYNdQYmVRtHiehdc3tjOp7eh+JAOmE=;
  b=RVV48Rb8q10+2fqVq2Q1lt2gAbQvnlmCB3ci7SjNc11aV4xRwsPbzKWu
   zemIKYIAjwzc9CzG0jTncioqsE/H1HGBpu6D4Yu/ZDpzPYbj0O1jrs46R
   vPOpQ5JbTSISyFqKvft2BPj/7hdBicmeWGudvdUemK9N6hpzh/eu2n+tn
   NsDmZLE/zpBroQGl6MNNtlyvkIeoQBbIWdJg7JrCIpS84N5ixLGKiHrTm
   VA2isMBbWe7XE5zG8aolciQOr/ZtCMaVxAXK5pZRRbQJFk1rjpeYGgneo
   gO+N+VrZR6ZLMjjzXnxZPzqcJV3y15oaOfhGLf4FEdftWtzBe2SBVfvC+
   Q==;
X-CSE-ConnectionGUID: jaCcPNieTJCLHPD7H2D5XQ==
X-CSE-MsgGUID: yvCeUkJlTVevf0f5E+zoIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23601169"
X-IronPort-AV: E=Sophos;i="6.10,190,1719903600"; 
   d="scan'208";a="23601169"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 16:42:43 -0700
X-CSE-ConnectionGUID: or9RUdvEQgCmP/BDwvc0Vw==
X-CSE-MsgGUID: ENRpUN54TNmztgzEf6nXoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,190,1719903600"; 
   d="scan'208";a="68446162"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 30 Aug 2024 16:42:41 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skBGJ-0002DI-2w;
	Fri, 30 Aug 2024 23:42:39 +0000
Date: Sat, 31 Aug 2024 07:42:38 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: error: ABI 'o32' is not supported on CPU 'mips64'
Message-ID: <202408310705.y2OPq3Xs-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fb24560f31f9dff2c97707cfed6029bfebebaf1c
commit: 2326c8f2022636a1e47402ffd09a3b28f737275f MIPS: Fix fallback march for SB1
date:   7 weeks ago
config: mips-randconfig-r121-20240830 (https://download.01.org/0day-ci/archive/20240831/202408310705.y2OPq3Xs-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20240831/202408310705.y2OPq3Xs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310705.y2OPq3Xs-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: ABI 'o32' is not supported on CPU 'mips64'
>> error: error: ABI 'o32' is not supported on CPU 'mips64'
   ABI 'o32' is not supported on CPU 'mips64'
   make[3]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offsets.s] Error 1
   make[3]: *** [scripts/Makefile.build:244: scripts/mod/empty.o] Error 1
   make[3]: Target 'scripts/mod/' not remade because of errors.
   make[2]: *** [Makefile:1207: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

