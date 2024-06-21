Return-Path: <linux-kernel+bounces-224777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC319126C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1841F26B23
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6C48BFD;
	Fri, 21 Jun 2024 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHdKbCkS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F47B4A20;
	Fri, 21 Jun 2024 13:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977092; cv=none; b=PJsDLN2kiA5MGGCJC1vJMYBIc41/aoCL48vtILfJdye2IvSVsN9VQ4gDHnV2Nj4OVVpWDe78OzDvgSYX7vjVLYMbuvEBdGrdLDV6h92H5jvjAcBtEW7TOVQX8QmgazHXwdjHrLpwZwpZVqpZDQGJQmKFuzTBvYgEfXn1Xory5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977092; c=relaxed/simple;
	bh=Wnt3WU4RUTET9RwLucGLgkXSCd/bMmWEz1gIfD3aWCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CR9BtW6I8fM7qWKo7l/0CHBa4vfTOQdh/v+lIcD0EscFi0zZl0lSfNYiXIpwpEZ+FzYYAErOJ75Jdjw6aNbDlYphhL32qmLJnyuMoSI2ywPEZDh+RlD7al/iNYvozy+dAXrqB+8K5gsOoz0j6diCc94ZqllXWgeezDqfNJjYKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHdKbCkS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718977090; x=1750513090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wnt3WU4RUTET9RwLucGLgkXSCd/bMmWEz1gIfD3aWCY=;
  b=OHdKbCkSOjJPF74jAXZbLMV2R8FChQLvXgTTjfqBSUhbDv4exVBkppK9
   xoVPaGZHMpyzxa56SX8hQl8Bf4zJavvE/GHyKs2cdq6L2El6HFIm1ZKFo
   KA69x9/z6zD/OE6Lqm+k7y1xJFN8KJruZlsw8WItQ6EPvMpVmslAlc+oI
   KTAPWITAGJxcspDctzLfNPrRFwa1GzxLJUkYwaOmNhvRkoFKQPmAlZgFB
   PNREGRym5AuaIgSfJ82ahulYnffxu0zDKTqQrJxddmMiOzsqPZdX/XnY0
   rbeUrbAjS+zk0sJtfwy4ymU5v7PsaEr0O+tPKJWU7N3WCgaEMUHihV8p/
   Q==;
X-CSE-ConnectionGUID: 8RMM3hNjS/uX0nbFzG8Cxw==
X-CSE-MsgGUID: d+r+qgUHRkimZ3jPlT5pnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="15767113"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="15767113"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 06:38:09 -0700
X-CSE-ConnectionGUID: Sc6VMFyDQIuwGa7SGBbTVA==
X-CSE-MsgGUID: hu8rEjFlTZa/euaLqURWFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="42501362"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 21 Jun 2024 06:38:05 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKeSp-0008cY-07;
	Fri, 21 Jun 2024 13:38:03 +0000
Date: Fri, 21 Jun 2024 21:37:42 +0800
From: kernel test robot <lkp@intel.com>
To: Yuntao Dai <d1581209858@live.com>, jassisinghbrar@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	unicorn_wang@outlook.com, inochiama@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	Yuntao Dai <d1581209858@live.com>
Subject: Re: [PATCH 3/3] mailbox: sophgo: add mailbox driver for cv18x SoCs
Message-ID: <202406212145.yo80iIS0-lkp@intel.com>
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
config: powerpc-randconfig-r121-20240621 (https://download.01.org/0day-ci/archive/20240621/202406212145.yo80iIS0-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240621/202406212145.yo80iIS0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406212145.yo80iIS0-lkp@intel.com/

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

