Return-Path: <linux-kernel+bounces-260593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 449FC93AB4D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DDC1F23969
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE0E17C68;
	Wed, 24 Jul 2024 02:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PMe3AtUJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFACB1B7E9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721788927; cv=none; b=SU7fxylm7mx/k8DpKdw+A2KyFXQ5tkeNOdc6vHQAa5yAf6i0a5bYt0SGAUd60AY3P8Lqwk92znB5g4rcann08mOe3613yHNBtM2OHqG3QOj45tDSupamUMF0TCcrtcvS5MA0LP1ZmlYfhUse409nQdK9S4f0ttCRZ6Rmn77l/Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721788927; c=relaxed/simple;
	bh=Jz6b+V0sp/QHCbI8lkUIWgxo8QZ3onL7lWJZDxQp45w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPhV4O4hhqUzRAHjaVoQMHYPXBDDijWzTYAAhbNsBwmwTQb+Fvc7wGxiayg7vzs5LRoG1ylAMW3YlTE7hPQ1d98GoNxBLw2yIeZzjW8ghDfUlgjd3nCDIUyuDA7F+ggpp/56mc/ZuzQU7OcAUIBiH6pbkIe+EXaLfuBgqARdPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PMe3AtUJ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721788926; x=1753324926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jz6b+V0sp/QHCbI8lkUIWgxo8QZ3onL7lWJZDxQp45w=;
  b=PMe3AtUJtzI9VNEDimQa8HRct0UW1v0jHLv3VyADc+oGZbJJ3nfuQata
   y95CSQAGdObFfkM4uyv/trngQH60CV9oaGjQaw3F7LsA+aJBxDIUI8UNV
   87RwiNlomqWqGJr0bEfLsr42x5hy4KJPGnDHIAOZ5Yow5oHjx9+yBuWy2
   j4WBYqYXanLRSDlzcwdPI3Sb/NwUoOCewKpFNFnA9Me6qYfln1VZVYwov
   pUN2oIrVfqEYIn9u9EquN/uDhE71q/K9ULfrvfH0ab+q4c2K4q7UIuNx3
   IDQ7dd41sELnl+fyTi7RZxnG+WDfXx9EOSAEqnWPKgNNxAQT3kGCAP/Jl
   Q==;
X-CSE-ConnectionGUID: UaamXoY5R3274U+CpAeLMg==
X-CSE-MsgGUID: gxuc0V9eTaeFJqXSwpujOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19139073"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19139073"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 19:42:05 -0700
X-CSE-ConnectionGUID: oAqvGr1CQJCN1qNZUUJqvA==
X-CSE-MsgGUID: NqCRA05dT6OJOGwJhwh1Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="52460857"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 23 Jul 2024 19:42:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWRx1-000ma6-2v;
	Wed, 24 Jul 2024 02:41:59 +0000
Date: Wed, 24 Jul 2024 10:41:42 +0800
From: kernel test robot <lkp@intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH 4/5] i3c: mipi-i3c-hci: Add a quirk to set timing
 parameters
Message-ID: <202407241020.dsJauFym-lkp@intel.com>
References: <20240723173538.3493935-5-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723173538.3493935-5-Shyam-sundar.S-k@amd.com>

Hi Shyam,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10 next-20240723]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shyam-Sundar-S-K/i3c-mipi-i3c-hci-Add-MIPI0100-ACPI-ID-to-the-I3C-Support-List/20240724-013958
base:   linus/master
patch link:    https://lore.kernel.org/r/20240723173538.3493935-5-Shyam-sundar.S-k%40amd.com
patch subject: [PATCH 4/5] i3c: mipi-i3c-hci: Add a quirk to set timing parameters
config: arm-randconfig-004-20240724 (https://download.01.org/0day-ci/archive/20240724/202407241020.dsJauFym-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407241020.dsJauFym-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407241020.dsJauFym-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/i3c/master/mipi-i3c-hci/hci_quirks.c: In function 'amd_i3c_hci_quirks_init':
>> drivers/i3c/master/mipi-i3c-hci/hci_quirks.c:25:13: error: 'boot_cpu_data' undeclared (first use in this function)
      25 |         if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
         |             ^~~~~~~~~~~~~
   drivers/i3c/master/mipi-i3c-hci/hci_quirks.c:25:13: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/i3c/master/mipi-i3c-hci/hci_quirks.c:25:41: error: 'X86_VENDOR_AMD' undeclared (first use in this function); did you mean 'X86_VENDOR_ANY'?
      25 |         if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
         |                                         ^~~~~~~~~~~~~~
         |                                         X86_VENDOR_ANY


vim +/boot_cpu_data +25 drivers/i3c/master/mipi-i3c-hci/hci_quirks.c

    22	
    23	void amd_i3c_hci_quirks_init(struct i3c_hci *hci)
    24	{
  > 25		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
    26			hci->quirks |= HCI_QUIRK_AMD_PIO_MODE;
    27			hci->quirks |= HCI_QUIRK_AMD_OD_PP_TIMING;
    28		}
    29	}
    30	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

