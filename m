Return-Path: <linux-kernel+bounces-251977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CA5930C78
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 04:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15594281495
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 02:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB165672;
	Mon, 15 Jul 2024 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRUs0/TV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79D5695;
	Mon, 15 Jul 2024 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721008804; cv=none; b=NHBk3xiG9R1SuqqAju/vQ/wjVAoA5ySEWzb/boY7twaV/kfy+7Q6gF10t0XO1SHZgpIGVsgUxUM1ja4jgtOZhLUpxAuFx0GaIP3Ji1R63ZtX8wtZijQyo22sw4XcU7e7mL6KAkBV7504/V9ghpBwHaea0Yn9I8VVVRp2qWBqJe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721008804; c=relaxed/simple;
	bh=eFeM/mubVUDDERtFQAHi8bGxnrvJRVJGCBfZtYGgymA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAfHf7XKNa6czgikZOGpRWWS9OkDZNIHXwEf5OiuCwkw1qg4gyfJbc7GXO1jqSln7Ffqo8sE2YnGKHlRC4XoJiBkeAzdwxWxdM1On+Le8m9WlZpMBIyufhIcMtIDZuLQH7LAVYEHpYVPeptps9a6lYoLThyTLKFA9juhqaJH6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRUs0/TV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721008803; x=1752544803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eFeM/mubVUDDERtFQAHi8bGxnrvJRVJGCBfZtYGgymA=;
  b=LRUs0/TVyBJxFogezK/8GwL3JDMI9lloxVb4CEFtA8+iGRdZo8lY6P4D
   pc4VFwskTKD1ibcyRP2VAjVEUNxfh4+GxjKIDUOcDfKV0SoE6df+V+R98
   j8x51E3kF1UlsKapp3QiLt8lucD3W7J1m963JGfCBWhhC5T/sKUjWhmtW
   55YachrZDxkxOjvnGPnWlzCyREor+25HL39QL1AfoHyeQSlwabQ2t1gr6
   jIUlodg9FNNzEdsj0sizMrIZ7TE8LAqB8QJQKBKNkLDhAsd367Z0QQgzt
   v1BxoBGqWcnR4Z1Vzk16MDccbQFX3Mz6RdCnCAx2rWgkl6xITxwl9E372
   A==;
X-CSE-ConnectionGUID: p3iLMrWWTeGv5SQxbfqUsA==
X-CSE-MsgGUID: mzwK6jENRY+JBZO+DLMaLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="28977055"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="28977055"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2024 19:00:02 -0700
X-CSE-ConnectionGUID: x8eZ/MO0TkeFXyGhdI9v4Q==
X-CSE-MsgGUID: 2zoIrlmTRBuw5qQNvc/QMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="54294866"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Jul 2024 18:59:58 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sTB0O-000dru-15;
	Mon, 15 Jul 2024 01:59:56 +0000
Date: Mon, 15 Jul 2024 09:59:12 +0800
From: kernel test robot <lkp@intel.com>
To: Yuntao Dai <d1581209858@live.com>, jassisinghbrar@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	unicorn_wang@outlook.com, inochiama@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	Yuntao Dai <d1581209858@live.com>
Subject: Re: [PATCH v2 3/3] mailbox: sophgo: add mailbox driver for cv18x SoCs
Message-ID: <202407150911.KZchf5cj-lkp@intel.com>
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
[also build test WARNING on linus/master v6.10 next-20240712]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuntao-Dai/dt-bindings-mailbox-add-Sophgo-cv18x-SoCs-mailbox/20240715-003952
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/SYBP282MB2238F93565D20F0A5F3EEB6BC4A02%40SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
patch subject: [PATCH v2 3/3] mailbox: sophgo: add mailbox driver for cv18x SoCs
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240715/202407150911.KZchf5cj-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240715/202407150911.KZchf5cj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407150911.KZchf5cj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mailbox/cv1800-mailbox.c:30: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * cv1800 mailbox channel private data


vim +30 drivers/mailbox/cv1800-mailbox.c

    28	
    29	/**
  > 30	 * cv1800 mailbox channel private data
    31	 * @idx: index of channel
    32	 * @cpu: send to which processor
    33	 */
    34	struct cv1800_mbox_chan_priv {
    35		int idx;
    36		int cpu;
    37	};
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

