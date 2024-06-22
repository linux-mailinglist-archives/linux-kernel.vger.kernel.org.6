Return-Path: <linux-kernel+bounces-225668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1623291337D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516381C211CA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF95914D6F1;
	Sat, 22 Jun 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pEPv2xTn"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE3128F4
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719056790; cv=none; b=Fa6vLkXUUyzKzWnp0sOY5yQxffJh4Wk3riEp/pUAHHzZJz0PUKaJP4gn8TzN4D845grF4/VDbwn0UAyj5hm52IHWjvD9z8KzWFynHOTZgduuT8hiaeYS8raOzLIF07M3DrdgKRi+v/cUVG3H1tKHzTlNKHJ4s9zqvNchiyliCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719056790; c=relaxed/simple;
	bh=gx4hwvTb8LTWlFqgqnsjT0ORete6hOvb6C5SPh3Q1fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip8rNf6EGgCiIFzYHE5bn2vH/WVFi4qq7/R1dBpU5XYvesbJODSfr/uqJmNiN3wa+mMjHk6aWszGXbd8uM8Kbl1W5Z755Ob/BZr91NvVGX7lJdMLRu3QwQ7czt0soQPyRu5FClu8lkp9scRhsrE4B27fuq8t1VcE4jUJ8B3T/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pEPv2xTn; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cdf4bc083so419068e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 04:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719056787; x=1719661587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5GoKr5LpL8zxiF4e6rxCxrhmJRtxBtTG1Kl19ZojU+k=;
        b=pEPv2xTnecTjSCRL079862O9Qae9fy9aaplvsgJe6jYHThmswAty50AL+TzWB7UT0v
         H3f85C4+KkhgCxHlnKV0/RbtOkIBWTpSsaIdhvTdlchs0XEH7kPMCAeta+U9MJ+oA8ZP
         OQlVghMbJr/okPER0OTWskO4lauyR8i9fsCMd8ARXDQTBxRIwA5k40U70Bz5bOZ8nLvO
         ZiLrH2JV2XrYGEDpueihGoAETyJEfUX/mLv5jI7tgsXoyzlNjjgT6X9DQHWX9wytRGCa
         SM4pQUYOJdTfi8lEJcz9hfw3dG7SKBrommpnp3UnDvECF+5fKAxIoOrWxvildbORbq2d
         JrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719056787; x=1719661587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GoKr5LpL8zxiF4e6rxCxrhmJRtxBtTG1Kl19ZojU+k=;
        b=OV6zdod61Q+6lHDk2mfso9VO7ebU/zgh5h3inmgqGDdd+uXAlsgWHgdZtG3iotme9i
         MChiL1XblpO+W7vb3YAUcRir7+cld+euvSB8sRYWHrGuMg+Zj7Qlj2MDFhCkn/aEIVzB
         8tmxxydt/vVcW+iUpB4326ze3KYbhiVUInPP19Zxwq4evUyfTyYY0KFR0Jla5ZwaUzg3
         dCNuQehU63h7QDYyiRzx2PXBBe8UhugZnIiZlgIQ+dotvJf4p5I2IeIBgZgU3urTOMFr
         u9HERm4lXxshbEucdsMLY5YoyeunhmHtVool+7MnA3GiWPkrcwk9o+s/mBqBBh0Jis/7
         UkOA==
X-Forwarded-Encrypted: i=1; AJvYcCXs3wkpLLN7jPb9fWLZjJ+KlH/kBw+MXFAFXE9nmuv81rYSNvuBSExGiAd0a0cimT3+o53jsFEI/fIleVYwfpQXrOysteJk88RuasG0
X-Gm-Message-State: AOJu0YzuaMZtmzDrA8z6TCZ2XdtEE0QJOrq+KHeqfy7yIT3ZtSlYXaQ6
	K5RLjYOk87KF2tTqc8AICrlpujFKzbq4tjOXcNOOW68xw3RgV9PCO6wSWX6xZmw=
X-Google-Smtp-Source: AGHT+IH3hl6/PlsSyEWBouIFziPH6NwxAF7HPfEv0Hgg9JU/r6Jt/4V5LhdGmq3eAU8V3lfRrusSAw==
X-Received: by 2002:a19:8c17:0:b0:52c:dd7d:3fd4 with SMTP id 2adb3069b0e04-52ce061afadmr190528e87.25.1719056786599;
        Sat, 22 Jun 2024 04:46:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ce05e8512sm39826e87.254.2024.06.22.04.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 04:46:26 -0700 (PDT)
Date: Sat, 22 Jun 2024 14:46:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	quic_jesszhan@quicinc.com, dan.carpenter@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/msm/dpu: drop validity checks for
 clear_pending_flush() ctl op
Message-ID: <3bbazi5xqwe3dvxyb42ghlzanwba5gvhhltnaqgl3tebzbzaxc@cqezq3xx2pzj>
References: <20240620201731.3694593-1-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620201731.3694593-1-quic_abhinavk@quicinc.com>

On Thu, Jun 20, 2024 at 01:17:30PM GMT, Abhinav Kumar wrote:
> clear_pending_flush() ctl op is always assigned irrespective of the DPU
> hardware revision. Hence there is no needed to check whether the op has
> been assigned before calling it.
> 
> Drop the checks across the driver for clear_pending_flush() and also
> update its documentation that it is always expected to be assigned.
> 
> changes in v2:
> 	- instead of adding more validity checks just drop the one for clear_pending_flush
> 	- update the documentation for clear_pending_flush() ctl op
> 	- update the commit text reflecting these changes
> 
> changes in v3:
> 	- simplify the documentation of clear_pending_flush
> 
> Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for writeback")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/464fbd84-0d1c-43c3-a40b-31656ac06456@moroto.mountain/T/
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c         | 3 +--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 3 +--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h          | 3 ++-
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

