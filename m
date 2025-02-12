Return-Path: <linux-kernel+bounces-510878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13188A32325
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A143A3671
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73493207E1B;
	Wed, 12 Feb 2025 10:03:53 +0000 (UTC)
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CC82063C7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354633; cv=none; b=bmeIaa/chwqtZQ8SNM5EwyxIhXoqzCnZRKzJ7ZIMFwAxk2cOPhMdt1rO8tOfM6dUulZnL93InXUIM/0di9SPVaQVmXMUvHqwIxiGmHpXOQID3BKe6kW8DDdOoUuvwed12DKWqw5O2NK+FD/aiKJhtdFvXSTwhnkHzFDkHyWer/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354633; c=relaxed/simple;
	bh=wuj0iG1Z/7DDo1uuo7RxJ1HwxHsqkrQ7nsXo/GxX9OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiEdq9xG2V/qq0kgekt94njrzqOoivQjER/ZbvLLgyu9uaZY1J3OhAj+fD3U55Vsn6HjVUKxYdC+45Ac2SSLx+NdArrwfuYYzKbInfHUN41H3uYN4ONTBoLstisv0urw4iZJ04IZQa1XWPtRArR/IyRDQ9iz8J1Eq+66LwFZ5Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B3D2F3F60B;
	Wed, 12 Feb 2025 11:03:40 +0100 (CET)
Date: Wed, 12 Feb 2025 11:03:39 +0100
From: Marijn Suijten <marijn.suijten@somainline.org>
To: "James A. MacInnes" <james.a.macinnes@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	robdclark@gmail.com, quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org, 
	sean@poorly.run, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH 1/2] drm/msm/dp: Disable wide bus support for SDM845
Message-ID: <vl6cfjpckgndu5nacw3o5wvdfwaijactokby6q2lywcdccicgz@k27my3352m2k>
References: <20250212034225.2565069-1-james.a.macinnes@gmail.com>
 <20250212034225.2565069-2-james.a.macinnes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212034225.2565069-2-james.a.macinnes@gmail.com>

On 2025-02-11 19:42:24, James A. MacInnes wrote:
> SDM845 DPU hardware is rev 4.0.0 per hardware document.

Just checking: version 4.0.0 is not named in the code that you're changing: are
you mentioning this because the patch you're fixing here [1] says that widebus
is "recommended" on 5.x.x which includes sc7180, yet didn't account for that
sc7180_dp_descs also being used in the SDM845 compatible which is 4.0.0?  That
is something worth mentioning in the patch description.

[1]: https://lore.kernel.org/linux-arm-msm/20240730195012.2595980-1-quic_abhinavk@quicinc.com/

> 
> Incorrect setting caused inop displayport.

Inop doesn't seem to be a common abbreviation, there's enough space to spell
out "inoperative".  And spend some more words on _why_ this is an "incorrect
setting" in the first place  (based on the suggestion above)?

I am trying to remember the details from the original widebus series: we
discussed that the INTF_CFG2_DATABUS_WIDEN flag was available starting with DPU
4.0.0 (IIRC, cannot find the source), yet the DSI host only supports it from
6G v2.5 onwards (SC7280 and up?) [2].  Seems a similar limitation applies to
DP hosts.

[2]: https://lore.kernel.org/linux-arm-msm/20230822-add-widebus-support-v4-4-9dc86083d6ea@quicinc.com/

> Corrected by separating SDM845 to own descriptor.

its own*

> 
> Fixes: c7c412202623 ("drm/msm/dp: enable widebus on all relevant chipsets")
> 

No need for empty lines between trailing tags.

> Signed-off-by: James A. MacInnes <james.a.macinnes@gmail.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index aff51bb973eb..2cbdbf85a85c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -126,6 +126,11 @@ static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
>  	{}
>  };
>  
> +static const struct msm_dp_desc msm_dp_desc_sdm845[] = {
> +	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = false },

We can probably drop the assignment, it'll be false/0 by default.

- Marijn

> +	{}
> +};
> +
>  static const struct msm_dp_desc msm_dp_desc_sc7180[] = {
>  	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
>  	{}
> @@ -178,7 +183,7 @@ static const struct of_device_id msm_dp_dt_match[] = {
>  	{ .compatible = "qcom,sc8180x-edp", .data = &msm_dp_desc_sc8180x },
>  	{ .compatible = "qcom,sc8280xp-dp", .data = &msm_dp_desc_sc8280xp },
>  	{ .compatible = "qcom,sc8280xp-edp", .data = &msm_dp_desc_sc8280xp },
> -	{ .compatible = "qcom,sdm845-dp", .data = &msm_dp_desc_sc7180 },
> +	{ .compatible = "qcom,sdm845-dp", .data = &msm_dp_desc_sdm845 },
>  	{ .compatible = "qcom,sm8350-dp", .data = &msm_dp_desc_sc7180 },
>  	{ .compatible = "qcom,sm8650-dp", .data = &msm_dp_desc_sm8650 },
>  	{ .compatible = "qcom,x1e80100-dp", .data = &msm_dp_desc_x1e80100 },
> -- 
> 2.43.0
> 

