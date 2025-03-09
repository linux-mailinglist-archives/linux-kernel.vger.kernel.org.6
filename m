Return-Path: <linux-kernel+bounces-553203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5B7A58587
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B6F3ABF28
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397291DF240;
	Sun,  9 Mar 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQkgWgI5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177998836;
	Sun,  9 Mar 2025 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741535483; cv=none; b=DjEBm23BiSGJmntLzWnUzKWwtQ33IICSH9tYYOfFgTmdM0OtkBdbvMnHGvvOnda3sWjmXXUw7dJ6GDNn4Cq6ZdnJhJsqfELu79jfVNEfIh5d9jML1v2zuIa8Nb2rdt3OfxyYpSGzfCvRFbFht7DklKs44Pi1nWetz7kTqdDMbeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741535483; c=relaxed/simple;
	bh=z26VWBNMz80YyF/hRHm8Hl23tDMXIjOJUiY/5dcLl2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exl1hRMGcwmrJyeu4ajzJjJBH26/DBA2hS1Hs3qdPSy9CK2TBQpDW3H9NTkypydUOxNYJpgCypC0Jv5CNchgKB76HW+nV+niHewJasoKIcx7G2qBLUvh56wdfg8qDuNmuP4R8SNGFbAsx/KH2nPciTRGrYZ/hERrOEF3vaNMSy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQkgWgI5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741535481; x=1773071481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z26VWBNMz80YyF/hRHm8Hl23tDMXIjOJUiY/5dcLl2Q=;
  b=mQkgWgI5eKCkAx7WYOKVlMXw1aQj8+lLLsJ2kk3aCdEwfOURLsVyzGVT
   E/fx1O0o+k8kfFTAmojXYer8cYYnJH7mZIguepPfAjzl8iDfwvKJO5dT1
   qQxdKs7Tz8+p8pNW0AYWmPBDtOXcu0OUNK6F9utsLs5rN6DloRRFf6APk
   6eU/S/BVZXqOQmQM2ruxdXR86MTIVNCOB7sSl7kFdGB8PbQex/Wi8S13I
   pxgrTaeS+CGKM1xjEQDLKZUztZOHbt3n6CtaWVTOEgZljYRbe2gfjOEq7
   YjliK+yM5we2f2NOPGtxDOSwbtZhL7C2on9A32IkLbh6aJ9PrUFjZVhtx
   Q==;
X-CSE-ConnectionGUID: XrGUtreURlCZqK0P8ujtqw==
X-CSE-MsgGUID: AlAosqvpSFyoCBNLcbDcpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42670980"
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="42670980"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2025 08:51:20 -0700
X-CSE-ConnectionGUID: aMKZlXlkRZmvTo3hOOJy6g==
X-CSE-MsgGUID: elAGiMi7SmG61Nx2Z1eQnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,234,1736841600"; 
   d="scan'208";a="124782869"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 09 Mar 2025 08:51:13 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1trIvi-0003Ey-22;
	Sun, 09 Mar 2025 15:51:07 +0000
Date: Sun, 9 Mar 2025 23:50:11 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>, Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <bwh@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org, upstream@airoha.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 09/13] dt-bindings: phy: Add documentation for Airoha
 AN7581 USB PHY
Message-ID: <202503092318.xReLDuUG-lkp@intel.com>
References: <20250309132959.19045-10-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309132959.19045-10-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20250307]
[also build test WARNING on v6.14-rc5]
[cannot apply to clk/clk-next robh/for-next usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.14-rc5 v6.14-rc4 v6.14-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/clk-en7523-convert-driver-to-regmap-API/20250309-213623
base:   next-20250307
patch link:    https://lore.kernel.org/r/20250309132959.19045-10-ansuelsmth%40gmail.com
patch subject: [PATCH 09/13] dt-bindings: phy: Add documentation for Airoha AN7581 USB PHY
reproduce: (https://download.01.org/0day-ci/archive/20250309/202503092318.xReLDuUG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503092318.xReLDuUG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/ja_JP/process/submit-checklist.rst references a file that doesn't exist: Documentation/translations/ja_JP/SubmitChecklist
   Warning: Documentation/translations/zh_CN/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: Documentation/translations/zh_TW/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yam
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
   Can't build as 1 mandatory dependency is missing at ./scripts/sphinx-pre-install line 984.
   make[2]: *** [Documentation/Makefile:121: htmldocs] Error 255
   make[1]: *** [Makefile:1792: htmldocs] Error 2

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

