Return-Path: <linux-kernel+bounces-536547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F570A48140
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563D319C25B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CBE2343C5;
	Thu, 27 Feb 2025 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K8efGPCj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2CE23313E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665809; cv=none; b=Fp17dlJvntD9BBttcOlYn/L1CNmAUnE//VxsRxPed9C1aNDuuaAk7tBMMVsY7zfMOgfBQCFXC9PAyirCeF7UN2eHXepbSZxL8077X1lrRITcTg83StcDmZvmMMOxtdoDwsRNTVOByDtmAuY3nOMy429V1ew1uU7ac9n74E3kuK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665809; c=relaxed/simple;
	bh=NSlGgDaQ6OTrGCsU4w8SbDFK25aIamxIlg7Tnk5mVsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE1rTJiVJjFrsGzKk/NXeG4qHaRWgNRSnRmVFQCqYzbD4BQ8d7LGgYe89wB1o6P2S3gxoqajSUzqP7OcmIGv4W3S/adezr3vbHPHcay+126lejysfbj/J75YNCLEBRTrPsybAJgrU1FWAfIuMb5sH0h1YzR4SxjY56K+VO0cWIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K8efGPCj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665808; x=1772201808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NSlGgDaQ6OTrGCsU4w8SbDFK25aIamxIlg7Tnk5mVsU=;
  b=K8efGPCjZpTwWrGkzn4UVS1BK4wJVHuItYPpeElWkfojiXwdpHTv7GCJ
   eHDJ0pzX9YqoNU449qjhMbl7lEwUsOx9QxsK9s5e3pSiKGMxBewpgCPc1
   QmTEO7HpKxUOuy/KydwErQFj7ewUI8ZbuGoYQsZgB5XuvtjTgskULHzL9
   J3IsCvsxetYNW+TP7FcnameocQrDt/wj/BNuL480MiWfAbQUwVLmiMpwI
   bHLJ/Vkuqa4W/CSdGlpSXYBt8/md8wiJJtZpUFSY7HXCmx7SA03xFFAZg
   r9psidS4hJgK8/6eflrL153nY+IGVo29cEr5Vdl0N+Q3Azh3ji8lWtY+M
   w==;
X-CSE-ConnectionGUID: ESgXHKruQTOx7+u05xXgjQ==
X-CSE-MsgGUID: KrHZBHYFTCexatlaRYQhyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40794901"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="40794901"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:16:47 -0800
X-CSE-ConnectionGUID: tuuZ2fsPQG6JM1/5Dk3Efg==
X-CSE-MsgGUID: zKSUO7C1R86uTKVnbJAegA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="121980714"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 27 Feb 2025 06:16:44 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnegq-000DT4-2n;
	Thu, 27 Feb 2025 14:16:40 +0000
Date: Thu, 27 Feb 2025 22:16:18 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ingo Molnar <mingo@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v2 01/11] percpu: Introduce percpu hot section
Message-ID: <202502272142.2EFoWquv-lkp@intel.com>
References: <20250226180531.1242429-2-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226180531.1242429-2-brgerst@gmail.com>

Hi Brian,

kernel test robot noticed the following build errors:

[auto build test ERROR on 79165720f31868d9a9f7e5a50a09d5fe510d1822]

url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Gerst/percpu-Introduce-percpu-hot-section/20250227-021212
base:   79165720f31868d9a9f7e5a50a09d5fe510d1822
patch link:    https://lore.kernel.org/r/20250226180531.1242429-2-brgerst%40gmail.com
patch subject: [PATCH v2 01/11] percpu: Introduce percpu hot section
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20250227/202502272142.2EFoWquv-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502272142.2EFoWquv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502272142.2EFoWquv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> s390x-linux-ld: cannot find CACLE_HOT_DATA: No such file or directory

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

