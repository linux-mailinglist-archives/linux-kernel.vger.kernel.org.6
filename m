Return-Path: <linux-kernel+bounces-357409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C2E9970F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29D01C20E4E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81211E7C2A;
	Wed,  9 Oct 2024 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLs2vOeX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5563A1E1049
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489495; cv=none; b=H13AZv2pWUooqcevslBUKA+KYtdXcPC2chukcQO/OvRTdMxtrt555AfuccsYxrQ7VTRzVcQUntectJ+4yD/B5QlU0g7L/wMCJ/SrriRP9Sf5w6O+oP7YmoFucwj3h1CPKDTL/oPO/XR+xj1fydtwjYhC/hkkjOxpfL3ufZddCxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489495; c=relaxed/simple;
	bh=DQ+UXJ6V9fAJtdAYV5JF+pZvbG+QV1OVa/sMvW/vdW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XwrC7ImM0Zi/daeIWeT78JDxPR/BfYsDidf9qIajQvIVCUodBET5q9bNz78ki60VYJfROj1Fjoz8l181SzFmEql9Zf3h/LdcCyvQ6Dp3Ardo9lDWLYD+Cb4GkhZJdlxaFfDYTg8fAVvGdpo1i2+PZ//Eg0ERF7jLznImAMQfOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLs2vOeX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728489493; x=1760025493;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=DQ+UXJ6V9fAJtdAYV5JF+pZvbG+QV1OVa/sMvW/vdW8=;
  b=ZLs2vOeXCBmraEroFPGo9Y6D76GxN41MOkAHP9DoNUJuz8BUeU11xugJ
   gEdKEZ5dq+ovkIYywfqWzV8zOUGD5f3Yy4hkl0B75YwiHh5PI1NBxSLIk
   rB+KUuR8lyE6cSX2a0IX1JS1MejNCohYkLRcgTX+YGu7ireT8ottsC1Pa
   7zfyGSLVaSNCkhJzmzYU2FR3ZiReJ1L5vHKMye5doPdN8iJZPGeXiJ+iB
   e+xCDjMsfRRDwjGazgiycMGeKfaPqNpcYjmVTqOIkydt3HSL4swzHOu5O
   nKc4iURaI8eIz+yYPDwJUoNelsdiGYE7s7rWEcMFl6MLOaY2YuEPnqVgx
   A==;
X-CSE-ConnectionGUID: 0d1Js9z7QlqEu7bAwyn5pQ==
X-CSE-MsgGUID: +N4B34EOSMSeGkTgjjJXeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="38448345"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="38448345"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:58:12 -0700
X-CSE-ConnectionGUID: StWuh8uQR7yw7xUh157Y4Q==
X-CSE-MsgGUID: ivsXANsTTq25vy/oUx1Bog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="76193122"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.80])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:58:09 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: R Sundar <prosunofficial@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, R Sundar
 <prosunofficial@gmail.com>
Subject: Re: [PATCH linux-next] drm: Fix for kernel doc warning
In-Reply-To: <20241003023806.17537-1-prosunofficial@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241003023806.17537-1-prosunofficial@gmail.com>
Date: Wed, 09 Oct 2024 18:58:06 +0300
Message-ID: <87frp58e0h.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 03 Oct 2024, R Sundar <prosunofficial@gmail.com> wrote:
> Added colon in kernel-doc comment to fix the warning.
>
> ./include/drm/drm_drv.h:372: warning: Incorrect use of kernel-doc format:          * @fbdev_probe
> ./include/drm/drm_drv.h:435: warning: Function parameter or struct member 'fbdev_probe' not described in 'drm_driver'
>
> Signed-off-by: R Sundar <prosunofficial@gmail.com>

Pushed to drm-misc-next, thanks for the patch.

BR,
Jani.

> ---
>  include/drm/drm_drv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 36a606af4ba1..1bbbcb8e2d23 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -369,7 +369,7 @@ struct drm_driver {
>  			       uint64_t *offset);
>  
>  	/**
> -	 * @fbdev_probe
> +	 * @fbdev_probe:
>  	 *
>  	 * Allocates and initialize the fb_info structure for fbdev emulation.
>  	 * Furthermore it also needs to allocate the DRM framebuffer used to

-- 
Jani Nikula, Intel

