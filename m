Return-Path: <linux-kernel+bounces-436729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073E89E8A09
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B391885409
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0751714B06A;
	Mon,  9 Dec 2024 03:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYtM1Vf/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F17155342
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 03:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733716508; cv=none; b=msjNSZ27JAShH+q4uQU1FLomRkjHVfhdJzvEWWARHMQNtFv8SILyrkkQyIR5G2lnO/rcS76hsmjm+PPbA+H8j6RgLOVBwJVBRjRphsULCFno5/m+3ExtayZqXUTyYIPxW0kH6kkMpxPiDAm6IdUAa1kLsl3zo0Ye1D4OwY1Zf/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733716508; c=relaxed/simple;
	bh=9qtbkWtmTNib6vg5NaPs1DOT0uD0ZQeGIONfk3hcFRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRSibsoKhQ1h5mq/Ah3IexLjAOicZVHyJxHaI6xrCizhoNIFReWuAHfCzUHAS2GfMdF3FzVsnB298Ps2xL++8Y+V7Jov6JYjgrEc/d+pKV83G8CAR6ZRMnB362uHefbWWYBS3yd6ZpdrGgWADOJM081oRKO9oED+IcfIcdR7AJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYtM1Vf/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733716507; x=1765252507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9qtbkWtmTNib6vg5NaPs1DOT0uD0ZQeGIONfk3hcFRs=;
  b=DYtM1Vf/Y418dBhVNDjNZkyNggJS2NDmeqIftL1joBCLNN6eXRV1Z1CZ
   ZrayPV54Ve0eXUD6SOgztiMLHD7itJak4ydcNtzC5Zhy5RXDtTUtfpfxP
   HBb42b9FMNlDBbZWEBvYne2pp2LzQMu+QvXmfcRkszLDU7KZYo7W3d8YY
   PG8dKGL58CV5mrZ9uNJP9jNO+b+OSOe/krjCJlT6zU2u6JwY1TEmIf68O
   5Sae7CvXJrgFe4Y/pjOAcEwcJt3C5T7YMtYMvWqeHdMKnrodk/2JzdIXC
   7ZQY5Dn9ZRDYlZ+uGTR11oPJl7vt+7yuCmxOBTsi+j6EyizT+r+CXh6Ca
   g==;
X-CSE-ConnectionGUID: d0YIDTTlT9KdEd3SbR5epw==
X-CSE-MsgGUID: QFM4FtoGRBucfmVO9fuv0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34136219"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34136219"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 19:55:06 -0800
X-CSE-ConnectionGUID: 7P5bf6wHStCKJAYrTu4ktw==
X-CSE-MsgGUID: 24Gsn8bcSxOdCE/gX9qPKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="94753591"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 Dec 2024 19:55:04 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKUrM-0003lJ-2Y;
	Mon, 09 Dec 2024 03:55:00 +0000
Date: Mon, 9 Dec 2024 11:54:47 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	Isaac Manjarres <isaacmanjarres@google.com>,
	Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH] mm: perform all memfd seal checks in a single place
Message-ID: <202412070928.cx0iqU0C-lkp@intel.com>
References: <20241206212846.210835-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206212846.210835-1-lorenzo.stoakes@oracle.com>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-perform-all-memfd-seal-checks-in-a-single-place/20241207-053020
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241206212846.210835-1-lorenzo.stoakes%40oracle.com
patch subject: [PATCH] mm: perform all memfd seal checks in a single place
config: microblaze-allnoconfig (https://download.01.org/0day-ci/archive/20241207/202412070928.cx0iqU0C-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412070928.cx0iqU0C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412070928.cx0iqU0C-lkp@intel.com/

All errors (new ones prefixed by >>):

   microblaze-linux-ld: mm/mmap.o: in function `memfd_check_seals_mmap':
>> (.text+0x31c): multiple definition of `memfd_check_seals_mmap'; mm/gup.o:(.text+0x1324): first defined here
   microblaze-linux-ld: fs/fcntl.o: in function `memfd_check_seals_mmap':
   (.text+0x630): multiple definition of `memfd_check_seals_mmap'; mm/gup.o:(.text+0x1324): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

