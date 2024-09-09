Return-Path: <linux-kernel+bounces-321940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE540972185
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCCA283F3B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F158224F6;
	Mon,  9 Sep 2024 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YWDfU5V8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73A54278
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 18:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725905144; cv=none; b=quY+jZJZrGtBL1ddXuziE10XPXIbbpsQgvupzMwa3/xNelOWJkDCEwTd3Zi/S+gENfZfdu9gLL3z1opTdPFa6yGuzs1S85be7dhQcAJ+BpAS5UGKkLOw9chR2VG6J69mVDnFal94S8cI7cECpmkpKOkakrh1M7f10ro7qK1LZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725905144; c=relaxed/simple;
	bh=b2vp8tZGXoYiqSYRqewBCoV1ds+dOr7furgT1Y2unnw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aQ3+1f7qraPsWw2zncNnPjcHe+zxelKAg+NaF5lWhhe7/FhqWL0efK8dj6jPq2+weW4vwvHXBXkPJiLqEQkcQKFy1COX5mu/9ZjaQL9mNYT0Epr5kaDGTtWIIKRcVTz5TcSVzDuV/ZE/aDKXKMcHsMekKwuzOesdoCDnAoQVGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YWDfU5V8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725905143; x=1757441143;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b2vp8tZGXoYiqSYRqewBCoV1ds+dOr7furgT1Y2unnw=;
  b=YWDfU5V8Xnep3ibik9lVYY9CqD29WY2L0AWcBnmbFarG4U+2wHE+yKGX
   w7BsC6J6WlyUEQrcUUXzyZDct0xT/SiXxbak5Lx6clXLg7cHZE0MymYUw
   tE2TNFB8hKjsObD4akiKKj/KMI1sNT3WW5AiRzyOGmVIGW1Ha5LBIKxum
   Sw4rnPBX6H6kl79fepNkw0928jhcaNZp7gqZdrezW/q+yYmJa9icHdb4r
   4/KZTfBqT8x84al2Nrqkj/MMRR7ENYnkO6TgOx4zDhYM58vB2ur37L3ii
   C2hXSSfdqjmW6fDFk6T7LhvsgbiWYhnlPJLHtv+ufS4vgUb1Lx4HIuHrO
   A==;
X-CSE-ConnectionGUID: bBLOq7rCS6aJheuFOY7FBQ==
X-CSE-MsgGUID: FNfDKRn9RnmSfd0jiU5l+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24769472"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="24769472"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 11:05:43 -0700
X-CSE-ConnectionGUID: y3Crg97uRK2wLop/8xQWKQ==
X-CSE-MsgGUID: 6gJbkN1JSHuP14pKx2UX4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="67043912"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 09 Sep 2024 11:05:41 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snile-000F3S-36;
	Mon, 09 Sep 2024 18:05:38 +0000
Date: Tue, 10 Sep 2024 02:05:29 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: ERROR: start_text address is c000000000000700, should be
 c000000000000200
Message-ID: <202409100106.A8692079-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   da3ea35007d0af457a0afc87e84fddaebc4e0b63
commit: 6e2fdceffdc6bd7b8ba314a1d1b976721533c8f9 tracing: Use refcount for trace_event_file reference counter
date:   5 weeks ago
config: powerpc64-randconfig-003-20240908 (https://download.01.org/0day-ci/archive/20240910/202409100106.A8692079-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409100106.A8692079-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409100106.A8692079-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ERROR: start_text address is c000000000000700, should be c000000000000200
   ERROR: try to enable LD_HEAD_STUB_CATCH config option
   ERROR: see comments in arch/powerpc/tools/head_check.sh

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

