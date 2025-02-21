Return-Path: <linux-kernel+bounces-525215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC874A3EC89
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FED27A5850
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B321FC0F0;
	Fri, 21 Feb 2025 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IIJlhoui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE433EA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117980; cv=none; b=maWaTFgtpQE7MTvaaOxZtZpaWdzJzFhxJtegEgJHKLVgMlgTfBmWQlGMQW8q0g/KPqYIJZAgwBnzdSyDArk1FTws2zclVSx3NjSa/lOhFQJdqIGM5h79e77CheMaz9+glt0SCWn7NNAYH7kwkko4DeY5Mva684/t/bt9EFvJrfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117980; c=relaxed/simple;
	bh=I/sDH4Il9gjLysSBuWK3+rNtjzTAmWWvwJtGzXyvw94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpJKbGfoeSxj2WdMGm7ufGJptjXMaft8GQbFCPh3Gsxfb0wRJZ65yhR0723AQUV1VP+mB3frf2vRLMv/YrVpBmjNYtzn+AydryG0EDG80auUbTcqn9yx2CF+ZW9RazJAZzX0HpUKwLOGbwU07o67XbohLIee7dL455TZhmjk30o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IIJlhoui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEE0C4CEE2;
	Fri, 21 Feb 2025 06:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740117979;
	bh=I/sDH4Il9gjLysSBuWK3+rNtjzTAmWWvwJtGzXyvw94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIJlhouibrLgu4lt+5/pJHggDP+e58ons6ZzIM1V9mX2tWUr+lDPK2tof2/QQ8jxU
	 6+2e3ktAVOjGr6mhUc/dA1UE+BNql5w4lN8q5QJGS990UVhUCb98AoMi4Vgoh4hyuw
	 4KMTdE/mPcNYo1O7FeLboW/IAWYDDP9eHnYBciK4=
Date: Fri, 21 Feb 2025 07:05:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Raag Jadav <raag.jadav@intel.com>
Cc: arnd@arndb.de, andriy.shevchenko@linux.intel.com, airlied@gmail.com,
	simona@ffwll.ch, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/draw: include bug.h
Message-ID: <2025022135-aviation-evident-2518@gregkh>
References: <20250221050804.2764553-1-raag.jadav@intel.com>
 <20250221050804.2764553-3-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221050804.2764553-3-raag.jadav@intel.com>

On Fri, Feb 21, 2025 at 10:38:04AM +0530, Raag Jadav wrote:
> Directly include bug.h for WARN() helpers instead of relying on
> intermediate headers.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/gpu/drm/drm_draw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
> index cb2ad12bce57..0a0e1eebf481 100644
> --- a/drivers/gpu/drm/drm_draw.c
> +++ b/drivers/gpu/drm/drm_draw.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/bits.h>
> +#include <linux/bug.h>
>  #include <linux/iosys-map.h>
>  #include <linux/types.h>
>  
> -- 
> 2.34.1
> 

Does patch 1 break this file without this patch so this series is not in
order?

I'll be glad to take patch 1 in my tree, but I don't want to break
anything else.

thanks,

greg k-h

