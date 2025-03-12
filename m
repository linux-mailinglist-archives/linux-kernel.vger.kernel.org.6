Return-Path: <linux-kernel+bounces-557455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320F9A5D922
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8AD3B95E7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D937923A57F;
	Wed, 12 Mar 2025 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQDoVRAs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791C23A98A;
	Wed, 12 Mar 2025 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741771134; cv=none; b=qMcJw/55GFSTuuOEKy0sC1V/J9UsbJ+6q7y4l4Wo4fwiSv9+HgE3fv7HZOCYFh7/Mcdxw3ufERXbjH61BR6hijTuRPVBfZK8hwDBHOJqz6F3VLCeplbPznzVXijJ92jaw9emOjvja6T5smVOU1Enhi5bC/R22PiFhBkQWVXO1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741771134; c=relaxed/simple;
	bh=QohO+qEryyUZNc5IxQGS+tP4cDEv1oyEh3/RIOphmwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gf/dcxWEulwaudL25Rqu3vFiHbLDd8yyQYslOK7dyi3hwCZTU8wDwWlu8tI/JxmC3AQoYzvPpNQ8A0CHBcjFeLAbtQ4Q8KdUhDGNADXOPNhgLVisfliLLrIDGVeyPZSnsA+lxGDDGnWiAqTmO2yPGnHh37dmMpaQnpW/Wr/s1zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQDoVRAs; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741771132; x=1773307132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QohO+qEryyUZNc5IxQGS+tP4cDEv1oyEh3/RIOphmwo=;
  b=cQDoVRAsBVY1DyYdhZ/2n21fZRG4/kbOAAEGYnmmFL3v0RupJSHCOmAT
   miPzmdmu6T26d3BanvBOjLkZxAS34vCf3+iAW1NvQk2CAWO4L7qjCQzHe
   oa1rSlQGUjVPHNe9NYS4D1twjn7UCQ2hil3ZkIAS82zQD6VtQQq64ZiqE
   Mz517w1ekLX0tyOtdEKeN5Yh3G8U5gbusZaKkP1l9dwIMUPeIabhQACAQ
   9rLlt6A5fSnOVLZ5BnM4TJVjRed9Qrn3FcxGdCPOUIdgpDxjZ4tBY529z
   LgH38eHPZhiAfr0NPXg0YVwdMl7Bk1I7IUTBPbD3dbJXofSBHsJgLj3Uk
   Q==;
X-CSE-ConnectionGUID: Lh1ch9UhTCWrY+LserYm+g==
X-CSE-MsgGUID: 2uy+p5LbQTmkM/EXoACa8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="46486840"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="46486840"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 02:18:52 -0700
X-CSE-ConnectionGUID: +8CO2PixQYSWJ8ZXPX6LEA==
X-CSE-MsgGUID: xnJrE98fRg6nZ98zAVfUFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="120801269"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 12 Mar 2025 02:18:48 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsIEg-0008Jk-00;
	Wed, 12 Mar 2025 09:18:46 +0000
Date: Wed, 12 Mar 2025 17:18:09 +0800
From: kernel test robot <lkp@intel.com>
To: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, krzysztof.kozlowski+dt@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, balamanikandan.gunasundar@microchip.com,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: mtd: atmel-nand: add legacy nand
 controllers
Message-ID: <202503121629.f5Hsa5Zy-lkp@intel.com>
References: <20250311122847.90081-4-balamanikandan.gunasundar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311122847.90081-4-balamanikandan.gunasundar@microchip.com>

Hi Balamanikandan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/mtd/next]
[also build test WARNING on mtd/mtd/fixes robh/for-next linus/master v6.14-rc6 next-20250311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Balamanikandan-Gunasundar/dt-bindings-mtd-microchip-nand-convert-txt-to-yaml/20250311-203706
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
patch link:    https://lore.kernel.org/r/20250311122847.90081-4-balamanikandan.gunasundar%40microchip.com
patch subject: [PATCH v2 3/3] dt-bindings: mtd: atmel-nand: add legacy nand controllers
reproduce: (https://download.01.org/0day-ci/archive/20250312/202503121629.f5Hsa5Zy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503121629.f5Hsa5Zy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/ja_JP/SubmittingPatches references a file that doesn't exist: linux-2.6.12-vanilla/Documentation/dontdiff
   Warning: Documentation/translations/zh_CN/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: Documentation/translations/zh_TW/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/mtd/atmel-nand.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
   Warning: lib/Kconfig.debug references a file that doesn't exist: Documentation/dev-tools/fault-injection/fault-injection.rst
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

