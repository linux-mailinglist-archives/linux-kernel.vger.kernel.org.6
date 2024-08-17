Return-Path: <linux-kernel+bounces-290551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7736A95559F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 07:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBE61F230F6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 05:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1491712C7FB;
	Sat, 17 Aug 2024 05:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6gxn1E2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0E46E619;
	Sat, 17 Aug 2024 05:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723873294; cv=none; b=F5QMwoY/cazCx3+1YGXk2gSJr8sqkTES7hRtb8FrHmAlygaS8A/s9LNA+DlwOhwNDA0hFRdoIgQWrhOanKW2B9ePRWq5BWzHhkDM7nwrmMVD3oE2VjGgHHy73yfy3iiY5DicLvJy7iFZ3ZWYJRuv1CEQ9SKslYjqJOMM/fJnhGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723873294; c=relaxed/simple;
	bh=UT3TEXjAnt6juaSW5v7iJywRiqzsU/IKcktZg/tIjHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCkJRtqDz881P3Auh3mzydNqngm811NKTQfeiqaXzUDL8NyuDTtHRkJRepdVQ/oU1HhW/xK2cj56o3LKiN9YjinJdtva4RlNl597Dp+/U1I3U+FqeZ5+Cihw2fTuKLRA7Yu85QCJbOVVe8ARHQbFFWvM8wr17vCF2MJGo5CtZyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6gxn1E2; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723873292; x=1755409292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UT3TEXjAnt6juaSW5v7iJywRiqzsU/IKcktZg/tIjHE=;
  b=F6gxn1E2RLO47GqstEah8YgNy3xnuBb4r2KUH5sdGixYPn94JtdAu1uh
   DnGcECE5fzNYYoF2Ov2iSHpE6OoIjCYsZKO3R4zEJgg3VmxcELy9w/3JE
   ojcqJ1SJ75l1mAyDDy7DxiFJVYtrBA0AGj8/7jyUpmgVNkthpPyTUVpDb
   ooORNY6u2Oqhw1NbhqlFP8mz2vx4kfsLWKOkC+VLOMHryvJmzapfv0n7F
   6BP+MUQhjGA2yxt6sRC63sR23d7j+BXy78i5Yjq4Oxn+Kk/DR0AvOVMLq
   Ecp5JOKQT6bhB+LAnCd5lEnMGzCDUzvSdjldL3J0Zbm6FAPVU3iCoD5oP
   A==;
X-CSE-ConnectionGUID: 9syPr15PQhCw3Ii2Zd5RGQ==
X-CSE-MsgGUID: u+8MggyoQWSjPurbWU4ZSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="33586382"
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="33586382"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 22:41:31 -0700
X-CSE-ConnectionGUID: iTH+5IiAQmidIYMfmvrviw==
X-CSE-MsgGUID: W28H85x6Tz2caN/vW2hXrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="64761382"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 16 Aug 2024 22:41:28 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfCBp-0007DG-1w;
	Sat, 17 Aug 2024 05:41:25 +0000
Date: Sat, 17 Aug 2024 13:40:49 +0800
From: kernel test robot <lkp@intel.com>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: oe-kbuild-all@lists.linux.dev,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 28/28] ARM: dts: aspeed: yosemite4: fix GPIO linename
 typo
Message-ID: <202408171324.4kdqlh1v-lkp@intel.com>
References: <20240816092417.3651434-29-Delphine_CC_Chiu@wiwynn.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816092417.3651434-29-Delphine_CC_Chiu@wiwynn.com>

Hi Delphine,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.11-rc3 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Delphine-CC-Chiu/ARM-dts-aspeed-yosemite4-Revise-i2c-mux-devices/20240816-173326
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240816092417.3651434-29-Delphine_CC_Chiu%40wiwynn.com
patch subject: [PATCH v12 28/28] ARM: dts: aspeed: yosemite4: fix GPIO linename typo
config: arm-randconfig-001-20240817 (https://download.01.org/0day-ci/archive/20240817/202408171324.4kdqlh1v-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240817/202408171324.4kdqlh1v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408171324.4kdqlh1v-lkp@intel.com/

All errors (new ones prefixed by >>):

   Error: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1721.1-6 Label or path i3c0 not found
   Error: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1764.1-6 Label or path i3c1 not found
>> Error: arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts:1833.1-7 Label or path jtag1 not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

