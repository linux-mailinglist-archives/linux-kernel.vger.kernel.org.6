Return-Path: <linux-kernel+bounces-428335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA419E0D11
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1394828298B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DB71DED6F;
	Mon,  2 Dec 2024 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyaKlVhg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F179C1DED6C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733171768; cv=none; b=fAQGOROU50bjKnnORkfkjLg4w3Aeku01dtYK8SMZ9TFoQko5lNMgT/P03TNNeA8caLAA1w2JaR2S3h1WR26O+96v0kmE9c7rOKgQNnDCS3A9LkwH8PlOIEUtDOP15Vh7msJWANyqRMwr2SfRf242Uc0+8+PRH2uJn5Q2N0gpXUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733171768; c=relaxed/simple;
	bh=AFKSCUypHwXVOLHrBjU96IpLAARRE/zEft7It6LMgo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfaAUrINqMYN98doQ+sq/VmrlmbyQzdMddqnHdwCgXJLC+ImRRinPSH1V1iQKzMC1eLt0Unmke7mo948+jRpINYS+vqXe2LfbOF/+CnpD8CsTAiDCEq3GY9QQlicC4t2DceoIr1ckgHve8qysSM08tIrLR8FKKzm0HQgEa+uqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyaKlVhg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733171766; x=1764707766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AFKSCUypHwXVOLHrBjU96IpLAARRE/zEft7It6LMgo8=;
  b=hyaKlVhgZwBho7syv/e9O8objNMFY7glCIbYR2fcMETmQQgEzzuHS48k
   W0HrqMo8nr0v4dflesM3evyjwi489JWOp5kb6D9KH9uFspG/gJ9z9wULm
   cgymOARC1vuhnxYfsdn8T2wjrw5LYfWAgb27Kafz9gdc3o8PBWDx0EOVW
   RQB/Thu+04v9loktBp1y5dJ1W83vlkMDLhGJqcmOl2xL30DWg7zxZXzsK
   bVN1TwwGB97JEG+eos386QRTSA2VNDrMQOFdpn6IRmymApK1lTUGZBv8M
   DdUqU18Qiw4fVzvA5R2HRUnDHZkwqY+MktAoxlGVbq13Bmoe6NxUlY9g6
   w==;
X-CSE-ConnectionGUID: +NcKSxNwT1iW9eUw/EwPMw==
X-CSE-MsgGUID: hK/5m4P0TN24Q/r/sfBLEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="20950353"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="20950353"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 12:36:05 -0800
X-CSE-ConnectionGUID: MKGlhwU7Q++lln8d+JSFTw==
X-CSE-MsgGUID: C5+voUgqTYiyoJnVoWKXDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="130679051"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 02 Dec 2024 12:36:03 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tID8x-0002s5-1r;
	Mon, 02 Dec 2024 20:35:49 +0000
Date: Tue, 3 Dec 2024 04:34:33 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] intel_th: avoid using deprecated page->mapping, index
 fields
Message-ID: <202412030410.qX3ejEnD-lkp@intel.com>
References: <20241202122127.51313-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202122127.51313-1-lorenzo.stoakes@oracle.com>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.13-rc1 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/intel_th-avoid-using-deprecated-page-mapping-index-fields/20241202-202330
base:   linus/master
patch link:    https://lore.kernel.org/r/20241202122127.51313-1-lorenzo.stoakes%40oracle.com
patch subject: [PATCH] intel_th: avoid using deprecated page->mapping, index fields
config: arm-randconfig-004-20241202 (https://download.01.org/0day-ci/archive/20241203/202412030410.qX3ejEnD-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030410.qX3ejEnD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030410.qX3ejEnD-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "vmf_insert_mixed" [drivers/hwtracing/intel_th/intel_th_msu.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

