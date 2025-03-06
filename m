Return-Path: <linux-kernel+bounces-548081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B65A53F9B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EDE189279C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1CA8624B;
	Thu,  6 Mar 2025 01:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJri+WDQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B900487BF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 01:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741223401; cv=none; b=Yj/No46ct5D8tp9IoOmtxP5Q0g979pnYaTj3ziYYveevSMsZ5qRrxiUQUezwlBHdzAuHbkx/mQRRQpP/B1RfVc8BOlPy9qHW9ZCb9bZTLlkZ4GcdEeNBHxtc8BnljrDgJum/8t1/e2SXAl9PqVg1KT2M+Q6fKdVo9PTXxJTwDIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741223401; c=relaxed/simple;
	bh=TaEwSc5jmVb7CdItKEJ8ADFV/XzGuCfQAd25mGX16EU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eui39da+D16Q5ttSf7gMz2GZjMH08ExLoYYXpMuit2fSG+9351ZLT3gYooBh8ZMkg2Btd/2epD0vR/g2XQmUw6SlgLq+mr68RQl9GBV3UNoS9LSxNbk0z/XdKudH0kszyH/3vjy/WwcxUfX83AISFxwcMj6IQBC3sXtRBkVqM7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJri+WDQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741223399; x=1772759399;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TaEwSc5jmVb7CdItKEJ8ADFV/XzGuCfQAd25mGX16EU=;
  b=kJri+WDQQSM7Ao2iS260SLskUR9wDOaSVgzTm5WaCf4AjBDOWZ+RXXY7
   f+R5OPZC+5qLNJx97RE0ceOKd2j9Ey1WvxYAhfjbKGKVbN1lZffvZhNdz
   FUlx+zCY9eksBQG7HAfaAFzLFeKOkyETNIkyv253PfsJ5RvDoGEcFLzOm
   vFgU/NXuUc2eghfM2uk8kw44fMmPk9b6VLa5DVZMv9jEZ3V8KQxIbW8F7
   T+Yt1mNTo94l3RUPTBsuHeZCPux0SFTrPsBIZmPaWqAr7irhe6VAXAQ9S
   4Djn1No7Wc5TDDPhB2QcSHNeRfyJ6SQItwML/wq/Jup7CRv3JkfQQrteH
   g==;
X-CSE-ConnectionGUID: mxuP4gfQRAGfo7G+sy2sFw==
X-CSE-MsgGUID: cw86yfFCRUuUmqHlITap1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="64662945"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="64662945"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 17:09:59 -0800
X-CSE-ConnectionGUID: z98SHcREQWSLD+xxzTEgHA==
X-CSE-MsgGUID: +s6P5KKUSNuFiktc/kxbTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="123957648"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 05 Mar 2025 17:09:57 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpzkA-000MNU-30;
	Thu, 06 Mar 2025 01:09:48 +0000
Date: Thu, 6 Mar 2025 09:09:08 +0800
From: kernel test robot <lkp@intel.com>
To: George Lander <lander@jagmn.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Marcus Cooper <codekipper@gmail.com>
Subject: sound/soc/sunxi/sun4i-spdif.c:180: warning: Function parameter or
 struct member 'mclk_multiplier' not described in 'sun4i_spdif_quirks'
Message-ID: <202503060947.QKUUR62l-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi George,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   848e076317446f9c663771ddec142d7c2eb4cb43
commit: 0a2319308de88b9e819c0b43d0fccd857123eb31 ASoC: sun4i-spdif: Add clock multiplier settings
date:   3 months ago
config: mips-randconfig-r024-20220830 (https://download.01.org/0day-ci/archive/20250306/202503060947.QKUUR62l-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250306/202503060947.QKUUR62l-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503060947.QKUUR62l-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/sunxi/sun4i-spdif.c:180: warning: Function parameter or struct member 'mclk_multiplier' not described in 'sun4i_spdif_quirks'


vim +180 sound/soc/sunxi/sun4i-spdif.c

f8260afa444b67 Marcus Cooper 2016-02-08  167  
ae9cccc30f6c08 Clément Péron 2019-05-27  168  /**
ae9cccc30f6c08 Clément Péron 2019-05-27  169   * struct sun4i_spdif_quirks - Differences between SoC variants.
ae9cccc30f6c08 Clément Péron 2019-05-27  170   *
c7202a19cf838d Lee Jones     2020-07-09  171   * @reg_dac_txdata: TX FIFO offset for DMA config.
ae9cccc30f6c08 Clément Péron 2019-05-27  172   * @has_reset: SoC needs reset deasserted.
f6a86b436b2658 Clément Péron 2019-05-27  173   * @val_fctl_ftx: TX FIFO flush bitmask.
ae9cccc30f6c08 Clément Péron 2019-05-27  174   */
ae9cccc30f6c08 Clément Péron 2019-05-27  175  struct sun4i_spdif_quirks {
ae9cccc30f6c08 Clément Péron 2019-05-27  176  	unsigned int reg_dac_txdata;
ae9cccc30f6c08 Clément Péron 2019-05-27  177  	bool has_reset;
f6a86b436b2658 Clément Péron 2019-05-27  178  	unsigned int val_fctl_ftx;
0a2319308de88b George Lander 2024-11-11  179  	unsigned int mclk_multiplier;
ae9cccc30f6c08 Clément Péron 2019-05-27 @180  };
ae9cccc30f6c08 Clément Péron 2019-05-27  181  

:::::: The code at line 180 was first introduced by commit
:::::: ae9cccc30f6c088dd6ead63e990407e37cd9437b ASoC: sun4i-spdif: Move quirks to the top

:::::: TO: Clément Péron <peron.clem@gmail.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

