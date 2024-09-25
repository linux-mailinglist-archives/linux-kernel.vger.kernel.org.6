Return-Path: <linux-kernel+bounces-337833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46168984F87
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4F2B20B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B05C8F70;
	Wed, 25 Sep 2024 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjR0hsra"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F621BC2A;
	Wed, 25 Sep 2024 00:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727224913; cv=none; b=YDIM1plqWFKFSZ3c/RV/UBj/Hfk/rhitqmHS1NUQsH19xB4xF0r/GidzN8D2nMRy61v/bsdCzsgz9CBhQilKdWU5QlH9BWU2qTCjnXBwIXpIKHelLhPyCK6hC9G52TzBlC6yAwS91Xj7Z1HXnCkWk985nsbalDlXjoSV5X4OQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727224913; c=relaxed/simple;
	bh=2XK8zEdM/brCVDCnd9ICJH3UlQjfrzBA8mZbRoKxSVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyFgIaftcnvEfpZdfh7IYjGG1/uT3VCfgP4dKPpu1J6HF/ZjBQG8CVoJSt9C4ofICWIrmI6DYzMXH04rpvNYcF5zStaDyFIYZPZjMjsKIjIWab32fNqn1BQ9Y514alGg8a/hj3S7wHhUG3ZF46/9wNqqgir7WFBdCD7lOEwHmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjR0hsra; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727224911; x=1758760911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2XK8zEdM/brCVDCnd9ICJH3UlQjfrzBA8mZbRoKxSVU=;
  b=mjR0hsragQzcf/tBJDa5Dogx1jdzvIUoVaEumCIxenvU+YxUDUebAwjx
   7KJEZRlnWa6GV9pliW5K6ueCveX4DqvG5ql8kr4yfI9rngCIzD1PM19cT
   m3tTRIaE/A7yyHH5+plunS6UJnA3FRWx2c3cvEtECHlLRelwl2cJJSBcm
   gMv8w/1W1oBPgOUsGRUAcCYPzm5gbPem8HBT5w6tGLACvm4j+nyO4QQgC
   poD03zbgqohz8cqUUvJebOq4S9g8xG3Psj2cy53fHPsSdnIwwuHQm1Y4P
   iFct8H7q5B2QhRGTf3E8jgfz0tTRsrMXlAUm6vLw/EIz2Y2nxd+snvWnW
   A==;
X-CSE-ConnectionGUID: ZYBWFWDxTZ2sHu9l2gf2Og==
X-CSE-MsgGUID: Czau/5ihSm+d3wWYElC2QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="43770277"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="43770277"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 17:41:51 -0700
X-CSE-ConnectionGUID: nYOCjWOKSemTWao0Nos07A==
X-CSE-MsgGUID: GwxADl33TkelnkL2bAv7pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="102418421"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Sep 2024 17:41:49 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stG6E-000IzZ-1W;
	Wed, 25 Sep 2024 00:41:46 +0000
Date: Wed, 25 Sep 2024 08:41:03 +0800
From: kernel test robot <lkp@intel.com>
To: Federico Vaga <federico.vaga@vaga.pv.it>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Federico Vaga <federico.vaga@vaga.pv.it>
Subject: Re: [PATCH v2] doc:it_IT: update documents in process/
Message-ID: <202409250825.r3iY80XD-lkp@intel.com>
References: <20240924224635.21472-1-federico.vaga@vaga.pv.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924224635.21472-1-federico.vaga@vaga.pv.it>

Hi Federico,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on next-20240924]
[cannot apply to linus/master v6.11]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Federico-Vaga/doc-it_IT-update-documents-in-process/20240925-064806
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20240924224635.21472-1-federico.vaga%40vaga.pv.it
patch subject: [PATCH v2] doc:it_IT: update documents in process/
reproduce: (https://download.01.org/0day-ci/archive/20240925/202409250825.r3iY80XD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250825.r3iY80XD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
>> Warning: Documentation/translations/it_IT/process/4.Coding.rst references a file that doesn't exist: Documentation/translations/it_IT/process/clang-format.rst
>> Warning: Documentation/translations/it_IT/process/coding-style.rst references a file that doesn't exist: Documentation/translations/it_IT/process/clang-format.rst
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

