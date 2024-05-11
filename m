Return-Path: <linux-kernel+bounces-176473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C888C308A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 12:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB092820FA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 10:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F3154656;
	Sat, 11 May 2024 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYYorBf7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA1A17F3
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715422385; cv=none; b=VGQLqfk0/Yf26cJDv9ju57WuSr0t1zp8sdIRdYXpecqsDcLfKL9lVrRVp1XRimAsTPfeE2W1SjqKvLeJnYhJTbkA5MJZl+qoi5Y4ond5tNC2x/Cafyx2baQLwA4E34+gbK8/OwCbtRJ5srXuk17oh4fmzh7YRPXfVevWclYvQJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715422385; c=relaxed/simple;
	bh=X9lQ1i8RpWuTDiej6FewivbHJv1S+ML018lXXyggYd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXktxYhZyzWIIZD1I588kh/9vdsgXL1Kpysa+pKQAUxxHPu29Nt5qpZH1mnASas+17jWNZgH/Kx508Zm45Wxr8fi+ma3XzSs5dj1PDNaHCvQ6cfAbFlA8I86Ch71xUl9WPTBKGh/jtR0umHjiZE/+SBWgWN0ypHxP4xIhxHQpcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYYorBf7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715422383; x=1746958383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X9lQ1i8RpWuTDiej6FewivbHJv1S+ML018lXXyggYd8=;
  b=LYYorBf7+iFEsJIx5NUV+7YM4N5mBdZiUp4oJBNcm7+p8XMiyZycUhJR
   SxHQ4gvBIeXDo0ezjTQpWDwxrtpewL6oSdspPBFDvDFNL4SKXV+kxdvhS
   /1V+cBAnetRNvmb4SFYG7Ndy+AwEeGmgEj0Ms8+ImvkFKNxIJfbEPecUL
   mlRcOo7sEaNBEQAqS5Axdi32RB8ioqqqmJgrshjL3HI8md7CYLjTgD32T
   mBAYwU4vL9mfzOa+6eNcfsnPQSoeesuVRPlfK8NCf+v9jfnhB/V18qvrx
   83HUBda7jTy8opWkbt+ZEAZRUivaSILkorZm+7rS718rUQF2oPm4kz2Yu
   Q==;
X-CSE-ConnectionGUID: dM7izCs0R6WG5njdM5vfPg==
X-CSE-MsgGUID: HfpoxqgYRzCYMnL/FVyb4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11545194"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="11545194"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 03:13:02 -0700
X-CSE-ConnectionGUID: 1HetjDiuTgyfZxyT8d00Vw==
X-CSE-MsgGUID: 959m47TSSFiOZo/J85m2ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="29727685"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 11 May 2024 03:12:59 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5jir-0007E7-0M;
	Sat, 11 May 2024 10:12:57 +0000
Date: Sat, 11 May 2024 18:12:39 +0800
From: kernel test robot <lkp@intel.com>
To: Kousik Sanagavarapu <five231003@gmail.com>, Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: Re: [PATCH 2/3] soc: ti: knav_qmss_queue: do device_node auto cleanup
Message-ID: <202405111846.3m9z398l-lkp@intel.com>
References: <20240510071432.62913-3-five231003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510071432.62913-3-five231003@gmail.com>

Hi Kousik,

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on soc/for-next linus/master v6.9-rc7 next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kousik-Sanagavarapu/soc-ti-pruss-do-device_node-auto-cleanup/20240510-151656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20240510071432.62913-3-five231003%40gmail.com
patch subject: [PATCH 2/3] soc: ti: knav_qmss_queue: do device_node auto cleanup
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240511/202405111846.3m9z398l-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405111846.3m9z398l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405111846.3m9z398l-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/soc/ti/knav_qmss_queue.c:1853:3: error: cannot jump from this goto statement to its label
                   goto err;
                   ^
   drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *regions __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1840:3: error: cannot jump from this goto statement to its label
                   goto err;
                   ^
   drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *regions __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1835:3: error: cannot jump from this goto statement to its label
                   goto err;
                   ^
   drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *regions __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1831:3: error: cannot jump from this goto statement to its label
                   goto err;
                   ^
   drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *regions __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1822:4: error: cannot jump from this goto statement to its label
                           goto err;
                           ^
   drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *regions __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *queue_pools __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1818:4: error: cannot jump from this goto statement to its label
                           goto err;
                           ^
   drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *regions __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *queue_pools __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1810:3: error: cannot jump from this goto statement to its label
                   goto err;
                   ^
   drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *regions __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *queue_pools __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1813:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *pdsps __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1806:3: error: cannot jump from this goto statement to its label
                   goto err;
                   ^
   drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *regions __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *queue_pools __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1813:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *pdsps __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1795:3: error: cannot jump from this goto statement to its label
                   goto err;
                   ^
   drivers/soc/ti/knav_qmss_queue.c:1855:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *regions __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1826:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *queue_pools __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1813:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *pdsps __free(device_node) =
                               ^
   drivers/soc/ti/knav_qmss_queue.c:1801:22: note: jump bypasses initialization of variable with __attribute__((cleanup))
           struct device_node *qmgrs __free(device_node) =
                               ^
   9 errors generated.


vim +1853 drivers/soc/ti/knav_qmss_queue.c

350601b4f7ab45 Murali Karicheri    2018-04-17  1754  
41f93af900a20d Sandeep Nair        2014-02-28  1755  static int knav_queue_probe(struct platform_device *pdev)
41f93af900a20d Sandeep Nair        2014-02-28  1756  {
41f93af900a20d Sandeep Nair        2014-02-28  1757  	struct device_node *node = pdev->dev.of_node;
41f93af900a20d Sandeep Nair        2014-02-28  1758  	struct device *dev = &pdev->dev;
41f93af900a20d Sandeep Nair        2014-02-28  1759  	u32 temp[2];
41f93af900a20d Sandeep Nair        2014-02-28  1760  	int ret;
41f93af900a20d Sandeep Nair        2014-02-28  1761  
41f93af900a20d Sandeep Nair        2014-02-28  1762  	if (!node) {
41f93af900a20d Sandeep Nair        2014-02-28  1763  		dev_err(dev, "device tree info unavailable\n");
41f93af900a20d Sandeep Nair        2014-02-28  1764  		return -ENODEV;
41f93af900a20d Sandeep Nair        2014-02-28  1765  	}
41f93af900a20d Sandeep Nair        2014-02-28  1766  
41f93af900a20d Sandeep Nair        2014-02-28  1767  	kdev = devm_kzalloc(dev, sizeof(struct knav_device), GFP_KERNEL);
41f93af900a20d Sandeep Nair        2014-02-28  1768  	if (!kdev) {
41f93af900a20d Sandeep Nair        2014-02-28  1769  		dev_err(dev, "memory allocation failed\n");
41f93af900a20d Sandeep Nair        2014-02-28  1770  		return -ENOMEM;
41f93af900a20d Sandeep Nair        2014-02-28  1771  	}
41f93af900a20d Sandeep Nair        2014-02-28  1772  
50c01a942b2874 Rob Herring         2023-10-09  1773  	if (device_get_match_data(dev))
350601b4f7ab45 Murali Karicheri    2018-04-17  1774  		kdev->version = QMSS_66AK2G;
350601b4f7ab45 Murali Karicheri    2018-04-17  1775  
41f93af900a20d Sandeep Nair        2014-02-28  1776  	platform_set_drvdata(pdev, kdev);
41f93af900a20d Sandeep Nair        2014-02-28  1777  	kdev->dev = dev;
41f93af900a20d Sandeep Nair        2014-02-28  1778  	INIT_LIST_HEAD(&kdev->queue_ranges);
41f93af900a20d Sandeep Nair        2014-02-28  1779  	INIT_LIST_HEAD(&kdev->qmgrs);
41f93af900a20d Sandeep Nair        2014-02-28  1780  	INIT_LIST_HEAD(&kdev->pools);
41f93af900a20d Sandeep Nair        2014-02-28  1781  	INIT_LIST_HEAD(&kdev->regions);
41f93af900a20d Sandeep Nair        2014-02-28  1782  	INIT_LIST_HEAD(&kdev->pdsps);
41f93af900a20d Sandeep Nair        2014-02-28  1783  
41f93af900a20d Sandeep Nair        2014-02-28  1784  	pm_runtime_enable(&pdev->dev);
12eeb74925da70 Minghao Chi         2022-04-18  1785  	ret = pm_runtime_resume_and_get(&pdev->dev);
41f93af900a20d Sandeep Nair        2014-02-28  1786  	if (ret < 0) {
e961c0f19450fd Zhang Qilong        2022-11-08  1787  		pm_runtime_disable(&pdev->dev);
41f93af900a20d Sandeep Nair        2014-02-28  1788  		dev_err(dev, "Failed to enable QMSS\n");
41f93af900a20d Sandeep Nair        2014-02-28  1789  		return ret;
41f93af900a20d Sandeep Nair        2014-02-28  1790  	}
41f93af900a20d Sandeep Nair        2014-02-28  1791  
41f93af900a20d Sandeep Nair        2014-02-28  1792  	if (of_property_read_u32_array(node, "queue-range", temp, 2)) {
41f93af900a20d Sandeep Nair        2014-02-28  1793  		dev_err(dev, "queue-range not specified\n");
41f93af900a20d Sandeep Nair        2014-02-28  1794  		ret = -ENODEV;
41f93af900a20d Sandeep Nair        2014-02-28  1795  		goto err;
41f93af900a20d Sandeep Nair        2014-02-28  1796  	}
41f93af900a20d Sandeep Nair        2014-02-28  1797  	kdev->base_id    = temp[0];
41f93af900a20d Sandeep Nair        2014-02-28  1798  	kdev->num_queues = temp[1];
41f93af900a20d Sandeep Nair        2014-02-28  1799  
41f93af900a20d Sandeep Nair        2014-02-28  1800  	/* Initialize queue managers using device tree configuration */
10e6f93cca367b Kousik Sanagavarapu 2024-05-10  1801  	struct device_node *qmgrs __free(device_node) =
10e6f93cca367b Kousik Sanagavarapu 2024-05-10  1802  			of_get_child_by_name(node, "qmgrs");
41f93af900a20d Sandeep Nair        2014-02-28  1803  	if (!qmgrs) {
41f93af900a20d Sandeep Nair        2014-02-28  1804  		dev_err(dev, "queue manager info not specified\n");
41f93af900a20d Sandeep Nair        2014-02-28  1805  		ret = -ENODEV;
41f93af900a20d Sandeep Nair        2014-02-28  1806  		goto err;
41f93af900a20d Sandeep Nair        2014-02-28  1807  	}
41f93af900a20d Sandeep Nair        2014-02-28  1808  	ret = knav_queue_init_qmgrs(kdev, qmgrs);
41f93af900a20d Sandeep Nair        2014-02-28  1809  	if (ret)
41f93af900a20d Sandeep Nair        2014-02-28  1810  		goto err;
41f93af900a20d Sandeep Nair        2014-02-28  1811  
41f93af900a20d Sandeep Nair        2014-02-28  1812  	/* get pdsp configuration values from device tree */
10e6f93cca367b Kousik Sanagavarapu 2024-05-10  1813  	struct device_node *pdsps __free(device_node) =
10e6f93cca367b Kousik Sanagavarapu 2024-05-10  1814  			of_get_child_by_name(node, "pdsps");
41f93af900a20d Sandeep Nair        2014-02-28  1815  	if (pdsps) {
41f93af900a20d Sandeep Nair        2014-02-28  1816  		ret = knav_queue_init_pdsps(kdev, pdsps);
41f93af900a20d Sandeep Nair        2014-02-28  1817  		if (ret)
41f93af900a20d Sandeep Nair        2014-02-28  1818  			goto err;
41f93af900a20d Sandeep Nair        2014-02-28  1819  
41f93af900a20d Sandeep Nair        2014-02-28  1820  		ret = knav_queue_start_pdsps(kdev);
41f93af900a20d Sandeep Nair        2014-02-28  1821  		if (ret)
41f93af900a20d Sandeep Nair        2014-02-28  1822  			goto err;
41f93af900a20d Sandeep Nair        2014-02-28  1823  	}
41f93af900a20d Sandeep Nair        2014-02-28  1824  
41f93af900a20d Sandeep Nair        2014-02-28  1825  	/* get usable queue range values from device tree */
10e6f93cca367b Kousik Sanagavarapu 2024-05-10  1826  	struct device_node *queue_pools __free(device_node) =
10e6f93cca367b Kousik Sanagavarapu 2024-05-10  1827  			of_get_child_by_name(node, "queue-pools");
41f93af900a20d Sandeep Nair        2014-02-28  1828  	if (!queue_pools) {
41f93af900a20d Sandeep Nair        2014-02-28  1829  		dev_err(dev, "queue-pools not specified\n");
41f93af900a20d Sandeep Nair        2014-02-28  1830  		ret = -ENODEV;
41f93af900a20d Sandeep Nair        2014-02-28  1831  		goto err;
41f93af900a20d Sandeep Nair        2014-02-28  1832  	}
41f93af900a20d Sandeep Nair        2014-02-28  1833  	ret = knav_setup_queue_pools(kdev, queue_pools);
41f93af900a20d Sandeep Nair        2014-02-28  1834  	if (ret)
41f93af900a20d Sandeep Nair        2014-02-28  1835  		goto err;
41f93af900a20d Sandeep Nair        2014-02-28  1836  
41f93af900a20d Sandeep Nair        2014-02-28  1837  	ret = knav_get_link_ram(kdev, "linkram0", &kdev->link_rams[0]);
41f93af900a20d Sandeep Nair        2014-02-28  1838  	if (ret) {
41f93af900a20d Sandeep Nair        2014-02-28  1839  		dev_err(kdev->dev, "could not setup linking ram\n");
41f93af900a20d Sandeep Nair        2014-02-28  1840  		goto err;
41f93af900a20d Sandeep Nair        2014-02-28  1841  	}
41f93af900a20d Sandeep Nair        2014-02-28  1842  
41f93af900a20d Sandeep Nair        2014-02-28  1843  	ret = knav_get_link_ram(kdev, "linkram1", &kdev->link_rams[1]);
41f93af900a20d Sandeep Nair        2014-02-28  1844  	if (ret) {
41f93af900a20d Sandeep Nair        2014-02-28  1845  		/*
41f93af900a20d Sandeep Nair        2014-02-28  1846  		 * nothing really, we have one linking ram already, so we just
41f93af900a20d Sandeep Nair        2014-02-28  1847  		 * live within our means
41f93af900a20d Sandeep Nair        2014-02-28  1848  		 */
41f93af900a20d Sandeep Nair        2014-02-28  1849  	}
41f93af900a20d Sandeep Nair        2014-02-28  1850  
41f93af900a20d Sandeep Nair        2014-02-28  1851  	ret = knav_queue_setup_link_ram(kdev);
41f93af900a20d Sandeep Nair        2014-02-28  1852  	if (ret)
41f93af900a20d Sandeep Nair        2014-02-28 @1853  		goto err;
41f93af900a20d Sandeep Nair        2014-02-28  1854  
10e6f93cca367b Kousik Sanagavarapu 2024-05-10  1855  	struct device_node *regions __free(device_node) =
10e6f93cca367b Kousik Sanagavarapu 2024-05-10  1856  			of_get_child_by_name(node, "descriptor-regions");
41f93af900a20d Sandeep Nair        2014-02-28  1857  	if (!regions) {
41f93af900a20d Sandeep Nair        2014-02-28  1858  		dev_err(dev, "descriptor-regions not specified\n");
4cba398f37f868 Zhihao Cheng        2020-11-21  1859  		ret = -ENODEV;
41f93af900a20d Sandeep Nair        2014-02-28  1860  		goto err;
41f93af900a20d Sandeep Nair        2014-02-28  1861  	}
41f93af900a20d Sandeep Nair        2014-02-28  1862  	ret = knav_queue_setup_regions(kdev, regions);
41f93af900a20d Sandeep Nair        2014-02-28  1863  	if (ret)
41f93af900a20d Sandeep Nair        2014-02-28  1864  		goto err;
41f93af900a20d Sandeep Nair        2014-02-28  1865  
41f93af900a20d Sandeep Nair        2014-02-28  1866  	ret = knav_queue_init_queues(kdev);
41f93af900a20d Sandeep Nair        2014-02-28  1867  	if (ret < 0) {
41f93af900a20d Sandeep Nair        2014-02-28  1868  		dev_err(dev, "hwqueue initialization failed\n");
41f93af900a20d Sandeep Nair        2014-02-28  1869  		goto err;
41f93af900a20d Sandeep Nair        2014-02-28  1870  	}
41f93af900a20d Sandeep Nair        2014-02-28  1871  
41f93af900a20d Sandeep Nair        2014-02-28  1872  	debugfs_create_file("qmss", S_IFREG | S_IRUGO, NULL, NULL,
74e0e43a09cea3 Qinglang Miao       2020-09-20  1873  			    &knav_queue_debug_fops);
a2dd6877b43ef1 Murali Karicheri    2018-04-17  1874  	device_ready = true;
41f93af900a20d Sandeep Nair        2014-02-28  1875  	return 0;
41f93af900a20d Sandeep Nair        2014-02-28  1876  
41f93af900a20d Sandeep Nair        2014-02-28  1877  err:
41f93af900a20d Sandeep Nair        2014-02-28  1878  	knav_queue_stop_pdsps(kdev);
41f93af900a20d Sandeep Nair        2014-02-28  1879  	knav_queue_free_regions(kdev);
41f93af900a20d Sandeep Nair        2014-02-28  1880  	knav_free_queue_ranges(kdev);
41f93af900a20d Sandeep Nair        2014-02-28  1881  	pm_runtime_put_sync(&pdev->dev);
41f93af900a20d Sandeep Nair        2014-02-28  1882  	pm_runtime_disable(&pdev->dev);
41f93af900a20d Sandeep Nair        2014-02-28  1883  	return ret;
41f93af900a20d Sandeep Nair        2014-02-28  1884  }
41f93af900a20d Sandeep Nair        2014-02-28  1885  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

