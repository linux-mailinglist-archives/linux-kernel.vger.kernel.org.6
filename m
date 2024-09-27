Return-Path: <linux-kernel+bounces-341292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C707A987DE0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D9F1C22B21
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 05:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A2C176AB1;
	Fri, 27 Sep 2024 05:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJ23X0yY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214F175D21;
	Fri, 27 Sep 2024 05:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727414957; cv=none; b=pKWMJPSvrul3gtsUkewQTgoUpjWaIp0Ks0p5mwUoOtnIOXUEi36w7Y+7lJ9sD5sHp/lWTk4TOkn5lUtU5Vmrpe9y7TtOXry5nnq4VURLMyGpuHmHlrptsnJ4ltb37r7RtlHevuLm6nnLMiZ0DaopyRRbcYGaVQZYEYpS3rQuXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727414957; c=relaxed/simple;
	bh=tOr73h+s5i8NrEI4xi6ybeSckNxM9TLk7DCrddUkUMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdMEbT106IiC7aijHDkI4HVAK3RB9q25yzK91WQPQGF2UZcVtXVKJDoymkfj/D26v89JsPqEcprsecDPydLFqQgiaAJxagFMzzNMvOw5S302wvw+c0wNDO6m2Y441Z9vV922JVT8IR+7X/+dBwDzrAGgzMBC/+meXhMkKkbS1+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJ23X0yY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727414956; x=1758950956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tOr73h+s5i8NrEI4xi6ybeSckNxM9TLk7DCrddUkUMw=;
  b=TJ23X0yYTD7CKDVRDl4gQAmxr0Cc9WEVPdV46nuiF4sMCVF6zQmBxpl6
   f8pOpD6/AE/svN8p+nZmv0vH5iwD3+h+hyiGHbS/b9BP+Bz+8kv1CV7oK
   oGv7Z5NOfFpVWlWsOJw2LCJhTPCROCGy3zcFiJwHgjqtlTCoNpkzI8dI3
   yYErPp+G1S1beTsRrb5r6Gy6h7JrRDX4iLHuEanV9j+OE0UAkR/4wFFtN
   nylVnwIzGNiSQmwr9qMqfbDS024GenzpMvQtC1hG0pnBqdOVC9eq0HS/m
   Wc62d1BCYT/O6YIdQjfifJKfNxjFfT087eUjfsUH7iySg38pn5korsr43
   A==;
X-CSE-ConnectionGUID: BT6nCM0PTuiTy6mEYSKNqg==
X-CSE-MsgGUID: UVxjVQv7TjKCaIoX9OJuQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37114296"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="37114296"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 22:29:16 -0700
X-CSE-ConnectionGUID: OY1RzxU5Roe3y6xzMnny8w==
X-CSE-MsgGUID: WX9CnaqQTY+q6JqEBc+PWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; 
   d="scan'208";a="72714909"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 26 Sep 2024 22:28:58 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1su3XC-000LWC-2e;
	Fri, 27 Sep 2024 05:28:54 +0000
Date: Fri, 27 Sep 2024 13:28:43 +0800
From: kernel test robot <lkp@intel.com>
To: Igor Prusov <ivprusov@salutedevices.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	kernel@salutedevices.com, prusovigor@gmail.com
Subject: Re: [PATCH v3 4/6] ASoC: codecs: Add NeoFidelity NTP8918 codec
Message-ID: <202409271307.H4zydYCv-lkp@intel.com>
References: <20240925-ntp-amps-8918-8835-v3-4-e2459a8191a6@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925-ntp-amps-8918-8835-v3-4-e2459a8191a6@salutedevices.com>

Hi Igor,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c7fbbb45ef78ff349d16923b516bc8667367d1a6]

url:    https://github.com/intel-lab-lkp/linux/commits/Igor-Prusov/dt-bindings-vendor-prefixes-Add-NeoFidelity-Inc/20240925-230818
base:   c7fbbb45ef78ff349d16923b516bc8667367d1a6
patch link:    https://lore.kernel.org/r/20240925-ntp-amps-8918-8835-v3-4-e2459a8191a6%40salutedevices.com
patch subject: [PATCH v3 4/6] ASoC: codecs: Add NeoFidelity NTP8918 codec
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409271307.H4zydYCv-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> sound/soc/codecs/ntp8918.c: linux/clk.h is included more than once.

vim +11 sound/soc/codecs/ntp8918.c

  > 11	#include <linux/clk.h>
    12	#include <linux/reset.h>
    13	#include <linux/i2c.h>
    14	#include <linux/regmap.h>
  > 15	#include <linux/clk.h>
    16	#include <linux/clk-provider.h>
    17	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

