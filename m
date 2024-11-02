Return-Path: <linux-kernel+bounces-393124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE1E9B9C18
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 03:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE9C282956
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 02:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1319A43ACB;
	Sat,  2 Nov 2024 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZZA2A7v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4712E545
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 02:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730513115; cv=none; b=TC7NUiqZ80o+EhfkXuGyINDuhzlZi0Hk5zqiOSn6omqhDjBOo4lSO3vL6J2Rbcu5yFIEKtfKd6WNqr46D+JvvYnNf/Rl2EQpCxlGQtvB/Ye1JdAlsxxnlQSlcDAvKN/F2m1MhjDKL4mqGWdd2ZtEl0Xyfug0/S3FuOrhqCoCbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730513115; c=relaxed/simple;
	bh=izP0oBk62DXJy2OJ2RXIbSqrKdSfg33H0k6pVd8XtiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvo6xuncf61ZRM1UHx1vtASyyFGiNXDHkHwwNcne2KUgOrWV5Kcz+PU9mSHKDPGMtT+epH1lkQjzJA5ID0imJYBuzSAmkiL407/sspOloi9NXmaZdFDG3+uIqaCQ87UsJ18/0Az2NB+NjFHieXGyaurHDb+iN01WzvTtfqIr2gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZZA2A7v; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730513114; x=1762049114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=izP0oBk62DXJy2OJ2RXIbSqrKdSfg33H0k6pVd8XtiY=;
  b=HZZA2A7vfzETBKLcCU1wA0QuUt7g//U8FxgHp9qSNhRGEs8EXomfmAj1
   DbuqaUzQw+3WJuPxyYJI44rgn3Iatd2reMNO2cW/rQ2tzZgsy7LWSSIK4
   OoLiavIf5bSFD3YFBoOeeXdnzRCH7qURRV/yDBLrFC8l3TvHRrMDLkOCy
   Q2rCCbxpfvNa2z2frpn5oQfxF0opYKzhgZfH9s4VGm8UDv/OUHaM/r1v3
   GQyasYSgJL0FYBNSEjOkKTBQxEWO9FUuKjGLrQ0pQKU7BUzLgezPX13lo
   3E62HQT3U6cZbBosdHMwU7Lb8JkpsDVNt/ncqb0DthqzpnRPpUkigIjZC
   A==;
X-CSE-ConnectionGUID: ++FgXZozTh2x8TTnZhENvA==
X-CSE-MsgGUID: 828VC/hlRtGei8OvG5YuCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="33127551"
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="33127551"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 19:05:14 -0700
X-CSE-ConnectionGUID: VddqJ4heQIa+829KwFr0Lg==
X-CSE-MsgGUID: dQJrE7jnTseocIkYwXM+TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="87941872"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 01 Nov 2024 19:05:11 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t73Vk-000iIn-0R;
	Sat, 02 Nov 2024 02:05:08 +0000
Date: Sat, 2 Nov 2024 10:04:58 +0800
From: kernel test robot <lkp@intel.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH 5/5] mtd: rawnand: davinci: Implement setup_interface()
 operation
Message-ID: <202411020957.X1T8T9ZR-lkp@intel.com>
References: <20241030104717.88688-6-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030104717.88688-6-bastien.curutchet@bootlin.com>

Hi Bastien,

kernel test robot noticed the following build errors:

[auto build test ERROR on krzk-mem-ctrl/for-next]
[also build test ERROR on linus/master v6.12-rc5]
[cannot apply to mtd/nand/next next-20241101]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bastien-Curutchet/memory-ti-aemif-Create-aemif_set_cs_timings/20241030-184949
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git for-next
patch link:    https://lore.kernel.org/r/20241030104717.88688-6-bastien.curutchet%40bootlin.com
patch subject: [PATCH 5/5] mtd: rawnand: davinci: Implement setup_interface() operation
config: arm-randconfig-003-20241101 (https://download.01.org/0day-ci/archive/20241102/202411020957.X1T8T9ZR-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411020957.X1T8T9ZR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411020957.X1T8T9ZR-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/mtd/nand/raw/davinci_nand.o: in function `davinci_nand_setup_interface':
>> davinci_nand.c:(.text+0x688): undefined reference to `aemif_set_cs_timings'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

