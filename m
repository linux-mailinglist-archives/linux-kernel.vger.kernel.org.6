Return-Path: <linux-kernel+bounces-261172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1D293B397
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812A41F222C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DFE15B145;
	Wed, 24 Jul 2024 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/gmgmh3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC379F0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721834904; cv=none; b=acccB16PiPw5Wi2zDsf8Gou+XtE4jjFb4Hy4SO+OGTVN0YWLHn36AH7CWw8tbjaHLOv/dTi2MyDG46d6/Tg1IIrcTH+mdNCq7qJDnhco/zB9TeZlLw4ORRMYthcjcNpV6aQubzskGWOsvNwkSVuD7W44riORPQDDAIPgQ5IYATY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721834904; c=relaxed/simple;
	bh=0Dj1AKzynzsxk7yAML0UPq9lQgI1l/ahyV3qibSWO8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H9B7BJAgfdxBK8bYswyaTCINM6hDc+0CQT1fYMqWHZShO6IhrwQOZKwGLa5zLpdHZac7B7Ir7pjjD9l7jNGZuv6N1BMZpLH4pfFzw6oKhigO+ILQzx/SQGU2QTXo6II3IK0kVkNsI7b+uZ3nB/+smfgEtZ8wPaNGyB7YAbU/Zmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/gmgmh3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721834902; x=1753370902;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0Dj1AKzynzsxk7yAML0UPq9lQgI1l/ahyV3qibSWO8A=;
  b=Y/gmgmh3Uf8O45GCTi7tk2tI4ry+m0wbDxNWTUVkRHq/rKZAXD1WkmtR
   iKgh6kgIy9IsZzcD8uYNdoSJNy7uQS5Tj4SaQjbc36Q4movbYKu609SvR
   WZS+PAuTlpk9Ev4I49exfYzuO/wiBIps3dQ65lWi8xynD+0sknwGfuDxb
   5DRdbfBZw240cMzp0fzO0cOzD6YcmLTcr+nSiTtriTRX+rkF5nT5QxSh5
   mQYbEKOdIUJzhcvNldV5iOMqxyZpqLAX1OTP8po+xN/hFDeTmof0GJ+8o
   u8iTBCJ0P9QaxadsAl4l4nDEIciI+L8D2mV2a9l6uUE4Ny+e6+/peI5q5
   g==;
X-CSE-ConnectionGUID: qo6qpkKbT3a+h8zp+bRiQw==
X-CSE-MsgGUID: 0M1FqHG4REizex14j+4OVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="36977061"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="36977061"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 08:28:22 -0700
X-CSE-ConnectionGUID: /qgORqtkS7CjoqsqbSHWNg==
X-CSE-MsgGUID: 5tISUXVfToiZqZe4+htJhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="57430010"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.197])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 08:28:13 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Tejas Vipin <tejasvipin76@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: dianders@chromium.org, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Tejas Vipin
 <tejasvipin76@gmail.com>
Subject: Re: [PATCH 1/2] drm/mipi-dsi: Add quiet member to
 mipi_dsi_multi_context struct
In-Reply-To: <20240724122447.284165-2-tejasvipin76@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240724122447.284165-1-tejasvipin76@gmail.com>
 <20240724122447.284165-2-tejasvipin76@gmail.com>
Date: Wed, 24 Jul 2024 18:28:04 +0300
Message-ID: <87a5i6kdx7.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 24 Jul 2024, Tejas Vipin <tejasvipin76@gmail.com> wrote:
> A "quiet" member is added to mipi_dsi_multi_context which allows 
> silencing all the errors printed by the multi functions.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  include/drm/drm_mipi_dsi.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
> index 0f520eeeaa8e..75855c1c7dae 100644
> --- a/include/drm/drm_mipi_dsi.h
> +++ b/include/drm/drm_mipi_dsi.h
> @@ -217,6 +217,16 @@ struct mipi_dsi_multi_context {
>  	 * end to see if any of them failed.
>  	 */
>  	int accum_err;
> +
> +	/**
> +	 * @quiet: Controls if a function calls dev_err or not
> +	 *
> +	 * Init to 0. When the value of quiet is set to 0, the function
> +	 * will  print error messages as required. If this is set to 1,
> +	 * the function will not print error messages, but will still
> +	 * change the value of accum_err.
> +	 */
> +	int quiet;

This is being used as a bool, why not make it a bool?

BR,
Jani.


>  };
>  
>  #define MIPI_DSI_MODULE_PREFIX "mipi-dsi:"

-- 
Jani Nikula, Intel

