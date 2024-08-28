Return-Path: <linux-kernel+bounces-304609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F3F962276
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BBA1C2348C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B34315CD54;
	Wed, 28 Aug 2024 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="siNh6tgY"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659018030
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834754; cv=none; b=SBSE1nOWGfAKuqNtTuYFWN5R+gKr9zeHxRMV/NJcQM6ZrxVr8yrv/VsDVLzcmIaBAu50L4ijUPeyv3RjvV7muAeNToDgb/gPXghrJGA6pgZrFYbC6Ms4PHsbMgeXAfVofaA2//V7/qwO/HpU2xCqu3u5H3ffdPoF6XYvh691zuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834754; c=relaxed/simple;
	bh=yu4Wy0wOcgEQcfzt1v6vuNg/URcukRaqet6Jqj3F69g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+sZUEVf36M9LADyIhQzzXmZoJ04FwmHj7DVeximuCnjkKyEC3U61aQkyNqf67S4Y6lUBwLemYkrOX8EtOp090QEp3H9LfQgdN/CIhJphZEFtua/fy/R8tWPM1MJ7gDAULc9VQsXHvrKGL/I+IrK8WMZMPV11dv4eposSWkfA4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=siNh6tgY; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5334c4d6829so8978739e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724834751; x=1725439551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vdBIi5m8EWzWp93xlsbcf9ZPOqz4SwEvCdHpMtK8yDU=;
        b=siNh6tgYFdG5L3dy1prcX5AvluHDhQibkzL3uRB7JgU19vPcP/Uym7CaNt0hwxfoQo
         BfemX837yo4Y+Gd3Yg/ENT65IiAVmERbvmGo4y22IRKRRMDZtJCthC8ilaNq8Kd+OoaA
         R5X/vFR6l1RO+Txljh0D68N3q6ji8u4Q4Ax5QaVG57MdFkozKYjPb+dwh2SnEDtEmKeU
         f2r/Y0LQloVmmmzt6LCIdCJ9QRxQb/RKzQ5jeJy0n53XN9oZYrgv3yYvsit6eMBibIqh
         mLPRBwRryM0bNyIARcyTtBu9K30ptIm0g88eHwpPJgt17Tn06ESGpTQvK1+hz67Lersz
         +wZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724834751; x=1725439551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdBIi5m8EWzWp93xlsbcf9ZPOqz4SwEvCdHpMtK8yDU=;
        b=woT0GZR35FWVKLcksC2H2IAHAXCLb1fdOF67wqJrN7Dya572bnfQDIsQNm+/qW6luC
         UopS/MJchDu2E/dIrIYWr2MMyUAD6JeFE186O/73ach/kfCHu3F4wFyk2vawd1X3+7K0
         G3UApNrKmo0H/kFKt4Tq+C6xD5phnxWzOhKANyBHk+krsYoh8ajfQo3es+02U94JSs7y
         VPYk/yJRcP9Y/Y9XQoiVqVX+BCFvX76zxmzx6TNPJsvUKoDRDKYQBn5YFa1YsFffoJKb
         kmB9YwVxygH8ftLQq9yyz4V1MfYbdPHyP7QMDM4JCiiPZL5buvp+IdmZDh8sJLe9XX+k
         8HUw==
X-Forwarded-Encrypted: i=1; AJvYcCW9hECX60wCFLXIEf2a6OWMggc2/nLatfVXUTvXj53EMjf/TRBDDTyagu9ph8Fw/6SVvPlim9OmA8WgT60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2b5r54rqwmBiCwZBWXQ1x1OQiFuM2Z91mOxswz7vME9rkKLvP
	4h9uTeerEdCDmqAomWGpifF80mqnkr5Tz9GGyTZfWIxtKPKzzYGP2sxH2TpY0wQ=
X-Google-Smtp-Source: AGHT+IHWxfcTIgRBRkO/+YAr6ZW+2Y5xXvy9KTaUM5ZOJKXQFVXhMO86M5E4uZUCWTKcKt1OVXzUNg==
X-Received: by 2002:a05:6512:224b:b0:533:88d:48ca with SMTP id 2adb3069b0e04-534750c2934mr986691e87.55.1724834750626;
        Wed, 28 Aug 2024 01:45:50 -0700 (PDT)
Received: from linaro.org ([82.79.186.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e5878562sm211665066b.156.2024.08.28.01.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 01:45:50 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:45:48 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	festevam@gmail.com, abelvesa@kernel.org, peng.fan@nxp.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND 1/4] dt-bindings: clock: add i.MX95 NETCMIX
 block control
Message-ID: <Zs7jvCHO+ifC3VaT@linaro.org>
References: <20240729012756.3686758-1-wei.fang@nxp.com>
 <20240729012756.3686758-2-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729012756.3686758-2-wei.fang@nxp.com>

On 24-07-29 09:27:53, Wei Fang wrote:
> Add 'nxp,imx95-netcmix-blk-ctrl' compatible string for i.MX95 platform.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> index 2dffc02dcd8b..b0072bae12d9 100644
> --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> @@ -17,6 +17,7 @@ properties:
>            - nxp,imx95-display-csr
>            - nxp,imx95-camera-csr
>            - nxp,imx95-vpu-csr
> +          - nxp,imx95-netcmix-blk-ctrl

Move this above vpu-csr, please.

Also, for some reason, this patchset doesn't apply cleanly.

Please respin.

>        - const: syscon
>  
>    reg:
> -- 
> 2.34.1
> 

