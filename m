Return-Path: <linux-kernel+bounces-205039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD36A8FF68E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A868B213A1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BD173518;
	Thu,  6 Jun 2024 21:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjlI5jEz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212ED282FE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708654; cv=none; b=e/Yr0Dj+lS14/haV5Uha7eWo2/96uu640Z8XSy7cHd1Suro6C0LgLG+4W/L7X3NQO9NjRXMZIL6timtgZFCeX5BaFPJjld6TpGa1EDz+lRY29/pIDC7WvYSwkx84pI579E9zojUZuiMDy15LUznkp54lVNh59ps7ECsailanKiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708654; c=relaxed/simple;
	bh=N0Q7oD6FKmO32Pc1pIntTHg0BQLLkxWsDSJc6HB1PFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYiNn/XfCwkrQifN0CTj8H+zesVQbIJF0Qmf3UgK/AdQ6ilDrDGP67K2qLugcQ+dQXd+zhd73c0cdtZghlrWpqHx3XHzFhjUqWnJV/+9CUFAdU7j2ph8FPYsa/Y/LDPRGMeY8oAKTxGKdZH8A3cujeKypZfu6sUbhT1PQaYf8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjlI5jEz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717708652; x=1749244652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N0Q7oD6FKmO32Pc1pIntTHg0BQLLkxWsDSJc6HB1PFs=;
  b=IjlI5jEzghlui+3Q3bT/YhTL7ZBUHHXHqqYJacSWcCAtUFJz1k65RtrC
   1S/XwBGdPnsfuVxMyMd6KctkeDx4XW+LrnVZE0c+Rp2mdv3f+30qrtKO2
   4LNzO+VOvRckHj4aHB+lSzqSX65g6dUxla2FAXlvTjLoeGsb8d2FF7tlI
   H838b2E6cjcqzMIw+OIHykhEjUZht/oxPF/bMOh1JKc7VDyLfgdnHKiqB
   irAuFmli2aG6BmMbAZXae033zIT16a7QAdTZmuOjcIJrN8YdcT7j8+8tb
   27ZWajgXSlq6LFDXPha3Ig1qAksRPPQ2UVzbuo32pCu7jT7SI0Z3zhehY
   A==;
X-CSE-ConnectionGUID: WRc1DeczQR+PO1UA+bE9Tg==
X-CSE-MsgGUID: yqIy6F3jRYKmheoumk/p7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25814967"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25814967"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 14:17:32 -0700
X-CSE-ConnectionGUID: /3VKxS5mSyGw3G6NuzDeGQ==
X-CSE-MsgGUID: OY8x7gTDTFG2XlxKbELLIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="75576778"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 06 Jun 2024 14:17:29 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFKUA-0003jO-2m;
	Thu, 06 Jun 2024 21:17:26 +0000
Date: Fri, 7 Jun 2024 05:16:50 +0800
From: kernel test robot <lkp@intel.com>
To: Tao Zeng via B4 Relay <devnull+tao.zeng.amlogic.com@kernel.org>,
	Gao Xiang <xiang@kernel.org>, Chao Yu <yuchao0@huawei.com>,
	Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, Tao Zeng <tao.zeng@amlogic.com>
Subject: Re: [PATCH] erofs: support external crypto for decompression
Message-ID: <202406070429.UJRJ6zGg-lkp@intel.com>
References: <20240606-erofs-decompression-v1-1-ec5f31396e04@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-erofs-decompression-v1-1-ec5f31396e04@amlogic.com>

Hi Tao,

kernel test robot noticed the following build errors:

[auto build test ERROR on ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f]

url:    https://github.com/intel-lab-lkp/linux/commits/Tao-Zeng-via-B4-Relay/erofs-support-external-crypto-for-decompression/20240606-155702
base:   ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f
patch link:    https://lore.kernel.org/r/20240606-erofs-decompression-v1-1-ec5f31396e04%40amlogic.com
patch subject: [PATCH] erofs: support external crypto for decompression
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20240607/202406070429.UJRJ6zGg-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406070429.UJRJ6zGg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406070429.UJRJ6zGg-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from fs/erofs/decompressor.c:6:
>> fs/erofs/compress.h:120:1: error: expected identifier or '(' before '{' token
     120 | {
         | ^
>> fs/erofs/compress.h:116:19: warning: 'z_erofs_load_crypto_config' declared 'static' but never defined [-Wunused-function]
     116 | static inline int z_erofs_load_crypto_config(struct super_block *sb,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +120 fs/erofs/compress.h

   115	
 > 116	static inline int z_erofs_load_crypto_config(struct super_block *sb,
   117						     struct erofs_super_block *dsb,
   118						     void *data,
   119						     int size);
 > 120	{
   121		if (crypto) {
   122			erofs_err(sb, "crypto algorithm isn't enabled");
   123			return -EINVAL;
   124		}
   125		return 0;
   126	}
   127	#endif
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

