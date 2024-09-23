Return-Path: <linux-kernel+bounces-335415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD7497E544
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 06:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874C91F215BB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 04:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7523D10F9;
	Mon, 23 Sep 2024 04:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LstNfCVb"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F161854
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 04:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727065288; cv=none; b=HFhBAZA+lOdS+H3bDyMsxUrZHG67ZOPRj6GvJ/jW67X7uhd97cWRBRywtrUHaKw0qPRm4bATe5Uct1+MeBvCfG6jmh6c/xEA7os4Fn/xt4ausm4TQe+qY5dUAxciJuGXvuO9ox6/uSnbbDxdVD9RuPnaMrGIg4AoA0wwFblBrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727065288; c=relaxed/simple;
	bh=L+Glh8hWjbOoHsZKdJ3/1RNtLIEeyClz1ZCDMzjs6ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiYfae6bRQKNVTkT1MhRcOTODZ7PLvBYpISN1qNjub82J+bsEyVGJrY0wIMHtXwzIDOnQsukwrI+PP5/9nsYXGEAKIKZnrTZTG37D8LHVyPbx/j3vjjk1dIkdQo12r+v5R0fgmcYsGNV3tIRnTsKrK5lZtXXI+18ajTVRxFPTHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LstNfCVb; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53568ffc525so4403436e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 21:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727065285; x=1727670085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UX30i2zA4yW1Ql73C0KW0/A+BlKe7ZYSoQVaMBiTug=;
        b=LstNfCVbMWdPhNDi/USfJ8lxNkFB+sld8PhrPImYEpfwjYIuY8cjWF1JctDj5UV2gB
         Tgv4zOovMyQPtJfm9q+6Q0YlD8gdMqvaEMS+UfWQK8KNkxeeezGrO+y6dAVr6mUxoJvt
         9VAMEDOBHMakWbRF6ZpaFJQKRHy3kn28sjHip7XOb0lTlYRcGIp84vgWkHAncCDFP4UQ
         JzRT1ZfPMQDg1ZrXk0V3XPj80NRNhNxI2fONsr7WSqUJe2AZ5RzToWQMK4KwwROGGshq
         REL18TTORBEiDEKGoA371vw3MBS6HFqiSpyjup8s0R6KXfnWBSRby2W0QK5JZwv4aksY
         LHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727065285; x=1727670085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UX30i2zA4yW1Ql73C0KW0/A+BlKe7ZYSoQVaMBiTug=;
        b=SIvB0QxO+4z/E/g7mYasfrrCOWAVoUXSEwH7/9TIhCWDC4Qyhy06kA6Lp4dNSDLaGn
         bPHQZU2ZsI9Ufxd8l7Ky3Heaf6zEivMToFx4X59nOfhALv8JSQ8oOSp1d1fExmggSGqV
         7lh0AuuZL5p3kfMAjPMOsAOyeoM9QgOL6R5+vuH3wng3WifBw6TI4aDi9ZA0eUio7WEV
         q01Z9SflEHe4s+uw8FkqHKVU1bZNXt0capKPtkeXCfLP6qdNPcE9M0alKU7OhSD0c+6A
         QI6H4dIsMSw+YRogAc3sMqKdo9LQNQGvKkHVQwhgownHc0zgjKvTGpCkhp5kTSinWYko
         9IkA==
X-Forwarded-Encrypted: i=1; AJvYcCWaqpiCIw+HdLr+US2lpyNIekt12ZoZp43o+UTu0g8PUHXZJ0TCRqPm6vnG8GCCkh0k6l9lB2uG3hF1d4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAmW3Hrlh57XGM2j/yhwwEUR0s+AM/LhJmqzZn8ddQoAUsaoE0
	WHmSu69ueLE3opzvsYtQn/c1EGvCaIZQuVETanaauACB0qTx95IFhsrAtwxKnF3b7iEnZQESh3B
	381o=
X-Google-Smtp-Source: AGHT+IFmiYTH3GZizsvWgDordIgmbGnH+InAibsj8y6AC510eeUrKn0wOi5xlapFZC+j7h0tvVCVfQ==
X-Received: by 2002:a05:6512:ac9:b0:536:53b2:1d0d with SMTP id 2adb3069b0e04-536ac2d03b0mr5038212e87.9.1727065284533;
        Sun, 22 Sep 2024 21:21:24 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870a4647sm3137008e87.194.2024.09.22.21.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 21:21:22 -0700 (PDT)
Date: Mon, 23 Sep 2024 07:21:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Liao Chen <liaochen4@huawei.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, linus.walleij@linaro.org, 
	thierry.reding@gmail.com, mperttunen@nvidia.com, jonathanh@nvidia.com
Subject: Re: [PATCH -next 2/3] drm/tegra: Enable module autoloading
Message-ID: <3ttycjomydslmaqtwnhjehrj7pa7m2i2daqd46kwd2tsxynr2t@jo24br66tz7b>
References: <20240902113320.903147-1-liaochen4@huawei.com>
 <20240902113320.903147-3-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902113320.903147-3-liaochen4@huawei.com>

On Mon, Sep 02, 2024 at 11:33:19AM GMT, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
> on the alias from of_device_id table.
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> ---
>  drivers/gpu/drm/tegra/drm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
> index 03d1c76aec2d..1a12f2eaad86 100644
> --- a/drivers/gpu/drm/tegra/drm.c
> +++ b/drivers/gpu/drm/tegra/drm.c
> @@ -1390,6 +1390,7 @@ static const struct of_device_id host1x_drm_subdevs[] = {
>  	{ .compatible = "nvidia,tegra234-nvdec", },
>  	{ /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, host1x_drm_subdevs);

I don't think it is correct. See how subdevs are handled in
host1x_device_parse_dt(). I'll pick up two other patches though.

>  
>  static struct host1x_driver host1x_drm_driver = {
>  	.driver = {
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

