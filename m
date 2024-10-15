Return-Path: <linux-kernel+bounces-366400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BABF399F4CA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA521C2254F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883361F76C6;
	Tue, 15 Oct 2024 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FNYIJMR6"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535FE1B3950
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015489; cv=none; b=Oh8S8VohRXdVimMgKAvhBqJd/wH6DHXDF114CebGZFugKp1E6ynXTp+AoO35GKbdWNUe8uTQPiRi6o9o1O+CUkTo+xLtfkxqcdJAqO3+B52/ixHvmuR2qiyh66DFHgvi0u3UBixJ5WS8GJPWrbzyJG3HW1pumURK1doLvGWa3lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015489; c=relaxed/simple;
	bh=8xSHcy2PuAPSvZBu9Eml4zzV7wYxfR0IjepjU1wiaRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V10y79KA6YQnqnn2tb47RLzJ5I878kuoLokabbedyRGOGZnFW+8ti4qxY4KbVwwkOvWkr/ME87MM2ETTNJ/OGQsR0vbdY+9S+39K4FSxeHbU9MDcAexTMCoP8b26bdB6ugP726ltdX1tagU9VqSygsS/mhl2yJqF2WQfW8kP1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FNYIJMR6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99f3a5a44cso388554166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729015485; x=1729620285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQgdud0CKtJUsCxMGehxz9oQ+EPp7xHVsXi0/0jf+Z0=;
        b=FNYIJMR6BRji9GCx0ubUTbltj4BnBPuyETOpy3kcxN+v1NSf75S+lYsSs8ycFOccVF
         8JtsOswR28IBEiykNawaoWZT0KgZmEkjyyFmdD3YcI1V/Ril45wDY/T5JLJDEXSQa/1H
         CqbeeM2qaw9GPki1GGhIiiVDgYfjWvrVvI2vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729015485; x=1729620285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQgdud0CKtJUsCxMGehxz9oQ+EPp7xHVsXi0/0jf+Z0=;
        b=QSKmj0Ys5p570jHiFtsqEOpov6xyugKOCKdQ+dn02GlDNBygwJYbDL7dc0Peyf3zL6
         LuRlpKau5OwZGNpI0u6Nf3UWCmwjMLM8f98IGPXlZQwmP5bTAvmYWFwONK+6qULuHDVI
         c9LGPdy7sL3RcxBf9fHJ7NW9u9ICqt16GhOI/8UlSGiVB3o4CoRkQhTP1iA+GngzLnnr
         zGiqp565YDEEwIyLaBdEJm1D7UxF4NCwJVT7fJkZ3EZIhJGpHDMhgirGTvtkQ2EW+SOE
         AlqJLQFU5lrl+PrAYy9Wyf/jSVy/ynnj9RvHZ9JRyI3mml7M8YJ9yaQqFTrchtRm1kcM
         wqxA==
X-Forwarded-Encrypted: i=1; AJvYcCUGROI/D1SfEG+PQycI0JXteb7n5bCCJbp1jIf/ss1pSv7/tmbS8QJQr4SAkTMoIpHG/4DarH6oHGSiLxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN9IEYOz7OLwbC5lx2RBVc2YNnypwYaQ8WAz9ev2jQDHwlLT0/
	mD05rusGsP5EUik7zvzbNlC/R4SYJTEruO9yvogxhUMz/kOalnehpXuwkJC1ecLP3wtmRsv70kz
	qxNr/
X-Google-Smtp-Source: AGHT+IF/iSjcVApUiOtaoy0/OAZ/w/DZS3bidlGj6RhrUeMlR7Z2fo6A0DQK1ZV5MChSXBYHxIqEPQ==
X-Received: by 2002:a17:907:e609:b0:a9a:1094:55de with SMTP id a640c23a62f3a-a9a34c7d7ddmr95154766b.13.1729015485299;
        Tue, 15 Oct 2024 11:04:45 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29817f00sm96311366b.126.2024.10.15.11.04.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 11:04:45 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43115b31366so52147255e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:04:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUl4/x7QPVlhnu2Ts2vH6i9Ou6Smtaq0Ax9TxgwXI8SZ/nK9R8NCERIzVJx4P0xJh6qZbWctujumjQ8jJQ=@vger.kernel.org
X-Received: by 2002:a05:6512:1091:b0:539:f13c:e5ce with SMTP id
 2adb3069b0e04-53a03f77ea6mr882102e87.46.1729015152112; Tue, 15 Oct 2024
 10:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008073430.3992087-1-wenst@chromium.org> <20241008073430.3992087-7-wenst@chromium.org>
In-Reply-To: <20241008073430.3992087-7-wenst@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 15 Oct 2024 10:58:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X+_iYi0_RSakh6bzVYuNpiqUvjHTrL81n8h4dO+WZf9g@mail.gmail.com>
Message-ID: <CAD=FV=X+_iYi0_RSakh6bzVYuNpiqUvjHTrL81n8h4dO+WZf9g@mail.gmail.com>
Subject: Re: [PATCH v8 6/8] i2c: of-prober: Add GPIO support to simple helpers
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 8, 2024 at 12:35=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> +static void i2c_of_probe_simple_disable_gpio(struct device *dev, struct =
i2c_of_probe_simple_ctx *ctx)
> +{
> +       if (!ctx->gpiod)
> +               return;
> +
> +       /* Ignore error if GPIO is not in output direction */
> +       gpiod_set_value(ctx->gpiod, !ctx->opts->gpio_assert_to_enable);

I'm not sure I understand the comment. Does disable() ever get called
when set() wasn't called beforehand? How could it not be in output
direction?


>  void i2c_of_probe_simple_cleanup(struct device *dev, void *data)
>  {
>         struct i2c_of_probe_simple_ctx *ctx =3D data;
>
> +       /* GPIO operations here are no-ops if a component was found and e=
nabled. */

Instead of the above, maybe:

GPIO operations here are no-ops if i2c_of_probe_simple_cleanup_early()
was called.


Just commenting nits, so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

