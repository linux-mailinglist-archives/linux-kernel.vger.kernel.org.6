Return-Path: <linux-kernel+bounces-420658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BF59D806A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA88164562
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC0F188CCA;
	Mon, 25 Nov 2024 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWcKaA79"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1577183CC1;
	Mon, 25 Nov 2024 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525513; cv=none; b=crrIK+KuAspAfD1Iv9JjfXPmGJN1aSdCyV71dwZM26v+vvVr0IK0DFBv8SUUE5OVfxAD9kVzOTdKNwu+eBilSB/AWetR7V/24NYtiLHigBCYLFGYxHtacXSbrKDB0W0RQL2/V3CswUMJ6Qv0a+Dd9Z93ApyJkaUalbXi3XWxY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525513; c=relaxed/simple;
	bh=1HEwJ06OdfnNR7EruhIW+OMlB4IJ53R9E6nB3+JJJdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cTvF+5qrhJOBZonDRS1ce0yl/eeh0gOuDMmKfyKxTYg0DVqkEqGfqoK3yUD9AXIuSvEKWpSjbJMyApXDw+dOO6rmKOUaMXASHWD5PTA+W2Q84whKCJ+l3jZEZ0sSUJoiDjDCIxOw0L1jY6JVa7oirJaBknrFx2PjOrSn29bBFAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWcKaA79; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732525510; x=1764061510;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=1HEwJ06OdfnNR7EruhIW+OMlB4IJ53R9E6nB3+JJJdI=;
  b=DWcKaA79Prfj2sB5WBoyVWXhoTbYXvmakQSdePBamx4vg1teNr/nIwEY
   HeSOralMrgRzwsL0eL88hruHP7BJwB5yDejuMOvuzDnGuJANFcR07j5cm
   zimqL/rUGafdjyfj8Lba7OJWIfERPA7geK8ocFkoHRDXfSNKK/lUwW23b
   6BFQLYyOCpH1pODlMhjG4OFATQ2fS31nNOWXomoyj+mpWou6WbA7wXk11
   6NwgVj2mrdL1ufPreYWmr/yI+Nd6R9F/kNXUBtUrgpkvgUzeXPoKaeHoB
   kTYTu5sX59LKdsSDAhHKYYRzt+nJ1SwI5U/iOd6WMVcEl0ZY8xa5gtwNg
   g==;
X-CSE-ConnectionGUID: zHEylp8lTHCvWT+6tRDe2w==
X-CSE-MsgGUID: u2wjQ++LTeOrZA76xG76XA==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="36400630"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="36400630"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 01:05:09 -0800
X-CSE-ConnectionGUID: R1kbqonqR++M9M/J5KxKdg==
X-CSE-MsgGUID: iccNDivmR82kc2bbOfKeJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="122049485"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.243])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 01:05:03 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Sasha Finkelstein via B4 Relay
 <devnull+fnkl.kernel.gmail.com@kernel.org>, Hector Martin
 <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sasha
 Finkelstein <fnkl.kernel@gmail.com>, Janne Grunau <j@jannau.net>
Subject: Re: [PATCH 2/5] gpu: drm: adp: Add Apple Display Pipe driver
In-Reply-To: <20241124-adpdrm-v1-2-3191d8e6e49a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
 <20241124-adpdrm-v1-2-3191d8e6e49a@gmail.com>
Date: Mon, 25 Nov 2024 11:04:59 +0200
Message-ID: <8734jfznt0.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, 24 Nov 2024, Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org> wrote:
> diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..36510194e18161ef6514885c764b2e7085c587e5
> --- /dev/null
> +++ b/drivers/gpu/drm/adp/adp_drv.c
> @@ -0,0 +1,814 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/anon_inodes.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/file.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +#include <asm/current.h>
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_damage_helper.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_edid.h>
> +#include <drm/drm_fb_dma_helper.h>
> +#include <drm/drm_file.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_gem_atomic_helper.h>
> +#include <drm/drm_gem_dma_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_probe_helper.h>
> +#include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_vblank.h>

Please only include what you use.

BR,
Jani.


-- 
Jani Nikula, Intel

