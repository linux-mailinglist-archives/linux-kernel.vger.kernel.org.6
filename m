Return-Path: <linux-kernel+bounces-402522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 052DB9C28C7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95F22830B7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C360CA6B;
	Sat,  9 Nov 2024 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psn2xyuq"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8E8BFF
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111832; cv=none; b=lc056UWKqorSjzoIha+x7xEAEByGb9NT9ANMsgQs0LavwQvMtVE2NXkG8bfvJ9H9exUMtZo5Df9Llj/G4DFat/RRnVz+/d3ytrvobUwSc1iw4z3RTYVsAwzReex1J482H9fh8F2MVsIc6UaAn7BHzfZaXeZwj770BxWRH7+OmRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111832; c=relaxed/simple;
	bh=m5snUBzSF9Zk9uwVyfFeARa+ZNDvJoKukKw2KaQMHHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9o0TQM2c1nI0MI29V9znvasu1EMh3Jozz3lwNJVvW3uxV6hk333JDBvotBVnsmix9Ta37KI6xmbX5JGptX4iTkkk0um9LpJ+Wua4+7rxSGM0io/LnZy99giEuI0xPbDop9jkj5TKVUvfVmrzK2do4AoE2OWKH8FqGAdHIzq0sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=psn2xyuq; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5638dd57so22591141fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 16:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731111829; x=1731716629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCUSp8vZt+etdZ/oJELhkYG4M5ycIKVOibuDoFx6fIU=;
        b=psn2xyuqZjkVKoauKQImB1HSMc00iEKaUAmLhVY6xKLiqSMNcgxTNVg7eKDu7e5o3t
         Z5QN8EOHSdmRfzR9kU6cllF2CfdmaKB4UO6W66ZmYIBuHZy7fv20iF28JYyi9DPaGgK5
         j1EWKXmLwx/IWQv6jzDDX8h24ROC40ZWnwuNMc5nrpzskM9tNXuztr6r541ZfOdUhVLL
         64Y4S/ZyTEC0IOZeRZ7Grre4yUB7eMhky4B2uB591rVVe5GkVk7Gbs4Rw8PM/3qMagor
         SlJTD1de+DtwTEhO+snMgvMIbuI4fpwX2QM5FWmlyeXgGnPWU3H5Fxzh6X25BrrwZ98y
         Vcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111829; x=1731716629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCUSp8vZt+etdZ/oJELhkYG4M5ycIKVOibuDoFx6fIU=;
        b=F/MTKlNoLEjJ8za6xnD3O7euOiWp5oI9tRhiVFgRXMHX4tApxgO8M4FwYgy1ZRU0aU
         qdToDaWY3eRhGqY50Fbs/qwy8mdCO/kOh1KUI7hNTmy3csyr1LHHxQgbXzQJ5vzyDxax
         COwqlRo9A087mzeTewDxwIM1EtvEK1NGDfQateX0Vlw3mtvTB9LkakUhHcWJB0wUALhh
         sqSgE+uP/oriCzOtr1E7h9hq4gbpplE8k1EPMIvR4gJ8XrjbUZq3h9NsOldJ3RWgf7bQ
         DPVwAuJywWDAdhZB57SuYuOaC6apsGmgfT0BDXlqCbbq/TwARSyNPM46a/DmtPyWdD0m
         61Kw==
X-Forwarded-Encrypted: i=1; AJvYcCU4+a/8EDDM8dW4lwFZIr4UVaqtz1zipCWjPXUmWfFMz9DrasMAwXwynn2+QZne0TVKZiMCRyHv5iYPPpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPlLGbpTRPDZ8FxXSrSCDeK2Tt312PVzTOUi21pKbSYjsxou12
	gDICyJgguaI5/lsYNoAW7k36nSXAYoGk7nN0kmUkr6kwLoEOIfwC5MNgewjzP/A=
X-Google-Smtp-Source: AGHT+IFRWk001tkq1A4/3uIoY4IY1UFsTqMCK1GVPAMXfalK9z2bqEPusxsZuSeSFQxPzDkOgwfPkQ==
X-Received: by 2002:a05:651c:549:b0:2fa:dadf:aad5 with SMTP id 38308e7fff4ca-2ff202683eamr27805411fa.28.1731111829101;
        Fri, 08 Nov 2024 16:23:49 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff17910e1csm8492181fa.68.2024.11.08.16.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:23:47 -0800 (PST)
Date: Sat, 9 Nov 2024 02:23:45 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com, andersson@kernel.org, 
	konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, quic_srichara@quicinc.com, 
	quic_varada@quicinc.com
Subject: Re: [PATCH v7 3/7] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
Message-ID: <z24xwwdtd6rytktxtuagiwbiukwd5tvfhotbbydizwsjtlnaob@q3ujwf2eiwds>
References: <20241107140550.3260859-1-quic_mmanikan@quicinc.com>
 <20241107140550.3260859-4-quic_mmanikan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107140550.3260859-4-quic_mmanikan@quicinc.com>

On Thu, Nov 07, 2024 at 07:35:46PM +0530, Manikanta Mylavarapu wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> SoCs without RPM need to enable sensors and calibrate them from the kernel.
> The IPQ5332 and IPQ5424 use the tsens v2.3.3 IP and do not have RPM.
> Therefore, add a new calibration function for V2, as the tsens.c calib
> function only supports V1. Also add new feature_config, ops and data for
> IPQ5332, IPQ5424.
> 
> Although the TSENS IP supports 16 sensors, not all are used. The hw_id
> is used to enable the relevant sensors.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
> Changes in V7:
> 	- Move val calculation out of switch-case and assign default
> 	  values to shift, slope and czero and then change them under
> 	  switch-case in tsens_v2_calibrate_sensor().
> 
>  drivers/thermal/qcom/tsens-v2.c | 176 ++++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.c    |   8 +-
>  drivers/thermal/qcom/tsens.h    |   4 +-
>  3 files changed, 186 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 0cb7301eca6e..6d2783577139 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -4,13 +4,32 @@
>   * Copyright (c) 2018, Linaro Limited
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/regmap.h>
> +#include <linux/nvmem-consumer.h>
>  #include "tsens.h"
>  
>  /* ----- SROT ------ */
>  #define SROT_HW_VER_OFF	0x0000
>  #define SROT_CTRL_OFF		0x0004
> +#define SROT_MEASURE_PERIOD	0x0008
> +#define SROT_Sn_CONVERSION	0x0060
> +#define V2_SHIFT_DEFAULT	0x0003
> +#define V2_SLOPE_DEFAULT	0x0cd0
> +#define V2_CZERO_DEFAULT	0x016a
> +#define ONE_PT_SLOPE		0x0cd0
> +#define TWO_PT_SHIFTED_GAIN	921600
> +#define ONE_PT_CZERO_CONST	94
> +#define SW_RST_DEASSERT		0x0
> +#define SW_RST_ASSERT		0x1
> +#define MEASURE_PERIOD_2mSEC	0x1
> +#define RSEULT_FORMAT_TEMP	0x1
> +#define TSENS_ENABLE		0x1
> +#define SENSOR_CONVERSION(n)	(((n) * 4) + SROT_Sn_CONVERSION)
> +#define CONVERSION_SHIFT_MASK	GENMASK(24, 23)
> +#define CONVERSION_SLOPE_MASK	GENMASK(22, 10)
> +#define CONVERSION_CZERO_MASK	GENMASK(9, 0)
>  
>  /* ----- TM ------ */
>  #define TM_INT_EN_OFF			0x0004
> @@ -50,6 +69,17 @@ static struct tsens_features ipq8074_feat = {
>  	.trip_max_temp	= 204000,
>  };
>  
> +static struct tsens_features ipq5332_feat = {
> +	.ver_major	= VER_2_X_NO_RPM,
> +	.crit_int	= 1,
> +	.combo_int	= 1,
> +	.adc		= 0,
> +	.srot_split	= 1,
> +	.max_sensors	= 16,
> +	.trip_min_temp	= 0,
> +	.trip_max_temp	= 204000,
> +};
> +
>  static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  	/* ----- SROT ------ */
>  	/* VERSION */
> @@ -59,6 +89,10 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  	/* CTRL_OFF */
>  	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
>  	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
> +	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3,  18),
> +	[CODE_OR_TEMP] = REG_FIELD(SROT_CTRL_OFF,    21, 21),
> +
> +	[MAIN_MEASURE_PERIOD] = REG_FIELD(SROT_MEASURE_PERIOD, 0, 7),
>  
>  	/* ----- TM ------ */
>  	/* INTERRUPT ENABLE */
> @@ -104,6 +138,126 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>  	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>  };
>  
> +static int tsens_v2_calibrate_sensor(struct device *dev, struct tsens_sensor *sensor,
> +				     struct regmap *map,  u32 mode, u32 base0, u32 base1)
> +{
> +	u32 shift = V2_SHIFT_DEFAULT;
> +	u32 slope = V2_SLOPE_DEFAULT, czero = V2_CZERO_DEFAULT, val;
> +	char name[8];
> +	int ret;
> +
> +	/* Read offset value */
> +	ret = snprintf(name, sizeof(name), "s%d", sensor->hw_id);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = nvmem_cell_read_variable_le_u32(dev, name, &sensor->offset);
> +	if (ret)
> +		return ret;
> +
> +	/* Based on calib mode, program SHIFT, SLOPE and CZERO */
> +	switch (mode) {
> +	case TWO_PT_CALIB:
> +		slope = (TWO_PT_SHIFTED_GAIN / (base1 - base0));
> +
> +		czero = (base0 + sensor->offset - ((base1 - base0) / 3));
> +
> +		fallthrough;
> +	case ONE_PT_CALIB2:
> +		czero = base0 + sensor->offset - ONE_PT_CZERO_CONST;

THis will override czero calculation from TWO_PT_CALIB case.

> +
> +		slope = ONE_PT_SLOPE;
> +
> +		break;
> +	default:
> +		dev_dbg(dev, "calibrationless mode\n");
> +	}
> +
> +	val =	FIELD_PREP(CONVERSION_SHIFT_MASK, shift) |
> +		FIELD_PREP(CONVERSION_SLOPE_MASK, slope) |
> +		FIELD_PREP(CONVERSION_CZERO_MASK, czero);
> +
> +	regmap_write(map, SENSOR_CONVERSION(sensor->hw_id), val);
> +
> +	return 0;
> +}
> +

-- 
With best wishes
Dmitry

