Return-Path: <linux-kernel+bounces-213607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D84D907797
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB950B224AC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650A712E1CD;
	Thu, 13 Jun 2024 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="A2PCjoYL"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D14206C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718294076; cv=none; b=qu1YdQwGF8p1c4oeKF4VYf3hKZKLyQ4GPpILTHQJCP2rJBWlpGwucutOL88DRCGdYCbMRA+9SkQ7gMk7E3QauI0czsZaAMy8hSXhIESi6d3jDuVE/HPLO1fvUQliq+Pm+YYFpEZvYmMBChzLJmmHJ5J6NkixdPtQf0EErrq1mqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718294076; c=relaxed/simple;
	bh=Qy/EAdDgX6MDEf5U1qYDCjyyjVP7uqwzYamTDW0h/is=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jCWKz/BT80lvvOzA+dS+MPkQYdU/iiD+7VePGg/yOWbMZ1OUg6UXKsZGk66aenmyavQxKTu8E97d+t7wq9glg3DQXCrFmP+1GW4Ip63cBrj8i7Y0XyxBquTgSjvhx/0Sn54yejUN7L9WQaJhZc196BtrqLHMPKXMtPmpl2VAIEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=A2PCjoYL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42172ab4b60so11935905e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718294072; x=1718898872; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d6tXE2AO0lPT2LpEB7LFIA9IGhDPpvidsM8ojyddTgQ=;
        b=A2PCjoYLE1hnBVC2z0gEMmJnoQx6dLxVZ7rX4ybwpuIEOvwiOjuIYfsEv+k+DboNda
         f741QZusIxyB8BfCPfJ+r2Tq2P59FLA/pE5q0NR3Kiboxh6+BcqOHGI0XTUtDwIogoxX
         wEYIInm+3iel38D0B9hKh0TQVqSCM1ZqZqsZXgTdM3lB7tEg1KCVXvk1TUX+3dsCwtIH
         +hko9XKYbdaj6d2SlUb1+uzTyUBqhFwgsWiuK0XMPeCGQxIp5qOLNJrk6pTtFD8RFRwT
         mxfsDpXVmKmU7gKbJR7SJ6YTemCLqAqwmF/Sqv6yPb6HRaU7SKHJWWNaUNOm42HjjhB5
         kuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718294072; x=1718898872;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d6tXE2AO0lPT2LpEB7LFIA9IGhDPpvidsM8ojyddTgQ=;
        b=RBHz8Hw936z4LsD8U6/bRa4ATK08LR6aT25AV9sUvIurZFUExwFxLzC+fqV0VFIRby
         YRfL9TAVvC038Agm0/BTSunZauMW2CVeA/5YIOU2PU8qh1eDxT/cG0Yztd5JMDzNGKzs
         rpXRDhgyQkmjegM1fo4Gvnr0hPTpdtvA/cb3jMqwBnPDA6gz7EtXLIgK4bx0vuxsC7oI
         WVr8Plc/Y8eiFVHmkXU47UdC8QwD4p6vZtxbY1N0NQGBy6JiwPMBVqa1UQUatL6D/eJM
         JcRbzsXaDxknsfzkn2pBPCGtu0/VLzV8TaWHcnxp6XdEssF0ebNzPz/O0mC1l3yE3r6Q
         F1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLiUx91JM1StLgGnra0+XMIzNOW0obJoRknUPsXUWWI2Un/PGhgnPxrdu5uKa/Hu/Vno037UlzjTSVXWxX9R349MIWfbrZD6Wu4V6d
X-Gm-Message-State: AOJu0YxM6oMHJwavxUVcrv09znAqsLsKSq7Pv4QrtCrSXQLlFhyfJ2m/
	IMK5i3CKZAWYkHe8SFpByuCHA9F4/IW3hm1vbq6S/0pU65WOGh6IhjrUOz5mQ+I=
X-Google-Smtp-Source: AGHT+IG1zc8YWNE0EHvhNYi1n4wvzpml1bFEuKoi2CO1pl70ncYnu86I0E00hbaTdU/6tEtLjLTn0g==
X-Received: by 2002:a05:600c:4689:b0:423:366:ad3d with SMTP id 5b1f17b1804b1-42304827295mr2065555e9.13.1718294072242;
        Thu, 13 Jun 2024 08:54:32 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:ec82:cd82:409a:270b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a633sm29738235e9.43.2024.06.13.08.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:54:31 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  kelvin.zhang@amlogic.com,
  linux-pwm@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org,
  devicetree@vger.kernel.org,  Junyi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v8 1/2] pwm: meson: Add support for Amlogic S4 PWM
In-Reply-To: <20240613-s4-pwm-v8-1-b5bd0a768282@amlogic.com> (Kelvin Zhang
	via's message of "Thu, 13 Jun 2024 19:46:35 +0800")
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
	<20240613-s4-pwm-v8-1-b5bd0a768282@amlogic.com>
Date: Thu, 13 Jun 2024 17:54:31 +0200
Message-ID: <1jfrtgj0so.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 13 Jun 2024 at 19:46, Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org> wrote:

> From: Junyi Zhao <junyi.zhao@amlogic.com>
>
> Add support for Amlogic S4 PWM.
>
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
>  drivers/pwm/pwm-meson.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index b2f97dfb01bb..98e6c1533312 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -460,6 +460,37 @@ static int meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
>  	return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
>  }
>  
> +static void meson_pwm_s4_put_clk(void *data)
> +{
> +	struct clk *clk = data;
> +
> +	clk_put(clk);
> +}
> +
> +static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
> +{
> +	struct device *dev = pwmchip_parent(chip);
> +	struct device_node *np = dev->of_node;
> +	struct meson_pwm *meson = to_meson_pwm(chip);
> +	int i, ret;
> +
> +	for (i = 0; i < MESON_NUM_PWMS; i++) {
> +		meson->channels[i].clk = of_clk_get(np, i);
> +		if (IS_ERR(meson->channels[i].clk))
> +			return dev_err_probe(dev,
> +					     PTR_ERR(meson->channels[i].clk),
> +					     "Failed to get clk\n");

here it is ok but ..

> +
> +		ret = devm_add_action_or_reset(dev, meson_pwm_s4_put_clk,
> +					       meson->channels[i].clk);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to add clk_put action\n");

... here, devm_add_action_or_reset cannot defer, so dev_err_probe is not useful.
dev_err() if you must print something. Just "return ret;" would be fine
by me

> +	}
> +
> +	return 0;
> +}
> +
>  static const struct meson_pwm_data pwm_meson8b_data = {
>  	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>  	.channels_init = meson_pwm_init_channels_meson8b_legacy,
> @@ -498,6 +529,10 @@ static const struct meson_pwm_data pwm_meson8_v2_data = {
>  	.channels_init = meson_pwm_init_channels_meson8b_v2,
>  };
>  
> +static const struct meson_pwm_data pwm_s4_data = {
> +	.channels_init = meson_pwm_init_channels_s4,
> +};
> +
>  static const struct of_device_id meson_pwm_matches[] = {
>  	{
>  		.compatible = "amlogic,meson8-pwm-v2",
> @@ -536,6 +571,10 @@ static const struct of_device_id meson_pwm_matches[] = {
>  		.compatible = "amlogic,meson-g12a-ao-pwm-cd",
>  		.data = &pwm_g12a_ao_cd_data
>  	},
> +	{
> +		.compatible = "amlogic,meson-s4-pwm",
> +		.data = &pwm_s4_data
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, meson_pwm_matches);

-- 
Jerome

