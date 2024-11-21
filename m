Return-Path: <linux-kernel+bounces-417542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CD69D5560
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15E4B22E00
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8601DAC89;
	Thu, 21 Nov 2024 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KoZabLzQ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5F1BD031
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227891; cv=none; b=M+wfGYgfGztH9/u2Xn2ja7kCEHC7YzBrc1a/NkKaLSY1n6wOATqYWYsoO16CwWuQDHI+GQ0Hyfk9BK4TFBWoJufPgUH7Zbd7+TgKaFEhc0Id1fFfZ/HnC0C7VaS6g8nH3nzLC1C0cGHPFJ/bPKU0d9WEKrR/GPtmTW1vyJ1PhEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227891; c=relaxed/simple;
	bh=iLHr6c937zAUNjvXiqxzEog1xJ2S+61XBMshQQmaT0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sukOo5YbKr2UDevXlUrq5T9xY94fX/aEcAi0j5mYM17PapoxKgfTioYzaxOViYPx1JL63GNHgd3NqAhvtpfjZPKQ5BVaG8csEAClSbV0T8lap6IGtQKJ16zEkFwjXjqR8SqL4/6nB2rKWyW37hJQNwH+5V/3LwZLDMK9CSvsYfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KoZabLzQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f8490856so1529079e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732227888; x=1732832688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9qF8j45CSfYdsmm+Dydm51y3aJn8tF9GxFB43niHJc=;
        b=KoZabLzQ0KVh8qWtYXXaAuMEBV3ChKxNGxan8+npV0MrtBmFXvreGBXTcOxFQCjXBT
         jR5juWL58RBrAJj0Wk1PcUzXBi1w/M4tDxAaCTUBuW7HqC1ukDCXQDR6EafvmRL6GBsX
         O29gJZnwEy0EL08O/lfE9rsS9uDO6UjQUzn8yJ8RtQSBLUFMLoUj81YEeTrwefQnJ1l3
         /LTGJEyTVqS+z7iqPj9am/7IjOTgmcmpdUpRAwxvKf4qx9OT93eFtSEXPZnXFHy6hl/E
         vG+Od5TCX2KRq+8BwJpea5BQqYBWwczhClQxOG//M437kb9zYXVlxuNYGVdmKAgdrNsR
         oU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732227888; x=1732832688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9qF8j45CSfYdsmm+Dydm51y3aJn8tF9GxFB43niHJc=;
        b=LGIAeqpAcmPOQkh6xeWQtEGAjXFQvfru/RTeatdzcbBg9kE/bqVRagju1pXU4rhXoS
         LF6HXX/RIS4pAQySIMRpou1xyBsWNg8Is3Hk/h65lAhw8vLbtYX3sDhTzURyF5rz61gx
         uc2RieH4GfUnyGoXzB7hS1CJCwAEfqq/CtG7um1Rs2Gli8ICIBs4tYHG1gbNPfq7J9WC
         oCCKHcBSXvXDH68CrkdOGCGg4WGeAr16y8CFg0ota2QPQ2kmxbnWTZzOsF4BwAdOmwIZ
         3IkR9j9Y/hGaM+VV4vxUF5Yqn7nlx97g+UQPkWzMc2Goe3nNnxu4G+ODIs9PRXr066AG
         k5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR1OlxcCFt2iztwfVOvj9NhD1lp5hUWPXnGBNsnJLp/p1gDosmv2kY87HbVVGkNyzOlCblAM1lPycCamo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHRu5rrgBA3eLyRiX+6KAt68UXCqQhzPVKI/C+n/J8IAL1046W
	MvoMkdXhOYVlBaw3CKn9Ly1We80HiD3e9yyICCCPAPVcwVkgDZ1kIZGcJZSmAME=
X-Gm-Gg: ASbGnctNmwniJkviCTYKuhFJq/QuqDDoWxPuNcFsMvPbNr7Y36Ag5If3lvmbaurbwy3
	5eUviseexaqaU3a6cg2krA/IcdNBR6A8ghj+LmjGp71ioP3O+XUmwxBwYXyRPUkdf4g0WCOpj9Q
	HCDRBrqobXs9byL1cgJTdhuCK0IQjnrcc5j6v0/sQIksB6acAeeNKyoBJDx6tFDW4di+WWHe+ab
	EHuQXbjFd0wHqaeAj+iIion27wmUv2SeU0F5c0koBR+S/d7aacyHAFamLEAzF4lOEGFSslBZb3O
	sAyKMlfyruZe+ex1eJhcmdKxxdFnEw==
X-Google-Smtp-Source: AGHT+IE2T2Pj6r6Y1ycGgpu7KwhyGxrz0hWNZVwX6ZaXIy5LqSV1VBAcT58vN5h6glzEjVd3g7gW/w==
X-Received: by 2002:ac2:410d:0:b0:53d:d3f1:2f4b with SMTP id 2adb3069b0e04-53dd3f12f92mr106226e87.30.1732227887928;
        Thu, 21 Nov 2024 14:24:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24519b6sm99737e87.106.2024.11.21.14.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:24:46 -0800 (PST)
Date: Fri, 22 Nov 2024 00:24:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Song Xue <quic_songxue@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Manu Gautam <mgautam@codeaurora.org>, 
	Vivek Gautam <vivek.gautam@codeaurora.org>, kernel@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] phy: qcom-qusb2: Add regulator_set_load to Qualcomm
 usb phy
Message-ID: <7qj4szkw365ve45hm5w475xs2vlfsfg5pcpc44bo3s5vhrcmuu@bh5swbug4ywi>
References: <20241121-add_set_load_to_qusb_phy-v2-1-1c5da1befec0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121-add_set_load_to_qusb_phy-v2-1-1c5da1befec0@quicinc.com>

On Thu, Nov 21, 2024 at 04:09:27PM +0800, Song Xue wrote:
> Set the current load before enable regulator supplies at QUSB phy.
> 
> Encountered one issue where the board powered down instantly once the UVC
> camera was attached to USB port while adding host mode on usb port and
> testing a UVC camera with the driver on QCS615 platform. The extensible
> boot loader mentioned that OCP(Over Current Protection) occurred at LDO12
> from regulators-0 upon powered on board again. That indicates that the
> current load set for QUSB phy, which use the regulator supply, is lower
> than expected.
> 
> As per QUSB spec, set the maximum current load at 30mA to avoid overcurrent
> load when attach a device to the USB port.
> 
> Fixes: 937e17f36a32 ("phy: qcom-qusb2: Power-on PHY before initialization")
> Signed-off-by: Song Xue <quic_songxue@quicinc.com>
> ---
> Changes in v2:
> - Removed "---" above the Fixes. 
> - Link to v1: https://lore.kernel.org/r/20241121-add_set_load_to_qusb_phy-v1-1-0f44f3a3290e@quicinc.com
> ---
>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> index c52655a383cef008552ed4533b9f31d1cbf34a13..80f0d17c42717e843937255a9a780bbae5998535 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> @@ -722,16 +722,27 @@ static int __maybe_unused qusb2_phy_runtime_resume(struct device *dev)
>  	return ret;
>  }
>  
> +#define QUSB2PHY_HPM_LOAD 30000 /*uA*/
> +
>  static int qusb2_phy_init(struct phy *phy)
>  {
>  	struct qusb2_phy *qphy = phy_get_drvdata(phy);
>  	const struct qusb2_phy_cfg *cfg = qphy->cfg;
>  	unsigned int val = 0;
>  	unsigned int clk_scheme;
> -	int ret;
> +	int ret, i;
>  
>  	dev_vdbg(&phy->dev, "%s(): Initializing QUSB2 phy\n", __func__);
>  
> +	/* set the current load */
> +	for (i = 0; i < ARRAY_SIZE(qphy->vregs); i++) {
> +		ret = regulator_set_load(qphy->vregs[i].consumer, QUSB2PHY_HPM_LOAD);

Please use regulator_set_mode() instead. Or just fix the mode in the
device tree, if the device can not operate if the regulator is in
non-HPM mode.

> +		if (ret) {
> +			dev_err(&phy->dev, "failed to set load at %s\n", qphy->vregs[i].supply);
> +			return ret;
> +		}
> +	}
> +
>  	/* turn on regulator supplies */
>  	ret = regulator_bulk_enable(ARRAY_SIZE(qphy->vregs), qphy->vregs);
>  	if (ret)
> 
> ---
> base-commit: decc701f41d07481893fdea942c0ac6b226e84cd
> change-id: 20241121-add_set_load_to_qusb_phy-d1327c797ffe
> 
> Best regards,
> -- 
> Song Xue <quic_songxue@quicinc.com>
> 

-- 
With best wishes
Dmitry

