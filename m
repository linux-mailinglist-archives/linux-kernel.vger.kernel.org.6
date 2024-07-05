Return-Path: <linux-kernel+bounces-242650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50B5928AD9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022621C21A3E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075CC16C44C;
	Fri,  5 Jul 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9JWMfvh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA0516B38E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720190634; cv=none; b=XaWk8N2WAbT7+kX8kcvnNKofLiKhqtOWYoNhoA6f354OYXRD7c8LuAQaZvrlzLZ0vpXIqMPockCd+Nh3eyj5PLyXICRYQp/T/I7HHCp6ykYlCHaFt4D1ZoWW+6GvXtJyt6z0XmOjUd1PrCfIztQg8Agu5QgZGwj8gvtj20CUIxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720190634; c=relaxed/simple;
	bh=Of10I6V3cy+13mCMby+nQ3t5SmQkycNDuZn2xQ+CDHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kl+j+sCy8biUO4cvxxBUqeFV0DuMDT2DwkENb6152JbI7qJa4sJpYVUVFCWZ9mjnkOgsaQfOigkF397vljdwFO4o0nWN7Fb1xNCaMHdF7qQCHQarmkYBIVL3nwM0ti7ZFLRzMHG61dMHX7Zv88URMpn8Cc+uefSuO/2AoUFGO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9JWMfvh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720190633; x=1751726633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Of10I6V3cy+13mCMby+nQ3t5SmQkycNDuZn2xQ+CDHo=;
  b=n9JWMfvhs9/3KlRF+uuKvUganM6b//N3pVsc4tN1joV2+OowMYApe5Fr
   64r2tmlNbOxoxJ0mDTfrtDHO/k/QAy4WCsqlBMwLYBBspdi1xlbMRiqig
   knkwYkrQ7TbqDUsjwc2qDeKTBmetdQFAA62xI26O804CyCRsTK+uzXdUv
   Y0S4eLVAhEQX3U4i9u+HjnB7XYVYWa4Hw1ZAxBJPvLY6kEUggs3dQm5Rg
   UwDt78enRbpTYNjit5u/yTleAsBG/nygWQv7MvYpfRjj6TJ2wFbMwhsy6
   gmLnfWr977srupNvVTgwVlz1AIxnpw6uh0Q2i/BH7ueB2zVCYnZjbKT9O
   Q==;
X-CSE-ConnectionGUID: czmmJZ/vT/iQh2GjO6v8Gg==
X-CSE-MsgGUID: sqZJn5k9SMe0bI0/D+Rpuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17592020"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="17592020"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 07:43:52 -0700
X-CSE-ConnectionGUID: YJnbjEkGRbiLkIfAna+9Qw==
X-CSE-MsgGUID: OiAl/KnhS2WNKmYt1rvYMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="46835266"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 05 Jul 2024 07:43:49 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPkA6-000SUQ-26;
	Fri, 05 Jul 2024 14:43:46 +0000
Date: Fri, 5 Jul 2024 22:43:41 +0800
From: kernel test robot <lkp@intel.com>
To: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, minchan@kernel.org,
	willy@infradead.org, senozhatsky@chromium.org, david@redhat.com,
	42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Alex Shi <alexs@kernel.org>
Subject: Re: [PATCH v2 17/20] mm/zsmalloc: convert get/set_first_obj_offset()
 to take zpdesc
Message-ID: <202407052102.qbT7nLMK-lkp@intel.com>
References: <20240703040613.681396-18-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703040613.681396-18-alexs@kernel.org>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/alexs-kernel-org/mm-zsmalloc-add-zpdesc-memory-descriptor-for-zswap-zpool/20240703-182314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240703040613.681396-18-alexs%40kernel.org
patch subject: [PATCH v2 17/20] mm/zsmalloc: convert get/set_first_obj_offset() to take zpdesc
config: i386-randconfig-002-20240705 (https://download.01.org/0day-ci/archive/20240705/202407052102.qbT7nLMK-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240705/202407052102.qbT7nLMK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407052102.qbT7nLMK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/zsmalloc.c:471:12: warning: function 'is_first_zpdesc' is not needed and will not be emitted [-Wunneeded-internal-declaration]
     471 | static int is_first_zpdesc(struct zpdesc *zpdesc)
         |            ^~~~~~~~~~~~~~~
   1 warning generated.


vim +/is_first_zpdesc +471 mm/zsmalloc.c

61989a80fb3ac9 drivers/staging/zsmalloc/zsmalloc-main.c Nitin Gupta 2012-01-09  470  
3844a7927dcecc mm/zsmalloc.c                            Alex Shi    2024-07-03 @471  static int is_first_zpdesc(struct zpdesc *zpdesc)
3844a7927dcecc mm/zsmalloc.c                            Alex Shi    2024-07-03  472  {
3844a7927dcecc mm/zsmalloc.c                            Alex Shi    2024-07-03  473  	return PagePrivate(zpdesc_page(zpdesc));
3844a7927dcecc mm/zsmalloc.c                            Alex Shi    2024-07-03  474  }
3844a7927dcecc mm/zsmalloc.c                            Alex Shi    2024-07-03  475  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

