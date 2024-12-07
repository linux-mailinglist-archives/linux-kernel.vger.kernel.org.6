Return-Path: <linux-kernel+bounces-436114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77369E815D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 18:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C5728194D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B2514F9CC;
	Sat,  7 Dec 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq7y/5DV"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21BE38FA3
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733593239; cv=none; b=Lv9KKRsFnB9N8j2SVJJLpbsS2SVIMgOnCI1KaJ75xthlIw/FRbH7hez1U9RzqSZmLPPEJIIte4pIIjtXs3cBWwyqsgTfwRVpbrOvpxxOMHBgRbDN8pEUjQkhy5ed4+4Npo8J1nkOwx73o7NTL01LU2XV2hj0EPCLgoWu83JlI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733593239; c=relaxed/simple;
	bh=S6cDraT/UqzDuLNKup/5Vv4l1cs9hja6FBfWxW28RXo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvWipmSdXSptWhhN3Rsl80Mp5CkBrwCVgK7PPJTg0mTIfUqWJ8HR8MG9RIUowpTBRyytcH5n6P2tonbu7CaiNFCN/nK99Ki+qg0f4fh5jhhIwslEV8gvazLrpXHFY2n1+GfW7DLIph44ml96Jua9lyUeKeNF7MB8hO3F3MwKTlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq7y/5DV; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71de0a43937so104245a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 09:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733593237; x=1734198037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7JFE2TSFDzv+768sc7DXISjbbLokOwhfjQgaEcTQpmc=;
        b=Yq7y/5DVNS1Ab6Ip95uhPsYvuXUvVoytB3OoQ5IK81cESU81qSesuNHxA/XK69VvWG
         O7InkWbmuuGKZThJc5f78JJbMilRHFzXEButU7mrnLD53hNl3Vf6a3e8oCIpl36tM0ux
         By/G2OvhN6GHWt+ecPxq7GMBEoK1WdKIPUyDrk4i6J/gN4TMoQ65pOlJF22cktHFnr6c
         ai05u6O5UqfTCf+ExuduLnn2cHFgUEO1Z/IZMkiSisIwXK8rlH+9TEPg364MHFxRb8GF
         xsWRHcC10FxIsbXnP1BWZ91hsjB5LS7BfMOGe3iJcpQZEs0w9tewKbzWzq+lkowR4gSj
         5RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733593237; x=1734198037;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JFE2TSFDzv+768sc7DXISjbbLokOwhfjQgaEcTQpmc=;
        b=qMSEduQ96VsT2Zzu5is+pGf5+s8qd6llzBWhAzXwRVi28yjpdTCEWb+GJ4YOYEebm+
         PsFhDHxegLZKgbYlNn4MNEVbFXwK1AIck54XS7zc9FLx1b85L3A3qgIfkJSUAKl9ugRn
         Fn/cOAMM+ZUj3izVZMiqbSluarYBVf+Xx18JzjosWCS8Ay2AgAXSulRi9ulXMsya8ieg
         NGGVcW6pF5NkDrqGyZNTfvzWCngLyJSr8RXfyHhrxdrm06OfrbsgZszr5KuUzK5PlTxt
         Qoz5S0iI5N/VhlSBDdjhySqXTixUxef/p8m300h8xYVivylvYV/K0lEb1zoz7hv517d2
         wulw==
X-Forwarded-Encrypted: i=1; AJvYcCVgYj9bbYSxB9H57Os8GhB+Lwl8DIRd76zJb7R5jnn2ZHNnF/xPn3aBkDot7bAuFDcfi3YUs8lJvDXbI6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy44o31oErZTbVAqfyhQJA7tevp4UmN5e4FpPVk0UxtO3pKezIr
	icDVX3H2gMhicBW88rslxFjfeqpPFvWgW3Q2tLeHciq8vYu71wHn
X-Gm-Gg: ASbGncs4E3Z1/SHnzkmf6wvD2DrEw3rkr9RwKxlm8B74v+J2NHc0TBIF39SVPv0qFaE
	zgGSHcstJnuy3yHTbbIlWXviiV8s+57ZnkINYgZCpBngmjWd74vxt3xzlXcMDDMlSf1l3gB4cbq
	aLE5YxnRcVrngbvyzEvkot2WbNL7AY3FYZXQN+vFPq3Fu52XNNIuxYzh5j+J25BD9Yvww2zdKHv
	TYHCIsXFCyrWTXx+Pc56hLLEXxUHjgHAxqK
X-Google-Smtp-Source: AGHT+IG4WgUGLt5SCW6fIP2m8vJVsykzHILxM+8C5MYlecI86j3b8ocFx5B0WxwLHxUtTyVt9fHCoA==
X-Received: by 2002:a05:6830:65ce:b0:718:7c3:f86a with SMTP id 46e09a7af769-71dcf4b0f49mr4344673a34.6.1733593236687;
        Sat, 07 Dec 2024 09:40:36 -0800 (PST)
Received: from neuromancer. ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71dc493b1e3sm1348170a34.1.2024.12.07.09.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2024 09:40:36 -0800 (PST)
Message-ID: <67548894.050a0220.2032bf.693e@mx.google.com>
X-Google-Original-Message-ID: <Z1SIk8CCSlFdu_RR@neuromancer.>
Date: Sat, 7 Dec 2024 11:40:35 -0600
From: Chris Morgan <macroalpha82@gmail.com>
To: Philippe Simons <simons.philippe@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	"open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: axp20x: AXP717: set ramp_delay
References: <20241206123751.981977-1-simons.philippe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206123751.981977-1-simons.philippe@gmail.com>

On Fri, Dec 06, 2024 at 01:37:51PM +0100, Philippe Simons wrote:
> AXP717 datasheet says that regulator ramp delay is 15.625 us/step,
> which is 10mV in our case.
> 
> Add a AXP_DESC_RANGES_DELAY macro and update AXP_DESC_RANGES macro to
> expand to AXP_DESC_RANGES_DELAY with ramp_delay = 0
> 
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
> ---
>  drivers/regulator/axp20x-regulator.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index a8e91d9d0..8f035db13 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -419,8 +419,8 @@
>  		.ops		= &axp20x_ops_fixed				\
>  	}
>  
> -#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_voltages,	\
> -			_vreg, _vmask, _ereg, _emask)				\
> +#define AXP_DESC_RANGES_DELAY(_family, _id, _match, _supply, _ranges, _n_voltages,	\
> +			_vreg, _vmask, _ereg, _emask, _ramp_delay)	\
>  	[_family##_##_id] = {							\
>  		.name		= (_match),					\
>  		.supply_name	= (_supply),					\
> @@ -437,8 +437,15 @@
>  		.linear_ranges	= (_ranges),					\
>  		.n_linear_ranges = ARRAY_SIZE(_ranges),				\
>  		.ops		= &axp20x_ops_range,				\
> +		.ramp_delay = (_ramp_delay),			\
>  	}
>  
> +#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_voltages,	\
> +			_vreg, _vmask, _ereg, _emask)				\
> +	AXP_DESC_RANGES_DELAY(_family, _id, _match, _supply, _ranges, _n_voltages,	\
> +		_vreg, _vmask, _ereg, _emask, 0)
> +
> +
>  static const int axp209_dcdc2_ldo3_slew_rates[] = {
>  	1600,
>  	 800,
> @@ -781,18 +788,18 @@ static const struct linear_range axp717_dcdc3_ranges[] = {
>  };
>  
>  static const struct regulator_desc axp717_regulators[] = {
> -	AXP_DESC_RANGES(AXP717, DCDC1, "dcdc1", "vin1",
> +	AXP_DESC_RANGES_DELAY(AXP717, DCDC1, "dcdc1", "vin1",
>  			axp717_dcdc1_ranges, AXP717_DCDC1_NUM_VOLTAGES,
>  			AXP717_DCDC1_CONTROL, AXP717_DCDC_V_OUT_MASK,
> -			AXP717_DCDC_OUTPUT_CONTROL, BIT(0)),
> -	AXP_DESC_RANGES(AXP717, DCDC2, "dcdc2", "vin2",
> +			AXP717_DCDC_OUTPUT_CONTROL, BIT(0), 640),
> +	AXP_DESC_RANGES_DELAY(AXP717, DCDC2, "dcdc2", "vin2",
>  			axp717_dcdc2_ranges, AXP717_DCDC2_NUM_VOLTAGES,
>  			AXP717_DCDC2_CONTROL, AXP717_DCDC_V_OUT_MASK,
> -			AXP717_DCDC_OUTPUT_CONTROL, BIT(1)),
> -	AXP_DESC_RANGES(AXP717, DCDC3, "dcdc3", "vin3",
> +			AXP717_DCDC_OUTPUT_CONTROL, BIT(1), 640),
> +	AXP_DESC_RANGES_DELAY(AXP717, DCDC3, "dcdc3", "vin3",
>  			axp717_dcdc3_ranges, AXP717_DCDC3_NUM_VOLTAGES,
>  			AXP717_DCDC3_CONTROL, AXP717_DCDC_V_OUT_MASK,
> -			AXP717_DCDC_OUTPUT_CONTROL, BIT(2)),
> +			AXP717_DCDC_OUTPUT_CONTROL, BIT(2), 640),
>  	AXP_DESC(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
>  		 AXP717_DCDC4_CONTROL, AXP717_DCDC_V_OUT_MASK,
>  		 AXP717_DCDC_OUTPUT_CONTROL, BIT(3)),
> -- 
> 2.47.1
> 

This series solves the immediate crashes I get on startup when I use
schedutil as my cpu scheduler.

Tested-by: Chris Morgan <macromorgan@hotmail.com>

