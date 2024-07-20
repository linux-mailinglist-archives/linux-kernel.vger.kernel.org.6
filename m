Return-Path: <linux-kernel+bounces-258018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4207D938235
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 19:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665841C20DF2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 17:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84041474BA;
	Sat, 20 Jul 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lV2do/4u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396C372
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721494900; cv=none; b=qEzT0Bb/2uyZ++KygQ5GgE4iqlOboz/qtbK4fivdVHGfUrE1X27NV56oVse4Pnac0+G4hrsoKvb8Qi6gZXBDTjVKXgjmXeing2ShsGAdSKrfSob7iunvOFDtZpgSbAs9YtxadYiizbSJI84bj7lM0tBBMKE1cv21EidoURLHXWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721494900; c=relaxed/simple;
	bh=Oiv8eP2NOw2hP5IE1VUwCmFWL55u+n5HshoHTpEyM8g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r2ZSHbqfP8uhX1y0+s0v2SPtofFsElESm8rTyXtJaVAXM18D2xst9V29JSwbJz5FljUrANLDs1Qg0VHiqkFefeJnESn+OS6jLz3Fih+MrIjeW7fjiGASJzbK5I5r+Qd+uR0YWKH6teT9LeWz2qTPoQhXBPqKGVX4b7GMkQiMz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lV2do/4u; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721494897; x=1753030897;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Oiv8eP2NOw2hP5IE1VUwCmFWL55u+n5HshoHTpEyM8g=;
  b=lV2do/4ui3IfhkYDnJHrzTMIeWuLL9sEVUYBmwtOptsBUktjub+l58hR
   Zs2OIiJjuAqpqZ5wrXOmWg7m17VHnZB7H+QpC9RHJ5qbRiGrFiRlH6Fam
   b41U9ecdSrkT07+q4pEAM7lgiCg1NWrGWSjK0TEvpNYOYE9PSM98Z846A
   2dtHKscIlA7GqhBsZyGPGG661iIXn9neG5kq8XIcD+aG76o9oh2GRGa0q
   2kdQqq+1mC2JnIBBTQ4/WVsJVUpgUUmkagOVTf5Sz/1uAPLPZ3OACZTx8
   1N+bz3pPQS/N5A4oVYs1VLNUfXwe2ndS6U38GKZPmjrj0K4R6GkhLC826
   g==;
X-CSE-ConnectionGUID: LMPHWbolQqq6tnPYJpypIQ==
X-CSE-MsgGUID: fCeFajAISJGyINsmmIkDrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11139"; a="44530672"
X-IronPort-AV: E=Sophos;i="6.09,224,1716274800"; 
   d="scan'208";a="44530672"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2024 10:01:37 -0700
X-CSE-ConnectionGUID: I24MEcrXTm+CXbjW1WnEIw==
X-CSE-MsgGUID: LafHgpLfTmK6XbTMv1X24w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,224,1716274800"; 
   d="scan'208";a="52140590"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Jul 2024 10:01:35 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sVDSe-000jSA-1N;
	Sat, 20 Jul 2024 17:01:32 +0000
Date: Sun, 21 Jul 2024 01:01:07 +0800
From: kernel test robot <lkp@intel.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: vmlinux.o: warning: objtool: .text.nvmet_ctrl_state_show: unexpected
 end of section
Message-ID: <202407210029.J3MTyDu6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3c3ff7be9729959699eb6cbc7fd7303566d74069
commit: 649fd41420a816b11b07423ebf4dbd4ac1ac2905 nvmet: add debugfs support
date:   4 weeks ago
config: x86_64-randconfig-123-20240719 (https://download.01.org/0day-ci/archive/20240721/202407210029.J3MTyDu6-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240721/202407210029.J3MTyDu6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407210029.J3MTyDu6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: __sanitizer_cov_trace_cmp1+0x13: call to write_comp_data.llvm.7642755165958622254() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_cmp2+0x16: call to write_comp_data.llvm.7642755165958622254() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_cmp4+0x16: call to write_comp_data.llvm.7642755165958622254() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_cmp8+0x13: call to write_comp_data.llvm.7642755165958622254() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_const_cmp1+0x16: call to write_comp_data.llvm.7642755165958622254() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_const_cmp2+0x16: call to write_comp_data.llvm.7642755165958622254() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_const_cmp4+0x16: call to write_comp_data.llvm.7642755165958622254() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_const_cmp8+0x13: call to write_comp_data.llvm.7642755165958622254() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_switch+0x78: call to write_comp_data.llvm.7642755165958622254() with UACCESS enabled
>> vmlinux.o: warning: objtool: .text.nvmet_ctrl_state_show: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

