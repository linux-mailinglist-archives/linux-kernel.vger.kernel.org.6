Return-Path: <linux-kernel+bounces-446235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C09E9F218B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 00:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84E57A0F7D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 23:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A61B218E;
	Sat, 14 Dec 2024 23:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnziYlNj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538C17D355
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734218980; cv=none; b=jEiIeHwlPaNqDyNASLWmRfQKVa/T/ZzvmqYCNEnotu2e2aCwrZDGOirlp2qQ7hBGKp8/O+EMxQFUPP6D6li2uCuUw+spIvpApzQIwC+kgLQnm3buoHcb6tkjUd1y2ORlN68KhtFuQTxLJObRTeptz76gn7jsAj1BjWySTIVcEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734218980; c=relaxed/simple;
	bh=1+CFgeAd+oR6Q7/0GgOQkB/ji2r8yb3vByK9aFbF0Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUYOiadi8WikBCsjiUuUP98+otKiIn1suCjDM/0lQzMDsOAVk4djonWxkSMLGgmQ8FALag0AhH2MmTj7kP73oQhsfeYieET7m4Hpr4cVrs4rvJLYTyKKpBbSSkXMpQ3aZTRGKquJxvjrP1K6grXdS/RdPhi+s/P6tC3ayeP93Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnziYlNj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734218979; x=1765754979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1+CFgeAd+oR6Q7/0GgOQkB/ji2r8yb3vByK9aFbF0Js=;
  b=LnziYlNjYFeVMcXnTiu3Z4kMBcOqt9ee0vkgxKP6v6aRIUQruTXz5km+
   ln7Y9rxwu8iuaHkg53iYNWtRHqlEnpfg3K3dJ2UNd0kVsJcTb7aK1RQA7
   tnpP9Dbg/J6soAT1bW0PNAZmdhoi3ven5pu+le6eOjwt/tJsnEuCBiSO+
   HDR/b0qJb/olshq/aiksKBTSqtAgCTCS7GKA9YlxzJMSbhkLaKCTuoVcB
   /es0D/gPE7JdUQArAs+mGfe3fLiUr454L2KIUjLdM6oBKUFAnCr2Tz7Ul
   w/dbwdeGauFrwcNdGjuLedz8EsPvwlGaqI/2mwRAoj4U0/O6LMqjBbpYy
   A==;
X-CSE-ConnectionGUID: CtepVbkzQ3ahCOqnkJXUTQ==
X-CSE-MsgGUID: /A98/j3FRxSHjrNFefWgCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="52061455"
X-IronPort-AV: E=Sophos;i="6.12,235,1728975600"; 
   d="scan'208";a="52061455"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 15:29:38 -0800
X-CSE-ConnectionGUID: SrouF0NVSG6mlDyZXA8t3A==
X-CSE-MsgGUID: Z2iN8U93RbKsgav5GjOCCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,235,1728975600"; 
   d="scan'208";a="97092677"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 14 Dec 2024 15:29:35 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMbZk-000DJi-0q;
	Sat, 14 Dec 2024 23:29:32 +0000
Date: Sun, 15 Dec 2024 07:28:44 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/2] drm/nouveau: incorporate I2C TV encoder drivers
Message-ID: <202412150729.LAunB5YO-lkp@intel.com>
References: <20241214-nouveau-encoder-slave-v1-1-beda767472e3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214-nouveau-encoder-slave-v1-1-beda767472e3@linaro.org>

Hi Dmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4176cf5c5651c33769de83bb61b0287f4ec7719f]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Baryshkov/drm-nouveau-incorporate-I2C-TV-encoder-drivers/20241214-233637
base:   4176cf5c5651c33769de83bb61b0287f4ec7719f
patch link:    https://lore.kernel.org/r/20241214-nouveau-encoder-slave-v1-1-beda767472e3%40linaro.org
patch subject: [PATCH 1/2] drm/nouveau: incorporate I2C TV encoder drivers
reproduce: (https://download.01.org/0day-ci/archive/20241215/202412150729.LAunB5YO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412150729.LAunB5YO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/nouveau/dispnv04/Kbuild:14: drivers/gpu/drm/nouveau/dispnv04/i2c/Kbuild: No such file or directory
>> make[6]: *** No rule to make target 'drivers/gpu/drm/nouveau/dispnv04/i2c/Kbuild'.
   drivers/gpu/drm/nouveau/dispnv04/Kbuild:14: Failed to remake makefile 'drivers/gpu/drm/nouveau/dispnv04/i2c/Kbuild'.
   make[5]: *** [scripts/Makefile.clean:61: drivers/gpu/drm/nouveau] Error 2
   make[5]: Target '__clean' not remade because of errors.
   make[4]: *** [scripts/Makefile.clean:61: drivers/gpu/drm] Error 2
   make[4]: Target '__clean' not remade because of errors.


vim +14 drivers/gpu/drm/nouveau/dispnv04/Kbuild

    13	
  > 14	include $(src)/dispnv04/i2c/Kbuild

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

