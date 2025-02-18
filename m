Return-Path: <linux-kernel+bounces-518576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1206AA39118
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 04:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE903A8D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 03:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EE315667D;
	Tue, 18 Feb 2025 03:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8Bo9QiY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125E818C31
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848056; cv=none; b=D5NlowsMvxTQ6MvF5+O+UcdHWXktHHLlsiWdKbyKo3IuBjZlOGvdYjfg/ocyjCmRhI/QXsgq188rkhP8sXAfeQ/qIiyB5yp9sMEDlwUI5Gc6RcLBHdxKOCMfvkauUYjPWbk5UQOti14ttXXO5xc93jXoV11Jgsahveq7QE9w2XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848056; c=relaxed/simple;
	bh=LJCRGsPscyCMWgefTOMlF4XecTltnIfoamUgwmuNWoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KNEeRRYkA7MrB1eNVShSVgfmnmb/B02VxzJG3wjG/BI8HN96FNA+fSEoTr/oJ/Gi6cidGy+YL1h+ffTxTts0zKE19L6o3wXy+bMyfEhgZKRIFAPvSZu8kRmZppy5pULKwAblZucMxR8it45wf4N/HI9Ql/VpqdAw+DK2equ1Rh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8Bo9QiY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739848055; x=1771384055;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LJCRGsPscyCMWgefTOMlF4XecTltnIfoamUgwmuNWoQ=;
  b=O8Bo9QiY1hAhWIy6TGb91N8XUmfXZ6Z+Br81RZ4RcBSpZu0ldr7nk26T
   5l4lQVPbR7XJI0324IV9LkmED6BjxZQNs499SKEEeHMRbQxDCBatF8mj/
   FGU0ipLPV98H1PknTR+roFJkOcAB2yCjKi8qipKoUtMJshi/48mGEbZf0
   UVvivvyiKIWcrMV4fSQavaTQT7MBW7Tn3iLEzzlmzvw+GLM6qXQMaO2x7
   poNA4QZhKNOXX74t8pL6q+GIQKO0+AQmHY5m/qIFilGDA3DLsHG9Sl6mG
   PG1FZFZJ+wHZOnkM8Uuw0Ef0O+69qgiK94Er78XJGxGS7ivTKOXI+rzZh
   Q==;
X-CSE-ConnectionGUID: pVWgzcTMTYOTM442TQwJpQ==
X-CSE-MsgGUID: hcSUXYSsSCadb44VDP0kqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44182362"
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="44182362"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 19:07:35 -0800
X-CSE-ConnectionGUID: ZE877J0WRiaNmAglAEfRbQ==
X-CSE-MsgGUID: aUXGUHQRRZeKmyPbe0Jlfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,294,1732608000"; 
   d="scan'208";a="114249776"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 17 Feb 2025 19:07:32 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkDx5-00006t-1r;
	Tue, 18 Feb 2025 03:07:19 +0000
Date: Tue, 18 Feb 2025 11:06:56 +0800
From: kernel test robot <lkp@intel.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Jinyang He <hejinyang@loongson.cn>,
	Youling Tang <tangyouling@loongson.cn>
Subject: drivers/net/wireless/ath/ath10k/mac.o: warning: objtool:
 ath10k_monitor_start+0x240: stack state mismatch: reg1[26]=-1+0
 reg2[26]=-2-40
Message-ID: <202502181126.ot62N8wN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2408a807bfc3f738850ef5ad5e3fd59d66168996
commit: cb8a2ef0848ca80d67d6d56e2df757cfdf6b3355 LoongArch: Add ORC stack unwinder support
date:   11 months ago
config: loongarch-randconfig-r051-20250218 (https://download.01.org/0day-ci/archive/20250218/202502181126.ot62N8wN-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250218/202502181126.ot62N8wN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502181126.ot62N8wN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath10k/mac.o: warning: objtool: ath10k_monitor_start+0x240: stack state mismatch: reg1[26]=-1+0 reg2[26]=-2-40
>> drivers/net/wireless/ath/ath10k/mac.o: warning: objtool: ath10k_peer_assoc_h_ht+0x438: stack state mismatch: reg1[22]=-1+0 reg2[22]=-2-16
>> drivers/net/wireless/ath/ath10k/mac.o: warning: objtool: ath10k_peer_assoc_h_vht+0x3e8: stack state mismatch: reg1[22]=-1+0 reg2[22]=-2-16
>> drivers/net/wireless/ath/ath10k/mac.o: warning: objtool: ath10k_control_beaconing+0x2a8: stack state mismatch: reg1[27]=-1+0 reg2[27]=-2-48
>> drivers/net/wireless/ath/ath10k/mac.o: warning: objtool: ath10k_mac_handle_tx_pause_iter+0xec: stack state mismatch: reg1[25]=-1+0 reg2[25]=-2-32
--
>> drivers/net/wireless/ath/ath10k/core.o: warning: objtool: ath10k_core_check_bdfext+0x230: stack state mismatch: reg1[24]=-1+0 reg2[24]=-2-24
>> drivers/net/wireless/ath/ath10k/core.o: warning: objtool: ath10k_core_copy_target_iram+0x2d4: stack state mismatch: reg1[24]=-1+0 reg2[24]=-2-24
>> drivers/net/wireless/ath/ath10k/core.o: warning: objtool: ath10k_download_cal_data+0x3a0: stack state mismatch: reg1[25]=-1+0 reg2[25]=-2-32
--
>> drivers/net/wireless/ath/ath10k/htt_rx.o: warning: objtool: ath10k_update_per_peer_tx_stats+0x590: stack state mismatch: reg1[22]=-1+0 reg2[22]=-2-16
>> drivers/net/wireless/ath/ath10k/htt_rx.o: warning: objtool: ath10k_htt_rx_alloc+0x2e0: stack state mismatch: reg1[25]=-1+0 reg2[25]=-2-32
--
>> drivers/net/wireless/ath/ath10k/htt_tx.o: warning: objtool: __ath10k_htt_tx_txq_recalc.isra.0+0x354: stack state mismatch: reg1[26]=-1+0 reg2[26]=-2-40
--
>> drivers/net/wireless/ath/ath10k/wmi.o: warning: objtool: ath10k_wmi_handle_tdls_peer_event+0x24c: stack state mismatch: reg1[25]=-1+0 reg2[25]=-2-32
>> drivers/net/wireless/ath/ath10k/wmi.o: warning: objtool: ath10k_wmi_event_mgmt_tx_bundle_compl+0x138: stack state mismatch: reg1[26]=-1+0 reg2[26]=-2-40
>> drivers/net/wireless/ath/ath10k/wmi.o: warning: objtool: ath10k_wmi_event_pdev_tpc_config+0x338: stack state mismatch: reg1[24]=-1+0 reg2[24]=-2-24
>> drivers/net/wireless/ath/ath10k/wmi.o: warning: objtool: ath10k_wmi_event_tpc_final_table+0x32c: stack state mismatch: reg1[24]=-1+0 reg2[24]=-2-24
--
>> drivers/net/wireless/ath/ath10k/wmi-tlv.o: warning: objtool: ath10k_wmi_tlv_op_rx+0xe98: stack state mismatch: reg1[26]=-1+0 reg2[26]=-2-40
--
>> drivers/net/wireless/ath/ath10k/ahb.o: warning: objtool: ath10k_ahb_halt_chip+0x43c: stack state mismatch: reg1[25]=-1+0 reg2[25]=-2-32

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

