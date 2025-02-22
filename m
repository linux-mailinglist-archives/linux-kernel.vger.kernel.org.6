Return-Path: <linux-kernel+bounces-527455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C06A40B6E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21CA19C1373
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3038021018A;
	Sat, 22 Feb 2025 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwOLtVL2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C3D18F2FC;
	Sat, 22 Feb 2025 19:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740252373; cv=none; b=W6RkGs7CfiYuaj/H+Gi0He7wBi6iHaEPYA7Lww8LuEHNQCZhVlTZZTuxdZf/IC0KTQ483bjpCFJjK3W9S5Iwyr2iqhDCb1lIzvZwth71qMFDbf3N5tIWWKEP73pYqTe6YX3mO/a9N1kw3lihHl19ny4WrlgvYDDAZ1Td1sS6uOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740252373; c=relaxed/simple;
	bh=2s5bZx8UtviIS3xhQ0sLk1pPacXIKC0ImhvYY7AtgJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIaJb8XDWVbUWb6MjLtAd61K+sImdmcsn6RoxKVuP4XATHI/vqcXkBAT9Kb0mV12u5Lht8sls367wJCOuPcVteTFBPxoxjveQigliUayvkqlzKAz+4hBv95ertT2kf+vQ6x5S5+PH8Fw1ho9FqwEbPCUms5/RPxgk62kcQkQtd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwOLtVL2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740252372; x=1771788372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2s5bZx8UtviIS3xhQ0sLk1pPacXIKC0ImhvYY7AtgJc=;
  b=BwOLtVL2omk21ZPMZXyrvgZXN0EEgiicU5OsPyyyULUsAlUnA7SNzuee
   Eyr/1t75rztrjw8itzWtFXYlMWh53gC2QAXeMLgG8eU8jcYJNJtsB/YzG
   2OV2nsHAR4G3ZB0swzleljRYE5t+xeU+rTT2iWKuHWtBPpKITJh678vHc
   etn34PoMbYNHL2Qdxpci7edCzYkQmW2Mpcq5sYoGMA3nmbHbA5PWhHbDH
   aIBbuI5cygFJPqWxRuQLvLfz6NElkc26VcYCdTfU14M1BFO1/PheZvN74
   QXPOOcQGNrpPyvmAqS0YpvC5Sa9bfeuSeUGHVNyNi/BhuziQ883TpAFZj
   Q==;
X-CSE-ConnectionGUID: UKtxV7KJRpen74f1IBwM2A==
X-CSE-MsgGUID: PWFF9f3/R2a7awDjRuivOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="51678571"
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="51678571"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 11:26:11 -0800
X-CSE-ConnectionGUID: e3Et3qLpRDak3dassD98OA==
X-CSE-MsgGUID: p/RH7JihSw6T2Pin3kCEkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116586745"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2025 11:26:08 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlv8U-0006q7-2b;
	Sat, 22 Feb 2025 19:26:03 +0000
Date: Sun, 23 Feb 2025 03:25:26 +0800
From: kernel test robot <lkp@intel.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-sound@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Add Vincenzo Frascino as Xilinx
 Sound Driver Maintainer
Message-ID: <202502230334.bQ3wP2MG-lkp@intel.com>
References: <20250221175030.1395815-5-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221175030.1395815-5-vincenzo.frascino@arm.com>

Hi Vincenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.14-rc3 next-20250221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincenzo-Frascino/ASoC-dt-bindings-xlnx-i2s-Convert-to-json-schema/20250222-015201
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20250221175030.1395815-5-vincenzo.frascino%40arm.com
patch subject: [PATCH v2 4/4] MAINTAINERS: Add Vincenzo Frascino as Xilinx Sound Driver Maintainer
reproduce: (https://download.01.org/0day-ci/archive/20250223/202502230334.bQ3wP2MG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502230334.bQ3wP2MG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/sound/xlnx,i2s.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/sound/xlnx,spdif.txt
   Warning: lib/Kconfig.debug references a file that doesn't exist: Documentation/dev-tools/fault-injection/fault-injection.rst
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

