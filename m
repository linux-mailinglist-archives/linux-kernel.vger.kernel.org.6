Return-Path: <linux-kernel+bounces-550670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9846FA562AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD653A6AFB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591591DE3C3;
	Fri,  7 Mar 2025 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwVZiggL"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B31B86EF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336693; cv=none; b=Ok8gimCsu5OSdVhuknFEEEsOViOCAmN1NmD+v/InwLm5+LD/IM01Ko0RzX7q/VDsuNysle3/R/1DQG7fkJDGgQ/sxDeOnSbTRQSsMzfxr/+rmj/Diuc8BK8YHKDvlRC1AAkRXPXC+mPzQ0AmMGJ8dfre5mD5KIzL20yyOhwN7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336693; c=relaxed/simple;
	bh=GYxyFRQKZQBt9XGGtRQ5AC7grdC0Qr21Eraa7nH9i/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUUuR3Zp99faOEsuMZ9fYksPbwV/rl8fVq+bxONMPzBWVNzdi7kL0eAp+rTHkXUjhBxgipFeNlQB/iFJ0ADGL1MfjN8PdC/e83s3t7LlsUFzANLh/ugVdApSNquUrdJrgrhsoXJajRKPGWNX1GvX0WezR6AWUTUGVuKJ97zZTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EwVZiggL; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-547bcef2f96so1833320e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741336689; x=1741941489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+N6yDlV0NFncs+ZNUB+wRwddFt938JHfbLuCUG/BitY=;
        b=EwVZiggLREqY/iuY3dJVLoEV4iTF4jVxPQoY20NpVajKhCZ451OmORDbcT+UeFFiXA
         Gw0mw5J4ZQGQO/8gZ85bf/5okULC9DXsE5rgeuXHVLOMS5FsHpWo/aQPEO8OurBwXU9v
         dCOcIbFinqQ3fJAqE/CQmtSjmhiw1bG7FjZHhrfsKQm7O2Bc1y/CQndO/EDl6eEX+9FD
         pINfW98VojfXWNVw5wBjZtIqSe2T9OhnbKTC+0adzrszaEq704ysvQnguLMmAjDJpPun
         AsFPd/tdsJRT5zqEKyVSqjv0QuBLSPih4IxFu7pp+tnK/efTzGJUF0WWGc5VcJsCQHkm
         mhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741336689; x=1741941489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+N6yDlV0NFncs+ZNUB+wRwddFt938JHfbLuCUG/BitY=;
        b=G17d9A578c2IHvq6ru+wibcSROFJ0Je2US8IKxYSToiiGE8LkI2E53wb/can7khIAz
         /9des0zYcdTJbm3wVz0BxbdCUvuH/kxM7DdGAweO4pJrZL3c40o3u9OOOAuqGTZWZ2c8
         guuI1zGFrcXD0Tc4B2l8tnFJ6pQrvYZlp8CliboIRc3Uz9jVeTVQflRUrtptm1a+1/hd
         0SQJgpIP+tVggZ5u3ztKADc3dzFvhmRvG7niuH0mooa0vNUK6dQlixyjwDyry93qzfix
         tvLsFu4hmJne4PZc7xxJOTdc5vDZ7wl/GnvfX4IWu47LZXAcAWgTFLn3EOx0DbV4EPqM
         KqeA==
X-Forwarded-Encrypted: i=1; AJvYcCUxvtOGGqEWxDeH9aUcRZFZHFymONUM2yEP0ROCufiJfz+UvjQgzs8T+/zb8tw0vPI2qoJZcSvLaVKmi7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmxaQIruW+7NvDE8RK+F37UtL1XoPfSVI1VEyQfqgweolen2hE
	r4CtanBl893Z/ZMG5FDwK2+Hyqo838WAPkFYwla9QyXSxcNrowK1/akwZOc294k=
X-Gm-Gg: ASbGncseerudDHjASqvJzqNvPLmSjy81+bPFeV7sgGBi/xJ75WCCvJIt/UMyXkA5oR6
	upJuT/sLIc4QqcCPCzkTI0SuNb9kvY9xyyeYIsUhVVcStLmr8fO51JCw9Qm3hUzsMDAWmzdFLZu
	Ud1DIgZl+5DhbROzd7NDCvLWXXN5N/2BJO2DftbmLvjf79qOx4ipqeaMdfBEblDnGvFV8XYJ8Xz
	h6yKrsDAOngJMMldK57teRI14VD9+qHR2jGZBjwUISEYMDQCUaxonXe75HmDRQgEKrQ5RlG2iLs
	vSEmpC/q+7DbKSJoHyDRHlYzthqsFOUS64IqkisFbIeCiaWZZDL+1g44IR81C71o+9Qj5dLer3q
	QskWBKOW73z9qXrrlRskdivEz
X-Google-Smtp-Source: AGHT+IGfVv7MlpX59E0f3tOSQukf2FN0b9H49VnDyqRemuSX3X6T5WqxxVCQMq9nBH5XyTBY2wHgBg==
X-Received: by 2002:a05:6512:2313:b0:549:74a7:12da with SMTP id 2adb3069b0e04-549910b765bmr856831e87.51.1741336689064;
        Fri, 07 Mar 2025 00:38:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae46042sm417789e87.30.2025.03.07.00.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:38:08 -0800 (PST)
Date: Fri, 7 Mar 2025 10:38:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] media: platform: qcom/iris: add sm8650 support
Message-ID: <noowenzvhkcmx7cmwbnqqepuabown6taznmuuomw6lp7mo6tam@zihcgcjsmt73>
References: <20250305-topic-sm8x50-iris-v10-v2-0-bd65a3fc099e@linaro.org>
 <20250305-topic-sm8x50-iris-v10-v2-7-bd65a3fc099e@linaro.org>
 <feea4c41-d3cf-4dc7-d197-6d91313d90ff@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feea4c41-d3cf-4dc7-d197-6d91313d90ff@quicinc.com>

On Thu, Mar 06, 2025 at 06:46:06PM +0530, Dikshita Agarwal wrote:
> 
> 
> On 3/6/2025 12:35 AM, Neil Armstrong wrote:
> > Add support for the SM8650 platform by re-using the SM8550
> > definitions and using the vpu33 ops.
> > 
> > The SM8650/vpu33 requires more reset lines, but the H.284
> > decoder capabilities are identical.
> > 
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >  .../platform/qcom/iris/iris_platform_common.h      |  1 +
> >  .../platform/qcom/iris/iris_platform_sm8550.c      | 64 ++++++++++++++++++++++
> >  drivers/media/platform/qcom/iris/iris_probe.c      |  4 ++
> >  3 files changed, 69 insertions(+)
> > 
> > diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
> > index fdd40fd80178c4c66b37e392d07a0a62f492f108..6bc3a7975b04d612f6c89206eae95dac678695fc 100644
> > --- a/drivers/media/platform/qcom/iris/iris_platform_common.h
> > +++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
> > @@ -35,6 +35,7 @@ enum pipe_type {
> >  
> >  extern struct iris_platform_data sm8250_data;
> >  extern struct iris_platform_data sm8550_data;
> > +extern struct iris_platform_data sm8650_data;
> >  
> >  enum platform_clk_type {
> >  	IRIS_AXI_CLK,
> > diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8550.c b/drivers/media/platform/qcom/iris/iris_platform_sm8550.c
> > index 35d278996c430f2856d0fe59586930061a271c3e..d0f8fa960d53367023e41bc5807ba3f8beae2efc 100644
> > --- a/drivers/media/platform/qcom/iris/iris_platform_sm8550.c
> > +++ b/drivers/media/platform/qcom/iris/iris_platform_sm8550.c
> > @@ -144,6 +144,10 @@ static const struct icc_info sm8550_icc_table[] = {
> >  
> >  static const char * const sm8550_clk_reset_table[] = { "bus" };
> >  
> > +static const char * const sm8650_clk_reset_table[] = { "bus", "core" };
> > +
> > +static const char * const sm8650_controller_reset_table[] = { "xo" };
> > +
> >  static const struct bw_info sm8550_bw_table_dec[] = {
> >  	{ ((4096 * 2160) / 256) * 60, 1608000 },
> >  	{ ((4096 * 2160) / 256) * 30,  826000 },
> > @@ -264,3 +268,63 @@ struct iris_platform_data sm8550_data = {
> >  	.dec_op_int_buf_tbl = sm8550_dec_op_int_buf_tbl,
> >  	.dec_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_dec_op_int_buf_tbl),
> >  };
> > +
> > +/*
> > + * Shares most of SM8550 data except:
> > + * - vpu_ops to iris_vpu33_ops
> > + * - clk_rst_tbl to sm8650_clk_reset_table
> > + * - controller_rst_tbl to sm8650_controller_reset_table
> > + * - fwname to "qcom/vpu/vpu33_p4.mbn"
> > + */
> > +struct iris_platform_data sm8650_data = {
[...]
> > +
> > +	.dec_ip_int_buf_tbl = sm8550_dec_ip_int_buf_tbl,
> > +	.dec_ip_int_buf_tbl_size = ARRAY_SIZE(sm8550_dec_ip_int_buf_tbl),
> > +	.dec_op_int_buf_tbl = sm8550_dec_op_int_buf_tbl,
> > +	.dec_op_int_buf_tbl_size = ARRAY_SIZE(sm8550_dec_op_int_buf_tbl),
> > +};
> This approach looks good to me, reusing the platform data like this keeps
> the code cleaner and avoids duplication. I think this is a good way to
> handle the differences while sharing the common parts.

Just to share some thoughts. We had this kind of data-sharing in the DPU
driver. It looked good in the beginning, but at some point we found
ourselves stuck with the platform data being named semi-randomly
(following the first-added SoC instead of the first-in-family).

Modifying "catalog" data became troublesome as it was no longer clear,
which chipsets are going to be affected by the change. So, after some
thought we ended up duplicating data all over the catalog files for the
sake of them being easy to modify. There are some ideas on how to
simplify that, but for now we have (almost) full data set for each SoC.

For example, imagine somebody adding sm8450 support and sm8450 reusing
sm8550 data. It would be a bit troublesome to remember that changing
sm8550 data would affect sm8450. And maybe some of the SAR, SA or
QCM/QCS platforms. I think you see the point.

If you are to explore the data sharing solution, I'd suggest exploring
an idea similar to the DPU catalog: start naming each of the platform
files with some kind of generation-like ID. In case of DPU it was easy
as each DPU instance has unique version. For the Iris devices it might
be as easy as vpu30_sm8550, vpu33_sm8650, etc. It might make it easier
to make assumptions and derive common pieces of data.

-- 
With best wishes
Dmitry

