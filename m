Return-Path: <linux-kernel+bounces-428062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B49E09AB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C7C282306
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818C71D61A2;
	Mon,  2 Dec 2024 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emGFCmIv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261151AB6EA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159889; cv=none; b=hxjHXMB8Wqn4S/3MQxF0PNfUMaEFPtdRpw9Psyte2ZBbc5WFkcublzkTVDHpq31bZtfJAWtjU5RVqqUEMKGa6TGLEYQOXjI+IhsSEZh+1nAvdvAS77PZx9iNVaMN0KaEph8OP5QXao3hcC9gFu+V2gwKD3DBf7d80MQlcc6kaR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159889; c=relaxed/simple;
	bh=E4Wm8kHlwPbdu6uDbIxqGDvMZJfMPRLvglVdRMcYHQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h61gDo6y/bXoJ6KMwyhVDHUUc0JpWnub1EccIDRyjjtlpsiwdHRR++xnlQOl5EchIbTMpivGVHj8zbovuhK3IfDi9+/i5+a0ROU55nXEpm9V1jcgGA4Hul3cTBoeI74RaYHio653AmpleLAd+0OFUusm/OXEg9OA9kYTtQ8LW6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emGFCmIv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733159888; x=1764695888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E4Wm8kHlwPbdu6uDbIxqGDvMZJfMPRLvglVdRMcYHQU=;
  b=emGFCmIvbQmr7TEGSQ26hA50FmjCNHCy4yH+QMLz68ayoMAyahYaqe8s
   z95pYM1v7q2GQapRnBrFybiuMv3RNCaq5ty223CJfo/noFqxAXu/r9DfN
   +htFDexrmcx+v4XWbfIn3/QyV4UFG6273BGYXEND0Fg6xf4fSfYdxruPw
   dbyRiYBqQUQc3NThaIwYlPqzgvZLCNnLA+cpWvMehiagokITRCfxhi5kl
   vqIAy30R+S11HGD2Gy8tkUCvCT4XpnDx2+0dHIJyu/DIkeXVueg0jPhRh
   fTscuKD12uogqiQOS3BIU3rTF+kYUfbD3ELxSRX7QFnS0u8bp3v/sc8ah
   Q==;
X-CSE-ConnectionGUID: rNoz0KkWSbKfS0W8T/DVkA==
X-CSE-MsgGUID: D3ADIEdnQPC3tfEFsiKGCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="37006578"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="37006578"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:18:07 -0800
X-CSE-ConnectionGUID: yI8Xm0+kTE6bLjDZFVP2dQ==
X-CSE-MsgGUID: KMW8ZvaESh6n8SQ3F16E6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93492240"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 02 Dec 2024 09:18:04 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIA3d-0002ej-0N;
	Mon, 02 Dec 2024 17:18:01 +0000
Date: Tue, 3 Dec 2024 01:17:37 +0800
From: kernel test robot <lkp@intel.com>
To: Philipp Stanner <pstanner@redhat.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?unknown-8bit?B?UMOpcmV6?= <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa: solidrun: Replace deprecated PCI functions
Message-ID: <202412030150.SVZbOVDL-lkp@intel.com>
References: <20241202122353.9793-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202122353.9793-2-pstanner@redhat.com>

Hi Philipp,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.13-rc1 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Philipp-Stanner/vdpa-solidrun-Replace-deprecated-PCI-functions/20241202-202728
base:   linus/master
patch link:    https://lore.kernel.org/r/20241202122353.9793-2-pstanner%40redhat.com
patch subject: [PATCH] vdpa: solidrun: Replace deprecated PCI functions
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20241203/202412030150.SVZbOVDL-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030150.SVZbOVDL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030150.SVZbOVDL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/vdpa/solidrun/snet_main.c: In function 'psnet_open_pf_bar':
>> drivers/vdpa/solidrun/snet_main.c:559:13: warning: unused variable 'ret' [-Wunused-variable]
     559 |         int ret;
         |             ^~~


vim +/ret +559 drivers/vdpa/solidrun/snet_main.c

   555	
   556	static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
   557	{
   558		char *name;
 > 559		int ret;
   560		unsigned short i, bars_found = 0;
   561		void __iomem *io;
   562	
   563		name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
   564		if (!name)
   565			return -ENOMEM;
   566	
   567		/* We don't know which BAR will be used to communicate..
   568		 * We will map every bar with len > 0.
   569		 *
   570		 * Later, we will discover the BAR and unmap all other BARs.
   571		 */
   572		for (i = 0; i < PCI_STD_NUM_BARS; i++) {
   573			if (pci_resource_len(pdev, i) == 0)
   574				continue;
   575	
   576			io = pcim_iomap_region(pdev, i, name);
   577			if (IS_ERR(io)) {
   578				SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
   579				return PTR_ERR(io);
   580			}
   581	
   582			psnet->bars[i] = io;
   583			bars_found++;
   584		}
   585	
   586		/* No BAR can be used.. */
   587		if (bars_found == 0) {
   588			SNET_ERR(pdev, "Failed to find a PCI BAR\n");
   589			return -ENODEV;
   590		}
   591	
   592		return 0;
   593	}
   594	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

