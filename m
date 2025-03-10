Return-Path: <linux-kernel+bounces-554235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07934A5950B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A77A7A5E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533EC22172D;
	Mon, 10 Mar 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VsAyhZK1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F039322171C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610922; cv=none; b=bFnjnvYTbx/xhe9COAExwORRUvWJudLPatTe2UEzgrdpSiqQOBDHN9yjDXqpP4DNioJIAL7nh8zx5UF2t2xBVl60QWit7VI/sV3atxfoWVgN87RTg7U5/RDObFjjSKHKt1Jqcgpotbq9wtxrtMIzy3jhlupNxKShRSlS4UfqzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610922; c=relaxed/simple;
	bh=xSWb5REeYFPZwi1QUoJuIX4lM1Cr4JUM9JjHTFSxWoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RG5j9dcV7lBs6QDCYGfbzxeWIQ7TeMSY66VkhEck/2vaEfWtggZtiIfUoExsSZFWMhlBZPi/GAJUNt/G0wPovUMQj5Gi0+X8TAC0Ut2HlepRMqsnmu0tf+rGL5AJuh9fQpd/cexLSM/P9mNmdggGB6RnI81RxGL+Wyo+K1j+Rt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VsAyhZK1; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741610921; x=1773146921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xSWb5REeYFPZwi1QUoJuIX4lM1Cr4JUM9JjHTFSxWoU=;
  b=VsAyhZK1oY+9zJmEJPv6eX/HlKxDyh1XYCATBROGT6LnMrd/BjjKKeky
   hJBVD+qhZ7NbHEjvxzT3FifUCPHlp3YajWLwQvKA1WxrjoB/+oAjIzI94
   HSbyBfNlouylX+Z22vqf+fltH14/W53cTOU0bZKZSTrd9TfHpucmPUZ/p
   U0KMBiSMuvHG8zwwQw3jxEdBsqqxnkG69jafP12hObK5rd1L98bj1VaTw
   EVg/N4cPE6NFhgs2mf6ehq31e4DF3Qg7yB91wu6E+V6c7d+hgnX4PQk+/
   QW6rZa/UtHpJodjTmrrDAKl/28tCfQgD/kTyWc+NnFWNDB+DsBp7Bac6t
   w==;
X-CSE-ConnectionGUID: jQZmaMzhTjy5XFYFprrIGQ==
X-CSE-MsgGUID: OvM1O+NiQV2FA8ek6sWFhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="65059386"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="65059386"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 05:48:40 -0700
X-CSE-ConnectionGUID: QuT5wmvcRcGZWfrVWsfu1A==
X-CSE-MsgGUID: +IN/u0q+QcKsj7aOhMegpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120183702"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 10 Mar 2025 05:48:35 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trcXr-0004F6-1s;
	Mon, 10 Mar 2025 12:47:57 +0000
Date: Mon, 10 Mar 2025 20:47:16 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com, pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	qyousef@layalina.io, hongyan.xia2@arm.com, christian.loehle@arm.com,
	luis.machado@arm.com, qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 5/7 v5] sched/fair: Add push task mechanism for EAS
Message-ID: <202503102022.MhverD5b-lkp@intel.com>
References: <20250302210539.1563190-6-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302210539.1563190-6-vincent.guittot@linaro.org>

Hi Vincent,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on peterz-queue/sched/core linus/master v6.14-rc6 next-20250307]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Guittot/sched-fair-Filter-false-overloaded_group-case-for-EAS/20250303-050850
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20250302210539.1563190-6-vincent.guittot%40linaro.org
patch subject: [PATCH 5/7 v5] sched/fair: Add push task mechanism for EAS
config: arm-realview_defconfig (https://download.01.org/0day-ci/archive/20250310/202503102022.MhverD5b-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250310/202503102022.MhverD5b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503102022.MhverD5b-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/sched/fair.c:8675:36: error: no member named 'pushable_tasks' in 'struct cfs_rq'
    8675 |         return !plist_head_empty(&rq->cfs.pushable_tasks);
         |                                   ~~~~~~~ ^
   kernel/sched/fair.c:8685:33: error: no member named 'pushable_tasks' in 'struct cfs_rq'
    8685 |         p = plist_first_entry(&rq->cfs.pushable_tasks,
         |                                ~~~~~~~ ^
   include/linux/plist.h:233:27: note: expanded from macro 'plist_first_entry'
     233 |         container_of(plist_first(head), type, member)
         |                                  ^~~~
   include/linux/container_of.h:19:26: note: expanded from macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   kernel/sched/fair.c:8685:33: error: no member named 'pushable_tasks' in 'struct cfs_rq'
    8685 |         p = plist_first_entry(&rq->cfs.pushable_tasks,
         |                                ~~~~~~~ ^
   include/linux/plist.h:233:27: note: expanded from macro 'plist_first_entry'
     233 |         container_of(plist_first(head), type, member)
         |                                  ^~~~
   include/linux/container_of.h:20:30: note: expanded from macro 'container_of'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                                     ^~~
   include/linux/compiler_types.h:483:63: note: expanded from macro '__same_type'
     483 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                                  ^~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   kernel/sched/fair.c:8685:33: error: no member named 'pushable_tasks' in 'struct cfs_rq'
    8685 |         p = plist_first_entry(&rq->cfs.pushable_tasks,
         |                                ~~~~~~~ ^
   include/linux/plist.h:233:27: note: expanded from macro 'plist_first_entry'
     233 |         container_of(plist_first(head), type, member)
         |                                  ^~~~
   include/linux/container_of.h:21:23: note: expanded from macro 'container_of'
      21 |                       __same_type(*(ptr), void),                        \
         |                                     ^~~
   include/linux/compiler_types.h:483:63: note: expanded from macro '__same_type'
     483 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                               ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                                  ^~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   kernel/sched/fair.c:8697:41: error: no member named 'pushable_tasks' in 'struct cfs_rq'
    8697 |         plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
         |                                        ~~~~~~~ ^
   kernel/sched/fair.c:8772:42: error: no member named 'pushable_tasks' in 'struct cfs_rq'
    8772 |                 plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
         |                                                ~~~~~~~ ^
   kernel/sched/fair.c:8779:43: error: no member named 'pushable_tasks' in 'struct cfs_rq'
    8779 |                         plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
         |                                                        ~~~~~~~ ^
   kernel/sched/fair.c:8781:43: error: no member named 'pushable_tasks' in 'struct cfs_rq'
    8781 |                         plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
         |                                                        ~~~~~~~ ^
   kernel/sched/fair.c:13572:27: error: no member named 'pushable_tasks' in 'struct cfs_rq'
    13572 |         plist_head_init(&cfs_rq->pushable_tasks);
          |                          ~~~~~~  ^
   9 errors generated.


vim +8675 kernel/sched/fair.c

  8672	
  8673	static inline int has_pushable_tasks(struct rq *rq)
  8674	{
> 8675		return !plist_head_empty(&rq->cfs.pushable_tasks);
  8676	}
  8677	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

