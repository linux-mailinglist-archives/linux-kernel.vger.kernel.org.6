Return-Path: <linux-kernel+bounces-282436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 998F694E3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 01:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EE31C211AA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 23:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B141684AB;
	Sun, 11 Aug 2024 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Se6Cpl03"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58D715F40D
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723419765; cv=none; b=Dvlf1t4CrfcHtPGpqR4hTsUd+9EM4GT6bVdUOkbCmkhOYXQx/uPCRTomVhHEFhY2StNXg6oRpfybyAnSK606l6LuGvK2n5uC1/VuBWHKyP56mTBTdJwOSGpfjg0LhOxaWEDz801+H0J8101Uul+/kawIU7NozLG0iX9wgz1npRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723419765; c=relaxed/simple;
	bh=hG1ou3WZ+E+K41+gejcSwTaX02Z4Ywk4qL7VEAzh/CU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VaiB6YUtYHoDDmD+od+hovgKMejqcsRqoUd3WIBv67Ll97/pJQFUpFoSEIzJrSPA1prenA1o/pSTeJb6XFuwIOPF5nlByxs9kp+9eqpDVuFqhH6EEvJxlCGxaVhY9X3gzc+528ZKnhQRoP6uxSZe4kTDp5xl5uuLxjEGvy++xuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Se6Cpl03; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723419764; x=1754955764;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hG1ou3WZ+E+K41+gejcSwTaX02Z4Ywk4qL7VEAzh/CU=;
  b=Se6Cpl0313YoxCVuIeHgP6h/2GpRMq+NuLMZmz3bIEaeRTaEArSDBJKT
   2olVxOeN9ovBd4XvkVCL/xsbggCwGWU74nWxzs7xIYS2t5Up+HcCYDttW
   qS9rdGLvy7Bpy+X5C4malyEcShMkT8tIyP6ZXCMslV0oa48sdCe0eNy1/
   ugqZHkqA7e9EpfIKEV+gx8yYb4MqAhNyzREhxzO/+mytH6aF7zDUMjDlo
   n2tJnc7NfThvaQn3Z/XcDDML5+btOx54oY3yG9jJVWXFT4b/OM0/EY8d9
   5jJAZUR8mI2/YCTKq4tQmoku5Us8vxp9PFCG085my9FG7XGENsbEr9wZp
   Q==;
X-CSE-ConnectionGUID: kHpNVQK1TsaJn3SrE5mhlg==
X-CSE-MsgGUID: HoKStQT5S4SOGo2oha3H/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21171561"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21171561"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2024 16:42:43 -0700
X-CSE-ConnectionGUID: +yy6E/3fTl+pU4AD1qbG2A==
X-CSE-MsgGUID: h3dO9rr0TaGRiQ0+t7skjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58653284"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 11 Aug 2024 16:42:42 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdICo-000BED-3A;
	Sun, 11 Aug 2024 23:42:35 +0000
Date: Mon, 12 Aug 2024 07:41:59 +0800
From: kernel test robot <lkp@intel.com>
To: =?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Subject: WARNING: modpost: vmlinux (__llvm_covfun): unexpected
 non-allocatable section.
Message-ID: <202408120748.AOYnYuYz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5189dafa4cf950e675f02ee04b577dfbbad0d9b1
commit: 32a84cfc6caf830431375c5182391284986d4066 arch: um: Add Clang coverage support
date:   7 months ago
config: um-randconfig-r133-20240809 (https://download.01.org/0day-ci/archive/20240812/202408120748.AOYnYuYz-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f86594788ce93b696675c94f54016d27a6c21d18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240812/202408120748.AOYnYuYz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408120748.AOYnYuYz-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
>> WARNING: modpost: vmlinux (__llvm_covfun): unexpected non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.
--
>> WARNING: modpost: vmlinux (__llvm_covfun): unexpected non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.
--
>> WARNING: modpost: vmlinux (__llvm_covmap): unexpected non-allocatable section.
Did you forget to use "ax"/"aw" in a .S file?
Note that for example <linux/init.h> contains
section definitions for use in .S files.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

