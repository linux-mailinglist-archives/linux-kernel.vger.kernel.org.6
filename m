Return-Path: <linux-kernel+bounces-524961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAB7A3E936
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2211C19C2717
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BF9111AD;
	Fri, 21 Feb 2025 00:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dN4oXDsS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8D79F2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740098403; cv=none; b=a9BHcBEBH+eOEkEbbLR3hYcVUyWpeRcOts6vYlmGKQKk14/Mi7muCbWK2B9bMmSKIozT1C5ZWwxottRXbVddTRM7o01qut4VFh6yR+/KeMy498o3ZyfBbZMKHFhrq6XMYhZ2u+FP0l1XOVcXjIh3JY8W3uQBWUbyhtFVGDlPSEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740098403; c=relaxed/simple;
	bh=q1JJyMGvYphxErX74ZnaUC7tzDuLTvZaZL/ShnEn5+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gOElo5LikBTDBcz3u0yhdgfdkJ+jgMJsfK4hzeHOMdZaYNMD30R1CfkxQuBI8Sbx7prTlmR0hwcjBDy6x+gI+Ypm/IN9PEDhwOL1Np79BoEfMvyipXQAHop7/nJv6a417XDFsg0Vc/Qk1LQzvbAaxAuu9VFAkLlOy6zG2P1PgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dN4oXDsS; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740098401; x=1771634401;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q1JJyMGvYphxErX74ZnaUC7tzDuLTvZaZL/ShnEn5+M=;
  b=dN4oXDsS9sGG8yUPVxQdzBrUxu6naII2sP1nrRGuYsAD8v+KOqbg/xI6
   mPfxZjBrai+wJpVxf84lG/FgV/kzYyJtnwkpdOXhDHzgPzlLm20zwws3b
   JW3c+3CRgPqVoFsxLz7funheXU8Fg2PZVKKpNs9NbPqb/QApxHErpDwCC
   4rN8KoJQPqqI7LQURYuzMLoDl5ZUv07L26PUgoYpGbUGX+uDmvBNRfwC/
   kWUBs4onTCiVgOSt4HcjNY2VrjAk8q/8fAfoTE3MHDvmL9PkBmbi1A1KV
   /Y79YwFo7LJ1b5ts0mNJgoEAOyxESN/qD4uEZiOFfngn/YCprQP3YtMMC
   Q==;
X-CSE-ConnectionGUID: SuHMSHXiTCul6TDmVrMzXQ==
X-CSE-MsgGUID: wSOzTysDRs6oJeWA2dXAMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51544549"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="51544549"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 16:40:00 -0800
X-CSE-ConnectionGUID: pmS3BrhhSIKG1IrVqOo3eg==
X-CSE-MsgGUID: dBTSwFu8QjCUGWaZlSrPDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="138423899"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 20 Feb 2025 16:38:47 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlH42-0004uz-0E;
	Fri, 21 Feb 2025 00:38:46 +0000
Date: Fri, 21 Feb 2025 08:38:41 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: vmlinux.o: warning: objtool: shrink_lruvec+0x500: sibling call from
 callable instruction with modified stack frame
Message-ID: <202502210851.HssdUw7m-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27eddbf3449026a73d6ed52d55b192bfcf526a03
commit: 3724062ca2b1364f02cf44dbea1a552227844ad1 objtool: Ignore dangling jump table entries
date:   12 days ago
config: x86_64-buildonly-randconfig-004-20250221 (https://download.01.org/0day-ci/archive/20250221/202502210851.HssdUw7m-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250221/202502210851.HssdUw7m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502210851.HssdUw7m-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: .discard.annotate_insn: dodgy linker, sh_entsize != 8
   vmlinux.o: warning: objtool: xen_hypercall_hvm+0x30: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_cmp1+0x11: call to write_comp_data.llvm.16327857404679515702() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_cmp2+0x14: call to write_comp_data.llvm.16327857404679515702() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_cmp4+0x14: call to write_comp_data.llvm.16327857404679515702() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_cmp8+0x13: call to write_comp_data.llvm.16327857404679515702() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_const_cmp1+0x14: call to write_comp_data.llvm.16327857404679515702() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_const_cmp2+0x14: call to write_comp_data.llvm.16327857404679515702() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_const_cmp4+0x14: call to write_comp_data.llvm.16327857404679515702() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_const_cmp8+0x13: call to write_comp_data.llvm.16327857404679515702() with UACCESS enabled
   vmlinux.o: warning: objtool: __sanitizer_cov_trace_switch+0x53: call to write_comp_data.llvm.16327857404679515702() with UACCESS enabled
>> vmlinux.o: warning: objtool: shrink_lruvec+0x500: sibling call from callable instruction with modified stack frame
   vmlinux.o: warning: objtool: .text.aw_dev_dsp_update_cfg: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

