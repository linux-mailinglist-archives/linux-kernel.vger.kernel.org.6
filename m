Return-Path: <linux-kernel+bounces-207226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EAF901424
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 03:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7212823DE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 01:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2766D4C98;
	Sun,  9 Jun 2024 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkl1MMXQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9C17F8
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 01:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717896939; cv=none; b=D1rbxi1QwIxnA5Om57oZwwa/ar0CIgH8VfExbPeZ7KkBMUEwVUf0t/hOEPJtpJ3RPYczZjhVp60n6PzaRsfK2AneBGSCr4mXxq/Njoo9Meg3JE+vxcOdBNNV3W1OluOHVKzc0GNV8bkF6IBgyNwR97230H/DcgBRClzUofSoU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717896939; c=relaxed/simple;
	bh=oJHizDTlgk7iiOeTs8+y1dXRJeUMx1LlY+wokuoqr4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plM8Hmq1Xz6JrGGvEVQwd8fZ3gVwix4I6FsTiWIA1MO9tpky5aMmLZLYBIgjSHtUSCyJI6S2ygwrpBPb6dlznJ2utoAPh5Jxvd8pYvGXLDyE1O27xAqhNbA7fTbzfmiuLbfuc/61JO3skM0cENzBWy0UxA6bT/8rLOfM/iT6qI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkl1MMXQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717896937; x=1749432937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oJHizDTlgk7iiOeTs8+y1dXRJeUMx1LlY+wokuoqr4U=;
  b=nkl1MMXQtzThVuhsSb7WoVTQeyHCOPsiCL0rYgkIy8VQG/mhofXLZ/MV
   O8OMTnDY8hqxD0vNHiqT4zHv8r6HeHB0CJftNgqfR1z8RIe4TdLykNLe9
   wmAzLmwGuQcH5j5m4RH8pg6fmOu/hrpE9hx7EIBzu0m614Eny5uf13yqJ
   RFC7Kodz7ZQAU8Lw+qNfL80pNukYryXhC3WgBA/NWyoltjRVd6hTEsjSF
   gK9ksNck+zlMx/Zr3WUQ9qk755cAEIuxE43528dWctt5bmGKvVyz2BkYL
   T9/+/NASDJYHSZ/SvDeE13GfFZHFwWtcrAAnsFoZCNaCytqY0C7lsIJI8
   A==;
X-CSE-ConnectionGUID: zQ6EODjOScCfMQpDeCTgpw==
X-CSE-MsgGUID: nRj/fx1SThuzRcyG6iY80w==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="32081336"
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="32081336"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 18:35:37 -0700
X-CSE-ConnectionGUID: +OZUXgVJS92pO40bcZYUVA==
X-CSE-MsgGUID: 1JBw/102Sviaozy4fTCeLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="69483281"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 Jun 2024 18:35:35 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sG7T3-0000jQ-0v;
	Sun, 09 Jun 2024 01:35:33 +0000
Date: Sun, 9 Jun 2024 09:35:22 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>
Subject: Re: [PATCH v4 1/2] devcoredump: Add dev_coredumpm_timeout()
Message-ID: <202406090938.yRretx5x-lkp@intel.com>
References: <20240607193220.229760-1-jose.souza@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240607193220.229760-1-jose.souza@intel.com>

Hi José,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-xe/drm-xe-next]
[also build test WARNING on wireless/main linus/master v6.10-rc2 next-20240607]
[cannot apply to driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus wireless-next/main]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jos-Roberto-de-Souza/drm-xe-Increase-devcoredump-timeout/20240608-033441
base:   https://gitlab.freedesktop.org/drm/xe/kernel.git drm-xe-next
patch link:    https://lore.kernel.org/r/20240607193220.229760-1-jose.souza%40intel.com
patch subject: [PATCH v4 1/2] devcoredump: Add dev_coredumpm_timeout()
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240609/202406090938.yRretx5x-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240609/202406090938.yRretx5x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406090938.yRretx5x-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/net/bluetooth/hci_core.h:36,
                    from net/bluetooth/coredump.c:10:
>> include/net/bluetooth/coredump.h:9: warning: "DEVCOREDUMP_TIMEOUT" redefined
       9 | #define DEVCOREDUMP_TIMEOUT     msecs_to_jiffies(10000) /* 10 sec */
         | 
   In file included from net/bluetooth/coredump.c:6:
   include/linux/devcoredump.h:16: note: this is the location of the previous definition
      16 | #define DEVCOREDUMP_TIMEOUT     (HZ * 60 * 5)
         | 


vim +/DEVCOREDUMP_TIMEOUT +9 include/net/bluetooth/coredump.h

9695ef876fd122 Abhishek Pandit-Subedi 2023-03-30   8  
9695ef876fd122 Abhishek Pandit-Subedi 2023-03-30  @9  #define DEVCOREDUMP_TIMEOUT	msecs_to_jiffies(10000)	/* 10 sec */
9695ef876fd122 Abhishek Pandit-Subedi 2023-03-30  10  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

