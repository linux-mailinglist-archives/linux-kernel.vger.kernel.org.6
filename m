Return-Path: <linux-kernel+bounces-426233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68969DF09D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55C431633A1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3835119CC24;
	Sat, 30 Nov 2024 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpxh3f9J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D234817C222
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732974429; cv=none; b=MrF7PEjjx4J7BSunCXnDZPtOBAfAiEqdQYPYw1xc3IsCiTuJpXUYQZpV0yzOxPhX/jhTNkhUiBw4qf+mt69HVQDpByNjCDqIWJ8GM2Tn2sCiwqnsVGSz/vP9BqH35BFZw2yk+6En2Xlk1THwjKGljYiFUq0smHAOh+Cx+Jfub7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732974429; c=relaxed/simple;
	bh=H+rY7/Fl+jf+eafxrQuwkRyzbnyJTaL3h3ycW0bXtfA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WHk4v9lIB2QYQmouLge/yFUVG2TztCHGw1Dn0GWTCo1OwGgyS9QjkblAoqFVAY/GeVoRrqsg23Ks+W3aZvJwP4+2JtZ9bmWFrpMyfM6kNCzW8clm1rOQ6UZ7Pz0olwxIyHXJ2WrJcszQ4kuDaXBo5uf1ogersENhnu32hOtM/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpxh3f9J; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732974427; x=1764510427;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H+rY7/Fl+jf+eafxrQuwkRyzbnyJTaL3h3ycW0bXtfA=;
  b=bpxh3f9JjBHs2+JFl4GDcAsDh88mqEyHnlWmiKTNxU7o59cI/njcWuzK
   P4znWr9tCJqevHhqTvbV9VDxHEhXPg1Hk65mY0gwMnjcQtCDsu4yI/gVv
   WxrRyDXfB7dTjlC34OeZKjhkRjuUTqq/9mKeJyfcWE7R4grkpxCGehKcy
   fzXvD8pnlZAIdA4cFADggASQPk1hoWKU4HY+PIG0lLuzDb5AbgXa5a36B
   kA2F+6OSR3EWS+ay4eNu2Rwj3DushiiyVgUxqvt7tXzgUOVxrZoEkjcsR
   9fcH46kpfb3uDgpBQoLBssW5rMnQYIpkIMWhtJMA3ykGRanWxvv//yRl/
   g==;
X-CSE-ConnectionGUID: z6JbkvV+Q2OnkN2FGuXZkQ==
X-CSE-MsgGUID: A339ArqXQc6NiCNhfr0O4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="43670988"
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="43670988"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 05:47:07 -0800
X-CSE-ConnectionGUID: cnpqhUhKQ/mGMC1FnifZMw==
X-CSE-MsgGUID: SJfzvVO5QwasiPLeWoltgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,198,1728975600"; 
   d="scan'208";a="92503985"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 30 Nov 2024 05:47:06 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHNoN-0000hn-2w;
	Sat, 30 Nov 2024 13:47:03 +0000
Date: Sat, 30 Nov 2024 21:44:03 +0800
From: kernel test robot <lkp@intel.com>
To: Filipe Manana <fdmanana@suse.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Subject: WARNING: modpost: "cmpxchg8b_emu" [fs/btrfs/btrfs.ko] has no CRC!
Message-ID: <202411302109.AIAUz8Er-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ba9f676d0a2e408aef14d679984c26373bf37b7
commit: 1020443840569535f6025a855958f07ea3eebf71 btrfs: make the extent map shrinker run asynchronously as a work queue job
date:   3 weeks ago
config: um-randconfig-r053-20241130 (https://download.01.org/0day-ci/archive/20241130/202411302109.AIAUz8Er-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241130/202411302109.AIAUz8Er-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411302109.AIAUz8Er-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: EXPORT symbol "cmpxchg8b_emu" [vmlinux] version generation failed, symbol will not be versioned.
Is "cmpxchg8b_emu" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "csum_partial" [vmlinux] version generation failed, symbol will not be versioned.
Is "csum_partial" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "csum_partial_copy_generic" [vmlinux] version generation failed, symbol will not be versioned.
Is "csum_partial_copy_generic" prototyped in <asm/asm-prototypes.h>?
>> WARNING: modpost: "cmpxchg8b_emu" [fs/btrfs/btrfs.ko] has no CRC!
WARNING: modpost: "cmpxchg8b_emu" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "csum_partial" [net/batman-adv/batman-adv.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

