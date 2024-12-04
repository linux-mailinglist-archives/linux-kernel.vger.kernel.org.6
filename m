Return-Path: <linux-kernel+bounces-430470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1680B9E3150
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19FC1615F5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F90D2B9B4;
	Wed,  4 Dec 2024 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGszsfQD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5C175AB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 02:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278707; cv=none; b=uXhK7TmDHfBh8yv4j6EiKNNz/lNkbHpR46kU0NkAq8jQ8bWAdh0lpCkd/Tysprkn0F1zOz6yS4cWHdDt9D4q6XZw/OSatcQb3y+adIQcmAITBrgqWJWnQ6qPqmEJRhzfgNBKyilvlARDAEjVNG941FusD4NdDOa6JRxcnDP2ibE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278707; c=relaxed/simple;
	bh=bFSkPvAGT8/0F2pNgQAhnq8VRL9QDGPkIM+iUn6ALLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0fGXgHl5rFIURVxjmevaNGp+r7gy0BVwqywH46s4RGFkpgM02SQ3CZPfx23y9SmA0NHKEgeS+YyH4ubDnbV32a4WSJ1nfyU+fD3DHWjTz5v4PsdBueySOD1eLcFg0EkvcBx4Do1In5azh/iynhBDq2p4CGC73eWd/wjfjh+fB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGszsfQD; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733278706; x=1764814706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bFSkPvAGT8/0F2pNgQAhnq8VRL9QDGPkIM+iUn6ALLM=;
  b=jGszsfQDNVA8Mk6PRlwTXe0MWDU6S1mAYPk1FJCbfPtdya6ug/ulzRKs
   xaoR6U41mSQOGIu6hB1foSczBn7zS/Mod+8q9AdFIJjubYC7ziffBtacy
   q/bUG/O+IaWHFc9O9FyoW3jiYACB7aAoOmgOfbF0Nsm66+AYkNIejoe+3
   0R/id6aajlFBDFwggQSCUmWfPaOIWdhzb8yMlaXMSS3Pg17IUY6lqc60l
   UUPYwB2TkYi25dx2/4iE/h899oUpdAxUfw7OwVKohkVIB6KYdRvxwo0A9
   GmNGQJ5POaz869BwUA5nLOZ3HEOFadfw/rPYZaFE/U9r3bgv29t29/ud8
   Q==;
X-CSE-ConnectionGUID: mwYYJGwmT7m+S/15cOlwlw==
X-CSE-MsgGUID: hXHw8p+hQ3SQRbdrMxu3lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="33271945"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="33271945"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 18:18:25 -0800
X-CSE-ConnectionGUID: jtf31CIwSVWX97RYKrpD4g==
X-CSE-MsgGUID: GA8URj/0S9qXXcrW/xO29w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98633958"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 18:18:23 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIey0-0000Sr-2J;
	Wed, 04 Dec 2024 02:18:17 +0000
Date: Wed, 4 Dec 2024 10:18:07 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Penkler <dpenkler@gmail.com>, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux@roeck-us.net,
	Dave Penkler <dpenkler@gmail.com>
Subject: Re: [PATCH v3] staging: gpib: Fix i386 build issue
Message-ID: <202412040912.hxTuXBak-lkp@intel.com>
References: <20241203084116.2228-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203084116.2228-1-dpenkler@gmail.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Penkler/staging-gpib-Fix-i386-build-issue/20241203-164356
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20241203084116.2228-1-dpenkler%40gmail.com
patch subject: [PATCH v3] staging: gpib: Fix i386 build issue
config: i386-randconfig-063-20241203 (https://download.01.org/0day-ci/archive/20241204/202412040912.hxTuXBak-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412040912.hxTuXBak-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412040912.hxTuXBak-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/staging/gpib/cb7210/cb7210.c:738:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:739:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:743:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:744:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:745:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:746:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:747:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:748:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:749:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:750:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:751:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:752:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:753:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:754:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:755:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:756:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:757:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:758:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:759:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:760:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:761:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:762:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:763:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:764:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:765:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:766:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:770:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:771:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:772:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:773:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:774:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:775:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:776:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:777:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:778:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:779:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:780:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:781:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:782:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:783:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:784:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:785:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:786:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:787:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:788:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:789:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:790:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:791:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:792:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:793:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:794:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:798:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:799:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:800:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:801:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:802:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:803:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:804:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:805:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:806:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:807:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:808:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:809:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:810:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:811:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:812:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:813:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:814:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:815:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:816:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:817:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:818:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:819:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:820:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:821:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:825:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:826:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:827:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:828:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:829:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:830:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:831:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:832:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:833:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:834:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:835:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:836:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:837:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:838:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:839:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:840:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:841:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:842:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:843:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:844:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:845:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:846:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:847:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:848:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/cb7210/cb7210.c:849:1: sparse: sparse: obsolete struct initializer, use C99 syntax
>> drivers/staging/gpib/cb7210/cb7210.c:974:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *iobase @@     got void [noderef] __iomem * @@
   drivers/staging/gpib/cb7210/cb7210.c:974:34: sparse:     expected void *iobase
   drivers/staging/gpib/cb7210/cb7210.c:974:34: sparse:     got void [noderef] __iomem *
   drivers/staging/gpib/cb7210/cb7210.c:979:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *iobase @@     got void [noderef] __iomem * @@
   drivers/staging/gpib/cb7210/cb7210.c:979:34: sparse:     expected void *iobase
   drivers/staging/gpib/cb7210/cb7210.c:979:34: sparse:     got void [noderef] __iomem *
   drivers/staging/gpib/cb7210/cb7210.c:1045:87: sparse: sparse: Using plain integer as NULL pointer
   drivers/staging/gpib/cb7210/cb7210.c:686:18: sparse: sparse: symbol 'cb_pci_unaccel_interface' was not declared. Should it be static?
   drivers/staging/gpib/cb7210/cb7210.c:714:18: sparse: sparse: symbol 'cb_pci_accel_interface' was not declared. Should it be static?
   drivers/staging/gpib/cb7210/cb7210.c:742:18: sparse: sparse: symbol 'cb_pci_interface' was not declared. Should it be static?
   drivers/staging/gpib/cb7210/cb7210.c:769:18: sparse: sparse: symbol 'cb_isa_unaccel_interface' was not declared. Should it be static?
   drivers/staging/gpib/cb7210/cb7210.c:797:18: sparse: sparse: symbol 'cb_isa_interface' was not declared. Should it be static?
   drivers/staging/gpib/cb7210/cb7210.c:824:18: sparse: sparse: symbol 'cb_isa_accel_interface' was not declared. Should it be static?

vim +974 drivers/staging/gpib/cb7210/cb7210.c

   925	
   926	int cb_pci_attach(gpib_board_t *board, const gpib_board_config_t *config)
   927	{
   928		struct cb7210_priv *cb_priv;
   929		struct nec7210_priv *nec_priv;
   930		int isr_flags = 0;
   931		int bits;
   932		int retval;
   933	
   934		retval = cb7210_generic_attach(board);
   935		if (retval)
   936			return retval;
   937	
   938		cb_priv = board->private_data;
   939		nec_priv = &cb_priv->nec7210_priv;
   940	
   941		cb_priv->pci_device = gpib_pci_get_device(config, PCI_VENDOR_ID_CBOARDS,
   942							  PCI_DEVICE_ID_CBOARDS_PCI_GPIB, NULL);
   943		if (cb_priv->pci_device)
   944			cb_priv->pci_chip = PCI_CHIP_AMCC_S5933;
   945		if (!cb_priv->pci_device) {
   946			cb_priv->pci_device = gpib_pci_get_device(config, PCI_VENDOR_ID_CBOARDS,
   947								  PCI_DEVICE_ID_CBOARDS_CPCI_GPIB, NULL);
   948			if (cb_priv->pci_device)
   949				cb_priv->pci_chip = PCI_CHIP_AMCC_S5933;
   950		}
   951		if (!cb_priv->pci_device) {
   952			cb_priv->pci_device = gpib_pci_get_device(config, PCI_VENDOR_ID_QUANCOM,
   953								  PCI_DEVICE_ID_QUANCOM_GPIB, NULL);
   954			if (cb_priv->pci_device) {
   955				cb_priv->pci_chip = PCI_CHIP_QUANCOM;
   956				nec_priv->offset = 4;
   957			}
   958		}
   959		if (!cb_priv->pci_device) {
   960			pr_warn("cb7210: no supported boards found.\n");
   961			return -1;
   962		}
   963	
   964		if (pci_enable_device(cb_priv->pci_device)) {
   965			pr_err("cb7210: error enabling pci device\n");
   966			return -1;
   967		}
   968	
   969		if (pci_request_regions(cb_priv->pci_device, "cb7210"))
   970			return -1;
   971		switch (cb_priv->pci_chip) {
   972		case PCI_CHIP_AMCC_S5933:
   973			cb_priv->amcc_iobase = pci_resource_start(cb_priv->pci_device, 0);
 > 974			nec_priv->iobase = ioremap(pci_resource_start(cb_priv->pci_device, 1),
   975						   pci_resource_len(cb_priv->pci_device, 1));
   976			cb_priv->fifo_iobase = pci_resource_start(cb_priv->pci_device, 2);
   977			break;
   978		case PCI_CHIP_QUANCOM:
   979			nec_priv->iobase = ioremap(pci_resource_start(cb_priv->pci_device, 0),
   980						   pci_resource_len(cb_priv->pci_device, 0));
   981			cb_priv->fifo_iobase = (unsigned long)nec_priv->iobase;
   982			break;
   983		default:
   984			pr_err("cb7210: bug! unhandled pci_chip=%i\n", cb_priv->pci_chip);
   985			return -EIO;
   986		}
   987		isr_flags |= IRQF_SHARED;
   988		if (request_irq(cb_priv->pci_device->irq, cb_pci_interrupt, isr_flags, "cb7210", board)) {
   989			pr_err("cb7210: can't request IRQ %d\n", cb_priv->pci_device->irq);
   990			return -1;
   991		}
   992		cb_priv->irq = cb_priv->pci_device->irq;
   993	
   994		switch (cb_priv->pci_chip) {
   995		case PCI_CHIP_AMCC_S5933:
   996			// make sure mailbox flags are clear
   997			inl(cb_priv->amcc_iobase + INCOMING_MAILBOX_REG(3));
   998			// enable interrupts on amccs5933 chip
   999			bits = INBOX_FULL_INTR_BIT | INBOX_BYTE_BITS(3) | INBOX_SELECT_BITS(3) |
  1000				INBOX_INTR_CS_BIT;
  1001			outl(bits, cb_priv->amcc_iobase + INTCSR_REG);
  1002			break;
  1003		default:
  1004			break;
  1005		}
  1006		return cb7210_init(cb_priv, board);
  1007	}
  1008	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

