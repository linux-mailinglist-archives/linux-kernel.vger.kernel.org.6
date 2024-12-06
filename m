Return-Path: <linux-kernel+bounces-434752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2309E6AA0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA892810A3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F341F12FE;
	Fri,  6 Dec 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCZMsQ0I"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEDA1BD030
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478149; cv=none; b=X1QJVX+CuvZ2mliwbej70NYF6XuyhUR2Ycp0b+te5KxoPOI4A3HVyZgmwRjFYsf4SE4cIurCOyVqZiknhfg6E/FgWfPEVx6r37TvhDZjRIsgYdTp48aNlMsoCvI7IC8m+gi8P+IAq+6MT5JwWOEcSEnU36CCbLBv/pkM4IeQkoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478149; c=relaxed/simple;
	bh=fnD8ZUeN3LHdllxutyGeLabN8SdYiuHEWMknGyQWBhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfM8pHR/X77KUGBWwgHzc6dRbIwdGuFk6ZtsTvXBau5XgGxt5PWEV/1Dt4IKVE35RGti7P5u+ZaWwL0wXtgXLH7p7uU5oR9yQGcqnDb9FxXw54W1n9HbHjCAPO5dsx7zaS/QKu+z8pKAf0mPKv8xph8BohGZ6d271RVYayT50p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hCZMsQ0I; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53de92be287so1856485e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733478145; x=1734082945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUIRQbMczpjfL2wu8QV4pEN4I4ysbDGkQQGhfj0T2t4=;
        b=hCZMsQ0IqP2C55RV8sunKoXwVdRE4CMOB4aOleXM5o9OaCTxZXxLFQp8m7eaM4FVHm
         7zqPUpOzOVuFjcqeXzYyDZXeNXBNce+xMVkE/3WK+HYfwhFkZBAoffcjHXyX5YZMXC65
         VtmPnlQLrr+07s4YcNIFTrCK9u4k227jsQADiu1MIY/kxm34B5aaoWflRA0rVZIJZTue
         CwzTQQ5Jk/spUWNiihdyZLi6U4wplDbn4jbx8obJxMZeTI29ZyKH98svzqso7N3/4I2K
         /GUbwZNfS/RHqwbEUq3f/iYawSe05FzPjrani0R287sT2+oUZvIbeK4v7O+zonAqDUOb
         abrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478145; x=1734082945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUIRQbMczpjfL2wu8QV4pEN4I4ysbDGkQQGhfj0T2t4=;
        b=PmMPb44btS1qQ7bNNNW/44Xlx1Y/U7hGE0XDK2ZBrDfUvwc/P4R1XCJMjhyA5RR+46
         6SO5cjHbcNJBaJPWxork8XsGnNw2XDPzE2M6QR0j1B02uDPmzBSyCgClaj8v8XD8YR26
         u/BRg0MKib1etcfRAkYf1zGqvidSYHI/7tuwHfp8hKOm/Z2JPH3pAgtOsvGlVCo7/zWC
         13UCzPftFHanwcqEnfrYWeD8ObNFFKmq6VKBG6YI6MQf/2G8fDQPKyYjeVVLy0l2OSrs
         RwT2IdhOCwWGBKIkklP6emJLgPui2Pf+AM33/mQZLUQC4w5z6JDbHVE+VWDSOak4t2rk
         tqiA==
X-Forwarded-Encrypted: i=1; AJvYcCVNdS5APYQQq9RZJvqRwcIwtKlGrLRtVW3Lc/gVy3470Qxnem8zQeeRYoEvFDFKemEeo+lFseO+x7JmGaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98kDegHOzJmFghpYdUsflmm9jc5yHEHLiHQkGE6N37U2gSwFk
	yjMmOmdBsjuKHAYAhKbQIKZ47PSHFi1SlO8fzpxsOsilg1Xf504b5SZxeFZiSSI=
X-Gm-Gg: ASbGncscMUTgVRJKJ7C227oaqyY/MHOn1n6BZ4nM9yu1maV+PGTsSnug/mIMILX8do/
	7Fo/rJVHTr/R2gMjU3QEHneh8oFo5epBsXvARR3lvfvKIWEogyRuxyaJTYu8eWzzO6GQNzxSz0v
	6NvaVWfENasFXDRXC7E9RI95szzV9l0npf8t35iV4wxdDT0eYUF4zuFmafp+xM9PQsb+aLK7zxy
	eTepYmaAFXo/ZCdxKMYTSnLqL29Y2yTPHUjrZ+124VX9dI/FbHNxsSM+0R1Jmg2qQw16ejtIl9p
	hQ7HPaqEwpbKOgaFi5PgAeoHXLGhnA==
X-Google-Smtp-Source: AGHT+IH4esxK0uLXH9slo3btbx6QQTuIap6lMO09rzPOg/wiHUYCi6471yfGuoXePGv2SFTfDWGePw==
X-Received: by 2002:a05:6512:3092:b0:53d:ecfc:306d with SMTP id 2adb3069b0e04-53e2c2b575cmr685333e87.19.1733478144895;
        Fri, 06 Dec 2024 01:42:24 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e22975264sm450841e87.92.2024.12.06.01.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 01:42:23 -0800 (PST)
Date: Fri, 6 Dec 2024 11:42:21 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 16/45] drm/msm/dp: add support for programming p1
 register block
Message-ID: <ewwpuc3f7vqjeazgeebecc3ygrha4ujq5r7bg5cow56zzb564l@kef4v3bwo3bi>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-16-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-16-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:31:47PM -0800, Abhinav Kumar wrote:
> p1 register block is needed for the second mst stream.
> Add support in the catalog to be able to program this block.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> @@ -1137,6 +1160,12 @@ static int msm_dp_catalog_get_io(struct msm_dp_catalog_private *catalog)
>  			DRM_ERROR("unable to remap p0 region: %pe\n", dss->p0.base);
>  			return PTR_ERR(dss->p0.base);
>  		}
> +
> +		dss->p1.base = msm_dp_ioremap(pdev, 4, &dss->p1.len);
> +		if (IS_ERR(dss->p1.base)) {
> +			DRM_ERROR("unable to remap p1 region: %pe\n", dss->p1.base);
> +			return PTR_ERR(dss->p1.base);
> +		}

Forgot to mention, please also map p1 in the legacy bingdings branch in
this function.

>  	}
>  
>  	return 0;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

