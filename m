Return-Path: <linux-kernel+bounces-188888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572598CE831
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 858D9B22D22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258E112E1F8;
	Fri, 24 May 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nms4ibFr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B425684D30;
	Fri, 24 May 2024 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565136; cv=none; b=DUN623rfgAxjSNVVcymczej+Xx7nEs2emnvtMNKE8c47lS+r1o8f+De33bttr1hrUx9kBFb6RP75ejLEgy60D3MUFUU+r0gBA/Qa1tzvrlEYcQAe2hXwvu7mAd/34LJyI+i2hU6Xtq4hyitXvtIJne2BMXuaSm2NeiBeDC4itSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565136; c=relaxed/simple;
	bh=b61opTK1KH6YtwVDrcPwkZAAgbYNEUe/PC2nBmuKlCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+Aw7Lj9XEKodTTzDIEXsk3tDL2nKhdDoVkWEdx1gTlvnVWc/21u0k9SoPgwCJKpYNGF584dATwiN2DJo2naO/KiAUPjoeq1gTb8mFPuSvyjg1A9IvbMUEvbRCmIIpmLyeIGi+bzxHTwdOBN4b/lYz39j/p1x3t5yNjF2M2Mqy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nms4ibFr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716565135; x=1748101135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b61opTK1KH6YtwVDrcPwkZAAgbYNEUe/PC2nBmuKlCI=;
  b=Nms4ibFr6ybbtHZ46gdBbagoKWNJMe26G7g5GJ2aUazsjEVOMNm7MJHU
   N88mr44OlkfW+9861vSEJQnCAjwKfaaJBFI2c0+Rzfpvjf04Q+eTy103v
   spArXFvq8jMrmjrGToI90o06sGaIS37Mqd7tbnT6cA7I048sv06RrUB6H
   2Qc62vIIX2kH5LxIHdNoqn0lzcaPxs8wDa8G1/Cb2PM4JjTyuPkSAajcn
   2LvsA15aE1NjE4y94u4lYHp/N1mhmDGn921/a6GVIVw+8e5EphbgcWV5p
   OfyCYNJXgKhxOhJM+j3y8XZip0NM1UVEPo+1meC1saKcZZCc7WJtCZ9Pl
   Q==;
X-CSE-ConnectionGUID: pNXtQe2ZTZuaHBmhCirjsg==
X-CSE-MsgGUID: /+SZKrJnRgCyl/JuUnK4jA==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="13123824"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="13123824"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 08:38:54 -0700
X-CSE-ConnectionGUID: wvym/ZEfS8+RgCtzWB+GLw==
X-CSE-MsgGUID: g29Fv+IYS/uEGWljXqgvhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="34649446"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 24 May 2024 08:38:51 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAX0K-0005Yl-13;
	Fri, 24 May 2024 15:38:48 +0000
Date: Fri, 24 May 2024 23:38:35 +0800
From: kernel test robot <lkp@intel.com>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
	dmitry.baryshkov@linaro.org, jthies@google.com, bleung@chromium.org,
	abhishekpandit@chromium.org, saranya.gopal@intel.com, lk@c--e.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	pmalani@chromium.org
Cc: oe-kbuild-all@lists.linux.dev, Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Subject: Re: [PATCH 2/2] usb: typec: ucsi: Enable UCSI v2.0 notifications
Message-ID: <202405242300.OetIYSh1-lkp@intel.com>
References: <20240524105837.15342-3-diogo.ivo@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524105837.15342-3-diogo.ivo@tecnico.ulisboa.pt>

Hi Diogo,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master next-20240523]
[cannot apply to v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Diogo-Ivo/usb-typec-ucsi-Add-new-capability-bits/20240524-190924
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240524105837.15342-3-diogo.ivo%40tecnico.ulisboa.pt
patch subject: [PATCH 2/2] usb: typec: ucsi: Enable UCSI v2.0 notifications
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240524/202405242300.OetIYSh1-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405242300.OetIYSh1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405242300.OetIYSh1-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/usb/typec/ucsi/ucsi.c: In function 'ucsi_get_supported_notifications':
>> drivers/usb/typec/ucsi/ucsi.c:1686:17: error: 'UCSI_ENABLE_NTFY_SINK_PATH_STS_CHANGE' undeclared (first use in this function); did you mean 'UCSI_ENABLE_NTFY_EXT_PWR_SRC_CHANGE'?
    1686 |         ntfy |= UCSI_ENABLE_NTFY_SINK_PATH_STS_CHANGE;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 UCSI_ENABLE_NTFY_EXT_PWR_SRC_CHANGE
   drivers/usb/typec/ucsi/ucsi.c:1686:17: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/usb/typec/ucsi/ucsi.c:1689:25: error: 'UCSI_ENABLE_NTFY_ATTENTION' undeclared (first use in this function); did you mean 'UCSI_ENABLE_NTFY_ERROR'?
    1689 |                 ntfy |= UCSI_ENABLE_NTFY_ATTENTION;
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         UCSI_ENABLE_NTFY_ERROR
>> drivers/usb/typec/ucsi/ucsi.c:1692:25: error: 'UCSI_ENABLE_NTFY_LPM_FW_UPDATE_REQ' undeclared (first use in this function)
    1692 |                 ntfy |= UCSI_ENABLE_NTFY_LPM_FW_UPDATE_REQ;
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/typec/ucsi/ucsi.c:1695:25: error: 'UCSI_ENABLE_NTFY_SECURITY_REQ_PARTNER' undeclared (first use in this function)
    1695 |                 ntfy |= UCSI_ENABLE_NTFY_SECURITY_REQ_PARTNER;
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/typec/ucsi/ucsi.c:1698:25: error: 'UCSI_ENABLE_NTFY_SET_RETIMER_MODE' undeclared (first use in this function); did you mean 'UCSI_CAP_SET_RETIMER_MODE'?
    1698 |                 ntfy |= UCSI_ENABLE_NTFY_SET_RETIMER_MODE;
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         UCSI_CAP_SET_RETIMER_MODE


vim +1686 drivers/usb/typec/ucsi/ucsi.c

  1664	
  1665	static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
  1666	{
  1667		u16 features = ucsi->cap.features;
  1668		u64 ntfy = UCSI_ENABLE_NTFY_ALL;
  1669	
  1670		if (!(features & UCSI_CAP_ALT_MODE_DETAILS))
  1671			ntfy &= ~UCSI_ENABLE_NTFY_CAM_CHANGE;
  1672	
  1673		if (!(features & UCSI_CAP_PDO_DETAILS))
  1674			ntfy &= ~(UCSI_ENABLE_NTFY_PWR_LEVEL_CHANGE |
  1675				  UCSI_ENABLE_NTFY_CAP_CHANGE);
  1676	
  1677		if (!(features & UCSI_CAP_EXT_SUPPLY_NOTIFICATIONS))
  1678			ntfy &= ~UCSI_ENABLE_NTFY_EXT_PWR_SRC_CHANGE;
  1679	
  1680		if (!(features & UCSI_CAP_PD_RESET))
  1681			ntfy &= ~UCSI_ENABLE_NTFY_PD_RESET_COMPLETE;
  1682	
  1683		if (ucsi->version <= UCSI_VERSION_1_2)
  1684			return ntfy;
  1685	
> 1686		ntfy |= UCSI_ENABLE_NTFY_SINK_PATH_STS_CHANGE;
  1687	
  1688		if (features & UCSI_CAP_GET_ATTENTION_VDO)
> 1689			ntfy |= UCSI_ENABLE_NTFY_ATTENTION;
  1690	
  1691		if (features & UCSI_CAP_FW_UPDATE_REQUEST)
> 1692			ntfy |= UCSI_ENABLE_NTFY_LPM_FW_UPDATE_REQ;
  1693	
  1694		if (features & UCSI_CAP_SECURITY_REQUEST)
> 1695			ntfy |= UCSI_ENABLE_NTFY_SECURITY_REQ_PARTNER;
  1696	
  1697		if (features & UCSI_CAP_SET_RETIMER_MODE)
> 1698			ntfy |= UCSI_ENABLE_NTFY_SET_RETIMER_MODE;
  1699	
  1700		return ntfy;
  1701	}
  1702	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

