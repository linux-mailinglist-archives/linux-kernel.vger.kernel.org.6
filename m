Return-Path: <linux-kernel+bounces-539920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CD8A4AAE1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310271896528
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E531DE4F6;
	Sat,  1 Mar 2025 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hb559znq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638391D7E3E
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740831467; cv=none; b=sCCv5CQhSpksa7vzku74u2W4NU7ZMzBqJrDzgkMlBDQVmFaI/lnAvlxTcQp6g9ckmJlXm/BMXs6jdohTvpTX8saOTUBlsb0TSwm/6QWnrORNeBs0wD+S+dEos/g6UCX6k0KcUxIzWzvDcTHoUvqCpoHHeN9AMdOPVAUzgxpeJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740831467; c=relaxed/simple;
	bh=i1lk9xKe/JXz4c6AB/M8fEa5DbGBkJjeN3ZRRa0J1/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o03SJg7odVILEGwbzjtYNc/mIr2CA7aPF/7CJDPBe1wtAw/fR+HHg3Gh3KrJpdbYYxkyvUmSfrUWhmR6UmuoyzvwKzA21Lz1iVbAy+wTJ4JFTiU4rqjQmgeZbpgG3aWtdgiXLd10YebxhktRkF8UNPuDk4MYoIrASadga3e4q98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hb559znq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740831464; x=1772367464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i1lk9xKe/JXz4c6AB/M8fEa5DbGBkJjeN3ZRRa0J1/8=;
  b=Hb559znqEF4qF0I9UVp/1Nw/gkp04XN6v2hIlkkTSEc/BcA0MVfwvzSY
   +nomLMxeUE1WcDMJAcAUhty8n8Tp0YrMndddO1O/hWLMzRAAmoWmLfvpT
   onNafvj/RiAY2Siq9MWTwiIv8xOZvR6qkBKpKJCjH12Sv7xB5Yncc0qpQ
   2RjYAgCOm+AOkTk0H4Jn0F8sgWjtZ2oMgQlHKt1lbqoLiZChUpdUNkPDu
   OIfsL+bp5ONw5yRalLEn+Ro+5qZoOYzLZFNfpVVXUlFVZDxWqcGIDM199
   x0HecLIavmE8bR7PXpe+4QwKqbEnt31P7qIGpM+p6hU8u2xt+z2wzvZPd
   w==;
X-CSE-ConnectionGUID: ijXG08qBTnqJSOuKZdlwmA==
X-CSE-MsgGUID: T4s7ZwE3T36Rgmb0h/0t6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45537168"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="45537168"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 04:17:44 -0800
X-CSE-ConnectionGUID: nC1fbvG+Qoa80CvOsJCgNA==
X-CSE-MsgGUID: 6I3/OGJFQb2QAeAFikkCNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="122574664"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 01 Mar 2025 04:17:43 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toLmh-000GEM-0H;
	Sat, 01 Mar 2025 12:17:36 +0000
Date: Sat, 1 Mar 2025 20:17:02 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: arch/powerpc/boot/decompress.c:132:15: error: implicit declaration
 of function '__decompress'
Message-ID: <202503012033.HCudrbsD-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   03d38806a902b36bf364cae8de6f1183c0a35a67
commit: 45cfade303335c486300b81e62caefffa843f585 drm/xe/xe2: fix 64-bit division in pte_update_size
date:   12 months ago
config: powerpc-randconfig-r132-20250301 (https://download.01.org/0day-ci/archive/20250301/202503012033.HCudrbsD-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250301/202503012033.HCudrbsD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503012033.HCudrbsD-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/boot/decompress.c: In function 'partial_decompress':
>> arch/powerpc/boot/decompress.c:132:15: error: implicit declaration of function '__decompress' [-Wimplicit-function-declaration]
     132 |         ret = __decompress(inbuf, input_size, NULL, flush, outbuf,
         |               ^~~~~~~~~~~~


vim +/__decompress +132 arch/powerpc/boot/decompress.c

1b7898ee276b39e Oliver O'Halloran 2016-09-22   97  
1b7898ee276b39e Oliver O'Halloran 2016-09-22   98  /**
1b7898ee276b39e Oliver O'Halloran 2016-09-22   99   * partial_decompress - decompresses part or all of a compressed buffer
1b7898ee276b39e Oliver O'Halloran 2016-09-22  100   * @inbuf:       input buffer
1b7898ee276b39e Oliver O'Halloran 2016-09-22  101   * @input_size:  length of the input buffer
930a77c3ad79c30 Zhang Jianhua     2021-05-10  102   * @outbuf:      output buffer
930a77c3ad79c30 Zhang Jianhua     2021-05-10  103   * @output_size: length of the output buffer
1b7898ee276b39e Oliver O'Halloran 2016-09-22  104   * @skip         number of output bytes to ignore
1b7898ee276b39e Oliver O'Halloran 2016-09-22  105   *
1b7898ee276b39e Oliver O'Halloran 2016-09-22  106   * This function takes compressed data from inbuf, decompresses and write it to
1b7898ee276b39e Oliver O'Halloran 2016-09-22  107   * outbuf. Once output_size bytes are written to the output buffer, or the
1b7898ee276b39e Oliver O'Halloran 2016-09-22  108   * stream is exhausted the function will return the number of bytes that were
1b7898ee276b39e Oliver O'Halloran 2016-09-22  109   * decompressed. Otherwise it will return whatever error code the decompressor
1b7898ee276b39e Oliver O'Halloran 2016-09-22  110   * reported (NB: This is specific to each decompressor type).
1b7898ee276b39e Oliver O'Halloran 2016-09-22  111   *
1b7898ee276b39e Oliver O'Halloran 2016-09-22  112   * The skip functionality is mainly there so the program and discover
1b7898ee276b39e Oliver O'Halloran 2016-09-22  113   * the size of the compressed image so that it can ask firmware (if present)
1b7898ee276b39e Oliver O'Halloran 2016-09-22  114   * for an appropriately sized buffer.
1b7898ee276b39e Oliver O'Halloran 2016-09-22  115   */
1b7898ee276b39e Oliver O'Halloran 2016-09-22  116  long partial_decompress(void *inbuf, unsigned long input_size,
1b7898ee276b39e Oliver O'Halloran 2016-09-22  117  	void *outbuf, unsigned long output_size, unsigned long _skip)
1b7898ee276b39e Oliver O'Halloran 2016-09-22  118  {
1b7898ee276b39e Oliver O'Halloran 2016-09-22  119  	int ret;
1b7898ee276b39e Oliver O'Halloran 2016-09-22  120  
1b7898ee276b39e Oliver O'Halloran 2016-09-22  121  	/*
1b7898ee276b39e Oliver O'Halloran 2016-09-22  122  	 * The skipped bytes needs to be included in the size of data we want
1b7898ee276b39e Oliver O'Halloran 2016-09-22  123  	 * to decompress.
1b7898ee276b39e Oliver O'Halloran 2016-09-22  124  	 */
1b7898ee276b39e Oliver O'Halloran 2016-09-22  125  	output_size += _skip;
1b7898ee276b39e Oliver O'Halloran 2016-09-22  126  
1b7898ee276b39e Oliver O'Halloran 2016-09-22  127  	decompressed_bytes = 0;
1b7898ee276b39e Oliver O'Halloran 2016-09-22  128  	output_buffer = outbuf;
1b7898ee276b39e Oliver O'Halloran 2016-09-22  129  	limit = output_size;
1b7898ee276b39e Oliver O'Halloran 2016-09-22  130  	skip = _skip;
1b7898ee276b39e Oliver O'Halloran 2016-09-22  131  
1b7898ee276b39e Oliver O'Halloran 2016-09-22 @132  	ret = __decompress(inbuf, input_size, NULL, flush, outbuf,

:::::: The code at line 132 was first introduced by commit
:::::: 1b7898ee276b39e54d870dc4ef3374f663d0b426 powerpc/boot: Use the pre-boot decompression API

:::::: TO: Oliver O'Halloran <oohall@gmail.com>
:::::: CC: Michael Ellerman <mpe@ellerman.id.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

