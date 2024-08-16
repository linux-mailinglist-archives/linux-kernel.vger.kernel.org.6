Return-Path: <linux-kernel+bounces-289569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFEE9547B3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904BB1F21820
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4711B86ED;
	Fri, 16 Aug 2024 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3tOl45U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112161B0122
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723806779; cv=none; b=fCxYCjMw3tJWY+UjcqH1aDWuJ+2qt/RTcUo6CrSMy5Jc7yI+WQD++OHDR70AkF7deiocrWcrqogkZ2ADgAAWdu0ruauo1dCc+BLeNX+X7YBCZvZbRJBwZuMv74wB8Ew8Ekbdp70Vn6Zx9c7pK83D3NOpp/2n8DtXFnjwQH1pskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723806779; c=relaxed/simple;
	bh=D3wfA7SQItWr4+Uh0GYXu1SzL5q3oh6L5Pk0a4zzf5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ug6LtFtSjY+ioE22RmGBu+Z2O7+FwjXhnCA6eFVZbQFYTpWPZETt9mhI86v16YL5DoFOpWMbO48o17w2BEKTRbQ0edbDE0XiZ9yn45BOXG88Fzgf9f0THCyh+a0X9txFKBf4hLKvOZJ4QJmCcwhYtlEmUrEsQ+2OuA5Ktyj4Vbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3tOl45U; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723806777; x=1755342777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D3wfA7SQItWr4+Uh0GYXu1SzL5q3oh6L5Pk0a4zzf5c=;
  b=W3tOl45U/l8EEe2Xa5NvlREA1znmE0LrlZIPeLVPneOIh1bIurL8MWfU
   GDbHKah1wNadhOu0tE8LbUuCYH7hNHocyncZWMzqYJxA+3HEt89xG9eAm
   DXNClsUptcUawQBRpkST4B1p19FkeZE9OWVTri/4OJXKEcyTYZQY3rpdX
   bZtbk8ErWFR6iatE7xCu1aZXaDs0DsESB6C4ZQpkLDFHTSgmy4QN6VrWK
   QE1ogDYdg91xFCVG0sLgG46gPmpJygWxtsdMrb1/CGQV2I27oN5K/9HJw
   9U23vxoWWCual+2NMOoDtMYpiAL4vgiDjb1RSa2ZE2HdhmQMClqfZDon6
   w==;
X-CSE-ConnectionGUID: rJq2i90mTVCzui+svMLCrw==
X-CSE-MsgGUID: iNae+mnKSoO82i7xz04LeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22068961"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22068961"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 04:12:56 -0700
X-CSE-ConnectionGUID: te6maNNRTm+v0c2KtFzTvg==
X-CSE-MsgGUID: vIs1qiDeT3a7SKyZKdlbxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90420797"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 Aug 2024 04:12:50 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seusy-0006Lu-32;
	Fri, 16 Aug 2024 11:12:48 +0000
Date: Fri, 16 Aug 2024 19:12:09 +0800
From: kernel test robot <lkp@intel.com>
To: Florian Rommel <mail@florommel.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Thompson <daniel.thompson@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Douglas Anderson <dianders@chromium.org>,
	Lorena Kretzschmar <qy15sije@cip.cs.fau.de>,
	Stefan Saecherl <stefan.saecherl@fau.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kgdb-bugreport@lists.sourceforge.net, x86@kernel.org,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Florian Rommel <mail@florommel.de>
Subject: Re: [PATCH WIP] x86/kgdb: trampolines for shadowed instructions
Message-ID: <202408162013.3Nz53QCv-lkp@intel.com>
References: <20240814085141.171564-1-mail@florommel.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814085141.171564-1-mail@florommel.de>

Hi Florian,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/master]
[also build test ERROR on tip/x86/core linus/master v6.11-rc3 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Florian-Rommel/x86-kgdb-trampolines-for-shadowed-instructions/20240814-230936
base:   tip/master
patch link:    https://lore.kernel.org/r/20240814085141.171564-1-mail%40florommel.de
patch subject: [PATCH WIP] x86/kgdb: trampolines for shadowed instructions
config: x86_64-buildonly-randconfig-004-20240816 (https://download.01.org/0day-ci/archive/20240816/202408162013.3Nz53QCv-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408162013.3Nz53QCv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408162013.3Nz53QCv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: execmem_alloc
   >>> referenced by usercopy_64.c
   >>>               vmlinux.o:(kgdb_arch_init)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

