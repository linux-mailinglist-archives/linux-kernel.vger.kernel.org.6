Return-Path: <linux-kernel+bounces-428485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F29E0F22
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B20161F15
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924831DF981;
	Mon,  2 Dec 2024 23:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2TF0TTr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE141DEFC2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733180420; cv=none; b=npIQGIECtWk/jyKT8uSyONsmWazh+ZMCh2CgzyWnmQ8z/Q1q57o4N6iOeRjnb+oQr3Pc91ezYwbenwoFlfHxy9WI0+37lbFOhuMc6ZFk6euL3krPUe/Duz5rLCmcJtLHbOwlmjI0LgNoz9SbDW7amjdVEX+yCReiLpc8EkKu+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733180420; c=relaxed/simple;
	bh=V0OLopPUIS8SqaOKQ5ZHjdlyEpM7CyoOtPVDyfQbrd4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k8jagqwsSPC8JtZpO2gm1IL70qmyF88uXsB7647XpibbOHs9V/3980ANLjntfMF8LSLzLVkgpepRzChIUPFW5IzXjL4faTW6nlSUH92uAOxHuBzsaolKI2bmGUbFywb9YDtTrWPt9thNCC8UB82A6pCIKwAF3KmLsz08RrXQKfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2TF0TTr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733180417; x=1764716417;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=V0OLopPUIS8SqaOKQ5ZHjdlyEpM7CyoOtPVDyfQbrd4=;
  b=T2TF0TTrn06amE8kCKZ0mgtfkviY+MT9rQPSIKgp1Dk5ooP3FfAGpUln
   3IvhhZhaj6tbtBAH35ZUXSAiZ+vnBiZn+YI636TUdtyJVkp14lacTa0wT
   OC5xaB9czZS7DpZ1cTbopJWGf/L+whIQzM6hJEgjdmVwIG2Hcq6dn7DQH
   rndiAkGtJe0MGxz7P4BVufNU97KZzBBEGyztPg1HllViBYNMQdOXr36QX
   JqvmMZlIRURBzFQD7MoOEL8xGZUNNqOn9ATR6aPZxnoytBVJu3cO52+ff
   aHa1wCZDtG8lkuitxoHP05H4IM6HTBAjmFEDwJBLWJrycFrx7iTp15uCk
   A==;
X-CSE-ConnectionGUID: NR34r16vSdin66AsTvr74A==
X-CSE-MsgGUID: FjusWWGMTzOAnlyaR0l9wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="32728251"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="32728251"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 15:00:16 -0800
X-CSE-ConnectionGUID: xSC/4VlOTdesveOEtGDGDQ==
X-CSE-MsgGUID: Pp/BhOjzSOWUHS00/cN0Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93133843"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Dec 2024 15:00:14 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIFOm-0002zz-11;
	Mon, 02 Dec 2024 23:00:12 +0000
Date: Tue, 3 Dec 2024 06:59:31 +0800
From: kernel test robot <lkp@intel.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: drivers/mtd/nand/raw/omap2.c:260: warning: Function parameter or
 member 'chip' not described in 'omap_nand_data_in_pref'
Message-ID: <202412030631.BhmsnlFP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Roger,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
commit: 854fd9209b20837ab48c2e6714e5e44dd8ea33a2 memory: omap-gpmc: Allow building as a module
date:   2 years, 7 months ago
config: x86_64-buildonly-randconfig-002-20240107 (https://download.01.org/0day-ci/archive/20241203/202412030631.BhmsnlFP-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030631.BhmsnlFP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030631.BhmsnlFP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/raw/omap2.c:260: warning: Function parameter or member 'chip' not described in 'omap_nand_data_in_pref'
>> drivers/mtd/nand/raw/omap2.c:260: warning: Function parameter or member 'buf' not described in 'omap_nand_data_in_pref'
>> drivers/mtd/nand/raw/omap2.c:260: warning: Function parameter or member 'len' not described in 'omap_nand_data_in_pref'
>> drivers/mtd/nand/raw/omap2.c:260: warning: Function parameter or member 'force_8bit' not described in 'omap_nand_data_in_pref'
>> drivers/mtd/nand/raw/omap2.c:304: warning: Function parameter or member 'chip' not described in 'omap_nand_data_out_pref'
>> drivers/mtd/nand/raw/omap2.c:304: warning: Function parameter or member 'buf' not described in 'omap_nand_data_out_pref'
>> drivers/mtd/nand/raw/omap2.c:304: warning: Function parameter or member 'len' not described in 'omap_nand_data_out_pref'
>> drivers/mtd/nand/raw/omap2.c:304: warning: Function parameter or member 'force_8bit' not described in 'omap_nand_data_out_pref'
>> drivers/mtd/nand/raw/omap2.c:446: warning: Function parameter or member 'chip' not described in 'omap_nand_data_in_dma_pref'
>> drivers/mtd/nand/raw/omap2.c:446: warning: Function parameter or member 'buf' not described in 'omap_nand_data_in_dma_pref'
>> drivers/mtd/nand/raw/omap2.c:446: warning: Function parameter or member 'len' not described in 'omap_nand_data_in_dma_pref'
>> drivers/mtd/nand/raw/omap2.c:446: warning: Function parameter or member 'force_8bit' not described in 'omap_nand_data_in_dma_pref'
>> drivers/mtd/nand/raw/omap2.c:467: warning: Function parameter or member 'chip' not described in 'omap_nand_data_out_dma_pref'
>> drivers/mtd/nand/raw/omap2.c:467: warning: Function parameter or member 'buf' not described in 'omap_nand_data_out_dma_pref'
>> drivers/mtd/nand/raw/omap2.c:467: warning: Function parameter or member 'len' not described in 'omap_nand_data_out_dma_pref'
>> drivers/mtd/nand/raw/omap2.c:467: warning: Function parameter or member 'force_8bit' not described in 'omap_nand_data_out_dma_pref'


vim +260 drivers/mtd/nand/raw/omap2.c

65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  254  
67ce04bf2746f8 drivers/mtd/nand/omap2.c     Vimal Singh          2009-05-12  255  /**
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  256   * omap_nand_data_in_pref - NAND data in using prefetch engine
67ce04bf2746f8 drivers/mtd/nand/omap2.c     Vimal Singh          2009-05-12  257   */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  258  static void omap_nand_data_in_pref(struct nand_chip *chip, void *buf,
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  259  				   unsigned int len, bool force_8bit)
67ce04bf2746f8 drivers/mtd/nand/omap2.c     Vimal Singh          2009-05-12 @260  {
0f808c1602bc75 drivers/mtd/nand/raw/omap2.c Boris Brezillon      2018-09-06  261  	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
2c01946c6b9eba drivers/mtd/nand/omap2.c     Sukumar Ghorai       2010-07-09  262  	uint32_t r_count = 0;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  263  	int ret = 0;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  264  	u32 *p = (u32 *)buf;
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  265  	unsigned int pref_len;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  266  
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  267  	if (force_8bit) {
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  268  		omap_nand_data_in(chip, buf, len, force_8bit);
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  269  		return;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  270  	}
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  271  
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  272  	/* read 32-bit words using prefetch and remaining bytes normally */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  273  
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  274  	/* configure and start prefetch transfer */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  275  	pref_len = len - (len & 3);
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  276  	ret = omap_prefetch_enable(info->gpmc_cs,
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  277  			PREFETCH_FIFOTHRESHOLD_MAX, 0x0, pref_len, 0x0, info);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  278  	if (ret) {
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  279  		/* prefetch engine is busy, use CPU copy method */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  280  		omap_nand_data_in(chip, buf, len, false);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  281  	} else {
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  282  		do {
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  283  			r_count = readl(info->reg.gpmc_prefetch_status);
47f88af4ed80ac drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-09-29  284  			r_count = PREFETCH_STATUS_FIFO_CNT(r_count);
2c01946c6b9eba drivers/mtd/nand/omap2.c     Sukumar Ghorai       2010-07-09  285  			r_count = r_count >> 2;
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  286  			ioread32_rep(info->fifo, p, r_count);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  287  			p += r_count;
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  288  			pref_len -= r_count << 2;
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  289  		} while (pref_len);
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  290  		/* disable and stop the Prefetch engine */
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  291  		omap_prefetch_reset(info->gpmc_cs, info);
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  292  		/* fetch any remaining bytes */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  293  		if (len & 3)
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  294  			omap_nand_data_in(chip, p, len & 3, false);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  295  	}
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  296  }
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  297  
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  298  /**
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  299   * omap_nand_data_out_pref - NAND data out using Write Posting engine
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  300   */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  301  static void omap_nand_data_out_pref(struct nand_chip *chip,
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  302  				    const void *buf, unsigned int len,
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  303  				    bool force_8bit)
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13 @304  {
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  305  	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  306  	uint32_t w_count = 0;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  307  	int i = 0, ret = 0;
c5d8c0cae4af7d drivers/mtd/nand/omap2.c     Kishore Kadiyala     2011-05-11  308  	u16 *p = (u16 *)buf;
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  309  	unsigned long tim, limit;
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  310  	u32 val;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  311  
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  312  	if (force_8bit) {
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  313  		omap_nand_data_out(chip, buf, len, force_8bit);
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  314  		return;
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  315  	}
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  316  
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  317  	/* take care of subpage writes */
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  318  	if (len % 2 != 0) {
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  319  		writeb(*(u8 *)buf, info->fifo);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  320  		p = (u16 *)(buf + 1);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  321  		len--;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  322  	}
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  323  
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  324  	/*  configure and start prefetch transfer */
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  325  	ret = omap_prefetch_enable(info->gpmc_cs,
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  326  			PREFETCH_FIFOTHRESHOLD_MAX, 0x0, len, 0x1, info);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  327  	if (ret) {
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  328  		/* write posting engine is busy, use CPU copy method */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  329  		omap_nand_data_out(chip, buf, len, false);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  330  	} else {
2c01946c6b9eba drivers/mtd/nand/omap2.c     Sukumar Ghorai       2010-07-09  331  		while (len) {
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  332  			w_count = readl(info->reg.gpmc_prefetch_status);
47f88af4ed80ac drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-09-29  333  			w_count = PREFETCH_STATUS_FIFO_CNT(w_count);
2c01946c6b9eba drivers/mtd/nand/omap2.c     Sukumar Ghorai       2010-07-09  334  			w_count = w_count >> 1;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  335  			for (i = 0; (i < w_count) && len; i++, len -= 2)
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  336  				iowrite16(*p++, info->fifo);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  337  		}
2c01946c6b9eba drivers/mtd/nand/omap2.c     Sukumar Ghorai       2010-07-09  338  		/* wait for data to flushed-out before reset the prefetch */
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  339  		tim = 0;
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  340  		limit = (loops_per_jiffy *
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  341  					msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  342  		do {
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  343  			cpu_relax();
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  344  			val = readl(info->reg.gpmc_prefetch_status);
47f88af4ed80ac drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-09-29  345  			val = PREFETCH_STATUS_COUNT(val);
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  346  		} while (val && (tim++ < limit));
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  347  
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  348  		/* disable and stop the PFPW engine */
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  349  		omap_prefetch_reset(info->gpmc_cs, info);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  350  	}
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  351  }
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  352  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  353  /*
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  354   * omap_nand_dma_callback: callback on the completion of dma transfer
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  355   * @data: pointer to completion data structure
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  356   */
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  357  static void omap_nand_dma_callback(void *data)
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  358  {
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  359  	complete((struct completion *) data);
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  360  }
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  361  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  362  /*
4cacbe226f3906 drivers/mtd/nand/omap2.c     Peter Meerwald       2012-07-19  363   * omap_nand_dma_transfer: configure and start dma transfer
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  364   * @chip: nand chip structure
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  365   * @addr: virtual address in RAM of source/destination
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  366   * @len: number of data bytes to be transferred
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  367   * @is_write: flag for read/write operation
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  368   */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  369  static inline int omap_nand_dma_transfer(struct nand_chip *chip,
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  370  					 const void *addr, unsigned int len,
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  371  					 int is_write)
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  372  {
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  373  	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  374  	struct dma_async_tx_descriptor *tx;
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  375  	enum dma_data_direction dir = is_write ? DMA_TO_DEVICE :
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  376  							DMA_FROM_DEVICE;
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  377  	struct scatterlist sg;
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  378  	unsigned long tim, limit;
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  379  	unsigned n;
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  380  	int ret;
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  381  	u32 val;
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  382  
8c6f0fc4d2d505 drivers/mtd/nand/omap2.c     Cooper Jr., Franklin 2016-04-15  383  	if (!virt_addr_valid(addr))
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  384  		goto out_copy;
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  385  
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  386  	sg_init_one(&sg, addr, len);
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  387  	n = dma_map_sg(info->dma->device->dev, &sg, 1, dir);
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  388  	if (n == 0) {
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  389  		dev_err(&info->pdev->dev,
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  390  			"Couldn't DMA map a %d byte buffer\n", len);
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  391  		goto out_copy;
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  392  	}
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  393  
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  394  	tx = dmaengine_prep_slave_sg(info->dma, &sg, n,
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  395  		is_write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  396  		DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  397  	if (!tx)
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  398  		goto out_copy_unmap;
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  399  
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  400  	tx->callback = omap_nand_dma_callback;
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  401  	tx->callback_param = &info->comp;
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  402  	dmaengine_submit(tx);
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  403  
03d3a1df6da660 drivers/mtd/nand/omap2.c     Cooper Jr., Franklin 2016-04-15  404  	init_completion(&info->comp);
03d3a1df6da660 drivers/mtd/nand/omap2.c     Cooper Jr., Franklin 2016-04-15  405  
03d3a1df6da660 drivers/mtd/nand/omap2.c     Cooper Jr., Franklin 2016-04-15  406  	/* setup and start DMA using dma_addr */
03d3a1df6da660 drivers/mtd/nand/omap2.c     Cooper Jr., Franklin 2016-04-15  407  	dma_async_issue_pending(info->dma);
03d3a1df6da660 drivers/mtd/nand/omap2.c     Cooper Jr., Franklin 2016-04-15  408  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  409  	/*  configure and start prefetch transfer */
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  410  	ret = omap_prefetch_enable(info->gpmc_cs,
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  411  		PREFETCH_FIFOTHRESHOLD_MAX, 0x1, len, is_write, info);
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  412  	if (ret)
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  413  		/* PFPW engine is busy, use cpu copy method */
d7efe2281db535 drivers/mtd/nand/omap2.c     Grazvydas Ignotas    2012-04-11  414  		goto out_copy_unmap;
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  415  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  416  	wait_for_completion(&info->comp);
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  417  	tim = 0;
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  418  	limit = (loops_per_jiffy * msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  419  
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  420  	do {
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  421  		cpu_relax();
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  422  		val = readl(info->reg.gpmc_prefetch_status);
47f88af4ed80ac drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-09-29  423  		val = PREFETCH_STATUS_COUNT(val);
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  424  	} while (val && (tim++ < limit));
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  425  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  426  	/* disable and stop the PFPW engine */
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  427  	omap_prefetch_reset(info->gpmc_cs, info);
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  428  
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  429  	dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  430  	return 0;
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  431  
d7efe2281db535 drivers/mtd/nand/omap2.c     Grazvydas Ignotas    2012-04-11  432  out_copy_unmap:
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  433  	dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  434  out_copy:
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  435  	is_write == 0 ? omap_nand_data_in(chip, (void *)addr, len, false)
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  436  		      : omap_nand_data_out(chip, addr, len, false);
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  437  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  438  	return 0;
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  439  }
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  440  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  441  /**
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  442   * omap_nand_data_in_dma_pref - NAND data in using DMA and Prefetch
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  443   */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  444  static void omap_nand_data_in_dma_pref(struct nand_chip *chip, void *buf,
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  445  				       unsigned int len, bool force_8bit)
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13 @446  {
7e534323c41621 drivers/mtd/nand/raw/omap2.c Boris Brezillon      2018-09-06  447  	struct mtd_info *mtd = nand_to_mtd(chip);
7e534323c41621 drivers/mtd/nand/raw/omap2.c Boris Brezillon      2018-09-06  448  
4695a3cf004a44 drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  449  	if (force_8bit) {
4695a3cf004a44 drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  450  		omap_nand_data_in(chip, buf, len, force_8bit);
4695a3cf004a44 drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  451  		return;
4695a3cf004a44 drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  452  	}
4695a3cf004a44 drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  453  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  454  	if (len <= mtd->oobsize)
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  455  		omap_nand_data_in_pref(chip, buf, len, false);
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  456  	else
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  457  		/* start transfer in DMA mode */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  458  		omap_nand_dma_transfer(chip, buf, len, 0x0);
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  459  }
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  460  

:::::: The code at line 260 was first introduced by commit
:::::: 67ce04bf2746f8a1f8c2a104b313d20c63f68378 mtd: nand: add OMAP2/OMAP3 NAND driver

:::::: TO: Vimal Singh <vimalsingh@ti.com>
:::::: CC: David Woodhouse <David.Woodhouse@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

