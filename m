Return-Path: <linux-kernel+bounces-352200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926F3991BAE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 03:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5587A2832FC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 01:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1467B67F;
	Sun,  6 Oct 2024 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jsMSY5ek"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71A23D76
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728176502; cv=none; b=qIAV1AQ7HqvWNCLG3Q7s1qasui5FjRtPMPadcJHp+n68S2Tw0zWC1Hh1VNIy3w3mEBsI/5mA+UILlJwEax8VqicfRVtiALf7EabW7HuB6rwnNDJLm4MRKCKs+5hS5jdiC/cWvu3/8GdlF/l1aUSgswwF0OP6cAlpcWNMK43fSQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728176502; c=relaxed/simple;
	bh=YIWI7OzQBWjQRQD3dHv9yU7vVXX/6sPNdKhYQzsmi7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfXrwb4y6T1bnXyP5KZW3wFycReZNRpJRKFfW99mQgOcni5b2SEApf14FUGjbjz/xBX+MwRrFIw2g5Daxe68GZvx4QnR7xzD4KjNZT5ySSQL2YHG6FQPqZLO9An6eiUzZXVL3DIKrS+03tC/LxIk3mUY2ki8BrLoEfpFF4Yf1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jsMSY5ek; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728176497; x=1759712497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YIWI7OzQBWjQRQD3dHv9yU7vVXX/6sPNdKhYQzsmi7s=;
  b=jsMSY5ek83voJiVLhuWAIsMRf950sLgQ9J4yB3UhlCqZbK+H+S0PoaBw
   eNyRVnnQZSlNhbz+U4/Lo8BYHd3HXYoBOLtQlmWM9eZNJ2WDq2jUDZY95
   sMVwXUVGcNLEESQ6wtQQtW8YDTxIA85srxmWbKYkhWFFQHiz2pqvswMRE
   mmcbSzS01KNjdob1HXOLq2zzGqIWfytDLzJauOWI0QJsjcybE00pq7cxX
   Y8Ln+LfrA03BPkTFOnrkOAYmH0rqAld/OwbOau5d/GIwy1jAMhrfXic/R
   +8bCtV9yigYdaNY2i7QBjZuc38pWb0WxjGP243qqqj0Jo0SiU1A9CrCSY
   Q==;
X-CSE-ConnectionGUID: LGt+ss4vTaGEaFKANf2dhw==
X-CSE-MsgGUID: 71y4dkdmRcy9M11npQwGBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="52759057"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="52759057"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 18:01:36 -0700
X-CSE-ConnectionGUID: rm2xF1dkRRm8x8ZgM0GGpg==
X-CSE-MsgGUID: /8nkO2UwQra292lnawWP8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="75420417"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Oct 2024 18:01:34 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxFeO-0003Uw-0U;
	Sun, 06 Oct 2024 01:01:32 +0000
Date: Sun, 6 Oct 2024 09:01:14 +0800
From: kernel test robot <lkp@intel.com>
To: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: oe-kbuild-all@lists.linux.dev, skhan@linuxfoundation.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu/drm: set gamma_lut or degamma_lut based on HW in
 setcmap_atomic
Message-ID: <202410060802.Ln9ygpuY-lkp@intel.com>
References: <20241003120655.53663-1-vamsikrishna.brahmajosyula@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003120655.53663-1-vamsikrishna.brahmajosyula@gmail.com>

Hi Vamsi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7ec462100ef9142344ddbf86f2c3008b97acddbe]

url:    https://github.com/intel-lab-lkp/linux/commits/Vamsi-Krishna-Brahmajosyula/gpu-drm-set-gamma_lut-or-degamma_lut-based-on-HW-in-setcmap_atomic/20241003-200835
base:   7ec462100ef9142344ddbf86f2c3008b97acddbe
patch link:    https://lore.kernel.org/r/20241003120655.53663-1-vamsikrishna.brahmajosyula%40gmail.com
patch subject: [PATCH] gpu/drm: set gamma_lut or degamma_lut based on HW in setcmap_atomic
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241006/202410060802.Ln9ygpuY-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241006/202410060802.Ln9ygpuY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410060802.Ln9ygpuY-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "drm_mode_obj_find_prop_id" [drivers/gpu/drm/drm_kms_helper.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

