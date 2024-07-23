Return-Path: <linux-kernel+bounces-260456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AD993A98F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 00:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CE71F22B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 22:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AA21494A4;
	Tue, 23 Jul 2024 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDruxlsY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8C14830D;
	Tue, 23 Jul 2024 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721775542; cv=none; b=Cp+hExzP6cIJ8dZZNXxnXu0WCxXxzqJaAATnDYNTk46Gxvtit7dRfVR165EQTaBgIP49EYtkmWqfF8u4OsrgewzrHY61SELGSiVw6p7tnYJ6/Hi8UtKHeAb2rDzRlyZy1MuSkO4IyxqQNa8lUhdHnXkUBccZzLEMyxAKkEwwM1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721775542; c=relaxed/simple;
	bh=qLz5MZwWJR9sFS+bnHNameeV1+9Wjxm+TbXv2evNJyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jeb9D/YCrwEBxup7nG30yPq5ggCpiAhvGkTtP/S1RiuwLxWrlzN8yLzs4vpnvYooaVlhno1DAIUvK3Y4J+Utva3Gi5I8maPt0wBJawDebhfzUbCOCiCzj/fBEIDdhCOiPJ41tJotBvRTjtOow+yh/9cj6KGZnoBT8zWESYo7EvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDruxlsY; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721775541; x=1753311541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qLz5MZwWJR9sFS+bnHNameeV1+9Wjxm+TbXv2evNJyI=;
  b=GDruxlsYei4FUHfcPS433hILb2w+ZxV/nry8NDrtqPUn/kh9CjAv36cT
   FdNkuQPosKKJV7Bg87N9XtmKojp6gj4giKtbZU+E+KfMzUSE0UDGTo3du
   ow+O0gbxiaD5R+6bbAd+9b+9Bw6XKMcC13ybxG4lKikmpjxjh8V8Yfp6u
   eWzZ0sr32ioasMyJQ+6HyTMQVAEYhv4l2BSduRTy6f9zJTKdGNLLgMv0R
   Qrf+M56jqtrXbY+muMCzl+MFI6XSCA5YhEiPBIgBVEALxxDLOn69qIPkb
   5T74CYhLMGIo2E/6/QIdie+W+lZQW58x8hYIo9hDVWDlZvhZtIbxMyCS1
   g==;
X-CSE-ConnectionGUID: pG7ClxGdR2eFpnnMfnlYkA==
X-CSE-MsgGUID: ItVhkpslQLKJPme9/7DKtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19234167"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="19234167"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 15:59:01 -0700
X-CSE-ConnectionGUID: ZbtqDCKlQLqSvP5SZzyLiQ==
X-CSE-MsgGUID: apZ8yC1uQDqr5FHhv+hN7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; 
   d="scan'208";a="52413972"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 23 Jul 2024 15:58:55 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWOT6-000mQz-1U;
	Tue, 23 Jul 2024 22:58:52 +0000
Date: Wed, 24 Jul 2024 06:58:04 +0800
From: kernel test robot <lkp@intel.com>
To: Vignesh Balasubramanian <vigbalas@amd.com>,
	linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mpe@ellerman.id.au, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com, ebiederm@xmission.com,
	keescook@chromium.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, bpetkov@amd.com,
	jinisusan.george@amd.com, matz@suse.de, binutils@sourceware.org,
	jhb@freebsd.org, felix.willgerodt@intel.com, tglx@linutronix.de,
	Vignesh Balasubramanian <vigbalas@amd.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 1/1] x86/elf: Add a new .note section containing
 xfeatures buffer layout info to x86 core files
Message-ID: <202407240632.KnGdRoYR-lkp@intel.com>
References: <20240723090454.8241-2-vigbalas@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723090454.8241-2-vigbalas@amd.com>

Hi Vignesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/execve]
[also build test ERROR on tip/x86/core kees/for-next/pstore kees/for-next/kspp linus/master v6.10 next-20240723]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vignesh-Balasubramanian/x86-elf-Add-a-new-note-section-containing-xfeatures-buffer-layout-info-to-x86-core-files/20240723-170946
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
patch link:    https://lore.kernel.org/r/20240723090454.8241-2-vigbalas%40amd.com
patch subject: [PATCH v4 1/1] x86/elf: Add a new .note section containing xfeatures buffer layout info to x86 core files
config: x86_64-buildonly-randconfig-003-20240724 (https://download.01.org/0day-ci/archive/20240724/202407240632.KnGdRoYR-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407240632.KnGdRoYR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407240632.KnGdRoYR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/asm/elf.h:6:9: error: unknown type name 'u32'
       6 |         u32 type;
         |         ^~~
   ./usr/include/asm/elf.h:7:9: error: unknown type name 'u32'
       7 |         u32 size;
         |         ^~~
   ./usr/include/asm/elf.h:8:9: error: unknown type name 'u32'
       8 |         u32 offset;
         |         ^~~
   ./usr/include/asm/elf.h:9:9: error: unknown type name 'u32'
       9 |         u32 flags;
         |         ^~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

