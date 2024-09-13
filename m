Return-Path: <linux-kernel+bounces-327658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AFC9778EB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA7B1F25EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FDD1AE845;
	Fri, 13 Sep 2024 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SN8PIuK5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC35187350
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726209761; cv=none; b=dxCpRXMIkCuFsv7+BtKC2HunR3x0VmSVvMavcRw+MiJW+1i6Sb1QhMKaDdqz21yiPPzYqViCPdXoidwuLp8e36w7CVi17RdfO047BEEjlmljhAf7Gt2PkQUQFZrh08k03rYi35ukxas+Q57pEdPkcwTiH528kbbtGdec+BgKrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726209761; c=relaxed/simple;
	bh=AR7yZuTlGot/y1jh/5CMWzyHwGVxELvTUjzMdobZYKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koycxSiv2A51Dbvwa8f0aK/EkPb0mNBULdXFM71zPRXE1k51WBAH0LHiD8Di7MjmI0MR7gLk4JF6nJmZpFWJgegi91FTmrsffLBZp7dybJwpLOggB6YcW2iMcJaCFsLfn0s4rqRwkSYxbYM8bz9NCVRaDNqTaPg73tdJwdYelSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SN8PIuK5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726209760; x=1757745760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AR7yZuTlGot/y1jh/5CMWzyHwGVxELvTUjzMdobZYKo=;
  b=SN8PIuK5hZGX74lqO/juYwclyKAi89kjhOgMEcJSNWeYiLKHsR2ND5oQ
   xdEUxiUkcLh4HrHwvCKwFtMAyCXiGJQdxa6+fW3ETUZWUBrqc9IbDkbYB
   lsetjXeT4R+k154OxRFPYizCrU8gOapj7OdMvpyMnxdQmCI+Wqah0kQUg
   Sz7nPZHwXknuMLgAVIAp8qXltd/LS4iGIS4WEtc9YU+NOrfXNmnl0WLCC
   ykmpJPtv30ykTVaWXvFDE1fN3kfpnCFcCPKDNW7ttgZXtKCQhTwxXR1RR
   lkeUll7yttZKvFYXrFwAroJhHUuVkQdd6vZLmGx5h7MH57cKRNOBfnV9M
   A==;
X-CSE-ConnectionGUID: cFqSXHIZRsabrjGFiCnuiQ==
X-CSE-MsgGUID: abzIZ9S5TJybKWkdLPt7AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24920928"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24920928"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 23:42:39 -0700
X-CSE-ConnectionGUID: qB4aAGkARSaQA2TIf4KWgQ==
X-CSE-MsgGUID: xw5eili4TSm4qkwlyDT9Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="68261423"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 12 Sep 2024 23:42:38 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sp00p-00066e-0U;
	Fri, 13 Sep 2024 06:42:35 +0000
Date: Fri, 13 Sep 2024 14:42:33 +0800
From: kernel test robot <lkp@intel.com>
To: Kaixin Wang <kxwang23@m.fudan.edu.cn>, sre@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andriy.shevchenko@linux.intel.com,
	rdunlap@infradead.org, linux-kernel@vger.kernel.org,
	21210240012@m.fudan.edu.cn, 21302010073@m.fudan.edu.cn,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>
Subject: Re: [PATCH] HSI: ssi_protocol: Fix use after free vulnerability in
 ssi_protocol Driver Due to Race Condition
Message-ID: <202409131457.oUtHawfD-lkp@intel.com>
References: <20240911151915.844957-1-kxwang23@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911151915.844957-1-kxwang23@m.fudan.edu.cn>

Hi Kaixin,

kernel test robot noticed the following build errors:

[auto build test ERROR on sre-hsi/for-next]
[also build test ERROR on linus/master v6.11-rc7 next-20240912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kaixin-Wang/HSI-ssi_protocol-Fix-use-after-free-vulnerability-in-ssi_protocol-Driver-Due-to-Race-Condition/20240911-232206
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git for-next
patch link:    https://lore.kernel.org/r/20240911151915.844957-1-kxwang23%40m.fudan.edu.cn
patch subject: [PATCH] HSI: ssi_protocol: Fix use after free vulnerability in ssi_protocol Driver Due to Race Condition
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240913/202409131457.oUtHawfD-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131457.oUtHawfD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409131457.oUtHawfD-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hsi/clients/ssi_protocol.c: In function 'ssi_protocol_remove':
>> drivers/hsi/clients/ssi_protocol.c:1158:37: error: expected ';' before 'kfree'
    1158 |         cancel_work_sync(&ssi->work)
         |                                     ^
         |                                     ;
    1159 |         kfree(ssi);
         |         ~~~~~                        


vim +1158 drivers/hsi/clients/ssi_protocol.c

  1148	
  1149	static int ssi_protocol_remove(struct device *dev)
  1150	{
  1151		struct hsi_client *cl = to_hsi_client(dev);
  1152		struct ssi_protocol *ssi = hsi_client_drvdata(cl);
  1153	
  1154		list_del(&ssi->link);
  1155		unregister_netdev(ssi->netdev);
  1156		ssip_free_cmds(ssi);
  1157		hsi_client_set_drvdata(cl, NULL);
> 1158		cancel_work_sync(&ssi->work)
  1159		kfree(ssi);
  1160	
  1161		return 0;
  1162	}
  1163	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

