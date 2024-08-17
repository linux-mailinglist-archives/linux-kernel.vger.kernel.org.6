Return-Path: <linux-kernel+bounces-290522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39836955539
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 05:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CB22832B1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 03:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0045980BFC;
	Sat, 17 Aug 2024 03:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRIBoxfH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D572B78C98
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 03:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723865313; cv=none; b=baylQP0xyiqh5Ns4eRdNSdmQfqlaRlLyWUD1LcpXK9Fd4zuBUwCzK4HE0GaFtlDEgERH4I//6QQW3tHXgUyqlvsCPwxQmaJ5zQ9ZYlhBFE5BSVHB/uwra+i7tW081z2jSeJBJNQTFnu2NE3mqAUd6kVTTQyPtfs7XWAH53nw+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723865313; c=relaxed/simple;
	bh=JN9j8wh/xJ0TPyJMAzENOzMg/xpSR944Q4eFSDKDmhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgwzxuAVO4Dsv9/YeOajOVGw/pF0lN/wMogFjsKnIculpZKQfxMEOGrc3zAe+4vKY/cr5m9GV69OhDfUlF/0E2tOeuzGB6wXnQ7ZTjFGXUZge2H+OHFs8nXdNTfGi8h1hXdSY4zbmyjL+WFIyC6qNEcht/Ie/P/SK8AcnGEfKvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRIBoxfH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723865311; x=1755401311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JN9j8wh/xJ0TPyJMAzENOzMg/xpSR944Q4eFSDKDmhc=;
  b=VRIBoxfHZDtfCBUGiMBLMQUToTF8u2t/1AuPLhUBA41mIWYBAzRW4d/6
   z69BBKlcvTl6+LVHY3UIMAh1aPM4TT9Xj+oONhY16Q308HGw3m2b2NTBq
   2bNaAIwU9ABawWrm3BQM1rzb33tLn4p5Pg2su3KBNSggONYhXfe3mH2a1
   FnHGWuV0NUkR3bR3uJUabIXZdbRts/VSIPkgZTRrfIYGj9igyc2xw8Nbu
   GsgpCrNRC7YIFVr+2z4NU9D3qUiQA/WFIItweJw3rRNoJHB+GJ7i7Zd9o
   MErmAeaAbh08rkbzWxm5Z4Tq3JTLID+vnYKHeCdllylIOM0BM6XXu+lrG
   A==;
X-CSE-ConnectionGUID: FNbSWhmsQOK6fk4/IgjMXw==
X-CSE-MsgGUID: lyQT0t0yT/KfgO/IRSRc6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="21981307"
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="21981307"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 20:28:30 -0700
X-CSE-ConnectionGUID: 2n+tifZ0T2qcHMDmRYT1Pg==
X-CSE-MsgGUID: CTgirSt5Q/qqY1TIUh4iwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,153,1719903600"; 
   d="scan'208";a="59881996"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 16 Aug 2024 20:28:25 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfA74-00079K-2z;
	Sat, 17 Aug 2024 03:28:22 +0000
Date: Sat, 17 Aug 2024 11:28:05 +0800
From: kernel test robot <lkp@intel.com>
To: Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev,
	"Alexey Gladkov (Intel)" <legion@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Yuan Yao <yuan.yao@intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>, cho@microsoft.com,
	decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v3 04/10] x86/insn: Read and decode insn without crossing
 the page boundary
Message-ID: <202408171001.feB1A8FN-lkp@intel.com>
References: <9704da6a35d62932d464d33b39953fc5b2fd74ea.1723807851.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9704da6a35d62932d464d33b39953fc5b2fd74ea.1723807851.git.legion@kernel.org>

Hi Alexey,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on tip/master linus/master v6.11-rc3 next-20240816]
[cannot apply to tip/x86/tdx tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexey-Gladkov/x86-tdx-Split-MMIO-read-and-write-operations/20240816-222615
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/9704da6a35d62932d464d33b39953fc5b2fd74ea.1723807851.git.legion%40kernel.org
patch subject: [PATCH v3 04/10] x86/insn: Read and decode insn without crossing the page boundary
config: i386-buildonly-randconfig-001-20240817 (https://download.01.org/0day-ci/archive/20240817/202408171001.feB1A8FN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408171001.feB1A8FN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408171001.feB1A8FN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/lib/insn-eval.c:1690: warning: Function parameter or struct member 'insn' not described in 'insn_fetch_decode_from_user_common'
>> arch/x86/lib/insn-eval.c:1690: warning: Function parameter or struct member 'inatomic' not described in 'insn_fetch_decode_from_user_common'
>> arch/x86/lib/insn-eval.c:1690: warning: Excess function parameter 'buf' description in 'insn_fetch_decode_from_user_common'


vim +1690 arch/x86/lib/insn-eval.c

  1671	
  1672	/**
  1673	 * insn_fetch_decode_from_user_common() - Copy and decode instruction bytes
  1674	 *                                        from user-space memory
  1675	 * @buf:	Array to store the fetched instruction
  1676	 * @regs:	Structure with register values as seen when entering kernel mode
  1677	 * @inatomic	boolean flag whether function is used in atomic context
  1678	 *
  1679	 * Gets the linear address of the instruction and copies the instruction bytes
  1680	 * and decodes the instruction.
  1681	 *
  1682	 * Returns:
  1683	 *
  1684	 * - 0 on success.
  1685	 * - -EFAULT if the copy from userspace fails.
  1686	 * - -EINVAL if the linear address of the instruction could not be calculated.
  1687	 */
  1688	int insn_fetch_decode_from_user_common(struct insn *insn, struct pt_regs *regs,
  1689					bool inatomic)
> 1690	{

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

