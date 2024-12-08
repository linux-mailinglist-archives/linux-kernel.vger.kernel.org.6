Return-Path: <linux-kernel+bounces-436278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B959E83DA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 07:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCF31659FA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 06:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F385A4D5;
	Sun,  8 Dec 2024 06:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNQsg0+X"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07ED46B8
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 06:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733638970; cv=none; b=Y66L8yUvJD/v2N7Xwd02ZTXaLdVwKF5qSJpObNVFLxh1moVh113gfn9tw4S7cqKd0QNLjWhDO/VOZTGwg5ia5mKBfc2lyiZ05DI/pSp+3fPU+fHtLbEpUwjfmLpoOvrmXJewMaJsv5N2YJKUxM83HeSXxsekZjuWJfG+G5wpQ3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733638970; c=relaxed/simple;
	bh=AS3azZ+PfLiRvJ+8Za68SmM9j3QMKamcxS6Oj0hfhCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXP5du61/eVReMhsTg/mOFNCI4S/JoAVEYu1fFzluOeCz/C+5IeaeXcsDkAyVAUY55k1EZKq1TJYiAQrjCK9g2o3myCe0sCQrUFJKnsJitW3BIpkk5f0jnwANggPG47kuh49tZX5JRrB/Rj8NZo2EJCJH8kWGcPHQd9VbHYLZEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vNQsg0+X; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53dd668c5easo3540738e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 22:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733638966; x=1734243766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=38gctL7UTrHCs9qA1LF95XHQwmYDkv868rO2ODhNpiw=;
        b=vNQsg0+XbJA/50xOX5QhhNHOkcpjGDe0dPR0n1Og2Y7qXki+XSWHcYhrYhS1cOXIKf
         uYnGlrIeWH8Ra4E6BovXVAhuO9DmU39OjELj+bdhMWVhgB6bSGpxNbKXW6t3dn/tcdAv
         RqXPwEKm/agWQY70/miDXS0z1NjHoRAzdUq61PwwYuQEsOlyXEcaW4r586LjHnuluYZQ
         Hq+dOXoVNs06I2MNBgvQx7IiGh/wY6hYtb/eVMABespHGLpFd3TTAFV6dLOUDUgMe3Bq
         VAq4aBcenP8BZ8zVDTW1DXgUOJ2x+lDw/ZVV338J2vw9YPryyXB7Gyj9l5PwECJ14sEW
         FBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733638966; x=1734243766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38gctL7UTrHCs9qA1LF95XHQwmYDkv868rO2ODhNpiw=;
        b=HJsaNtGcQ9Zqz5JCwlyYTC9PK+ER8jfJGBaUPPSQ2l+NX1eofTMG/n2SZLg7P6+kEW
         V4UuLoHU/+fhfoR0YUvK3Juaa00UHMMpMfEoEx6CuePesbjgHKk5UBlBZSml4z7YDx9B
         sWB1c9Gb+Ue6xyhsLmusVG1rnLPkUuyMypLl1yFJ3VpNARlMfhPsJYPZjAFlFEFLrYqt
         yxUfoS4NZUFxHt0a63ibHtqe5Udt4NsJk+nwopNR7eyX+sTQ2BIyH//oMRL9p3CvbcLm
         flvUL9MLABQZyhzHa76njVIme75KMzki2kzGPNS69OxJEj4u+a2GTtbcN/Njnq0wZNAn
         IYlA==
X-Forwarded-Encrypted: i=1; AJvYcCVfeGuvLVL7Z9ZhU9SS9e4o1Gs9Vz7ZGOaqfyH+5JvKDMF7wMZiWeer37xbrQUIEIV38pDLEyv7kTHeVPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7prdJWMY4swZH8U++6/BTS4QYE57psC85wEyrv0OcQxohDWuJ
	gtLWYTWo76UclRfW3XGkqUCkV8VmXeEoK9v+RcONBtMJxeOOthWkxqROhnMKWQQ=
X-Gm-Gg: ASbGncu7WTqQ/Ty3y68sUmDn/yo4y1snHpn/2fTuaAMJ92h1dY+RLbjg+ZAJWYkrZmx
	Bu7TJLVby7VuCRiGdiL8TpB5sagob8jDQnt5uBdqQMYMVxOCfAVomXG4hykflyJ4MIPo8WpyD3W
	Yq2pYgPss3+LmeUQQmbMQ+hYlq0iqhm41aiQOZBhF1qERgjCl0BweSClbfMb9yZkXrVgw6WXf+4
	i1jqbPCA+GEoHjeN1apsppaZDDsfHc4iVGkcjHqdKT4X6ujeyb4Q3ABoXoqR6wamPJ5M4i7n7mH
	FsGycHcK98kR2OdXnEJAFGtL0cDejQ==
X-Google-Smtp-Source: AGHT+IH0qp1aPQA+2OpPaXQ/vPvKw2/kQ5aoewjrbzmt3QID8qu4PyXFLKKH22VCjIXIHCP65iqmvA==
X-Received: by 2002:a05:6512:3dac:b0:540:1bc3:1061 with SMTP id 2adb3069b0e04-5401bc31213mr349243e87.11.1733638965870;
        Sat, 07 Dec 2024 22:22:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401c2c700fsm99554e87.86.2024.12.07.22.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 22:22:45 -0800 (PST)
Date: Sun, 8 Dec 2024 08:22:42 +0200
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
Message-ID: <ku6ytypptjtydcgscdvwsi62cgxokxn6svwwzs2ce3otnnlrrl@uvr6st3365kv>
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

> @@ -145,6 +148,26 @@ static inline u32 msm_dp_read_p0(struct msm_dp_catalog_private *catalog,
>  	return readl_relaxed(catalog->io.p0.base + offset);
>  }
>  
> +static inline void msm_dp_write_p1(struct msm_dp_catalog_private *catalog,
> +				   u32 offset, u32 data)
> +{
> +	/*
> +	 * To make sure interface reg writes happens before any other operation,
> +	 * this function uses writel() instread of writel_relaxed()
> +	 */
> +	writel(data, catalog->io.p1.base + offset);
> +}
> +
> +static inline u32 msm_dp_read_p1(struct msm_dp_catalog_private *catalog,
> +				 u32 offset)
> +{
> +	/*
> +	 * To make sure interface reg writes happens before any other operation,
> +	 * this function uses writel() instread of writel_relaxed()
> +	 */
> +	return readl_relaxed(catalog->io.p1.base + offset);
> +}

After looking at the actual code, please implement
msm_dp_read_pn(stream_id)  / msm_dp_write_pn(stream_id)

> +
>  static inline u32 msm_dp_read_link(struct msm_dp_catalog_private *catalog, u32 offset)
>  {
>  	return readl_relaxed(catalog->io.link.base + offset);

-- 
With best wishes
Dmitry

