Return-Path: <linux-kernel+bounces-394327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B320B9BAD75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 08:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8331F22027
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668F51957F9;
	Mon,  4 Nov 2024 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnhUCgBa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB918C028
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730706776; cv=none; b=UT4d33hoDL01p8LTkT4OHOsk5rM4vqv2ZiJHPB2tvoeZprmXM+Cj2oncMZpAAIXRjio+TrnG+6aCXzye6fpRTpaAANiAT0Cpbcjegw1xjdtCCLdQbbzpzLe0bCfM/enYh7fWBrfLqu2nqxe1xWLDA8JMRET19AV35Xy716Hy9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730706776; c=relaxed/simple;
	bh=Cr5rD/+HY6vt+VKE7z+vw3XsU9RSd9ssfzNDIHXaWuc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JKEfLkDzh+PkBP6ildMioPW/DkXsv4v9JKlKFBbfmck+5Yo8epQ9qde+Zs11Y9hOz/6aRBT4oCPorbUhcp6vsI9LhcpVykktCloStvg7t4PHKuokYf1wm86lShDpC/WRvRfnQk6OGRLU/w7/UVfs9SVCVOQhbkKw4R0pR0+1hn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnhUCgBa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730706775; x=1762242775;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cr5rD/+HY6vt+VKE7z+vw3XsU9RSd9ssfzNDIHXaWuc=;
  b=RnhUCgBaYMT2CdVPIHlLDU5up/m8V38BHISvDeHlYAtKU18KYDmQgAoI
   w6+B0+q/v0F/ZrI87gfohwRcqp+053xh0rRg88HkVrOHO50JM7fqFxFrT
   hmUXyYQ5fgE1pADXXx13nxYwYi+7ZNJkMz4ueR39RoqAnCNN0yms0pcHz
   vzigFJE1BPdNXcXsCqBvSAWkVi5/UBQVdtpEe1aMWLhUqsK7VzyFi5Dg4
   1IahPOYH7VseJo+wTaYJX6SWOMFEBEUSh1qSBZLhvuz+Sb5XKkWUCuiaR
   77k6kqup4AzVaNzVu1QRdOqNAgvjPVTvjMvPDhYvyeDxURK6U9K1/aSWm
   Q==;
X-CSE-ConnectionGUID: fhfdAPGBRSGlWqnO22/1Mw==
X-CSE-MsgGUID: AFH64InAR+ytQvGghLoVlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="18008673"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="18008673"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 23:52:55 -0800
X-CSE-ConnectionGUID: 05JlAmOVR9SrmL/j9sP+ag==
X-CSE-MsgGUID: Ksd2yd7CTsOlcvbb9g7CKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="84387287"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 03 Nov 2024 23:52:53 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7rtL-000kcL-1A;
	Mon, 04 Nov 2024 07:52:51 +0000
Date: Mon, 4 Nov 2024 15:52:40 +0800
From: kernel test robot <lkp@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: arch/m68k/sun3/sun3ints.c:33:13: sparse: sparse: cast truncates bits
 from constant value (ffffff7f becomes 7f)
Message-ID: <202411041551.CCTg5fsi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   59b723cd2adbac2a34fc8e12c74ae26ae45bf230
commit: 72e70a0e7ac7c422843eb8bbf192e820e9ccd24d m68k: sun3: Change led_pattern[] to unsigned char
date:   1 year, 1 month ago
config: m68k-randconfig-r112-20241104 (https://download.01.org/0day-ci/archive/20241104/202411041551.CCTg5fsi-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241104/202411041551.CCTg5fsi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411041551.CCTg5fsi-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/m68k/sun3/sun3ints.c:33:13: sparse: sparse: cast truncates bits from constant value (ffffff7f becomes 7f)

vim +33 arch/m68k/sun3/sun3ints.c

    31	
    32	static unsigned char led_pattern[8] = {
  > 33		(u8)~(0x80), (u8)~(0x01),
    34		(u8)~(0x40), (u8)~(0x02),
    35		(u8)~(0x20), (u8)~(0x04),
    36		(u8)~(0x10), (u8)~(0x08)
    37	};
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

