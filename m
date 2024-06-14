Return-Path: <linux-kernel+bounces-215236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCFD909025
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA901F23BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA8119B5A5;
	Fri, 14 Jun 2024 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XeGIQ0Es"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199B6181B83
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382271; cv=none; b=R2qqymLM0+GKF3soQTNaSlKXxfCMRPIT9PH+8LXMWJu6tDeuCaFh8hT4/XCl+23k1OVAeZIQEkjMnX4dAMzfUkXO0bhIFBTNcPacmaYemDEEDZF+5Slz+iZpNQaKWQe6KiD+ExrDZDBIx90RjgMnw2nQ2uZD+yaZVmEzy1MZdIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382271; c=relaxed/simple;
	bh=QUjO/ewrv40kB8UQDqGi+mbyl2naOvjhfguK5EKbsQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1qWq9MF7nXP+DgL7izZJGZvxRP9qFkUgXxIwEwlrFqwP/WsL6t4EQDgCHIhoRCZgn5ynqTGH2Qktv54s2z5v8tum8hIZAFAHUKbksu+gCJyNvbEv2qadvaI667pq9/NZbx3e2CsjaR2PuSn3Iua7G0atUe1K4W8iGLMH0JyAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XeGIQ0Es; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718382269; x=1749918269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QUjO/ewrv40kB8UQDqGi+mbyl2naOvjhfguK5EKbsQk=;
  b=XeGIQ0EsKlS4qBjvNsoD6U0zsA1KqBbl3uG1o4tXLGeX53BNotQGctgy
   8T5z24//RD/jCsORWZwRcw3I7zQCk9Owb0mZ2UD/YW6H6DSBYDD/+hDeI
   7X2bglz0oN9J5yRJ0pg7O57KQy2/wIAlBahFwyUb0cdFpk/4gly6qFpRo
   V0saW2VG0d266f4iruR7ZQWMmP6m46X5KkLa+a/O2jHMw702IYeGB9jJd
   rfwb3+BWXAO12+pM/M3iTL1z7nRjkKGZPaS6Jh1AEfWMtIHv1IjJhjhEP
   1oEG+TwqL68zczJqCGGA5d/MsyvGmDkfjZjx0ROWpKp9PplFVwfi0Y85D
   w==;
X-CSE-ConnectionGUID: PJ403zrGSKSJ54/bXwAghw==
X-CSE-MsgGUID: wsolmElVRM+folc+ato9NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15426466"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="15426466"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 09:24:13 -0700
X-CSE-ConnectionGUID: E+D1AwzXQ+mwB8uP53wUow==
X-CSE-MsgGUID: MG2teJ6HTcaSrBPFV7eESg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="78031221"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 14 Jun 2024 09:24:08 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sI9if-0001V7-2S;
	Fri, 14 Jun 2024 16:24:05 +0000
Date: Sat, 15 Jun 2024 00:23:46 +0800
From: kernel test robot <lkp@intel.com>
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Matthias Brugger <matthias.bgg@gmail.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>,
	Nancy Lin <nancy.lin@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 1/2] mailbox: Add power_get/power_put API to mbox_chan_ops
Message-ID: <202406150022.LXLvvkeI-lkp@intel.com>
References: <20240614040133.24967-2-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614040133.24967-2-jason-jh.lin@mediatek.com>

Hi Jason-JH.Lin,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10-rc3 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-JH-Lin/mailbox-Add-power_get-power_put-API-to-mbox_chan_ops/20240614-120412
base:   linus/master
patch link:    https://lore.kernel.org/r/20240614040133.24967-2-jason-jh.lin%40mediatek.com
patch subject: [PATCH 1/2] mailbox: Add power_get/power_put API to mbox_chan_ops
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240615/202406150022.LXLvvkeI-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 78ee473784e5ef6f0b19ce4cb111fb6e4d23c6b2)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240615/202406150022.LXLvvkeI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406150022.LXLvvkeI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/mailbox/mailbox.c:9:
   In file included from include/linux/interrupt.h:21:
   In file included from arch/riscv/include/asm/sections.h:9:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/mailbox/mailbox.c:382:11: error: incompatible pointer to integer conversion returning 'void *' from a function with result type 'int' [-Wint-conversion]
     382 |                         return ERR_PTR(ret);
         |                                ^~~~~~~~~~~~
   1 warning and 1 error generated.


vim +382 drivers/mailbox/mailbox.c

   355	
   356	static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
   357	{
   358		struct device *dev = cl->dev;
   359		unsigned long flags;
   360		int ret;
   361	
   362		if (chan->cl || !try_module_get(chan->mbox->dev->driver->owner)) {
   363			dev_dbg(dev, "%s: mailbox not free\n", __func__);
   364			return -EBUSY;
   365		}
   366	
   367		spin_lock_irqsave(&chan->lock, flags);
   368		chan->msg_free = 0;
   369		chan->msg_count = 0;
   370		chan->active_req = NULL;
   371		chan->cl = cl;
   372		init_completion(&chan->tx_complete);
   373	
   374		if (chan->txdone_method	== TXDONE_BY_POLL && cl->knows_txdone)
   375			chan->txdone_method = TXDONE_BY_ACK;
   376	
   377		spin_unlock_irqrestore(&chan->lock, flags);
   378	
   379		if (chan->mbox->ops->power_get) {
   380			ret = chan->mbox->ops->power_get(chan);
   381			if (ret < 0)
 > 382				return ERR_PTR(ret);
   383		}
   384	
   385		if (chan->mbox->ops->startup) {
   386			ret = chan->mbox->ops->startup(chan);
   387	
   388			if (ret) {
   389				dev_err(dev, "Unable to startup the chan (%d)\n", ret);
   390				mbox_free_channel(chan);
   391				return ret;
   392			}
   393		}
   394	
   395		return 0;
   396	}
   397	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

