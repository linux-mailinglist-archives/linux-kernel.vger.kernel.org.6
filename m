Return-Path: <linux-kernel+bounces-554030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85859A591FA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39343188C771
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23635227B95;
	Mon, 10 Mar 2025 10:52:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC50226529
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603966; cv=none; b=iOypwOSvDJx4+AbGKoCAHY46nAKDj89P6XJ8xgSB1MGwZxvgA5B945aQVT6OI5/C/K3+1lianFWfqhZ8g5BwakoEI4zHfxVVWEU3pNqJ0EUqo5D/CapuQRv1QbHBNEW4GPW4lPMGsPI3Oo8VqZpZqNbS+Cn244Ya9KXv5OucBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603966; c=relaxed/simple;
	bh=CMyr7J47+rVV3eZXPZ5GDsVhG5MGIzGF5kCME7CTjSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAUbRhkd6JVqJZc1nAbf2/1rZh+RGz+1S8tkKPgrnLC63SlaY9u7bAohZg9qkiX3lWymH7YzrAcenedcocZxgTBO5xjRh9kZ5nOv91mYkPe9V6Sbhr9jFrQgPCQoBimVMjYZGFqPLHpMNh2N3BzINjX2ZfCL+hsa+XheL0mMYhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10687153B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:52:55 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F7FB3F5A1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:52:43 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:52:34 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com, niecheng1@uniontech.com,
	guanwentao@uniontech.com, chenlinxuan@uniontech.com
Subject: Re: [PATCH] drm/arm: Suppress "ARM devices" menu if not essential
Message-ID: <Z87EcmftDZ1QOLL0@e110455-lin.cambridge.arm.com>
References: <D20815A68EE4902F+20250310072357.52841-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D20815A68EE4902F+20250310072357.52841-1-wangyuli@uniontech.com>

On Mon, Mar 10, 2025 at 03:23:57PM +0800, WangYuli wrote:
> Manifestly, the "ARM devices" menu is appropriate only for the ARM
> architecture.
> 
> Inasmuch as every single item in this menu is predicated on
> (ARM || ARM64 || COMPILE_TEST), it is therefore illogical for the
> "ARM devices" menu itself not to be predicated upon
> (ARM || ARM64 || COMPILE_TEST), and displaying a blank menu in other
> architectures is unwarranted.

Arm's Display IP is not tied to the Arm architecture. Anyone can license
and use the IP with any CPU architecture. The fact that so far the IP has
only been present in a handful of devices doesn't mean we should restrict
the drivers.

What is the issue that you're trying to solve here?

Best regards,
Liviu

> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  drivers/gpu/drm/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/Kconfig b/drivers/gpu/drm/arm/Kconfig
> index c901ac00c0c3..0aa6a54567b6 100644
> --- a/drivers/gpu/drm/arm/Kconfig
> +++ b/drivers/gpu/drm/arm/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  menu "ARM devices"
> -	depends on DRM
> +	depends on DRM && (ARM || ARM64 || COMPILE_TEST)
>  
>  config DRM_HDLCD
>  	tristate "ARM HDLCD"
> -- 
> 2.47.2
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

