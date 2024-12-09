Return-Path: <linux-kernel+bounces-437528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792109E9468
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0832282F94
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530F0228C83;
	Mon,  9 Dec 2024 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxDl/38c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256BF223703
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747854; cv=none; b=d2FtD+1wJMLStjwEYEKWFrJr7VQdqUSzx28GQawu1rItY4wjciPPfEmSwvCjC9H/aQDdI2ylm6+65hQg/oPuAm49x0v4+nw2gUASu32wqE85yme09+dhEYVeG4O7jRTi2i6wuNkJVG0ffCFKuxLWazMaUbAP1Z+aoYpTjPetmGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747854; c=relaxed/simple;
	bh=LYTEcPL033S5OYdOqoOU0GJya+KGHL3PTqelirKDtPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tD1q5FpeGiPNog+0TECv0dhLbtYD4dQfvQU1EWpFYlnvvvMFdMingOw0aqRhU4y9wkKrIWDCE1OO+8QTlq9ks8+Uef72zHuE9VG0Al1aVSdEa7bE5kVXjkJqlXdtu85rdinpF33i/2jZu1kMEyDhISQONwoXPn1Z24KR7HpmhWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxDl/38c; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733747852; x=1765283852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LYTEcPL033S5OYdOqoOU0GJya+KGHL3PTqelirKDtPI=;
  b=bxDl/38cQg5oO3lVwtLSJEiJwBwjSu215mjMHx923PTsEQBhgIusnuFJ
   EcgTaDbhe7KcBgbLzt1Ue2As6ZL4cBPDW9uVh+0tC3pAgZmLTQkr3vAg0
   u5eVe6/xTyY+qksQKQxCl/zzF4FMzTpNupHjXPKgIdZ1Ld2VxLfez+kTe
   N4F6d6Z8jQv7nAKW9HiONlc0OwyghnN0amwO2a3HA3JabUu62H59xINso
   7FH4pKq83RdriL9I+RxOkxzpXpqRVsvkvl9Un2uU7bYyGBatPtNMfbXpU
   1n4g1NgD0PZV6HgbbHvzaKw04uLq33qVmS3p35usabWcPLMTD2wRXIh+f
   Q==;
X-CSE-ConnectionGUID: z6vTbszCSSiUrwGu0/me7w==
X-CSE-MsgGUID: FuuFU36TRvWOX2+frvUPBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33954476"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="33954476"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 04:37:31 -0800
X-CSE-ConnectionGUID: gDggGBkFT2aWFsMGEIkWng==
X-CSE-MsgGUID: OEqzAqrNRvSllQHKzND+cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="95260217"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 09 Dec 2024 04:37:29 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKd0w-0004Jz-22;
	Mon, 09 Dec 2024 12:37:26 +0000
Date: Mon, 9 Dec 2024 20:36:27 +0800
From: kernel test robot <lkp@intel.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Kees Cook <kees@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/execmem: Make ARCH_WANTS_EXECMEM_LATE depend on
 EXECMEM
Message-ID: <202412092048.tTzJ5szH-lkp@intel.com>
References: <20241209031251.515903-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209031251.515903-1-anshuman.khandual@arm.com>

Hi Anshuman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/mm-execmem-Make-ARCH_WANTS_EXECMEM_LATE-depend-on-EXECMEM/20241209-111533
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241209031251.515903-1-anshuman.khandual%40arm.com
patch subject: [PATCH] mm/execmem: Make ARCH_WANTS_EXECMEM_LATE depend on EXECMEM
config: arm64-kismet-CONFIG_ARCH_WANTS_EXECMEM_LATE-CONFIG_ARM64-0-0 (https://download.01.org/0day-ci/archive/20241209/202412092048.tTzJ5szH-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20241209/202412092048.tTzJ5szH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412092048.tTzJ5szH-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for ARCH_WANTS_EXECMEM_LATE when selected by ARM64
   WARNING: unmet direct dependencies detected for ARCH_WANTS_EXECMEM_LATE
     Depends on [n]: EXECMEM [=n]
     Selected by [y]:
     - ARM64 [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

