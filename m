Return-Path: <linux-kernel+bounces-252280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC35D9310E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7677B1F221DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE44186E2C;
	Mon, 15 Jul 2024 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0Yb9hnN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46815223;
	Mon, 15 Jul 2024 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034595; cv=none; b=FukMA+Oj0C82+1CSKSXQwSuc3KcyRAslnzKJatslscdn8BNWzunLYFHFMu2xZewqwA+CA1ZdizBmP2mu/UrBKsPbohBnhe2lWlXYtPuEjx6pGxSLMnrKsu+UYNsAE0an6Ezg2lchc1v6OnlDfmxUrttJ1ccHwA0kMQFVGqhAv6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034595; c=relaxed/simple;
	bh=9VQl3YvtCVqzJrmMa8ve+rPTBLk5zbjsSx4SZChw0R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwauPVTWQwX5PsmQi8S9EoSvuj9yye1t5UKXTNW+hUaVQjUDu07PrOlOSY+A4APT4xlEFfBB6YYQd0N7FSJIibGaeQu3/jC8Vml4V6KlklW9i06UjkT60ymyQNhYwjrasx4BUJoLKI3H90uM126ADMglR89XiSBLtyqbqepPhno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0Yb9hnN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721034594; x=1752570594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9VQl3YvtCVqzJrmMa8ve+rPTBLk5zbjsSx4SZChw0R4=;
  b=f0Yb9hnNyw5FNPbJSkIpG7lfRAu/5B5zosvv7pUdUokCh0ePxv1BYGQp
   THL6NYY8awWR+DJMwmMZVHvYMIyjBE+pf+mTttRc7uGBxUZRyvNh3Ad8j
   yiYZRyL8I/KYBirUbLft1R0Kfykf8XNPLBUpPC1ecZVfX6vYUrc0jBY/Z
   GXnlu/PHk0uahUJIjyodv2+1miA2yqj58BAA2ZFDZDg78X8TNNPr/vvUt
   EZGktfZddG1EQ+IPL2Ja/k7IOfj9BxzBXpQE80Rq4dE6NPVGaz29JVrH2
   ZHUmW1StinxuWY9+wkdBBuO6nCuElYn5C8t/pCuDQ9fTGJ9m1POwhYbPw
   w==;
X-CSE-ConnectionGUID: lwTH6wp0ROGnKMuPiQbwlA==
X-CSE-MsgGUID: 4ehZKwiNSIaMDbfeJkkCQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18247913"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="18247913"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 02:09:54 -0700
X-CSE-ConnectionGUID: rFW3txrQRs+va6vRHZPgIg==
X-CSE-MsgGUID: S8ahSpr1RMy1P74Ohlqc1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="54738169"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 15 Jul 2024 02:09:50 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTHiN-000eAQ-2x;
	Mon, 15 Jul 2024 09:09:47 +0000
Date: Mon, 15 Jul 2024 17:09:34 +0800
From: kernel test robot <lkp@intel.com>
To: Yuntao Dai <d1581209858@live.com>, jassisinghbrar@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	unicorn_wang@outlook.com, inochiama@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	Yuntao Dai <d1581209858@live.com>
Subject: Re: [PATCH v2 3/3] mailbox: sophgo: add mailbox driver for cv18x SoCs
Message-ID: <202407151649.ExTr3xXL-lkp@intel.com>
References: <SYBP282MB2238F93565D20F0A5F3EEB6BC4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBP282MB2238F93565D20F0A5F3EEB6BC4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>

Hi Yuntao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.10 next-20240715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuntao-Dai/dt-bindings-mailbox-add-Sophgo-cv18x-SoCs-mailbox/20240715-003952
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/SYBP282MB2238F93565D20F0A5F3EEB6BC4A02%40SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
patch subject: [PATCH v2 3/3] mailbox: sophgo: add mailbox driver for cv18x SoCs
config: powerpc-randconfig-r113-20240715 (https://download.01.org/0day-ci/archive/20240715/202407151649.ExTr3xXL-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240715/202407151649.ExTr3xXL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407151649.ExTr3xXL-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mailbox/cv1800-mailbox.c:56:62: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *data @@     got unsigned long long [noderef] [usertype] __iomem * @@
   drivers/mailbox/cv1800-mailbox.c:56:62: sparse:     expected void *data
   drivers/mailbox/cv1800-mailbox.c:56:62: sparse:     got unsigned long long [noderef] [usertype] __iomem *
>> drivers/mailbox/cv1800-mailbox.c:78:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/mailbox/cv1800-mailbox.c:78:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] [usertype] __iomem *addr @@     got unsigned long long [usertype] * @@
   drivers/mailbox/cv1800-mailbox.c:78:22: sparse:     expected unsigned long long [noderef] [usertype] __iomem *addr
   drivers/mailbox/cv1800-mailbox.c:78:22: sparse:     got unsigned long long [usertype] *
   drivers/mailbox/cv1800-mailbox.c:102:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/mailbox/cv1800-mailbox.c:102:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned long long [noderef] [usertype] __iomem *addr @@     got unsigned long long [usertype] * @@
   drivers/mailbox/cv1800-mailbox.c:102:14: sparse:     expected unsigned long long [noderef] [usertype] __iomem *addr
   drivers/mailbox/cv1800-mailbox.c:102:14: sparse:     got unsigned long long [usertype] *

vim +56 drivers/mailbox/cv1800-mailbox.c

    47	
    48	static irqreturn_t cv1800_mbox_isr(int irq, void *dev_id)
    49	{
    50		struct cv1800_mbox *mbox = (struct cv1800_mbox *)dev_id;
    51		size_t i;
    52	
    53		for (i = 0; i < MAILBOX_MAX_CHAN; i++) {
    54			if (mbox->content[i] && mbox->chans[i].cl) {
    55				mbox_chan_received_data(&mbox->chans[i],
  > 56							mbox->content[i]);
    57				mbox->content[i] = NULL;
    58				return IRQ_HANDLED;
    59			}
    60		}
    61		return IRQ_NONE;
    62	}
    63	
    64	static irqreturn_t cv1800_mbox_irq(int irq, void *dev_id)
    65	{
    66		struct cv1800_mbox *mbox = (struct cv1800_mbox *)dev_id;
    67		u64 __iomem *addr;
    68		u8 set, valid;
    69		size_t i;
    70	
    71		set = readb(mbox->mbox_base + MBOX_SET_INT_REG(RECV_CPU));
    72	
    73		if (!set)
    74			return IRQ_NONE;
    75	
    76		for (i = 0; i < MAILBOX_MAX_CHAN; i++) {
    77			valid = set & (1 << i);
  > 78			addr = (u64 *)(mbox->mbox_base + MAILBOX_CONTEXT_OFFSET) + i;
    79			if (valid) {
    80				mbox->content[i] = addr;
    81				writeb(valid,
    82				       mbox->mbox_base + MBOX_SET_CLR_REG(RECV_CPU));
    83				writeb(~valid, mbox->mbox_base + MBOX_EN_REG(RECV_CPU));
    84				return IRQ_WAKE_THREAD;
    85			}
    86		}
    87	
    88		return IRQ_NONE;
    89	}
    90	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

