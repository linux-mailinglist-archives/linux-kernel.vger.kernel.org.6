Return-Path: <linux-kernel+bounces-430474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1569E3159
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 03:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B0C92874EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E392E62B;
	Wed,  4 Dec 2024 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zjh0yc4u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108BD17BCA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278775; cv=none; b=IIHa0qrBXy1asucgP99l/Pe27JBF9S+OIgVE3bwtT9SB09Tv+x+LM5cotEj6GwvFfp1dwUJwDXywFK7+yOw4sMcW7nXRDexoPAxnaY6ASsGy4a/D15YSe0HcHwaIoLAbf+k3tNjH0gUO0eVLK+EDCT6bGRQAqdIU/zu3NxsQBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278775; c=relaxed/simple;
	bh=wi11SfWz/6zS0Pk8E1VA7e+kzU8B4OpUzH1KkaB3P5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wb4Ol6Zq/lExp4CQkiRAoDpfSDPTl5ORsGFxLvpQgaPzv8d6YF4cFPJLuC4lmvxDHA9QguKrSwt3P9fUPfSuNoChmX9J7HVqIbmp6TD/Z9CdMUYRm2Kva6V/GZTgRU+6tHEKJ0fphqIjXaoUbRGYbH1gfr477g1syMCQFXKPn44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zjh0yc4u; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733278773; x=1764814773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wi11SfWz/6zS0Pk8E1VA7e+kzU8B4OpUzH1KkaB3P5Q=;
  b=Zjh0yc4uVdTsZowgKCm8/S3pUJ+f+Pz9+Ap1NUUkqx3i8ESExjvzqkOh
   WZaPVTuAzfbiei0zYoRe3USGpOTKggGEVm1rb7INPPcyLr3RXo7dpZqzs
   0zIKW0tXwHt2SeFiI92ksPxesND9pNrYU/x7v542gBfuNCg4ker/CJTUd
   zdjO82Ps12LJ9c25zPEZqdChlPbDC+PM63wnFzhwhkW6WSONJiH1siX2V
   Kz2RvqkNNasLR2Obs/8QQnbqDxi8MRM5wiXKnPR1UX1Ke0SH76SOKRGJw
   JMb3o7AiWsinnIv4VBT8tASJaSxrkK4ImmF5Y2FCbC6FlQshI0V+6lLZX
   w==;
X-CSE-ConnectionGUID: /yiXXV5ZSkOM/C0KkLAkSA==
X-CSE-MsgGUID: 2x6REq8VQ6yzoZfPacSRZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="37297149"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="37297149"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 18:19:32 -0800
X-CSE-ConnectionGUID: Lx09kYhrSfWTNj65jol4ZQ==
X-CSE-MsgGUID: +nfuBq5CRMK2hzdFGzfaSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="124451647"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 03 Dec 2024 18:19:30 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIez6-0000Sz-1z;
	Wed, 04 Dec 2024 02:19:26 +0000
Date: Wed, 4 Dec 2024 10:18:22 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Penkler <dpenkler@gmail.com>, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux@roeck-us.net,
	Dave Penkler <dpenkler@gmail.com>
Subject: Re: [PATCH v3] staging: gpib: Fix i386 build issue
Message-ID: <202412040913.WApPUuyd-lkp@intel.com>
References: <20241203084116.2228-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203084116.2228-1-dpenkler@gmail.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Penkler/staging-gpib-Fix-i386-build-issue/20241203-164356
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20241203084116.2228-1-dpenkler%40gmail.com
patch subject: [PATCH v3] staging: gpib: Fix i386 build issue
config: i386-randconfig-061-20241203 (https://download.01.org/0day-ci/archive/20241204/202412040913.WApPUuyd-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412040913.WApPUuyd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412040913.WApPUuyd-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1019:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1020:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1021:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1022:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1023:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1024:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1025:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1026:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1027:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1028:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1029:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1030:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1031:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1032:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1033:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1034:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1038:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1039:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1040:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1041:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1042:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1043:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1044:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1045:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1046:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1047:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1048:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1049:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1050:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1051:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1052:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1053:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1054:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1055:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1056:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1057:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1058:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1059:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1060:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1061:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1062:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1066:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1067:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1068:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1069:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1070:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1071:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1072:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1073:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1074:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1075:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1076:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1077:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1078:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1079:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1080:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1081:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1082:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1083:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1084:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1085:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1086:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1087:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1088:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1089:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1090:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1094:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1095:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1096:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1097:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1098:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1099:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1100:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1101:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1102:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1103:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1104:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1105:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1106:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1107:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1108:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1109:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1110:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1111:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1112:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1113:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1114:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1115:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1116:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1117:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1118:1: sparse: sparse: obsolete struct initializer, use C99 syntax
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:897:18: sparse: sparse: symbol 'ni_pci_interface' was not declared. Should it be static?
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:925:18: sparse: sparse: symbol 'ni_pci_accel_interface' was not declared. Should it be static?
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:953:18: sparse: sparse: symbol 'ni_isa_interface' was not declared. Should it be static?
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:981:18: sparse: sparse: symbol 'ni_nat4882_isa_interface' was not declared. Should it be static?
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1009:18: sparse: sparse: symbol 'ni_nec_isa_interface' was not declared. Should it be static?
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1037:18: sparse: sparse: symbol 'ni_isa_accel_interface' was not declared. Should it be static?
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1065:18: sparse: sparse: symbol 'ni_nat4882_isa_accel_interface' was not declared. Should it be static?
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1093:18: sparse: sparse: symbol 'ni_nec_isa_accel_interface' was not declared. Should it be static?
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1423:31: sparse: sparse: Using plain integer as NULL pointer
>> drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1443:26: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *iobase @@     got void [noderef] __iomem * @@
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1443:26: sparse:     expected void *iobase
   drivers/staging/gpib/tnt4882/tnt4882_gpib.c:1443:26: sparse:     got void [noderef] __iomem *

vim +1443 drivers/staging/gpib/tnt4882/tnt4882_gpib.c

  1396	
  1397	static int ni_isa_attach_common(gpib_board_t *board, const gpib_board_config_t *config,
  1398					enum nec7210_chipset chipset)
  1399	{
  1400		struct tnt4882_priv *tnt_priv;
  1401		struct nec7210_priv *nec_priv;
  1402		int isr_flags = 0;
  1403		resource_size_t iobase;
  1404		unsigned long ibbase;
  1405		int irq;
  1406	
  1407		board->status = 0;
  1408	
  1409		if (tnt4882_allocate_private(board))
  1410			return -ENOMEM;
  1411		tnt_priv = board->private_data;
  1412		tnt_priv->io_writeb = outb_wrapper;
  1413		tnt_priv->io_readb = inb_wrapper;
  1414		tnt_priv->io_writew = outw_wrapper;
  1415		tnt_priv->io_readw = inw_wrapper;
  1416		nec_priv = &tnt_priv->nec7210_priv;
  1417		nec_priv->type = chipset;
  1418		nec_priv->read_byte = nec7210_locking_ioport_read_byte;
  1419		nec_priv->write_byte = nec7210_locking_ioport_write_byte;
  1420		nec_priv->offset = atgpib_reg_offset;
  1421	
  1422		// look for plug-n-play board
  1423		if (config->ibbase == 0) {
  1424			struct pnp_dev *dev;
  1425			int retval;
  1426	
  1427			retval = ni_isapnp_find(&dev);
  1428			if (retval < 0)
  1429				return retval;
  1430			tnt_priv->pnp_dev = dev;
  1431			iobase = pnp_port_start(dev, 0);
  1432			irq = pnp_irq(dev, 0);
  1433		} else {
  1434			ibbase = (unsigned long)config->ibbase;
  1435			iobase = ibbase;
  1436			irq = config->ibirq;
  1437		}
  1438		// allocate ioports
  1439		if (!request_region(iobase, atgpib_iosize, "atgpib")) {
  1440			pr_err("tnt4882: failed to allocate ioports\n");
  1441			return -1;
  1442		}
> 1443		nec_priv->iobase = ioremap(iobase, pnp_port_len(tnt_priv->pnp_dev, 0));
  1444	
  1445		// get irq
  1446		if (request_irq(irq, tnt4882_interrupt, isr_flags, "atgpib", board)) {
  1447			pr_err("gpib: can't request IRQ %d\n", irq);
  1448			return -1;
  1449		}
  1450		tnt_priv->irq = irq;
  1451	
  1452		tnt4882_init(tnt_priv, board);
  1453	
  1454		return 0;
  1455	}
  1456	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

