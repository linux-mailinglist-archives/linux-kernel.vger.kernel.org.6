Return-Path: <linux-kernel+bounces-550331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CBCA55E07
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E483AB8EC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 03:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F18187872;
	Fri,  7 Mar 2025 03:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aVkCZG2D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519A41CFBC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 03:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316921; cv=none; b=IkgLsfC3PFHEHFZ9+woxgUb93TjuLosIn7ZjFdUxVLSJbh5iOtGgGkYvb8OcqaPPMxUeaVHBb90V+WHwcTSKDoqXxje0pWB31j9x2Xct4rK816hCPcHHaAjpQ6kFps2L7c4K3GEgzpowOlCZSjOT5jMpfsLnJz/IcKyZuPgBOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316921; c=relaxed/simple;
	bh=DcLJ9aKimVNyrW/43nsjmeGTwBj8U+eyVkMor5z0OH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn9aadX2BpZq5cPwxpWAoq7EcX5nOFf3ODzEt2bj98EskVLZbQtxA9uFxRQH4s2wPJZlc6Bpvw7wIchk4Hv2gz/nhGlRryPwSZjq1rAI4kcTSRElScGyW6VIE6/8bUvLw3t+YOUZxD7ptuZHSdVJel/b3ahYhp845cfA8Cc5uvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aVkCZG2D; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741316919; x=1772852919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DcLJ9aKimVNyrW/43nsjmeGTwBj8U+eyVkMor5z0OH0=;
  b=aVkCZG2DevpG8JhaJV75ZEFrc0J/n5atqb7tyEJMR/ygxC2aSndFonEI
   QcBreTctw1nNJEVGEiM4JdSQm0N07RG8wXrHiq5pXvjfZTbXb1oZdpDfq
   N2Guc5GkMyafaaOui7niWWL3q5tTXgUh+auYfxKgd4moO36GGWln1E4Yk
   MurS67dSCWQ960762KMk8yv4zDuL2AxNf+HVucocLXltfzqZ6sYj+Ey/Q
   W6fdJeWLFoBtLVBswa3T8c3B/GmU/FqpdnHqOhRDHq/PvRYy2YdkG1Gex
   9Kiu4IkA5KomO6VtLRytp2QPMYN2cCx9UayqOyxCkVtUQJQeydP/dyXoQ
   w==;
X-CSE-ConnectionGUID: n1RVVMEhRgiEo1Lld35qgg==
X-CSE-MsgGUID: oNJy5RLfTgKFd5DT5UPYKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="52996201"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="52996201"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 19:08:39 -0800
X-CSE-ConnectionGUID: NYB16Ma0QrSPRJ6pD9Bw5g==
X-CSE-MsgGUID: UPRbNo95TJeuYJ1WV0owAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119130707"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 06 Mar 2025 19:08:35 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqO4d-000O7i-2r;
	Fri, 07 Mar 2025 03:08:31 +0000
Date: Fri, 7 Mar 2025 11:07:31 +0800
From: kernel test robot <lkp@intel.com>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	dmitry.osipenko@collabora.com, jfalempe@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ryosuke Yasuoka <ryasuoka@redhat.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH drm-next 2/2] drm/virtio: Use atomic_vmap to work
 drm_panic in GUI
Message-ID: <202503071022.q1pg7suf-lkp@intel.com>
References: <20250305152555.318159-3-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305152555.318159-3-ryasuoka@redhat.com>

Hi Ryosuke,

kernel test robot noticed the following build errors:

[auto build test ERROR on e21cba704714c301d04c5fd37a693734b623872a]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryosuke-Yasuoka/vmalloc-Add-atomic_vmap/20250305-232918
base:   e21cba704714c301d04c5fd37a693734b623872a
patch link:    https://lore.kernel.org/r/20250305152555.318159-3-ryasuoka%40redhat.com
patch subject: [PATCH drm-next 2/2] drm/virtio: Use atomic_vmap to work drm_panic in GUI
config: i386-buildonly-randconfig-003-20250306 (https://download.01.org/0day-ci/archive/20250307/202503071022.q1pg7suf-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503071022.q1pg7suf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503071022.q1pg7suf-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-mgr-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-bridge-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-region-test.o
ERROR: modpost: "drm_gem_atomic_get_pages" [drivers/gpu/drm/drm_shmem_helper.ko] undefined!
ERROR: modpost: "atomic_vmap" [drivers/gpu/drm/drm_shmem_helper.ko] undefined!
>> ERROR: modpost: "drm_gem_shmem_atomic_vmap" [drivers/gpu/drm/virtio/virtio-gpu.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

