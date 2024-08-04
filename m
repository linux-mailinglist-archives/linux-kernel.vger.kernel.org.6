Return-Path: <linux-kernel+bounces-274042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 512EF9471C9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 01:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D39E1C20ACF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 23:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD8313B5B7;
	Sun,  4 Aug 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkUEhLNX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971ED13B2A9
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722814436; cv=none; b=sHShBxukIZ2apvM7UfB+KmgE8WzIwXCeeF/zeeAsB+0vAaSZo0XU6NdF0MQohYpwKNBxU8Eb68nwyC9M60EWBUxesjEECfXy8cTUkeDKOR/MYiSsSrxCmrnwKimQly9UIYsFLtOyLuCGAvcotd4e28i4/b4DLkSGwY4hL9HZ+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722814436; c=relaxed/simple;
	bh=YNiK52tqjvH1YMSFEVG1g6kPtcgRQbMOB62OYCiVx0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYZm028o3PblE3mQDiQ+Z//umwuTM+8lJE7Q78JKlQNleZ1GxacoBBTT+2D3Zzq2wjn3nFpORGdN4jRo272Ly1onShGLnuyCOSg9Yc43t1yZkvS8mnjzggZxDUUOqBovyn/wVzDfjHpafLXU+QkT3JW+7u5eWns5a/L2oJkxTwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkUEhLNX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722814435; x=1754350435;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YNiK52tqjvH1YMSFEVG1g6kPtcgRQbMOB62OYCiVx0A=;
  b=HkUEhLNX+09fglnD1jke1lqynMroTzN4/qqn9tO+Zal6uyHt0yPPUL5L
   4aZWu5kaNMGUS+ZtTxV6XivuRXxa/nq9yyVedZ++9XKRZVunv+vD8iM1E
   MGbzBlbgfCPz5ZIsTcAxbCxl3fJYORfFliNe7ZnijvIsAFNmj+Ko1Xhlq
   hxUML51iGVZSFjNMhmGAEQZXqTYsZOUZ7bNDZqfpR6zRuX4Z76O4dVHXh
   BlUQQjn/b+/bKRUV/jj6Icc8GaSUfpQL2c4SD48ZHPxCj08NJojwxn4N0
   4HS//t23Y+k9VAR4qxs8l3pEibV+K67au+wGB109TPCp3d+IC0SByck0Q
   A==;
X-CSE-ConnectionGUID: Cg6Knl1kThCSwS+co7nqxg==
X-CSE-MsgGUID: o8NAVjfNQSKR37+NJUaM7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="46163227"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="46163227"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 16:33:54 -0700
X-CSE-ConnectionGUID: x7F/yaDOQyuxCCTid+YdXA==
X-CSE-MsgGUID: /J5BAN8rR0uB8knM867Q0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="55933870"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 04 Aug 2024 16:33:52 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sakjW-0001e8-1w;
	Sun, 04 Aug 2024 23:33:50 +0000
Date: Mon, 5 Aug 2024 07:33:01 +0800
From: kernel test robot <lkp@intel.com>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	linux1394-devel@lists.sourceforge.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] firewire: ohci: use guard macro to serialize
 operations for isochronous contexts
Message-ID: <202408050730.y1eyRcTv-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on ieee1394-linux1394/for-next]
[also build test ERROR on ieee1394-linux1394/for-linus linus/master v6.11-rc1 next-20240802]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Takashi-Sakamoto/firewire-core-use-guard-macro-to-maintain-static-packet-data-for-phy-configuration/20240804-210645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git for-next
patch link:    https://lore.kernel.org/r/20240804130225.243496-18-o-takashi%40sakamocchi.jp
patch subject: [PATCH 17/17] firewire: ohci: use guard macro to serialize operations for isochronous contexts
config: arm64-randconfig-003-20240805 (https://download.01.org/0day-ci/archive/20240805/202408050730.y1eyRcTv-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408050730.y1eyRcTv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408050730.y1eyRcTv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/firewire/ohci.c:3138:2: error: expected expression
    3138 |         guard(spinlock_irq)(&ohci->lock);
         |         ^
   include/linux/cleanup.h:167:2: note: expanded from macro 'guard'
     167 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:122:2: note: expanded from macro 'CLASS'
     122 |         class_##_name##_t var __cleanup(class_##_name##_destructor) =   \
         |         ^
   <scratch space>:133:1: note: expanded from here
     133 | class_spinlock_irq_t
         | ^
   1 error generated.


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

