Return-Path: <linux-kernel+bounces-422365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E1B9D98AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC7928351C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5902B1865E3;
	Tue, 26 Nov 2024 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gl/0L3+7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4446CD53C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628353; cv=none; b=k7wEOF5YxlUNyecs5Pl9tXmtRBqg2pK/81vDkqp+Ja6fg2Ek1m+TVIBdo593Zo5xeH8cW1rxa5GtPMSHfLRDaf6M0trKXESRC8VMG0/7eJiu2e19bb91jqH9EN6nS3cGI0Wc/pjaUIs6Zldq+9wTtJcGKE3693YEWIRpWdr58Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628353; c=relaxed/simple;
	bh=M39yVHSjSGjuRWJPdgSgtGq4dSUaAz0FQ0qvPonJlko=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ti2shKe4EbgZEfkTzbPmSY79KCjkIGg+mfRG+9rKRXeJwmaqifDmNS7fnguE5KaexJKYCU69U4bBWn4+cP7a4cpAJkoG7ZiPhdjTFeI9m3YBLPncxDorKaqiXF6SZ8faOrAiAJF5JbuxsBpzPQU5CZZnyzCpqoz+XJBWz7ooA1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gl/0L3+7; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732628352; x=1764164352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M39yVHSjSGjuRWJPdgSgtGq4dSUaAz0FQ0qvPonJlko=;
  b=Gl/0L3+7+thc73seWh16I9mfGJZXB83fiLuWvG9bjNZgmrtI7k0DZpYP
   ZGUXHThe/ucHsK/2fRkbXQJFM6Go49Gd5TjHVO1n85inh6uuryEHXzz4o
   JL1tyKQSLYTFMRDMxulr+D4+wz0RnqaDchkv1nma2LOeaQV8yBbX++6hd
   xpWqCgrT51j7SZt9rMk2v3sc/6dRotjy4f8I4quEJy3xcp0Qh6ux0Vm0P
   8xLnxGvn4Ph3RctQtA7xKR4sa2A39r8qvhz1uUQaQANa8BTIS3DqWvu1X
   nk+Qv0k7HYoCuZLPjnLhHgetlBHno4ItT8ZueKzYg/fQV5c8hy7dUaGzl
   Q==;
X-CSE-ConnectionGUID: TiBIpiuRR6a5TaP00lxCSg==
X-CSE-MsgGUID: AGc7J7D2TIuOgvVc1mxq5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32946437"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32946437"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 05:39:09 -0800
X-CSE-ConnectionGUID: GvP5Qg93TaCsRvuuj6Tc7g==
X-CSE-MsgGUID: 8j1TsWguS4ayCxJkK3ilSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="96545581"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Nov 2024 05:39:06 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFvmS-0007JT-1T;
	Tue, 26 Nov 2024 13:39:04 +0000
Date: Tue, 26 Nov 2024 21:38:24 +0800
From: kernel test robot <lkp@intel.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>
Subject: rust/helpers/mutex.c:11:6: sparse: sparse: symbol
 'rust_helper___mutex_init' was not declared. Should it be static?
Message-ID: <202411262123.zw9MlOvN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7eef7e306d3c40a0c5b9ff6adc9b273cc894dbd5
commit: d065cc76054d21e48a839a2a19ba99dbc51a4d11 rust: mutex: fix __mutex_init() usage in case of PREEMPT_RT
date:   9 weeks ago
config: um-randconfig-r111-20241126 (https://download.01.org/0day-ci/archive/20241126/202411262123.zw9MlOvN-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241126/202411262123.zw9MlOvN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411262123.zw9MlOvN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
>> rust/helpers/mutex.c:11:6: sparse: sparse: symbol 'rust_helper___mutex_init' was not declared. Should it be static?
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/spinlock.c:16:6: sparse: sparse: context imbalance in 'rust_helper_spin_lock' - wrong count at exit
   rust/helpers/spinlock.c:21:6: sparse: sparse: context imbalance in 'rust_helper_spin_unlock' - unexpected unlock

vim +/rust_helper___mutex_init +11 rust/helpers/mutex.c

    10	
  > 11	void rust_helper___mutex_init(struct mutex *mutex, const char *name,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

