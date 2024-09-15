Return-Path: <linux-kernel+bounces-329673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C20979486
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 05:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989141F22B34
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 03:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB15C125DF;
	Sun, 15 Sep 2024 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtwGmcf6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC6E184E
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 03:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726370314; cv=none; b=l20lGFVz+/x6lZ7tJdaM2+HBy+vNjv38mMO5VubABqhjMxEdmJhErS17Ml4wqKiZAq3x+wXkhUYspMVfwvq8MrihMoPCR0MVyCz8A+yLbAUsS6o2l5cOg/0OouuV6rXfL0pb0MnbZHrcEVxGvesOE/kPPMSQlgjKgGRzn2A3aWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726370314; c=relaxed/simple;
	bh=ZRydN+dM+3OvRRLgs4jhjaBSzfoQ7MPwG7EOHmcE3FE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n/uO+XXOdgZMQLzMoyOAc0kJ/irB7stKwHD7sa/9YQoeCgcnWDu5nTg2UTjxgXbhGbPQG6BBymC1kpIcQdtQLUdOnrvB0W9S28e1g5rmINHvTJQWIufUTh/60QMgCcaODlpNssgvJyoTKFPsyeQudXCUSKbFxatzi4zMGgfOhjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtwGmcf6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726370313; x=1757906313;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZRydN+dM+3OvRRLgs4jhjaBSzfoQ7MPwG7EOHmcE3FE=;
  b=RtwGmcf60KeTrhUqcFCiQpY20Jpmj1Uq/NgSIr4w1h5kMBKM1lag1rAC
   +13uy1vbY2gmxcTdlKkMJ/IMYK7G0KSb0dHOPhTVfkkOAx2SRTYGZvqYN
   /DFbvoV9P88T2w1IRkXwZVkJ91u1Az8QM8QM+r2CBnOzTKLGprCy52RL+
   951xHnQcEGAxAaDZtqMpzMRb6w2UXBgArY33keFNkIB97Rcdse+YeF6mo
   eBbTLjBPpFCwLaPKGdViRps4basTEynhQ+MhYQdSVA8u/e709HuRCutfs
   jwUV3tEA6rEhcn/U8AMvgOFFPPgyzEvKBr4xRWLcfhn5VX09RmNHzKrz4
   A==;
X-CSE-ConnectionGUID: WAklS30bT7CVcbhTjkOP8A==
X-CSE-MsgGUID: 37ICUZrWSUmT52zp1LDEuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="25110084"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="25110084"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 20:18:32 -0700
X-CSE-ConnectionGUID: /iHr1LBpRZuiH1v4RojWWA==
X-CSE-MsgGUID: UgC0I8g9TUiqAhDuL+2B9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="72911982"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 14 Sep 2024 20:18:30 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spfmN-0008NI-2r;
	Sun, 15 Sep 2024 03:18:27 +0000
Date: Sun, 15 Sep 2024 11:18:26 +0800
From: kernel test robot <lkp@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>
Subject: drivers/gpu/drm/xe/xe_rtp.c:151:2-3: Unneeded semicolon
Message-ID: <202409151152.pJ4ukp5k-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0babf683783ddca06551537c6781e413cfe8d27b
commit: 72906d340b60f3dae545deef77376a0f598bece7 drm/xe/rtp: Split rtp process initialization
date:   9 months ago
config: alpha-randconfig-r062-20240915 (https://download.01.org/0day-ci/archive/20240915/202409151152.pJ4ukp5k-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409151152.pJ4ukp5k-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/xe/xe_rtp.c:151:2-3: Unneeded semicolon

vim +151 drivers/gpu/drm/xe/xe_rtp.c

   134	
   135	static void rtp_get_context(struct xe_rtp_process_ctx *ctx,
   136				    struct xe_hw_engine **hwe,
   137				    struct xe_gt **gt,
   138				    struct xe_device **xe)
   139	{
   140		switch (ctx->type) {
   141		case XE_RTP_PROCESS_TYPE_GT:
   142			*hwe = NULL;
   143			*gt = ctx->gt;
   144			*xe = gt_to_xe(*gt);
   145			break;
   146		case XE_RTP_PROCESS_TYPE_ENGINE:
   147			*hwe = ctx->hwe;
   148			*gt = (*hwe)->gt;
   149			*xe = gt_to_xe(*gt);
   150			break;
 > 151		};
   152	}
   153	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

