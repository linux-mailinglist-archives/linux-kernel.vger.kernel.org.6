Return-Path: <linux-kernel+bounces-310223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED3496767A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 14:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D81A428244A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 12:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A4817DE16;
	Sun,  1 Sep 2024 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TeCcg+x6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A1D17C9E7
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725194867; cv=none; b=P8sIpHV0CPWx2uRf+PfR9w/SxxkkL751zq/pYjl1x5M4XA4PHT6cX7FB2xzaJMqXZVnXtYLLvaDHxpKC03WvSc3cp12Fh3mEUMpp8TWL5WWRlm93H7BL7I/mLt1YV9Q2bRX9dLN+dgn3Z4tQ/8JuXzLBn+PbcvaweOd9hjDKSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725194867; c=relaxed/simple;
	bh=lD5iHJTZ8qGFua2/c0koUs5VYOF3+zNOa9SZSaaEnpM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OkoCmiawJ1TEJkRiWphRwtrjvG5LA38G9G7GdRJSmWQSVMelEKSsSEBilT9cmJnfuIi8gusUZMix/jWdeG/E67LMfw3vK9dvMXj1zMCqnuDbIIgLdHrpm9VPC8KFzah7JksGy95dSF4oyD+AmBjvrr4pViXqlUuzznqwyY2AoZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TeCcg+x6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725194866; x=1756730866;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lD5iHJTZ8qGFua2/c0koUs5VYOF3+zNOa9SZSaaEnpM=;
  b=TeCcg+x6UCzTFWVRh6/vF9D0DdN8kc2uHWCwVfihJjbbMYWP3bydO8fP
   LMpmbpawD+viiVViIqQtxeMx2iGm+NzoZUoDlt+Kn28o1JIpBQ4x9MI+s
   mm0AfxLYWITgGC1hz1vcJt694VfEvW7VlosKt78K/neABFpV/ktXTHusC
   qoxRsaGLtubUYPV0gl+7RNmfvtBpdPaS5bnjgBm7H1T2liO3hfrpA1ZEI
   GYKlyyKxuYKehEiYuxuS79+nmvgKe4Jri5pZrgZUtrQJDXTUupnPnMECT
   R9fHSm3S5aVMyBl3SAnVnphWSdA2PeLLJusiC7vfH4rbuggTFYC9GyB3b
   A==;
X-CSE-ConnectionGUID: /Gpu3h9OSPeJtkU3wkIm9A==
X-CSE-MsgGUID: 5+HGydPaQmyyJ7G/7Gtqjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="34445310"
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="34445310"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 05:47:45 -0700
X-CSE-ConnectionGUID: aRFFZCYqQ9KMS7hYTCAppQ==
X-CSE-MsgGUID: WOcwajdETxGSgiJSXsJSOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="95148323"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 01 Sep 2024 05:47:43 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skjzZ-0003ds-0H;
	Sun, 01 Sep 2024 12:47:41 +0000
Date: Sun, 1 Sep 2024 20:46:44 +0800
From: kernel test robot <lkp@intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: loongarch64-linux-ld: net-sysfs.c:undefined reference to `dql_group'
Message-ID: <202409012047.eCaOdfQJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   431c1646e1f86b949fa3685efc50b660a364c2b6
commit: 74293ea1c4db62cb969e741fbfd479a34d935024 net: sysfs: Do not create sysfs for non BQL device
date:   7 months ago
config: loongarch-randconfig-r113-20240820 (https://download.01.org/0day-ci/archive/20240901/202409012047.eCaOdfQJ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240901/202409012047.eCaOdfQJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409012047.eCaOdfQJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: net/core/net-sysfs.o: in function `.L778':
   net-sysfs.c:(.text+0x5894): undefined reference to `dql_group'
>> loongarch64-linux-ld: net-sysfs.c:(.text+0x589c): undefined reference to `dql_group'
   loongarch64-linux-ld: net/core/net-sysfs.o: in function `.L790':
   net-sysfs.c:(.text+0x5b50): undefined reference to `dql_group'
   loongarch64-linux-ld: net-sysfs.c:(.text+0x5b58): undefined reference to `dql_group'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

