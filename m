Return-Path: <linux-kernel+bounces-356100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8EF995C75
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44ED2848C7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F38F9DF;
	Wed,  9 Oct 2024 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtwvlBps"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6A36FB6
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435031; cv=none; b=A8uBmYKTTuX4QstRcTrRfqXnGDVzpAZYWfjbki2W45WoxXjbvCtteGf03XpyiQBBoxLEOz99fDojEaMoZrORb0bx9OwyQT0UOv/+F5W70+4LRZvzanh+JUFb65j1ZvMu+lNyhNQ99hygCdAFH/sFc80AJDFEvGVIeE2yI7g+lcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435031; c=relaxed/simple;
	bh=mm00jxsBdqrGj28hTnXqDIwmUJ7FSwzOATxvMfeQhb0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qXfiH7IwpnSstAia9TNLDFMtDwOEZGsfTWmZh58OJ8POQp/RNqoKw2ho/qGaZs7G/hTY0gT8/fKgWteRF3fszUgl1ww00BPPD2JykgQ1DPbJCtHIkW4XcTaSwyGpAAh4wO0LqePaVRuzgvxOyjpnF28ofb2BH2AhfsHt7Ft4Zjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtwvlBps; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728435030; x=1759971030;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mm00jxsBdqrGj28hTnXqDIwmUJ7FSwzOATxvMfeQhb0=;
  b=QtwvlBpsYGLEEUe1jW9ujlBa50RfY9lyEIeEcXCtbhVRmCM6RoNDb/kK
   RoajmdOvD5QHcvHjXgdGY9AL/i+YQHPxX7fpuznN4woerUvgVLFbZZ8aN
   IRquQSHYCNoD+R78XCPD9KnKN2nif/Q4cUzdbyaEB/XjRpgSGSL3u17gN
   jhVmakIUGWFFxiDaokhRf9iDDy89JQhn1wrt+rZSZ7jNQasPDGxE7oGZv
   7tIU2eBuBoZYG517UpjkdXk+tdzLvH0xSPCAvoODvPI0B9kDszXKAW8G1
   +1JiefjaZQnqkFmLx3EcBSs0Yw/UHQhCPhwf923ArUZbaYiJ4I9+0/b4Q
   Q==;
X-CSE-ConnectionGUID: 495Zg2X9Sjup0cLtOj5g8g==
X-CSE-MsgGUID: uqUsnYjdSAeWp52YinJDzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="30580418"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="30580418"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 17:50:28 -0700
X-CSE-ConnectionGUID: CetsU61BRDGuy6Dn2vDP8w==
X-CSE-MsgGUID: szTMG113Tuii9uF0ZiMD+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="75642702"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Oct 2024 17:50:19 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syKu8-0008YS-0U;
	Wed, 09 Oct 2024 00:50:16 +0000
Date: Wed, 9 Oct 2024 08:50:07 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arm-linux-gnueabi-ld: error: .tmp_vmlinux1.btf.o is already in final
 BE8 format
Message-ID: <202410090844.AtobmcI7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   75b607fab38d149f232f01eae5e6392b394dd659
commit: b1a9a5e04767e2a78783e19c9e55c25812ceccc3 kbuild: merge temporary vmlinux for BTF and kallsyms
date:   3 months ago
config: arm-randconfig-r062-20241009 (https://download.01.org/0day-ci/archive/20241009/202410090844.AtobmcI7-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241009/202410090844.AtobmcI7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410090844.AtobmcI7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arm-linux-gnueabi-ld: error: .tmp_vmlinux1.btf.o is already in final BE8 format
   arm-linux-gnueabi-ld: failed to merge target specific data of file .tmp_vmlinux1.btf.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

