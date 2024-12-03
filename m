Return-Path: <linux-kernel+bounces-429193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5925A9E1994
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFF01B2C668
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCAC1E0488;
	Tue,  3 Dec 2024 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWLvoIrQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C411185B48
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219728; cv=none; b=AWqPIzFq4cVDA2gNrDn6pHpd5fsY4A96+TTfHT2WUfyuwTVwlcL3lJ6L36zPxvIFzwwM+7f5Y5oDrp1IKh5ZSwpaUwQy7bpPQljEUQNYn4CJOa8V9lC8tceHEdx3XeVeBjYQi3sro5hmVoPzJ1jxuJBENO1hYqv6V/7cq7qK1lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219728; c=relaxed/simple;
	bh=7sqVKYvTrtgl99aCAEkkYZ0UGGHMyaOrJdFLgExAFYU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p26kiFPO19Fw8heCQmcZ4uxmaa6XupSq20l12PPW57UeGhsHhQcJlAiT3iqKjk7b83Cmdu8jBXvAN53PtG4nOmigl6M8/TYxOe8Qzav3bv0r4KQa3cDgW573Z7d3ndj68FHfJqs0j8a/xHEJHM4DR6JVTvVfg+s84wWuSl+9sd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWLvoIrQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733219727; x=1764755727;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7sqVKYvTrtgl99aCAEkkYZ0UGGHMyaOrJdFLgExAFYU=;
  b=VWLvoIrQAU+WRB3gzgSPf3TvJW5Wym02qos2UoLeGrU+e2g+yvwBmaA0
   n8a0Xs0WRiFu9XabhdsbkqpXDs8t9HTPhMrIrJ/nMiOF1iH8iAOh7wytd
   /4iwI84zT4Udj4Kz5y1bOyqA53WHZONNZN1AD4SsC0j/ADsrqWEBrWKUB
   KF7tQubBMmVBciBVMTLjvwr/CrAYfzNttlF73aUS7PCcqaU6/DlPA9ieV
   WLWFzIxmgl7O+KoqdCFHP1Dle5qVPZxKewV0SO036wTZl6N15x/n/9kKc
   42wkxaiq7Q8KCxqRaVch5lafdng3OKGqiyVaqbabwg+AxcYUr/iKEb2oL
   w==;
X-CSE-ConnectionGUID: 2bPSu+AuSY6HY/PmcgFi7g==
X-CSE-MsgGUID: WN51r+zoQT6F0zHkNuDQAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44034163"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44034163"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 01:55:26 -0800
X-CSE-ConnectionGUID: Fx1k/0SpTouLmP2mdt/DxQ==
X-CSE-MsgGUID: YRyN5NWSQlyS+o6CsisqrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93046602"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 03 Dec 2024 01:55:24 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIPcn-0000Vb-2S;
	Tue, 03 Dec 2024 09:55:21 +0000
Date: Tue, 3 Dec 2024 17:54:52 +0800
From: kernel test robot <lkp@intel.com>
To: WANG Xuerui <git@xen0n.name>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>
Subject: drivers/vdpa/pds/debugfs.c:266:49: warning: '%02d' directive output
 may be truncated writing between 2 and 11 bytes into a region of size 6
Message-ID: <202412031726.c8OLuPOm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
commit: 3f301dc292eb122eff61b8b2906e519154b0327f LoongArch: Replace -ffreestanding with finer-grained -fno-builtin's
date:   1 year, 3 months ago
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20241203/202412031726.c8OLuPOm-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031726.c8OLuPOm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031726.c8OLuPOm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/vdpa/pds/debugfs.c: In function 'pds_vdpa_debugfs_add_vdpadev':
>> drivers/vdpa/pds/debugfs.c:266:49: warning: '%02d' directive output may be truncated writing between 2 and 11 bytes into a region of size 6 [-Wformat-truncation=]
     266 |                 snprintf(name, sizeof(name), "vq%02d", i);
         |                                                 ^~~~
   drivers/vdpa/pds/debugfs.c:266:46: note: directive argument in the range [-2147483641, 254]
     266 |                 snprintf(name, sizeof(name), "vq%02d", i);
         |                                              ^~~~~~~~
   drivers/vdpa/pds/debugfs.c:266:17: note: 'snprintf' output between 5 and 14 bytes into a destination of size 8
     266 |                 snprintf(name, sizeof(name), "vq%02d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/net/wireless/intersil/p54/fwio.c: In function 'p54_parse_firmware':
>> drivers/net/wireless/intersil/p54/fwio.c:128:34: warning: '%s' directive output may be truncated writing up to 39 bytes into a region of size 32 [-Wformat-truncation=]
     128 |                                 "%s - %x.%x", fw_version,
         |                                  ^~
   drivers/net/wireless/intersil/p54/fwio.c:128:33: note: directive argument in the range [0, 16777215]
     128 |                                 "%s - %x.%x", fw_version,
         |                                 ^~~~~~~~~~~~
   drivers/net/wireless/intersil/p54/fwio.c:128:33: note: directive argument in the range [0, 255]
   drivers/net/wireless/intersil/p54/fwio.c:127:17: note: 'snprintf' output between 7 and 52 bytes into a destination of size 32
     127 |                 snprintf(dev->wiphy->fw_version, sizeof(dev->wiphy->fw_version),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     128 |                                 "%s - %x.%x", fw_version,
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~
     129 |                                 priv->fw_var >> 8, priv->fw_var & 0xff);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/net/ethernet/marvell/octeontx2/af/cgx.c: In function 'cgx_lmac_init':
>> drivers/net/ethernet/marvell/octeontx2/af/cgx.c:1662:49: warning: '%d' directive writing between 1 and 11 bytes into a region of size between 4 and 6 [-Wformat-overflow=]
    1662 |                 sprintf(lmac->name, "cgx_fwi_%d_%d", cgx->cgx_id, i);
         |                                                 ^~
   drivers/net/ethernet/marvell/octeontx2/af/cgx.c:1662:37: note: directive argument in the range [-2147483641, 254]
    1662 |                 sprintf(lmac->name, "cgx_fwi_%d_%d", cgx->cgx_id, i);
         |                                     ^~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/cgx.c:1662:17: note: 'sprintf' output between 12 and 24 bytes into a destination of size 16
    1662 |                 sprintf(lmac->name, "cgx_fwi_%d_%d", cgx->cgx_id, i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c: In function 'rvu_dbg_mcs_init':
>> drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c:533:36: warning: '%d' directive writing between 1 and 11 bytes into a region of size 7 [-Wformat-overflow=]
     533 |                 sprintf(dname, "mcs%d", i);
         |                                    ^~
   drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c:533:32: note: directive argument in the range [-2147483641, 2147483646]
     533 |                 sprintf(dname, "mcs%d", i);
         |                                ^~~~~~~
   drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c:533:17: note: 'sprintf' output between 5 and 15 bytes into a destination of size 10
     533 |                 sprintf(dname, "mcs%d", i);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +266 drivers/vdpa/pds/debugfs.c

151cc834f3ddaf Shannon Nelson 2023-05-19  256  
151cc834f3ddaf Shannon Nelson 2023-05-19  257  void pds_vdpa_debugfs_add_vdpadev(struct pds_vdpa_aux *vdpa_aux)
151cc834f3ddaf Shannon Nelson 2023-05-19  258  {
151cc834f3ddaf Shannon Nelson 2023-05-19  259  	int i;
151cc834f3ddaf Shannon Nelson 2023-05-19  260  
151cc834f3ddaf Shannon Nelson 2023-05-19  261  	debugfs_create_file("config", 0400, vdpa_aux->dentry, vdpa_aux->pdsv, &config_fops);
151cc834f3ddaf Shannon Nelson 2023-05-19  262  
151cc834f3ddaf Shannon Nelson 2023-05-19  263  	for (i = 0; i < vdpa_aux->pdsv->num_vqs; i++) {
151cc834f3ddaf Shannon Nelson 2023-05-19  264  		char name[8];
151cc834f3ddaf Shannon Nelson 2023-05-19  265  
151cc834f3ddaf Shannon Nelson 2023-05-19 @266  		snprintf(name, sizeof(name), "vq%02d", i);
151cc834f3ddaf Shannon Nelson 2023-05-19  267  		debugfs_create_file(name, 0400, vdpa_aux->dentry,
151cc834f3ddaf Shannon Nelson 2023-05-19  268  				    &vdpa_aux->pdsv->vqs[i], &vq_fops);
151cc834f3ddaf Shannon Nelson 2023-05-19  269  	}
151cc834f3ddaf Shannon Nelson 2023-05-19  270  }
151cc834f3ddaf Shannon Nelson 2023-05-19  271  

:::::: The code at line 266 was first introduced by commit
:::::: 151cc834f3ddafec869269fe48036460d920d08a pds_vdpa: add support for vdpa and vdpamgmt interfaces

:::::: TO: Shannon Nelson <shannon.nelson@amd.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

