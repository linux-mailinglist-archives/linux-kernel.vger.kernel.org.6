Return-Path: <linux-kernel+bounces-216238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C284909CFF
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122C3281937
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192C0186E59;
	Sun, 16 Jun 2024 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OASCkUsd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638F49635
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 10:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718535014; cv=none; b=Kiqh5x6u2gpRVHpKqUeIefUtYGJkUidhJqwlFWqqhL9K2Ycw2vO2/hCAtLeO5HVKNLNAS7cC66R00FKMkY7qPemhWV7QusISEigL+A7DrUCqeDm9iKI9sm9lEWjaUSRQ41z/ZctYH+NyaSsNH3T0RhjOIMr5S4tuMhKuWfkFFdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718535014; c=relaxed/simple;
	bh=brr90q5Tq4BAbS8NN0Xp7TRm0S0CFYQq5NLpZFBrjLw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mVNEamXPabgrCQwqx+QFOVUdJAjya2K0mLQf1IJA4fI6uTnvh4+ZEz6xeIfJQ2itxbhn+rd/6Um4SBRfLIPdRhVM/OIFrncm3jL5/xvOcySQwHvwpBNHEKVOYExbLd5ArRtshe7DnZnFc7Ju0fPMW0E4KgRwm9SPr8uMHbCptAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OASCkUsd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718535012; x=1750071012;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=brr90q5Tq4BAbS8NN0Xp7TRm0S0CFYQq5NLpZFBrjLw=;
  b=OASCkUsd7CaNLjieiu40crGBBvAYiWxIYlCYcWbtrvdJAsmoG5Tb03Vp
   vLhjZL+ZfkdIj+1mKOrLsdIfhcON05Ltwr5of681RU0uP8LB2pmbwYkOi
   CiwTI0rYqam2oGr8T6S2clKA1KBy2kz1FxW1tPJjjkxLrHNjoS3WcGc2t
   TJ0pBtjlNqqEdloYBj3ufXcxUBtc0BLExh3EU909XU65wbnqifrrmX3SP
   xQJc5C5C2TbINl0wU0w1IcZoXEdcJywn2fJMd7Z/3NZKg0CNIBiWhOgIa
   hbtB/KpR4386uaUdgzcL5iHqYULnQxIw+A/bVc5QyMgSNAjzbihfD7k8u
   g==;
X-CSE-ConnectionGUID: hsVt2O2AScq6X1ymyhXZ5w==
X-CSE-MsgGUID: HhHJvJLSRdeWkkSyAwRs+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="15347679"
X-IronPort-AV: E=Sophos;i="6.08,242,1712646000"; 
   d="scan'208";a="15347679"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 03:50:11 -0700
X-CSE-ConnectionGUID: Fi42dMPHTauhxqbBopEsJQ==
X-CSE-MsgGUID: UWsrWVrLSoW6y8YXA2SFmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,242,1712646000"; 
   d="scan'208";a="41048590"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Jun 2024 03:50:09 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sInSZ-0002eA-17;
	Sun, 16 Jun 2024 10:50:07 +0000
Date: Sun, 16 Jun 2024 18:49:17 +0800
From: kernel test robot <lkp@intel.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb:
 clock-controller@11010000: #power-domain-cells:0:0: 1 was expected
Message-ID: <202406161842.rJqdaHKy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a3e18a540541325a8c8848171f71e0d45ad30b2c
commit: f33dca9ed6f41c8acf2c17c402738deddb7d7c28 dt-bindings: clock: renesas,rzg2l-cpg: Update #power-domain-cells = <1> for RZ/G3S
date:   7 weeks ago
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240616/202406161842.rJqdaHKy-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
dtschema version: 2024.6.dev1+g833054f
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240616/202406161842.rJqdaHKy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406161842.rJqdaHKy-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: clock-controller@11010000: #power-domain-cells:0:0: 1 was expected
   	from schema $id: http://devicetree.org/schemas/clock/renesas,rzg2l-cpg.yaml#
   arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: pinctrl@11030000: eth0: 'anyOf' conditional failed, one must be fixed:
   	'mux', 'tx_ctl', 'txc' do not match any of the regexes: 'pinctrl-[0-9]+'
   	'output-enable' does not match any of the regexes: 'pinctrl-[0-9]+'
   	from schema $id: http://devicetree.org/schemas/pinctrl/renesas,rzg2l-pinctrl.yaml#
   arch/arm64/boot/dts/renesas/r9a08g045s33-smarc.dtb: pinctrl@11030000: key-1-gpio-hog: 'anyOf' conditional failed, one must be fixed:
   	'input' does not match any of the regexes: 'pinctrl-[0-9]+'
   	True is not of type 'object'
   	[[144, 1]] is not of type 'object'
   	['key-1-gpio-irq'] is not of type 'object'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

