Return-Path: <linux-kernel+bounces-348237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B220B98E470
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48731C2308B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADDE21731C;
	Wed,  2 Oct 2024 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUWRxZh3"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E58F40;
	Wed,  2 Oct 2024 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902321; cv=none; b=NnloApG0vTPRoBL1RXHCd2IQzoQTKeY11tC5/voFMzdP3JNLtN/74SpA71V6ogXdcqMDrQjrJuQd0Jol7DjtHQInAMYYcsAIjWP2avWOLYj3M0Mduc7xZXhkYrherJ7qpn/0pjB0nOXxJUgr7MzPxdMzpVIKwDCP73rlRUv5/+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902321; c=relaxed/simple;
	bh=VEHAyZoQjBPuXBaQnp3bkKS9a1uzzrtwU6torraHTtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JowuC9l+HoMtUq8u0gH7e8jEUGrqEwPxUkV8GMciLV4XEIrdJlwlVPJ3vU7xYnPGM1S0JxSzEBaFNFToxc6J4CaNtQ/DOpoKTdnoJVJEWnduZFf+7pEKN0EdmIz8Fy/EatP1YtXAbtKzsrdrUWopsiy7BNnpGzilv7dfJBeaP4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUWRxZh3; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fac47f0b1aso3039171fa.1;
        Wed, 02 Oct 2024 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727902318; x=1728507118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKTTMLpVNU1rbwFfrmI7lnoXgbZiPVbY+NtY+gwrero=;
        b=JUWRxZh3fisEez6X44SvT1/LG5NjAgsT2YZku/ozbLKHIKMpyKopIeTA0xhhRnRHyl
         QX6YYIaQYDznijXnaAmdjuMtIpjesAPii5cX40sUFmShQVZMeE/FCdSE4gSRXzb7+7AX
         Q7t6oWMhfSjQU4x1ss9AKCliaV+3KjmC3xJyB58sU0mHJ/wZc9s+5kF2SWu+DmGJYMif
         IrstpHfXLU5/x4NbUmIElpYdmvmefnuXXOZa3MZh7jsLAiD6h3yS+s1k2MP5djOqgXul
         YhpsEDMm/0AVbjKscY56/XSvHfMF/OWJNRp4jCZh4zTvYS32TW+/RixzXyi9NcUZ0nvb
         SlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727902318; x=1728507118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKTTMLpVNU1rbwFfrmI7lnoXgbZiPVbY+NtY+gwrero=;
        b=aS42Irrt4uVkpy6NApE7R3UTW7UaGcVB9U7cedsbKUd7YJpXhjngtHb/30dWLhtWAl
         tsOL/O9lldtuLF7W4RSSpLoPfdnXzbCJvN5Bk4jkyCEJVQvWu3UD9A7KXvvIIF0nYoiL
         dWS0RFKOjeiI/F2dMDPfUUEDV2dVdW8WoD2i5RlGZ7xOCmx5ZiuB5SkBiDQDvunCdI77
         YwVkGwPzI710nystzjjdNZ3j1+B2uTVlqBN4RPt2CA5CVWz/4cOwHlLSTbZXth7Kwhmw
         fSNBBcmR3jr78bB0cj7DuXN125El144czVjRg933gxUHUVvLPiQJ1MLBjl4WajpKccGv
         1gVw==
X-Forwarded-Encrypted: i=1; AJvYcCWy/7xuvImS+7ChqN0bj+CTVh0I/J/z1kSwTRyf5gpG4fO69N8SttOoESwRUKvC2O+m8B3H6JxC9l8c@vger.kernel.org, AJvYcCXYnz9cjECnfGOPWHZF5GDUZWKv6EgD0PHHawQM/lYRC4B2j7TqGmm4EOL23R/G6zdiXVcpOqIPsD90NDOa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9t2eo7GA/nkE56E9/goss9wqvKbn0fwBxjKcw8Ngah1ZVEPBS
	40r+7/ak3efJ0gYYmMGM0spm1jVtFAlhCHGxSXQfAjTwVuGeeZ930px5F9uu2BGRDzcO6OV1thU
	JEqnVmGkU9UGfTjr7KoI9ygdbse0=
X-Google-Smtp-Source: AGHT+IGkBg1h2s8kkcXTyEZggePG6zCcw11Akl1BW7tIzxgdK/KH0WZ3KEBjraWlRZDcrGpcbllxYF4a0zGGCXXfq1c=
X-Received: by 2002:a05:6512:3084:b0:537:a745:3e with SMTP id
 2adb3069b0e04-539a0795be3mr2627745e87.45.1727902317426; Wed, 02 Oct 2024
 13:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002204750.597337-1-Frank.Li@nxp.com> <20241002204750.597337-4-Frank.Li@nxp.com>
In-Reply-To: <20241002204750.597337-4-Frank.Li@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 2 Oct 2024 17:51:45 -0300
Message-ID: <CAOMZO5B+nGngoonBm4gzFXtKy_DR7SPNs1GQYSeOu8emcsRgyQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: imx8qm-mek: Add PCIe and sata
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

On Wed, Oct 2, 2024 at 5:48=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:

> +&pciea{

Missing space: &pciea {

> +       phys =3D <&hsio_phy 0 PHY_TYPE_PCIE 0>;
> +       phy-names =3D "pcie-phy";
> +       pinctrl-0 =3D <&pinctrl_pciea>;
> +       pinctrl-names =3D "default";
> +       reset-gpio =3D <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
> +       vpcie-supply =3D <&reg_pciea>;
> +       status =3D "okay";
> +};
> +
> +&pcieb{

Same here.

