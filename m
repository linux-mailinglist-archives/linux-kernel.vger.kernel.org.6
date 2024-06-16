Return-Path: <linux-kernel+bounces-216438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA04909F4F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3E55B20B16
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6A04503A;
	Sun, 16 Jun 2024 18:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkuCsKMI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36321B27D
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718563596; cv=none; b=mhzKrXWa2Z5iAiPlrJTUaouA3xJtkS7d/IdQkJbZsMKZtye+aooxCpZrgL6tTzqPT5yCfBsvRC8jlyQolmeLHUIL3eJ/iRU9v/2Myqw6GUGBmNbzkzAKmBro0mY3JoKdY3980P+ignUUaKifIdTmgF2jNvgAoPvzu0X7T6eEhGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718563596; c=relaxed/simple;
	bh=tLd7mS6bPJCicOINSMGFRmf6Hzbsirhin6FWdqKp3bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuJsn0W6nZvnWCwnNKkS+IFSRhzn9f5PZzD/E8PFU1MSF99AT+VjbLKiYDw7uacyaV99IawTQuS3+4d17Dqom+12mDQb4tIUDAymNZmX+SkhQOjcjEz0bCmgcpbVgnxy2y+8iG+IPNzMO+Oyc2jhjdw+FtaAeTXCjRndpCWDfqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkuCsKMI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718563594; x=1750099594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tLd7mS6bPJCicOINSMGFRmf6Hzbsirhin6FWdqKp3bk=;
  b=SkuCsKMI/0R5Ig1SXxr4s+OdWGEJohhIV64JmUkROmidVMOTE3M3Ufyi
   2ewspjrSFk5vWgMw2mBPFFf1IbSEHwdpkfnPxd5dv4Im+yWJ9DkhB1M/u
   naa6TSW6Gq8vpMYldozw3zli3l1JyZkZ9r/uVHFG22uq1JkukM2Szpql/
   txYK5p2AbRiNoRBUf1f7ekGM4pycTVNqKPbJsSDr54/RgxJXWu/+mR/GN
   ywcy7Rm7GfdniYYizUGsh7maY2dHhv9aFZsAU8RMbe36U11TUBhpG9QuO
   pVN5jfpCeSNLIGAjud/IOeS5hr5WEZQiOigHU7iHz0Ecd/I25HEcabGDu
   g==;
X-CSE-ConnectionGUID: EudKHphgQhWro8VRCr1kbw==
X-CSE-MsgGUID: heJf3gGaTpmEMQ4jfZyLiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="37917621"
X-IronPort-AV: E=Sophos;i="6.08,243,1712646000"; 
   d="scan'208";a="37917621"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 11:46:34 -0700
X-CSE-ConnectionGUID: 6sKTfiJsQBqIZ6eWJZm/CA==
X-CSE-MsgGUID: Mp/rJAFEQqSKXh14liab6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,243,1712646000"; 
   d="scan'208";a="72209287"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Jun 2024 11:46:32 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIuta-0003AI-0i;
	Sun, 16 Jun 2024 18:46:30 +0000
Date: Mon, 17 Jun 2024 02:45:54 +0800
From: kernel test robot <lkp@intel.com>
To: Amit Vadhavana <av2082000@gmail.com>, srinivas.kandagatla@linaro.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	rbmarliere@gmail.com, skhan@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev,
	linux-kernel-mentees@lists.linuxfoundation.org, av2082000@gmail.com
Subject: Re: [PATCH] slimbus: Fix struct and documentation alignment in
 stream.c
Message-ID: <202406170228.1TcJ2eGD-lkp@intel.com>
References: <20240616154531.38232-1-av2082000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616154531.38232-1-av2082000@gmail.com>

Hi Amit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.10-rc3 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Amit-Vadhavana/slimbus-Fix-struct-and-documentation-alignment-in-stream-c/20240616-234811
base:   linus/master
patch link:    https://lore.kernel.org/r/20240616154531.38232-1-av2082000%40gmail.com
patch subject: [PATCH] slimbus: Fix struct and documentation alignment in stream.c
config: arc-randconfig-002-20240617 (https://download.01.org/0day-ci/archive/20240617/202406170228.1TcJ2eGD-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240617/202406170228.1TcJ2eGD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406170228.1TcJ2eGD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/slimbus/stream.c:28:1: warning: useless storage class specifier in empty declaration
      28 | };
         | ^


vim +28 drivers/slimbus/stream.c

    11	
    12	/**
    13	 * struct segdist_code - Segment Distributions code from
    14	 *	Table 20 of SLIMbus Specs Version 2.0
    15	 *
    16	 * @ratem: Channel Rate Multipler(Segments per Superframe)
    17	 * @seg_interval: Number of slots between the first Slot of Segment
    18	 *		and the first slot of the next  consecutive Segment.
    19	 * @segdist_code: Segment Distribution Code SD[11:0]
    20	 * @seg_offset_mask: Segment offset mask in SD[11:0]
    21	 */
    22	static const struct segdist_code {
    23		int ratem;
    24		int seg_interval;
    25		int segdist_code;
    26		u32 seg_offset_mask;
    27	
  > 28	};
    29	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

