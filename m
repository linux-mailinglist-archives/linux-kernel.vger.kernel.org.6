Return-Path: <linux-kernel+bounces-551391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79914A56BDC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D1C3AD386
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0960D21CC45;
	Fri,  7 Mar 2025 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGzfdexT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9021A92F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360956; cv=none; b=amcaCOEGQMMLaxCC+NaZzSLZkfOBXIdeKtFoY0S2wYvZIEkrK4kJtNVAt7Cauuc1ywDRN5Wq9F9MQu1JwhLLc+Ous3u1zCYD4ZE4DlBfQ4yluc3Oj8DIhw7fakMZSHxbm7oV9lilwynV3s4Wr9vRKf6v13KXmXhas4eQ6mB4fw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360956; c=relaxed/simple;
	bh=KSMC5QM8qz0gz5xHIBm/4GI/nE2ksGcyfus2VQkF2rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NXjJnt7ip7GyqMLQYig+2AGh9ewz/XPk0uzlC/MEQM0JYTL/M1bh0H44hpRCRb2VfVO1PY3nsVBYcJQ+dR6VKPH/c8pYEUK/LsQN9K/AR7VF21fNJdN452NOTCwyjVr1yiD1xJ+CAvr5EYudYKD7zxZX9FyK6dl37pwhs9SsofM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGzfdexT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741360955; x=1772896955;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KSMC5QM8qz0gz5xHIBm/4GI/nE2ksGcyfus2VQkF2rQ=;
  b=OGzfdexTrQYAN/QqegxwO/uS80i62iEvzL/NCIhEw/8dXW9dNpbT4bl6
   vSvYQqvCxYzz6sCqDGCkx/58BkDJ0nLQyt1PFxlgoQx9Z8lhMREibqhXi
   b81DaZyLd0L8tKespJZ5bkvn5Yu+F2rpUaBpkK9C5Viwt6jv/3udFmF3U
   UwoXqxDRj1mYAMFeRiVXl2rROPtdM0x3bIVKZVS0csAg6yJIZqMtctTvQ
   2+MQnEKmFc1TxEk31iGIn7BVCim1M/KJ46HiCn8ytEHf0B4YSHQOnKUcT
   6iR/yPXVAQPt5GHmE7sqoFTwNdGu74z7UodMOInBYKuovyN6v0qHSTh18
   w==;
X-CSE-ConnectionGUID: F2JHy5rYRvmBzjSNTJ3pjQ==
X-CSE-MsgGUID: 7S0SIYHlQQ6a2nb9HUsJEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42641179"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42641179"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 07:22:34 -0800
X-CSE-ConnectionGUID: jxflgZpCQxiEbKo8TpoN8Q==
X-CSE-MsgGUID: kAgM1Y5cRAiYSvsxMVIJbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="120045919"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 07 Mar 2025 07:22:32 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqZWw-0000du-2O;
	Fri, 07 Mar 2025 15:22:30 +0000
Date: Fri, 7 Mar 2025 23:22:20 +0800
From: kernel test robot <lkp@intel.com>
To: Rong Xu <xur@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>, Kees Cook <kees@kernel.org>
Subject: main.c:(.text.unlikely+0x18): relocation truncated to fit:
 R_ARC_S25W_PCREL against symbol `__st_r13_to_r15' defined in .text section
 in ../lib/gcc/arc-elf/12.3.0/arc700/libgcc.a(_millicodethunk_st.o)
Message-ID: <202503072317.Y9GcLy6u-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rong,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   00a7d39898c8010bfd5ff62af31ca5db34421b38
commit: 0043ecea2399ffc8bfd99ed9dbbe766e7c79293c vmlinux.lds.h: Adjust symbol ordering in text output section
date:   3 months ago
config: arc-randconfig-r006-20230901 (https://download.01.org/0day-ci/archive/20250307/202503072317.Y9GcLy6u-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503072317.Y9GcLy6u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503072317.Y9GcLy6u-lkp@intel.com/

All errors (new ones prefixed by >>):

   init/main.o: in function `run_init_process':
>> main.c:(.text.unlikely+0x18): relocation truncated to fit: R_ARC_S25W_PCREL against symbol `__st_r13_to_r15' defined in .text section in ../lib/gcc/arc-elf/12.3.0/arc700/libgcc.a(_millicodethunk_st.o)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

