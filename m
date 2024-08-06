Return-Path: <linux-kernel+bounces-277098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF2949C5A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7BC1C21144
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478E3176AA5;
	Tue,  6 Aug 2024 23:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WehKlM3c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118DC39FE4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722987473; cv=none; b=eQw1dDv3Ofk/hZNAMgMxRI34Tc0ifPb2+Lyy23VIRqFw1+CU+7ZSy4Sn/iZphYlG1bg4v4nlw9rUm1pUb6ezNe0DSxYfXonONDm1wf3i1VhURIOBmC/3hmJlY3IKv2E0fRWwLLCwZfK+BcZHW3jNUS0C/IPc3bfGFXrTTVatYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722987473; c=relaxed/simple;
	bh=QQem/7ix+rF/krZnyfwpRhr5WE3PESIoqQ4YBeS/Eww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtEG1mwLiUriCxeAZQIEOulP6ccNNb4P4yEcpiOOFI1+DJo6wVGNooCa3OWKTGbbZ25QBgtO3gfsaokBEvUMWGz/dc04w2ITfsBqsDZduTlK7VOw16DI1pUFRB3qjF3u2QMGiYmtRK4elE7bzKZAbmOFErUnCVt9toao3OcwTOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WehKlM3c; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722987471; x=1754523471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QQem/7ix+rF/krZnyfwpRhr5WE3PESIoqQ4YBeS/Eww=;
  b=WehKlM3cJUqHFnik5GyixUqYgPiYdlH7lXZvF8lLtfeb/9uRSHqKiwX6
   +44knamEel8Yy14QRXG6PyF5F3vhKD4k1yUMx3dJ5o8g/5UWxh2zclOpA
   qrlgtM/4W0+0l38IAVdt7RrLGfTuONnqzeIE0xIdzKOLThDWem35Hl5jT
   mfqCDKz8B64k/jjGmSfRZonJhJNh84XmGFzFcDEOo3Khxa1ZdMX2TA5Zk
   vWe50/oF8CDprN/wygNH8fjnYIIOjpZP43jmqB8MH1gzIKzgqx5lKALWN
   7Ic2K0He2q15dcuRYkVjX4++jtyfv3XF8fY5BG3BYU9K6IJJWTpdO5X6e
   A==;
X-CSE-ConnectionGUID: DY/RM7Y4R6a4WPthz297FA==
X-CSE-MsgGUID: HpmnsUPXTX+vYQWCbfQrvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="32184578"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="32184578"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 16:37:51 -0700
X-CSE-ConnectionGUID: Dr4ab4qVQOWNW6dInnPB8g==
X-CSE-MsgGUID: +XelNfyLS5Kc7TPHq7rDYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="87606859"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 06 Aug 2024 16:37:48 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbTkN-0004ui-0S;
	Tue, 06 Aug 2024 23:37:44 +0000
Date: Wed, 7 Aug 2024 07:37:11 +0800
From: kernel test robot <lkp@intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v3 1/5] i3c: mipi-i3c-hci: Add MIPI0100 ACPI ID to the
 I3C Support List
Message-ID: <202408070758.Twn4OAwy-lkp@intel.com>
References: <20240806075843.277969-2-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806075843.277969-2-Shyam-sundar.S-k@amd.com>

Hi Shyam,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc2 next-20240806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shyam-Sundar-S-K/i3c-mipi-i3c-hci-Add-MIPI0100-ACPI-ID-to-the-I3C-Support-List/20240806-165640
base:   linus/master
patch link:    https://lore.kernel.org/r/20240806075843.277969-2-Shyam-sundar.S-k%40amd.com
patch subject: [PATCH v3 1/5] i3c: mipi-i3c-hci: Add MIPI0100 ACPI ID to the I3C Support List
config: hexagon-randconfig-001-20240806 (https://download.01.org/0day-ci/archive/20240807/202408070758.Twn4OAwy-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240807/202408070758.Twn4OAwy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408070758.Twn4OAwy-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/zlib_inflate/zlib_inflate.o
>> ERROR: modpost: drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci: sizeof(struct platform_device_id)=24 is not a modulo of the size of section __mod_platform__<identifier>_device_table=56.
>> Fix definition of struct platform_device_id in mod_devicetable.h

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

