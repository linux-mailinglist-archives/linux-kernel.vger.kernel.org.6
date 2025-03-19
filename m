Return-Path: <linux-kernel+bounces-567305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C077A68460
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 06:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2C73B9910
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B8924EF8A;
	Wed, 19 Mar 2025 05:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzCkTOKG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA824EA89
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742360835; cv=none; b=fML4tbkQ5DhwLhSB2XfyesGF0Pds1074nAJFpqbnrz1qsoo+5EwBwikNNR6Or75GKmokcEmgBdp0MuTz3pUNChHkAE2vHRzj5XfZDZIak/W13o25PuzOQH8r8AcDzmFhqKyo0qRe8Jk19Cp4VBSWcumB9VE3K8ELSa2ilIk0CZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742360835; c=relaxed/simple;
	bh=/pKlRpzrFMOJFvWEfkuVM7VOXk4tiC90+0XLUButK0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pQf2+00lxCeDkytjQ3jFiimGULiK9ksDp/V8wiBTJuSCxv1bZiusCMbtO273+gY4qZQD1uUKmoSvhj35Snn85ysrRlKRXsqkbmjSbNBEj1p6mvXxzRErGG6owxK0Mcfv3V7r6XIWeravxUeUqqwXBPYvobU1tk5JTNvzoMp+Dqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzCkTOKG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742360834; x=1773896834;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/pKlRpzrFMOJFvWEfkuVM7VOXk4tiC90+0XLUButK0g=;
  b=UzCkTOKGqmjNu/hhsEapiSKRXbke3WKpP0s3BrAKkWXjWqwpCUTcBtsc
   nb7BzpxFZaf+iy79sJQFopEFA3gWWMSuMVKyTXRbyi3RQiyDXuKZKLXZr
   gK6eyGfPIKt0vneTkP8ClUe4OnAgT6sNj05lDx1E4ThcK/hKIWR75KZ6u
   8mVrp+Nx8WKO8B2ljzeMNPNl0Cyl6WuGqYZYBXBc4sjxGeGMASbIziZVj
   ZUGcvp1RwRBgYgHG54BPNE9+HO20WwwT5VFCsZhBKil122rQstRRcdRJT
   fIvoWfscp2TM1xJVRExCOgxQwmgRXPcoEpdd+RKvIR6bUdxmSSDQJV2mu
   Q==;
X-CSE-ConnectionGUID: j5AoCbTlRYqUQB5ot5NKCA==
X-CSE-MsgGUID: gMXqOFw/QaGvBtHyJbZirw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54165554"
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="54165554"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 22:07:11 -0700
X-CSE-ConnectionGUID: B6fQhWDmQPyhLOh7tmtBNA==
X-CSE-MsgGUID: +vD10cAgRBOBeqZgl7ds8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,258,1736841600"; 
   d="scan'208";a="159614974"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 18 Mar 2025 22:07:10 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuldy-000ENC-2i;
	Wed, 19 Mar 2025 05:07:06 +0000
Date: Wed, 19 Mar 2025 13:06:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: arch/arm64/kernel/entry-ftrace.S:333: Error: undefined symbol
 FREGS_SIZE used as an immediate value
Message-ID: <202503191223.RCdQEebt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   81e4f8d68c66da301bb881862735bd74c6241a19
commit: a3ed4157b7d89800a0008de0c9e46a438a5c3745 fgraph: Replace fgraph_ret_regs with ftrace_regs
date:   3 months ago
config: arm64-randconfig-003-20250319 (https://download.01.org/0day-ci/archive/20250319/202503191223.RCdQEebt-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503191223.RCdQEebt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503191223.RCdQEebt-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/arm64/kernel/entry-ftrace.S: Assembler messages:
>> arch/arm64/kernel/entry-ftrace.S:333: Error: undefined symbol FREGS_SIZE used as an immediate value
>> arch/arm64/kernel/entry-ftrace.S:336: Error: undefined symbol FREGS_X0 used as an immediate value
>> arch/arm64/kernel/entry-ftrace.S:337: Error: undefined symbol FREGS_X2 used as an immediate value
>> arch/arm64/kernel/entry-ftrace.S:338: Error: undefined symbol FREGS_X4 used as an immediate value
>> arch/arm64/kernel/entry-ftrace.S:339: Error: undefined symbol FREGS_X6 used as an immediate value
>> arch/arm64/kernel/entry-ftrace.S:342: Error: undefined symbol FREGS_FP used as an immediate value
   arch/arm64/kernel/entry-ftrace.S:349: Error: undefined symbol FREGS_X0 used as an immediate value
   arch/arm64/kernel/entry-ftrace.S:350: Error: undefined symbol FREGS_X2 used as an immediate value
   arch/arm64/kernel/entry-ftrace.S:351: Error: undefined symbol FREGS_X4 used as an immediate value
   arch/arm64/kernel/entry-ftrace.S:352: Error: undefined symbol FREGS_X6 used as an immediate value
   arch/arm64/kernel/entry-ftrace.S:353: Error: undefined symbol FREGS_SIZE used as an immediate value


vim +333 arch/arm64/kernel/entry-ftrace.S

   324	
   325	/*
   326	 * void return_to_handler(void)
   327	 *
   328	 * Run ftrace_return_to_handler() before going back to parent.
   329	 * @fp is checked against the value passed by ftrace_graph_caller().
   330	 */
   331	SYM_CODE_START(return_to_handler)
   332		/* Make room for ftrace_regs */
 > 333		sub	sp, sp, #FREGS_SIZE
   334	
   335		/* Save return value regs */
 > 336		stp	x0, x1, [sp, #FREGS_X0]
 > 337		stp	x2, x3, [sp, #FREGS_X2]
 > 338		stp	x4, x5, [sp, #FREGS_X4]
 > 339		stp	x6, x7, [sp, #FREGS_X6]
   340	
   341		/* Save the callsite's FP */
 > 342		str	x29, [sp, #FREGS_FP]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

