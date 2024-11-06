Return-Path: <linux-kernel+bounces-398773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D339BF5DE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D586B2346E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AA1209697;
	Wed,  6 Nov 2024 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIOP0poM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88A9209F39
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919538; cv=none; b=UoFHW15sCRWd/U0euhoaTZKqsZq8hVzWaB8xPD9/Xkq7U9WVfSDThn8DU6OSXom8aX3EpZu2WWqYzeT+o11FduY1m0jUgcj1YaOBASPDuEDvJ/uFOB/vrdSWBgEQ1k+xeH15Ya8g//lxVC6riJGBGhGAribz68E3hAl3TTfrLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919538; c=relaxed/simple;
	bh=mu7nGzXKcBOqqGa1xFdsZ+PuIKkam6CKDL71+5R5+t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmcB03ExWi5EkhdEEHdNu1elOiyaFhjUvkCsOKdvDc+uqnWGIYT35A2H3nGJozG2GI3BKIPFrgVBHC+PHixhsi81PIUbDKjZkAIYKfSTsQj8mxDPAdR6niG85cpE+JPGoRNiK2QkM6HNFFn7MxR0Ysw4Gckf8VLrWUTI9dwWg5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIOP0poM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730919537; x=1762455537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mu7nGzXKcBOqqGa1xFdsZ+PuIKkam6CKDL71+5R5+t8=;
  b=TIOP0poM4TpJlFD3fv7LR5mIS3ArLZEuhd3pptN1eLkW1rhDYK9aqOtw
   suNIA9ukY8vh08DEtvKaAB7PVljpK18tJmcC/qPftjZUIGN/l99+Hv0p/
   AVm9X03Fnepj3fp2bbAdlVjSj1U2EuVF4imxmeY6WC2FOVnUB+62ACo8V
   20B4c8ggV85rDRF8pX6BxQq6FFc/RfOWMH6R0ubEvCkq5t2NCuwR/DM9z
   C1vE1LR7kkCkcU7fgwolrVIqQvlynMuziZbENKOYxoFMD/r+5OD07y9Iq
   rW1FcTlBvouu93CStEgy9OJWbsrXkOyYkEVo6335Zm71Dkgp2Qgp/dMUm
   Q==;
X-CSE-ConnectionGUID: 4zTedzJcTHukVFnz5KDRTg==
X-CSE-MsgGUID: uXBtazbmTz6IInBR6Wb72A==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30959496"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="30959496"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:58:55 -0800
X-CSE-ConnectionGUID: j+ZJxQADQsCmMJq69QPvGQ==
X-CSE-MsgGUID: erf9/nnVSEibuK/aGPaEeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89813516"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 06 Nov 2024 10:57:33 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8lDe-000pJa-1n;
	Wed, 06 Nov 2024 18:57:30 +0000
Date: Thu, 7 Nov 2024 02:56:31 +0800
From: kernel test robot <lkp@intel.com>
To: David Kaplan <david.kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/35] x86/bugs: Restructure spectre_v2_user mitigation
Message-ID: <202411070218.ge5HHTv1-lkp@intel.com>
References: <20241105215455.359471-14-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105215455.359471-14-david.kaplan@amd.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/master]
[also build test WARNING on linus/master v6.12-rc6 next-20241106]
[cannot apply to tip/smp/core tip/x86/core tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Kaplan/x86-bugs-Add-X86_BUG_SPECTRE_V2_USER/20241106-060512
base:   tip/master
patch link:    https://lore.kernel.org/r/20241105215455.359471-14-david.kaplan%40amd.com
patch subject: [PATCH v2 13/35] x86/bugs: Restructure spectre_v2_user mitigation
config: x86_64-randconfig-121-20241106 (https://download.01.org/0day-ci/archive/20241107/202411070218.ge5HHTv1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411070218.ge5HHTv1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411070218.ge5HHTv1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/x86/kernel/cpu/bugs.c:1337:32: sparse: sparse: symbol 'spectre_v2_cmd' was not declared. Should it be static?

vim +/spectre_v2_cmd +1337 arch/x86/kernel/cpu/bugs.c

  1336	
> 1337	enum spectre_v2_mitigation_cmd spectre_v2_cmd __ro_after_init = SPECTRE_V2_CMD_AUTO;
  1338	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

