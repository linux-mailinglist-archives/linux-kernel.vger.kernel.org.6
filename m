Return-Path: <linux-kernel+bounces-242568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C29289E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014121F252E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A17F14B973;
	Fri,  5 Jul 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJgm9eYG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F6C149DF7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186910; cv=none; b=OjBtlE+PMJDyD4wGuAg6YAkCxA6BzHvrlclZWZLKSYYopXeH81V9616j8tnD3PIu0pMZ+Hawpp2dII/dp1w7955M5k6NR/EFdl10Wdqlzy0yA8q9ngQZzzcNhvgWm1Xm5/eXXuzCh57VkZ7dXU2QUe+YyTAlzG2mJ6X6PvUkiEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186910; c=relaxed/simple;
	bh=thZNfYC8uPof+gGtq8OfZdddZaeF5427/D5+IHIKChc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7RWacj+qa3Q+4XHpCfU5AyDv7GD4xBKP8pnl20UH9GwuqYY842aIAg3N/8FD+SgxW/gQQb8COFgx75s3soxsMueXFkaFM4Kz9gqStYOgpOnmz8zlXlxHELorC2Dsnd3TN1uWaA33lr0YY/PS/jQKVXlOYy6sHSPjdpgHUb9fJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJgm9eYG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720186909; x=1751722909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=thZNfYC8uPof+gGtq8OfZdddZaeF5427/D5+IHIKChc=;
  b=UJgm9eYGJkEq78IApomXcW7kjpW2zx45GU5eRieAPw3lJrPNdyxZDzx0
   h/DxFfZUM1oROMOX0B5avNDkXDtaQi7vq7uCaSEl5lDtqGz1cEmbporLq
   B8mvxpgzcp3N1Jy0sw9wAwiYs3b5W+LTNrsW8MVuDb44hD+n5Omao03+t
   ExxfZ2wqVyqsqiTzYCV/DUBwjGvLLnluOYwQnln1k0Enq0XiwWtQkAwWU
   zXfuusYnnd2cb+MifqIHhdjXQWTZIDhlg2uTQfS1b3uKCBt4VLsmQr1W+
   LXtPMTfgBGpQ2KygK3bQzM3FAney7dQSRe6huJDEgGk29xgr0gNe0JQpZ
   A==;
X-CSE-ConnectionGUID: vduXcoC6Qb+FEKE0BkqqXg==
X-CSE-MsgGUID: kO59hVvKSYOvTzVPGEvscw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="21249296"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="21249296"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 06:41:48 -0700
X-CSE-ConnectionGUID: UevxvWyYTG2PP6AGyswH4Q==
X-CSE-MsgGUID: 2hTyJIfTRpO7KhNrmdxPFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="52068164"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 05 Jul 2024 06:41:44 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sPjC2-000SQq-0h;
	Fri, 05 Jul 2024 13:41:42 +0000
Date: Fri, 5 Jul 2024 21:41:36 +0800
From: kernel test robot <lkp@intel.com>
To: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, minchan@kernel.org,
	willy@infradead.org, senozhatsky@chromium.org, david@redhat.com,
	42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Alex Shi <alexs@kernel.org>
Subject: Re: [PATCH v2 01/20] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
Message-ID: <202407052121.e5LTYhXc-lkp@intel.com>
References: <20240703040613.681396-2-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703040613.681396-2-alexs@kernel.org>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/alexs-kernel-org/mm-zsmalloc-add-zpdesc-memory-descriptor-for-zswap-zpool/20240703-182314
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240703040613.681396-2-alexs%40kernel.org
patch subject: [PATCH v2 01/20] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
config: i386-buildonly-randconfig-004-20240705 (https://download.01.org/0day-ci/archive/20240705/202407052121.e5LTYhXc-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240705/202407052121.e5LTYhXc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407052121.e5LTYhXc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/zsmalloc.c:65:
>> mm/zpdesc.h:48:1: error: no member named 'memcg_data' in 'page'
      48 | ZPDESC_MATCH(memcg_data, memcg_data);
         | ^            ~~~~~~~~~~
   mm/zpdesc.h:40:16: note: expanded from macro 'ZPDESC_MATCH'
      40 |         static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
         |                       ^                     ~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^                        ~~~~~~
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                                  ^~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   In file included from mm/zsmalloc.c:65:
>> mm/zpdesc.h:48:1: error: no member named 'memcg_data' in 'zpdesc'
      48 | ZPDESC_MATCH(memcg_data, memcg_data);
         | ^                        ~~~~~~~~~~
   mm/zpdesc.h:40:45: note: expanded from macro 'ZPDESC_MATCH'
      40 |         static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
         |                                                    ^                       ~~
   include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
      16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
         |                                 ^                        ~~~~~~
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                                  ^~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   2 errors generated.


vim +48 mm/zpdesc.h

     9	
    10	/*
    11	 * struct zpdesc -	Memory descriptor for zpool memory, now is for zsmalloc
    12	 * @flags:		Page flags, PG_private: identifies the first component page
    13	 * @lru:		Indirectly used by page migration
    14	 * @mops:		Used by page migration
    15	 * @next:		Next zpdesc in a zspage in zsmalloc zpool
    16	 * @handle:		For huge zspage in zsmalloc zpool
    17	 * @zspage:		Pointer to zspage in zsmalloc
    18	 * @memcg_data:		Memory Control Group data.
    19	 *
    20	 * This struct overlays struct page for now. Do not modify without a good
    21	 * understanding of the issues.
    22	 */
    23	struct zpdesc {
    24		unsigned long flags;
    25		struct list_head lru;
    26		struct movable_operations *mops;
    27		union {
    28			/* Next zpdescs in a zspage in zsmalloc zpool */
    29			struct zpdesc *next;
    30			/* For huge zspage in zsmalloc zpool */
    31			unsigned long handle;
    32		};
    33		struct zspage *zspage;
    34		unsigned long _zp_pad_1;
    35	#ifdef CONFIG_SLAB_OBJ_EXT
    36		unsigned long memcg_data;
    37	#endif
    38	};
    39	#define ZPDESC_MATCH(pg, zp) \
    40		static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
    41	
    42	ZPDESC_MATCH(flags, flags);
    43	ZPDESC_MATCH(lru, lru);
    44	ZPDESC_MATCH(mapping, mops);
    45	ZPDESC_MATCH(index, next);
    46	ZPDESC_MATCH(index, handle);
    47	ZPDESC_MATCH(private, zspage);
  > 48	ZPDESC_MATCH(memcg_data, memcg_data);
    49	#undef ZPDESC_MATCH
    50	static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
    51	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

