Return-Path: <linux-kernel+bounces-362186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B5F99B1E2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F71D1F260AC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C0913E41A;
	Sat, 12 Oct 2024 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="djDhLAS4"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47112CD89
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728719953; cv=none; b=d+vue9C6I0VU7Q0Ckuk4deDATCHfSqpqCev1wfGIpI7eXZFr1+oI5SVx43RXWA1PUSVupA0I6QDijlWCxcyU3W+NUZJgWZdFzmzLPk1g5MbYQawwS3Jxz2h/Yr0pTc7LwLeYJ7IefewBHd3fTwSdPD0w7KWpxf6Tef0BkILJ+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728719953; c=relaxed/simple;
	bh=cxzXg9dgC9cCXyIdI31fmObrQTvtxDdxIW73/tNO8aM=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=UV4CuAsh/6pesmkxMVIqp7WsoFc5Vd4kgCUCA4IQD77dkcVh7FNCPZ4LKMqvFYDuQu215kXATRVUBRNNCBhNeyJ8+BYgFuAwqlyO0eC0IyZrgf+RsOR3slVu1siAq6vz+1jsS5gDaGIDWkCEpucqFg+Y/bgj0uUBtbH0IuAM3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=djDhLAS4; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xc7x//zeily7GNGxNXuk+OmlA9OzzeNt8gs2K3SzbdM=;
  b=djDhLAS4jFt7ePhEFr1//4zAboYyM9RmjYna1Yv2rzfA47oTAuBWXJ7V
   BTeNdpCPDa0hDvh58St3hdQnC3mynRU4MZkqYwPjiPCbfoEQAXFINK5ra
   I4HIBQg0GqUz+mXly6Op+mvNjA7ikSH5wi2I7TAaeDhmQ4tom1OUv6pKa
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,198,1725314400"; 
   d="scan'208";a="98914526"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2024 09:59:01 +0200
Date: Sat, 12 Oct 2024 09:59:00 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Karol Kolacinski <karol.kolacinski@intel.com>, 
    Jakub Kicinski <kuba@kernel.org>, 
    Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
    Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
    Jacob Keller <jacob.e.keller@intel.com>
cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/net/ethernet/intel/ice/ice_ptp_hw.c:396:4-22: opportunity
 for str_enabled_disabled(dw24 . ts_pll_enable) (fwd)
Message-ID: <alpine.DEB.2.22.394.2410120958080.3377@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Sat, 12 Oct 2024 15:17:38 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/net/ethernet/intel/ice/ice_ptp_hw.c:396:4-22: opportunity for
    str_enabled_disabled(dw24 . ts_pll_enable)

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Karol Kolacinski <karol.kolacinski@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC: Jacob Keller <jacob.e.keller@intel.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   09f6b0c8904bfaa1e0601bc102e1b6aa6de8c98f
commit: b390ecc2e375f8973c512a5041a69555069f502a ice: Change CGU regs struct to anonymous
date:   4 months ago
:::::: branch date: 8 hours ago
:::::: commit date: 4 months ago
config: i386-randconfig-051-20241012 (https://download.01.org/0day-ci/archive/20241012/202410121553.SRNFzc2M-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202410121553.SRNFzc2M-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:396:4-22: opportunity for str_enabled_disabled(dw24 . ts_pll_enable)
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:474:4-22: opportunity for str_enabled_disabled(dw24 . ts_pll_enable)

vim +396 drivers/net/ethernet/intel/ice/ice_ptp_hw.c

3a7496234d179a Jacob Keller       2021-10-13  336
3a7496234d179a Jacob Keller       2021-10-13  337  /**
39ecb29df855ce Sergey Temerkhanov 2024-05-28  338   * ice_cfg_cgu_pll_e82x - Configure the Clock Generation Unit
d551d075b04382 Karol Kolacinski   2024-05-28  339   * @hw: pointer to the HW struct
39ecb29df855ce Sergey Temerkhanov 2024-05-28  340   * @clk_freq: Clock frequency to program
39ecb29df855ce Sergey Temerkhanov 2024-05-28  341   * @clk_src: Clock source to select (TIME_REF, or TCX0)
39ecb29df855ce Sergey Temerkhanov 2024-05-28  342   *
39ecb29df855ce Sergey Temerkhanov 2024-05-28  343   * Configure the Clock Generation Unit with the desired clock frequency and
39ecb29df855ce Sergey Temerkhanov 2024-05-28  344   * time reference, enabling the PLL which drives the PTP hardware clock.
39ecb29df855ce Sergey Temerkhanov 2024-05-28  345   *
39ecb29df855ce Sergey Temerkhanov 2024-05-28  346   * Return:
39ecb29df855ce Sergey Temerkhanov 2024-05-28  347   * * %0       - success
39ecb29df855ce Sergey Temerkhanov 2024-05-28  348   * * %-EINVAL - input parameters are incorrect
39ecb29df855ce Sergey Temerkhanov 2024-05-28  349   * * %-EBUSY  - failed to lock TS PLL
39ecb29df855ce Sergey Temerkhanov 2024-05-28  350   * * %other   - CGU read/write failure
3a7496234d179a Jacob Keller       2021-10-13  351   */
39ecb29df855ce Sergey Temerkhanov 2024-05-28  352  static int ice_cfg_cgu_pll_e82x(struct ice_hw *hw,
39ecb29df855ce Sergey Temerkhanov 2024-05-28  353  				enum ice_time_ref_freq clk_freq,
39ecb29df855ce Sergey Temerkhanov 2024-05-28  354  				enum ice_clk_src clk_src)
3a7496234d179a Jacob Keller       2021-10-13  355  {
39ecb29df855ce Sergey Temerkhanov 2024-05-28  356  	union tspll_ro_bwm_lf bwm_lf;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  357  	union nac_cgu_dword19 dw19;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  358  	union nac_cgu_dword22 dw22;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  359  	union nac_cgu_dword24 dw24;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  360  	union nac_cgu_dword9 dw9;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  361  	int err;
3a7496234d179a Jacob Keller       2021-10-13  362
39ecb29df855ce Sergey Temerkhanov 2024-05-28  363  	if (clk_freq >= NUM_ICE_TIME_REF_FREQ) {
39ecb29df855ce Sergey Temerkhanov 2024-05-28  364  		dev_warn(ice_hw_to_dev(hw), "Invalid TIME_REF frequency %u\n",
39ecb29df855ce Sergey Temerkhanov 2024-05-28  365  			 clk_freq);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  366  		return -EINVAL;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  367  	}
3a7496234d179a Jacob Keller       2021-10-13  368
39ecb29df855ce Sergey Temerkhanov 2024-05-28  369  	if (clk_src >= NUM_ICE_CLK_SRC) {
39ecb29df855ce Sergey Temerkhanov 2024-05-28  370  		dev_warn(ice_hw_to_dev(hw), "Invalid clock source %u\n",
39ecb29df855ce Sergey Temerkhanov 2024-05-28  371  			 clk_src);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  372  		return -EINVAL;
3a7496234d179a Jacob Keller       2021-10-13  373  	}
3a7496234d179a Jacob Keller       2021-10-13  374
39ecb29df855ce Sergey Temerkhanov 2024-05-28  375  	if (clk_src == ICE_CLK_SRC_TCX0 &&
39ecb29df855ce Sergey Temerkhanov 2024-05-28  376  	    clk_freq != ICE_TIME_REF_FREQ_25_000) {
39ecb29df855ce Sergey Temerkhanov 2024-05-28  377  		dev_warn(ice_hw_to_dev(hw),
39ecb29df855ce Sergey Temerkhanov 2024-05-28  378  			 "TCX0 only supports 25 MHz frequency\n");
39ecb29df855ce Sergey Temerkhanov 2024-05-28  379  		return -EINVAL;
3a7496234d179a Jacob Keller       2021-10-13  380  	}
3a7496234d179a Jacob Keller       2021-10-13  381
39ecb29df855ce Sergey Temerkhanov 2024-05-28  382  	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD9, &dw9.val);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  383  	if (err)
39ecb29df855ce Sergey Temerkhanov 2024-05-28  384  		return err;
3a7496234d179a Jacob Keller       2021-10-13  385
39ecb29df855ce Sergey Temerkhanov 2024-05-28  386  	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD24, &dw24.val);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  387  	if (err)
39ecb29df855ce Sergey Temerkhanov 2024-05-28  388  		return err;
3a7496234d179a Jacob Keller       2021-10-13  389
39ecb29df855ce Sergey Temerkhanov 2024-05-28  390  	err = ice_read_cgu_reg_e82x(hw, TSPLL_RO_BWM_LF, &bwm_lf.val);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  391  	if (err)
39ecb29df855ce Sergey Temerkhanov 2024-05-28  392  		return err;
3a7496234d179a Jacob Keller       2021-10-13  393
39ecb29df855ce Sergey Temerkhanov 2024-05-28  394  	/* Log the current clock configuration */
39ecb29df855ce Sergey Temerkhanov 2024-05-28  395  	ice_debug(hw, ICE_DBG_PTP, "Current CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
b390ecc2e375f8 Karol Kolacinski   2024-05-28 @396  		  dw24.ts_pll_enable ? "enabled" : "disabled",
b390ecc2e375f8 Karol Kolacinski   2024-05-28  397  		  ice_clk_src_str(dw24.time_ref_sel),
b390ecc2e375f8 Karol Kolacinski   2024-05-28  398  		  ice_clk_freq_str(dw9.time_ref_freq_sel),
b390ecc2e375f8 Karol Kolacinski   2024-05-28  399  		  bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
3a7496234d179a Jacob Keller       2021-10-13  400
39ecb29df855ce Sergey Temerkhanov 2024-05-28  401  	/* Disable the PLL before changing the clock source or frequency */
b390ecc2e375f8 Karol Kolacinski   2024-05-28  402  	if (dw24.ts_pll_enable) {
b390ecc2e375f8 Karol Kolacinski   2024-05-28  403  		dw24.ts_pll_enable = 0;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  404
39ecb29df855ce Sergey Temerkhanov 2024-05-28  405  		err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD24, dw24.val);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  406  		if (err)
3a7496234d179a Jacob Keller       2021-10-13  407  			return err;
3a7496234d179a Jacob Keller       2021-10-13  408  	}
3a7496234d179a Jacob Keller       2021-10-13  409
39ecb29df855ce Sergey Temerkhanov 2024-05-28  410  	/* Set the frequency */
b390ecc2e375f8 Karol Kolacinski   2024-05-28  411  	dw9.time_ref_freq_sel = clk_freq;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  412  	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD9, dw9.val);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  413  	if (err)
39ecb29df855ce Sergey Temerkhanov 2024-05-28  414  		return err;
3a7496234d179a Jacob Keller       2021-10-13  415
39ecb29df855ce Sergey Temerkhanov 2024-05-28  416  	/* Configure the TS PLL feedback divisor */
39ecb29df855ce Sergey Temerkhanov 2024-05-28  417  	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD19, &dw19.val);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  418  	if (err)
39ecb29df855ce Sergey Temerkhanov 2024-05-28  419  		return err;
3a7496234d179a Jacob Keller       2021-10-13  420
b390ecc2e375f8 Karol Kolacinski   2024-05-28  421  	dw19.tspll_fbdiv_intgr = e822_cgu_params[clk_freq].feedback_div;
b390ecc2e375f8 Karol Kolacinski   2024-05-28  422  	dw19.tspll_ndivratio = 1;
3a7496234d179a Jacob Keller       2021-10-13  423
39ecb29df855ce Sergey Temerkhanov 2024-05-28  424  	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD19, dw19.val);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  425  	if (err)
39ecb29df855ce Sergey Temerkhanov 2024-05-28  426  		return err;
3a7496234d179a Jacob Keller       2021-10-13  427
39ecb29df855ce Sergey Temerkhanov 2024-05-28  428  	/* Configure the TS PLL post divisor */
39ecb29df855ce Sergey Temerkhanov 2024-05-28  429  	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD22, &dw22.val);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  430  	if (err)
3a7496234d179a Jacob Keller       2021-10-13  431  		return err;
3a7496234d179a Jacob Keller       2021-10-13  432
b390ecc2e375f8 Karol Kolacinski   2024-05-28  433  	dw22.time1588clk_div = e822_cgu_params[clk_freq].post_pll_div;
b390ecc2e375f8 Karol Kolacinski   2024-05-28  434  	dw22.time1588clk_sel_div2 = 0;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  435
39ecb29df855ce Sergey Temerkhanov 2024-05-28  436  	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD22, dw22.val);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  437  	if (err)
3a7496234d179a Jacob Keller       2021-10-13  438  		return err;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  439
39ecb29df855ce Sergey Temerkhanov 2024-05-28  440  	/* Configure the TS PLL pre divisor and clock source */
39ecb29df855ce Sergey Temerkhanov 2024-05-28  441  	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD24, &dw24.val);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  442  	if (err)
39ecb29df855ce Sergey Temerkhanov 2024-05-28  443  		return err;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  444
b390ecc2e375f8 Karol Kolacinski   2024-05-28  445  	dw24.ref1588_ck_div = e822_cgu_params[clk_freq].refclk_pre_div;
b390ecc2e375f8 Karol Kolacinski   2024-05-28  446  	dw24.tspll_fbdiv_frac = e822_cgu_params[clk_freq].frac_n_div;
b390ecc2e375f8 Karol Kolacinski   2024-05-28  447  	dw24.time_ref_sel = clk_src;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  448
39ecb29df855ce Sergey Temerkhanov 2024-05-28  449  	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD24, dw24.val);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  450  	if (err)
39ecb29df855ce Sergey Temerkhanov 2024-05-28  451  		return err;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  452
39ecb29df855ce Sergey Temerkhanov 2024-05-28  453  	/* Finally, enable the PLL */
b390ecc2e375f8 Karol Kolacinski   2024-05-28  454  	dw24.ts_pll_enable = 1;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  455
39ecb29df855ce Sergey Temerkhanov 2024-05-28  456  	err = ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD24, dw24.val);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  457  	if (err)
39ecb29df855ce Sergey Temerkhanov 2024-05-28  458  		return err;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  459
39ecb29df855ce Sergey Temerkhanov 2024-05-28  460  	/* Wait to verify if the PLL locks */
39ecb29df855ce Sergey Temerkhanov 2024-05-28  461  	usleep_range(1000, 5000);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  462
39ecb29df855ce Sergey Temerkhanov 2024-05-28  463  	err = ice_read_cgu_reg_e82x(hw, TSPLL_RO_BWM_LF, &bwm_lf.val);
39ecb29df855ce Sergey Temerkhanov 2024-05-28  464  	if (err)
39ecb29df855ce Sergey Temerkhanov 2024-05-28  465  		return err;
39ecb29df855ce Sergey Temerkhanov 2024-05-28  466
b390ecc2e375f8 Karol Kolacinski   2024-05-28  467  	if (!bwm_lf.plllock_true_lock_cri) {
39ecb29df855ce Sergey Temerkhanov 2024-05-28  468  		dev_warn(ice_hw_to_dev(hw), "CGU PLL failed to lock\n");
39ecb29df855ce Sergey Temerkhanov 2024-05-28  469  		return -EBUSY;
3a7496234d179a Jacob Keller       2021-10-13  470  	}
3a7496234d179a Jacob Keller       2021-10-13  471
39ecb29df855ce Sergey Temerkhanov 2024-05-28  472  	/* Log the current clock configuration */
39ecb29df855ce Sergey Temerkhanov 2024-05-28  473  	ice_debug(hw, ICE_DBG_PTP, "New CGU configuration -- %s, clk_src %s, clk_freq %s, PLL %s\n",
b390ecc2e375f8 Karol Kolacinski   2024-05-28  474  		  dw24.ts_pll_enable ? "enabled" : "disabled",
b390ecc2e375f8 Karol Kolacinski   2024-05-28  475  		  ice_clk_src_str(dw24.time_ref_sel),
b390ecc2e375f8 Karol Kolacinski   2024-05-28  476  		  ice_clk_freq_str(dw9.time_ref_freq_sel),
b390ecc2e375f8 Karol Kolacinski   2024-05-28  477  		  bwm_lf.plllock_true_lock_cri ? "locked" : "unlocked");
3a7496234d179a Jacob Keller       2021-10-13  478
3a7496234d179a Jacob Keller       2021-10-13  479  	return 0;
3a7496234d179a Jacob Keller       2021-10-13  480  }
3a7496234d179a Jacob Keller       2021-10-13  481

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

