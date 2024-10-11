Return-Path: <linux-kernel+bounces-360503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 430F3999BC5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1DF2863A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7491F9423;
	Fri, 11 Oct 2024 04:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYn7Feux"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E331922C4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621779; cv=none; b=iIi/8cTP6FFU+lUmIRMuYRXYKr4Bs3JktEB0W7isKwJZ9qhM6hcpvhHXqTL9x/eUhVYBcnkhwnoSoUr5TJpK6ig97kU2DYZ7cQh48XrecCVNkvuPswx5mEiwJ/JuAl4tEruNlxseHaTLmOX0SbsNJPqV4psJuA+2XZhvK5L5L70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621779; c=relaxed/simple;
	bh=vZgBm1UOByToPUPpkRaufy5pOITRdo6zBLwR51v8HUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lh4DEC/8V4EBASGwlbN7V6S/p9nkcO4juX8Ar375G9hSGnAZ7HICY8s+TXthwdpbmhr7XyrnOI4C9Ibel7HbfztWKkTByFE4ZTp3uQZyrWqYu6THosZ+chAWB8dspYdCAviIGs+eonmFxCCBWki6geS4eYzx1CyCtHoMnZDPGvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYn7Feux; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728621778; x=1760157778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vZgBm1UOByToPUPpkRaufy5pOITRdo6zBLwR51v8HUA=;
  b=lYn7Feux1m3rWoMW5DjS3P/IIztN3Kce5i/6pQNuKJVYDB0wj1nfvTcY
   5QczOmCsLc2oGp92sMVN+Kfk3St3vsTJbYKHFhzKZP/brmz6MDdOzVX7I
   0HgmzyWiFDIiGFtOGGymuW+gYBU+hr4vUmEkJwVkmEon+dm/DcEaOdG0L
   ac+XnTL8Dc+We4VVigqDLEldOP7SKkML7DzsDXYzV+9jEs40zxuuCthce
   CTkxSUYTQpCvciLBDTUwSf71JQvfxrJHMSgf02TqQH1IWPq0j1ylpu0z4
   4M2k1dBqO+KptM5TjAQMWfZsG+lHL2VhIwN+SoMlhONhWSZw1FAWP/Eur
   g==;
X-CSE-ConnectionGUID: hvzq1u2IRJ+NC17ieAjwiw==
X-CSE-MsgGUID: c7cJRh/0TxKEcp78Oi3IGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="27959190"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="27959190"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 21:42:58 -0700
X-CSE-ConnectionGUID: KJglW9e3T0WVrSBrbjM5uw==
X-CSE-MsgGUID: uCRysRmrTnaJG5jbWpYrcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="76712342"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Oct 2024 21:42:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sz7UL-000Bob-0F;
	Fri, 11 Oct 2024 04:42:53 +0000
Date: Fri, 11 Oct 2024 12:42:34 +0800
From: kernel test robot <lkp@intel.com>
To: Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH 2/4] mm/sparse-vmemmap: set pte_init when vmemmap is
 created
Message-ID: <202410111213.dfJ08626-lkp@intel.com>
References: <20241010035048.3422527-3-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010035048.3422527-3-maobibo@loongson.cn>

Hi Bibo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 87d6aab2389e5ce0197d8257d5f8ee965a67c4cd]

url:    https://github.com/intel-lab-lkp/linux/commits/Bibo-Mao/LoongArch-Set-pte-entry-with-PAGE_GLOBAL-for-kernel-space/20241010-115120
base:   87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
patch link:    https://lore.kernel.org/r/20241010035048.3422527-3-maobibo%40loongson.cn
patch subject: [PATCH 2/4] mm/sparse-vmemmap: set pte_init when vmemmap is created
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20241011/202410111213.dfJ08626-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241011/202410111213.dfJ08626-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410111213.dfJ08626-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/sparse-vmemmap.c:187:23: warning: no previous prototype for 'kernel_pte_init' [-Wmissing-prototypes]
     187 | void __weak __meminit kernel_pte_init(void *addr)
         |                       ^~~~~~~~~~~~~~~


vim +/kernel_pte_init +187 mm/sparse-vmemmap.c

   186	
 > 187	void __weak __meminit kernel_pte_init(void *addr)
   188	{
   189	}
   190	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

