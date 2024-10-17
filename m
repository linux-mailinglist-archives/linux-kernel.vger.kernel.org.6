Return-Path: <linux-kernel+bounces-369860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE69A23BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B91F2943E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0201DDC25;
	Thu, 17 Oct 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mv16Q38r"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40511DDC21
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171352; cv=none; b=Xd3BGJngdf4ct4cXWjzGQq+XmHFDA10C56yLLAkaxBYzTWcM0rwSTRZxNUdntTKou+bO5fZN8Fid4KzVzSLQFA6q+pMe9v0zGzj5lRS55uHeelVcdtrlpM7SVE5MEgp04W1u5d7Pf5WM+um4+oM+4/piu3e4DY3fvY8ZIbp++K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171352; c=relaxed/simple;
	bh=POCcKFsZDCX17J8YXjXUXiElbCFiKUS3lyHCgP2MKOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EOMt4B++N6FvEcoDSFvH7X/7PeLicEvrumnoSIonB/fvYejokPoiN2RnzDb1RP6UkjUbJ++eNGR/cht6auBEUyuFfA3JUxOkDc0rmBMtR9QG4SvN9xXvbIN0ug6kdKaXI8XCVgXh69RsMy3XHD5atSUK5gcq8Hra2a62tTGFpWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mv16Q38r; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729171348; x=1760707348;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=POCcKFsZDCX17J8YXjXUXiElbCFiKUS3lyHCgP2MKOA=;
  b=mv16Q38r0Fr4QNChdpMwpDN+Thi/JnqH5gOUvq/uuXAkLHN32hklW7dQ
   sIMdc2He2AtvzVio/mKTTuiFZOepJBbD8YeUr+txOCJW93qkA3kXePl3H
   OqbTI4E+xoPoPxav0VGbmLentvgTzsXD6dgPrS3B6wWc2fDoePrcdnFHF
   hHpCejVCIjqzQz3p8WFWrx5dd8rsYPTOQPpQGmtogeqGGzpJ/nXgLV/FW
   bz+Q/43joVDIj9LiXudmgNcFrzBcE3G30sPNMay4fS8t8fzxwIn0YIF+j
   xbO7xMJRXdShp5GdTYMsoBL6OW6+OkJobGt7jp3MGbilKYkuH3ykE2W/G
   Q==;
X-CSE-ConnectionGUID: qh+o1Es5QmiEvlL3pu2S3Q==
X-CSE-MsgGUID: oMRwBDbURriTisCy+1GCaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="54069263"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="54069263"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 06:22:27 -0700
X-CSE-ConnectionGUID: WYRSj3kuRDa7aFhEjZG2Yw==
X-CSE-MsgGUID: DU5i8yHJQBmnxETDUizwiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78689339"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Oct 2024 06:22:25 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1QSM-000MOB-20;
	Thu, 17 Oct 2024 13:22:22 +0000
Date: Thu, 17 Oct 2024 21:22:03 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241015-2 13/18]
 kernel/bpf/core.c:2505:29: sparse: sparse: incompatible types in comparison
 expression (different base types):
Message-ID: <202410172103.ZqzfeZN1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241015-2
head:   41fe8a04339b3781dca5a8ba323ba77022acc441
commit: ad5262bdaed765f2f59e1db0a1361e7bd6dac847 [13/18] treewide_some: fix multiple -Wfamnae warnings that must be audited separately
config: x86_64-randconfig-123-20241017 (https://download.01.org/0day-ci/archive/20241017/202410172103.ZqzfeZN1-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410172103.ZqzfeZN1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410172103.ZqzfeZN1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/bpf/core.c:242:49: sparse: sparse: arithmetics on pointers to functions
   kernel/bpf/core.c:2010:43: sparse: sparse: arithmetics on pointers to functions
   kernel/bpf/core.c:2015:48: sparse: sparse: arithmetics on pointers to functions
   kernel/bpf/core.c:2283:77: sparse: sparse: subtraction of functions? Share your drugs
>> kernel/bpf/core.c:2505:29: sparse: sparse: incompatible types in comparison expression (different base types):
   kernel/bpf/core.c:2505:29: sparse:    struct bpf_prog_array *
   kernel/bpf/core.c:2505:29: sparse:    struct bpf_prog_array_hdr *
   kernel/bpf/core.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/xdp.h, ...):
   include/trace/events/xdp.h:321:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/xdp.h:348:1: sparse: sparse: Using plain integer as NULL pointer
   include/trace/events/xdp.h:382:1: sparse: sparse: Using plain integer as NULL pointer

vim +2505 kernel/bpf/core.c

8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2502  
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2503  void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2504  {
8c7dcb84e3b744 Delyan Kratunov 2022-06-14 @2505  	if (!progs || progs == &bpf_empty_prog_array.hdr)
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2506  		return;
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2507  	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2508  }
8c7dcb84e3b744 Delyan Kratunov 2022-06-14  2509  

:::::: The code at line 2505 was first introduced by commit
:::::: 8c7dcb84e3b744b2b70baa7a44a9b1881c33a9c9 bpf: implement sleepable uprobes by chaining gps

:::::: TO: Delyan Kratunov <delyank@fb.com>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

