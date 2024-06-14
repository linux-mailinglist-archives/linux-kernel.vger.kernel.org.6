Return-Path: <linux-kernel+bounces-215490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CFB909396
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4972F1C21403
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1901494B3;
	Fri, 14 Jun 2024 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTeplea4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D5E13C671
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 21:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718399367; cv=none; b=o+Z7KkQGmvuabNrgCDdQwYDVG7M02VItEH7AZwrke3TQOP+kmQbSFmM0ynpKIDIj7PsQwrfzBcTLx6w1o0tUpRDRahp90YlXdwRWNtCDcBKQ84spwVB/xG+I5hg+L+iobJlhumE+bzv2TUVDyHetKaw7LKdcz9LwDY/aDoeGW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718399367; c=relaxed/simple;
	bh=FNq86m2+L/Y8MguLbUnC6HoD3GqL1CauBRcwa9sF4GA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O83UKltNzQUSQxFyTMyQ59uUtIHV00GAJUvors/7/7IIkfaC31WvrCLlhaGpU5l2PFViXkNXNn1ZCLwO53yOKhAdH17Oh2zPAByz2THKlHzjQ91zOh0yxRrBc3gLeoDIyAVGRYl8l0XxGll4uUGKkjNtrY37znzmz3o7EPQ9DWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTeplea4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718399366; x=1749935366;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FNq86m2+L/Y8MguLbUnC6HoD3GqL1CauBRcwa9sF4GA=;
  b=NTeplea42uiwz8vJlAiUC1/+6PWWBtGbQFZTcfb8mtCu+4iVVyL2Feff
   VqckqmjQZr0YVjTYLlhkjPqt362Lx3yk/qWBBs2UO7iNsdkzmo8YJ2EWP
   mSy/kySl6Q4BmVwg6NhrDsEjLeVo7nGVg3TjZH6e0P8w7D080Mblfc9DR
   XTib99iKep4EEVzZgzJvmMaOTe25sfksNFQ/dv/AmOxJWRyVsf6FlfilA
   qbyWyiC2Ij2HarFR2ylGbdOmIsHbZ2lj1iHTi46TC2IlylzbnSq/wajAD
   KZeEfDXVExZz/HeTKSEguCNWtubi7yy2nhhAvQkrl6cm1TrC8PpUF5XML
   A==;
X-CSE-ConnectionGUID: hjk1VbPfSVSWflf/N+Al5g==
X-CSE-MsgGUID: Dp3HtxdyTOGj60o/4fx2uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15141717"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="15141717"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 14:09:26 -0700
X-CSE-ConnectionGUID: FBxTe8TwQ5OCB8N3E2Vs9g==
X-CSE-MsgGUID: JDLnadtmSGipZJW8EiIzWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="78095555"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Jun 2024 14:09:23 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIEAi-0001nZ-2L;
	Fri, 14 Jun 2024 21:09:20 +0000
Date: Sat, 15 Jun 2024 05:08:36 +0800
From: kernel test robot <lkp@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: mm/slub.c:3905:29: error: variable 'obj_exts' set but not used
Message-ID: <202406150444.F6neSaiy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c286c21ff94252f778515b21b6bebe749454a852
commit: 4b8736964640fe160724e7135dc62883bddcdace mm/slab: add allocation accounting into slab allocation and free paths
date:   7 weeks ago
config: x86_64-sof-customedconfig-atom-defconfig (https://download.01.org/0day-ci/archive/20240615/202406150444.F6neSaiy-lkp@intel.com/config)
compiler: gcc-11 (Ubuntu 11.4.0-4ubuntu1) 11.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240615/202406150444.F6neSaiy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406150444.F6neSaiy-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/slub.c: In function 'slab_post_alloc_hook':
>> mm/slub.c:3905:29: error: variable 'obj_exts' set but not used [-Werror=unused-but-set-variable]
    3905 |         struct slabobj_ext *obj_exts;
         |                             ^~~~~~~~
   cc1: all warnings being treated as errors


vim +/obj_exts +3905 mm/slub.c

  3898	
  3899	static __fastpath_inline
  3900	void slab_post_alloc_hook(struct kmem_cache *s,	struct obj_cgroup *objcg,
  3901				  gfp_t flags, size_t size, void **p, bool init,
  3902				  unsigned int orig_size)
  3903	{
  3904		unsigned int zero_size = s->object_size;
> 3905		struct slabobj_ext *obj_exts;
  3906		bool kasan_init = init;
  3907		size_t i;
  3908		gfp_t init_flags = flags & gfp_allowed_mask;
  3909	
  3910		/*
  3911		 * For kmalloc object, the allocated memory size(object_size) is likely
  3912		 * larger than the requested size(orig_size). If redzone check is
  3913		 * enabled for the extra space, don't zero it, as it will be redzoned
  3914		 * soon. The redzone operation for this extra space could be seen as a
  3915		 * replacement of current poisoning under certain debug option, and
  3916		 * won't break other sanity checks.
  3917		 */
  3918		if (kmem_cache_debug_flags(s, SLAB_STORE_USER | SLAB_RED_ZONE) &&
  3919		    (s->flags & SLAB_KMALLOC))
  3920			zero_size = orig_size;
  3921	
  3922		/*
  3923		 * When slab_debug is enabled, avoid memory initialization integrated
  3924		 * into KASAN and instead zero out the memory via the memset below with
  3925		 * the proper size. Otherwise, KASAN might overwrite SLUB redzones and
  3926		 * cause false-positive reports. This does not lead to a performance
  3927		 * penalty on production builds, as slab_debug is not intended to be
  3928		 * enabled there.
  3929		 */
  3930		if (__slub_debug_enabled())
  3931			kasan_init = false;
  3932	
  3933		/*
  3934		 * As memory initialization might be integrated into KASAN,
  3935		 * kasan_slab_alloc and initialization memset must be
  3936		 * kept together to avoid discrepancies in behavior.
  3937		 *
  3938		 * As p[i] might get tagged, memset and kmemleak hook come after KASAN.
  3939		 */
  3940		for (i = 0; i < size; i++) {
  3941			p[i] = kasan_slab_alloc(s, p[i], init_flags, kasan_init);
  3942			if (p[i] && init && (!kasan_init ||
  3943					     !kasan_has_integrated_init()))
  3944				memset(p[i], 0, zero_size);
  3945			kmemleak_alloc_recursive(p[i], s->object_size, 1,
  3946						 s->flags, init_flags);
  3947			kmsan_slab_alloc(s, p[i], init_flags);
  3948			if (need_slab_obj_ext()) {
  3949				obj_exts = prepare_slab_obj_exts_hook(s, flags, p[i]);
  3950	#ifdef CONFIG_MEM_ALLOC_PROFILING
  3951				/*
  3952				 * Currently obj_exts is used only for allocation profiling.
  3953				 * If other users appear then mem_alloc_profiling_enabled()
  3954				 * check should be added before alloc_tag_add().
  3955				 */
  3956				if (likely(obj_exts))
  3957					alloc_tag_add(&obj_exts->ref, current->alloc_tag, s->size);
  3958	#endif
  3959			}
  3960		}
  3961	
  3962		memcg_slab_post_alloc_hook(s, objcg, flags, size, p);
  3963	}
  3964	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

