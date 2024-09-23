Return-Path: <linux-kernel+bounces-335869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D91297EBC4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC550B21986
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED4A1990D2;
	Mon, 23 Sep 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MLwI3aGe"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0281197A83
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096174; cv=none; b=cCkxwIvIml1r2MTM33lNnzRWjnHzx6Ec4K889K0ZOJyFUQJDUMNn8xYDmQYCb6YYznkgECDP5lOu4LTJUpk9fohUiURt9s+gkJf+fapsUnJxJZB+ftkIQYgHxcKlfcMcyFHJAE6vz32ehLUAZzAJyBWRu2dqqr3d8eAD8z7tnag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096174; c=relaxed/simple;
	bh=jzDvSBKwkVdUMQsiJmF4oYStGUS15nrVohM7flKGoIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Th/EHM6S9rSrzHq76mThIoxy/cp3CF/V4e4t37N6xggPJZjMI8QfGILlH4zUE9AZwLMaLcbfJiQSwWlyWfIbnPB/ak65arX1GyVnU3ofQxIATqomYF/hYEqRKpmE4NyT6p3NVMcXtcGjMLtNbWJ5nbaS7JJEVhtaxgapaAOOavg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MLwI3aGe; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a99d23e036so466694885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727096171; x=1727700971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YpmRGiuRj02me6ExvTdqms1rXFpbM5Yb2+jVrF4wto4=;
        b=MLwI3aGeGhahlWSdb/o2DoDC6g+/WMa4OMnFMteCKQdNa5a808p0IuQ8USd4s3Ch8I
         DBe60fLIuYFxW+WY3Oa9DMk+2Z31QdjG3bRFrDBqcktfcc/TpByNgAkey+DzOing3Z+x
         oMW3rIeTqHd9DwTWfkjUggK6MrLuLFeVXu5YAnjMLQRq+kb5jbgsnVkZiy9+qIQI7kBc
         p2EINJY2aFUhpO9rXpWRHLJ47xNCECwIEULSdKjzhNjGbsYuSH5QyTCFn8ldSBR0ywYN
         t+S2d9xZg+Ms8U0J67gfbuAIL6n2p35iwDWzpXKyf7BjqybXiDPYekeD0yCY2p//gLZR
         RIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727096171; x=1727700971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpmRGiuRj02me6ExvTdqms1rXFpbM5Yb2+jVrF4wto4=;
        b=S2gcpiBx3XF1eJ8OhgtFmuO9lz5QDfGAoBc8HL3TgjLCo3549QSBGshFceFl3sE8LU
         m596CP40pph95oCYa+jAgrwAnOwx4BZXmX8KGln9YYWxo4Egb+79wWChExpRiDlrRYqv
         eobmzbo6MBzfv4au/3++gnrXw79ySxf7aUQVAoa5/n+1NDs2P8tMD/PIPQ0Ykt93dYjG
         Q7kp+QIzNianBo9NaXgKfPsYO4ZHTZE6dFBAjnrgTu2wMj2jWUN7W+zN+NglJg0NJtAd
         +51tjh6V8iud207bjrgLj7oSEYooNJ9v+OVVtDacJB528MAyU3oOoIb2AZaBMII9edej
         NWYA==
X-Forwarded-Encrypted: i=1; AJvYcCXRnvU3m2xFJ9oGfcPKLiBwjMaKN+02BxUf3q+3L4TWtJvPxx6CUd/nrgp4bx2cM9XnoYzjg4fzbnRIRQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9AIE2C/2uSbEjFHzAHJDZl6fpLuv/4LNPrhxEpu8Bcc8rf5ii
	CoHLwxqx8x37SVvkmpWiEUTEgJZtHBeWvf5mbjcR9DHQzbe3E0KZPsElSF0MAIXylZbtiqQVAWA
	bM9U=
X-Google-Smtp-Source: AGHT+IHn0Nex/Wcq7aiun9zy74wgMKQmhjhE+Mgi+BNC3lHnVS9nR+dfKFkg/SPBaXhqf3+a+kszoA==
X-Received: by 2002:a05:620a:2688:b0:7a9:b8d1:a1d with SMTP id af79cd13be357-7acb8d99ef1mr1720582985a.38.1727096171572;
        Mon, 23 Sep 2024 05:56:11 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08eba0csm475168585a.131.2024.09.23.05.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 05:56:11 -0700 (PDT)
Message-ID: <95e372fc-5656-4c11-9e84-0df624fca0ad@baylibre.com>
Date: Mon, 23 Sep 2024 08:56:09 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: axi-pwmgen: Create a dedicated function for getting
 driver data from a chip
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240923125418.16558-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20240923125418.16558-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-09-23 08:54, Uwe Kleine-König wrote:
> Compared to direct calls to pwmchip_get_drvdata() a dedicated function
> has two upsides: A better name and the right type. So the code becomes
> easier to read and the new function is harder to use wrongly.
>
> Another side effect (which is the secret motivation for this patch, but
> shhh) is that the driver becomes a bit easier to backport to kernel
> versions that don't have devm_pwmchip_alloc() yet.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
>   drivers/pwm/pwm-axi-pwmgen.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index b5477659ba18..e5162f3e511e 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -53,10 +53,15 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
>   	.max_register = 0xFC,
>   };
>   
> +static struct axi_pwmgen_ddata axi_pwmgen_ddata_from_chip(struct pwm_chip *chip)
> +{
> +	return pwmchip_get_drvdata(chip);
> +}
> +
>   static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   			    const struct pwm_state *state)
>   {
> -	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
> +	struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
>   	unsigned int ch = pwm->hwpwm;
>   	struct regmap *regmap = ddata->regmap;
>   	u64 period_cnt, duty_cnt;
> @@ -100,7 +105,7 @@ static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>   				struct pwm_state *state)
>   {
> -	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
> +	struct axi_pwmgen_ddata *ddata = axi_pwmgen_ddata_from_chip(chip);
>   	struct regmap *regmap = ddata->regmap;
>   	unsigned int ch = pwm->hwpwm;
>   	u32 cnt;
>
> base-commit: 62f92d634458a1e308bb699986b9147a6d670457

