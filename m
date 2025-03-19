Return-Path: <linux-kernel+bounces-567904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B57BA68BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548664615E0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B828420E31B;
	Wed, 19 Mar 2025 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLfuGEON"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0120DD74
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383901; cv=none; b=pwwZrA6EC+0DkMYnRlKgqPRGuMWZ5S5GvBKfwYcIABNq0vEkSkJ+3c87RcYunwkECOYjvyzdthO8L3H7+BsinxqhybdVbNE1lDk+1dT0M/y9/IogYKnKcplTSUJUHWyjWbeVcMxUkUtUQkK5EvDPi2C+XRifTDBNiTnvy5rHKhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383901; c=relaxed/simple;
	bh=JuM0h84X+KQkVl208uOYkXU9G84DGdKrH2blweZ+49c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PQ4Yvme5HfeB50H7npaKDr/SxDWQUBpF+3TFTOLg3wZ1UuobxEAY77SzQh7Ybebz9894UfjGeY01GkOU0eV3agdOO+vXugYPnDRFwME+ubxJDLIzNuNOYICFWbDBYM4FluMvXchyj9TbBu2ieCTZ3pHLx/9gZ709MpEdwv/n81k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLfuGEON; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742383898; x=1773919898;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JuM0h84X+KQkVl208uOYkXU9G84DGdKrH2blweZ+49c=;
  b=RLfuGEONM12Ac3usuhf3Ks6I7qEZ82ViPMXiNiPU4X8kMiva//Y/Sc0d
   uw6m49ebZuTZOBEqqkFzUJs6Ukzi+eF3M3GLlw8gWSjdgr5IbxNQCsdvW
   yOjWrB6FyREUg1DT6Ai9+1pP5YX2689YiIn3Ny4s/Afp5am0DX8k/v1nA
   q9fXA5/w5Ea87JdNZ/htefkOeoZpyotNr0JvviZJozffKbVfAzNbxyhjS
   BZ74BAG1682RMwL37a6+cimd7OGsJxrgWcgt2chnkiweYebciEONUmfVl
   Ccn6wGeGYsMzxmB8FqQnoXEH3RKXgjLZe3mTKbEl4RKyQ6qiLoRvaO+KF
   Q==;
X-CSE-ConnectionGUID: Zg2dCCG0SC2fSeoFTZf42Q==
X-CSE-MsgGUID: IHPqIz8vSeqzLCrW/fTwxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="68924391"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="68924391"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 04:31:37 -0700
X-CSE-ConnectionGUID: 3JXum0x0Q+S4OQ0bVjecKA==
X-CSE-MsgGUID: gxgfm4mPRniOAiYU96iAig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127780868"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 19 Mar 2025 04:31:36 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ture1-000EdU-1J;
	Wed, 19 Mar 2025 11:31:33 +0000
Date: Wed, 19 Mar 2025 19:30:45 +0800
From: kernel test robot <lkp@intel.com>
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>
Subject: net/bpf/test_run.c:511:1: warning: 'retain' attribute ignored
Message-ID: <202503191909.SHOCLBzK-lkp@intel.com>
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
commit: 7bdcedd5c8fb88e7176b93812b139eca5fe0aa46 bpf: Harden __bpf_kfunc tag against linker kfunc removal
date:   9 months ago
config: mips-allmodconfig (https://download.01.org/0day-ci/archive/20250319/202503191909.SHOCLBzK-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503191909.SHOCLBzK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503191909.SHOCLBzK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/bpf/test_run.c:511:1: warning: 'retain' attribute ignored [-Wattributes]
     511 | {
         | ^
   net/bpf/test_run.c:557:1: warning: 'retain' attribute ignored [-Wattributes]
     557 | {
         | ^
   net/bpf/test_run.c:566:1: warning: 'retain' attribute ignored [-Wattributes]
     566 | {
         | ^
   net/bpf/test_run.c:573:1: warning: 'retain' attribute ignored [-Wattributes]
     573 | {
         | ^
   net/bpf/test_run.c:579:1: warning: 'retain' attribute ignored [-Wattributes]
     579 | {
         | ^
   net/bpf/test_run.c:608:1: warning: 'retain' attribute ignored [-Wattributes]
     608 | {
         | ^
   net/bpf/test_run.c:613:1: warning: 'retain' attribute ignored [-Wattributes]
     613 | {
         | ^
   net/bpf/test_run.c:619:1: warning: 'retain' attribute ignored [-Wattributes]
     619 | {
         | ^
   net/bpf/test_run.c:623:1: warning: 'retain' attribute ignored [-Wattributes]
     623 | {
         | ^
--
>> net/core/filter.c:11863:1: warning: 'retain' attribute ignored [-Wattributes]
   11863 | {
         | ^
   net/core/filter.c:11876:1: warning: 'retain' attribute ignored [-Wattributes]
   11876 | {
         | ^
   net/core/filter.c:11889:1: warning: 'retain' attribute ignored [-Wattributes]
   11889 | {
         | ^
   net/core/filter.c:11910:1: warning: 'retain' attribute ignored [-Wattributes]
   11910 | {
         | ^
   net/core/filter.c:12096:1: warning: 'retain' attribute ignored [-Wattributes]
   12096 | {
         | ^
--
>> net/core/xdp.c:713:1: warning: 'retain' attribute ignored [-Wattributes]
     713 | {
         | ^
   net/core/xdp.c:736:1: warning: 'retain' attribute ignored [-Wattributes]
     736 | {
         | ^
   net/core/xdp.c:769:1: warning: 'retain' attribute ignored [-Wattributes]
     769 | {
         | ^
--
>> net/ipv4/tcp_cong.c:455:1: warning: 'retain' attribute ignored [-Wattributes]
     455 | {
         | ^
   net/ipv4/tcp_cong.c:469:1: warning: 'retain' attribute ignored [-Wattributes]
     469 | {
         | ^
   net/ipv4/tcp_cong.c:495:1: warning: 'retain' attribute ignored [-Wattributes]
     495 | {
         | ^
   net/ipv4/tcp_cong.c:514:1: warning: 'retain' attribute ignored [-Wattributes]
     514 | {
         | ^
   net/ipv4/tcp_cong.c:522:1: warning: 'retain' attribute ignored [-Wattributes]
     522 | {
         | ^
--
>> net/ipv4/fou_bpf.c:46:1: warning: 'retain' attribute ignored [-Wattributes]
      46 | {
         | ^
   net/ipv4/fou_bpf.c:88:1: warning: 'retain' attribute ignored [-Wattributes]
      88 | {
         | ^
--
>> net/ipv4/tcp_bbr.c:300:1: warning: 'retain' attribute ignored [-Wattributes]
     300 | {
         | ^
   net/ipv4/tcp_bbr.c:333:1: warning: 'retain' attribute ignored [-Wattributes]
     333 | {
         | ^
   net/ipv4/tcp_bbr.c:1028:1: warning: 'retain' attribute ignored [-Wattributes]
    1028 | {
         | ^
   net/ipv4/tcp_bbr.c:1040:1: warning: 'retain' attribute ignored [-Wattributes]
    1040 | {
         | ^
   net/ipv4/tcp_bbr.c:1082:1: warning: 'retain' attribute ignored [-Wattributes]
    1082 | {
         | ^
   net/ipv4/tcp_bbr.c:1091:1: warning: 'retain' attribute ignored [-Wattributes]
    1091 | {
         | ^
   net/ipv4/tcp_bbr.c:1102:1: warning: 'retain' attribute ignored [-Wattributes]
    1102 | {
         | ^
   net/ipv4/tcp_bbr.c:1130:1: warning: 'retain' attribute ignored [-Wattributes]
    1130 | {
         | ^
--
>> net/ipv4/tcp_cubic.c:130:1: warning: 'retain' attribute ignored [-Wattributes]
     130 | {
         | ^
   net/ipv4/tcp_cubic.c:143:1: warning: 'retain' attribute ignored [-Wattributes]
     143 | {
         | ^
   net/ipv4/tcp_cubic.c:325:1: warning: 'retain' attribute ignored [-Wattributes]
     325 | {
         | ^
   net/ipv4/tcp_cubic.c:342:1: warning: 'retain' attribute ignored [-Wattributes]
     342 | {
         | ^
   net/ipv4/tcp_cubic.c:359:1: warning: 'retain' attribute ignored [-Wattributes]
     359 | {
         | ^
   net/ipv4/tcp_cubic.c:449:1: warning: 'retain' attribute ignored [-Wattributes]
     449 | {
         | ^
--
>> net/ipv4/tcp_dctcp.c:90:1: warning: 'retain' attribute ignored [-Wattributes]
      90 | {
         | ^
   net/ipv4/tcp_dctcp.c:119:1: warning: 'retain' attribute ignored [-Wattributes]
     119 | {
         | ^
   net/ipv4/tcp_dctcp.c:128:1: warning: 'retain' attribute ignored [-Wattributes]
     128 | {
         | ^
   net/ipv4/tcp_dctcp.c:184:1: warning: 'retain' attribute ignored [-Wattributes]
     184 | {
         | ^
   net/ipv4/tcp_dctcp.c:194:1: warning: 'retain' attribute ignored [-Wattributes]
     194 | {
         | ^
   net/ipv4/tcp_dctcp.c:244:1: warning: 'retain' attribute ignored [-Wattributes]
     244 | {
         | ^
--
>> fs/verity/measure.c:121:1: warning: 'retain' attribute ignored [-Wattributes]
     121 | {
         | ^


vim +/retain +511 net/bpf/test_run.c

391145ba2accc4 Dave Marchevsky         2023-10-31  509  
400031e05adfce David Vernet            2023-02-01  510  __bpf_kfunc int bpf_fentry_test1(int a)
faeb2dce084aff Alexei Starovoitov      2019-11-14 @511  {
faeb2dce084aff Alexei Starovoitov      2019-11-14  512  	return a + 1;
faeb2dce084aff Alexei Starovoitov      2019-11-14  513  }
46565696434095 Kumar Kartikeya Dwivedi 2022-01-14  514  EXPORT_SYMBOL_GPL(bpf_fentry_test1);
faeb2dce084aff Alexei Starovoitov      2019-11-14  515  

:::::: The code at line 511 was first introduced by commit
:::::: faeb2dce084aff92d466c6ce68481989b815435b bpf: Add kernel test functions for fentry testing

:::::: TO: Alexei Starovoitov <ast@kernel.org>
:::::: CC: Daniel Borkmann <daniel@iogearbox.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

