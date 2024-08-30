Return-Path: <linux-kernel+bounces-309495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CDA966B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B206E2848CE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECCE1C1753;
	Fri, 30 Aug 2024 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eTb8h0dF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAAA16FF5F
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725053866; cv=none; b=shLNLLnXifuHaJ7P1wcOuXV7HdoS4/BbHYGWJBG2rXLxC8aGdoKQvnthTr7tzuJNQ/Tlt8GyP4XBegv1EZ/avARCBS30GIh/iZXx7Oc7CLU3/gy5+6jsRJfIHYOzVlV6/wB3jIZMukQj5z1cErrm3DDvLJ0LrfS74PWf4B92BFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725053866; c=relaxed/simple;
	bh=ZcvEL/TIWbV37cmltrDgT3mXiHQW05tUbxFjCQL+klY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDUYIP9GIFZStS3vJxaRBIGw2TM4O3Kkiq16XRt1IhcytB1/s53XBU4AaS+nrbleBYWSSel7wvP0yxbaJoCPUEIBiTtoV88bmZ69ihcOYF/Bzbqve9PWbgZ+CG3re4rf2MTBOkUOEC57qfpEghTemWls8wyUooGVcy6tiof69C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eTb8h0dF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725053865; x=1756589865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZcvEL/TIWbV37cmltrDgT3mXiHQW05tUbxFjCQL+klY=;
  b=eTb8h0dFADgp5PiUK28hz8O/k+Jc+wUtYj4M2drhkcrlVgUxf9krZzt6
   fo8yUrfwIJIi2xHQ6lVvunNDB5N7cleAjLn34c/G9+z25SbHWLGJMR1Mt
   nfCOp8VLthfotftgLOkWtsrDWlpgPB/uHgVMqddaghqRi3KC3jBiZfCwi
   3RWyfLMqX1a2PPxEZyxkKlCXFLd45OBmXcGSk3LnbmI7Pp9kmQa9OxV21
   iAzNqQZgg5ugFxspKQrrDTieMqG7jzraiY1ktC/OMIWdploTnp74LupQL
   byYHrOVScwgyWAFJGMmOb1Pr5H3WYUT9a0P69r3Vvjuxc4a8/m+Cc6MtF
   Q==;
X-CSE-ConnectionGUID: AQFIaNT0QhKeFMO60aTB+Q==
X-CSE-MsgGUID: 4LzEa2WPSw2YA2k5tZbdxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="27474620"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="27474620"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 14:37:45 -0700
X-CSE-ConnectionGUID: krFcODJCSWmgeTmDHohXvg==
X-CSE-MsgGUID: H6tdReiLRmqBKquHtxshAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="68818301"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 30 Aug 2024 14:37:39 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk9JJ-000299-2E;
	Fri, 30 Aug 2024 21:37:37 +0000
Date: Sat, 31 Aug 2024 05:37:32 +0800
From: kernel test robot <lkp@intel.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>,
	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, arthurgrillo@riseup.net,
	linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
	miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
	seanpaul@google.com, nicolejadeyee@google.com,
	Louis Chauvet <louis.chauvet@bootlin.com>
Subject: Re: [PATCH v2 5/6] drm/vkms: Switch to managed for CRTC
Message-ID: <202408310524.JPBkb81E-lkp@intel.com>
References: <20240827-google-vkms-managed-v2-5-f41104553aeb@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827-google-vkms-managed-v2-5-f41104553aeb@bootlin.com>

Hi Louis,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 071d583e01c88272f6ff216d4f867f8f35e94d7d]

url:    https://github.com/intel-lab-lkp/linux/commits/Louis-Chauvet/drm-vkms-Switch-to-managed-for-connector/20240827-180427
base:   071d583e01c88272f6ff216d4f867f8f35e94d7d
patch link:    https://lore.kernel.org/r/20240827-google-vkms-managed-v2-5-f41104553aeb%40bootlin.com
patch subject: [PATCH v2 5/6] drm/vkms: Switch to managed for CRTC
config: i386-buildonly-randconfig-004-20240831 (https://download.01.org/0day-ci/archive/20240831/202408310524.JPBkb81E-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310524.JPBkb81E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310524.JPBkb81E-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/vkms/vkms_output.c:58:6: warning: variable 'cursor' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
      58 |         if (vkmsdev->config->cursor) {
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/vkms/vkms_output.c:65:10: note: uninitialized use occurs here
      65 |                               cursor ? &cursor->base : NULL);
         |                               ^~~~~~
   drivers/gpu/drm/vkms/vkms_output.c:58:2: note: remove the 'if' if its condition is always true
      58 |         if (vkmsdev->config->cursor) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/vkms/vkms_output.c:32:37: note: initialize the variable 'cursor' to silence this warning
      32 |         struct vkms_plane *primary, *cursor, *overlay = NULL;
         |                                            ^
         |                                             = NULL
   1 warning generated.


vim +58 drivers/gpu/drm/vkms/vkms_output.c

d16489307a52f0 Rodrigo Siqueira    2018-07-11  29  
e9d85f731de06a Rodrigo Siqueira    2019-06-25  30  int vkms_output_init(struct vkms_device *vkmsdev, int index)
854502fa0a38dc Rodrigo Siqueira    2018-05-16  31  {
2abd7e59001123 Louis Chauvet       2024-08-27  32  	struct vkms_plane *primary, *cursor, *overlay = NULL;
854502fa0a38dc Rodrigo Siqueira    2018-05-16  33  	struct drm_device *dev = &vkmsdev->drm;
a12934d3402c04 Louis Chauvet       2024-08-27  34  	struct drm_connector *connector;
e3b4c152118a04 Louis Chauvet       2024-08-27  35  	struct drm_encoder *encoder;
2abd7e59001123 Louis Chauvet       2024-08-27  36  	struct vkms_crtc *crtc;
df2d385cb4132e José Expósito       2022-01-07  37  	unsigned int n;
2abd7e59001123 Louis Chauvet       2024-08-27  38  	int ret;
854502fa0a38dc Rodrigo Siqueira    2018-05-16  39  
2abd7e59001123 Louis Chauvet       2024-08-27  40  	/*
2abd7e59001123 Louis Chauvet       2024-08-27  41  	 * Initialize used plane. One primary plane is required to perform the composition.
2abd7e59001123 Louis Chauvet       2024-08-27  42  	 *
2abd7e59001123 Louis Chauvet       2024-08-27  43  	 * The overlay and cursor planes are not mandatory, but can be used to perform complex
2abd7e59001123 Louis Chauvet       2024-08-27  44  	 * composition.
2abd7e59001123 Louis Chauvet       2024-08-27  45  	 */
e9d85f731de06a Rodrigo Siqueira    2019-06-25  46  	primary = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_PRIMARY, index);
854502fa0a38dc Rodrigo Siqueira    2018-05-16  47  	if (IS_ERR(primary))
854502fa0a38dc Rodrigo Siqueira    2018-05-16  48  		return PTR_ERR(primary);
854502fa0a38dc Rodrigo Siqueira    2018-05-16  49  
310e506c06e495 Melissa Wen         2021-04-24  50  	if (vkmsdev->config->overlay) {
df2d385cb4132e José Expósito       2022-01-07  51  		for (n = 0; n < NUM_OVERLAY_PLANES; n++) {
2abd7e59001123 Louis Chauvet       2024-08-27  52  			overlay = vkms_plane_init(vkmsdev, DRM_PLANE_TYPE_OVERLAY, index);
2abd7e59001123 Louis Chauvet       2024-08-27  53  			if (IS_ERR(overlay))
2abd7e59001123 Louis Chauvet       2024-08-27  54  				return PTR_ERR(overlay);
310e506c06e495 Melissa Wen         2021-04-24  55  		}
df2d385cb4132e José Expósito       2022-01-07  56  	}
310e506c06e495 Melissa Wen         2021-04-24  57  
2df7af93fdadb9 Sumera Priyadarsini 2021-01-12 @58  	if (vkmsdev->config->cursor) {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

