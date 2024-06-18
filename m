Return-Path: <linux-kernel+bounces-220326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4589F90DFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3348B22094
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950121849D8;
	Tue, 18 Jun 2024 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="clSharj2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD6D1741E4;
	Tue, 18 Jun 2024 23:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718752893; cv=none; b=a/jhPSm1T/RfvLLGcVYXK46go1l69tg22Bs8l9rt27si3q+6PH0ZEBHi+SvJ8PLbkro+rQiRzNFP/o9lYHiuUyv3ppkv51CoCG0FgAfor3S8ezqzBrITxldgCDOhvyq7m/EtalWYxeLqp4x72YdDBmJJ0idMYFpyDP7tnX09Abg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718752893; c=relaxed/simple;
	bh=v/NlBfEfE5g1MehnEEQEfq87Nz3xvgIrz+Ciiv2rTtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxCckxHWUhEPoSgoCOdB9DtkvUIW8q3k5mAsxkEWm1nEYmC2HHwradudhAgJkVagxFWGIGb7oqsiXnxOJVnMNk6di9S3hIIgeX1rvvVbOTKb3Z79CvAd79csYLV2cVNYnp8iUhLn/EL2nz2kbE3xcWhVmMmHuJCc3nweJV9wVuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=clSharj2; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718752892; x=1750288892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v/NlBfEfE5g1MehnEEQEfq87Nz3xvgIrz+Ciiv2rTtU=;
  b=clSharj2YJgBI3E/qWBuZzun9Nj3Ql7gOQJDHgKPdiyDNNWGxthby+KC
   qq9tzkcLeOXj+7GVS+mUy1SkxSmaKGo0CH+GfqxfN2+17VFVy1W/c4uiu
   4L2vPRrffXxbyS+dWxyMLjJ4bnHgEH9EIHii+bPog8BxottJDwSupjnLd
   b4cuARyQ6ohfXwuL5WJA3lMcz3Hg057FnH/Lt4UzQWB4ZaUe2MALRLusy
   9OX2ORRUtaGUsXUfOUmDdLwMfwRM75J57Nq66c0vtWxCtlnVPPUJVzJMJ
   mO2qUL9pNV+k8knGyoMRcnKrvEJJU+Hn9wxcL90CG8tKuCN1ZaeOD0njD
   Q==;
X-CSE-ConnectionGUID: VrmxjojKSByadu/PEEQeJQ==
X-CSE-MsgGUID: +47eyExwQkiWf4gANq84pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="18582746"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="18582746"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 16:21:31 -0700
X-CSE-ConnectionGUID: f+n0ED0bQMWg+K7pz4MA/w==
X-CSE-MsgGUID: UbJXJqC2QKmmTy6JXU8KIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="72464871"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 18 Jun 2024 16:21:27 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJi8j-00061a-1t;
	Tue, 18 Jun 2024 23:21:25 +0000
Date: Wed, 19 Jun 2024 07:21:23 +0800
From: kernel test robot <lkp@intel.com>
To: Yuntao Dai <d1581209858@live.com>, jassisinghbrar@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	unicorn_wang@outlook.com, inochiama@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	Yuntao Dai <d1581209858@live.com>
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
Message-ID: <202406190627.BcUP9uUN-lkp@intel.com>
References: <SYBP282MB22389FD1E07BBDC6FE1D90A0C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBP282MB22389FD1E07BBDC6FE1D90A0C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>

Hi Yuntao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.10-rc4 next-20240618]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuntao-Dai/dt-bindings-mailbox-add-Sophgo-cv18x-SoCs-mailbox/20240618-232307
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/SYBP282MB22389FD1E07BBDC6FE1D90A0C4CE2%40SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM
patch subject: [PATCH 1/3] dt-bindings: mailbox: add Sophgo cv18x SoCs mailbox
config: arc-randconfig-051-20240619 (https://download.01.org/0day-ci/archive/20240619/202406190627.BcUP9uUN-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406190627.BcUP9uUN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406190627.BcUP9uUN-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.yaml: recvid: missing type definition
>> Documentation/devicetree/bindings/mailbox/sophgo,cv1800b-mailbox.yaml: sendto: missing type definition

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

