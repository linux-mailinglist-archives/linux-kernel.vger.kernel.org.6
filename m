Return-Path: <linux-kernel+bounces-540113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D431EA4ADCA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 21:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765C33B3432
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 20:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ACC1E0B66;
	Sat,  1 Mar 2025 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9hKi0gX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369275258
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740860423; cv=none; b=ZYp5uN14Yw60qpbjsL8TsqvTkvsK98BEMA3pLMcZPxXYoiHqv10XB4w/02bW34Ubg52eYT/bn3s+QWtM1eBiHCShuFw8iEdB7EfudzaCb8rm//y46izB7vUj9QlFeV+x7oMGja7HkRFGYPm8HLpLt9bBW98LFmNu4rg/jd3nqD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740860423; c=relaxed/simple;
	bh=8ROBKw30EjUc/+X+mVyqk68aM0a7JOfRmZ9KbnzYzwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRUxzHcftktgwCCa79Mpju0DyugUwJDnx2GNW2EIFJO6yb+vKv6vXUyuSeH/qEza+oPQJMjYJBAgZJHSYDMw+79Hhyb1hg0FrA8RMnXKdKtBIpsqgQ+Vs7K4p/nx22m8gZe4eDcRC5K/V8NhyLqa5VKqAeJ0NqNeEuyEEIkiJhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9hKi0gX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740860422; x=1772396422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ROBKw30EjUc/+X+mVyqk68aM0a7JOfRmZ9KbnzYzwU=;
  b=e9hKi0gXGeYNfhsHSHrd7r4nu3b/owghra6fY5rM+uexTWS3awQmT4UB
   EqidRV9pCvRNPE8CF3wOoTwZlRshzqtlPKHbppt+k88OrJuB7cD7WFxa9
   wFSrDtkzypCJGMz/no+ZpsUU5Dlefr+t29cn0tf4/oSDYqRAzH4JPvmf9
   Fj/hob6GMQkSHMPWyI8JLF1VhcEkCCn3Jm1xAxxu09LdU1l2MXiBHRQAK
   8aMCXai2uChoZXnA6uvOObdbqSnZFm267k6hEjonzB/xdnujviRHQ7lW8
   bdejnG9TCYPCcwh5qY7+Q22Dp4HdJ0ovczKPNrTBXU2s2puMl0v5uFz8u
   g==;
X-CSE-ConnectionGUID: sHOmqKhUQp+0EkLBbFTW1Q==
X-CSE-MsgGUID: XKM7dEJbQEK3+KkWuIfL7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="52411929"
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="52411929"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 12:20:21 -0800
X-CSE-ConnectionGUID: Vrq4h9hFRiewzVzLJWCzKQ==
X-CSE-MsgGUID: 6Mdxhje5Q46laCrsGGIymw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,326,1732608000"; 
   d="scan'208";a="117389237"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 01 Mar 2025 12:20:18 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toTJl-000Gf8-0w;
	Sat, 01 Mar 2025 20:20:13 +0000
Date: Sun, 2 Mar 2025 04:19:59 +0800
From: kernel test robot <lkp@intel.com>
To: zihan zhou <15645113830zzh@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, bsegall@google.com,
	dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
	peterz@infradead.org, rostedt@goodmis.org,
	vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [PATCH V1 2/4] sched: Do predict load
Message-ID: <202503020410.hBcraNw8-lkp@intel.com>
References: <20250221085051.32468-1-15645113830zzh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221085051.32468-1-15645113830zzh@gmail.com>

Hi zihan,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on akpm-mm/mm-nonmm-unstable brauner-vfs/vfs.all peterz-queue/sched/core linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zihan-zhou/sched-Add-kconfig-of-predict-load/20250221-165850
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20250221085051.32468-1-15645113830zzh%40gmail.com
patch subject: [PATCH V1 2/4] sched: Do predict load
config: x86_64-randconfig-076-20250301 (https://download.01.org/0day-ci/archive/20250302/202503020410.hBcraNw8-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020410.hBcraNw8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020410.hBcraNw8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: set_in_predict_no_preempt
   >>> referenced by fair.c:5628 (kernel/sched/fair.c:5628)
   >>>               vmlinux.o:(dequeue_entity)
   >>> referenced by fair.c:5767 (kernel/sched/fair.c:5767)
   >>>               vmlinux.o:(put_prev_entity)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

