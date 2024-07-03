Return-Path: <linux-kernel+bounces-239769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CBB926522
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26341F22127
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D654181B9E;
	Wed,  3 Jul 2024 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUg4PTZx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8B4177980
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021367; cv=none; b=U8Rks7tv3xJ/N9uZ6BnJA3I9bpbon662ksJsO9RUIZE3hluNOhNiqoBWL7wkmg5HNbsH15DuDz7Vv5yshLrbe1QpockUbeJxjTLMEz0RMMWXK9rZhxnvwVPWei5wJRpeQPOtIdlHBLucg19gvtFj0wIyHmdfk6W3/25hPtzHsQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021367; c=relaxed/simple;
	bh=+AihdfUpmwWLDFFWHwa21OtW1ZkYTlwt+AShpx03GGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Jmqs3+S3VRc9NFZoWFisMcBcyiGiWj/jd6s8++l0NuHhHFUgX8zzeYyUHLNu7bu9cr+jd8Yk8uKrRMzrSvqalrDBaJKSey4wAVNqD8BR+pQADVKvIpj0cztGVlAm7ndc7FVq+ljVP1gNJgudUZ22N8CEZZX+NDfodOKwx/izK3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUg4PTZx; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720021366; x=1751557366;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+AihdfUpmwWLDFFWHwa21OtW1ZkYTlwt+AShpx03GGA=;
  b=RUg4PTZx66vw3YLoU/VKd3cjhBKB3zAccZbXD21pCXZsXxE3CYE2c/u1
   2IQXjfCVHyB6Yx5GXx+9MjoMGgk/gLsKNhnduX8LAIizQHDq/XwCxxi+i
   egEGfYEGIzwD3Bcszy9gAH2Ix/o6jAu0LlSyhbp2kNOpt0TlGQ5+UYXoE
   JUifw0/LwHSxX5aPHg3N9PQKn7y6NVBZ44Ky+wbD0c/otqbVcefkkRW/7
   ch9E7DUi00C7EBt5LQ+76v21F7Fwj+A2VUaY4WdBlTt/wN995FjF66ewL
   /GRwtwQWrcI7ezj8Sh2RHbKWYlWFzCyrk8Bl3sScyPq/vrTE+FSy0LYZu
   A==;
X-CSE-ConnectionGUID: PILE3AR2RcGckeX8DouFYQ==
X-CSE-MsgGUID: FsBS/HIzSeu7Bju8qDPPFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17129061"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17129061"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 08:42:45 -0700
X-CSE-ConnectionGUID: I2CwxlN9Sx6HWet2C/qZGw==
X-CSE-MsgGUID: P830gC2yQVea7U4dc4NK9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46725798"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 03 Jul 2024 08:42:44 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sP280-000PuS-2c;
	Wed, 03 Jul 2024 15:42:40 +0000
Date: Wed, 3 Jul 2024 23:42:05 +0800
From: kernel test robot <lkp@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Kees Cook <keescook@chromium.org>
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 alloc_tag_restore+0x3c (section: .text.unlikely) -> initcall_level_names
 (section: .init.data)
Message-ID: <202407032306.gi9nZsBi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e9d22f7a6655941fc8b2b942ed354ec780936b3e
commit: b951aaff503502a7fe066eeed2744ba8a6413c89 mm: enable page allocation tagging
date:   10 weeks ago
config: xtensa-randconfig-r051-20240703 (https://download.01.org/0day-ci/archive/20240703/202407032306.gi9nZsBi-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240703/202407032306.gi9nZsBi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407032306.gi9nZsBi-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
>> WARNING: modpost: vmlinux: section mismatch in reference: alloc_tag_restore+0x3c (section: .text.unlikely) -> initcall_level_names (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: bitmap_copy_clear_tail+0x44 (section: .text.unlikely) -> __setup_str_initcall_blacklist (section: .init.rodata)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

