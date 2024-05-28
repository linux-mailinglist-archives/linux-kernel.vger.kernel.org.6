Return-Path: <linux-kernel+bounces-192032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BDF8D1785
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A42A1F2278E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41BA157E61;
	Tue, 28 May 2024 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilWsZKND"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613DF17E8F4;
	Tue, 28 May 2024 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889770; cv=none; b=Xj/QTW0RS/0wxH0N0Tuo2FHVV2QR9wqC9p1hxThZYooyKknU5zWyAWMn7M3wUTfzjFNM+G+/BbDaspsXpT5+CjD5Nx4ftlc9Oy1AHQ+ThbFoRZ3RLUKc3R156i5XJG63kj5KcFBnnoib1673uLldwGf0wp/0V6mJy9fpxr2VUd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889770; c=relaxed/simple;
	bh=Rlym6Q0gKtJUNT3qD8ad70TIJk9A9o9+AqBoVN1qd/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxH7mz87bdm88VT+qKjaBBe6/hwVM3+l72DhQyPqOBE1BYDebHBZeK7pDEoVyqsEGuxKMPI4AKPaBhagmDWas+CL22X23qyp04MXlYNs7V0o604dBEhFOXPPcqHcTNawxnvFJNSOQU10IGrLghYlQ59ojSDwwYo2G2HhOchlwBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilWsZKND; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5785eab8d5dso682886a12.3;
        Tue, 28 May 2024 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716889767; x=1717494567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rlym6Q0gKtJUNT3qD8ad70TIJk9A9o9+AqBoVN1qd/U=;
        b=ilWsZKNDsRwvadbIpLAEdi3G/c56tAAGE9FuGYDBkbqsQTR1amTA5G7eipaNbto175
         YQkJsFNC+ybFJOSR9IM8yhwi8WUoT+NxYCIYH0TgtSmd1IRSpnN31DLHJc71DBAxGrOX
         Oybb/qE/hRLZ+RuLfj8mIV6+cXIFmR6IQK6L7RBuvFnTpMsWJKa98AF+UthcnsF+95sA
         Wux/O6YIeiAE13YcqEZMKotM2rK21YHbplMXfQd2XnQ7pMuK8zMAN96IL2jCRSYVM2ww
         jLhMmnE7EQvRy0A29PDcd2qUo5AUanhCfQPFA0fERYrTaKbMJvgiBbPJWENuMzK07tOf
         PFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716889767; x=1717494567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rlym6Q0gKtJUNT3qD8ad70TIJk9A9o9+AqBoVN1qd/U=;
        b=tzM7bJZu5BYiXOPtuNho1mNXbuQiodJYNMrAMZdu+k/oJkyLHX6AIZ0b6VS+Wg73W3
         aEu9/8R5OXoIXipMNtQQBjPGta84uU63dd71ktYaGg6o9n3th1jsaEJvLvUb8AUBnbJd
         C5etflDzxOfhcPQLlQLehbAZF7AAji3R82whfvEmwH8GC/jPvWPiChnnm4CtfDfNTGsh
         wBEOcQCVI8JBGrxcM7edLYUPG0u8qeLs0VPJ9CB63lb8uyD8mva8a6rEZxN1ujFWkxxn
         cSL5dyMl285Xy9CUq5wO6W+Jem9Dr6Wbies+zDxnwBjkT335Je4AQMgUyo+VZ7/8m9yz
         bocw==
X-Forwarded-Encrypted: i=1; AJvYcCWiudpATn0t/zaYEBuBYZ6s32fyu3ZGYQ5eKCV41r+/b4KFwYn3F6yYz7+TUUY8nOsq9+6XL2j5cRH8ljLSPCFYh/42X8Ubr3PTVMyaFv6aRhfkavxZLU0KwJKPeV14Ew7m9u2Zbk8JHw==
X-Gm-Message-State: AOJu0YxSy1BZOWr03tcuPlR5SU1801mQwMzgoGADUmy9BlcSMSNng4kU
	2htYAOtG++ohirKbrRbDdcxCrmNDqxB5vAWrOZklBVrNGdm8p6t2a6QUcR2FhlLV5O9eDUN7O+8
	awqvJff2wn+XquGqVqk6ANBbZbMI=
X-Google-Smtp-Source: AGHT+IF7pAr69yU9svC5bxzRerXV6L0MMij/GAhNmLknMPb4ry9esEuNqtCjPCeo8caW65iqoT4OE/AkoA2A6fWPgb4=
X-Received: by 2002:a17:906:1c0b:b0:a63:3488:c973 with SMTP id
 a640c23a62f3a-a63348902c7mr120702266b.73.1716889766525; Tue, 28 May 2024
 02:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
In-Reply-To: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Tue, 28 May 2024 13:49:14 +0400
Message-ID: <CABjd4YyuDsWGbSfNyqcW3s=59p8adVf5Js79PYyKFqfyM71dxA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] RK3588 and Rock 5B dts additions: thermal, OPP and fan
To: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Dragan Simic <dsimic@manjaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Diederik de Haas <didi.debian@cknow.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 1:37=E2=80=AFPM Alexey Charkov <alchark@gmail.com> w=
rote:
>
> This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
> active cooling on Radxa Rock 5B via the provided PWM fan.
>
> Some RK3588 boards use separate regulators to supply CPUs and their
> respective memory interfaces, so this is handled by coupling those
> regulators in affected boards' device trees to ensure that their
> voltage is adjusted in step.
>
> This also enables the built-in thermal sensor (TSADC) for all boards
> that don't currently have it enabled, using the default CRU based
> emergency thermal reset. This default configuration only uses on-SoC
> devices and doesn't rely on any external wiring, thus it should work
> for all devices (tested only on Rock 5B though).
>
> The boards that have TSADC_SHUT signal wired to the PMIC reset line
> can choose to override the default reset logic in favour of GPIO
> driven (PMIC assisted) reset, but in my testing it didn't work on
> Radxa Rock 5B - maybe I'm reading the schematic wrong and it doesn't
> support PMIC assisted reset after all.
>
> Fan control on Rock 5B has been split into two intervals: let it spin
> at the minimum cooling state between 55C and 65C, and then accelerate
> if the system crosses the 65C mark - thanks to Dragan for suggesting.
> This lets some cooling setups with beefier heatsinks and/or larger
> fan fins to stay in the quietest non-zero fan state while still
> gaining potential benefits from the airflow it generates, and
> possibly avoiding noisy speeds altogether for some workloads.
>
> OPPs help actually scale CPU frequencies up and down for both cooling
> and performance - tested on Rock 5B under varied loads. I've dropped
> those OPPs that cause frequency reductions without accompanying decrease
> in CPU voltage, as they don't seem to be adding much benefit in day to
> day use, while the kernel log gets a number of "OPP is inefficient" lines=
.
>
> Note that this submission doesn't touch the SRAM read margin updates or
> the OPP calibration based on silicon quality which the downstream driver
> does and which were mentioned in [1]. It works as it is (also confirmed b=
y
> Sebastian in his follow-up message [2]), and it is stable in my testing o=
n
> Rock 5B, so it sounds better to merge a simple version first and then
> extend when/if required.
>
> [1] https://lore.kernel.org/linux-rockchip/CABjd4YzTL=3D5S7cS8ACNAYVa730W=
A3iGd5L_wP1Vn9=3Df83RCORA@mail.gmail.com/
> [2] https://lore.kernel.org/linux-rockchip/pkyne4g2cln27dcdu3jm7bqdqpmd2k=
wkbguiolmozntjuiajrb@gvq4nupzna4o/
>
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---

Hi Heiko,

Do you think this can be merged for 6.11? Looks like there hasn't been
any new feedback in a while, and it would be good to have frequency
scaling in place for RK3588.

Please let me know if you have any reservations or if we need any
broader discussion.

Thanks a lot,
Alexey

