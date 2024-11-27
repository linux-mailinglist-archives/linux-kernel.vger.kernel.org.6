Return-Path: <linux-kernel+bounces-423933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C929DAE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003FC1639E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089A6202F72;
	Wed, 27 Nov 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/Gwgo7J"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763C2CCC0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732738882; cv=none; b=aIGxX3naDKV4CjDsvGDePMWHDHC4h/pfR3MXL06HCeF9UrB/pMsylJi9P4jec151edhEifhiN4OdKHGwJrazrDGSRaUhpuuXMKkG3lzx+axrnSD/bc8prFJhM8/UbTwk2NhG6dSJrVyC1du3lkVc72ihr8Lb0Rqv1EyatEQ3nMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732738882; c=relaxed/simple;
	bh=H8seXUe/eRMaHx0BuL08kr/UFvhuKtwPm8qMsyQPpFE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jVKQD3Exe5vzv1vkhxqizhN39980XV7lWknxSlR2AqHtE7aUkyigfh9TxKgSnq6ucRKRkB7QnzhP+FexUkxK9oM6yfxsanxMnie8KMfXuXJGvPseu3OfHIML6lwgZTR2BkUJpxbJc9ucQLKi93kDgdXXbj4XR+GxFXXERvKm4l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/Gwgo7J; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732738880; x=1764274880;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=H8seXUe/eRMaHx0BuL08kr/UFvhuKtwPm8qMsyQPpFE=;
  b=C/Gwgo7JJC496s1dC8rklkVioLWmQTShhfhLuZPrivNcPxW6vzZn+fLw
   MhfaPadJfUddp0M6Wm3eQQbuWx7yu+tzJmGEyIZ8q5Jx6lAH9iIkWuwsR
   RmzkGxFFDI95KeGWPFiOz6t/Qp+uxNE7EPx0bLNUW/vtcu90A8QtJukYX
   BVR2rKoi2idAjRGRTU+BmHc0Lfk9dv5zq9uJtQDZz0I/B9knLev85E1os
   RFcCOtiCJbTWPsdlPdi3sGgQtqzvThFsMhoPIrvagd5iaVrfMlR4UWVI+
   J897ySlOl4HYIPFlSiRkoZp9UV1oi3zNVdOKtU2SN3tjaSp2rvN2mxQrO
   w==;
X-CSE-ConnectionGUID: z2vjZjnjScKZepAAJwA06w==
X-CSE-MsgGUID: sd/FwAUjQcW8uPh/avXEvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="36886806"
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="36886806"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 12:21:20 -0800
X-CSE-ConnectionGUID: cZCNryF2THSnu1sHBptssA==
X-CSE-MsgGUID: wKm1xg/xQiSitu6i2FMu9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="92875829"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 27 Nov 2024 12:21:18 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGOXE-0008L5-0K;
	Wed, 27 Nov 2024 20:21:16 +0000
Date: Thu, 28 Nov 2024 04:20:23 +0800
From: kernel test robot <lkp@intel.com>
To: Yan-Hsuan Chuang <yhchuang@realtek.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kalle Valo <kvalo@codeaurora.org>,
	Stanislaw Gruszka <sgruszka@redhat.com>,
	Brian Norris <briannorris@chromium.org>
Subject: drivers/net/wireless/realtek/rtw88/rtw8822c.c:329:1: warning: the
 frame size of 1072 bytes is larger than 1024 bytes
Message-ID: <202411280441.XgddHSn0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7d4050728c83aa63828494ad0f4d0eb4faf5f97a
commit: e3037485c68ec1a299ff41160d8fedbd4abc29b9 rtw88: new Realtek 802.11ac driver
date:   6 years ago
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20241128/202411280441.XgddHSn0-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411280441.XgddHSn0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411280441.XgddHSn0-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:5,
                    from ./arch/xtensa/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/net/mac80211.h:19,
                    from drivers/net/wireless/realtek/rtw88/main.h:8,
                    from drivers/net/wireless/realtek/rtw88/rtw8822c.c:5:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/xtensa/include/asm/page.h:182:16: warning: comparison of unsigned expression in '>= 0' is always true [-Wtype-limits]
     182 |         ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
         |                ^~
   include/linux/compiler.h:77:45: note: in definition of macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/scatterlist.h:143:9: note: in expansion of macro 'BUG_ON'
     143 |         BUG_ON(!virt_addr_valid(buf));
         |         ^~~~~~
   arch/xtensa/include/asm/page.h:190:33: note: in expansion of macro 'pfn_valid'
     190 | #define virt_addr_valid(kaddr)  pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
         |                                 ^~~~~~~~~
   include/linux/scatterlist.h:143:17: note: in expansion of macro 'virt_addr_valid'
     143 |         BUG_ON(!virt_addr_valid(buf));
         |                 ^~~~~~~~~~~~~~~
   include/linux/dma-mapping.h: In function 'dma_map_resource':
   arch/xtensa/include/asm/page.h:182:16: warning: comparison of unsigned expression in '>= 0' is always true [-Wtype-limits]
     182 |         ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
         |                ^~
   include/asm-generic/bug.h:148:34: note: in definition of macro 'WARN_ON_ONCE'
     148 |         int __ret_warn_once = !!(condition);                    \
         |                                  ^~~~~~~~~
   include/linux/dma-mapping.h:359:26: note: in expansion of macro 'pfn_valid'
     359 |         if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
         |                          ^~~~~~~~~
   drivers/net/wireless/realtek/rtw88/rtw8822c.c: In function 'rtw8822c_dac_cal_rf_mode':
>> drivers/net/wireless/realtek/rtw88/rtw8822c.c:329:1: warning: the frame size of 1072 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     329 | }
         | ^


vim +329 drivers/net/wireless/realtek/rtw88/rtw8822c.c

   312	
   313	static void rtw8822c_dac_cal_rf_mode(struct rtw_dev *rtwdev,
   314					     u32 *i_value, u32 *q_value)
   315	{
   316		u32 iv[DACK_SN_8822C], qv[DACK_SN_8822C];
   317		u32 rf_a, rf_b;
   318	
   319		mdelay(10);
   320	
   321		rf_a = rtw_read_rf(rtwdev, RF_PATH_A, 0x0, RFREG_MASK);
   322		rf_b = rtw_read_rf(rtwdev, RF_PATH_B, 0x0, RFREG_MASK);
   323	
   324		rtw_dbg(rtwdev, RTW_DBG_RFK, "[DACK] RF path-A=0x%05x\n", rf_a);
   325		rtw_dbg(rtwdev, RTW_DBG_RFK, "[DACK] RF path-B=0x%05x\n", rf_b);
   326	
   327		rtw8822c_dac_cal_iq_sample(rtwdev, iv, qv);
   328		rtw8822c_dac_cal_iq_search(rtwdev, iv, qv, i_value, q_value);
 > 329	}
   330	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

