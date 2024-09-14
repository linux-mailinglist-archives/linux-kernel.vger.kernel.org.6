Return-Path: <linux-kernel+bounces-329093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F8978D31
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325941C22447
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 03:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCE7175BF;
	Sat, 14 Sep 2024 03:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDRvYa4d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED00C17996
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726285781; cv=none; b=FVkClCK2thKYrkun6U7YyChCrB3mzBB5cZmTp/gtLCZFqHX3j2nUsOsksV3gD1wbKC1hKGxsaTz2Fu0a0/1QqgvimBGkZt1481RZj8gvaRHzsnu5oGKFzJSg7j+qM7iHQHi7AVyd4+9x/GNPC5uqy6f6S0Ixij5tpe1qtGYnbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726285781; c=relaxed/simple;
	bh=WvIpZlcITf2CqW3ox8sQkV/fW+NYeGhzXc6ObKkYoaw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Stqb4qTBQsYqmfKPjvbu+R9v+0RDWEemchAUYRK5G9hQHx34tBq2IEI7Up1vnhR+HnJQC4XOkGeQEGSi/NJyGMnmXHg9oL9ufS7W5zjYIfPi5jUFT1eVT/3RTQQG4iGZVXBrOtQU1h3jeMhkkk9G3wNpp4u7TCasPPSQsByqK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDRvYa4d; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726285780; x=1757821780;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WvIpZlcITf2CqW3ox8sQkV/fW+NYeGhzXc6ObKkYoaw=;
  b=mDRvYa4dW7Vlx1PIiS1KgQVKtaD3eQbT3clhIQl6u9dABnOeRsbL4MGn
   hLt/QPxTLbwMo6MzaWqsjEROG6+MV8r5qzoddc+zHTM6dx09JWUWdV6mc
   nc5WXc4QJfyF8TqXJuv0MLJTi2OUqlABH7vv6TIUbS0/P4gudkqhjcIRw
   cOHOI0f9yXTl93++o8sMlZ3XS0mkVFXun58ET4g+AzW46ezuylbtTtVDS
   tXsPR3sRSAqxkz24zhjjYQdHfYGxb/aHxkQo+7XPvg2rpBuhmNzeVDUaC
   +86oj0d7rBx7k1k51UjMTxxFYP4X2O5VI9l9oxHBgKurnt1z1slzXj2/A
   Q==;
X-CSE-ConnectionGUID: u4kfBT9tROSGQoanTM4DPA==
X-CSE-MsgGUID: OWiP2uu7QAyj9gUolaSp4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="50612794"
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="50612794"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 20:49:39 -0700
X-CSE-ConnectionGUID: QrIC1uNRQA6OSVWITJLd2A==
X-CSE-MsgGUID: ElgOlXIvSV6zFOJN8IgLIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,228,1719903600"; 
   d="scan'208";a="68155495"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Sep 2024 20:49:38 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spJmx-0007Kk-32;
	Sat, 14 Sep 2024 03:49:35 +0000
Date: Sat, 14 Sep 2024 11:48:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240912 15/15]
 kernel/bpf/core.c:2505:29: warning: comparison of distinct pointer types
 lacks a cast
Message-ID: <202409141152.VgCj23dh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240912
head:   f2ca068393cf1157c12ab08556b05824eec16511
commit: f2ca068393cf1157c12ab08556b05824eec16511 [15/15] treewide_some: fix multiple -Wfamnae warnings that must be audited separately
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20240914/202409141152.VgCj23dh-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240914/202409141152.VgCj23dh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409141152.VgCj23dh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/bpf/core.c: In function 'bpf_prog_array_free_sleepable':
>> kernel/bpf/core.c:2505:29: warning: comparison of distinct pointer types lacks a cast
    2505 |         if (!progs || progs == &bpf_empty_prog_array.hdr)
         |                             ^~


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

