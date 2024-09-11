Return-Path: <linux-kernel+bounces-324927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230F79752C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DACA9282118
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893F618C91D;
	Wed, 11 Sep 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VatFr+6A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2CD185923
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058817; cv=none; b=Weaixx8n/F4yc4ie55B0TGNPvg+iGnK/JNAAMCNNC9v+dALY1+xHrzAeZ4qzzRNOy1oTjNfNjRFQlmN/bt71nyHa9LQd3dszD/JalPGuMU/Dzxu4iqkJGnuMSK9ldxdWbcQlKdnCkrytYnkkWj4m346DEl6TGOA5a52cE9Ovh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058817; c=relaxed/simple;
	bh=fNEw9q5L02wFt/SbtQ2tsftoa1czNPsPbeHhsyx+RmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+mFK10wF9okgYfSOMQSI3tIyqeGUjnw/wjAvFJgYnJCxeeu1Aef48N1/OF90Ea0TqspcoLY9qobVgZYOcObCdu8Tg0FhrnfPZaP7Iy2ZYm4GVixNACQ7dg5zyWxSgcaY3di45P/ZDgUtYLrpRRC82FjuLhysXQZDVLgft+0/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VatFr+6A; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726058814; x=1757594814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fNEw9q5L02wFt/SbtQ2tsftoa1czNPsPbeHhsyx+RmE=;
  b=VatFr+6AlA0CvxQzrgbweb6FX/opSOu06FPlR8gN5IeN4+KiiPQxXfFz
   9GQa5yrIVBHDCsHzXLYM66t7BBFNZhO3bZWiDRexHLOENoVJFZTgr45Pm
   IWs/5DCsnNnkjkyBg2zcRdZagWq/4hj38JlUR/ZjwZ4gM2jh0L0C7vMll
   yCkMCkdPrOuus8d/87msQlznkP3Ie9WZvvCFW5ro8S7tgGYeeaWSI7Ct7
   TR5pg2QEOjwwAjvEqtn8CpDmjbDD4pQhW5hiFCB8hggBicOtXeZNOnEY4
   yALWMI7y+0SLmBCszrM/eGdIYamo9ezXWiomxiKqPLITavztm3jpwLOP7
   Q==;
X-CSE-ConnectionGUID: G7Ti4gVCS5S30eKJowtpEQ==
X-CSE-MsgGUID: rV09t/0CTYW7dp05cPUR+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35447099"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="35447099"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 05:46:53 -0700
X-CSE-ConnectionGUID: 59EqOoXQTnCHSJmxUJHkng==
X-CSE-MsgGUID: lMreyNQYRj2UT0Z0kddTEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="71494827"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 11 Sep 2024 05:46:52 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soMkD-0003ZC-2c;
	Wed, 11 Sep 2024 12:46:49 +0000
Date: Wed, 11 Sep 2024 20:46:19 +0800
From: kernel test robot <lkp@intel.com>
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
	michael.christie@oracle.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1 6/7] vhost: Add kthread support in function
 vhost_worker_create
Message-ID: <202409112050.3zbvpbyT-lkp@intel.com>
References: <20240909013531.1243525-7-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909013531.1243525-7-lulu@redhat.com>

Hi Cindy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mst-vhost/linux-next]
[also build test WARNING on linus/master v6.11-rc7 next-20240910]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vhost-Add-a-new-module_param-for-enable-kthread/20240909-093852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
patch link:    https://lore.kernel.org/r/20240909013531.1243525-7-lulu%40redhat.com
patch subject: [PATCH v1 6/7] vhost: Add kthread support in function vhost_worker_create
config: arc-randconfig-001-20240911 (https://download.01.org/0day-ci/archive/20240911/202409112050.3zbvpbyT-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240911/202409112050.3zbvpbyT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409112050.3zbvpbyT-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/vhost/vhost.c: In function 'vhost_worker_queue':
   drivers/vhost/vhost.c:273:13: error: 'use_kthread' undeclared (first use in this function)
     273 |         if (use_kthread) {
         |             ^~~~~~~~~~~
   drivers/vhost/vhost.c:273:13: note: each undeclared identifier is reported only once for each function it appears in
   drivers/vhost/vhost.c: In function 'vhost_workers_free':
   drivers/vhost/vhost.c:805:13: error: 'use_kthread' undeclared (first use in this function)
     805 |         if (use_kthread)
         |             ^~~~~~~~~~~
   drivers/vhost/vhost.c: In function 'vhost_worker_create':
   drivers/vhost/vhost.c:986:13: error: 'use_kthread' undeclared (first use in this function)
     986 |         if (use_kthread)
         |             ^~~~~~~~~~~
   drivers/vhost/vhost.c: In function 'vhost_free_worker':
   drivers/vhost/vhost.c:1030:13: error: 'use_kthread' undeclared (first use in this function)
    1030 |         if (use_kthread)
         |             ^~~~~~~~~~~
   drivers/vhost/vhost.c: In function 'vhost_worker_create':
>> drivers/vhost/vhost.c:990:1: warning: control reaches end of non-void function [-Wreturn-type]
     990 | }
         | ^


vim +990 drivers/vhost/vhost.c

   983	
   984	static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
   985	{
   986		if (use_kthread)
   987			return vhost_worker_create_kthread(dev);
   988		else
   989			return vhost_worker_create_task(dev);
 > 990	}
   991	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

