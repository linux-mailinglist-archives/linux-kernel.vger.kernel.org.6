Return-Path: <linux-kernel+bounces-441314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB19ECCAD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1366C282DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D443211A27;
	Wed, 11 Dec 2024 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pw6/B1pi"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73C823FD21
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922003; cv=none; b=sG2YcRX+/6hrfhXzwFIgGUmJhvwCC3k7YnPUagJx4HdZBsS0mkadkB5cmIM/RWzHsxXm8awofeBGhVkHpo0iBfOxqRzer1ctM3bhBBRqwajxlaCBZ1BQn0E7bkxzWkKAqcWjjZG3FDiwLXIsjfmlSlEK9ujC4VH7eQW0psSAHNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922003; c=relaxed/simple;
	bh=9vwQ4DTXUQXSYuiFSuO8qJgz9ksaOqF3dLukB/AVSGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsVIroRdR5ilOeYe1dgr00cXO1u3bwSMo2Ylcu3eREq8m1ZqDp/Gy3c73SMWBcHHW8EwfvOVTf+aF/seMoArXN2W9B51h58D6AbLjfQx1lX32DxHWSaNirU4+WD/aJygxphwiVkgpOS9eEPYcO+QiWPoVNjrnp4Ymv8GJVvFhtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pw6/B1pi; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8746C83D;
	Wed, 11 Dec 2024 13:59:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1733921959;
	bh=9vwQ4DTXUQXSYuiFSuO8qJgz9ksaOqF3dLukB/AVSGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pw6/B1pigVl9UzRrAM00Ngki8vn4ZwCcifeQhyI1zN7yc6c+epaLp/4sOFBVdQ5/p
	 i00g9RUf2XLbBvUtQHWwHflqmAnkq1REab8IgOPL64krLJHd86czRbqNl2JyHrockm
	 uToREKoBgRGMaEsnQ0Zt7m5W5XrL1D7AW+LICakY=
Date: Wed, 11 Dec 2024 14:59:36 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Karol Przybylski <karprzy7@gmail.com>
Cc: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, michal.simek@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: zynqmp_dp: Fix integer overflow in
 zynqmp_dp_rate_get()
Message-ID: <20241211125936.GA23711@pendragon.ideasonboard.com>
References: <20241211122026.797511-1-karprzy7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211122026.797511-1-karprzy7@gmail.com>

Hi Karol,

Thank you for the patch.

On Wed, Dec 11, 2024 at 01:20:26PM +0100, Karol Przybylski wrote:
> This patch fixes a potential integer overflow in the zynqmp_dp_rate_get() function.
> 
> The issue comes up when the expression drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000 is evaluated using 32-bit arithmetic.

Please wrap your commit message text to 82 columns.

> 
> Now the constant is casted to compatible u64 type.
> 
> Resolves CID 1636340 and CID 1635811
> 

Does this need a Fixes: tag ? How about 'Cc: stable@vger.kernel.org' to
get it backported to stable kernels ?

> Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
> ---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 25c5dc61e..55e92344b 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -2190,7 +2190,7 @@ static int zynqmp_dp_rate_get(void *data, u64 *val)
>  	struct zynqmp_dp *dp = data;
>  
>  	mutex_lock(&dp->lock);
> -	*val = drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000;
> +	*val = drm_dp_bw_code_to_link_rate(dp->test.bw_code) * (u64)10000;

You can also make the integer a 64-bit constant with

	*val = drm_dp_bw_code_to_link_rate(dp->test.bw_code) * 10000ULL;

>  	mutex_unlock(&dp->lock);
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart

