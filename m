Return-Path: <linux-kernel+bounces-532323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFE8A44B75
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2443B2AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C741DFD89;
	Tue, 25 Feb 2025 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPrVPcmo"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220C1DB153;
	Tue, 25 Feb 2025 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512369; cv=none; b=Gj1Bl6BY0keQ9uWF5KMptZ0ezAoS4BZKNeuqstS5dw2ua5pu5D9iAeS/Kn/z/pRUaWkc3ZPtCijch2OcOkehr7zJ80cLO0fN+/95rgZrDnDb/jsXLSM0cFmHJLFSgh8JXIrFUkjlee9zGdc6wVVm2GM9dGoKAYL1WL31YkGAvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512369; c=relaxed/simple;
	bh=Uwf7eWdavyjH5gGwV2VxH1xgmznfjmK4oAqMn+DVDPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3alpOJJjfYrZty6v8BlYbJ62snLTgamzNsG0Ha3DA5+5TCXa2u0JX5aisp3k1qEpb8S8shSE3nsz2BQWIxPi7LMXh3dQ+09SBz25h4++db2+IlmT75QF81gFcuhxUklCX4TK43sQ5miEYRtGMXxDZdFhbjbQtog7GhLyCQZq1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPrVPcmo; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30761be8fa8so65598081fa.2;
        Tue, 25 Feb 2025 11:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740512366; x=1741117166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRfwiNue6KLLPaOFrmVXrPuXrw6AneOIZ7brZ38AEvc=;
        b=PPrVPcmoDHd+tJEXEzLIrnjJb6hpOJUYqISlbyixWp7LSqlMpYDRolnz0znVdiMGM7
         44IIH5o0j6fauxyEjtkZkq3QLJxv+pconMI8wRJtOOwwBgJfmd8lvVV58EyClhlSH3aX
         rMNaE9YXuIeYm6r4glS6GyPaS1KQDJ/x3Q3QPFcwdxpmBvMsS5k23zCD+2N+F0htzMXq
         w33htTLOK6nxvYXaN28KbuyghjIzkHTGY7aKO8y54rzkMjxxzPboJLpRXHZ7F0vb/tqo
         md0cA3TKZKMhYACuZz+SMQ8Iv3W1oI03iX7G/zsFTjpLMr9oAn/GXSrfZWk8fRtmmKhM
         NtAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740512366; x=1741117166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRfwiNue6KLLPaOFrmVXrPuXrw6AneOIZ7brZ38AEvc=;
        b=OWyEvENLymybZaYYfQMzM6+4/YIHeLyPcytDmRjiUjZvMVKzaUj2dHBZsl+BgiDUyI
         9QtuIDhJND2/+2nzjfa3P4xjD9r1N9IB0taaScbCQAMQX89IxfliudHx7ylnucR1uREG
         XqxZOTYB8z8wODhb/hpz4VrZqJZfUA5coxWM52I2R1C7JdTR2qYFsvC7nqyC2KVQzkQK
         EU1zIxwMuDnhL1kjGmbdMPif4Xp0ndr5nJgHM57nWIi0C0vVGSZupAjGDEq3S99tjl7x
         41hfF4+/qr8GHZV3IuRsIZuGlALv4gs9mmQwdlziT4i0IDCM3+Ian5cKXQVYJgAGJHH1
         InNw==
X-Forwarded-Encrypted: i=1; AJvYcCV+6rUYRb+ntU+4W7dKdHK5r4Gt/JVrR7RXMmn62MYJwY/Q4tVvAxJFKQbjQtU0bPAcN/+HbLjP5o1R@vger.kernel.org, AJvYcCVCeVc8+cjOungK6QcJyBt8FLmoB/hy8kGIw95cSL2+2FjzJ5Y2/2Ws7GL5LI/+jLC0Ne5xeCwLGxsrYNJq@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGXDAYClnb55B1ZQjls1woejDkgy13s2zJpcN4cen+OcDnVNU
	04jMNY3wN+HEE/KDytBAjsgVBEx8Qu1tH52yO0XSxh4HbwGneZqgJzMwr45uI/ySzfUtjalu0ee
	ThWZ1M7OyZ950nE8aZmU8CThzN1M=
X-Gm-Gg: ASbGncsO7VU3MG2KNck399ikfOt+d11xJM5Eav7rN1/cwl6UB8KM6ciQ0YnNhrgpuXs
	P/bqLrrLYuw/jF+/BIwfaMNZrGwdpJ72+KgPUqv0cUFWlIaByMWW2OLNwCr1BUkADHGns/VXhPP
	FS8YOtInXdh/D2McTNRcIVhmNL/BP/d06S9/BRt2c=
X-Google-Smtp-Source: AGHT+IEKk084A4djpTZdcYmY7yRIuhYdq72PxE8lKK7wocMcZos7nA2xNjrdx5Wn+I+t1aoqdI5qFo8Lb0jS8y7rkGo=
X-Received: by 2002:a05:6512:158c:b0:545:169b:9b51 with SMTP id
 2adb3069b0e04-548510dba17mr3031808e87.24.1740512366062; Tue, 25 Feb 2025
 11:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225192557.2914684-1-Frank.Li@nxp.com>
In-Reply-To: <20250225192557.2914684-1-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 25 Feb 2025 16:39:14 -0300
X-Gm-Features: AWEUYZkycYP4AmimIz7AT7PNtXzinXlNotQzIz-bQOQJJOzcBgdenJ2hhbqyzlA
Message-ID: <CAOMZO5AFy288CEeZLhbDvpL=_ETnFt2sAYnJH_VbiXzGe5UiQw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] arm64: dts: imx93: Add the 'fsl,ext-reset-output'
 property for wdog3
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 4:26=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -692,6 +692,7 @@ wdog3: watchdog@42490000 {
>                                 interrupts =3D <GIC_SPI 79 IRQ_TYPE_LEVEL=
_HIGH>;
>                                 clocks =3D <&clk IMX93_CLK_WDOG3_GATE>;
>                                 timeout-sec =3D <40>;
> +                               fsl,ext-reset-output;

This property depends on the board design.

It should be placed in the board dts file, not the SoC dtsi.

