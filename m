Return-Path: <linux-kernel+bounces-426533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AD09DF483
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 04:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7BCCB2101F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 03:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A487841C7F;
	Sun,  1 Dec 2024 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNoiJ4YW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A0C147
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 03:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733023059; cv=none; b=S1UvjNXPALY9RUoO0xqA5ahSTsmGI0p4v9gLja2TwHyWI2U/KL361CUFr9CnGrFyLo4QOFCCih+CSvAt3Ts1A15EikT2qSMVnlJtiMZf8NQXcFCsEPuiZbC8vxex6TWZRqSgkMNU5hHrk9+HcliBav+TRxOkN5szNwDg5NIO3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733023059; c=relaxed/simple;
	bh=vRdrevVUDuRTedj/A/P830QBheUGHFMypWkiNJwCfP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YDuT3dY9XQvHE0CBLwgazpKWGdhg33CSWVjzqtgjqseS0RfkC6h2G8ums6R0MyrEChWryu2mtN2O2+x9p/cPilb+k6/EUrfSpSAu7MrlBRxbFdUKGyKZqMN4znpIfWP9qnrF81IkSwM2OhWibsJiGNBvZd7kMIW4tP+5+W9H9ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNoiJ4YW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733023056; x=1764559056;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vRdrevVUDuRTedj/A/P830QBheUGHFMypWkiNJwCfP4=;
  b=PNoiJ4YWmswJZXh1HpFlBZlJ7ofTMpOPhSnsW10vB9x5GGUE82WQObak
   nFZlTFAz9g8dRrau6RWgaylcbHdSm478EtvRgvbfgaSh8XzooaTA5aWYB
   3d4Vi6AHbb2luWePBepYWTxZnaZtk7bIDKL/Xtzp3bc6IBGO5vSz3W2sz
   PKHEvgHhHJ9ZgAviNue1uikpooHKVI5s/cAIw9tSVps5HizLsYF4hUPAp
   NYShVDyj6LS05UEEA8j6gPBC0ekGRKqCI55uduUDpprheCdD7knj3zpAG
   eoq/LzF31703fbn9SYnwJeOFz4FPBHDSHmK6+HXNRaF3Fy0pFceIzkVCz
   Q==;
X-CSE-ConnectionGUID: 5yPOVgpST62i32UHXKM3rQ==
X-CSE-MsgGUID: sDCCBYylTKS28xz0G3amqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11272"; a="33351340"
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="33351340"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 19:17:35 -0800
X-CSE-ConnectionGUID: L9fC7z+NRF+IlNNMpe+Ckg==
X-CSE-MsgGUID: 6yFxPySvTwSjXkG0rBRKWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,199,1728975600"; 
   d="scan'208";a="97550062"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 30 Nov 2024 19:17:33 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHaSh-0001Bd-2A;
	Sun, 01 Dec 2024 03:17:31 +0000
Date: Sun, 1 Dec 2024 11:15:54 +0800
From: kernel test robot <lkp@intel.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: sound/soc/intel/skylake/skl-topology.c:2070:50: sparse: sparse:
 restricted __le32 degrades to integer
Message-ID: <202412011151.JQ78nur8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ba9f676d0a2e408aef14d679984c26373bf37b7
commit: c0891ac15f0428ffa81b2e818d416bdf3cb74ab6 isystem: ship and use stdarg.h
date:   3 years, 3 months ago
config: x86_64-randconfig-121-20241121 (https://download.01.org/0day-ci/archive/20241201/202412011151.JQ78nur8-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241201/202412011151.JQ78nur8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412011151.JQ78nur8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> sound/soc/intel/skylake/skl-topology.c:2070:50: sparse: sparse: restricted __le32 degrades to integer
>> sound/soc/intel/skylake/skl-topology.c:2089:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] ppl_id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2089:22: sparse:     expected unsigned char [usertype] ppl_id
   sound/soc/intel/skylake/skl-topology.c:2089:22: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2104:21: sparse: sparse: restricted __le32 degrades to integer
>> sound/soc/intel/skylake/skl-topology.c:2123:47: sparse: sparse: incorrect type in assignment (different base types) @@     expected int module_id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2123:47: sparse:     expected int module_id
   sound/soc/intel/skylake/skl-topology.c:2123:47: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2127:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] instance_id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2127:49: sparse:     expected unsigned int [usertype] instance_id
   sound/soc/intel/skylake/skl-topology.c:2127:49: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2121:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2121:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2121:25: sparse: sparse: restricted __le32 degrades to integer
>> sound/soc/intel/skylake/skl-topology.c:2292:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] pin_index @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2292:34: sparse:     expected unsigned char [usertype] pin_index
   sound/soc/intel/skylake/skl-topology.c:2292:34: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2296:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buf_size @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2296:33: sparse:     expected unsigned int [usertype] buf_size
   sound/soc/intel/skylake/skl-topology.c:2296:33: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2290:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2290:25: sparse: sparse: restricted __le32 degrades to integer
>> sound/soc/intel/skylake/skl-topology.c:2323:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dma_buffer_size @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2323:38: sparse:     expected unsigned int [usertype] dma_buffer_size
   sound/soc/intel/skylake/skl-topology.c:2323:38: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2327:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cpc @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2327:26: sparse:     expected unsigned int [usertype] cpc
   sound/soc/intel/skylake/skl-topology.c:2327:26: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2331:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] is_pages @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2331:31: sparse:     expected unsigned int [usertype] is_pages
   sound/soc/intel/skylake/skl-topology.c:2331:31: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2335:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] obs @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2335:26: sparse:     expected unsigned int [usertype] obs
   sound/soc/intel/skylake/skl-topology.c:2335:26: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2339:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] ibs @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2339:26: sparse:     expected unsigned int [usertype] ibs
   sound/soc/intel/skylake/skl-topology.c:2339:26: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2321:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2321:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2321:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2321:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2321:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2321:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2321:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2321:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2321:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2391:21: sparse: sparse: restricted __le32 degrades to integer
>> sound/soc/intel/skylake/skl-topology.c:2396:49: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] max_input_pins @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2396:49: sparse:     expected unsigned char [usertype] max_input_pins
   sound/soc/intel/skylake/skl-topology.c:2396:49: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2400:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] max_output_pins @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2400:50: sparse:     expected unsigned char [usertype] max_output_pins
   sound/soc/intel/skylake/skl-topology.c:2400:50: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2413:55: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2413:55: sparse:     expected unsigned int [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2413:55: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2426:55: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2426:55: sparse:     expected unsigned int [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2426:55: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2430:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] time_slot @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2430:36: sparse:     expected unsigned char [usertype] time_slot
   sound/soc/intel/skylake/skl-topology.c:2430:36: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2434:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] core_id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2434:34: sparse:     expected unsigned char [usertype] core_id
   sound/soc/intel/skylake/skl-topology.c:2434:34: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2438:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int enum skl_module_type m_type @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2438:33: sparse:     expected unsigned int enum skl_module_type m_type
   sound/soc/intel/skylake/skl-topology.c:2438:33: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2442:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] dev_type @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2442:35: sparse:     expected unsigned char [usertype] dev_type
   sound/soc/intel/skylake/skl-topology.c:2442:35: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2446:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int enum skl_hw_conn_type hw_conn_type @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2446:39: sparse:     expected unsigned int enum skl_hw_conn_type hw_conn_type
   sound/soc/intel/skylake/skl-topology.c:2446:39: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2450:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] instance_id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2450:41: sparse:     expected unsigned int [usertype] instance_id
   sound/soc/intel/skylake/skl-topology.c:2450:41: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2465:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] vbus_id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2465:34: sparse:     expected unsigned int [usertype] vbus_id
   sound/soc/intel/skylake/skl-topology.c:2465:34: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2469:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] params_fixup @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2469:39: sparse:     expected unsigned int [usertype] params_fixup
   sound/soc/intel/skylake/skl-topology.c:2469:39: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2473:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] converter @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2473:36: sparse:     expected unsigned int [usertype] converter
   sound/soc/intel/skylake/skl-topology.c:2473:36: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2477:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int enum d0i3_capability d0i3_caps @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2477:36: sparse:     expected unsigned int enum d0i3_capability d0i3_caps
   sound/soc/intel/skylake/skl-topology.c:2477:36: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2495:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected int static conf_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2495:26: sparse:     expected int static conf_idx
   sound/soc/intel/skylake/skl-topology.c:2495:26: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2506:49: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] tkn @@     got restricted __le32 [usertype] token @@
   sound/soc/intel/skylake/skl-topology.c:2506:49: sparse:     expected unsigned int [usertype] tkn
   sound/soc/intel/skylake/skl-topology.c:2506:49: sparse:     got restricted __le32 [usertype] token
>> sound/soc/intel/skylake/skl-topology.c:2506:66: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] tkn_val @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2506:66: sparse:     expected unsigned int [usertype] tkn_val
   sound/soc/intel/skylake/skl-topology.c:2506:66: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2519:49: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] tkn @@     got restricted __le32 [usertype] token @@
   sound/soc/intel/skylake/skl-topology.c:2519:49: sparse:     expected unsigned int [usertype] tkn
   sound/soc/intel/skylake/skl-topology.c:2519:49: sparse:     got restricted __le32 [usertype] token
   sound/soc/intel/skylake/skl-topology.c:2519:66: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] tkn_val @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2519:66: sparse:     expected unsigned int [usertype] tkn_val
   sound/soc/intel/skylake/skl-topology.c:2519:66: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2527:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] res_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2527:52: sparse:     expected unsigned char [usertype] res_idx
   sound/soc/intel/skylake/skl-topology.c:2527:52: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2531:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] fmt_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2531:52: sparse:     expected unsigned char [usertype] fmt_idx
   sound/soc/intel/skylake/skl-topology.c:2531:52: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2540:31: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2541:38: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2554:68: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] tkn @@     got restricted __le32 [usertype] token @@
   sound/soc/intel/skylake/skl-topology.c:2554:68: sparse:     expected unsigned int [usertype] tkn
   sound/soc/intel/skylake/skl-topology.c:2554:68: sparse:     got restricted __le32 [usertype] token
>> sound/soc/intel/skylake/skl-topology.c:2555:41: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2555:41: sparse:     expected unsigned int [usertype] val
   sound/soc/intel/skylake/skl-topology.c:2555:41: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2574:51: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] caps_size @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2574:51: sparse:     expected unsigned int [usertype] caps_size
   sound/soc/intel/skylake/skl-topology.c:2574:51: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2580:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] set_params @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2580:52: sparse:     expected unsigned int [usertype] set_params
   sound/soc/intel/skylake/skl-topology.c:2580:52: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2585:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] param_id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2585:50: sparse:     expected unsigned int [usertype] param_id
   sound/soc/intel/skylake/skl-topology.c:2585:50: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:2590:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] domain @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2590:33: sparse:     expected unsigned char [usertype] domain
   sound/soc/intel/skylake/skl-topology.c:2590:33: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2596:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dma_buffer_size @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2596:42: sparse:     expected unsigned int [usertype] dma_buffer_size
   sound/soc/intel/skylake/skl-topology.c:2596:42: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2394:25: sparse: sparse: restricted __le32 degrades to integer
>> sound/soc/intel/skylake/skl-topology.c:2635:21: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:2635:21: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:2635:21: sparse:    right side has type restricted __le32
   sound/soc/intel/skylake/skl-topology.c:2637:30: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2665:43: sparse: sparse: restricted __le32 degrades to integer
>> sound/soc/intel/skylake/skl-topology.c:2697:32: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2697:32: sparse:     expected int
   sound/soc/intel/skylake/skl-topology.c:2697:32: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2693:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2693:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2693:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2897:13: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:2897:13: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:2897:13: sparse:    right side has type restricted __le32
   sound/soc/intel/skylake/skl-topology.c:2908:21: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:2908:21: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:2908:21: sparse:    right side has type restricted __le32
   sound/soc/intel/skylake/skl-topology.c:2918:21: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:2918:21: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:2918:21: sparse:    right side has type restricted __le32
>> sound/soc/intel/skylake/skl-topology.c:3045:47: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned short [usertype] event_type @@     got restricted __le16 [usertype] event_type @@
   sound/soc/intel/skylake/skl-topology.c:3045:47: sparse:     expected unsigned short [usertype] event_type
   sound/soc/intel/skylake/skl-topology.c:3045:47: sparse:     got restricted __le16 [usertype] event_type
   sound/soc/intel/skylake/skl-topology.c:3095:17: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] len @@     got restricted __le32 [usertype] size @@
   sound/soc/intel/skylake/skl-topology.c:3095:17: sparse:     expected unsigned long [usertype] len
   sound/soc/intel/skylake/skl-topology.c:3095:17: sparse:     got restricted __le32 [usertype] size
   sound/soc/intel/skylake/skl-topology.c:3141:29: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3114:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3114:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3162:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3192:33: sparse: sparse: restricted __le32 degrades to integer
>> sound/soc/intel/skylake/skl-topology.c:3235:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3235:29: sparse:     expected unsigned char [usertype] id
   sound/soc/intel/skylake/skl-topology.c:3235:29: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3239:63: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] tkn @@     got restricted __le32 [usertype] token @@
   sound/soc/intel/skylake/skl-topology.c:3239:63: sparse:     expected unsigned int [usertype] tkn
   sound/soc/intel/skylake/skl-topology.c:3239:63: sparse:     got restricted __le32 [usertype] token
   sound/soc/intel/skylake/skl-topology.c:3240:49: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3240:49: sparse:     expected unsigned int [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3240:49: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3233:25: sparse: sparse: restricted __le32 degrades to integer
>> sound/soc/intel/skylake/skl-topology.c:3259:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] input_pin_type @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3259:37: sparse:     expected unsigned char [usertype] input_pin_type
   sound/soc/intel/skylake/skl-topology.c:3259:37: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:3263:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] output_pin_type @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3263:38: sparse:     expected unsigned char [usertype] output_pin_type
   sound/soc/intel/skylake/skl-topology.c:3263:38: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3267:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] max_input_pins @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3267:37: sparse:     expected unsigned char [usertype] max_input_pins
   sound/soc/intel/skylake/skl-topology.c:3267:37: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3271:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] max_output_pins @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3271:38: sparse:     expected unsigned char [usertype] max_output_pins
   sound/soc/intel/skylake/skl-topology.c:3271:38: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:3275:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_resources @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3275:35: sparse:     expected unsigned char [usertype] nr_resources
   sound/soc/intel/skylake/skl-topology.c:3275:35: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:3279:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_interfaces @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3279:36: sparse:     expected unsigned char [usertype] nr_interfaces
   sound/soc/intel/skylake/skl-topology.c:3279:36: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3257:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3257:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3257:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3257:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3257:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3257:25: sparse: sparse: restricted __le32 degrades to integer
>> sound/soc/intel/skylake/skl-topology.c:3313:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected int lib_count @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3313:32: sparse:     expected int lib_count
   sound/soc/intel/skylake/skl-topology.c:3313:32: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:3317:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_modules @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3317:33: sparse:     expected unsigned char [usertype] nr_modules
   sound/soc/intel/skylake/skl-topology.c:3317:33: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:3332:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected int static mod_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3332:25: sparse:     expected int static mod_idx
   sound/soc/intel/skylake/skl-topology.c:3332:25: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3341:29: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3347:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long [usertype] a @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3347:24: sparse:     expected unsigned long [usertype] a
   sound/soc/intel/skylake/skl-topology.c:3347:24: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:3354:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] count @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3354:52: sparse:     expected unsigned int [usertype] count
   sound/soc/intel/skylake/skl-topology.c:3354:52: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3358:29: sparse: sparse: restricted __le32 degrades to integer
>> sound/soc/intel/skylake/skl-topology.c:3364:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected int static astate_cfg_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3364:32: sparse:     expected int static astate_cfg_idx
   sound/soc/intel/skylake/skl-topology.c:3364:32: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:3368:51: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] kcps @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3368:51: sparse:     expected unsigned int [usertype] kcps
   sound/soc/intel/skylake/skl-topology.c:3368:51: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:3372:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] clk_src @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3372:54: sparse:     expected unsigned int [usertype] clk_src
   sound/soc/intel/skylake/skl-topology.c:3372:54: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3387:31: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3388:36: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3395:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3395:25: sparse:     expected unsigned char [usertype] id
   sound/soc/intel/skylake/skl-topology.c:3395:25: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:3396:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected int static res_val_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3396:29: sparse:     expected int static res_val_idx
   sound/soc/intel/skylake/skl-topology.c:3396:29: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3403:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] fmt_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3403:30: sparse:     expected unsigned char [usertype] fmt_idx
   sound/soc/intel/skylake/skl-topology.c:3403:30: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:3404:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected int static intf_val_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3404:30: sparse:     expected int static intf_val_idx
   sound/soc/intel/skylake/skl-topology.c:3404:30: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:3425:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_input_pins @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3425:36: sparse:     expected unsigned char [usertype] nr_input_pins
   sound/soc/intel/skylake/skl-topology.c:3425:36: sparse:     got restricted __le32 [usertype] value
>> sound/soc/intel/skylake/skl-topology.c:3432:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_output_pins @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3432:37: sparse:     expected unsigned char [usertype] nr_output_pins
   sound/soc/intel/skylake/skl-topology.c:3432:37: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3311:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3478:21: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:3478:21: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:3478:21: sparse:    right side has type restricted __le32
   sound/soc/intel/skylake/skl-topology.c:3492:40: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3479:30: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3513:42: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3548:13: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:3548:13: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:3548:13: sparse:    right side has type restricted __le32
   sound/soc/intel/skylake/skl-topology.c:3558:21: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:3558:21: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:3558:21: sparse:    right side has type restricted __le32
   sound/soc/intel/skylake/skl-topology.c:3568:21: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:3568:21: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:3568:21: sparse:    right side has type restricted __le32
--
>> drivers/edac/skx_base.c:355:46: sparse: sparse: dubious: x | !y

vim +2070 sound/soc/intel/skylake/skl-topology.c

3af36706ff6c4e Vinod Koul        2015-10-07  2056  
3af36706ff6c4e Vinod Koul        2015-10-07  2057  /*
6277e83292a2d4 Shreyas NC        2016-08-12  2058   * Add pipeline by parsing the relevant tokens
6277e83292a2d4 Shreyas NC        2016-08-12  2059   * Return an existing pipe if the pipe already exists.
3af36706ff6c4e Vinod Koul        2015-10-07  2060   */
6277e83292a2d4 Shreyas NC        2016-08-12  2061  static int skl_tplg_add_pipe(struct device *dev,
bcc2a2dc3ba8c3 Cezary Rojewski   2019-07-23  2062  		struct skl_module_cfg *mconfig, struct skl_dev *skl,
6277e83292a2d4 Shreyas NC        2016-08-12  2063  		struct snd_soc_tplg_vendor_value_elem *tkn_elem)
3af36706ff6c4e Vinod Koul        2015-10-07  2064  {
3af36706ff6c4e Vinod Koul        2015-10-07  2065  	struct skl_pipeline *ppl;
3af36706ff6c4e Vinod Koul        2015-10-07  2066  	struct skl_pipe *pipe;
3af36706ff6c4e Vinod Koul        2015-10-07  2067  	struct skl_pipe_params *params;
3af36706ff6c4e Vinod Koul        2015-10-07  2068  
3af36706ff6c4e Vinod Koul        2015-10-07  2069  	list_for_each_entry(ppl, &skl->ppl_list, node) {
6277e83292a2d4 Shreyas NC        2016-08-12 @2070  		if (ppl->pipe->ppl_id == tkn_elem->value) {
6277e83292a2d4 Shreyas NC        2016-08-12  2071  			mconfig->pipe = ppl->pipe;
081dc8ab46df85 Guneshwor Singh   2017-04-27  2072  			return -EEXIST;
6277e83292a2d4 Shreyas NC        2016-08-12  2073  		}
3af36706ff6c4e Vinod Koul        2015-10-07  2074  	}
3af36706ff6c4e Vinod Koul        2015-10-07  2075  
3af36706ff6c4e Vinod Koul        2015-10-07  2076  	ppl = devm_kzalloc(dev, sizeof(*ppl), GFP_KERNEL);
3af36706ff6c4e Vinod Koul        2015-10-07  2077  	if (!ppl)
6277e83292a2d4 Shreyas NC        2016-08-12  2078  		return -ENOMEM;
3af36706ff6c4e Vinod Koul        2015-10-07  2079  
3af36706ff6c4e Vinod Koul        2015-10-07  2080  	pipe = devm_kzalloc(dev, sizeof(*pipe), GFP_KERNEL);
3af36706ff6c4e Vinod Koul        2015-10-07  2081  	if (!pipe)
6277e83292a2d4 Shreyas NC        2016-08-12  2082  		return -ENOMEM;
3af36706ff6c4e Vinod Koul        2015-10-07  2083  
3af36706ff6c4e Vinod Koul        2015-10-07  2084  	params = devm_kzalloc(dev, sizeof(*params), GFP_KERNEL);
3af36706ff6c4e Vinod Koul        2015-10-07  2085  	if (!params)
6277e83292a2d4 Shreyas NC        2016-08-12  2086  		return -ENOMEM;
3af36706ff6c4e Vinod Koul        2015-10-07  2087  
3af36706ff6c4e Vinod Koul        2015-10-07  2088  	pipe->p_params = params;
6277e83292a2d4 Shreyas NC        2016-08-12 @2089  	pipe->ppl_id = tkn_elem->value;
3af36706ff6c4e Vinod Koul        2015-10-07  2090  	INIT_LIST_HEAD(&pipe->w_list);
3af36706ff6c4e Vinod Koul        2015-10-07  2091  
3af36706ff6c4e Vinod Koul        2015-10-07  2092  	ppl->pipe = pipe;
3af36706ff6c4e Vinod Koul        2015-10-07  2093  	list_add(&ppl->node, &skl->ppl_list);
3af36706ff6c4e Vinod Koul        2015-10-07  2094  
6277e83292a2d4 Shreyas NC        2016-08-12  2095  	mconfig->pipe = pipe;
6277e83292a2d4 Shreyas NC        2016-08-12  2096  	mconfig->pipe->state = SKL_PIPE_INVALID;
6277e83292a2d4 Shreyas NC        2016-08-12  2097  
6277e83292a2d4 Shreyas NC        2016-08-12  2098  	return 0;
6277e83292a2d4 Shreyas NC        2016-08-12  2099  }
6277e83292a2d4 Shreyas NC        2016-08-12  2100  
9e0784d00e35e0 Andy Shevchenko   2019-06-19  2101  static int skl_tplg_get_uuid(struct device *dev, guid_t *guid,
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2102  	      struct snd_soc_tplg_vendor_uuid_elem *uuid_tkn)
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2103  {
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2104  	if (uuid_tkn->token == SKL_TKN_UUID) {
cade2f59e7ae3d Andy Shevchenko   2020-04-22  2105  		import_guid(guid, uuid_tkn->uuid);
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2106  		return 0;
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2107  	}
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2108  
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2109  	dev_err(dev, "Not an UUID token %d\n", uuid_tkn->token);
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2110  
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2111  	return -EINVAL;
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2112  }
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2113  
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2114  static int skl_tplg_fill_pin(struct device *dev,
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2115  			struct snd_soc_tplg_vendor_value_elem *tkn_elem,
6277e83292a2d4 Shreyas NC        2016-08-12  2116  			struct skl_module_pin *m_pin,
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2117  			int pin_index)
6277e83292a2d4 Shreyas NC        2016-08-12  2118  {
d956147473ec18 Sriram Periyasamy 2017-11-07  2119  	int ret;
d956147473ec18 Sriram Periyasamy 2017-11-07  2120  
22ebd6666efd86 Sriram Periyasamy 2017-11-07 @2121  	switch (tkn_elem->token) {
6277e83292a2d4 Shreyas NC        2016-08-12  2122  	case SKL_TKN_U32_PIN_MOD_ID:
22ebd6666efd86 Sriram Periyasamy 2017-11-07 @2123  		m_pin[pin_index].id.module_id = tkn_elem->value;
6277e83292a2d4 Shreyas NC        2016-08-12  2124  		break;
6277e83292a2d4 Shreyas NC        2016-08-12  2125  
6277e83292a2d4 Shreyas NC        2016-08-12  2126  	case SKL_TKN_U32_PIN_INST_ID:
22ebd6666efd86 Sriram Periyasamy 2017-11-07 @2127  		m_pin[pin_index].id.instance_id = tkn_elem->value;
6277e83292a2d4 Shreyas NC        2016-08-12  2128  		break;
6277e83292a2d4 Shreyas NC        2016-08-12  2129  
d956147473ec18 Sriram Periyasamy 2017-11-07  2130  	case SKL_TKN_UUID:
9e0784d00e35e0 Andy Shevchenko   2019-06-19  2131  		ret = skl_tplg_get_uuid(dev, &m_pin[pin_index].id.mod_uuid,
d956147473ec18 Sriram Periyasamy 2017-11-07  2132  			(struct snd_soc_tplg_vendor_uuid_elem *)tkn_elem);
d956147473ec18 Sriram Periyasamy 2017-11-07  2133  		if (ret < 0)
d956147473ec18 Sriram Periyasamy 2017-11-07  2134  			return ret;
d956147473ec18 Sriram Periyasamy 2017-11-07  2135  
6277e83292a2d4 Shreyas NC        2016-08-12  2136  		break;
6277e83292a2d4 Shreyas NC        2016-08-12  2137  
6277e83292a2d4 Shreyas NC        2016-08-12  2138  	default:
22ebd6666efd86 Sriram Periyasamy 2017-11-07  2139  		dev_err(dev, "%d Not a pin token\n", tkn_elem->token);
6277e83292a2d4 Shreyas NC        2016-08-12  2140  		return -EINVAL;
6277e83292a2d4 Shreyas NC        2016-08-12  2141  	}
6277e83292a2d4 Shreyas NC        2016-08-12  2142  
6277e83292a2d4 Shreyas NC        2016-08-12  2143  	return 0;
6277e83292a2d4 Shreyas NC        2016-08-12  2144  }
6277e83292a2d4 Shreyas NC        2016-08-12  2145  

:::::: The code at line 2070 was first introduced by commit
:::::: 6277e83292a2d4d88d150c0eb3004bd714ad8728 ASoC: Intel: Skylake: Parse vendor tokens to build module data

:::::: TO: Shreyas NC <shreyas.nc@intel.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

