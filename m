Return-Path: <linux-kernel+bounces-370610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836309A2FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4370E287AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343F02296C9;
	Thu, 17 Oct 2024 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TO1SviLc"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B660322911F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199778; cv=none; b=cFBPhl/IwkQJChnSnU+B8eC2Bo50odnRzcssg745ydokimiVStpeEwKwJgrPmKktEwhi+PvzqS1LYnCShwTN+zzDU4Yvi0CbOY7LuQ8XeE+UxmZEhPN+/a9K+KxxPFcHGBuHl+0O387mUvX0zWmcae2KDc1CKyW4PLJ2tjoqjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199778; c=relaxed/simple;
	bh=wQydXNcWdpTBzZQKKEPkKWCSlf0fQmLAmN+bYKHMIS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4BosHvzT9IhRkeolg3e1ricMb2Bi+PaZb887bBLbLNSOW4MhUspx/j/XwyumX26gGYKXZEAaO4td4wcFdi+DUXR4pFiu+wyQ48WFD4Q4mCQvp/RgWLErceU4wnJWbrNzHb5Y2tWtW0p2ub6lM238MapKuvE++HC6tk7Xxib4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TO1SviLc; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb443746b8so17370151fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729199771; x=1729804571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwSGZxm0nPOCcXElvwF4s1O3dQZtjR+E7hVy6q0TNNI=;
        b=TO1SviLcgaCyn572Jt3czEGN4aangahO2WHV1BU8jbjrnkdArZqNmEL+RibsBVmHBk
         Jay4PIgLmbA74g1hdUZ6nt4Wcl7LmnArFS+Ub4cS4oPp+MuX2svWjj5i5s4H/3cW61Ox
         AIoCxan+TdvglHspu+ZxCtx8kNYQ6196E6Nyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729199771; x=1729804571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwSGZxm0nPOCcXElvwF4s1O3dQZtjR+E7hVy6q0TNNI=;
        b=p0oqD2XJvKInfwtsuNDpwmnAN3bL5SSzwIsq1Ngi+ciop75OHf+3YKj+fyscP0bBlH
         uX8FDBie+q8uah9iTEhmSFWtxSNetb3qlY0bIhHNAFDqtkQ2FJtrrcf7OBQ9t4txF05T
         9TqqqzR6Bp/EJUhC3oy7xnQPHAfk9grINERE8l1XgVAPjysT4icwSTviTvO5NPLjX2gc
         3okCuCZGu50z2BKTqJOQGmZ7IEMgg4vh4fRYeW/e6GfhKZPqgR/+PVzVOMMLqKVT6haM
         pCx2r+th7unHd+x+tmUb5Q1evcp6/1wsjB0D81gJ9VfB30kA14T8dji9C52BJ87FMZKf
         B/LA==
X-Forwarded-Encrypted: i=1; AJvYcCXcNXf+UhXE/NjQcjA67SvQ775/F8ok2CtVFRR5pJC9slk+XAZLRpnKAhcpLC2Q3aSuhdfuQ7f4vYWnTf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJBzID5b0m25jcXerC4thVu/2ie74NGiZx9Y/tiK0ahlsBgwb
	mS2mD2HFWLrJWi0MQAG+ZYFnEAn2DThDB7opINy3NwHlL+bupk0OovP92c1SRXVlU6JUYk7k/9K
	e8uPA
X-Google-Smtp-Source: AGHT+IFWjyDBwx5CnWjJXe+gZZXWQ3xppl8mSmP1zN/yJuuO1y9qjK8CO3QHku5XqG0EUtPmkCBAYA==
X-Received: by 2002:a2e:6119:0:b0:2fa:fd41:24c1 with SMTP id 38308e7fff4ca-2fb61bdaf82mr41126881fa.45.1729199770086;
        Thu, 17 Oct 2024 14:16:10 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb809bae1dsm315821fa.64.2024.10.17.14.16.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 14:16:09 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so1418790e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:16:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0e7Rvvswu7//8n2hvJ6ziVpO4NFuDZNJNC8naTtbNAwHhmcc0Dk1HI16kpYxWckMfcNsodxAeXjUFMWg=@vger.kernel.org
X-Received: by 2002:a05:6512:308b:b0:539:f754:ae15 with SMTP id
 2adb3069b0e04-53a15445ebfmr181364e87.41.1729199768852; Thu, 17 Oct 2024
 14:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017094222.1014936-1-wenst@chromium.org> <20241017094222.1014936-8-wenst@chromium.org>
In-Reply-To: <20241017094222.1014936-8-wenst@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 17 Oct 2024 14:15:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X-YzEGEc+tp-uB6vdPMEC-V9M=Gb60H69=_XY9w4R8nw@mail.gmail.com>
Message-ID: <CAD=FV=X-YzEGEc+tp-uB6vdPMEC-V9M=Gb60H69=_XY9w4R8nw@mail.gmail.com>
Subject: Re: [PATCH v9 7/7] arm64: dts: mediatek: mt8173-elm-hana: Mark
 touchscreens and trackpads as fail
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

On Thu, Oct 17, 2024 at 2:42=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> Instead of having them all available, mark them all as "fail-needs-probe"
> and have the implementation try to probe which one is present.
>
> Also remove the shared resource workaround by moving the pinctrl entry
> for the trackpad interrupt line back into the individual trackpad nodes.

It could be worth noting in the description that it's a really bad
idea to pick this patch if you don't also have the patch
("platform/chrome: Introduce device tree hardware prober").


> @@ -35,6 +37,7 @@ touchscreen@40 {
>                 hid-descr-addr =3D <0x0001>;
>                 interrupt-parent =3D <&pio>;
>                 interrupts =3D <88 IRQ_TYPE_LEVEL_LOW>;
> +               status =3D "fail-needs-probe";

It's a little weird that there's no pinctrl definition for the
touchscreens but there is one for the trackpad, but that predates your
patch and is unlikely to be a big deal.

>         };
>  };
>
> @@ -47,6 +50,8 @@ &i2c4 {
>         trackpad2: trackpad@2c {
>                 compatible =3D "hid-over-i2c";
>                 interrupts-extended =3D <&pio 117 IRQ_TYPE_LEVEL_LOW>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&trackpad_irq>;
>                 reg =3D <0x2c>;

I should have noticed before, but officially the order above is
slightly off. According to:

https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

The "reg" property should be higher (right after compatible). It's not
a new problem with your patch but since you're inserting a new
property you might as well match the new dts style.


In any case, nothing is a huge deal.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

