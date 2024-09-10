Return-Path: <linux-kernel+bounces-322422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296BB9728CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCBA1C23D34
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724151684A6;
	Tue, 10 Sep 2024 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvGdvPYN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92EE12E48
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725945213; cv=none; b=ptokFflKLKwyx2Xc8daU8v+283PuSZdVzXPlRsZRLRD8i5BeM6nKIZEB3HsfrU/0k3XxKjPyF6nADR1lQjViYdl/lW3XxDAz9ONWZ82qEcocRCBiij8gL1EX0r0cn6JsE1BKJ+4QctGg0sMKdysReACWF7yBoBgfvxKu50Gf3HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725945213; c=relaxed/simple;
	bh=SuuZllRm35ADvfaTLAuyMG97Is+OLQc+Q2WWo5c4Rp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RS3yW4SLEYTVGO5B46IrdXb2sNfBA6rgla36gAIhz60/c1ZLo0fREMZr86a4lbMahi4wvIX6PPlnuT0GNlX0jYI6yJ7oAc/BfSxyamf9Zz5usTVnOKhIftZpdZDMsO/xeejrur6TL28z3riKMc/tTYakoYZ0BFSWB1MuoTjAq8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvGdvPYN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725945212; x=1757481212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SuuZllRm35ADvfaTLAuyMG97Is+OLQc+Q2WWo5c4Rp0=;
  b=QvGdvPYNET9Q2avK1JduI7L+GgE0EvsfHoXgtjP6vIV7IY3c8cu/T0QH
   SNKRXnqS18qYFacRimfCDYt5Ady1niE4RbiiO+cyBtCN5i2RuL7JootrL
   JNS6hfFFRMvHQrfCcRw8RR7zSm/5OmSVIr0DT9pzDjdPGHVvqc3I1NzSf
   TS2OAdXQ7K2WaQiO3Rlh3Xim+JFdhycNU8RM8uTO3yF4eXyvBsRKkfRvx
   v55Kq86GCKddfvCLUs2gWnFQ7t8raysu+L1/hFwXLnr3eI6qAD+iwT1+X
   j3T+zjbPjCgWHGeTUrSiTNRCKp9XwJqHIvT/UWGvWxDwQUvKtqi8MkqOY
   g==;
X-CSE-ConnectionGUID: ForRtqDfTGmdLqUqSreyGw==
X-CSE-MsgGUID: Z9hRDAJBQs+ezJKFqsAr3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24814209"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="24814209"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 22:13:31 -0700
X-CSE-ConnectionGUID: tHw762XeQ7qFiwBUe0zozA==
X-CSE-MsgGUID: R0NOdDYlSSy3Go/mTses5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="66924553"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 09 Sep 2024 22:13:29 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sntBu-00006B-2k;
	Tue, 10 Sep 2024 05:13:26 +0000
Date: Tue, 10 Sep 2024 13:12:27 +0800
From: kernel test robot <lkp@intel.com>
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
	michael.christie@oracle.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [RESEND PATCH v1 1/7] vhost: Add a new module_param for enable
 kthread
Message-ID: <202409101256.eWKWH1mw-lkp@intel.com>
References: <20240909020138.1245873-2-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909020138.1245873-2-lulu@redhat.com>

Hi Cindy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.11-rc7 next-20240909]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vhost-Add-kthread-support-in-function-vhost_worker_queue/20240909-110046
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20240909020138.1245873-2-lulu%40redhat.com
patch subject: [RESEND PATCH v1 1/7] vhost: Add a new module_param for enable kthread
config: x86_64-randconfig-123-20240910 (https://download.01.org/0day-ci/archive/20240910/202409101256.eWKWH1mw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409101256.eWKWH1mw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409101256.eWKWH1mw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/vhost/vhost.c:44:6: sparse: sparse: symbol 'enforce_kthread' was not declared. Should it be static?
   drivers/vhost/vhost.c:1898:54: sparse: sparse: self-comparison always evaluates to false
   drivers/vhost/vhost.c:1899:54: sparse: sparse: self-comparison always evaluates to false
   drivers/vhost/vhost.c:1900:55: sparse: sparse: self-comparison always evaluates to false
   drivers/vhost/vhost.c:2155:46: sparse: sparse: self-comparison always evaluates to false
   drivers/vhost/vhost.c:2235:48: sparse: sparse: self-comparison always evaluates to false

vim +/enforce_kthread +44 drivers/vhost/vhost.c

    35	
    36	static ushort max_mem_regions = 64;
    37	module_param(max_mem_regions, ushort, 0444);
    38	MODULE_PARM_DESC(max_mem_regions,
    39		"Maximum number of memory regions in memory map. (default: 64)");
    40	static int max_iotlb_entries = 2048;
    41	module_param(max_iotlb_entries, int, 0444);
    42	MODULE_PARM_DESC(max_iotlb_entries,
    43		"Maximum number of iotlb entries. (default: 2048)");
  > 44	bool enforce_kthread = true;
    45	module_param(enforce_kthread, bool, 0444);
    46	MODULE_PARM_DESC(enforce_kthread, "enable vhost to use kthread (default: Y)");
    47	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

