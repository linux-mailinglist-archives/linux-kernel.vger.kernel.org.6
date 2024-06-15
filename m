Return-Path: <linux-kernel+bounces-215897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6251290987E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 15:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA721F21DF0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 13:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A387049622;
	Sat, 15 Jun 2024 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCsEYllF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F89D3B1BC
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718457742; cv=none; b=UjSgF+cIpx8USg4wURF5P8+n2f1PU3OPKF2rpTAOhkLWFB8HGUxzVVgiIrDDggqchU6z6n9Ahl4hJxf2Rn2v7JxVYf8pK9CZIRK9S6ISYbA1SMz3xQzTj1MlJB/obH26BbQarmIxojc6oFsXxWA1FmTB75angYbmOOmMvv6MwOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718457742; c=relaxed/simple;
	bh=PNSYu5iRNRE25o/6n2QfHZ/h2Qw06F9X3mZkPPP04FI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mEf6LGrnmws5ErZAq8FUQqnw+r4H/aSJBCjpI3i9kPH0IuXFGujJRDZad8o3MGjG7ru1c5TdwaHy6DMDdPr6cgDxJIfcMtSPJHIHe85pCGmdgdSh1JTreMsbaW/LC0Bbw53O/YyPpsakjBKDw6QvhGH7Euua4n27fNyg6AmpHR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCsEYllF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718457740; x=1749993740;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PNSYu5iRNRE25o/6n2QfHZ/h2Qw06F9X3mZkPPP04FI=;
  b=aCsEYllFmJZjx6FIZJ+zuaVbO/omMF530pXP3pXfeBTBz5L3k3yhCXui
   F/8WzuoO140QZxcwOlZ1Tyy12L7CpVcTZ2QgrTwrUDASUhM7smZMI9Kk0
   x0mc7MWCnR/Dm4F20cFIWHfKavgueyGNM8uPOnIWBze94cx6SVEymbLie
   VBr6twFDSPfcTIQKEETnYs83WtmUubei/CYzzyLjw0C7FFK7sMCuTwQn9
   rPH4biAJ8v5kWuLrl7aePnwdB0An3liUjnf5miMwNHO0MTEDz3bkrTAEm
   rvFPg83/kSrrxPk+/YyZkfb4T0jt9fip/6vFHkQwus2s4gul82kffYLzy
   A==;
X-CSE-ConnectionGUID: uScK3tweS/Gr8UQAfsE6vA==
X-CSE-MsgGUID: vKyWaeObTn6dJLykq6m1mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="15071061"
X-IronPort-AV: E=Sophos;i="6.08,240,1712646000"; 
   d="scan'208";a="15071061"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 06:22:19 -0700
X-CSE-ConnectionGUID: kmM0SGTKRp2A/gETUt3g3w==
X-CSE-MsgGUID: gmNzsIDHQVial082eRuoUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,240,1712646000"; 
   d="scan'208";a="40697718"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 15 Jun 2024 06:22:17 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sITMF-00003q-1w;
	Sat, 15 Jun 2024 13:22:15 +0000
Date: Sat, 15 Jun 2024 21:22:00 +0800
From: kernel test robot <lkp@intel.com>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [tip:x86/vmware 4/8] ld.lld: error: undefined symbol:
 vmware_hypercall_slow
Message-ID: <202406152101.ioasijN1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vmware
head:   ef08e7dc21307b226b5280d5e8cfea687bfd2866
commit: e5ac9008b79c59235c34494e555419665022f5e1 [4/8] drm/vmwgfx: Use VMware hypercall API
config: i386-buildonly-randconfig-001-20240615 (https://download.01.org/0day-ci/archive/20240615/202406152101.ioasijN1-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240615/202406152101.ioasijN1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406152101.ioasijN1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: vmware_hypercall_slow
   >>> referenced by vmwgfx_msg.c
   >>>               drivers/gpu/drm/vmwgfx/vmwgfx_msg.o:(vmw_host_get_guestinfo) in archive vmlinux.a
   >>> referenced by vmwgfx_msg.c
   >>>               drivers/gpu/drm/vmwgfx/vmwgfx_msg.o:(vmw_host_get_guestinfo) in archive vmlinux.a
   >>> referenced by vmwgfx_msg.c
   >>>               drivers/gpu/drm/vmwgfx/vmwgfx_msg.o:(vmw_send_msg) in archive vmlinux.a
   >>> referenced 13 more times

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

