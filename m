Return-Path: <linux-kernel+bounces-314521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E42D96B46D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30582880A1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB741898E5;
	Wed,  4 Sep 2024 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b36XrRSY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267AD188A2D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438142; cv=none; b=bylgf78eCAcW8ZFfT+pS6O4XVHZtpsSSHOWHBz5I5DrQgm8TcfJ1sA7mhXF20DUuGLcc+qO8WsSxgvL/dr6r8M97eOwsvHm+ANWEOr6Csymm0Dx1t7JfS2DVF/Dz7pZdgLLKFygAEQlRqWY0A9e5T3iRyy0bNW8cEObuSwiL2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438142; c=relaxed/simple;
	bh=V1FmEQxa7lsgaFs6dxtMyqS9h9XeuCAQr3fIQa40Vko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ut5xkUgG95L6g8rrQUo/fez3MLafED5Jz4YKyXQKxi10jeC1x7iuhkEKJg7PzS04ikluhkNPF2Uw8QDU2FxiYYoGvCuh0BvVxa0PqC4wkdJ8342QvR0S4JwddbouwitUdHjWWlYI6yGOCkJDiT9uZUolmuO2zUBEE+eFoj/OCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b36XrRSY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725438141; x=1756974141;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=V1FmEQxa7lsgaFs6dxtMyqS9h9XeuCAQr3fIQa40Vko=;
  b=b36XrRSYtOnEijRdVtqhc84dQsSheiz40xFfTEpRe8B9gFuhpCae817X
   tvhlNPXWuxxEnhUdplmM2xrUI5BIiLERL5B9pDl/6wH+zkO9Bd7nLGo4F
   LADt/mI6xGubd6r+Q+9We9RQvL7/cmMIyvT8X2K+7FaJWA5ucKKsXCnJi
   sBfT4sod4EWZcod6wO/PDyQfGFHmptxGsp3yphSX88RQ36eNbBGmLMwgr
   fudF1vc79dwbVET+H3ns9SrIPfvYYAwuAtaFeUi1rLvvxQEQM9g26/PCm
   SeYujQbU8ZIVTsbfUjLXgXTm9C47vVDT3o6difvDk9PY1alpnv53Mb4Ry
   w==;
X-CSE-ConnectionGUID: gw9CYR16RC2FPgemQHEwYQ==
X-CSE-MsgGUID: tdc2glgbTKqGy2tF//8QJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="34743456"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="34743456"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 01:22:21 -0700
X-CSE-ConnectionGUID: fhxr+nYxRoODf5yvaTE17Q==
X-CSE-MsgGUID: rm5Y8ZLpSGWehoeNaPv1rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="69353257"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.18])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 01:22:16 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Alex Deucher
 <alexander.deucher@amd.com>, Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, Hawking Zhang <Hawking.Zhang@amd.com>, Hamza
 Mahfooz <hamza.mahfooz@amd.com>
Subject: Re: [PATCH] drm/amdgpu: enable -Wformat-truncation
In-Reply-To: <20240903200953.292717-1-hamza.mahfooz@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240903200953.292717-1-hamza.mahfooz@amd.com>
Date: Wed, 04 Sep 2024 11:21:59 +0300
Message-ID: <875xrbu8uw.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 03 Sep 2024, Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
> It is enabled by W=1 and amdgpu has a clean build with it enabled. So,
> to make sure we block future instances of it from showing up on
> our driver, enable it by default for the module.

Would prefer enabling it by default across the subsystem [1].

BR,
Jani.


[1] https://lore.kernel.org/r/cover.1716479340.git.jani.nikula@intel.com

>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 34943b866687..64adadb56fd6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -41,6 +41,7 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
>  
>  # Locally disable W=1 warnings enabled in drm subsystem Makefile
>  subdir-ccflags-y += -Wno-override-init
> +subdir-ccflags-y += $(call cc-option, -Wformat-truncation)
>  subdir-ccflags-$(CONFIG_DRM_AMDGPU_WERROR) += -Werror
>  
>  amdgpu-y := amdgpu_drv.o

-- 
Jani Nikula, Intel

