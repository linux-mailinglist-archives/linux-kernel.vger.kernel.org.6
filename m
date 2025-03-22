Return-Path: <linux-kernel+bounces-572222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F571A6C7FE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 08:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4CC3B5BD0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 06:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A41194080;
	Sat, 22 Mar 2025 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WE3VQurz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2648AD2D
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742626799; cv=none; b=cJWMtJoZqJoZu3ZThGxv9enC/qnFAv/YUAI2jsa3YXrdqO6415F06t6cTmOawlSLK45p8RrQdTPlNne72r6t53uNAFxVG83uroSW4nO4zXAMJqG4Ud49NaNdKdt3bFONnf1zY0SVw/IXtqn/kMUBLPgwMi+0LI++0cqWDT12oyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742626799; c=relaxed/simple;
	bh=JKMq0z2iDWpQRa5Ggne5PlCBXeMkphwT4deK2O6Z1vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJWJKoQ2HjKMikHL9RWPD850cx4pLXGGs+uzIiOtui71hjd5e6u26ieWDWN6iJ9dTxwBR7obVgNhFfp03IK4xVMJ2xBgAL0TkLfpn9bH+UGFuu9e3XxUSUpEfxkJPGtzlgf2YGDhJHP9Zg+8OWG6TpvCNsq2WqxUX4m3XAa/ksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WE3VQurz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742626796; x=1774162796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JKMq0z2iDWpQRa5Ggne5PlCBXeMkphwT4deK2O6Z1vM=;
  b=WE3VQurzih+ZUWmucsvBYAo+MN8LPtz7CyqcieMuGZQXNpatDnGUVihg
   mr1BcL3hG5/vXhDZxd41O2UlQ+hzPW1A26eP3M5do5+hyppU0quKXOUbo
   LWLsDExu6FM2JtqETl9EDiY9SXgPp90TrcK/69su4LUfvm6/IVsHCkdFb
   gKL3uLy42ftTEMuONkOHF+HuX5j/6EI/MclT2mXVOstY+EI4NmnjaLIyI
   zXrGZ6AjFsn20Ght+3ju4g8083JLvoRSGhWVC4evoLOkMOvPIbny1Urtu
   NXrnDYUcvsikGf/SmzZh5pmggukkOQixYl38uSDKRBHSxp3qsNtCaDqJs
   A==;
X-CSE-ConnectionGUID: 7U1QVeJ0TU2A3uSjPRuabw==
X-CSE-MsgGUID: kIYs2YkhR1qZyRkg/tXG0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="55277298"
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="55277298"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 23:59:56 -0700
X-CSE-ConnectionGUID: 3PbpgjJsQ7G8SFNhgDCD5g==
X-CSE-MsgGUID: TJh6lw0GR0aAIahOqOjF2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,266,1736841600"; 
   d="scan'208";a="123540591"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 21 Mar 2025 23:59:55 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvspk-000203-0T;
	Sat, 22 Mar 2025 06:59:52 +0000
Date: Sat, 22 Mar 2025 14:59:48 +0800
From: kernel test robot <lkp@intel.com>
To: nancyenos <nicymimz@gmail.com>,
	"outreachy @ lists . linux . dev Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, nancyenos <nicymimz@gmail.com>
Subject: Re: [PATCH] staging: octeon: Fix unused macro Argument 'x'
Message-ID: <202503221402.gmXKIBsx-lkp@intel.com>
References: <20250322003218.14134-1-nicymimz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322003218.14134-1-nicymimz@gmail.com>

Hi nancyenos,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/nancyenos/staging-octeon-Fix-unused-macro-Argument-x/20250322-084136
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250322003218.14134-1-nicymimz%40gmail.com
patch subject: [PATCH] staging: octeon: Fix unused macro Argument 'x'
config: arc-randconfig-001-20250322 (https://download.01.org/0day-ci/archive/20250322/202503221402.gmXKIBsx-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250322/202503221402.gmXKIBsx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503221402.gmXKIBsx-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/staging/octeon/octeon-ethernet.h:41,
                    from drivers/staging/octeon/ethernet-rx.c:26:
   drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_check_rcv_error':
>> drivers/staging/octeon/ethernet-rx.c:67:25: error: 'OCTEON_FEATURE_PKND' undeclared (first use in this function)
      67 |  if (octeon_has_feature(OCTEON_FEATURE_PKND))
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:12:39: note: in definition of macro 'octeon_has_feature'
      12 | #define octeon_has_feature(x) ((void)(x), 0)
         |                                       ^
   drivers/staging/octeon/ethernet-rx.c:67:25: note: each undeclared identifier is reported only once for each function it appears in
      67 |  if (octeon_has_feature(OCTEON_FEATURE_PKND))
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:12:39: note: in definition of macro 'octeon_has_feature'
      12 | #define octeon_has_feature(x) ((void)(x), 0)
         |                                       ^
>> drivers/staging/octeon/octeon-stubs.h:12:41: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      12 | #define octeon_has_feature(x) ((void)(x), 0)
         |                                         ^
   drivers/staging/octeon/ethernet-rx.c:67:6: note: in expansion of macro 'octeon_has_feature'
      67 |  if (octeon_has_feature(OCTEON_FEATURE_PKND))
         |      ^~~~~~~~~~~~~~~~~~
   drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_poll':
>> drivers/staging/octeon/ethernet-rx.c:201:22: error: 'OCTEON_CN68XX' undeclared (first use in this function)
     201 |  if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
         |                      ^~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:11:36: note: in definition of macro 'OCTEON_IS_MODEL'
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                    ^
   drivers/staging/octeon/octeon-stubs.h:11:38: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                      ^
   drivers/staging/octeon/ethernet-rx.c:201:6: note: in expansion of macro 'OCTEON_IS_MODEL'
     201 |  if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
         |      ^~~~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:11:38: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                      ^
   drivers/staging/octeon/ethernet-rx.c:233:8: note: in expansion of macro 'OCTEON_IS_MODEL'
     233 |    if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
         |        ^~~~~~~~~~~~~~~
   drivers/staging/octeon/ethernet-rx.c:267:26: error: 'OCTEON_FEATURE_PKND' undeclared (first use in this function)
     267 |   if (octeon_has_feature(OCTEON_FEATURE_PKND))
         |                          ^~~~~~~~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:12:39: note: in definition of macro 'octeon_has_feature'
      12 | #define octeon_has_feature(x) ((void)(x), 0)
         |                                       ^
>> drivers/staging/octeon/octeon-stubs.h:12:41: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      12 | #define octeon_has_feature(x) ((void)(x), 0)
         |                                         ^
   drivers/staging/octeon/ethernet-rx.c:267:7: note: in expansion of macro 'octeon_has_feature'
     267 |   if (octeon_has_feature(OCTEON_FEATURE_PKND))
         |       ^~~~~~~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:11:38: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                      ^
   drivers/staging/octeon/ethernet-rx.c:389:6: note: in expansion of macro 'OCTEON_IS_MODEL'
     389 |  if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
         |      ^~~~~~~~~~~~~~~
   drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_rx_initialize':
   drivers/staging/octeon/ethernet-rx.c:489:23: error: 'OCTEON_CN68XX' undeclared (first use in this function)
     489 |   if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
         |                       ^~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:11:36: note: in definition of macro 'OCTEON_IS_MODEL'
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                    ^
   drivers/staging/octeon/octeon-stubs.h:11:38: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                      ^
   drivers/staging/octeon/ethernet-rx.c:489:7: note: in expansion of macro 'OCTEON_IS_MODEL'
     489 |   if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
         |       ^~~~~~~~~~~~~~~
   drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_rx_shutdown':
   drivers/staging/octeon/ethernet-rx.c:532:23: error: 'OCTEON_CN68XX' undeclared (first use in this function)
     532 |   if (OCTEON_IS_MODEL(OCTEON_CN68XX))
         |                       ^~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:11:36: note: in definition of macro 'OCTEON_IS_MODEL'
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                    ^
   drivers/staging/octeon/octeon-stubs.h:11:38: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                      ^
   drivers/staging/octeon/ethernet-rx.c:532:7: note: in expansion of macro 'OCTEON_IS_MODEL'
     532 |   if (OCTEON_IS_MODEL(OCTEON_CN68XX))
         |       ^~~~~~~~~~~~~~~
--
   In file included from drivers/staging/octeon/octeon-ethernet.h:41,
                    from drivers/staging/octeon/ethernet-tx.c:25:
   drivers/staging/octeon/ethernet-tx.c: In function 'cvm_oct_xmit':
>> drivers/staging/octeon/ethernet-tx.c:227:41: error: 'OCTEON_CN3XXX' undeclared (first use in this function)
     227 |  if ((skb->len < 64) && OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
         |                                         ^~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:11:36: note: in definition of macro 'OCTEON_IS_MODEL'
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                    ^
   drivers/staging/octeon/ethernet-tx.c:227:41: note: each undeclared identifier is reported only once for each function it appears in
     227 |  if ((skb->len < 64) && OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
         |                                         ^~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:11:36: note: in definition of macro 'OCTEON_IS_MODEL'
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                    ^
   drivers/staging/octeon/octeon-stubs.h:11:38: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                      ^
   drivers/staging/octeon/ethernet-tx.c:227:25: note: in expansion of macro 'OCTEON_IS_MODEL'
     227 |  if ((skb->len < 64) && OCTEON_IS_MODEL(OCTEON_CN3XXX)) {
         |                         ^~~~~~~~~~~~~~~
   drivers/staging/octeon/ethernet-tx.c: In function 'cvm_oct_xmit_pow':
>> drivers/staging/octeon/ethernet-tx.c:558:23: error: 'OCTEON_CN68XX' undeclared (first use in this function)
     558 |  if (!OCTEON_IS_MODEL(OCTEON_CN68XX))
         |                       ^~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:11:36: note: in definition of macro 'OCTEON_IS_MODEL'
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                    ^
   drivers/staging/octeon/octeon-stubs.h:11:38: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                      ^
   drivers/staging/octeon/ethernet-tx.c:558:7: note: in expansion of macro 'OCTEON_IS_MODEL'
     558 |  if (!OCTEON_IS_MODEL(OCTEON_CN68XX))
         |       ^~~~~~~~~~~~~~~
--
   In file included from drivers/staging/octeon/octeon-ethernet.h:41,
                    from drivers/staging/octeon/ethernet.c:23:
   drivers/staging/octeon/ethernet.c: In function 'cvm_oct_common_change_mtu':
>> drivers/staging/octeon/ethernet.c:258:23: error: 'OCTEON_CN3XXX' undeclared (first use in this function)
     258 |   if (OCTEON_IS_MODEL(OCTEON_CN3XXX) ||
         |                       ^~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:11:36: note: in definition of macro 'OCTEON_IS_MODEL'
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                    ^
   drivers/staging/octeon/ethernet.c:258:23: note: each undeclared identifier is reported only once for each function it appears in
     258 |   if (OCTEON_IS_MODEL(OCTEON_CN3XXX) ||
         |                       ^~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:11:36: note: in definition of macro 'OCTEON_IS_MODEL'
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                    ^
   drivers/staging/octeon/octeon-stubs.h:11:38: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                      ^
   drivers/staging/octeon/ethernet.c:258:7: note: in expansion of macro 'OCTEON_IS_MODEL'
     258 |   if (OCTEON_IS_MODEL(OCTEON_CN3XXX) ||
         |       ^~~~~~~~~~~~~~~
>> drivers/staging/octeon/ethernet.c:259:23: error: 'OCTEON_CN58XX' undeclared (first use in this function)
     259 |       OCTEON_IS_MODEL(OCTEON_CN58XX)) {
         |                       ^~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:11:36: note: in definition of macro 'OCTEON_IS_MODEL'
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                    ^
   drivers/staging/octeon/octeon-stubs.h:11:38: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                      ^
   drivers/staging/octeon/ethernet.c:259:7: note: in expansion of macro 'OCTEON_IS_MODEL'
     259 |       OCTEON_IS_MODEL(OCTEON_CN58XX)) {
         |       ^~~~~~~~~~~~~~~
   drivers/staging/octeon/ethernet.c: In function 'cvm_oct_common_open':
>> drivers/staging/octeon/ethernet.c:469:25: error: 'OCTEON_FEATURE_PKND' undeclared (first use in this function)
     469 |  if (octeon_has_feature(OCTEON_FEATURE_PKND))
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:12:39: note: in definition of macro 'octeon_has_feature'
      12 | #define octeon_has_feature(x) ((void)(x), 0)
         |                                       ^
>> drivers/staging/octeon/octeon-stubs.h:12:41: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      12 | #define octeon_has_feature(x) ((void)(x), 0)
         |                                         ^
   drivers/staging/octeon/ethernet.c:469:6: note: in expansion of macro 'octeon_has_feature'
     469 |  if (octeon_has_feature(OCTEON_FEATURE_PKND))
         |      ^~~~~~~~~~~~~~~~~~
   drivers/staging/octeon/ethernet.c: In function 'cvm_oct_probe':
>> drivers/staging/octeon/ethernet.c:725:25: error: 'OCTEON_CN68XX' undeclared (first use in this function)
     725 |     if (OCTEON_IS_MODEL(OCTEON_CN68XX))
         |                         ^~~~~~~~~~~~~
   drivers/staging/octeon/octeon-stubs.h:11:36: note: in definition of macro 'OCTEON_IS_MODEL'
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                    ^
   drivers/staging/octeon/octeon-stubs.h:11:38: warning: left-hand operand of comma expression has no effect [-Wunused-value]
      11 | #define OCTEON_IS_MODEL(x) ((void)(x), 0)
         |                                      ^
   drivers/staging/octeon/ethernet.c:725:9: note: in expansion of macro 'OCTEON_IS_MODEL'
     725 |     if (OCTEON_IS_MODEL(OCTEON_CN68XX))
         |         ^~~~~~~~~~~~~~~


vim +12 drivers/staging/octeon/octeon-stubs.h

     7	
     8	#define OCTEON_IRQ_WORKQ0 0
     9	#define OCTEON_IRQ_RML 0
    10	#define OCTEON_IRQ_TIMER1 0
    11	#define OCTEON_IS_MODEL(x) ((void)(x), 0)
  > 12	#define octeon_has_feature(x) ((void)(x), 0)
    13	#define octeon_get_clock_rate()	0
    14	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

