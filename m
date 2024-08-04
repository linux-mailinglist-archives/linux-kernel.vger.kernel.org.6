Return-Path: <linux-kernel+bounces-274028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D4A94717D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 00:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF941C208F0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 22:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332A312E4A;
	Sun,  4 Aug 2024 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4DEdzhE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A435FA2A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722810706; cv=none; b=BKK93HwZ3vzT0Kx2q++g9t7XWFrKx9VXrBJmRRhYJzTTLIQAjMr+3zOjsaOWRxBGfDSUi9fW+SWfnu4B+9rEm0msWNIQ+m7B278gvLLBGQ7vKaIjiaO7oAtrbyBzALabKP0/eB/33wsPRhmS3wKYycCzETHt9wD1WDbWN8G2G1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722810706; c=relaxed/simple;
	bh=FLPM1VU3GQt6d9UpfsksOoBdSBBHGKFSEOHUAsYrMbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScgvCuS8mX+cj+HL7NV/AOAgmZ1vYF8jgNSxYJFoldHfD2AI9wYdUZSpom9dr16mZ5YJTMhFhe2EHJSq0pXKyYUOJ+pvS06aCQtb/7snkJiS4t8pIkSw9AA4WYoch4obkYpMZzPUKxs7DgSgYJt0dIN2HcFVWYCNtvJzFMO+3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4DEdzhE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722810705; x=1754346705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FLPM1VU3GQt6d9UpfsksOoBdSBBHGKFSEOHUAsYrMbM=;
  b=Q4DEdzhET4w4dZJadDoEYyVa/GHqqfWhC9okxDsG1Yju2HREFzcBCSUo
   aVlacXUsZE9p9FfIeyaj0e5U4ttonk13yEt76uHQ5bBqdHiMy4IWLAX+6
   KpH2b/g2fKK3RakqQ+dNAqWPyDa0ebh17vvZBsa98OFEkD5Uhu3FALIl1
   QNath/bJKllLwbDIRK0N2g6rFOsVQxoAGwq2vMWhqB/3a5xSQVH2UTNRF
   kxBbMmKvkBCXljSbK3VCZJ7DMUVQ+8reDbX7IhApmNrZw0uEIkCvSKvju
   SkfdPscblJR3Uulwzh7Ei7FOJaA/BA4amjqMvgrccD3vyfP8s/1LVTU4H
   Q==;
X-CSE-ConnectionGUID: lg+XpQ7wTEy4vlk8nTyR+A==
X-CSE-MsgGUID: 7cAT5OzeQV6MOPMbQUQplw==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="23671526"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="23671526"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 15:31:44 -0700
X-CSE-ConnectionGUID: 1Uygf4b0SQa+Z2TaaAAmOg==
X-CSE-MsgGUID: nHS3SMEwS4SYhKLhMNLJWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="55924905"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 04 Aug 2024 15:31:43 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sajlM-0001dI-2k;
	Sun, 04 Aug 2024 22:31:40 +0000
Date: Mon, 5 Aug 2024 06:31:23 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux1394-devel@lists.sourceforge.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] firewire: ohci: use guard macro to serialize
 operations for isochronous contexts
Message-ID: <202408050633.0nI12cmo-lkp@intel.com>
References: <20240804130225.243496-18-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804130225.243496-18-o-takashi@sakamocchi.jp>

Hi Takashi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ieee1394-linux1394/for-next]
[also build test WARNING on ieee1394-linux1394/for-linus linus/master v6.11-rc1 next-20240802]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Takashi-Sakamoto/firewire-core-use-guard-macro-to-maintain-static-packet-data-for-phy-configuration/20240804-210645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git for-next
patch link:    https://lore.kernel.org/r/20240804130225.243496-18-o-takashi%40sakamocchi.jp
patch subject: [PATCH 17/17] firewire: ohci: use guard macro to serialize operations for isochronous contexts
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240805/202408050633.0nI12cmo-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408050633.0nI12cmo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408050633.0nI12cmo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/firewire/ohci.c:3138:2: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    3138 |         guard(spinlock_irq)(&ohci->lock);
         |         ^
   include/linux/cleanup.h:167:2: note: expanded from macro 'guard'
     167 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:122:2: note: expanded from macro 'CLASS'
     122 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |         ^
   <scratch space>:86:1: note: expanded from here
      86 | class_spinlock_irq_t
         | ^
   1 warning generated.


vim +3138 drivers/firewire/ohci.c

  3059	
  3060	static struct fw_iso_context *ohci_allocate_iso_context(struct fw_card *card,
  3061					int type, int channel, size_t header_size)
  3062	{
  3063		struct fw_ohci *ohci = fw_ohci(card);
  3064		struct iso_context *ctx;
  3065		descriptor_callback_t callback;
  3066		u64 *channels;
  3067		u32 *mask, regs;
  3068		int index, ret = -EBUSY;
  3069	
  3070		scoped_guard(spinlock_irq, &ohci->lock) {
  3071			switch (type) {
  3072			case FW_ISO_CONTEXT_TRANSMIT:
  3073				mask     = &ohci->it_context_mask;
  3074				callback = handle_it_packet;
  3075				index    = ffs(*mask) - 1;
  3076				if (index >= 0) {
  3077					*mask &= ~(1 << index);
  3078					regs = OHCI1394_IsoXmitContextBase(index);
  3079					ctx  = &ohci->it_context_list[index];
  3080				}
  3081				break;
  3082	
  3083			case FW_ISO_CONTEXT_RECEIVE:
  3084				channels = &ohci->ir_context_channels;
  3085				mask     = &ohci->ir_context_mask;
  3086				callback = handle_ir_packet_per_buffer;
  3087				index    = *channels & 1ULL << channel ? ffs(*mask) - 1 : -1;
  3088				if (index >= 0) {
  3089					*channels &= ~(1ULL << channel);
  3090					*mask     &= ~(1 << index);
  3091					regs = OHCI1394_IsoRcvContextBase(index);
  3092					ctx  = &ohci->ir_context_list[index];
  3093				}
  3094				break;
  3095	
  3096			case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
  3097				mask     = &ohci->ir_context_mask;
  3098				callback = handle_ir_buffer_fill;
  3099				index    = !ohci->mc_allocated ? ffs(*mask) - 1 : -1;
  3100				if (index >= 0) {
  3101					ohci->mc_allocated = true;
  3102					*mask &= ~(1 << index);
  3103					regs = OHCI1394_IsoRcvContextBase(index);
  3104					ctx  = &ohci->ir_context_list[index];
  3105				}
  3106				break;
  3107	
  3108			default:
  3109				index = -1;
  3110				ret = -ENOSYS;
  3111			}
  3112	
  3113			if (index < 0)
  3114				return ERR_PTR(ret);
  3115		}
  3116	
  3117		memset(ctx, 0, sizeof(*ctx));
  3118		ctx->header_length = 0;
  3119		ctx->header = (void *) __get_free_page(GFP_KERNEL);
  3120		if (ctx->header == NULL) {
  3121			ret = -ENOMEM;
  3122			goto out;
  3123		}
  3124		ret = context_init(&ctx->context, ohci, regs, callback);
  3125		if (ret < 0)
  3126			goto out_with_header;
  3127	
  3128		if (type == FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL) {
  3129			set_multichannel_mask(ohci, 0);
  3130			ctx->mc_completed = 0;
  3131		}
  3132	
  3133		return &ctx->base;
  3134	
  3135	 out_with_header:
  3136		free_page((unsigned long)ctx->header);
  3137	 out:
> 3138		guard(spinlock_irq)(&ohci->lock);
  3139	
  3140		switch (type) {
  3141		case FW_ISO_CONTEXT_RECEIVE:
  3142			*channels |= 1ULL << channel;
  3143			break;
  3144	
  3145		case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
  3146			ohci->mc_allocated = false;
  3147			break;
  3148		}
  3149		*mask |= 1 << index;
  3150	
  3151		return ERR_PTR(ret);
  3152	}
  3153	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

