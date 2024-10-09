Return-Path: <linux-kernel+bounces-356978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9558D9969D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E8A1F25C81
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B35192D91;
	Wed,  9 Oct 2024 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXwrgTUs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F001E1922DD;
	Wed,  9 Oct 2024 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476336; cv=none; b=sgQjx4vfFnisle4zFXLW9i7xdhBLpOZUDqZTL9MRkB235BHr/d5XOMj3Aofjx+4ipNADsuOR2DPTbxkS93Y+EMstG7Zk1Wl93/vnQYmJgHyJOgLsrBJ9dmPSwIyz6NPysk3jLO/1x2te4Fbi3pDKvtXTR+yiuZwylPHuKXv3Gu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476336; c=relaxed/simple;
	bh=c2gFY4gtveL1XpFdSfORF1+tbN/JPlxEpuexOeTX9cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flZh7mO0BJAuWSRSiD1jFqRSEqzkuX4jvbA55xFVBq5L6RgEAYUbnHZVnR+I4uoK1wgx+ZYhFXPV8UigUnqrK0663dCueJcXyWtcD6OkWI4hC5EI11PZGd+2EaS7sf+cHJoJZDvgg37ejeCZjUta8H8JdklspMb2P8kJBDETrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXwrgTUs; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728476335; x=1760012335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c2gFY4gtveL1XpFdSfORF1+tbN/JPlxEpuexOeTX9cU=;
  b=kXwrgTUsWW4L7cihZJQ5WqkqBKHCLxR/mz4tZY48fHdqh7Xz93iGq6dt
   bUZWLrc9wCJYxgF3uRnlzQWyaiuw4ZpdVtJ0r4YFMqI018ZP3okOhRlTK
   Cbs4acj44/Un7fp6y7o6MdbSi2fw45y2Ni3VLyXpuosLPouAxuF0ECdmO
   lbey4tc4NvyzHxUFTjniEEMFBw4AhPGz2KiL572fA5TiQC8xTZvpx0l49
   5UuLms2tj9FzlmFdorl5a/BfA+i4NHke6hRnm9RCugRkKYrlKfBkJFT1h
   jEmPd9t+jljetVUbIKbQn6JjkpO/swgqm5B3+y4Y/KryX24FfUDZko+kI
   A==;
X-CSE-ConnectionGUID: A7mkl6lkToWDchcefrDGuA==
X-CSE-MsgGUID: gM2d7+HtR/+NkU8MCHUGuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31563771"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="31563771"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 05:18:54 -0700
X-CSE-ConnectionGUID: PbgVQfRNSVOsRuFInDbpIw==
X-CSE-MsgGUID: qvIVTNMJRfizD8QMeqt59w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76188060"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Oct 2024 05:18:51 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syVeS-0009C0-30;
	Wed, 09 Oct 2024 12:18:48 +0000
Date: Wed, 9 Oct 2024 20:18:20 +0800
From: kernel test robot <lkp@intel.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: Re: [PATCH v6 1/3] drm/mipi-dsi: add mipi_dsi_compression_mode_multi
Message-ID: <202410092245.tfsuUllL-lkp@intel.com>
References: <20241006-starqltechn_integration_upstream-v6-1-8336b9cd6c34@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006-starqltechn_integration_upstream-v6-1-8336b9cd6c34@gmail.com>

Hi Dzmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 58ca61c1a866bfdaa5e19fb19a2416764f847d75]

url:    https://github.com/intel-lab-lkp/linux/commits/Dzmitry-Sankouski/drm-mipi-dsi-add-mipi_dsi_compression_mode_multi/20241007-022151
base:   58ca61c1a866bfdaa5e19fb19a2416764f847d75
patch link:    https://lore.kernel.org/r/20241006-starqltechn_integration_upstream-v6-1-8336b9cd6c34%40gmail.com
patch subject: [PATCH v6 1/3] drm/mipi-dsi: add mipi_dsi_compression_mode_multi
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241009/202410092245.tfsuUllL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241009/202410092245.tfsuUllL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410092245.tfsuUllL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/drm_mipi_dsi.c:1533: warning: Function parameter or struct member 'ctx' not described in 'mipi_dsi_compression_mode_multi'
>> drivers/gpu/drm/drm_mipi_dsi.c:1533: warning: Excess function parameter 'dsi' description in 'mipi_dsi_compression_mode_multi'


vim +1533 drivers/gpu/drm/drm_mipi_dsi.c

  1522	
  1523	/**
  1524	 * mipi_dsi_compression_mode_multi() - enable/disable DSC on the peripheral
  1525	 * @dsi: DSI peripheral device
  1526	 * @enable: Whether to enable or disable the DSC
  1527	 *
  1528	 * Enable or disable Display Stream Compression on the peripheral using the
  1529	 * default Picture Parameter Set and VESA DSC 1.1 algorithm.
  1530	 */
  1531	void mipi_dsi_compression_mode_multi(struct mipi_dsi_multi_context *ctx,
  1532					     bool enable)
> 1533	{
  1534		return mipi_dsi_compression_mode_ext_multi(ctx, enable,
  1535							   MIPI_DSI_COMPRESSION_DSC, 0);
  1536	}
  1537	EXPORT_SYMBOL(mipi_dsi_compression_mode_multi);
  1538	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

