Return-Path: <linux-kernel+bounces-280525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C6694CBB0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82A97B21758
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE5518C341;
	Fri,  9 Aug 2024 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mrkp4qFw"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A41552EB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723190027; cv=none; b=TlKTgshWSGgWbRvulpCzVVZ3xKNKdBviABw3ETca4gSd0S9AaTpvKYqXzZEwT1L6VhynT7XvwUhGLJ0UORBs8PXN9ZK0SXvyYbgNa4uLLprC/i/w57eGL4278ACyCIuqDlZkjdsbqi+ddt+rAw84xIDlnLeKJ7tkJrT9J8O5TxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723190027; c=relaxed/simple;
	bh=mx9XvqN8gfoztx5g8Hg8p3zrShD585HpqTze7i/V9sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXYaAcN6RGVwwCB8j33uJz/ORriRzPVsNgH7tYsCBNcVVH0jiozKBWpq2lIsrhT5koD4uCsNchdeBa4t+8TFTxfiy4aTkor2z3OnP/sv2m0ar4Y5Mnt7JMdYEVjoyOgvGIwi89yjaYasQH3U+dMWkPDwaXlWCoVRs0tQhq4i2RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mrkp4qFw; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef2fbf1d14so27773901fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723190024; x=1723794824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOhlBCGx3wgliIklN4sJ6vIsr9hRttzR53fydIf4y5g=;
        b=Mrkp4qFww3AZ4zSJchDIw5ZpwDtzlW67B+O3ljI5133Czf3Uj6RZFFJ9AGlLmJ3ka9
         bmJhvC4wq8SMTCRVkDBaIypsUSn3eTk6OK9UIS5HKkOvXJWXB8XxUg+x+OzVsCulXQv4
         zPYD9SF+6SQjoekyLWxiTDZa26sXUywn7q7uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723190024; x=1723794824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOhlBCGx3wgliIklN4sJ6vIsr9hRttzR53fydIf4y5g=;
        b=Rayp3GxqZRAkVftUEECjs1zgXL7pdgwlr0cdFIIH9INqmB3A9eyT5IdzIFP7uoe4qk
         ch6zzS/L382ojffaNEn52ekwehBJhxpZzGskDwQsruew1wF/vt0yXfr1BEDGNSJUOK29
         vrIQzUqFKE28sVxleKo9r0+RHE4nZpsEmQs36MQhEZKg02gbX5aiVexueChKKUvbPnhr
         Hlz8Xs9skhKfMuJ/3gk84Xe0XvoJ8iauE+rOMLexjwz63cvRLArvXN3wA7Nr/wjz1DWH
         2HvmxQNlmjNx/1WSZ96fAYvNVeRBtC002DJCqDIbcLmZUBdX+FwCDlMOMztFzuFUQMCb
         D1rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMk3pCTKAr/OTHJ6Ghu44TuFxntkqSWBrLCDyB0SEPi9nUjGqjzX+Z4q35TsNSPvN9lA/i8oUQXVRJJAPA4ccPjzKk3FeDnQ3IThMJ
X-Gm-Message-State: AOJu0Yw37p51g25vVW+fuxqFo4/uRJdpLLCQ/g+lYhuTCZrybxFIA0y5
	mObLxrAyRWQvSrrE7c13sT1m/MY+bSIQWFwjunz5VQeClJQ2xn8esrqK+oQMdAcOhhk5NppIaiq
	z20PU1dobeG2e5/JXQzpBWUlRS0BpRkx1ZrCs
X-Google-Smtp-Source: AGHT+IH6ychLenqDgOvMBzDQh2JMkFFn21GgkZRTJgCiT8vrbwbMMfUcAwkW9CQQCIA8Bgb7QPT8OmlAiGtufGVI5DI=
X-Received: by 2002:a05:6512:3f05:b0:52f:cc9e:449d with SMTP id
 2adb3069b0e04-530e5d210abmr1449084e87.3.1723190023966; Fri, 09 Aug 2024
 00:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-kukui_trip-v1-1-6a73c8e0b79a@chromium.org>
In-Reply-To: <20240808-kukui_trip-v1-1-6a73c8e0b79a@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 9 Aug 2024 15:53:32 +0800
Message-ID: <CAGXv+5GgmRiqkZdQo--XciuEgAvyOiR+XYWO=dZWziZ-pJzPDQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8183-kukui: Add trip points to each thermal zone
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 5:09=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium.or=
g> wrote:
>
> Add trip points to the tboard1 and tboard2 thermal zones to ensure they
> are registered successfully.

The position of tboard_thermistor2 is different between end devices.
And both sensors are outside of the SoC. Having such a high trip point
probably doesn't help with keeping the device or user safe.

The SoC itself also has internal sensors which would be more suited for
this.

So I think it makes more sense to have the kernel not require trip points
for thermal zones, matching what the thermal binding says. I resurrected
an old patch for this [1].


ChenYu

[1] https://lore.kernel.org/linux-arm-kernel/20240809070822.2835371-1-wenst=
@chromium.org/

> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 26 ++++++++++++++++++++=
++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/=
boot/dts/mediatek/mt8183-kukui.dtsi
> index 6345e969efae..1593ea14f81f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -978,12 +978,38 @@ tboard1 {
>                 polling-delay =3D <1000>; /* milliseconds */
>                 polling-delay-passive =3D <0>; /* milliseconds */
>                 thermal-sensors =3D <&tboard_thermistor1>;
> +               trips {
> +                       tboard1_alert: trip-alert {
> +                               temperature =3D <85000>;
> +                               hysteresis =3D <2000>;
> +                               type =3D "passive";
> +                       };
> +
> +                       tboard1_crit: trip-crit {
> +                               temperature =3D <100000>;
> +                               hysteresis =3D <2000>;
> +                               type =3D "critical";
> +                       };
> +               };
>         };
>
>         tboard2 {
>                 polling-delay =3D <1000>; /* milliseconds */
>                 polling-delay-passive =3D <0>; /* milliseconds */
>                 thermal-sensors =3D <&tboard_thermistor2>;
> +               trips {
> +                       tboard2_alert: trip-alert {
> +                               temperature =3D <85000>;
> +                               hysteresis =3D <2000>;
> +                               type =3D "passive";
> +                       };
> +
> +                       tboard2_crit: trip-crit {
> +                               temperature =3D <100000>;
> +                               hysteresis =3D <2000>;
> +                               type =3D "critical";
> +                       };
> +               };
>         };
>  };
>
>
> ---
> base-commit: 21b136cc63d2a9ddd60d4699552b69c214b32964
> change-id: 20240801-kukui_trip-6625c0a54c50
>
> Best regards,
> --
> Hsin-Te Yuan <yuanhsinte@chromium.org>
>
>

