Return-Path: <linux-kernel+bounces-207137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BEF9012CA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 18:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C252824A3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC317B500;
	Sat,  8 Jun 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWzPn86l"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6434158A1F;
	Sat,  8 Jun 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717864695; cv=none; b=R8YD2VB4I0g/Un5M3ICc675osHWpQm2W/yi+yQmiPkjHCDo0j6RQXnReY/4d/R6SDoa67grxrO2yOxUtLS1MZoO5EnDsE/SvdV3wkzXxOcOPfNrB+db5+FAdC3wMXqxNk9cBTDQf2Bc7z8JlTMBY2gIXpfzF13G/tw5UEatnIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717864695; c=relaxed/simple;
	bh=lavqlrHogwUC9mmcwJckb+cT8mAaADZdVbxJ/+8gRqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZuftdQ+TrY6YaeZ3uxFheQtSXv2dMD+yPXjy8F5KZ6Vd2vXEqALCEGc9KUA78DnK3nQLEmo0KjiIYpTgARxq+x9Sx0SPXq7FyCRUMesiB3K75mgJbrpYQX9CrDnlIuGmvmsqK34bmh2NDthO/9xRbwtXhBftLrOKE4v4dpENuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWzPn86l; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c1b39ba2afso452461a91.2;
        Sat, 08 Jun 2024 09:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717864693; x=1718469493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFLGmunAqvogS4M4bBRmmOM2b1Zn9U568WT3k8G7wyI=;
        b=dWzPn86llBqyE8zYrF61iUQymHsTULCuuB0q1P3siTGiL6JMJ7WE+SCSGjrIjrHtZc
         HFEaoOHfOXKdzubxhUp8QZy+AbXpdBOIHjcR0Ogo4sTWIiyyUN3wsetqQjyHkFCrl8G7
         xfyTiNfA1pGI2jxVXIpJv4WksotPZFHaGeqTD1sexufkObOYOZC02abc522jEf0ApJuf
         uuIhtQ9p3hopvOIgI2M7Bvk0i4SWZmllPTBXn4gcxIZOBP2y0mXW/JxahRGYKkpofyD3
         eV8n9+RSOgi39cHxYhfPinvfmt9fgAFx5zDnQj2YDkqBiybz1lx7wmUiT1dyaCoNyqE3
         ziiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717864693; x=1718469493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFLGmunAqvogS4M4bBRmmOM2b1Zn9U568WT3k8G7wyI=;
        b=enuIESYQlh0cghFaUyELoDyyp8X1yiZ3FFSBJ6uuqqP3aluUIUo0D0t5Aq7ygjkYEg
         AzAnYF9PvYXnjZ/SiBcS+gu4bi3xaPYoWu0vujmhgLi8RUCAzh+zOFd4naBUNi7ioN0g
         WvtH+38rqsyWiRDbgRRtSOIjx0bks0mO8lXjVD+bq2av8kAV9ZsormfNyrvvo1U30kBi
         7wxN5CLqNqFjbL7EkUuTNv328egH8oGmjf1DXHVySivEaS5yprX8nJ4oqKpALIOxCHFk
         WZq4e/Zo/w6kAxRCAqIKtxCLTv4GyI/2lVHpfQ6nofeRCC4JCQI6R1yJd7mobCq2J1Sb
         rnEA==
X-Forwarded-Encrypted: i=1; AJvYcCWDylFzeGdAYh9SEsclFjUXnPp4qkYl6DRTeefiqZIl/W+gL/y5y8NdLm7WKKFKmLf/parF8+gnqTBXgd9NDxnrKRZPIY/haRDbI64gWacBl8KsIj/XSCsRwzkBPZeD4uU27Qedpt0vfA==
X-Gm-Message-State: AOJu0Yw3zK1Wxht4s+Jteo0f7W730ARmBPC6nUoO/fBwckORNXM1NdMo
	HzEESmskrgTU83TWBkIIzfazqYN2Ov2C74Y1yCaq9gIGo7f3DOdZQIQucBLzQm5p87yNbT7ORpy
	InxfyP6HRbYgqrf416TmFHqBiAaY=
X-Google-Smtp-Source: AGHT+IE2ziVnC1MC1kTN0mv56FYXjqtcSrVL6RMmoiz89YlFDp70YXWA2nD7FwvijH4AQBDt/5JXZYdR8kCY0SsMays=
X-Received: by 2002:a17:90a:4591:b0:2bf:eddc:590b with SMTP id
 98e67ed59e1d1-2c2bcad64d2mr5285074a91.1.1717864693008; Sat, 08 Jun 2024
 09:38:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605094812.1074027-1-peng.fan@oss.nxp.com> <20240605094812.1074027-2-peng.fan@oss.nxp.com>
In-Reply-To: <20240605094812.1074027-2-peng.fan@oss.nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 8 Jun 2024 13:38:01 -0300
Message-ID: <CAOMZO5DJ0oeOmm-PpDMpGwXfsjcm8ju6+EzpG6f9BxH4okLFxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: freescale: Support i.MX93 9x9 Quick Start Board
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 6:39=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:

> +&usdhc2 {
> +       pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +       pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +       pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +       cd-gpios =3D <&gpio3 0 GPIO_ACTIVE_LOW>;
> +       vmmc-supply =3D <&reg_usdhc2_vmmc>;
> +       bus-width =3D <4>;
> +       status =3D "okay";
> +       no-sdio;
> +       no-mmc;

Please remove 'no-sdio'.

On the imx93-11x11-evk, this property prevented me from connecting a
CMP9010 board into the usdhc2 slot:

https://lore.kernel.org/linux-arm-kernel/20240529034854.1595664-1-festevam@=
gmail.com/

