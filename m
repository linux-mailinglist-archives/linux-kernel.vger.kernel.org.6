Return-Path: <linux-kernel+bounces-430748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F069E354E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53B1B23F6C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE7818C03B;
	Wed,  4 Dec 2024 08:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZQgiVkt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C026113D281
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299716; cv=none; b=RgIbmRlgjOBOVHLTvb6rNxP+0mOzUW8x8PhJjv+rI9wnzf84RTeRMDR7RzBLvKxs+r65UdI439k6cqB2qFMC/7KCZq57eEkJ53uRYnLdqKJOJVsVjAtMF/crPHFO8MF4CL3NGqfSDbs4+4/82e+e9VLu/msCLa4QCBJZnTDbJE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299716; c=relaxed/simple;
	bh=ctPCVNh5tHp7G5O9ZKsq28RSv9/8I27VOINoe25Eb3s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lQK6V6jZJcBNPy+Ziw25lN8TU8nsMUY2Ufn0RVYVbqImYCMpZ8HuMOxUNLb++20qGJsfxGOK4uwRMPkl+b89hAqd27hfhbsEdPhxlS+nx70/qaYQmISQ1uPphEvJLfkO9L4eSi0qyGik4N+4XiU3g6ydjbKN6VjvDH3XgRO2rHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZQgiVkt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733299715; x=1764835715;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ctPCVNh5tHp7G5O9ZKsq28RSv9/8I27VOINoe25Eb3s=;
  b=IZQgiVktzEtaK/yKWGZHVMak1nNtLj7l6GMuizgdSDy+Kkp2Bp/tP9nF
   EYPfFZ4QaBb1HZCZSsKnsT5jdu9LyDtdalOplfBes5vb/1pnxmU5uUggY
   0DhOXT8cMwsIm5jWFS5JIZVzvRJ3rf+ngeJQSRKgG/KB3/aaUwb5PnoVv
   MWjHhkvblPSQl0oGhYdz/8+unD4NLsa7wmO/NN3tXPmF9wpYdT4gjse2S
   XG+K0tWbCuSHNjmY6cEDqUhDe8b2nkxU6tQWzMSlslwUE8j+j+wOR71mt
   GGvb1a/ROeP70JQkQcWMTGBfab87CsYR8wpD28KGHyTjjB+rQIPwweBYE
   A==;
X-CSE-ConnectionGUID: 0/a75jqeQJCeBXVePcoVCg==
X-CSE-MsgGUID: QSSii5HUR/S7o+g2TU9xYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44214961"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44214961"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 00:08:34 -0800
X-CSE-ConnectionGUID: KxsGcLy/Qhq+RHwwk8DXVA==
X-CSE-MsgGUID: 5IacHtq7RfK5ZlacAxB1BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93781822"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 04 Dec 2024 00:08:33 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIkQw-0002k3-26;
	Wed, 04 Dec 2024 08:08:30 +0000
Date: Wed, 4 Dec 2024 16:08:28 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: /usr/bin/ld: warning: arch/um/kernel/skas/stub_exe.dbg has a LOAD
 segment with RWX permissions
Message-ID: <202412041645.0fo0mztX-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johannes,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feffde684ac29a3b7aec82d2df850fbdbdee55e4
commit: d3b08e5f3f2829943342b88d3e2b44fb0ccdccab um: fix stub exe build with CONFIG_GCOV
date:   6 weeks ago
config: um-randconfig-r061-20241204 (https://download.01.org/0day-ci/archive/20241204/202412041645.0fo0mztX-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412041645.0fo0mztX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412041645.0fo0mztX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   clang: warning: argument unused during compilation: '-mno-3dnow' [-Wunused-command-line-argument]
>> /usr/bin/ld: warning: arch/um/kernel/skas/stub_exe.dbg has a LOAD segment with RWX permissions

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

