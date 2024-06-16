Return-Path: <linux-kernel+bounces-216451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B23909F77
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 21:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8D01C2176E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927A4CB28;
	Sun, 16 Jun 2024 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLmn7tfU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8741C6A0
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 19:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718564917; cv=none; b=MMybThj69wmIBuVukdoY/n12e+PhDuIqmnipCfAPpPe1Meo73U68ykFdSJblWAWKNl6sT5NmXTJOISEzoNfxwWU4MpuAyYQL9LBT9WkFOiMZabZUbWF4UBShkG4RjE2nE9v1caB1FwmaF+BKWzzuIo7U2D/dbg+mPXe5ha/RwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718564917; c=relaxed/simple;
	bh=jAUV2fkaJUOuqukFImg27JopNhskZOQjkb5WpZ7dnXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idcbr/jii0Lm74xFAquUW3vsM+8fWLj60qO8G1VKaTzlEOOZx2YBdHTuhTvcbLnzW2uAFoal2xPZg/D2B0TdSBoWOz3KaxsQ+HkvNviLqxe0wztSpJM/9wSn2FPLHKcQSyVnsG8V50+W5Jc3MSN+wp6s3tA3ibYh5HQO0OxG0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLmn7tfU; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718564916; x=1750100916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jAUV2fkaJUOuqukFImg27JopNhskZOQjkb5WpZ7dnXI=;
  b=FLmn7tfUe0O3+EBuxj4J9Q6AUPQiOENrc5JiRfOtAJxyDWPFpIOUiaZp
   BqeOKSpqYrTllt2zLHghgl2qKtLQSC3pnbV8yWX5OL/qo/JmcmpbVpyvt
   cwQPxnyhjUpvvX2fAteFDxb9d1NxJUxmM2EYOtqy3Q92giBYtzkWnyujX
   h9kYLSk/FWUFAiE69+JTFEo0buJE2xLAv3sLmnZ1ZjJmthohPq6edtIua
   n2Yxt9tsKRw+KFYEQmbLyj3Go5IMXBGqFgk4fQwGEXlbKd6EMnMzmugdR
   IZd2vDFKWgD0SSLwihtguyFJKEQpSZmyhmaUufXYjiMnxaY8tW70S2Wnx
   A==;
X-CSE-ConnectionGUID: JduJFg9JRlSlNzryVEKx9w==
X-CSE-MsgGUID: 7SV3sc2qSIalq5GAtGwK9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="32866479"
X-IronPort-AV: E=Sophos;i="6.08,243,1712646000"; 
   d="scan'208";a="32866479"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 12:08:35 -0700
X-CSE-ConnectionGUID: s69HtPn/S02F75KT9lBZwA==
X-CSE-MsgGUID: 3wULYVdJRtiEZ2VnXSxS8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,243,1712646000"; 
   d="scan'208";a="40937455"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Jun 2024 12:08:33 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIvEs-0003Ay-1n;
	Sun, 16 Jun 2024 19:08:30 +0000
Date: Mon, 17 Jun 2024 03:07:40 +0800
From: kernel test robot <lkp@intel.com>
To: Amit Vadhavana <av2082000@gmail.com>, srinivas.kandagatla@linaro.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	rbmarliere@gmail.com, skhan@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel-mentees@lists.linuxfoundation.org, av2082000@gmail.com
Subject: Re: [PATCH] slimbus: Fix struct and documentation alignment in
 stream.c
Message-ID: <202406170201.Zh53W56G-lkp@intel.com>
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
[also build test WARNING on v6.10-rc3 next-20240612]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Amit-Vadhavana/slimbus-Fix-struct-and-documentation-alignment-in-stream-c/20240616-234811
base:   linus/master
patch link:    https://lore.kernel.org/r/20240616154531.38232-1-av2082000%40gmail.com
patch subject: [PATCH] slimbus: Fix struct and documentation alignment in stream.c
config: arm-randconfig-002-20240617 (https://download.01.org/0day-ci/archive/20240617/202406170201.Zh53W56G-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 78ee473784e5ef6f0b19ce4cb111fb6e4d23c6b2)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240617/202406170201.Zh53W56G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406170201.Zh53W56G-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/slimbus/stream.c:22:1: warning: 'static' ignored on this declaration [-Wmissing-declarations]
      22 | static const struct segdist_code {
         | ^
>> drivers/slimbus/stream.c:22:8: warning: 'const' ignored on this declaration [-Wmissing-declarations]
      22 | static const struct segdist_code {
         |        ^
   2 warnings generated.


vim +/static +22 drivers/slimbus/stream.c

abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  11  
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  12  /**
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  13   * struct segdist_code - Segment Distributions code from
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  14   *	Table 20 of SLIMbus Specs Version 2.0
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  15   *
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  16   * @ratem: Channel Rate Multipler(Segments per Superframe)
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  17   * @seg_interval: Number of slots between the first Slot of Segment
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  18   *		and the first slot of the next  consecutive Segment.
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  19   * @segdist_code: Segment Distribution Code SD[11:0]
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  20   * @seg_offset_mask: Segment offset mask in SD[11:0]
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  21   */
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05 @22  static const struct segdist_code {
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  23  	int ratem;
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  24  	int seg_interval;
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  25  	int segdist_code;
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  26  	u32 seg_offset_mask;
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  27  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

