Return-Path: <linux-kernel+bounces-381408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B82B9AFEBB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8BA5B24FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971B818B484;
	Fri, 25 Oct 2024 09:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXvFZZ1s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B826512FB1B;
	Fri, 25 Oct 2024 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849564; cv=none; b=dO2Y8+AQ/Pi0sg3IaH0N00VVHsGD/AbaHE6G2r5YUXhgOuFJueHNpTNIqa5Q0jSkFEXfQrqWq67fl5kh/x/CfxyxKZfZFMUorlskzLDNCR3ioM7zMWI4Tdu2vr9cSxHrfQvw3t2w86S07MoQfJg6kVhnB2A3FbaiauZ15Gln9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849564; c=relaxed/simple;
	bh=ZARvpj+4y2gmcRwYkJIUqXAw6D/BozzudJM0om84MZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8pM4TWDFc0kO5FcvJzCvzZp8Qtrtpi9nl6HCB89dsk6BaIDbwiaSFq+gR2Lov/fofNpkpD6O3UMTndr+2+MPN4dzrKTHigugoPSq5uoum2jnOeCBZBSsCNXnhYUldxKJiohr/5ZnnVVzyQCgzVBrBWynK+NyM7r7UQtL5zCvu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXvFZZ1s; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729849561; x=1761385561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZARvpj+4y2gmcRwYkJIUqXAw6D/BozzudJM0om84MZw=;
  b=SXvFZZ1sroJ6Jrx3eNYhf96jwj2GSDiJiAZJSQNpY+fyIvH3A379nHx4
   IXdNQs7AHT3KmVc2mD0MkBzF4W5Pnhqzk2oKcZT1MpiW9ebb6q5ATRvqe
   FZXZoMEmUxU1dO9Twx4wGPcZOe3k7AekMwnsOJRfFc3qI/LeK+B+lyL8/
   5K7tzCIxBjKobvJ3zah4LOCsN0Aqc3WQ55u7EmN/A4JxfH+ySzIAWdFfB
   IKEeSnS1U9bjUus4ct2DbyRGIvmw+q1XzzHJZVSnZp9yMzzDV+vBloPLE
   o+LaOOao4kJ8fNNyuVCWdVQvGT6eVBiXvChcco328e+w5VZ7mZhTyXqOZ
   g==;
X-CSE-ConnectionGUID: jLuc7QDBQcyCPTY7JWE7Eg==
X-CSE-MsgGUID: 0SHniX3rTFGYvTyDbt9s8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40129328"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="40129328"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 02:46:00 -0700
X-CSE-ConnectionGUID: 5UHDvqAZSEqUUNxuUDqGnQ==
X-CSE-MsgGUID: kC3HEjRVT0SmaAYZ8zBJ+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="81188264"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 25 Oct 2024 02:45:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4GtE-000Y0T-1q;
	Fri, 25 Oct 2024 09:45:52 +0000
Date: Fri, 25 Oct 2024 17:45:43 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Maxime Ripard <mripard@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 21/37] drm/vc4: txp: Add support for BCM2712 MOP
Message-ID: <202410251725.ZQplKjRl-lkp@intel.com>
References: <20241023-drm-vc4-2712-support-v1-21-1cc2d5594907@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-drm-vc4-2712-support-v1-21-1cc2d5594907@raspberrypi.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 91e21479c81dd4e9e22a78d7446f92f6b96a7284]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Stevenson/drm-vc4-Limit-max_bpc-to-8-on-Pi0-3/20241024-005239
base:   91e21479c81dd4e9e22a78d7446f92f6b96a7284
patch link:    https://lore.kernel.org/r/20241023-drm-vc4-2712-support-v1-21-1cc2d5594907%40raspberrypi.com
patch subject: [PATCH 21/37] drm/vc4: txp: Add support for BCM2712 MOP
config: arc-randconfig-r111-20241025 (https://download.01.org/0day-ci/archive/20241025/202410251725.ZQplKjRl-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241025/202410251725.ZQplKjRl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410251725.ZQplKjRl-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/vc4/vc4_txp.c:513:27: sparse: sparse: symbol 'bcm2712_mop_data' was not declared. Should it be static?

vim +/bcm2712_mop_data +513 drivers/gpu/drm/vc4/vc4_txp.c

   512	
 > 513	const struct vc4_txp_data bcm2712_mop_data = {
   514		.base = {
   515			.name = "mop",
   516			.debugfs_name = "mop_regs",
   517			.hvs_available_channels = BIT(2),
   518			.hvs_output = 2,
   519		},
   520		.encoder_type = VC4_ENCODER_TYPE_TXP0,
   521		.high_addr_ptr_reg = TXP_DST_PTR_HIGH_MOP,
   522		.has_byte_enable = true,
   523		.size_minus_one = true,
   524		.supports_40bit_addresses = true,
   525	};
   526	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

