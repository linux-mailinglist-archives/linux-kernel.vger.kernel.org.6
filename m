Return-Path: <linux-kernel+bounces-337009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBA598441B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7E91C22E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C4A1A4E9D;
	Tue, 24 Sep 2024 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtNFncII"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FA1F5FF
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727175740; cv=none; b=j+7Ul+jRYFH+0L2+lSyiCDSYgaOmUbd2Mg80tLKDzMppdJT7N1ayFRnTApqokwXT6HtMn6S4dYmX5P47LaKCCfqwq/6Vczfk1HgsClaQUp97O2LfgHD+EuFpFhieoe5l2nTQ00sP58cw0xjFNqG3Se+wrOY9aCUpAzBOCjGzeT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727175740; c=relaxed/simple;
	bh=r+j1MXTxZz2fTAivtAhGK1Hjd2mJcNatuBZE7WbDSz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slJQ+wM/1663O51tdN6QUPvZO3kv5UfFb/HYWSd8IdQrA+Cj7SpwKyi6aPthFckwlRXFDEB3YyeXnkrhk2A6gF1+PHoL798neDFaHxIzhWlsCicf1UCg4HF88JcdRenBKCWP1okil7cxK0N45eoaX0yRHhMkEwOir3A0W4H7l4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtNFncII; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727175738; x=1758711738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r+j1MXTxZz2fTAivtAhGK1Hjd2mJcNatuBZE7WbDSz4=;
  b=OtNFncIIhB0rh8e6xlWW9o9MGsxocyb6vc+9HC01LxY0V8peEjyIV+CJ
   pXslMzKXPztuGPEZQSioJe/vE+p+sxnxWVUQRG1ympjU5SxKM20zNn1Bm
   rs7VmJFc/smO7guMt9nEI7txkDooz0oArJHCiZim/Cx6aooUdk8Q+w+oZ
   VAXCPlvlQ4WeEyk8slUFjqLLzw14EKTjdVdMkzSK5dmydFerBO6eB4dcb
   J1o4RY6w2vXqwxcuCSYbvB/wgiYeGmhoyWmxAghPJoURq03XgHklqNnnh
   /4hb7TMF//zxsMf6HIWOtgSRnhotRDiNFs+BeVz1bsVPOTqO1vPAJI7kJ
   A==;
X-CSE-ConnectionGUID: KcMH9xK0T8WPb631ejVTRw==
X-CSE-MsgGUID: Ly2etw7DS9OQVgzUHTQtDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="36748452"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="36748452"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 04:02:17 -0700
X-CSE-ConnectionGUID: WUmtV44ERIC2jdJW6RHO8Q==
X-CSE-MsgGUID: TF58PbtjRFeBD/sXxqz0lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="71823482"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Sep 2024 04:02:13 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1st3J5-000IFv-12;
	Tue, 24 Sep 2024 11:02:11 +0000
Date: Tue, 24 Sep 2024 19:01:12 +0800
From: kernel test robot <lkp@intel.com>
To: Hermes Wu <Hermes.Wu@ite.com.tw>, Pin-yen Lin <treapking@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, Kenneth Hung <Kenneth.hung@ite.com.tw>,
	Hermes Wu <Hermes.wu@ite.com.tw>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] drm/bridge: it6505: HDCP CTS fail on repeater
 items
Message-ID: <202409241856.OWgR1x3Y-lkp@intel.com>
References: <20240923094826.13471-3-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923094826.13471-3-Hermes.Wu@ite.com.tw>

Hi Hermes,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on drm-exynos/exynos-drm-next drm-intel/for-linux-next drm-intel/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master v6.11 next-20240923]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hermes-Wu/drm-bridge-it6505-fix-AUX-read-use-aux-fifo/20240923-175041
base:   git://anongit.freedesktop.org/drm/drm drm-next
patch link:    https://lore.kernel.org/r/20240923094826.13471-3-Hermes.Wu%40ite.com.tw
patch subject: [PATCH v3 2/3] drm/bridge: it6505: HDCP CTS fail on repeater items
config: nios2-randconfig-r073-20240924 (https://download.01.org/0day-ci/archive/20240924/202409241856.OWgR1x3Y-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409241856.OWgR1x3Y-lkp@intel.com/

smatch warnings:
drivers/gpu/drm/bridge/ite-it6505.c:2027 it6505_setup_sha1_input() warn: inconsistent indenting

vim +2027 drivers/gpu/drm/bridge/ite-it6505.c

b5c84a9edcd418 Allen Chen  2022-01-14  1996  
b5c84a9edcd418 Allen Chen  2022-01-14  1997  static int it6505_setup_sha1_input(struct it6505 *it6505, u8 *sha1_input)
b5c84a9edcd418 Allen Chen  2022-01-14  1998  {
d65feac281ab47 Pin-yen Lin 2023-07-18  1999  	struct device *dev = it6505->dev;
b5c84a9edcd418 Allen Chen  2022-01-14  2000  	u8 binfo[2];
9665163df60e16 Hermes Wu   2024-09-23  2001  	int down_stream_count, err, msg_count = 0;
b5c84a9edcd418 Allen Chen  2022-01-14  2002  
b5c84a9edcd418 Allen Chen  2022-01-14  2003  	err = it6505_get_dpcd(it6505, DP_AUX_HDCP_BINFO, binfo,
b5c84a9edcd418 Allen Chen  2022-01-14  2004  			      ARRAY_SIZE(binfo));
b5c84a9edcd418 Allen Chen  2022-01-14  2005  
b5c84a9edcd418 Allen Chen  2022-01-14  2006  	if (err < 0) {
b5c84a9edcd418 Allen Chen  2022-01-14  2007  		dev_err(dev, "Read binfo value Fail");
b5c84a9edcd418 Allen Chen  2022-01-14  2008  		return err;
b5c84a9edcd418 Allen Chen  2022-01-14  2009  	}
b5c84a9edcd418 Allen Chen  2022-01-14  2010  
b5c84a9edcd418 Allen Chen  2022-01-14  2011  	down_stream_count = binfo[0] & 0x7F;
b5c84a9edcd418 Allen Chen  2022-01-14  2012  	DRM_DEV_DEBUG_DRIVER(dev, "binfo:0x%*ph", (int)ARRAY_SIZE(binfo),
b5c84a9edcd418 Allen Chen  2022-01-14  2013  			     binfo);
b5c84a9edcd418 Allen Chen  2022-01-14  2014  
b5c84a9edcd418 Allen Chen  2022-01-14  2015  	if ((binfo[0] & BIT(7)) || (binfo[1] & BIT(3))) {
b5c84a9edcd418 Allen Chen  2022-01-14  2016  		dev_err(dev, "HDCP max cascade device exceed");
b5c84a9edcd418 Allen Chen  2022-01-14  2017  		return 0;
b5c84a9edcd418 Allen Chen  2022-01-14  2018  	}
b5c84a9edcd418 Allen Chen  2022-01-14  2019  
b5c84a9edcd418 Allen Chen  2022-01-14  2020  	if (!down_stream_count ||
b5c84a9edcd418 Allen Chen  2022-01-14  2021  	    down_stream_count > MAX_HDCP_DOWN_STREAM_COUNT) {
b5c84a9edcd418 Allen Chen  2022-01-14  2022  		dev_err(dev, "HDCP down stream count Error %d",
b5c84a9edcd418 Allen Chen  2022-01-14  2023  			down_stream_count);
b5c84a9edcd418 Allen Chen  2022-01-14  2024  		return 0;
b5c84a9edcd418 Allen Chen  2022-01-14  2025  	}
9665163df60e16 Hermes Wu   2024-09-23  2026  	err =  it6505_get_ksvlist(it6505, sha1_input, down_stream_count * 5);
b5c84a9edcd418 Allen Chen  2022-01-14 @2027  		if (err < 0)
b5c84a9edcd418 Allen Chen  2022-01-14  2028  			return err;
b5c84a9edcd418 Allen Chen  2022-01-14  2029  
9665163df60e16 Hermes Wu   2024-09-23  2030  	msg_count += down_stream_count * 5;
b5c84a9edcd418 Allen Chen  2022-01-14  2031  
b5c84a9edcd418 Allen Chen  2022-01-14  2032  	it6505->hdcp_down_stream_count = down_stream_count;
b5c84a9edcd418 Allen Chen  2022-01-14  2033  	sha1_input[msg_count++] = binfo[0];
b5c84a9edcd418 Allen Chen  2022-01-14  2034  	sha1_input[msg_count++] = binfo[1];
b5c84a9edcd418 Allen Chen  2022-01-14  2035  
b5c84a9edcd418 Allen Chen  2022-01-14  2036  	it6505_set_bits(it6505, REG_HDCP_CTRL2, HDCP_EN_M0_READ,
b5c84a9edcd418 Allen Chen  2022-01-14  2037  			HDCP_EN_M0_READ);
b5c84a9edcd418 Allen Chen  2022-01-14  2038  
b5c84a9edcd418 Allen Chen  2022-01-14  2039  	err = regmap_bulk_read(it6505->regmap, REG_M0_0_7,
b5c84a9edcd418 Allen Chen  2022-01-14  2040  			       sha1_input + msg_count, 8);
b5c84a9edcd418 Allen Chen  2022-01-14  2041  
b5c84a9edcd418 Allen Chen  2022-01-14  2042  	it6505_set_bits(it6505, REG_HDCP_CTRL2, HDCP_EN_M0_READ, 0x00);
b5c84a9edcd418 Allen Chen  2022-01-14  2043  
b5c84a9edcd418 Allen Chen  2022-01-14  2044  	if (err < 0) {
b5c84a9edcd418 Allen Chen  2022-01-14  2045  		dev_err(dev, " Warning, Read M value Fail");
b5c84a9edcd418 Allen Chen  2022-01-14  2046  		return err;
b5c84a9edcd418 Allen Chen  2022-01-14  2047  	}
b5c84a9edcd418 Allen Chen  2022-01-14  2048  
b5c84a9edcd418 Allen Chen  2022-01-14  2049  	msg_count += 8;
b5c84a9edcd418 Allen Chen  2022-01-14  2050  
b5c84a9edcd418 Allen Chen  2022-01-14  2051  	return msg_count;
b5c84a9edcd418 Allen Chen  2022-01-14  2052  }
b5c84a9edcd418 Allen Chen  2022-01-14  2053  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

