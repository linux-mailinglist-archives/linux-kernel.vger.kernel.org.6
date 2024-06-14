Return-Path: <linux-kernel+bounces-215428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC2909295
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FA752891F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132F01A2FD5;
	Fri, 14 Jun 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmNv1v3A"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F341A0AFE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391141; cv=none; b=VIYi+Vu4bgnXer9AZi9db9PRIu41H+RBqUDEPFQMY7nYig50jVl93aCibs5L50Xtm+OaQHDQYruolD+74Ia8OkWVnVA8v190nUnQSPhM5R+L15TijU/XUdV42tslGTQWO/bx/5qTJfcwy9r0CoLWH+/DgVQDVnMtLxTeHWjH9D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391141; c=relaxed/simple;
	bh=i1/JajuCHgwTdekrpE3K1vL6mofCP5cR98PS+SfZc88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+zmDsCKKjDTOpr7UDoGiQ85Am7ajHghAOIwsEDRDnCg8ngGVf7SCwDctF0S9RAQSMvsUmkkHgEg97NZQcF1WEgrJBbgxb4DF1x1+1sR1WeIhoK1YuDX1Kks6pDcW488k0yGzk/jvN5dGWFhDLpDGmPaKdtIeEkHop086oaaJ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmNv1v3A; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718391140; x=1749927140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i1/JajuCHgwTdekrpE3K1vL6mofCP5cR98PS+SfZc88=;
  b=FmNv1v3AsLux2VJNtOWlpQU8Q5mz3WxaY/M+7s5EAft/rcyBkrOUzKln
   211xk+pQbRkltgHcjClg/ykYn+fjPCHx0Zeo94mMADfS6ydMvmvxfjuX4
   8jf5PZr0MNEQoXbk6N+k0jpQqpnqssHLZs5x5HiwhHD3WpFEWO6V5AXbP
   FoQvVe0tz15N0/zzBz14KjPHQS8cYVng836efO8dfuaLNXMwcLucIS6fR
   SFrmDGs41fowlKneLY8MJcOeH6yxQWmssKnYN4lm/ye6IcdeBUhxicaEA
   ZmLvEFNrRBUrjMsPU+HuQjFLykU6YEdXgO2BXdujBzv/hSZ16QnePR2iU
   A==;
X-CSE-ConnectionGUID: wQibaXJlQfSK6Z3CSAcHLQ==
X-CSE-MsgGUID: eQ+lMprJQneWmO85WXkTjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="32770697"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="32770697"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 11:52:19 -0700
X-CSE-ConnectionGUID: 8BCAEC1eQ0iiBVgU7P+7Sw==
X-CSE-MsgGUID: UHK9p5C2SaG4ROqDiYQuCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="44956943"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 14 Jun 2024 11:52:16 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sIC22-0001fn-0j;
	Fri, 14 Jun 2024 18:52:14 +0000
Date: Sat, 15 Jun 2024 02:51:35 +0800
From: kernel test robot <lkp@intel.com>
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Matthias Brugger <matthias.bgg@gmail.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>,
	Nancy Lin <nancy.lin@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 1/2] mailbox: Add power_get/power_put API to mbox_chan_ops
Message-ID: <202406150214.pVxsbllC-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on fujitsu-integration/mailbox-for-next v6.10-rc3 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jason-JH-Lin/mailbox-Add-power_get-power_put-API-to-mbox_chan_ops/20240614-120412
base:   linus/master
patch link:    https://lore.kernel.org/r/20240614040133.24967-2-jason-jh.lin%40mediatek.com
patch subject: [PATCH 1/2] mailbox: Add power_get/power_put API to mbox_chan_ops
config: i386-randconfig-062-20240614 (https://download.01.org/0day-ci/archive/20240615/202406150214.pVxsbllC-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240615/202406150214.pVxsbllC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406150214.pVxsbllC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mailbox/mailbox.c:382:39: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got void * @@
   drivers/mailbox/mailbox.c:382:39: sparse:     expected int
   drivers/mailbox/mailbox.c:382:39: sparse:     got void *
   drivers/mailbox/mailbox.c: note: in included file (through include/linux/smp.h, include/linux/alloc_tag.h, include/linux/percpu.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

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

