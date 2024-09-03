Return-Path: <linux-kernel+bounces-312200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E6E969373
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D40FB21182
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F2D1CF280;
	Tue,  3 Sep 2024 06:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYquRZgT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F91CEAB2;
	Tue,  3 Sep 2024 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725343848; cv=none; b=gI5xr3I3YOfuJKSydb3kDhwrJ9EIZhJI8LeiWvpWvf6MM+FKR2zcNn88/GbLxAWQyH+iJkGOeF0IWYygwCQLTSaosqZSmmRU7h19tyNEdFC926lw/6wqY3/4oEB7DAgPxnue8A5sbKLYlQ/2rjIpQePuw9+9Ju03o1EmWo/Ma5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725343848; c=relaxed/simple;
	bh=aYJh5fNp4QC9EhWbCRaM8ceBBTd5va9484C4zr8sDXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1oPsgzRC27knuwe1QgD5/IuPDNIUm96g/hdtSI6PwL1dwDl6WHO1HNvkRAx96iRjlHCAM3zFlnnEmkkh8AOaK4586IIJ+Xf/oobD23FrXTIRS+i4aQtODteLXeOs+t5LMWIGj+Fa+ThVMz5xeTw7/ez/FRolIuYyOlwAYcnXhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYquRZgT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725343847; x=1756879847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aYJh5fNp4QC9EhWbCRaM8ceBBTd5va9484C4zr8sDXo=;
  b=nYquRZgTawoKPhvbMvUTvRu0f6/YhbmAi/r2sK25yUc99YlFY99jxcUI
   V5LcxIpyvmekMajzzvYTSUS3atv5I/cjzj/WpZZ68yw1Z5RPD4oVPOQHi
   SKsuDtVm0CVuGzmKvIdIUNEclFUojIXhLWwGwHNuzD1t8Mu+j4fFw6jdn
   ynAPKH2CneW+BfzqPnxQl6fkpMpaf6ohiSB+nE+ubes2NW7pXVo2iIqYH
   3MmIcQwmuBatxYVZOMk2UhaqUuHaDBfDuc3+p2pAReaM8sVkEuAD+SdYO
   9MXjOIZRMICsLty1D38d1HcqhEdhkB7La1h0ihbEmzkI+htZNOJFDCqWW
   A==;
X-CSE-ConnectionGUID: OFdUjNi7QxOK+RHCtuxKSA==
X-CSE-MsgGUID: xnX8ZtqrSUCRGS57+F3aAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="41393358"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="41393358"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 23:10:47 -0700
X-CSE-ConnectionGUID: LvvKY5cPQbKgpYBZ6pW+Gg==
X-CSE-MsgGUID: hh1hu8qVQ1WqvWVQbylEzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="95515310"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 02 Sep 2024 23:10:44 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slMkT-0006IG-16;
	Tue, 03 Sep 2024 06:10:41 +0000
Date: Tue, 3 Sep 2024 14:10:29 +0800
From: kernel test robot <lkp@intel.com>
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	knoxchiou@google.com, hsinyi@google.com
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: mediatek: Add MT8186 Ponyta
 Chromebooks
Message-ID: <202409031258.S4i2qVfW-lkp@intel.com>
References: <20240902125502.1844374-3-cengjianeng@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902125502.1844374-3-cengjianeng@huaqin.corp-partner.google.com>

Hi Jianeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.11-rc6 next-20240902]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jianeng-Ceng/dt-bindings-arm-mediatek-Add-MT8186-Ponyta-Chromebook/20240902-210651
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240902125502.1844374-3-cengjianeng%40huaqin.corp-partner.google.com
patch subject: [PATCH v1 2/2] arm64: dts: mediatek: Add MT8186 Ponyta Chromebooks
config: arm64-randconfig-002-20240903 (https://download.01.org/0day-ci/archive/20240903/202409031258.S4i2qVfW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240903/202409031258.S4i2qVfW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409031258.S4i2qVfW-lkp@intel.com/

All errors (new ones prefixed by >>):

   make[4]: *** No rule to make target 'arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-rev2-sku1.dtb', needed by 'arch/arm64/boot/dts/mediatek/'.
>> make[4]: *** No rule to make target 'arch/arm64/boot/dts/mediatek/mt8186-corsola-ponyta-rev2-sku0.dtb', needed by 'arch/arm64/boot/dts/mediatek/dtbs-list'.
   make[4]: Target 'arch/arm64/boot/dts/mediatek/' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

