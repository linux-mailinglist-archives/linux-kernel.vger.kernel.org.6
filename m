Return-Path: <linux-kernel+bounces-346948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB5A98CB51
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 04:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6D71C224E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 02:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0670AC2C6;
	Wed,  2 Oct 2024 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W24X5ONV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E528F4
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727836847; cv=none; b=XfllRYzFu1J0MMKk3OXKA0uPv7XgKlZrqSEvwkmIHurGbIsN9getDaPFy5TIWU0TvJjv+nNx1JjYzQfb8j8dachTlodp2riTCjLt781zkYze0/WR1NHucKinqjS6Wb0+pOOCR7q2fnCt3timUHnrTXG2gLojznTeklh2Ckb8534=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727836847; c=relaxed/simple;
	bh=QQzHHBgybgW+Z07G81Hz4fvALI1/nFWb9wH+/UBjWvE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FwtXRqsW7Ifiaqk5XXJ5sF4KGjYx1G+qyIVlq4JWZCnlovwfHluSEO2+DB3TdDN5Jklng+mte2dIOWW9eDmTCi8ADtmGUnNXz7R++cc8xj8Fk5dr5iIDgGt93bFIzmg7iFb1PliZo0aeO4MG6Q3TGaKFSP4U1X6+dIdtEUEY+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W24X5ONV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727836846; x=1759372846;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QQzHHBgybgW+Z07G81Hz4fvALI1/nFWb9wH+/UBjWvE=;
  b=W24X5ONVR2kJKNU2IGJ4BNYAXV1scOpo5irYMCiy4YjMILjwQjzC6yXV
   4SL448EJE1sW1FU3Iq5DFO7qV+IamXK2JSagWeq9bVl8VJoELEUeSYr8P
   5qqtRq7XqXQmQRZftCjw721lxjKD5wnTEJ/UjC6vOvloj4am1X1h+cOXZ
   xYkXN07PwSOJcmsRmmQNGGvv5k2ToMinyAOuk6pKkGsgnTjZER5al7H/V
   df24xxwCx7LvysCjAVqjxghJEJEP49Tk84NFH0/K1kAEjOgYASg4poGaw
   bASk8AmAhHMrxU+qVuIyB6XZ6ppKYK687nrsnTqxSL16p0D1BlM1cLimz
   g==;
X-CSE-ConnectionGUID: jarVbHKOSyGXg/tUEKEaLg==
X-CSE-MsgGUID: xSnPLm5MQlqFxWfsnbLWwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37554437"
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="37554437"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 19:40:46 -0700
X-CSE-ConnectionGUID: 67cAt+yFRnK5JtUcsCYenw==
X-CSE-MsgGUID: 2jDuxdZCSji7BrTHr2rbZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="73890779"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 01 Oct 2024 19:40:44 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svpI9-000RS9-01;
	Wed, 02 Oct 2024 02:40:41 +0000
Date: Wed, 2 Oct 2024 10:40:38 +0800
From: kernel test robot <lkp@intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>
Subject: drivers/platform/x86/intel/vsec.c:340:6: error: redefinition of
 'intel_vsec_register'
Message-ID: <202410021056.c4DcySHh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
commit: fc9aef4382c02774662da3d7e1de8ba224e04f80 platform/x86/intel/vsec.h: Move to include/linux
date:   7 weeks ago
config: x86_64-randconfig-r133-20240215 (https://download.01.org/0day-ci/archive/20241002/202410021056.c4DcySHh-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410021056.c4DcySHh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410021056.c4DcySHh-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/platform/x86/intel/vsec.c: In function 'intel_vsec_walk_dvsec':
   drivers/platform/x86/intel/vsec.c:257:23: error: implicit declaration of function 'pci_find_next_ext_capability'; did you mean 'pci_find_next_capability'? [-Werror=implicit-function-declaration]
     257 |                 pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                       pci_find_next_capability
   drivers/platform/x86/intel/vsec.c: At top level:
>> drivers/platform/x86/intel/vsec.c:340:6: error: redefinition of 'intel_vsec_register'
     340 | void intel_vsec_register(struct pci_dev *pdev,
         |      ^~~~~~~~~~~~~~~~~~~
   In file included from drivers/platform/x86/intel/vsec.c:21:
   include/linux/intel_vsec.h:129:20: note: previous definition of 'intel_vsec_register' with type 'void(struct pci_dev *, struct intel_vsec_platform_info *)'
     129 | static inline void intel_vsec_register(struct pci_dev *pdev,
         |                    ^~~~~~~~~~~~~~~~~~~
   drivers/platform/x86/intel/vsec.c:510:1: warning: data definition has no type or storage class
     510 | module_pci_driver(intel_vsec_pci_driver);
         | ^~~~~~~~~~~~~~~~~
   drivers/platform/x86/intel/vsec.c:510:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
   drivers/platform/x86/intel/vsec.c:510:1: warning: parameter names (without types) in function declaration
   drivers/platform/x86/intel/vsec.c:504:26: warning: 'intel_vsec_pci_driver' defined but not used [-Wunused-variable]
     504 | static struct pci_driver intel_vsec_pci_driver = {
         |                          ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/intel_vsec_register +340 drivers/platform/x86/intel/vsec.c

a3c8f906ed5fc1 David E. Box    2021-12-07  339  
4edbd117ba3f7b Gayatri Kammela 2023-11-29 @340  void intel_vsec_register(struct pci_dev *pdev,
4edbd117ba3f7b Gayatri Kammela 2023-11-29  341  			 struct intel_vsec_platform_info *info)
4edbd117ba3f7b Gayatri Kammela 2023-11-29  342  {
fc9aef4382c027 David E. Box    2024-07-25  343  	if (!pdev || !info || !info->headers)
4edbd117ba3f7b Gayatri Kammela 2023-11-29  344  		return;
4edbd117ba3f7b Gayatri Kammela 2023-11-29  345  
4edbd117ba3f7b Gayatri Kammela 2023-11-29  346  	intel_vsec_walk_header(pdev, info);
4edbd117ba3f7b Gayatri Kammela 2023-11-29  347  }
4edbd117ba3f7b Gayatri Kammela 2023-11-29  348  EXPORT_SYMBOL_NS_GPL(intel_vsec_register, INTEL_VSEC);
4edbd117ba3f7b Gayatri Kammela 2023-11-29  349  

:::::: The code at line 340 was first introduced by commit
:::::: 4edbd117ba3f7beacfb439aad60e8a5de77114b4 platform/x86/intel/vsec: Add intel_vsec_register

:::::: TO: Gayatri Kammela <gayatri.kammela@linux.intel.com>
:::::: CC: Hans de Goede <hdegoede@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

