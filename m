Return-Path: <linux-kernel+bounces-182941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C43908C920A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 21:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6481F22582
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 19:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EFB5916B;
	Sat, 18 May 2024 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QG7Hcy2z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559553D56D
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716059615; cv=none; b=TLor8SuLwkri70uqdSaWM5y12eiceSu0qdE9XSBE/iFL7lZjMCH8UYuStNNNxvbalOK+/lq1AEUOmZFD0fd+C5SAKERjNTUNCxyavCeQ7plVOgLmmC3y0k6tVPeT7Q0E3yND3OqwDTCHrNuDcr/mbg2dLa9Gqo29z6atNOqDESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716059615; c=relaxed/simple;
	bh=dmUrEVkEGWcT32XVHipw4Le/vNC1K1SO1R4PXt+DWpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVNQuRWwZMxK2AFn4aZjEDqxIvJZU/tlgC2DYQu8qa0ZeREa5/UmuJ+LlPVdhnl+yOI7Woy1kN97K5njGdVFNq3jEjACvdsXRUcCRt8iiS/egWjSpkF5tNIoIHM04ZUj4V8SsRl6Iuoptzf1lJHPEpjKFCRdwdTmBGUXcF/9NA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QG7Hcy2z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716059612; x=1747595612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dmUrEVkEGWcT32XVHipw4Le/vNC1K1SO1R4PXt+DWpo=;
  b=QG7Hcy2zqwNjLpWaQGAVmoaIjkZG06jTxZXzuJyCW4JvuNDHJImDFYXr
   xDRdZLrOnSmxOck5CMo2OpKl3rNlbP+DpOmTTZnMUza1j+emXTs2xBy9g
   Ay6UxzEiPEOKQ+iiWiwJE/OkdfU9vWIv0rvjSRu65v/ttpV9E+RJWb2A6
   ot9lbWCW9s9XC3MPiOFqtyMTmSjadrMnJWnIiyVfF/64wi+IwZpa+Dr9s
   /m/N/K00RSOQYjndVbJPh5Bzln+cB2Xg6MtjtHw6adyg7JbL2zhDo0ZSX
   54bUdqzpZksStcmHiE+trtsaVfF3OG5UPkgUfWIj9cknlvR2G+k7p5kq7
   Q==;
X-CSE-ConnectionGUID: FF/VMFnAS+WzX3lcPGYySA==
X-CSE-MsgGUID: M4yCFaOMRlGTJECnFUV7Rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="16056371"
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="16056371"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 12:13:32 -0700
X-CSE-ConnectionGUID: aVWqyovbTkOjj6sLs8Y7Ow==
X-CSE-MsgGUID: xqrEHeKjSZuKYybI86BPIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="32272042"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 18 May 2024 12:13:30 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8PUl-0002YS-1n;
	Sat, 18 May 2024 19:13:27 +0000
Date: Sun, 19 May 2024 03:13:21 +0800
From: kernel test robot <lkp@intel.com>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>,
	srinivas.kandagatla@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove redundant description in struct segdist_code
Message-ID: <202405190241.jIzZxFB5-lkp@intel.com>
References: <20240518165840.29415-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518165840.29415-1-abhishektamboli9@gmail.com>

Hi Abhishek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.9 next-20240517]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhishek-Tamboli/Remove-redundant-description-in-struct-segdist_code/20240519-010020
base:   linus/master
patch link:    https://lore.kernel.org/r/20240518165840.29415-1-abhishektamboli9%40gmail.com
patch subject: [PATCH] Remove redundant description in struct segdist_code
config: i386-randconfig-141-20240519 (https://download.01.org/0day-ci/archive/20240519/202405190241.jIzZxFB5-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240519/202405190241.jIzZxFB5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405190241.jIzZxFB5-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/slimbus/stream.c:48: warning: Function parameter or struct member 'segdist_codes' not described in 'segdist_code'


vim +48 drivers/slimbus/stream.c

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
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  22  static const struct segdist_code {
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  23  	int ratem;
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  24  	int seg_interval;
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  25  	int segdist_code;
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  26  	u32 seg_offset_mask;
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  27  
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  28  } segdist_codes[] = {
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  29  	{1,	1536,	0x200,	 0xdff},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  30  	{2,	768,	0x100,	 0xcff},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  31  	{4,	384,	0x080,	 0xc7f},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  32  	{8,	192,	0x040,	 0xc3f},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  33  	{16,	96,	0x020,	 0xc1f},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  34  	{32,	48,	0x010,	 0xc0f},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  35  	{64,	24,	0x008,	 0xc07},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  36  	{128,	12,	0x004,	 0xc03},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  37  	{256,	6,	0x002,	 0xc01},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  38  	{512,	3,	0x001,	 0xc00},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  39  	{3,	512,	0xe00,	 0x1ff},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  40  	{6,	256,	0xd00,	 0x0ff},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  41  	{12,	128,	0xc80,	 0x07f},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  42  	{24,	64,	0xc40,	 0x03f},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  43  	{48,	32,	0xc20,	 0x01f},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  44  	{96,	16,	0xc10,	 0x00f},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  45  	{192,	8,	0xc08,	 0x007},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  46  	{364,	4,	0xc04,	 0x003},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  47  	{768,	2,	0xc02,	 0x001},
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05 @48  };
abb9c9b8b51ba5 Srinivas Kandagatla 2018-07-05  49  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

