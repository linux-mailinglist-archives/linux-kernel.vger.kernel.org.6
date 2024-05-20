Return-Path: <linux-kernel+bounces-183415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 624208C98B9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CFA1F21663
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 05:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BF914012;
	Mon, 20 May 2024 05:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCtjlpBy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6612B93
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 05:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716181656; cv=none; b=PMeHE8GzozyPgHEbElW3Iexz/D2zfgTzEqwiq8IJnyEK2x81OdqMk8U/s3dRCY65pEagN3wMRN2OFYVVYAJYZ23wzFV1skZt7OUjo8sHOdO7+Msdw6HJ6fhjP1G5HFg5dCkzZ0AIfyvOGm0pHSNbktz909V6gTSaHqHjdrUHZ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716181656; c=relaxed/simple;
	bh=OSXJP7P5T18fydifD7V8S2biQ1kv96ZBJbbC7QlAW2w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RVlCjrTKARgDrZODnJVFx8t+XaPd1IHZxG2BQ+SeSsIr22ZB7diLEg2eM8vFERFErTbnS07PvRWZBijO4J7TBp2nnkjWGpp/pX3GQMqOSPjDANYQznTpDHhwKB5KSqBKuELxE9/je8aMBMgTL17Z//X2G2Qo5gs5yBFjg+lRyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCtjlpBy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716181655; x=1747717655;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OSXJP7P5T18fydifD7V8S2biQ1kv96ZBJbbC7QlAW2w=;
  b=nCtjlpByckV34a41lxgoIIqPMOvZ92wtHAw0L/YkJBD2f+eURysPmwPp
   hl5bZ9j4A3prqwHBMOT2JcfYc2UecuSPEYrgtT6NCAiuqGBtinHVBvgqR
   +JiIlUuDlqpDCPow3i3WtHnfEAde7A6d+eBfrYeDw9GcoS7p4ZjDxrIZY
   RwHW7tSk9Yit8iw6d7+TI0hJrm+E/wGfdq6MbaA/4vwDL6Gd4UCrWEGTt
   ftmH9yx4J6t+dFFShmMYiZyiIr87PyD4FY8J9lMSAf6YDhflnicQYGPkI
   CDoq2nWChHY+rmZBhgmXaxtKz0WXCvQBFS2hfnKtu3mWyY7r+h3+5A2oM
   g==;
X-CSE-ConnectionGUID: 2zMsthrdRfaRnDMoZqUuHw==
X-CSE-MsgGUID: wUgY+ZCHSA69V6Jo3rYMKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12161185"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12161185"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 22:07:35 -0700
X-CSE-ConnectionGUID: skTDJ7pFTe+2ftUlJMG2+w==
X-CSE-MsgGUID: nRhzPG88TUi/V4tO2Nu0nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32566138"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 19 May 2024 22:07:33 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8vFA-0004eF-1z;
	Mon, 20 May 2024 05:07:29 +0000
Date: Mon, 20 May 2024 13:07:18 +0800
From: kernel test robot <lkp@intel.com>
To: Zhang Lixu <lixu.zhang@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Subject: drivers/hid/intel-ish-hid/ishtp/loader.c:172:8: error: incompatible
 pointer types passing '__le64 *' (aka 'unsigned long long *') to parameter
 of type 'dma_addr_t *' (aka 'unsigned int *')
Message-ID: <202405201313.SAStVPrT-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eb6a9339efeb6f3d2b5c86fdf2382cdc293eca2c
commit: 579a267e4617d705f6c795e5e755b01f1f87eff3 HID: intel-ish-hid: Implement loading firmware from host feature
date:   13 days ago
config: i386-buildonly-randconfig-005-20240520 (https://download.01.org/0day-ci/archive/20240520/202405201313.SAStVPrT-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240520/202405201313.SAStVPrT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405201313.SAStVPrT-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hid/intel-ish-hid/ishtp/loader.c:172:8: error: incompatible pointer types passing '__le64 *' (aka 'unsigned long long *') to parameter of type 'dma_addr_t *' (aka 'unsigned int *') [-Werror,-Wincompatible-pointer-types]
     172 |                                                  &fragment->fragment_tbl[i].ddr_adrs, GFP_KERNEL);
         |                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:429:15: note: passing argument to parameter 'dma_handle' here
     429 |                 dma_addr_t *dma_handle, gfp_t gfp)
         |                             ^
   drivers/hid/intel-ish-hid/ishtp/loader.c:207:2: error: call to undeclared function 'DEFINE_RAW_FLEX'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     207 |         DEFINE_RAW_FLEX(struct loader_xfer_dma_fragment, fragment, fragment_tbl, FRAGMENT_MAX_NUM);
         |         ^
   drivers/hid/intel-ish-hid/ishtp/loader.c:207:18: error: expected expression
     207 |         DEFINE_RAW_FLEX(struct loader_xfer_dma_fragment, fragment, fragment_tbl, FRAGMENT_MAX_NUM);
         |                         ^
   drivers/hid/intel-ish-hid/ishtp/loader.c:207:51: error: use of undeclared identifier 'fragment'
     207 |         DEFINE_RAW_FLEX(struct loader_xfer_dma_fragment, fragment, fragment_tbl, FRAGMENT_MAX_NUM);
         |                                                          ^
   drivers/hid/intel-ish-hid/ishtp/loader.c:207:61: error: use of undeclared identifier 'fragment_tbl'
     207 |         DEFINE_RAW_FLEX(struct loader_xfer_dma_fragment, fragment, fragment_tbl, FRAGMENT_MAX_NUM);
         |                                                                    ^
   drivers/hid/intel-ish-hid/ishtp/loader.c:229:2: error: use of undeclared identifier 'fragment'
     229 |         fragment->fragment.header.command = LOADER_CMD_XFER_FRAGMENT;
         |         ^
   drivers/hid/intel-ish-hid/ishtp/loader.c:230:2: error: use of undeclared identifier 'fragment'
     230 |         fragment->fragment.xfer_mode = LOADER_XFER_MODE_DMA;
         |         ^
   drivers/hid/intel-ish-hid/ishtp/loader.c:231:2: error: use of undeclared identifier 'fragment'
     231 |         fragment->fragment.is_last = 1;
         |         ^
   drivers/hid/intel-ish-hid/ishtp/loader.c:232:2: error: use of undeclared identifier 'fragment'
     232 |         fragment->fragment.size = ish_fw->size;
         |         ^
   drivers/hid/intel-ish-hid/ishtp/loader.c:236:2: error: use of undeclared identifier 'fragment'
     236 |         fragment->fragment_cnt = DIV_ROUND_UP(ish_fw->size, fragment_size);
         |         ^
   drivers/hid/intel-ish-hid/ishtp/loader.c:238:37: error: use of undeclared identifier 'fragment'
     238 |         rv = prepare_dma_bufs(dev, ish_fw, fragment, dma_bufs, fragment_size);
         |                                            ^
   drivers/hid/intel-ish-hid/ishtp/loader.c:258:46: error: use of undeclared identifier 'fragment'
     258 |                                      struct_size(fragment, fragment_tbl, fragment->fragment_cnt),
         |                                                                          ^
   drivers/hid/intel-ish-hid/ishtp/loader.c:257:29: error: use of undeclared identifier 'fragment'
     257 |                 rv = loader_xfer_cmd(dev, fragment,
         |                                           ^
   drivers/hid/intel-ish-hid/ishtp/loader.c:273:24: error: use of undeclared identifier 'fragment'
     273 |         release_dma_bufs(dev, fragment, dma_bufs, fragment_size);
         |                               ^
   14 errors generated.


vim +172 drivers/hid/intel-ish-hid/ishtp/loader.c

   151	
   152	/**
   153	 * prepare_dma_bufs() - Prepare the DMA buffer for transferring firmware fragments
   154	 * @dev: The ISHTP device
   155	 * @ish_fw: The ISH firmware
   156	 * @fragment: The ISHTP firmware fragment descriptor
   157	 * @dma_bufs: The array of DMA fragment buffers
   158	 * @fragment_size: The size of a single DMA fragment
   159	 *
   160	 * Return: 0 on success, negative error code on failure
   161	 */
   162	static int prepare_dma_bufs(struct ishtp_device *dev,
   163				    const struct firmware *ish_fw,
   164				    struct loader_xfer_dma_fragment *fragment,
   165				    void **dma_bufs, u32 fragment_size)
   166	{
   167		u32 offset = 0;
   168		int i;
   169	
   170		for (i = 0; i < fragment->fragment_cnt && offset < ish_fw->size; i++) {
   171			dma_bufs[i] = dma_alloc_coherent(dev->devc, fragment_size,
 > 172							 &fragment->fragment_tbl[i].ddr_adrs, GFP_KERNEL);
   173			if (!dma_bufs[i])
   174				return -ENOMEM;
   175	
   176			fragment->fragment_tbl[i].length = clamp(ish_fw->size - offset, 0, fragment_size);
   177			fragment->fragment_tbl[i].fw_off = offset;
   178			memcpy(dma_bufs[i], ish_fw->data + offset, fragment->fragment_tbl[i].length);
   179			clflush_cache_range(dma_bufs[i], fragment_size);
   180	
   181			offset += fragment->fragment_tbl[i].length;
   182		}
   183	
   184		return 0;
   185	}
   186	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

