Return-Path: <linux-kernel+bounces-248316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6552D92DBA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CEB9283085
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E373E143C58;
	Wed, 10 Jul 2024 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLou8rv+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823013D886
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649395; cv=none; b=uCV1kvKumpjLAqZWk2EPr7Ku1z0Z8WBUClTaBTtlVTIVSM7RcGhJYjPZRttFzp1LIYRcpQT3mYiS4nr8J3KykQQHpFxaTwXRZi1TbXPFc83kAlpkHXIm11KYEPhCoYg5ZgYm6K9+r97O5c/zWDVv27rPerAXX12gVFUwCvFvOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649395; c=relaxed/simple;
	bh=wSMLdOaAIyfeMlYDPE9ykwDaq14eIz1cba3/eVSQBdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhDyHYDt3Jrpbp+Ry7Rda+V6Cx3GOuAlS/OW5d1laZSumJUkpzkcHcHjJvyTiaeG1TH+yOSQTdiyjyBmu4UdOl4ksitbL6gnZI+Ij/i7ZxI8EEjxVpYH9JY8QNz2rm3j1hddCQYc+3RHM9+SpRfhn9lg7st0brG917M40B7/HyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLou8rv+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720649392; x=1752185392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wSMLdOaAIyfeMlYDPE9ykwDaq14eIz1cba3/eVSQBdo=;
  b=CLou8rv+TW6JB+pKAO687vVTgiUldAdEGYMJw/UpZMnN6EWfwH+Tmydy
   0RNNhpVj+bix3DSgWhH8KA9J3qP1+LFgOca361GI6M92y5TSbHuScg1iI
   0p3JUOKh88siyI6b8NkjJMf9Xctv9FXMBHSWaDlVueTBK3Bi+jF3Uz8h0
   ZakaffyEzRanbsZcoTRuYFO1WqcBGaYunQD8o1r7T34+LuS6yCYER7bPW
   HnsKZhKYrzRI/n4Kov1y5lYdZBlUMHrsgpL8cqApnLNBuswV/cBTrsqQd
   HyQKvQ8tWgUzi+SzJzZt+v+JMr5qFtkjC2wp0+wzWIyUMawP0CCo6lBhP
   g==;
X-CSE-ConnectionGUID: X4c7XYd0Q/OhWUMY5FDgtQ==
X-CSE-MsgGUID: UCuYvI9vRxCimPmWT/isAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="20911552"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="20911552"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 15:09:51 -0700
X-CSE-ConnectionGUID: eaqdFRdISdqNQ+NTKGO1yw==
X-CSE-MsgGUID: hl/y1xj5Q2GJi/ICes6TNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48440999"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2024 15:09:48 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRfVS-000YLq-1N;
	Wed, 10 Jul 2024 22:09:46 +0000
Date: Thu, 11 Jul 2024 06:09:02 +0800
From: kernel test robot <lkp@intel.com>
To: Cheng Ming Lin <linchengming884@gmail.com>, miquel.raynal@bootlin.com,
	vigneshr@ti.com, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, richard@nod.at,
	alvinzhou@mxic.com.tw, leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 2/3] mtd: spinand: macronix: Fixups for PLANE_SELECT_BIT
Message-ID: <202407110520.pbPnrOlM-lkp@intel.com>
References: <20240710011541.342682-3-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710011541.342682-3-linchengming884@gmail.com>

Hi Cheng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on next-20240710]
[cannot apply to linus/master v6.10-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cheng-Ming-Lin/include-linux-mtd-spinand-h-Add-fixups-for-spinand/20240710-184654
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
patch link:    https://lore.kernel.org/r/20240710011541.342682-3-linchengming884%40gmail.com
patch subject: [PATCH 2/3] mtd: spinand: macronix: Fixups for PLANE_SELECT_BIT
config: i386-randconfig-014-20240711 (https://download.01.org/0day-ci/archive/20240711/202407110520.pbPnrOlM-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407110520.pbPnrOlM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407110520.pbPnrOlM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/spi/macronix.c:113: warning: Function parameter or struct member 'spinand' not described in 'write_Plane_Select_bit_in_cadd'
>> drivers/mtd/nand/spi/macronix.c:113: warning: Function parameter or struct member 'req' not described in 'write_Plane_Select_bit_in_cadd'
>> drivers/mtd/nand/spi/macronix.c:113: warning: Function parameter or struct member 'column' not described in 'write_Plane_Select_bit_in_cadd'
>> drivers/mtd/nand/spi/macronix.c:113: warning: expecting prototype for Macronix serial NAND flash with a two(). Prototype was for write_Plane_Select_bit_in_cadd() instead


vim +113 drivers/mtd/nand/spi/macronix.c

   102	
   103	/**
   104	 * Macronix serial NAND flash with a two-plane structure
   105	 * should insert Plane Select bit into the column address
   106	 * during the write_to_cache operation.
   107	 * Additionally, MX35{U,F}2G14AC also need to insert Plane
   108	 * Select bit into the column address during the read_from_cache
   109	 * operation.
   110	 */
   111	static unsigned int write_Plane_Select_bit_in_cadd(struct spinand_device *spinand,
   112				const struct nand_page_io_req *req, unsigned int column)
 > 113	{
   114		struct nand_device *nand = spinand_to_nand(spinand);
   115	
   116		return column | (req->pos.plane << fls(nanddev_page_size(nand)));
   117	}
   118	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

