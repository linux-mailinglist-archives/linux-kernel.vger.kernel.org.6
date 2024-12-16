Return-Path: <linux-kernel+bounces-447829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B849F3795
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D696C1888DED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CEE2063E3;
	Mon, 16 Dec 2024 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDAxNWif"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BD313B792;
	Mon, 16 Dec 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370240; cv=none; b=VPvW26aJQ0HC6oQJ/M40oaYHzMo/8rd7VkZNHcnvU/X8SrNIbrWOP+V0S85hrfdt2zjiw9ssXLryt4hqxQwzg5oanv/Hgw99QOPhz5MPENnQms7o7Kcq7zF3INhLHB0h2D8L0ushz/Ua4WSHnkM4LmCy23sslwBtLRbO/KwS/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370240; c=relaxed/simple;
	bh=0GHTmDW24yDL/L87YNar8k/bzXJLqW1qzxXU3jUJqm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXUfqfRS+lNyHfroYYUtO8RwZp+NYIQSBRj5RFYfZvzoi5WIzyN34/IGtrBgYIXLV13GuXhfbG1IFTetvKBJ0x+ZfaiSvV/sUmuX8Wp69kP+rL/XJiKH4vF6Y4Ph4dI3X9JgYOlsFHRgXl7lG2DEGa/xdJnWIFeDvZFT924trLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDAxNWif; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734370238; x=1765906238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0GHTmDW24yDL/L87YNar8k/bzXJLqW1qzxXU3jUJqm8=;
  b=dDAxNWifmh/Xkvnj1CJuS8PQ48VIcdD+TUj1IGL4yVBUWt9tGmTvoBta
   8sYnR+HNhSbuZxhrxl4kDLGOvGwIiSh8M+23HVJgDtBnniMQood5SjM8p
   mC6MsbHlPszScJUMYEU9kT/vhV2zRocxrQ5WZIVwI8HT38iHK6vfjOabM
   Yp94VrgjVV7HEXj6uSUisv3vDXYapZHTPyen1d63hcFyB/RE0irbsPu4q
   +GDqVqdUjSebNDIRqXofPfTVgy19lw6T6gCc+W8syzNZ9B98YvetRiPWR
   0elNnNZrm5xDBpOcUH3mdhM6xxKdMKQRQQEqWsyVHP29Uwfv6ie9Oh5EF
   Q==;
X-CSE-ConnectionGUID: qOGLaWdXQbyqZRy4YA9qnQ==
X-CSE-MsgGUID: d4N+wPzHTNOSBo9pNTfQVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="38445520"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="38445520"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 09:30:37 -0800
X-CSE-ConnectionGUID: svyeDUJLS5e0ZfTRRRv9iw==
X-CSE-MsgGUID: EWI4KAF3S7CLXQ763EqQ/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134602748"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 Dec 2024 09:30:34 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNEvP-000EMq-2r;
	Mon, 16 Dec 2024 17:30:31 +0000
Date: Tue, 17 Dec 2024 01:30:03 +0800
From: kernel test robot <lkp@intel.com>
To: Geoffrey Chien <geoffrey_chien@pegatron.corp-partner.google.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	herbert1_wu@pegatron.corp-partner.google.com,
	Thomas_Hsieh@pegatron.corp-partner.google.com,
	Geoffrey Chien <geoffrey_chien@pegatron.corp-partner.google.com>
Subject: Re: [PATCH] arm64: dts: mt8186: Add mt8186-skitty
Message-ID: <202412170154.QsBtjHdl-lkp@intel.com>
References: <20241216-skitty_kernel-v1-1-bc75dcdfeb57@pegatron.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216-skitty_kernel-v1-1-bc75dcdfeb57@pegatron.corp-partner.google.com>

Hi Geoffrey,

kernel test robot noticed the following build errors:

[auto build test ERROR on 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8]

url:    https://github.com/intel-lab-lkp/linux/commits/Geoffrey-Chien/arm64-dts-mt8186-Add-mt8186-skitty/20241216-153651
base:   78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
patch link:    https://lore.kernel.org/r/20241216-skitty_kernel-v1-1-bc75dcdfeb57%40pegatron.corp-partner.google.com
patch subject: [PATCH] arm64: dts: mt8186: Add mt8186-skitty
config: arm64-randconfig-003-20241216 (https://download.01.org/0day-ci/archive/20241217/202412170154.QsBtjHdl-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241217/202412170154.QsBtjHdl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412170154.QsBtjHdl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dtsi:42.1-8 Label or path target not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

