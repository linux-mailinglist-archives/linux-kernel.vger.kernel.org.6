Return-Path: <linux-kernel+bounces-550032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F3A55A3C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E0A16FF3D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C703E27CB33;
	Thu,  6 Mar 2025 22:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpvMlfrE"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F383206F22;
	Thu,  6 Mar 2025 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301753; cv=none; b=OA8+x9UBQz4nuPp1KYaEJUMzDtikUMo/cewT4Mn853Bux3Agp3sAmlCNAjJHhyW5pzlGgu8akMBZZIM7cQnB+sHjfjX9HP/PzKBZ2c9EMbdQ9xVbseCAv2a7sZU2PqxoaE9H6EDLxl4KrvIT1ywMTmxgqclM+0wGTxUqsj+RQto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301753; c=relaxed/simple;
	bh=a+MtALUVY91zVDdEmvlAj9f3BESzAhxgQRJBbEz3RJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNWuzt3Wap43In2wNQbJsk0362eR6WFWwtdI4nS4WpWHjTIL5KaTt7bgBHi0FE43xQJ58SF+m1bi3XqmKdEm6S15K8QASpB+gv2os/DFQyVaeE4+U+/cSAQ0k+NCpLNk3xhy4TmJz8HaZmVzrXFl1yq4dSRpZg+zXB6wXw8PN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpvMlfrE; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so1369392e87.3;
        Thu, 06 Mar 2025 14:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741301748; x=1741906548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm2qV+PayrFKZi2Qr9jDYU/KnrvQXtIuUzSZ0SYEFfA=;
        b=RpvMlfrEOR/qLi9vCfwbfE7onQMdygwkzTu2HfhIPvozm8m+OPNcnkqnGiw1c+kETz
         ubi0SvfY2FZsCpmDkL7UgbTe3+YALTI3KzvQm423qEraynzOHlM/fFrRZPYk5CSoBGw6
         /IRzGo/mc4zmXARZ8wzEklqp6pnrVOrihXHpWEeuCpZsa2gSmXr1rOrcqewp4UThu0Q+
         8ovTqx7VtxWADXqHjkNw5IkLtwta78be7a4tc0vG4dwZB1cygWzYcmeuJ3VKgFgNjtTy
         tvPHG0XfcdxT4F7HHIhuSmwAsIPwfZap9zxfBoq/8oY23ajRSHhDP8cpA0r2lOmegn7Y
         sYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741301748; x=1741906548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nm2qV+PayrFKZi2Qr9jDYU/KnrvQXtIuUzSZ0SYEFfA=;
        b=RtqTwLA7u5tm3LTnC7CXC55Q3m5qFm3wuwBA7jIceiwJ2Lmjm3ghMoovCAkObJ7aJf
         wV0H8QVIoXoOr9V2OnqcViEd5jjup6JCPg89ic6KPtmr2ArFiv3ofDMu9iwdll0GW/27
         7FOFgOm+ocT3hRhihxr67i+ULH2fa7vxA3UCeDYHpbM6SByzryBpUKgNiHO5Q/MMbgeG
         zN66CVafa7Rbt3SH5ccMamd9WyvfikGLcN8XaNv1ujpN/Mq3xHwUhZ6piN4TD3P4NCBv
         HQAPBkVVC1DDTGiUC5f/ILysIXR9RvGmFMHa5fResplrrFxNWvrFBgArY5SVDb173ARJ
         as5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFE7bjpS6QXF93wkAQcyhnWw8QpJB+MHJfQrtZr3pHRLfNpx0IB7MWTYCYI5A/D2ObVvfEAMMtHcqlfGSo@vger.kernel.org, AJvYcCXfsSnqvsYl3x5Js8x9x+g0zQ+Lj2jAazp+f0pOv2VtwxbjkfwM1lUjSkJXyrWOn4UzJijbDq5rtBs1@vger.kernel.org
X-Gm-Message-State: AOJu0YwqLvS1+MNU9qwsN3AmrMgpRrnRM2H3aJ9cvHLS7DybNj3sK4Ol
	KkL7C2yCdEvdpDsryQ/mF049mAS1HcVZRGyzccfCc15/OF4FefuwhnL+n6yOdJOZDjj4fHUDMMr
	BkDNm+9BYcyH+d6drTiWIQeJefyBqkzpS
X-Gm-Gg: ASbGncvogUv9/4tCauFT7/j/94RWc58uUUB072I1LjE86jDQYozOQIn/0k1/HcNtxQa
	OYKuGdzApxshBPX4Mw6JHWg42ToWLyjPd5nxdxmKPOe5zYvVR+8hk9ViAdGgReBbgfgsSez+sIR
	Jc4JtRseSIHihTHgGO62MOx+Lx802cmevo8gxABTMSGotrQ89Sy1SxGi31Jg==
X-Google-Smtp-Source: AGHT+IELLnqdwKJ1evQmnO6miMjCOF6kWpjNInySnrLYVu8W39JXHce4tfrcyF/HH/vVvtpBmKUXlY5IKpjWjhg+MpM=
X-Received: by 2002:a05:6512:1112:b0:549:4d7d:b61b with SMTP id
 2adb3069b0e04-54990eab0f1mr333594e87.35.1741301747365; Thu, 06 Mar 2025
 14:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306222359.797855-1-Frank.Li@nxp.com>
In-Reply-To: <20250306222359.797855-1-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 6 Mar 2025 19:55:36 -0300
X-Gm-Features: AQ5f1Jrc9-FFNpCeyDExi95YGo2Kn5IirxDCaG51gdscsys4mOsD1AzjUc9N6UE
Message-ID: <CAOMZO5CL-qQSHuSoCtb+f_mqNG8vu4tTVDi-ThoHq+m9SeagxA@mail.gmail.com>
Subject: Re: [PATCH] ARM64: dts: imx8mp-evk: add ecspi2 support
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

On Thu, Mar 6, 2025 at 7:24=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> +&ecspi2 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       num-cs =3D <1>;
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_ecspi2 &pinctrl_ecspi2_cs>;
> +       cs-gpios =3D <&gpio5 13 GPIO_ACTIVE_LOW>;
> +       status =3D "okay";
> +
> +       spidev1: spi@0 {
> +               compatible =3D "rohm,dh2228fv";

That's not a correct description of the hardware.

Conor's effort was to clean up the abuses of using "rohm,dh2228fv" to
get spidev support.

Please check:

fc28d1c1fe3b3 ("spi: spidev: add correct compatible for Rohm BH2228FV")

