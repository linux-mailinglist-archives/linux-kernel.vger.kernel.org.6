Return-Path: <linux-kernel+bounces-367134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A599FEFE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D431B245D1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F4165EE8;
	Wed, 16 Oct 2024 02:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdCpU6lF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E103141C7F;
	Wed, 16 Oct 2024 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729046611; cv=none; b=kPKRdWJ3kXkqpJ9n7u2HGgP7I7V9stCpuFqRG7+jYp307NtyhV3tYF8Ho77qlPNkkD0YoANmxRt568dGRp4IXg2IobmyfcpN1HXJNxoHcjJzweAT9pYOcfPU7kIAs6zGgl0ES8ej0o9aLx42Rayk+dSNjAssyrStY6VVHLz0XvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729046611; c=relaxed/simple;
	bh=gmClh4vC9apW7WXPxFb5ohfP2cG8mfYVLZj/iwBafnc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OLH8jFtI/bDE9Po6toch1snxbUwKLr2bRTsI/wo7Vth76/xPy3JxGN/G8oiwuGxxNTNFj9uZHVPN1Sz9SwXktShxn6p83x5MsAQpbvEWk9iR2xi/s9KkGIrcSFfIeu3skoeLgqJTfufFcFfqA7pVtBjWit+VcF3gEfHa61iDXT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdCpU6lF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729046610; x=1760582610;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gmClh4vC9apW7WXPxFb5ohfP2cG8mfYVLZj/iwBafnc=;
  b=AdCpU6lF9lPtOs12xFijF+jzIsgyo+f3EfRFWSy42lFdPyqNrBAnWFqb
   vzgk0Ysw0GtBL4mz22gWjzZXEISCkj8ry3oS5fb3xlwYVrBySORhKa7ap
   zU8ofy2nvRADReEZDQcxkqPZ6w3YCf+TnHZVNQKLPtwI0Q7tT624BE2bw
   9J8qfrW0Dlizum/ClNEWn/GxHvej9PsE4TushBB8tIQZ1jaBL6V26puV1
   CYtd0pxyOn2yWwMuuQhXBe9jrk+YJBg3UORUddmq2W3dm8YvsPPTIYH55
   /eq5WRY5yixFzBIkgj9jbRV3e4HVWfYWj2EZB3iuVJv350nOz07iDB4Om
   Q==;
X-CSE-ConnectionGUID: M/4toGfDQD2od/dSXGFjBg==
X-CSE-MsgGUID: 65ajBRTVSo+4S8G6KUEADQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31347173"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="31347173"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 19:43:29 -0700
X-CSE-ConnectionGUID: /kM2ZodySLSglj5Kci5apA==
X-CSE-MsgGUID: DmkaH0FiS9GME18WLuBayA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78545703"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 15 Oct 2024 19:43:27 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0u0T-000KBU-0V;
	Wed, 16 Oct 2024 02:43:25 +0000
Date: Wed, 16 Oct 2024 10:42:51 +0800
From: kernel test robot <lkp@intel.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-doc@vger.kernel.org
Subject: [tip:timers/core 40/40] htmldocs: Warning: drivers/regulator/core.c
 references a file that doesn't exist: Documentation/timers/timers-howto.rst
Message-ID: <202410161059.a0f6IBwj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Anna-Maria,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
head:   1f455f601e2060497f9883991e8d5e79fbc7b047
commit: 1f455f601e2060497f9883991e8d5e79fbc7b047 [40/40] timers/Documentation: Cleanup delay/sleep documentation
reproduce: (https://download.01.org/0day-ci/archive/20241016/202410161059.a0f6IBwj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410161059.a0f6IBwj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> Warning: drivers/regulator/core.c references a file that doesn't exist: Documentation/timers/timers-howto.rst
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

