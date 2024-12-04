Return-Path: <linux-kernel+bounces-432109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F1D9E454D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4D3168277
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 20:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76A71F03DD;
	Wed,  4 Dec 2024 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/w27WJA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9891C3C04
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 20:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733342996; cv=none; b=X5vPGUBBBQDXgivNG45rU9jqGXNzedKKchnfUsS+FPwIZP3f4z7prCVWkDh1two/n2HqcGQs2coITsh+wAsVUFPViJ319N2ZoifRJ8O70vIzEp1ZoRme1PDRyQpwVEfbJfKVMtQBxFrxF0+JWWkcZ+qkGpwQpllMfNevjznmpt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733342996; c=relaxed/simple;
	bh=yF6HQtLwTtRXYBnNwEC0Rc8WBNM/f0oVnV8EAkCZNuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULesV/0U9P5gYcYDbllc/KgEXKh7qF1niPYWM5vIpdNHPkyI+8Or7ohoUoV1rpmSDroqvmp+BCi8u82phVPJ6Y42OqXeOD9q2w3Lj6Yl6tae0vboo8apg+n1Tmei5DWWn5gydvDyCZthUm3vOSUIq7jgA3U3kwlPI3eaZGwvtwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/w27WJA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733342993; x=1764878993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yF6HQtLwTtRXYBnNwEC0Rc8WBNM/f0oVnV8EAkCZNuc=;
  b=O/w27WJArHQedx+OwqLondRQ/mXCOn3Rf/z5Dj14Fpx7rN7chr9f5JnW
   8x8vOK12UmhwcsfGrUjz/qpEi8UCBrPnF0uYa+MGTQjX0yp9ePNZPgXf+
   xxHrLMwTWU4GrbXP0ZRpf8aUvKG5uIMdmEOV3pN9oHmfSYx/Dv5kPpAxN
   Wok4ZMZGJ5Ur5LSgiS6iqwR5vuzPLoDh8wASVxAtvpgyYD2HkbefUIht5
   40jWz+Sf1/cBvXEaZLza/fN1YEhhnqviGyLcaz1w0Jv9eu1d3pzIM4AA7
   zOjUnyXppo6iQr7KEfw56OdM6qd3xFDm87gJB+qgrfTRdrnegl9JYkQ4Q
   g==;
X-CSE-ConnectionGUID: ENLJGhepQmyW5Os+4qoAdA==
X-CSE-MsgGUID: aeBWdo0bTrecC5ScR+7q7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="45007400"
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="45007400"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 12:09:53 -0800
X-CSE-ConnectionGUID: hjKRbg0iTvuqQACuITIkjA==
X-CSE-MsgGUID: pgsX1FHaTcq981ieRnU2wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,208,1728975600"; 
   d="scan'208";a="124686798"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 04 Dec 2024 12:09:49 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIvgw-0003Rr-0U;
	Wed, 04 Dec 2024 20:09:46 +0000
Date: Thu, 5 Dec 2024 04:09:12 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 4/4] powerpc/static_call: Implement inline static calls
Message-ID: <202412050317.rQGggDIb-lkp@intel.com>
References: <3dbd0b2ba577c942729235d0211d04a406653d81.1733245362.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dbd0b2ba577c942729235d0211d04a406653d81.1733245362.git.christophe.leroy@csgroup.eu>

Hi Christophe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on powerpc/next]
[also build test WARNING on powerpc/fixes linus/master v6.13-rc1 next-20241204]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/static_call_inline-Provide-trampoline-address-when-updating-sites/20241204-120612
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/3dbd0b2ba577c942729235d0211d04a406653d81.1733245362.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH v4 4/4] powerpc/static_call: Implement inline static calls
config: powerpc-randconfig-r062-20241204 (https://download.01.org/0day-ci/archive/20241205/202412050317.rQGggDIb-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241205/202412050317.rQGggDIb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412050317.rQGggDIb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/powerpc/platforms/powermac/bootx_init.c:18:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   1 warning generated.
>> arch/powerpc/platforms/powermac/bootx_init.o: warning: objtool: bootx_init+0x28: unannotated intra-function call

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

