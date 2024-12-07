Return-Path: <linux-kernel+bounces-436186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD639E823F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 22:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0DA1633BE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 21:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD26154BF5;
	Sat,  7 Dec 2024 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SI1C6Npk"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35758146A60
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733607091; cv=none; b=DUHtJOn6thcBHbcwQPUE5RHU3vkMNnVPChwzRkc/z6TzEy+as8QuH5kJUjYiBVMdYAkhrNtA+273WCPPoRBaWQEd9ZE59c1TlNEE/rGh0JBl1t6/ocAsFl+zNPyQv1HRyHf8MbtWOgcZdNwn1lMKIBZmdAKOPbGrUlp4U8rIs3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733607091; c=relaxed/simple;
	bh=DjeQFZwSMhqCtQ8nrVJXyzDK26ogxEag7xLAlAfoY5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jr4GrK4b1wMtkfvHycDf7LfhzOXQUTJTJEZIc2W0QNG0HHr+yLyg3TeIxturPgKU/99rb1nu1OJnrDOja4drDqrfK0Za6H7C5Vyl7jkujNzBJy2Oce+ItjbNl9alJpSPN9m2QVUR+HGBn8khLLEmLph1irnncmEl7Uj/tlivsc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SI1C6Npk; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f2af291e13so57286eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 13:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733607088; x=1734211888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfKGW0QrWsaa6qvorIS98f1mLt8WgB4RHKxY9T6NNQ0=;
        b=SI1C6NpkD+LU5+wh5+pkFBGAblR5BmjLldIzP6LmHMNS7c4dOOMkrinQsojR76TQxh
         VHbrrZUUlLtC6x1fxgTY2yDmgflAqtHctrEO8BhpbTiPKaM0O0r0KMIT5fsY8rhF0ELx
         Li0UeEE0kXFdHd6gpTtDIsTf8G1jQpfLDuqOYtq8eYvdwJJOJSArU1jpZTOzytN/Oacl
         OAFH9HfXTBr/xveAmsPD7kYLcBDLXNrjYCm4PUM6rOzUwwg2fQfEXh4xLvW6kNDzOal6
         1cnLJh9vcu3ywts6de/vAY7Y5pikJHiJxP+BEjqHHBfgRYFnLgV9Av6+B3CJtwSMQQyA
         WLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733607088; x=1734211888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfKGW0QrWsaa6qvorIS98f1mLt8WgB4RHKxY9T6NNQ0=;
        b=dSxupquIkaLGWtsU1rFA4YStokri5KlDl6pbbA/q1tbiQUcIjhmzlP5yonk3rlJYqG
         V2Z6OuPDng3irCIsWt9qvw9j5HMcIh6FE+NodlQ3szs0WofW20tg/hIBimFhAZ+CbWnJ
         QunI6K6CKKoHLcGQ2gy8gjgxwn776iodAqmpo1AD0Au8zEQSkDjECpD0XC+O58rKRUWJ
         ublDHphvRDEPMv59WDKABv0UJStPPbrFxVaBHJ55Qe2eJHPadAhZQ//j82/+IiesK1ER
         6AHvQHYMk+nLldSCKdEFjilcJOYFzxJO2UOduW6cEnlijrAMkseExbH4YJsLfGGfR+lY
         IOUA==
X-Forwarded-Encrypted: i=1; AJvYcCUfVZH1B5O0TKWRtH0SQYHv219Xt0zzFWJAGznLKgQSnj8jDf3bW3SldTuqXEzF0p7Wog6lK0yIvkJvrEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3hRVA5Dny16zU4e+u2v4DCXotMRryaAVHmse5xyBgAfBt4VLk
	HhpN9F5f4YI/EEyrCgth6OAg8RNv5b0CgjrnPSTCq0m54B4d3q8vtb/fzKKNzNN8Ax8cr4e3Fk7
	S2CBjcBnYm0+4RSxl5cKmx+l/9cIbxf4WtaDuXw==
X-Gm-Gg: ASbGncsgLyEEROeLArjvGSzF3Rj7pYOJ/nRB0tEfB2m8Su8TpB5RxkN6AqiUcBscDY7
	y5MUd4B8fk1u3DtZSaJQGGFAJk0tyf+8=
X-Google-Smtp-Source: AGHT+IHrxIKj+TInrHyVvrustF8TDSTRjzN9vK1a1fqIMmmjrvizhO/kVBzPl/ZHpL1kwxUVz6dUbaTqxj9Qq62lNHQ=
X-Received: by 2002:a4a:b604:0:b0:5eb:5eff:afbb with SMTP id
 006d021491bc7-5f27737f2a8mr7037701eaf.1.1733607088103; Sat, 07 Dec 2024
 13:31:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-gs101-phy-lanes-orientation-phy-v4-0-f5961268b149@linaro.org>
 <20241206-gs101-phy-lanes-orientation-phy-v4-6-f5961268b149@linaro.org>
In-Reply-To: <20241206-gs101-phy-lanes-orientation-phy-v4-6-f5961268b149@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Sat, 7 Dec 2024 21:31:17 +0000
Message-ID: <CADrjBPoZqbAM=2zOdgXD_dTrgh-J7yE+OX_JSVJ42Lmzb-DPEw@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] phy: exynos5-usbdrd: subscribe to orientation
 notifier if required
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Sam Protsenko <semen.protsenko@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	Roy Luo <royluo@google.com>, kernel-team@android.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

Firstly, thanks for all your work getting USB on Pixel 6 / gs101
working upstream :)

On Fri, 6 Dec 2024 at 16:31, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> gs101's SS phy needs to be configured differently based on the
> connector orientation, as the SS link can only be established if the
> mux is configured correctly.
>
> The code to handle programming of the mux is in place already, this commi=
t
> now adds the missing pieces to subscribe to the Type-C orientation
> switch event.
>
> Note that for this all to work we rely on the USB controller
> re-initialising us. It should invoke our .exit() upon cable unplug, and
> during cable plug we'll receive the orientation event after which we
> expect our .init() to be called.
>
> Above reinitialisation happens if the DWC3 controller can enter runtime
> suspend automatically. For the DWC3 driver, this is an opt-in:
>     echo auto > /sys/devices/.../11110000.usb/power/control
> Once done, things work as long as the UDC is not bound as otherwise it
> stays busy because it doesn't cancel / stop outstanding TRBs. For now
> we have to manually unbind the UDC in that case:
>      echo "" > sys/kernel/config/usb_gadget/.../UDC
>
> Note that if the orientation-switch property is missing from the DT,
> the code will behave as before this commit (meaning for gs101 it will
> work in SS mode in one orientation only). Other platforms are not
> affected either way.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org>

Notes on testing:

I tested this series with the corresponding DT using a Pixel 6 device
with 2 different USB hubs and also plugging directly into my laptop.
I've tried various combinations of plugging / unplugging from both
ends of the USB cable and changing cable orientation. With the latest
series the disconnect/reconnect always seems robustly detected and
Pixel is enumerated as a USB device by the host, adb connection to the
phone is possible even with the cable orientation changing between
disconnect/reconnect.

One thing I did notice during testing is that in one cable orientation
Pixel is detected as a `SuperSpeed USB device` by the host and in the
other cable orientation it is detected as a `high-speed USB device`.
Which suggests there is still a latent bug in the phy
re-configuration. Although I think it is fine to fix this
incrementally, as prior to this series the other cable orientation
didn't work at all.

I just tested my personal Pixel 6 running the downstream production
drivers, and that is detected as a `SuperSpeed USB device` in both
cable orientations.

Thanks,

Peter

