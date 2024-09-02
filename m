Return-Path: <linux-kernel+bounces-310761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E820B9680EB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6107DB20764
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C97E17C22E;
	Mon,  2 Sep 2024 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qju6jSZK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D7014900E
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263451; cv=none; b=AhQ/Nh/e5UYw93O3BQUWpkuQT2j/agf4oLMVX7eTCUdWzeo5M1QtO/NLeOP6dkzI+z6HJYjM/Tlcd7wxozUK2bXMxxDqk7d/Pl0Ss341YJSD08kSAXFDUgiLPZOabAJIgk1xfmsrdL7j8a/aJ9+r0hlfhIz0rFelevXaDqFL4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263451; c=relaxed/simple;
	bh=S5+ORhvYHAjQ3Nu+w7aF/cDQYGF92UNOnE7o8O5LjSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiPjY2x/mQ6BVSz/lG7/t4UnoRXHpqRJxgPJ3ehLGhoidDA6IDyb36qy1fnUHTqc0pJpI7RZdaoOU+gUQxmi/YN5BpnttyJgbEQlI1/hBjN4hSZryqk1ryLyxnX/5/4WnTdxqhMtY6zmQHwMwrKc5Wos7NBbJZeDDtgqw4npYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qju6jSZK; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725263449; x=1756799449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S5+ORhvYHAjQ3Nu+w7aF/cDQYGF92UNOnE7o8O5LjSA=;
  b=Qju6jSZKV5UglgqIkDBrFY3ptWDE1gC08TGCvTEptU1jCYhb8GYwR3ut
   0YOcmDe3jJX/2L3jmfCEg+xmMny7kbbghJEWsGIwNiWFYzGRfSN9Qb0v9
   dfQeeUkwZ15K5Ue/3nueVVYKn9Uf/0x0HhwnMtw64jgueCVjIl/MeZvzE
   SEsA5VZ3XpHpExzLitEpLMwZ6cZyC6VunVMIMb7I3G0aYagKOz5gYzhj5
   7OjnwMiX7UvIrxIJhakZQCPVU1Rx0Ma4uCdTI26wPDa07VUaUk7p1gdE+
   gjpmiI0GiT1L6CMkK9m2nBgD4abc0ZrnG/bfpNzV9DFwgEXjU4ge5KFWf
   w==;
X-CSE-ConnectionGUID: JoE6ahTZSkKsY4qSkDY0qg==
X-CSE-MsgGUID: 51gi9KkaReOS5PXh01qsEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="34443948"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34443948"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 00:50:49 -0700
X-CSE-ConnectionGUID: zC2eh/4MSBKBTW1bD81/7g==
X-CSE-MsgGUID: DcouEchOSouNJH+PmlwD7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="87772741"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 02 Sep 2024 00:50:47 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sl1pl-0005GM-0q;
	Mon, 02 Sep 2024 07:50:45 +0000
Date: Mon, 2 Sep 2024 15:49:49 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] rpmb: fix error path in rpmb_dev_register()
Message-ID: <202409021532.QfH7shPj-lkp@intel.com>
References: <20240830061404.2831708-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830061404.2831708-1-jens.wiklander@linaro.org>

Hi Jens,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240829]
[cannot apply to v6.11-rc5 v6.11-rc4 v6.11-rc3 linus/master v6.11-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jens-Wiklander/rpmb-fix-error-path-in-rpmb_dev_register/20240830-141540
base:   next-20240829
patch link:    https://lore.kernel.org/r/20240830061404.2831708-1-jens.wiklander%40linaro.org
patch subject: [PATCH] rpmb: fix error path in rpmb_dev_register()
config: i386-randconfig-004-20240902 (https://download.01.org/0day-ci/archive/20240902/202409021532.QfH7shPj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240902/202409021532.QfH7shPj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409021532.QfH7shPj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/misc/rpmb-core.c: In function 'rpmb_dev_register':
>> drivers/misc/rpmb-core.c:199:1: warning: label 'err_id_remove' defined but not used [-Wunused-label]
     199 | err_id_remove:
         | ^~~~~~~~~~~~~


vim +/err_id_remove +199 drivers/misc/rpmb-core.c

1e9046e3a15460 Jens Wiklander 2024-08-14  146  
1e9046e3a15460 Jens Wiklander 2024-08-14  147  /**
1e9046e3a15460 Jens Wiklander 2024-08-14  148   * rpmb_dev_register - register RPMB partition with the RPMB subsystem
1e9046e3a15460 Jens Wiklander 2024-08-14  149   * @dev: storage device of the rpmb device
1e9046e3a15460 Jens Wiklander 2024-08-14  150   * @descr: RPMB device description
1e9046e3a15460 Jens Wiklander 2024-08-14  151   *
1e9046e3a15460 Jens Wiklander 2024-08-14  152   * While registering the RPMB partition extract needed device information
1e9046e3a15460 Jens Wiklander 2024-08-14  153   * while needed resources are available.
1e9046e3a15460 Jens Wiklander 2024-08-14  154   *
1e9046e3a15460 Jens Wiklander 2024-08-14  155   * Returns: a pointer to a 'struct rpmb_dev' or an ERR_PTR on failure
1e9046e3a15460 Jens Wiklander 2024-08-14  156   */
1e9046e3a15460 Jens Wiklander 2024-08-14  157  struct rpmb_dev *rpmb_dev_register(struct device *dev,
1e9046e3a15460 Jens Wiklander 2024-08-14  158  				   struct rpmb_descr *descr)
1e9046e3a15460 Jens Wiklander 2024-08-14  159  {
1e9046e3a15460 Jens Wiklander 2024-08-14  160  	struct rpmb_dev *rdev;
1e9046e3a15460 Jens Wiklander 2024-08-14  161  	int ret;
1e9046e3a15460 Jens Wiklander 2024-08-14  162  
1e9046e3a15460 Jens Wiklander 2024-08-14  163  	if (!dev || !descr || !descr->route_frames || !descr->dev_id ||
1e9046e3a15460 Jens Wiklander 2024-08-14  164  	    !descr->dev_id_len)
1e9046e3a15460 Jens Wiklander 2024-08-14  165  		return ERR_PTR(-EINVAL);
1e9046e3a15460 Jens Wiklander 2024-08-14  166  
1e9046e3a15460 Jens Wiklander 2024-08-14  167  	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
1e9046e3a15460 Jens Wiklander 2024-08-14  168  	if (!rdev)
1e9046e3a15460 Jens Wiklander 2024-08-14  169  		return ERR_PTR(-ENOMEM);
1e9046e3a15460 Jens Wiklander 2024-08-14  170  	rdev->descr = *descr;
1e9046e3a15460 Jens Wiklander 2024-08-14  171  	rdev->descr.dev_id = kmemdup(descr->dev_id, descr->dev_id_len,
1e9046e3a15460 Jens Wiklander 2024-08-14  172  				     GFP_KERNEL);
1e9046e3a15460 Jens Wiklander 2024-08-14  173  	if (!rdev->descr.dev_id) {
1e9046e3a15460 Jens Wiklander 2024-08-14  174  		ret = -ENOMEM;
1e9046e3a15460 Jens Wiklander 2024-08-14  175  		goto err_free_rdev;
1e9046e3a15460 Jens Wiklander 2024-08-14  176  	}
1e9046e3a15460 Jens Wiklander 2024-08-14  177  
1e9046e3a15460 Jens Wiklander 2024-08-14  178  	mutex_lock(&rpmb_mutex);
1e9046e3a15460 Jens Wiklander 2024-08-14  179  	ret = ida_simple_get(&rpmb_ida, 0, 0, GFP_KERNEL);
1e9046e3a15460 Jens Wiklander 2024-08-14  180  	mutex_unlock(&rpmb_mutex);
1e9046e3a15460 Jens Wiklander 2024-08-14  181  	if (ret < 0)
1e9046e3a15460 Jens Wiklander 2024-08-14  182  		goto err_free_dev_id;
1e9046e3a15460 Jens Wiklander 2024-08-14  183  	rdev->id = ret;
1e9046e3a15460 Jens Wiklander 2024-08-14  184  
1e9046e3a15460 Jens Wiklander 2024-08-14  185  	dev_set_name(&rdev->dev, "rpmb%d", rdev->id);
1e9046e3a15460 Jens Wiklander 2024-08-14  186  	rdev->dev.class = &rpmb_class;
1e9046e3a15460 Jens Wiklander 2024-08-14  187  	rdev->dev.parent = dev;
1e9046e3a15460 Jens Wiklander 2024-08-14  188  
1e9046e3a15460 Jens Wiklander 2024-08-14  189  	ret = device_register(&rdev->dev);
d1c997b32ba265 Jens Wiklander 2024-08-30  190  	if (ret) {
d1c997b32ba265 Jens Wiklander 2024-08-30  191  		put_device(&rdev->dev);
d1c997b32ba265 Jens Wiklander 2024-08-30  192  		return ERR_PTR(ret);
d1c997b32ba265 Jens Wiklander 2024-08-30  193  	}
1e9046e3a15460 Jens Wiklander 2024-08-14  194  
1e9046e3a15460 Jens Wiklander 2024-08-14  195  	dev_dbg(&rdev->dev, "registered device\n");
1e9046e3a15460 Jens Wiklander 2024-08-14  196  
1e9046e3a15460 Jens Wiklander 2024-08-14  197  	return rdev;
1e9046e3a15460 Jens Wiklander 2024-08-14  198  
1e9046e3a15460 Jens Wiklander 2024-08-14 @199  err_id_remove:
1e9046e3a15460 Jens Wiklander 2024-08-14  200  	mutex_lock(&rpmb_mutex);
1e9046e3a15460 Jens Wiklander 2024-08-14  201  	ida_simple_remove(&rpmb_ida, rdev->id);
1e9046e3a15460 Jens Wiklander 2024-08-14  202  	mutex_unlock(&rpmb_mutex);
1e9046e3a15460 Jens Wiklander 2024-08-14  203  err_free_dev_id:
1e9046e3a15460 Jens Wiklander 2024-08-14  204  	kfree(rdev->descr.dev_id);
1e9046e3a15460 Jens Wiklander 2024-08-14  205  err_free_rdev:
1e9046e3a15460 Jens Wiklander 2024-08-14  206  	kfree(rdev);
1e9046e3a15460 Jens Wiklander 2024-08-14  207  	return ERR_PTR(ret);
1e9046e3a15460 Jens Wiklander 2024-08-14  208  }
1e9046e3a15460 Jens Wiklander 2024-08-14  209  EXPORT_SYMBOL_GPL(rpmb_dev_register);
1e9046e3a15460 Jens Wiklander 2024-08-14  210  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

