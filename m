Return-Path: <linux-kernel+bounces-347590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B4F98D64D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E7E284E4F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1211D0B93;
	Wed,  2 Oct 2024 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iR0ZuT4L"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4447E1D07A7
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876292; cv=none; b=lo/vAutk4A44oPwzRJ6OGlK2ldsnErqzBKGEZvRAx+ZQAT4e2/8YEiYs2HBZlzNLoIzK+ncPGBEfrMMZ1pIHYXZl2cK4WmaO2ogbzWJIhULYHMPcnTe7HyCRsrWeM2Kkp7WGin5CO3vkgoH3UFPtAetpbG7fmQYzubbpCpr+Gdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876292; c=relaxed/simple;
	bh=6yoNHjlamlraeMc3V59paBJJnLoyV3WYUfj3EmI8few=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDxw3ONxHS15fckE7/mylD6HLnbNMzbD4gL7o3HdCCMgBqA1Gt8O3o/4w0rvNE+CKCwQ4k2JL8EOGZ8zNr/c0p7/pmVSVV5jLXYEXdBUiztppS2lMephztEiGB8JUarotNtFp1Pl+BZsg1jxkCJc/jrPn2hKvZgHlX7nW9guQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iR0ZuT4L; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fadb636abaso19175231fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727876288; x=1728481088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gx7nBhp6lxVo1pa4k/APyedN4jV9Ivk3rAOgniXY4K8=;
        b=iR0ZuT4LiXoek1XHa2owLh8/4KOl1qtFt3LUZhzKt+0vjEg3s5tl4VCUIAVMU+AZOh
         jOmWBWffZva0DuB2qp2E7//vV+q2JDkkVTOEkHOnxWmqKcwR6kXRY4icPpw534LYQRUc
         Uzm/RSjCCHYwdrKmAFHTW3j8F96LNoe9hPCl1Xt8RTl/z5Aufr2Okzja33Z5xK7Djf+q
         N+xkN2WeduICSuSpqCJsF1FUoi433NSG+xh7RcIF8nGup63ml7dyxwVwYchJTtK0Ht9v
         FBfkrrgkicZU9Ao3PUDpeXBRVEfVRz4b6413mZDnkHhBfqfR36CHu5NVftHRxIgYK8/2
         08bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727876288; x=1728481088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gx7nBhp6lxVo1pa4k/APyedN4jV9Ivk3rAOgniXY4K8=;
        b=jaLkEj6fCXPV3p4eh79Btob2EV73iUAM3ajQ5pvh07DKfyOBm8aoubQXSV3IVjyY7e
         XDkjoeP8GpYub/BEgJN7XQaHxRcj5M/Suo8wBzP5ZJKaOUQ/vhp4pzZ2+bkCj0nj1nYU
         BOvmh/uF9FbfkyDBrrOmMxXBRetyGTAGfwG0ONuBlWD4Ae/qYuxJFtr3GbAN3cv7wm5p
         hmUoUBF41bYA6748Lsvo4m6BBjIs3/VZVZv1Rr2O604cPbLdGyDgC0w3Elvs0QkWlQiW
         XwJPZNoHgUKTR+qH3Fas89tg+b7WuDid9MPXoC+Sto79uQ88gkFPYbVoAGkPwkwd/Nef
         h5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXHSiSztdHPvzju5k9VLtePHBsuRvrvJwq8furEqipzhURRH70tptgUQRbXbTwECFUiO4nStXZQ1ZJqc6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+u90dhqfOan+XtC99hLQUtb9aDBKwKP371M5ZxlJc7aeYiCny
	wXDhEzLalkjReKYkt1yRJk/8qhtbWSj9Kz95kWOQ9KKGo3KjfErogez8RIZlgw9iPL3nW4bmKzU
	xKKdne02oQeVjC9w9ZyLSwGPAhPMJadJQGPG2Vg==
X-Google-Smtp-Source: AGHT+IFtOBtnoN0143aZXVWAwkEH+oTi/X5tyE2nQpsGUqONGRL4JsQwsp1UDaTLIqpdvcw8O3TsElrFgBjHjgxlEig=
X-Received: by 2002:a05:6512:308b:b0:539:93b2:1373 with SMTP id
 2adb3069b0e04-539a0662b0cmr2044174e87.20.1727876288279; Wed, 02 Oct 2024
 06:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202410020735.aBI61ZYn-lkp@intel.com> <Zv0S3wXOzgmyFP3x@google.com>
In-Reply-To: <Zv0S3wXOzgmyFP3x@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 15:37:56 +0200
Message-ID: <CACRpkdZmKfNWF7ciHJMi4JU+_JnxjWD_kMhfxFOeydQ11Vyc4Q@mail.gmail.com>
Subject: Re: drivers/input/touchscreen/cyttsp_i2c.c:47:18: error: implicit
 declaration of function 'i2c_transfer'
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 11:31=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> >    drivers/input/touchscreen/cyttsp_i2c.c:118:26: warning: 'cyttsp_i2c_=
driver' defined but not used [-Wunused-variable]
> >      118 | static struct i2c_driver cyttsp_i2c_driver =3D {
> >          |                          ^~~~~~~~~~~~~~~~~
> >    cc1: some warnings being treated as errors
> >
>
> This is really weird: cyttsp_i2c.h includes linux/i2c.h, it has
> dependency in Kconfig on I2C and CONFIG_I2C is present in the .config
> referenced above, so all the declarations should be there.

I usually ask Arnd about all kind of Kconfig business when
things get weird.

But could it be one of these awful things:

config TOUCHSCREEN_CYTTSP_I2C
        tristate "support I2C bus connection"
-        depends on TOUCHSCREEN_CYTTSP_CORE && I2C
+       depends on TOUCHSCREEN_CYTTSP_CORE && (I2C=3Dy ||
I2C=3DTOUCHSCREEN_CYTTSP_CORE)

Since I2C is tristate it could be a module and then this touchscreen
has to be a module too.

Yours,
Linus Walleij

