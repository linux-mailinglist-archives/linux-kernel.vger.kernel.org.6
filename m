Return-Path: <linux-kernel+bounces-324416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539E6974C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156EC283306
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDBB14D2A6;
	Wed, 11 Sep 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVJeeQTG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77AA14D449;
	Wed, 11 Sep 2024 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042064; cv=none; b=Sd1p90aR1eELjE6eZgp1OEPa43T6ltAbLU91jCf8eI2Wdz3/zsxXWaCpo5HCL22k+hdbAXVxBWrxZhNYCkHfJbsyWJh4LlGIFerrrK+mNkZdwYA0WrR4CJn1K/kzpNC6lTB0QC6lkxNvbw8+s5XGfk88zkVgPX43vDKsOJxreIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042064; c=relaxed/simple;
	bh=EKZEIu89oRth7yodb/7PPbffl+lMha21+1Do9ttFjVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+VENxJbMas8mgWoR+7DuyywvMXs9yx8ffxxOV4Kfd2eVhWzbeVowp2Hj1mH8EliLPvY6SUhf5afi6aLSauSwOXU0kWf/7wYir2bh7TIczozUhE/Un42rkqyRLzr4BdPype0oixdOxg959UiLyjvlEPEoJ9v4P1kDme2XkQZ8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVJeeQTG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726042064; x=1757578064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EKZEIu89oRth7yodb/7PPbffl+lMha21+1Do9ttFjVI=;
  b=YVJeeQTG5cciGWe2NJQkxl02CpwzbzvEL5nNYXLw9fqSxnnrLiEX1uTc
   5xIEaEzce6F+pLbUlvWArrdS6udu+Zq2kDX1kV6kpYX914ZD1uOzDtBn+
   neDahxaUatvRMNci6R4Ma8bHtH3HZImrSP3sMzKKjPvDB5pFzrMHRMo/H
   lJG9qCCmrwOyxD6V3r2KSp3zNex5N4eZ3bEga5OBsjB52A0Mm/tyxWaNG
   cg8jHUJvLSx0nau0CcOcNUSfhMRhKPkFGiIslwDYA32vs00aD5z1wqWaV
   tUTrNzMa8LHqI8Q1N5FjlzuasDaEbKh580me63lhNk2tSiMIsXQPEFDOA
   w==;
X-CSE-ConnectionGUID: XG+O25I4Rtyya2c5EnTNyQ==
X-CSE-MsgGUID: 685+qW65SimdLrbKocEW3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24321857"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="24321857"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 01:07:42 -0700
X-CSE-ConnectionGUID: KEWhRgfHSIS3VTcnfiBibQ==
X-CSE-MsgGUID: BUYId16kREuvLRI0XGNutQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67127393"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 11 Sep 2024 01:07:39 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soIO0-0003DY-2v;
	Wed, 11 Sep 2024 08:07:36 +0000
Date: Wed, 11 Sep 2024 16:06:55 +0800
From: kernel test robot <lkp@intel.com>
To: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: Re: [PATCH] arm64: dts: mt8183: Add encoder node
Message-ID: <202409111520.z5LrGscP-lkp@intel.com>
References: <20240910-venc-v1-1-d17dfd931dc8@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910-venc-v1-1-d17dfd931dc8@chromium.org>

Hi Hsin-Te,

kernel test robot noticed the following build errors:

[auto build test ERROR on da3ea35007d0af457a0afc87e84fddaebc4e0b63]

url:    https://github.com/intel-lab-lkp/linux/commits/Hsin-Te-Yuan/arm64-dts-mt8183-Add-encoder-node/20240910-142236
base:   da3ea35007d0af457a0afc87e84fddaebc4e0b63
patch link:    https://lore.kernel.org/r/20240910-venc-v1-1-d17dfd931dc8%40chromium.org
patch subject: [PATCH] arm64: dts: mt8183: Add encoder node
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240911/202409111520.z5LrGscP-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240911/202409111520.z5LrGscP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409111520.z5LrGscP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/mediatek/mt8183.dtsi:1971.4-5 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

