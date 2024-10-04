Return-Path: <linux-kernel+bounces-351531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E5B991293
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE9F2867F5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE5214C59A;
	Fri,  4 Oct 2024 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d67D/qVD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5837F14C582
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 22:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728082669; cv=none; b=XKZrc8dui/2PNhD4esv5qPCyIT880zvaAKx7CzoNiiBtzQTdHeqNRZ4qo7ddZGzLQPagdlQku9eAINmwOfp7APLqYQhZ0MQirB0zEQXX1QfpXbexyCRZSeAWWXzRH0gCysqa+hSowJTXZCFfvYap1M1OX9J4KGNXtGnH0JjKj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728082669; c=relaxed/simple;
	bh=iP3PjDg8C0QSZuYcbelqYi2MY8Tu+CV22cnPKpdI3cE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SN6pffyhd/dLdhj+FbED44fpE7OwmxUM95Z16EhqWn1v3/ixLIWnYwVX+QVZxrn97TKDPE0dIzEXjld4Zf9yGacRonMtFcRYJB9nx+4B6oT9Q4D3ONsLJuilCXirHdOYRf6s8Q4jCOXjcp4Fvq50POLThsM/BhSPYlBGdRYY3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d67D/qVD; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728082667; x=1759618667;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iP3PjDg8C0QSZuYcbelqYi2MY8Tu+CV22cnPKpdI3cE=;
  b=d67D/qVDbzuo4K8sEV5yZNZpCfPF+IrwM/WMjC+DTqYrbQ+ifkZZnVrh
   DmTeYzedFkhw90dnUweq2gFtrVM8VBzNqALzm/30WqTIXLAVE6Z9CKN8Q
   s25bqbstaKE+yeDbgtC9eo5EmIMvKoFjTGnQeFN9VuYjDKCq6d+8/k/IQ
   VSTBsObF3yQ1rWOzXf5DkNx4IeVfndecEuc5uNPOH8T02fY/slSZInj+X
   JVjnK9YqLsOuvzYHx9oyf0zDGURy9B6wxtOFCaerTh0DTIh7vwHHwn0ok
   I6OBtQAvzECHbLgHmxDD+teojc6S3xQ73sWoBRSxwZgxi2AxKJQBjIyVC
   A==;
X-CSE-ConnectionGUID: jMWFkidzQF+hFDa+Yd6Ovg==
X-CSE-MsgGUID: hW21lr3MR2Kt449LEYPjaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="37973938"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="37973938"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 15:57:46 -0700
X-CSE-ConnectionGUID: WnQuzELMTWy0I7Pr1r1FmA==
X-CSE-MsgGUID: wLelGjFqRmi3GVLXf9V7eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="75095287"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 04 Oct 2024 15:57:45 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swrF0-0002JQ-2Z;
	Fri, 04 Oct 2024 22:57:42 +0000
Date: Sat, 5 Oct 2024 06:57:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241003 5/14]
 include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to
 requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) ==
 sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of
 struct_group_tagged()
Message-ID: <202410050637.FRCKvVql-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241003
head:   ec64acf2dce7577a42c01241e78b24afebc26e96
commit: f44c92244302b0ac9d17ccf3eb21786a9be55163 [5/14] RDMA/uverbs: Use static_assert() to check struct sizes
config: arm-randconfig-002-20241005 (https://download.01.org/0day-ci/archive/20241005/202410050637.FRCKvVql-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef3566a25ff0e34fb87339ba5e13eca17cec00f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050637.FRCKvVql-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410050637.FRCKvVql-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/infiniband/core/uverbs_cmd.c:43:
   In file included from include/rdma/uverbs_types.h:10:
   In file included from include/rdma/ib_verbs.h:15:
   In file included from include/linux/ethtool.h:18:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/infiniband/core/uverbs_cmd.c:44:
   In file included from include/rdma/uverbs_std_types.h:10:
>> include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of struct_group_tagged()
     643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
         | ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     644 |               "struct member likely outside of struct_group_tagged()");
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/rdma/uverbs_ioctl.h:643:58: note: expression evaluates to '56 == 52'
     643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     644 |               "struct member likely outside of struct_group_tagged()");
         |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   1 warning and 1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +643 include/rdma/uverbs_ioctl.h

   630	
   631	struct uverbs_attr_bundle {
   632		/* New members MUST be added within the struct_group() macro below. */
   633		struct_group_tagged(uverbs_attr_bundle_hdr, hdr,
   634			struct ib_udata driver_udata;
   635			struct ib_udata ucore;
   636			struct ib_uverbs_file *ufile;
   637			struct ib_ucontext *context;
   638			struct ib_uobject *uobject;
   639			DECLARE_BITMAP(attr_present, UVERBS_API_ATTR_BKEY_LEN);
   640		);
   641		struct uverbs_attr attrs[];
   642	};
 > 643	static_assert(offsetof(struct uverbs_attr_bundle, attrs) == sizeof(struct uverbs_attr_bundle_hdr),
   644		      "struct member likely outside of struct_group_tagged()");
   645	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

