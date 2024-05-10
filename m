Return-Path: <linux-kernel+bounces-175338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9193B8C1E35
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A277283B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B3F56B9C;
	Fri, 10 May 2024 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="PCflBbWN"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355591BC2A
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715323186; cv=none; b=jbdkVzVaaHKBciJTLsaTMjbZf1CFy8O+j7DzFbMFYp8eT2gUv/Ek6f9KHnYM7pBskwvIQMjy3h/1Mz5mRKephALGOXYgfprgbhkqE/3GteYtHrgE6SxYOh+khhgInYj3G/0FfO4RiTWjn/7R7QB2IZPH0+pvRGloG9HNp/T8cDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715323186; c=relaxed/simple;
	bh=M6/ShrmFP2zIiQ209mU5GrLeH/mOx0rrCknJicOhDHU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=KlzAzdf4u0cmHWdJnLTiNp1UwiBHp+U8QWKodBBZX8Si9PA/SzastBvzp/GGLloiTXioBSH4ea+Zb4XbWIQpmBpS1aN7CYGiY1k6rlMUut+/feo/kHZb8498ap1z2H2k67VjHl5tb/1FNa37o9sZdM+6yP4BcJMtFjZ31NLxMYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=PCflBbWN; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f1b378ca5so2920253e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 23:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1715323182; x=1715927982; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDDYjOZbYyI7+VrCFYHuMsQn9IaAJCiNGNvsyl18CMA=;
        b=PCflBbWNTX7wwLbMKwOVhvxeVR3FPu8+ObpKj15As9kUpMtCDJxv2ir+RzocjInPMR
         YuO48E5N2SwtUxkobLAiHekFNXXAEsiB/tsTQxlkT3e+8jG6lPXSD6kJalQ63ThaMrD1
         pc5WtVnScmxeeJ0zYRZYbeDII2wNJa3ntfW+5gKBnKjG7j4IZED8YBTAkKw0q8bc9YPA
         iSx66roBjBemB7f/cKu09hj5st0ljH6C8MRoC+KLpJ5wejGxekK254RKNzg/aoxV2Fen
         IhCA93Wgs4SFFB0aETw1dfuXkod7i+zzrKJDAp3m+jVXoUYyNQU8RJzA6HE9rX6tYRyx
         6R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715323182; x=1715927982;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yDDYjOZbYyI7+VrCFYHuMsQn9IaAJCiNGNvsyl18CMA=;
        b=toJurs/4wrO6fYHhPHdV8Kj/5orSkg2L7qiozYTxsGIOSwT4ZUHq3G2AIbi6lQVEzT
         JynIZL8jgHtosT98J949Ms7GQrVe9qNxgxlwN7hzueb5BWRnEXEoKHb5oka11yQUrsLb
         Ms2jjRRYYoTbgB3Qu0jkB9HR+TyD6NOc74Lv9CKELV+17llmOiGZ21oWe2EriMPoCMJf
         IttXPskQC/vabjTPHVhSsC4Kn99ZKxA+XVzIs0OkZGMkor/wonhqVL/MMsDrS4KLcskW
         Bt04/TxEgQc8p98IWnqrOXI6ML2lgYBgZw6HjwsS/xMZ4ttJ6XMMZtSpsDDqy8968DMC
         I5zw==
X-Forwarded-Encrypted: i=1; AJvYcCXByDW6B5NDYyNMmS0sozim4f3kxjlc3E0F/hDv8uHLlykQu1VbnRaMMAFR302eIbTXXKIKQZTdil7R5g+2QnAolopJWpT2AhCKkeFI
X-Gm-Message-State: AOJu0YyMSmpq5kkMWD6/q5NR/r5bRp5fw2N0NFZsbRoH0bV9ig2+o5ha
	abhFZublA513LldEOygh14FLocwX1lGI9UwT+mP1/pI6nJ5AXo0/lO4v4dN/mDk=
X-Google-Smtp-Source: AGHT+IGTdkIuRQEy0jY4PTiYExRK3QqxMe0SAVoIPw3mJH1Zqc0JsGLFwwgxvxkPwCC5Ylk5LEfNcA==
X-Received: by 2002:a19:761a:0:b0:519:e878:9385 with SMTP id 2adb3069b0e04-5220fd7c7eemr1123427e87.18.1715323182260;
        Thu, 09 May 2024 23:39:42 -0700 (PDT)
Received: from localhost (2a02-a210-20ba-5a00-9ceb-707b-2d57-26f7.cable.dynamic.v6.ziggo.nl. [2a02:a210:20ba:5a00:9ceb:707b:2d57:26f7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d207sm150850766b.22.2024.05.09.23.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 23:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 May 2024 08:39:41 +0200
Message-Id: <D15RBIV5HF6S.2FFLSGU60X1UB@fairphone.com>
Subject: Re: [RFT PATCH v2 01/48] drm/panel: raydium-rm692e5: Stop tracking
 prepared
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Douglas Anderson" <dianders@chromium.org>,
 <dri-devel@lists.freedesktop.org>, "Maxime Ripard" <mripard@kernel.org>
Cc: "Linus Walleij" <linus.walleij@linaro.org>, "Chris Morgan"
 <macromorgan@hotmail.com>, "Yuran Pereira" <yuran.pereira@hotmail.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Konrad Dybcio"
 <konrad.dybcio@linaro.org>, "Daniel Vetter" <daniel@ffwll.ch>, "David
 Airlie" <airlied@gmail.com>, "Jessica Zhang" <quic_jesszhan@quicinc.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Sam Ravnborg"
 <sam@ravnborg.org>, "Thomas Zimmermann" <tzimmermann@suse.de>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240503213441.177109-1-dianders@chromium.org>
 <20240503143327.RFT.v2.1.I784238de4810658212a5786b219f128460562a37@changeid>
In-Reply-To: <20240503143327.RFT.v2.1.I784238de4810658212a5786b219f128460562a37@changeid>

On Fri May 3, 2024 at 11:32 PM CEST, Douglas Anderson wrote:
> As talked about in commit d2aacaf07395 ("drm/panel: Check for already
> prepared/enabled in drm_panel"), we want to remove needless code from
> panel drivers that was storing and double-checking the
> prepared/enabled state. Even if someone was relying on the
> double-check before, that double-check is now in the core and not
> needed in individual drivers.
>
> Cc: Luca Weiss <luca.weiss@fairphone.com>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Seems to match with the changes I did for another (generated) panel
driver I upstreamed - see also:
https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator/c=
ommit/74c104440dfd828aa94194fd279c0c505ab55854

Functionally also seems to be fine, I don't see any problems. Thanks!

Tested-by: Luca Weiss <luca.weiss@fairphone.com>

Regards
Luca

> ---
>
> Changes in v2:
> - New
>
>  drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c b/drivers/gpu/=
drm/panel/panel-raydium-rm692e5.c
> index a613ba5b816c..21d97f6b8a2f 100644
> --- a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
> @@ -23,7 +23,6 @@ struct rm692e5_panel {
>  	struct drm_dsc_config dsc;
>  	struct regulator_bulk_data supplies[3];
>  	struct gpio_desc *reset_gpio;
> -	bool prepared;
>  };
> =20
>  static inline struct rm692e5_panel *to_rm692e5_panel(struct drm_panel *p=
anel)
> @@ -171,9 +170,6 @@ static int rm692e5_prepare(struct drm_panel *panel)
>  	struct device *dev =3D &ctx->dsi->dev;
>  	int ret;
> =20
> -	if (ctx->prepared)
> -		return 0;
> -
>  	ret =3D regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies)=
;
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to enable regulators: %d\n", ret);
> @@ -213,8 +209,6 @@ static int rm692e5_prepare(struct drm_panel *panel)
> =20
>  	mipi_dsi_generic_write_seq(ctx->dsi, 0xfe, 0x00);
> =20
> -	ctx->prepared =3D true;
> -
>  	return 0;
>  }
> =20
> @@ -222,13 +216,9 @@ static int rm692e5_unprepare(struct drm_panel *panel=
)
>  {
>  	struct rm692e5_panel *ctx =3D to_rm692e5_panel(panel);
> =20
> -	if (!ctx->prepared)
> -		return 0;
> -
>  	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
>  	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> =20
> -	ctx->prepared =3D false;
>  	return 0;
>  }
> =20


