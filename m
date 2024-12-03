Return-Path: <linux-kernel+bounces-429194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6979E185A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BD0166872
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1863C1E0B6C;
	Tue,  3 Dec 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgPwO/bE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5815A1DFE27
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219730; cv=none; b=tZWfDeGLI9NYQOeGyWbnw8zWVGq59EgNIohEfFks1j0yMqa7iHZ4LpsaNKXXAPa271edVCFqY5/ebBWMeIDCwSuG7lWlCoaeSVxy9kfwY6lKL5JR5dgfugoyhbSupjPHKIixkcKwfAq2tBZR4zRLxTbrBk4ynRUgdgdLTNIVgpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219730; c=relaxed/simple;
	bh=hRkaOTaCuCM4FriXUeQx17QoaqIVFD5Esls30M1qlro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I29RRAJ/9duA8qeRZwE3i13BIDRVqNIKhHcj0aqJZc4n9n65PeGX5UB9OnmeVLRLEzZrr1oDn23Owc1OhgwvAmSKSE1+ZG/ztAjAjyO34AetQlJAgljIsKr1Qu4VWHYMMZ6zT42cNOEoR1ZHL8Xn/RosJXTZItC4cAJcP/od3oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgPwO/bE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733219729; x=1764755729;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hRkaOTaCuCM4FriXUeQx17QoaqIVFD5Esls30M1qlro=;
  b=jgPwO/bEfJFf3zoVm8JEjOMPpt5Js0zX8JP9C/NcURbvB3Q149EhnFJh
   tflrFIVGe+EDuLRZKnX0x+8HrLfR50BF7ZnkVehzP9h3icSTNKL4pxjFl
   z4NM5DZTFv/o8/WSXeV/IfOjm8y8nlrPwmTpqb8KhvYJmmn3C6m+y6fSH
   S7lVs4BJIylNqMcMEMVIWupOegtLMaimkwUG+7mYP1UocU4snZNfBydGJ
   iufRAPVcx4DEkPP10Qi+gMnmyAuJ0TBZbsxgZ3tVQi6DpZ8jeEdQBa6gn
   qThwN9QnRPLYbmWycrI5tJdY6GUgF9tLDexba+HjEktFxckYYSvPqS2SK
   g==;
X-CSE-ConnectionGUID: A2hhvh7kT6CwvnktJCb8Ow==
X-CSE-MsgGUID: GKCe0VNsSg2/78clESLJ6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44034167"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="44034167"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 01:55:26 -0800
X-CSE-ConnectionGUID: WU4pR8BzSF+xrvWJR6PWDQ==
X-CSE-MsgGUID: B/86XJvlS4OKHwQ+m+QmNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93046601"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 03 Dec 2024 01:55:24 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIPcn-0000VZ-2K;
	Tue, 03 Dec 2024 09:55:21 +0000
Date: Tue, 3 Dec 2024 17:54:51 +0800
From: kernel test robot <lkp@intel.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: drivers/mtd/nand/raw/omap2.c:261: warning: Function parameter or
 member 'chip' not described in 'omap_nand_data_in_pref'
Message-ID: <202412031716.JfNIh1Uu-lkp@intel.com>
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
commit: a9e849efca4f9c7732ea4a81f13ec96208994b22 mtd: rawnand: omap2: move to exec_op interface
date:   3 years ago
config: i386-buildonly-randconfig-001-20240106 (https://download.01.org/0day-ci/archive/20241203/202412031716.JfNIh1Uu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031716.JfNIh1Uu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031716.JfNIh1Uu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/raw/omap2.c:261: warning: Function parameter or member 'chip' not described in 'omap_nand_data_in_pref'
>> drivers/mtd/nand/raw/omap2.c:261: warning: Function parameter or member 'buf' not described in 'omap_nand_data_in_pref'
>> drivers/mtd/nand/raw/omap2.c:261: warning: Function parameter or member 'len' not described in 'omap_nand_data_in_pref'
>> drivers/mtd/nand/raw/omap2.c:261: warning: Function parameter or member 'force_8bit' not described in 'omap_nand_data_in_pref'
>> drivers/mtd/nand/raw/omap2.c:305: warning: Function parameter or member 'chip' not described in 'omap_nand_data_out_pref'
>> drivers/mtd/nand/raw/omap2.c:305: warning: Function parameter or member 'buf' not described in 'omap_nand_data_out_pref'
>> drivers/mtd/nand/raw/omap2.c:305: warning: Function parameter or member 'len' not described in 'omap_nand_data_out_pref'
>> drivers/mtd/nand/raw/omap2.c:305: warning: Function parameter or member 'force_8bit' not described in 'omap_nand_data_out_pref'
>> drivers/mtd/nand/raw/omap2.c:447: warning: Function parameter or member 'chip' not described in 'omap_nand_data_in_dma_pref'
>> drivers/mtd/nand/raw/omap2.c:447: warning: Function parameter or member 'buf' not described in 'omap_nand_data_in_dma_pref'
>> drivers/mtd/nand/raw/omap2.c:447: warning: Function parameter or member 'len' not described in 'omap_nand_data_in_dma_pref'
>> drivers/mtd/nand/raw/omap2.c:447: warning: Function parameter or member 'force_8bit' not described in 'omap_nand_data_in_dma_pref'
>> drivers/mtd/nand/raw/omap2.c:463: warning: Function parameter or member 'chip' not described in 'omap_nand_data_out_dma_pref'
>> drivers/mtd/nand/raw/omap2.c:463: warning: Function parameter or member 'buf' not described in 'omap_nand_data_out_dma_pref'
>> drivers/mtd/nand/raw/omap2.c:463: warning: Function parameter or member 'len' not described in 'omap_nand_data_out_dma_pref'
>> drivers/mtd/nand/raw/omap2.c:463: warning: Function parameter or member 'force_8bit' not described in 'omap_nand_data_out_dma_pref'


vim +261 drivers/mtd/nand/raw/omap2.c

65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  255  
67ce04bf2746f8 drivers/mtd/nand/omap2.c     Vimal Singh          2009-05-12  256  /**
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  257   * omap_nand_data_in_pref - NAND data in using prefetch engine
67ce04bf2746f8 drivers/mtd/nand/omap2.c     Vimal Singh          2009-05-12  258   */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  259  static void omap_nand_data_in_pref(struct nand_chip *chip, void *buf,
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  260  				   unsigned int len, bool force_8bit)
67ce04bf2746f8 drivers/mtd/nand/omap2.c     Vimal Singh          2009-05-12 @261  {
0f808c1602bc75 drivers/mtd/nand/raw/omap2.c Boris Brezillon      2018-09-06  262  	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
2c01946c6b9eba drivers/mtd/nand/omap2.c     Sukumar Ghorai       2010-07-09  263  	uint32_t r_count = 0;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  264  	int ret = 0;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  265  	u32 *p = (u32 *)buf;
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  266  	unsigned int pref_len;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  267  
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  268  	if (force_8bit) {
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  269  		omap_nand_data_in(chip, buf, len, force_8bit);
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  270  		return;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  271  	}
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  272  
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  273  	/* read 32-bit words using prefetch and remaining bytes normally */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  274  
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  275  	/* configure and start prefetch transfer */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  276  	pref_len = len - (len & 3);
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  277  	ret = omap_prefetch_enable(info->gpmc_cs,
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  278  			PREFETCH_FIFOTHRESHOLD_MAX, 0x0, pref_len, 0x0, info);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  279  	if (ret) {
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  280  		/* prefetch engine is busy, use CPU copy method */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  281  		omap_nand_data_in(chip, buf, len, false);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  282  	} else {
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  283  		do {
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  284  			r_count = readl(info->reg.gpmc_prefetch_status);
47f88af4ed80ac drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-09-29  285  			r_count = PREFETCH_STATUS_FIFO_CNT(r_count);
2c01946c6b9eba drivers/mtd/nand/omap2.c     Sukumar Ghorai       2010-07-09  286  			r_count = r_count >> 2;
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  287  			ioread32_rep(info->fifo, p, r_count);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  288  			p += r_count;
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  289  			pref_len -= r_count << 2;
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  290  		} while (pref_len);
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  291  		/* disable and stop the Prefetch engine */
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  292  		omap_prefetch_reset(info->gpmc_cs, info);
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  293  		/* fetch any remaining bytes */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  294  		if (len & 3)
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  295  			omap_nand_data_in(chip, p, len & 3, false);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  296  	}
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  297  }
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  298  
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  299  /**
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  300   * omap_nand_data_out_pref - NAND data out using Write Posting engine
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  301   */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  302  static void omap_nand_data_out_pref(struct nand_chip *chip,
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  303  				    const void *buf, unsigned int len,
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  304  				    bool force_8bit)
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13 @305  {
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  306  	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  307  	uint32_t w_count = 0;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  308  	int i = 0, ret = 0;
c5d8c0cae4af7d drivers/mtd/nand/omap2.c     Kishore Kadiyala     2011-05-11  309  	u16 *p = (u16 *)buf;
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  310  	unsigned long tim, limit;
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  311  	u32 val;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  312  
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  313  	if (force_8bit) {
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  314  		omap_nand_data_out(chip, buf, len, force_8bit);
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  315  		return;
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  316  	}
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  317  
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  318  	/* take care of subpage writes */
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  319  	if (len % 2 != 0) {
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  320  		writeb(*(u8 *)buf, info->fifo);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  321  		p = (u16 *)(buf + 1);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  322  		len--;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  323  	}
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  324  
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  325  	/*  configure and start prefetch transfer */
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  326  	ret = omap_prefetch_enable(info->gpmc_cs,
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  327  			PREFETCH_FIFOTHRESHOLD_MAX, 0x0, len, 0x1, info);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  328  	if (ret) {
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  329  		/* write posting engine is busy, use CPU copy method */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  330  		omap_nand_data_out(chip, buf, len, false);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  331  	} else {
2c01946c6b9eba drivers/mtd/nand/omap2.c     Sukumar Ghorai       2010-07-09  332  		while (len) {
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  333  			w_count = readl(info->reg.gpmc_prefetch_status);
47f88af4ed80ac drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-09-29  334  			w_count = PREFETCH_STATUS_FIFO_CNT(w_count);
2c01946c6b9eba drivers/mtd/nand/omap2.c     Sukumar Ghorai       2010-07-09  335  			w_count = w_count >> 1;
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  336  			for (i = 0; (i < w_count) && len; i++, len -= 2)
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  337  				iowrite16(*p++, info->fifo);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  338  		}
2c01946c6b9eba drivers/mtd/nand/omap2.c     Sukumar Ghorai       2010-07-09  339  		/* wait for data to flushed-out before reset the prefetch */
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  340  		tim = 0;
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  341  		limit = (loops_per_jiffy *
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  342  					msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  343  		do {
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  344  			cpu_relax();
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  345  			val = readl(info->reg.gpmc_prefetch_status);
47f88af4ed80ac drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-09-29  346  			val = PREFETCH_STATUS_COUNT(val);
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  347  		} while (val && (tim++ < limit));
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  348  
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  349  		/* disable and stop the PFPW engine */
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  350  		omap_prefetch_reset(info->gpmc_cs, info);
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  351  	}
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  352  }
59e9c5ae17179f drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  353  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  354  /*
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  355   * omap_nand_dma_callback: callback on the completion of dma transfer
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  356   * @data: pointer to completion data structure
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  357   */
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  358  static void omap_nand_dma_callback(void *data)
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  359  {
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  360  	complete((struct completion *) data);
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  361  }
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  362  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  363  /*
4cacbe226f3906 drivers/mtd/nand/omap2.c     Peter Meerwald       2012-07-19  364   * omap_nand_dma_transfer: configure and start dma transfer
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  365   * @chip: nand chip structure
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  366   * @addr: virtual address in RAM of source/destination
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  367   * @len: number of data bytes to be transferred
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  368   * @is_write: flag for read/write operation
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  369   */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  370  static inline int omap_nand_dma_transfer(struct nand_chip *chip,
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  371  					 const void *addr, unsigned int len,
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  372  					 int is_write)
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  373  {
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  374  	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  375  	struct dma_async_tx_descriptor *tx;
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  376  	enum dma_data_direction dir = is_write ? DMA_TO_DEVICE :
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  377  							DMA_FROM_DEVICE;
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  378  	struct scatterlist sg;
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  379  	unsigned long tim, limit;
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  380  	unsigned n;
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  381  	int ret;
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  382  	u32 val;
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  383  
8c6f0fc4d2d505 drivers/mtd/nand/omap2.c     Cooper Jr., Franklin 2016-04-15  384  	if (!virt_addr_valid(addr))
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  385  		goto out_copy;
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  386  
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  387  	sg_init_one(&sg, addr, len);
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  388  	n = dma_map_sg(info->dma->device->dev, &sg, 1, dir);
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  389  	if (n == 0) {
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  390  		dev_err(&info->pdev->dev,
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  391  			"Couldn't DMA map a %d byte buffer\n", len);
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  392  		goto out_copy;
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  393  	}
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  394  
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  395  	tx = dmaengine_prep_slave_sg(info->dma, &sg, n,
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  396  		is_write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM,
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  397  		DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  398  	if (!tx)
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  399  		goto out_copy_unmap;
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  400  
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  401  	tx->callback = omap_nand_dma_callback;
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  402  	tx->callback_param = &info->comp;
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  403  	dmaengine_submit(tx);
763e7359109223 drivers/mtd/nand/omap2.c     Russell King         2012-04-25  404  
03d3a1df6da660 drivers/mtd/nand/omap2.c     Cooper Jr., Franklin 2016-04-15  405  	init_completion(&info->comp);
03d3a1df6da660 drivers/mtd/nand/omap2.c     Cooper Jr., Franklin 2016-04-15  406  
03d3a1df6da660 drivers/mtd/nand/omap2.c     Cooper Jr., Franklin 2016-04-15  407  	/* setup and start DMA using dma_addr */
03d3a1df6da660 drivers/mtd/nand/omap2.c     Cooper Jr., Franklin 2016-04-15  408  	dma_async_issue_pending(info->dma);
03d3a1df6da660 drivers/mtd/nand/omap2.c     Cooper Jr., Franklin 2016-04-15  409  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  410  	/*  configure and start prefetch transfer */
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  411  	ret = omap_prefetch_enable(info->gpmc_cs,
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  412  		PREFETCH_FIFOTHRESHOLD_MAX, 0x1, len, is_write, info);
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  413  	if (ret)
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  414  		/* PFPW engine is busy, use cpu copy method */
d7efe2281db535 drivers/mtd/nand/omap2.c     Grazvydas Ignotas    2012-04-11  415  		goto out_copy_unmap;
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  416  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  417  	wait_for_completion(&info->comp);
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  418  	tim = 0;
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  419  	limit = (loops_per_jiffy * msecs_to_jiffies(OMAP_NAND_TIMEOUT_MS));
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  420  
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  421  	do {
4e070376165a9b drivers/mtd/nand/omap2.c     Sukumar Ghorai       2011-01-28  422  		cpu_relax();
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  423  		val = readl(info->reg.gpmc_prefetch_status);
47f88af4ed80ac drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-09-29  424  		val = PREFETCH_STATUS_COUNT(val);
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  425  	} while (val && (tim++ < limit));
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  426  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  427  	/* disable and stop the PFPW engine */
65b97cf6b8deca drivers/mtd/nand/omap2.c     Afzal Mohammed       2012-08-30  428  	omap_prefetch_reset(info->gpmc_cs, info);
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  429  
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  430  	dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  431  	return 0;
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  432  
d7efe2281db535 drivers/mtd/nand/omap2.c     Grazvydas Ignotas    2012-04-11  433  out_copy_unmap:
2df41d0533ad1a drivers/mtd/nand/omap2.c     Russell King         2012-04-25  434  	dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  435  out_copy:
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  436  	is_write == 0 ? omap_nand_data_in(chip, (void *)addr, len, false)
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  437  		      : omap_nand_data_out(chip, addr, len, false);
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  438  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  439  	return 0;
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  440  }
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  441  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  442  /**
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  443   * omap_nand_data_in_dma_pref - NAND data in using DMA and Prefetch
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  444   */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  445  static void omap_nand_data_in_dma_pref(struct nand_chip *chip, void *buf,
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  446  				       unsigned int len, bool force_8bit)
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13 @447  {
7e534323c41621 drivers/mtd/nand/raw/omap2.c Boris Brezillon      2018-09-06  448  	struct mtd_info *mtd = nand_to_mtd(chip);
7e534323c41621 drivers/mtd/nand/raw/omap2.c Boris Brezillon      2018-09-06  449  
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  450  	if (len <= mtd->oobsize)
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  451  		omap_nand_data_in_pref(chip, buf, len, false);
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  452  	else
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  453  		/* start transfer in DMA mode */
a9e849efca4f9c drivers/mtd/nand/raw/omap2.c Roger Quadros        2021-12-09  454  		omap_nand_dma_transfer(chip, buf, len, 0x0);
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  455  }
dfe32893cbe3e5 drivers/mtd/nand/omap2.c     vimal singh          2009-07-13  456  

:::::: The code at line 261 was first introduced by commit
:::::: 67ce04bf2746f8a1f8c2a104b313d20c63f68378 mtd: nand: add OMAP2/OMAP3 NAND driver

:::::: TO: Vimal Singh <vimalsingh@ti.com>
:::::: CC: David Woodhouse <David.Woodhouse@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

