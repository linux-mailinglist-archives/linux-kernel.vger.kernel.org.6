Return-Path: <linux-kernel+bounces-180371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ACA8C6D9B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2351C22167
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0AA15B548;
	Wed, 15 May 2024 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BqU3h4uQ"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481AA15B12D
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807615; cv=none; b=KjB+7wbDRvCWXYwdkFYEkAKFOpWlTckGfLyqku8RTj2TRqgEgzYGuC0hTWkpfb1xOjn6JFqrOSRwZQDn/d/C35QIdsLdxu17bC0pgQdpetsEgU7JopLQ/YC8jHzC2QNeNL+TXWOkE4XqxpU9mzNJV6NP09iidXc4ywQiBVE4Aeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807615; c=relaxed/simple;
	bh=bvwKe2cUxIwA3wbANMobFmrdn8i2fePiVArTt8lKlnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTLsxnjIoobzy9yreAfOmraxWDh5Zf35I/PE/PbnYCXa71Pl0OpAno5xO1FnUVmLPg+pu5G0nD6Iwdokxvx8iQqbJD9r/t4VOukAjn+zV6fvPf6/7lA9u592g5t9MazXwaZhlj+isXA3vL/4w2jR91qn4H2InIdzpgo7h3d1FaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BqU3h4uQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-792c34f891eso614111885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715807612; x=1716412412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=renabCQBjnKbuD0E1htsmVXRz+sXl0GAkDLoNZkXQSo=;
        b=BqU3h4uQUcMp7mU+/HUaLUJhTHSOrxKffjTTNZWmby/97JEgGd3KcYEUf9JqchswiI
         ZSe18XLH0AIO8hSvbETH5Z/a2u72c+MNbKdorHHVXW0x35A5SosGDHKbH/KD41o8ZUkK
         4rEG/E/OYAZqQAgTXKBeKC72oGma0mqSyQp5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715807612; x=1716412412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=renabCQBjnKbuD0E1htsmVXRz+sXl0GAkDLoNZkXQSo=;
        b=QrqTsESm6MBtNbOikxHxniwTEP70M3hodnKafr0b2mKcsoqdGRi7A9IaThcoyYY8ZD
         J68sI7p+4o50VieMOifnSR7jqHvoopCY3LOpU9djmOaksZYKbL/0zE50QZFbvifHqqMF
         Yk9kzs56A9O9DwiIhpBJeOCL2/irzs3Lu5f5WoinW0i4WK5jtQrPV9Uz1YGgdOHyl+Ys
         Luxs37NEsoH0SB0jB0Lgq/iCXlycpgwSO+GjKQgb8Yu7gktwrkIr/1s/oFmlikct6cze
         mUtuVhiF4C1BR2lGBCpaykDKk1prfwXmkHv2isHKbdG26ZmsvXACnAdjfpPkAhXASmD2
         GzYA==
X-Forwarded-Encrypted: i=1; AJvYcCXFBGymK4MNaKbLRoKFdfIUfuZtbNm8bDnROnwvomqGWaHDRgLQnwfFwLWxhlb/coPqh0674LWm8lF4hjqZWN8u2vNPxz/vbVtppbwi
X-Gm-Message-State: AOJu0YxFuG7ru6Fi80Yx+WJOMIKcfwDiI6tJedNU5NfWbFYk3s45veQK
	do/4AiTG3jl+d1vhufnKa3OdadzQlg/CPCDV4FrSSt3AsvpmAtDhZtiipk6uhq+rv0QJcRlRWZo
	=
X-Google-Smtp-Source: AGHT+IFJ6QMn8YAWMfwQLAgcXHLi2IJ7gcsgNPogIy3JVQ8f+zJBcbonR1lMSW0NT7AOti9MmvilqA==
X-Received: by 2002:a05:620a:2a0e:b0:792:e8c4:414 with SMTP id af79cd13be357-792e8c4065fmr1121106285a.26.1715807612015;
        Wed, 15 May 2024 14:13:32 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792ed076f98sm219808385a.119.2024.05.15.14.13.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 14:13:31 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43df9ac3ebcso2215441cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:13:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3YIpeTWf5gE5sQeUrNgofTW9bQta7lOgr6lP4/Hwq2jgwZaihm3+P5k52ZUpSQKmHg1ny2xyWDB9HFln7KRh9tp6yYO65LOEN3SX5
X-Received: by 2002:a05:622a:58c3:b0:43e:3ac1:c80 with SMTP id
 d75a77b69052e-43e3ac11131mr1505941cf.18.1715807608625; Wed, 15 May 2024
 14:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515014643.2715010-1-yangcong5@huaqin.corp-partner.google.com>
 <20240515014643.2715010-3-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240515014643.2715010-3-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 15 May 2024 14:13:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wqiw2gi8MNnsYZkmM7H5XK1PUtxH-wqhbC-3m7Z0ur+g@mail.gmail.com>
Message-ID: <CAD=FV=Wqiw2gi8MNnsYZkmM7H5XK1PUtxH-wqhbC-3m7Z0ur+g@mail.gmail.com>
Subject: Re: [v7 2/7] drm/panel: himax-hx83102: Break out as separate driver
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 14, 2024 at 6:47=E2=80=AFPM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> +static int hx83102_prepare(struct drm_panel *panel)
> +{
> +       struct hx83102 *ctx =3D panel_to_hx83102(panel);
> +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> +       struct device *dev =3D &dsi->dev;
> +       int ret;
> +
> +       gpiod_set_value(ctx->enable_gpio, 0);
> +       usleep_range(1000, 1500);
> +
> +       ret =3D regulator_enable(ctx->pp1800);
> +       if (ret < 0)
> +               return ret;
> +
> +       usleep_range(3000, 5000);
> +
> +       ret =3D regulator_enable(ctx->avdd);
> +       if (ret < 0)
> +               goto poweroff1v8;
> +       ret =3D regulator_enable(ctx->avee);
> +       if (ret < 0)
> +               goto poweroffavdd;
> +
> +       usleep_range(10000, 11000);
> +
> +       mipi_dsi_dcs_nop(ctx->dsi);
> +       usleep_range(1000, 2000);
> +
> +       gpiod_set_value(ctx->enable_gpio, 1);
> +       usleep_range(1000, 2000);
> +       gpiod_set_value(ctx->enable_gpio, 0);
> +       usleep_range(1000, 2000);
> +       gpiod_set_value(ctx->enable_gpio, 1);
> +       usleep_range(6000, 10000);
> +
> +       ret =3D ctx->desc->init(ctx);
> +       if (ret < 0)
> +               goto poweroff;
> +
> +       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> +       if (ret) {
> +               dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
> +               return ret;
> +       }

The above "return ret" should be "goto poweroff". Please send a v8.

-Doug

