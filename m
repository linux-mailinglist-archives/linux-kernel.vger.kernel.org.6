Return-Path: <linux-kernel+bounces-185425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7088CB4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26FF7284304
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D875553816;
	Tue, 21 May 2024 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hDwHdGYG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB8C208D0;
	Tue, 21 May 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324034; cv=none; b=rWD6X3kUlfxwoFRvYrEp3ObFNv3OZ80rGVA1ucAoM65Dg2HzAXB0jHegv4A11icZKtR8rjknlfxTJGWvWfE1mShL34f6x4OrSCqKEEmibvh3U12NRTnNpPdZ5tSAM5h6HPODtnM/lhj1Rpsy4KsKSSPFWQ4bqZGXBoN7mQnIMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324034; c=relaxed/simple;
	bh=a7HBpYV952J/NzsIFy4t5Olu/Ny1r0SLPd7DBdGJaTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Atn+TOcpdhOJmUY16Nlh2pE0bD9jK+WUqrZi5VdC7cILD5rjknfx5yeyJWMXHNXGWBibQihWde8dDqQDxYDkRKDjuIzA1aGErDa07sTXKvi7aQlozhl+WAEo2M6rOkm34njogmxbFpgoHL1Ts3hHJVsTu/eoYcwlLMtvjtupfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hDwHdGYG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716324032; x=1747860032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a7HBpYV952J/NzsIFy4t5Olu/Ny1r0SLPd7DBdGJaTc=;
  b=hDwHdGYGIx4gDiMbR+Q9sxdGcwBnCaQNiPAUEnmE5IYRwVmuQoSpgmJo
   DuIPAMcJC0WoMfAnO6zI054Vcb4fWmCvd02WUN+aCkJhYfQ5f0pbTU1A4
   2i6Wm3yXHJHAjxC4esDh8tIC7hZCBA6Ak9G8sNbzclXvcyuLeGZHzUTC/
   TnYlFlS3+IE6ZUpP+CeoDyutMw2yGH9cTeL+F03NesngKEodohAfb646B
   s6G1EkxrMeEMLLsAhpNLlNE13yDchW2Rt9SVpcuu/RaJYUQKhOqJsuZvn
   VGTi5QH4AkoFtub0cwtF4o8+GJNVwenCJK8fyQCQ3xiUAhCu8VJjjLa5y
   g==;
X-CSE-ConnectionGUID: ZncMOTvfRGaEMEOCT5J5Sw==
X-CSE-MsgGUID: 7x0DHDBVTZqgFH1GzzMeQQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="30068654"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="30068654"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 13:40:31 -0700
X-CSE-ConnectionGUID: gobwC626TcO4ZqmEhMLEXA==
X-CSE-MsgGUID: FYk2rclmRAKYeyzfQKofPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="37813587"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 21 May 2024 13:40:24 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9WHG-0000i1-1y;
	Tue, 21 May 2024 20:40:21 +0000
Date: Wed, 22 May 2024 04:39:47 +0800
From: kernel test robot <lkp@intel.com>
To: keith <keith.zhao@starfivetech.com>, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, hjc@rock-chips.com, heiko@sntech.de,
	andy.yan@rock-chips.com, xingyu.wu@starfivetech.com,
	p.zabel@pengutronix.de, jack.zhu@starfivetech.com,
	shengyang.chen@starfivetech.com
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, keith.zhao@starfivetech.com
Subject: Re: [PATCH v4 06/10] drm/vs: add vs plane api
Message-ID: <202405220419.2XNzWyBP-lkp@intel.com>
References: <20240521105817.3301-7-keith.zhao@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521105817.3301-7-keith.zhao@starfivetech.com>

Hi keith,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master next-20240521]
[cannot apply to robh/for-next rockchip/for-next v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/keith/dt-bindings-display-Add-YAML-schema-for-JH7110-display-pipeline/20240521-110316
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240521105817.3301-7-keith.zhao%40starfivetech.com
patch subject: [PATCH v4 06/10] drm/vs: add vs plane api
config: m68k-randconfig-r133-20240522 (https://download.01.org/0day-ci/archive/20240522/202405220419.2XNzWyBP-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240522/202405220419.2XNzWyBP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405220419.2XNzWyBP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/verisilicon/vs_plane.c:83:30: sparse: sparse: symbol 'vs_plane_funcs' was not declared. Should it be static?
>> drivers/gpu/drm/verisilicon/vs_plane.c:339:37: sparse: sparse: symbol 'primary_plane_helpers' was not declared. Should it be static?
>> drivers/gpu/drm/verisilicon/vs_plane.c:345:37: sparse: sparse: symbol 'overlay_plane_helpers' was not declared. Should it be static?
>> drivers/gpu/drm/verisilicon/vs_plane.c:351:37: sparse: sparse: symbol 'cursor_plane_helpers' was not declared. Should it be static?

vim +/vs_plane_funcs +83 drivers/gpu/drm/verisilicon/vs_plane.c

    82	
  > 83	const struct drm_plane_funcs vs_plane_funcs = {
    84		.update_plane		= drm_atomic_helper_update_plane,
    85		.disable_plane		= drm_atomic_helper_disable_plane,
    86		.reset			= vs_plane_reset,
    87		.atomic_duplicate_state = vs_plane_atomic_duplicate_state,
    88		.atomic_destroy_state	= vs_plane_atomic_destroy_state,
    89		.format_mod_supported	= vs_format_mod_supported,
    90	};
    91	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

