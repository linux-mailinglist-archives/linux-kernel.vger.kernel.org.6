Return-Path: <linux-kernel+bounces-285513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7903E950E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FCA1C22144
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B631D1A76A0;
	Tue, 13 Aug 2024 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgZoPn3C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9E1A7064
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583263; cv=none; b=tEUQKgs3pTJqJZl3c14pEXfqtYZrPYgbC3ZWoSzkCo7PrYQ0yd3macMI/4ep7N1SU48VE6kGIg4s6eCoMW7Is81k7b+DMEd7F8vfdfGMbln486REOr2TuSBbWKIvmT6ai4QXehX0cXHC/2iHROW1JqJmyVwLtO0HW0eklct23No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583263; c=relaxed/simple;
	bh=wii20uAFwA0Hva9CAlMTdYHq43WPKMRZX481oCB0G/w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mQiIuzr7lolCWJ7DLG8/d2gCwD9ouUNuceDqt0ZQ6hoUVjUyo0+f8xk0QCBqaaI5HXRFum8js7+Po8spnJlIOM62tzR9MZod3xG/IGRUKsRCUEaJiYw5MAQJJpq0cF4bQbZyDKG3DMORaJ9eHHoTHHPhU7GxTMZ8XV36AqJ9CAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgZoPn3C; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723583262; x=1755119262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wii20uAFwA0Hva9CAlMTdYHq43WPKMRZX481oCB0G/w=;
  b=fgZoPn3CmD1J4taGZ+T9rVg8J6ratfuI7wfsPppsx65D3ORxDxcxnXJ/
   vzQ8g3cHeyxjS5On4IpTONoDImszynE/mSAhmX/hg3HRvGsZ0Fk3BxqyA
   EhI1v2+BY2SfmNDxrmH2HCvxSobaOez4poVGaj95LiDlJoAknCzo2HaU6
   BW1xanYt2vp5ezzP5PVZChNJ0f5DU14jP+yH9tEPYmvNpfBttdgN2pJom
   dQSTgsxDJtkZ8PWR6nRrI+12WHf88gYaX8mtloCKR8uE9fZIdVX4keOak
   7lvKOkxH7zwKHEUUqhjGrtgfSVHGuDf+KSJtkyOXoLol2EcYQGRRyEV1Z
   w==;
X-CSE-ConnectionGUID: UQLhD7bmQn2pSWMFM6KbVw==
X-CSE-MsgGUID: jbQ9DWOsQzisvpcstLazDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21641006"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21641006"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:07:41 -0700
X-CSE-ConnectionGUID: TbxdHviIQEytEZK0jFAYHQ==
X-CSE-MsgGUID: OjllNDUTSPChxyanK95NPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58747990"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 13 Aug 2024 14:07:39 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdyjx-0000jI-02;
	Tue, 13 Aug 2024 21:07:37 +0000
Date: Wed, 14 Aug 2024 05:07:13 +0800
From: kernel test robot <lkp@intel.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: arch/mips/boot/dts/mobileye/eyeq6h-epm6.dtb: /: failed to match any
 schema with compatible: ['mobileye,eyeq6-epm6', 'mobileye,eyeq6']
Message-ID: <202408140537.DgUJFGmH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6b4aa469f04999c3f244515fa7491b4d093c5167
commit: fbe0fae601b780622fcb7034a479fa161645b9f4 MIPS: mobileye: Add EyeQ6H support
date:   9 weeks ago
config: mips-randconfig-051-20240814 (https://download.01.org/0day-ci/archive/20240814/202408140537.DgUJFGmH-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
dtschema version: 2024.6.dev10+ge5d88ac
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240814/202408140537.DgUJFGmH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408140537.DgUJFGmH-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/mips/boot/dts/mobileye/eyeq6h-epm6.dtb: /: failed to match any schema with compatible: ['mobileye,eyeq6-epm6', 'mobileye,eyeq6']
>> arch/mips/boot/dts/mobileye/eyeq6h-epm6.dtb: /: failed to match any schema with compatible: ['mobileye,eyeq6-epm6', 'mobileye,eyeq6']

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

