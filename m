Return-Path: <linux-kernel+bounces-223710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 701EB91173C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 02:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90701F22ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC9A1366;
	Fri, 21 Jun 2024 00:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maP0PoYs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45882625;
	Fri, 21 Jun 2024 00:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929326; cv=none; b=k2gn6AsxvRwQ75O/quPp2fNiniyl5N237NLulVN77DM6nyuZ2gqzCYmb7L9rdsYg/ZOn4ezWZpuJNWfCajxa4Vy0hUiL+nw0IRNKR5mw1cqYqe9p/K45F1pZ6m7ulMdTovLPDfEzTVPhvCWw7WbGAg51rOQni6mG/5GLBcUdRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929326; c=relaxed/simple;
	bh=A5oOZHXU+IU0z5IfE4+M02oaOKdsfUbdPWbbLMxbgBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grTfe9iqzONniLC1dUOe8MwF2KvldP9k3nCLfn8/4sqRiCw8ykj8c5yrly2FVuN1B6PM6i0LSpiV33tNaR3XOBDQlj99t/uePPRy3gNap6FtgTxLPuwJFkfiPiUcKb1THUqfoN+8bYLzVmHHsowHHCKHAf4Tk1+rdpTsiSGkuC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maP0PoYs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718929326; x=1750465326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A5oOZHXU+IU0z5IfE4+M02oaOKdsfUbdPWbbLMxbgBY=;
  b=maP0PoYscxPG82n+H+ZjD+6bvCxbber356XXMr5yiRnFi1+KwoEldT77
   NkH9RGX+Vd3C2pTE8RWPMqXAGM5+OShxkmaqnj69+1DLFko1SLL91H/8X
   CEpCl/0yihRNbJ5YjzFvkcBAXaV1/330HCTSBzn0nM6eRYoMrRH4D7zBP
   mxze8XcJnCgCaRdbIrOnXGojV/nMvU+7q9EWOx0KQgA3FshOcgw6TvLEZ
   kz159ZzWVz35NDX61P3fgDjo3tBXjGYficU8an7QgYKB3ef4tLa9w8uVI
   bB8GAm3wAgRr7JeZU8rRSMWEmFcHSXktWsbASV2NjQq3Zv03p7h1veK6X
   w==;
X-CSE-ConnectionGUID: CUh+oiCnQEqLG8pxCQbIbg==
X-CSE-MsgGUID: B3wViMDXTousl/KerEOrMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="33403640"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="33403640"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 17:22:05 -0700
X-CSE-ConnectionGUID: 1vsqdwxiTimYX59IXwOCkg==
X-CSE-MsgGUID: iV7byUPPTrWfWCnKRy86tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; 
   d="scan'208";a="43094446"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 20 Jun 2024 17:22:01 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKS2Q-00083Q-2G;
	Fri, 21 Jun 2024 00:21:58 +0000
Date: Fri, 21 Jun 2024 08:21:23 +0800
From: kernel test robot <lkp@intel.com>
To: Yuntao Dai <d1581209858@live.com>, jassisinghbrar@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	unicorn_wang@outlook.com, inochiama@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	Yuntao Dai <d1581209858@live.com>
Subject: Re: [PATCH 3/3] mailbox: sophgo: add mailbox driver for cv18x SoCs
Message-ID: <202406210836.gWHxzdUE-lkp@intel.com>
References: <SYBP282MB2238F93AB57A398E322644C3C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBP282MB2238F93AB57A398E322644C3C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>

Hi Yuntao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.10-rc4 next-20240620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuntao-Dai/dt-bindings-mailbox-add-Sophgo-cv18x-SoCs-mailbox/20240618-232307
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/SYBP282MB2238F93AB57A398E322644C3C4CE2%40SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
patch subject: [PATCH 3/3] mailbox: sophgo: add mailbox driver for cv18x SoCs
config: powerpc-randconfig-r121-20240621 (https://download.01.org/0day-ci/archive/20240621/202406210836.gWHxzdUE-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240621/202406210836.gWHxzdUE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406210836.gWHxzdUE-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mailbox/cv1800b-mailbox.c:66:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mailbox/cv1800b-mailbox.c:85:22: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mailbox/cv1800b-mailbox.c:87:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got unsigned long long [usertype] *addr @@
   drivers/mailbox/cv1800b-mailbox.c:87:21: sparse:     expected void volatile [noderef] __iomem *d
   drivers/mailbox/cv1800b-mailbox.c:87:21: sparse:     got unsigned long long [usertype] *addr

vim +/__iomem +66 drivers/mailbox/cv1800b-mailbox.c

    51	
    52	static irqreturn_t cv1800b_mbox_irq(int irq, void *dev_id)
    53	{
    54		struct cv1800b_mbox *mbox = (struct cv1800b_mbox *)dev_id;
    55		u8 set, valid;
    56		u64 *addr;
    57		size_t i;
    58	
    59		set = readb(mbox->mbox_base + MBOX_SET_INT_REG(mbox->recvid));
    60	
    61		if (!set)
    62			return IRQ_NONE;
    63	
    64		for (i = 0; i < MAILBOX_MAX_CHAN; i++) {
    65			valid = set & (1 << i);
  > 66			addr = (u64 *)(mbox->mbox_base + MAILBOX_CONTEXT_OFFSET) + i;
    67			if (valid) {
    68				mbox->content[i] = addr;
    69				writeb(valid, mbox->mbox_base +
    70						      MBOX_SET_CLR_REG(mbox->recvid));
    71				writeb(~valid,
    72				       mbox->mbox_base + MBOX_EN_REG(mbox->recvid));
    73				return IRQ_WAKE_THREAD;
    74			}
    75		}
    76	
    77		return IRQ_NONE;
    78	}
    79	
    80	static int cv1800b_mbox_send_data(struct mbox_chan *chan, void *data)
    81	{
    82		struct cv1800b_mbox *mbox = dev_get_drvdata(chan->mbox->dev);
    83		int idx = (int)chan->con_priv;
    84		u8 en, valid;
    85		u64 *addr = (u64 *)(mbox->mbox_base + MAILBOX_CONTEXT_OFFSET) + idx;
    86	
  > 87		memcpy_toio(addr, data, 8);
    88	
    89		valid = 1 << idx;
    90		writeb(valid, mbox->mbox_base + MBOX_SET_CLR_REG(mbox->sendto));
    91		en = readb(mbox->mbox_base + MBOX_EN_REG(mbox->sendto));
    92		writeb(en | valid, mbox->mbox_base + MBOX_EN_REG(mbox->sendto));
    93		writeb(valid, mbox->mbox_base + MBOX_SET_REG);
    94	
    95		return 0;
    96	}
    97	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

