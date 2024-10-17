Return-Path: <linux-kernel+bounces-369435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FCA9A1D46
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B6DB21D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8D01D45FB;
	Thu, 17 Oct 2024 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="KgYZQfwu"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E71D358B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154079; cv=none; b=hjoD4hBFu9oUvU0GUCtLL/aj43WviPt3oppCW4U9sElfEnjDRTrkA388WN6r/I4viY4CvvcqQFFHkp+5j+muxV68liLZJwM3qPNB6BONC/++kLQqwX7TnDCyecqFGChY4Cx5RNmKOZLekNkULFu4AF3yuPXGyvoTgT1kJ8pxSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154079; c=relaxed/simple;
	bh=ZUpBCHLKZ+o9za6/ycdV6eVYRwc6zgHvXV75kG4M1Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8PCrgK/h9GqtHsouy/45jHG9bwfMcrAs/CeHRtpu672RGcXKlZVCqFhezPPFQDGGOpvG66I+VuAM82UhcLC6HvtUsi0omBo0JuNb4/lWGi3A1KLwiF5B97WMe7R8gC5ctzhHla/4/xicnzKb48KrHq1cqLzDAd5I05B2IlMKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=KgYZQfwu; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c960af31daso879942a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1729154074; x=1729758874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCxW7dhqu2Uzy1zSTt5k4/bEdeOeR26xuXCoqFeuweQ=;
        b=KgYZQfwuzc+CYTM9Asm7lUac25qYnRu3E7U857mM5dpJfkW4A54oqJyiFp1gh/74jq
         /KE+3w1NWwOYbfzKskkqW+73Es/7nJav5TJnwUSF0P6KY3S6yp7KoraffuWpeCMFL5fb
         ISGS4Tv0Bs4/NR2ZcUMbVJ6ltCoMcmUczyIBZ1aVnUs/x44gO09y6//cETr82KDIZkgu
         UkvbIqyZecMRtkWIrru0x7EklSoiJrJzSNgS57r/uIYqUBWz1/bj36Vexbyn9R/aN3/U
         hbLbGyEATjo0RlwfWm2FWKoOSkQDJFavBLxKJ1eSHR4pf7pQ2y7t64g25pfcJm9wrUTt
         bGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729154074; x=1729758874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCxW7dhqu2Uzy1zSTt5k4/bEdeOeR26xuXCoqFeuweQ=;
        b=RCxjEWaGyVVTvv4RBA0NpSlYL1H7U1i1FrzmIALhz+CDLai8QTxjm07yNfUdEgz0bS
         ah2cSqcfyA/+nsbKndAzq9rP2WqVdE6syQ2PiCBnHYCxZlrkI3h9gn635UQvj/n/j+Id
         IGD/zlZzGRsr+8PowGwH0PeSvfyTn1ENom4ZbY80ogCr6+P0zF8NkiSG9LwGkX7YMb4o
         JgEqJx0DSfdR4uzybJC+oSLUH0kX0wT10OzLM0VKqVsa6apPseI4wG983YhrtRl4Eo9T
         c5icDFEdihzR46vQXj61bIHOsIpd6x9J8MTt5keJvZ3U8VfuExiPYJgCYL+GflMStTy8
         TlVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD3hhtVzidEPfk2+QlIndJ2MMSjA3fMTu3VhebVvPLs2nlus0TUJQroEclxr1c38mEojMfZ1DRb1VjlCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoOdKf1TGzNdXBZaJ9mNQ/Byb3aoTsW1vHyjI6IYh1jq8NQLnH
	pj6j9JvZDUcLrlZw75I0/zym/6sOJRnreYpOxsh0jNGWLlYhSkg2tYx2gLlSQkG41SpR4Vygqht
	yjp+iCAMvMCNURoMx5PbXEcD6lTJ9HRIZfm0=
X-Google-Smtp-Source: AGHT+IHwKuMg556H5Uzwc7KwPkGGEYxp49IiYbT1rWUfQvAo1PiypvxmMsNjVo6Zdx8fO4w9wNUwanhSWWf+Hr4HPBg=
X-Received: by 2002:a17:907:97cd:b0:a99:d782:2e2b with SMTP id
 a640c23a62f3a-a99d78231bcmr1682086066b.30.1729154073842; Thu, 17 Oct 2024
 01:34:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015105133.656360-1-ciprianmarian.costea@oss.nxp.com> <20241015105133.656360-3-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20241015105133.656360-3-ciprianmarian.costea@oss.nxp.com>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Thu, 17 Oct 2024 17:34:07 +0900
Message-ID: <CABMQnVJp_j4mMg-TXogM-cBSBMkpF=CUrGE=q+QCiz0arBJxyw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] rtc: s32g: add NXP S32G2/S32G3 SoC support
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>, Bogdan Hamciuc <bogdan.hamciuc@nxp.com>, 
	Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

2024=E5=B9=B410=E6=9C=8815=E6=97=A5(=E7=81=AB) 19:52 Ciprian Costea <cipria=
nmarian.costea@oss.nxp.com>:
>
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>
> Add a RTC driver for NXP S32G2/S32G3 SoCs.
>
> The RTC module is used to enable Suspend to RAM (STR) support
> on NXP S32G2/S32G3 SoC based boards.
> RTC tracks clock time during system suspend.
>
> RTC from S32G2/S32G3 is not battery-powered and it is not
> kept alive during system reset.
>
> Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  drivers/rtc/Kconfig    |  11 +
>  drivers/rtc/Makefile   |   1 +
>  drivers/rtc/rtc-s32g.c | 778 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 790 insertions(+)
>  create mode 100644 drivers/rtc/rtc-s32g.c
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index e87c3d74565c..18fc3577f6cd 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -2054,4 +2054,15 @@ config RTC_DRV_SSD202D
>           This driver can also be built as a module, if so, the module
>           will be called "rtc-ssd20xd".
>
> +config RTC_DRV_S32G
> +       tristate "RTC driver for S32G2/S32G3 SoCs"
> +       depends on ARCH_S32 || COMPILE_TEST
> +       depends on COMMON_CLK
> +       help
> +         Say yes to enable RTC driver for platforms based on the
> +         S32G2/S32G3 SoC family.
> +
> +         This RTC module can be used as a wakeup source.
> +         Please note that it is not battery-powered.
> +
>  endif # RTC_CLASS
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 8ee79cb18322..a63d010a753c 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -158,6 +158,7 @@ obj-$(CONFIG_RTC_DRV_RX8025)        +=3D rtc-rx8025.o
>  obj-$(CONFIG_RTC_DRV_RX8111)   +=3D rtc-rx8111.o
>  obj-$(CONFIG_RTC_DRV_RX8581)   +=3D rtc-rx8581.o
>  obj-$(CONFIG_RTC_DRV_RZN1)     +=3D rtc-rzn1.o
> +obj-$(CONFIG_RTC_DRV_S32G)     +=3D rtc-s32g.o
>  obj-$(CONFIG_RTC_DRV_S35390A)  +=3D rtc-s35390a.o
>  obj-$(CONFIG_RTC_DRV_S3C)      +=3D rtc-s3c.o
>  obj-$(CONFIG_RTC_DRV_S5M)      +=3D rtc-s5m.o
> diff --git a/drivers/rtc/rtc-s32g.c b/drivers/rtc/rtc-s32g.c
> new file mode 100644
> index 000000000000..d6502d8bf616
> --- /dev/null
> +++ b/drivers/rtc/rtc-s32g.c

[...]

> +enum {
> +       DIV1 =3D 1,
> +       DIV32 =3D 32,
> +       DIV512 =3D 512,
> +       DIV512_32 =3D 16384
> +};
> +
> +struct rtc_time_base {
> +       s64 sec;
> +       u64 cycles;
> +       u64 rollovers;
> +       struct rtc_time tm;
> +};
> +
> +struct rtc_priv {
> +       struct rtc_device *rdev;
> +       struct device *dev;

You don't have to have 'struct device' here. You can refer to 'struct
device' from
member variable dev.parent of 'struct rtc_device'.

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 32247FBB40AD1FA6

