Return-Path: <linux-kernel+bounces-441800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60829ED430
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB8B188BB07
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20387204F79;
	Wed, 11 Dec 2024 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5IIFg55"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B259D202F8B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939737; cv=none; b=eUpeaneShaO05/jmoYnUAfc07n0vJvcg6xfc7B4ydXNCXieDrLyo1CQ1wsTAvdtTCiJSJepY7vvGNM40AiMcVZ9wSPgVFxcLn2Bu4Gf4MfJFkoswgQSRVA4BrDKkoeCQsgb4fMqJ1sIanSzW0zf9BuO/pFiRNtjZjMh8FRL58jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939737; c=relaxed/simple;
	bh=kDPd8U5uK5R4uekTRa3wapZvJ0AawT6vwbSHt7TAt+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7vlfjZ/KBk2X4w4eUBfuUdVeZ2QZ2IikRmupAQj+hZrB1TNuotS6ULVmQxPimaXxtPAGERUckjlVw4gRdFJmudaQ1PU6iSrp8IxyZbCO7CxstpU2gd8d/5aXneTViymj41kbDHjpUnV0q+EmWfoCOT4Obc0Ab6090MIV0Au2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l5IIFg55; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3eb4ac63dc2so1929067b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733939735; x=1734544535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NxV4GoHK/ahyIflRv/mOazvo62QwExn028Ncg5fkKE=;
        b=l5IIFg55BcHfsKZKMfFFC1xMkRFJlHPIzqDAy0AeLEKD/XacZuS06CGwGSMFFoOyNN
         NDCWoaNbAEOflz8e6IEoNhh5ryh3GBbswZvzGmsYC52N7YoRCTbco25zsMW6WWqEr9VO
         gfHjH8KSINNuT/SVVx4jGyMHq3BCPMOkEHPI353CQ0S5PotmBmhS1HbOspmC9dRwYBGB
         s1Ut/b4dGWhiv3DY1KqjG+cJW1APZ7X1CTr+TU5wkZb6pFWl2ubF9i5s/jr9snibtRd7
         BjG8sSg/qmTl5MKcAw7RZ56ZVTZeTT5dW8cfMwujOs9c2u23giLJ086sfocEgEMm9p0K
         B0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733939735; x=1734544535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NxV4GoHK/ahyIflRv/mOazvo62QwExn028Ncg5fkKE=;
        b=jG6rRN3nw9E0rQBmYZ0TafSZCbN+AuYh9lDN1IkhXtqzuu8I2FaPZyRPFeTGX/KOFn
         4QpKexQ+ky/tb2+TOyuUZxaO+uUaNHBxRImxsimNk6e++WafTi9TZ1mmXC10F7tf68ES
         4iwjfkc23dB0MpJ9C0UlwWFt+QJe3zQMNkArC7yOrz3IZ6VGYa6V7Tes2MydJDHRV08P
         YYx1TlgVlPldzX2pDokXuI5ir8FzM6ahel9lCOGPdryFTVC2X5yj3jl9YvX/W+RCprtg
         NmaXgByCAcjqsohZ96TGDIpNeJoqCDgL9hNOP53Jh9TO/mLPPrIPayN92Z/6yCuPX05R
         0nZw==
X-Forwarded-Encrypted: i=1; AJvYcCVilGUgZI79LTbuT8KrZm0HYe6buXOjy8Rer2H1oyiPNtdqOK5RZEQjvRWjoGU2LACu1rX2iO28T9E8vsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAVKgrdBYkngBjw9XCGQtrw7NHSLeF2qxf//MbTIgLdnrU867p
	ygepZxDP9rVvhBE8gI+NW9OSiLg+RvYYvDUFe26RJBoUcbQ+bFufeJuENCxYgP5IBtFqE6V7WgT
	Zfw/J7ORXs3p8bEuC0Mm2ltrTPgoADIPOnwgvOg==
X-Gm-Gg: ASbGncuDJD3hb1Wy3ZRcYSxI99Je7hFgi8t0yPeGU9jIMaOc79FbAwSxZT7vpQR7YzZ
	2sWX2QSny6npwLHfz2IesDapc5upJKRpmHHs=
X-Google-Smtp-Source: AGHT+IF4vtTjbxANqGCquCOW86vWqQwnJkVwBIy0+PKUY3mXo9+jIK2tbaAnXdNFAA6ijnfwpTtlzsC6XGNl2/h4Y9Q=
X-Received: by 2002:a05:6808:189c:b0:3e6:6097:847d with SMTP id
 5614622812f47-3eb85a8b199mr2732633b6e.7.1733939734907; Wed, 11 Dec 2024
 09:55:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206-gs101-phy-lanes-orientation-phy-v4-0-f5961268b149@linaro.org>
 <20241206-gs101-phy-lanes-orientation-phy-v4-6-f5961268b149@linaro.org> <CADrjBPoZqbAM=2zOdgXD_dTrgh-J7yE+OX_JSVJ42Lmzb-DPEw@mail.gmail.com>
In-Reply-To: <CADrjBPoZqbAM=2zOdgXD_dTrgh-J7yE+OX_JSVJ42Lmzb-DPEw@mail.gmail.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 11 Dec 2024 17:55:23 +0000
Message-ID: <CADrjBPpv7Y-v4w-ZjsM52wPXM1G=v028BxmJA=_zb4ksDq21EQ@mail.gmail.com>
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

On Sat, 7 Dec 2024 at 21:31, Peter Griffin <peter.griffin@linaro.org> wrote=
:
>
> Hi Andr=C3=A9,
>
> Firstly, thanks for all your work getting USB on Pixel 6 / gs101
> working upstream :)
>
> On Fri, 6 Dec 2024 at 16:31, Andr=C3=A9 Draszik <andre.draszik@linaro.org=
> wrote:
> >
> > gs101's SS phy needs to be configured differently based on the
> > connector orientation, as the SS link can only be established if the
> > mux is configured correctly.
> >
> > The code to handle programming of the mux is in place already, this com=
mit
> > now adds the missing pieces to subscribe to the Type-C orientation
> > switch event.
> >
> > Note that for this all to work we rely on the USB controller
> > re-initialising us. It should invoke our .exit() upon cable unplug, and
> > during cable plug we'll receive the orientation event after which we
> > expect our .init() to be called.
> >
> > Above reinitialisation happens if the DWC3 controller can enter runtime
> > suspend automatically. For the DWC3 driver, this is an opt-in:
> >     echo auto > /sys/devices/.../11110000.usb/power/control
> > Once done, things work as long as the UDC is not bound as otherwise it
> > stays busy because it doesn't cancel / stop outstanding TRBs. For now
> > we have to manually unbind the UDC in that case:
> >      echo "" > sys/kernel/config/usb_gadget/.../UDC
> >
> > Note that if the orientation-switch property is missing from the DT,
> > the code will behave as before this commit (meaning for gs101 it will
> > work in SS mode in one orientation only). Other platforms are not
> > affected either way.
> >
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> Tested-by: Peter Griffin <peter.griffin@linaro.org>
>
> Notes on testing:
>
> I tested this series with the corresponding DT using a Pixel 6 device
> with 2 different USB hubs and also plugging directly into my laptop.
> I've tried various combinations of plugging / unplugging from both
> ends of the USB cable and changing cable orientation. With the latest
> series the disconnect/reconnect always seems robustly detected and
> Pixel is enumerated as a USB device by the host, adb connection to the
> phone is possible even with the cable orientation changing between
> disconnect/reconnect.
>
> One thing I did notice during testing is that in one cable orientation
> Pixel is detected as a `SuperSpeed USB device` by the host and in the
> other cable orientation it is detected as a `high-speed USB device`.
> Which suggests there is still a latent bug in the phy
> re-configuration.

You can disregard this last point, I had a typo in my test setup :( I
just confirmed that it is detected as SuperSpeed in both orientations.

Thanks,

Peter

