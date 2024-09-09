Return-Path: <linux-kernel+bounces-320848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE88971149
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A22B2833F5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F2C1B1D44;
	Mon,  9 Sep 2024 08:09:03 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430721AF4EB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869342; cv=none; b=swzt27yjH1oexWu/TQuq9zR7WOGVNo8nPj6v1e+cuvwr06Y0+wVTDrabpkZcwbXfi89jybZ0tqgqvwRlA09PTuYMfIufiO/i0ezu1YT9KDPsZ/Ibv+ZrqbbsstTOV2JhLKfMtqTa4MYI/tmwv9u/GTU6KoRj3VbMu2LZvorkZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869342; c=relaxed/simple;
	bh=C9iWBq5U4o1SOT7F5/EySRlPQJIRG43rEx4sDBIv5EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1F+xs4gmzWhRsjLo+VjSmM+CFOtuOyYC/CGc8MpWT9iidU9w9K2ZRntdUhViQgnbVRMMuBSG6jW+c1fJbCNrqn83lef4rSDiIZR3RphaPU4YRe5hXIfknWrT4sKo1oCN4n2JEriKP+1xzQM2MurKjSRzuJWXSVoeoK2sS49Zao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5365c512b00so3208624e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725869336; x=1726474136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1iZIvL68Sxe3qZBnfU/kh1fDv3H2QvFOPZFkgsEqJQ=;
        b=BxmdURDovyh5IX+8Z8Smi7vT7siLjYvCHwpoo7Fhilv/BEoVE4oEE1PHd3t9h3Ny3T
         dLeRwQ1Z4tzazdgbPK27xsn4Fx1EtmyEYBz8SXDItYh1X2/4wNtYfb03RrjPb8/zERF7
         oN2SVAH6REBccqrAG6Obmrh4npVRJKQw/SvK8Co+zMeBBZaWraau3KruKv8mOlwRglkT
         MkS5krHiErh+p/4wW00KHO3+Eqv9PfGbmKA/yKK4EuRnfMI66LTN/fZAPjxK9o2JqHqu
         s2cKkflfpS0R+oRyLcVwWyfB4+b9QkBZv2Z8ocLIzd26Wbta12M0S9A3KdTLB8vqFasH
         Gweg==
X-Forwarded-Encrypted: i=1; AJvYcCUy7CP25sWYZJbUvK5GW0IJMxMnkJYaaERLZZPqVtZdLgs8XGqkjssBDBzWZb9DZ9bDFTpWwR/5OZJieXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzizVs6ew+lWoWNo/NvPdyOabq4E3PCbOUHuwGVFa3N5COqMtKi
	atErHM89ccu8NL58NGZLKySkbRVwRXJ1eK8clGgAuFvh+NZvu+KPmb+a3nCJ
X-Google-Smtp-Source: AGHT+IGai63WrBLanG7iAQin6IRO68K2WpHuaVXlOCzxQ0q4KVOZdUOEMVfC8Bu56xH9Ltxd9E4ttA==
X-Received: by 2002:a05:6512:124e:b0:533:3268:b959 with SMTP id 2adb3069b0e04-53658805f76mr6934203e87.53.1725869335276;
        Mon, 09 Sep 2024 01:08:55 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f914c72sm687822e87.305.2024.09.09.01.08.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 01:08:54 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f75c0b78fbso18246961fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:08:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIi9PHrVVu2TBm+rLdXqlbgFywmjqlsylaLlaVkJ4/4bYVC2EAyEoGz3pcCxfTp+PdS0xfgxFSye5F7qg=@vger.kernel.org
X-Received: by 2002:a2e:e09:0:b0:2ef:2344:deec with SMTP id
 38308e7fff4ca-2f751f9ec91mr48068811fa.45.1725869333796; Mon, 09 Sep 2024
 01:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908214718.36316-1-andrej.skvortzov@gmail.com> <20240908214718.36316-2-andrej.skvortzov@gmail.com>
In-Reply-To: <20240908214718.36316-2-andrej.skvortzov@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 9 Sep 2024 16:08:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v65Laka+YaPyAecwxEhMkoodrXnDPn+UTwZUS_wsSBMzyg@mail.gmail.com>
Message-ID: <CAGb2v65Laka+YaPyAecwxEhMkoodrXnDPn+UTwZUS_wsSBMzyg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: sun50i-a64-pinephone: Add AF8133J to PinePhone
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Shoji Keita <awaittrot@shjk.jp>, 
	Icenowy Zheng <icenowy@aosc.io>, Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 5:48=E2=80=AFAM Andrey Skvortsov
<andrej.skvortzov@gmail.com> wrote:
>
> From: Icenowy Zheng <icenowy@aosc.io>
>
> New batches of PinePhones switched the magnetometer to AF8133J from
> LIS3MDL because lack of ST components.
>
> Both chips use the same PB1 pin, but in different modes.
> LIS3MDL uses it as an gpio input to handle interrupt.
> AF8133J uses it as an gpio output as a reset signal.
>
> It wasn't possible at runtime to enable both device tree nodes and
> detect supported sensor at probe time, because both drivers try to
> acquire the same gpio in different modes.
>
> Device tree fixup will be done in firmware without introducing new board
> revision and new dts.

FYI I've been working on an in-kernel prober [1] for such alternative
components. This does not require firmware support.

[1] https://lore.kernel.org/all/20240904090016.2841572-1-wenst@chromium.org=
/

> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Link: https://patchwork.ozlabs.org/project/uboot/patch/20240211092824.395=
155-1-andrej.skvortzov@gmail.com/
>
> ---
>  .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/ar=
ch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index 6eab61a12cd8f..66fbb35a7fae9 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -188,6 +188,18 @@ touchscreen@5d {
>  &i2c1 {
>         status =3D "okay";
>
> +       /* Alternative magnetometer */
> +       af8133j: magnetometer@1c {
> +               compatible =3D "voltafield,af8133j";
> +               reg =3D <0x1c>;
> +               reset-gpios =3D <&pio 1 1 GPIO_ACTIVE_LOW>;
> +               avdd-supply =3D <&reg_dldo1>;
> +               dvdd-supply =3D <&reg_dldo1>;
> +
> +               /* status will be fixed up in firmware */
> +               status =3D "disabled";
> +       };
> +
>         /* Magnetometer */
>         lis3mdl: magnetometer@1e {
>                 compatible =3D "st,lis3mdl-magn";
> --
> 2.45.2
>

