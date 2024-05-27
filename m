Return-Path: <linux-kernel+bounces-191489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340078D1037
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC23282FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE5F167265;
	Mon, 27 May 2024 22:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUJvW9Ow"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEDF17E8EF
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716848632; cv=none; b=fs6ln88On+1Wz0iINUhtFr91xW4+Iqc+3h+yLF25hv7jhL24nKC02gtCkrOML/eT6kU7NQKjvWxHnsf/bdMaFuIvFlCBAJoGwiNrhD2sllFuRKA7Vr6pUgJSYVyNE0tuOAf8aKQAlZi/ILVPaHSRWYRAUpnQwUyeLVeFRDfWjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716848632; c=relaxed/simple;
	bh=GZH377y7yGc5E1Hf3ysl8Uxmrt7q59I5cvxr1o0XHaY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=saAjaXnrpn4lYNbYQ437gh9KXH4TVIO+Q26tbuq8NwnAAzWUcrdzL//R0r6REHZskHkzyJbdg4h0yDoG6hXs6uAJuQEMcZ0+vk7/xaRUepXeNCk7eTST8dAKyCauHfUVOnlVzEyC75t7ohlaCMxL9WMGTZ4TZ18f7kuV4bNbAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUJvW9Ow; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716848630; x=1748384630;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GZH377y7yGc5E1Hf3ysl8Uxmrt7q59I5cvxr1o0XHaY=;
  b=UUJvW9OwYezbZz5fTRZgPNxNAvrbKHqc+uWx1RmYJVRSETWyMg9gnym/
   aVuld+ZuALn6I/fOcG1wLDHWc65lHeRV/a0pj6o1ht7fWQELSt4gdteP8
   e37oTchyrz47ZCaU6XG56ygpYOnstsBVv/O5zttopiKFCtdBWDog7XwlP
   pSwLi2u3zzPb2TsH9SldRxegxQqcWqOieMdmkdzlEhl8xR7+zb9DXuyhG
   vnAytM0RTzZa93FKyy5uMCba+AxqkydfOUhPlyGjFz1YzgfjKWT3i/7qJ
   uKgGaqcpY249LRLFGnNr2BSeo6pXdZ1Zu2St5DsZCTKjl6HGrH127tO4x
   Q==;
X-CSE-ConnectionGUID: 2TKJhMoGRJaqceJ29k+LnQ==
X-CSE-MsgGUID: UWttp7FRR/eIVAS7uwXP+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="16962589"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="16962589"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 15:23:49 -0700
X-CSE-ConnectionGUID: ZjW8H8UHRrSJc9kP9w+icA==
X-CSE-MsgGUID: ri2QSozKSxy0e9YRun+vSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="34760143"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 27 May 2024 15:23:47 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBikr-000B99-0s;
	Mon, 27 May 2024 22:23:45 +0000
Date: Tue, 28 May 2024 06:22:58 +0800
From: kernel test robot <lkp@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: ld.lld: error: undefined symbol: proc_do_static_key
Message-ID: <202405280616.wcOGWJEj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2bfcfd584ff5ccc8bb7acde19b42570414bf880b
commit: 8d469d0bee74d3f2d02f0b232933a3f084d9cbf7 lib: introduce early boot parameter to avoid page_ext memory overhead
date:   5 weeks ago
config: arm64-randconfig-002-20240528 (https://download.01.org/0day-ci/archive/20240528/202405280616.wcOGWJEj-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240528/202405280616.wcOGWJEj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405280616.wcOGWJEj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: proc_do_static_key
   >>> referenced by alloc_tag.c
   >>>               lib/alloc_tag.o:(memory_allocation_profiling_sysctls) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

