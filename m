Return-Path: <linux-kernel+bounces-339756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1E9869F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CBF1C2342B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 00:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ED91A3BD4;
	Wed, 25 Sep 2024 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d3PNbchF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621EC14AD24;
	Wed, 25 Sep 2024 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727308789; cv=none; b=B8lxxBQBhO2O61ncKU+/dMxjPNbl55E+FbjlV3WkKBn6NqOQaxdtMMADN70d0BblWxW+sxWKpDoh46aPmftpfpOFiW+nCeaeKlP3XFu7JlHqHo8AuOYTktMC5j+OR5zVX5jXGZKjZgJRoE9cadLpVcg0skGrWnnCET+VACij/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727308789; c=relaxed/simple;
	bh=CSK//gxzmcctiDTYayy7uXe9etmH2AVe0UsRHlfWu8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsKDEyjMklCeH5DYrjEjt0i8ciqT41Ake31dojkiDCALQ5uLgdWPneiNghpltBhOty0/kYuShlZY1aAY/uk1cQieDNbHG+Y9pAKJepDQk7nbGSoxLeLi86DQCV555sFKMxsPvsWgGfztH6zmQ70PnaLvKJxzgLNqZS86aNog0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d3PNbchF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727308788; x=1758844788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CSK//gxzmcctiDTYayy7uXe9etmH2AVe0UsRHlfWu8k=;
  b=d3PNbchFeDeLQd/UEWJsx+QkJQ28TUYTn8lOJO0GYNTLpeChNDGnpmVK
   S05aZ16r9wzqUg37NelxxLeuZ6DnsXgLQA/IS0Mln1dcGibkAJXNZz/sb
   XkYtx7e4Wzjir36mJEhFzxFCm3rJH2ZOToGKb3HZmb78vt/xYSaO4MmFi
   dFBtGMpmiIujEEjRFHSraFreHZns3+QYyvrENlPM0HMo8ELVb03gjFuuv
   R68YSAFzTxcaadP/VWljpKDmNXBh2K/BFGA5YRSSQTocJVyAiHC2GvEhl
   4SVvNNToEuGvyunYmFNiP7AUIgNsCu/6MzzoiEwwz2clI4WasYZdLQZSi
   g==;
X-CSE-ConnectionGUID: j4bGU+6pQoCmsqkkxdOMvQ==
X-CSE-MsgGUID: S4KVrQ1xSNy6R91C+jLyBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="29275787"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="29275787"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 16:59:47 -0700
X-CSE-ConnectionGUID: fpWLMYKYTqGUW+XR2+GQ3Q==
X-CSE-MsgGUID: nczqUb9DS+6lSCV651UHeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="76327756"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2024 16:59:44 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stbv4-000K3N-11;
	Wed, 25 Sep 2024 23:59:42 +0000
Date: Thu, 26 Sep 2024 07:58:49 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, linux-usb@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Use common error handling code in
 update_property_block()
Message-ID: <202409260728.uNVNmTvy-lkp@intel.com>
References: <26b7f215-4f83-413c-9dab-737d790053c0@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26b7f215-4f83-413c-9dab-737d790053c0@web.de>

Hi Markus,

kernel test robot noticed the following build errors:

[auto build test ERROR on westeri-thunderbolt/next]
[also build test ERROR on linus/master v6.11 next-20240925]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/thunderbolt-Use-common-error-handling-code-in-update_property_block/20240925-161308
base:   https://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git next
patch link:    https://lore.kernel.org/r/26b7f215-4f83-413c-9dab-737d790053c0%40web.de
patch subject: [PATCH] thunderbolt: Use common error handling code in update_property_block()
config: arc-randconfig-001-20240926 (https://download.01.org/0day-ci/archive/20240926/202409260728.uNVNmTvy-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240926/202409260728.uNVNmTvy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409260728.uNVNmTvy-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/thunderbolt/xdomain.c: In function 'update_property_block':
>> drivers/thunderbolt/xdomain.c:703:30: error: 'dir' undeclared (first use in this function); did you mean 'idr'?
     703 |         tb_property_free_dir(dir);
         |                              ^~~
         |                              idr
   drivers/thunderbolt/xdomain.c:703:30: note: each undeclared identifier is reported only once for each function it appears in


vim +703 drivers/thunderbolt/xdomain.c

   645	
   646	static void update_property_block(struct tb_xdomain *xd)
   647	{
   648		mutex_lock(&xdomain_lock);
   649		mutex_lock(&xd->lock);
   650		/*
   651		 * If the local property block is not up-to-date, rebuild it now
   652		 * based on the global property template.
   653		 */
   654		if (!xd->local_property_block ||
   655		    xd->local_property_block_gen < xdomain_property_block_gen) {
   656			struct tb_property_dir *dir;
   657			int ret, block_len;
   658			u32 *block;
   659	
   660			dir = tb_property_copy_dir(xdomain_property_dir);
   661			if (!dir) {
   662				dev_warn(&xd->dev, "failed to copy properties\n");
   663				goto out_unlock;
   664			}
   665	
   666			/* Fill in non-static properties now */
   667			tb_property_add_text(dir, "deviceid", utsname()->nodename);
   668			tb_property_add_immediate(dir, "maxhopid", xd->local_max_hopid);
   669	
   670			ret = tb_property_format_dir(dir, NULL, 0);
   671			if (ret < 0) {
   672				dev_warn(&xd->dev, "local property block creation failed\n");
   673				goto out_free_dir;
   674			}
   675	
   676			block_len = ret;
   677			block = kcalloc(block_len, sizeof(*block), GFP_KERNEL);
   678			if (!block)
   679				goto out_free_dir;
   680	
   681			ret = tb_property_format_dir(dir, block, block_len);
   682			if (ret) {
   683				dev_warn(&xd->dev, "property block generation failed\n");
   684				kfree(block);
   685				goto out_free_dir;
   686			}
   687	
   688			tb_property_free_dir(dir);
   689			/* Release the previous block */
   690			kfree(xd->local_property_block);
   691			/* Assign new one */
   692			xd->local_property_block = block;
   693			xd->local_property_block_len = block_len;
   694			xd->local_property_block_gen = xdomain_property_block_gen;
   695		}
   696	
   697	out_unlock:
   698		mutex_unlock(&xd->lock);
   699		mutex_unlock(&xdomain_lock);
   700		return;
   701	
   702	out_free_dir:
 > 703		tb_property_free_dir(dir);
   704		goto out_unlock;
   705	}
   706	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

