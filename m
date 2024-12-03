Return-Path: <linux-kernel+bounces-429775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE30F9E23F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E4016E927
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CCA1FBCB2;
	Tue,  3 Dec 2024 15:34:46 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C301F9A88;
	Tue,  3 Dec 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240086; cv=none; b=XU29JB/pgMdPrBA5K3gPcVy0LoF0Z+EYGk2ERxBIAxPladFYFcflLt7JNzQ/j15k/CX2xRm6GwUg05cQnIk3P5WWl6R5KW36F83IdwJ6YOqtHb6DY4EZsr2tcLEwvA24E2OLJlWxsA/+MnukZARwNBWA8DkQ+39q+YtFo+l1miI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240086; c=relaxed/simple;
	bh=/t81Kipm80KSB2ytCFacecH45iV4Rgpz9NMkvjdx3oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0Ddq+ahlHJHxQxkuRYlm+Rb6qYEXqcVdbAW827o+s2bP/Medlt1ePli6BEAaTfmaMA8W4HhrF79HcyXCy+sKB69dX5+p1B8izbWwJTPnR66ZrhGIoEyQgM7UjrGDE1YIpi5NrxBz2sre2qN0AIXzsaflcP973SrRwmlGgUjnXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffc7a2c5d5so59410311fa.1;
        Tue, 03 Dec 2024 07:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733240078; x=1733844878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9ct1kVI68mHIDVHyGKkb/UxzcQ9qI2NSHiJbGWgjuE=;
        b=qHTO7CDwFASzqYb/mOW906cOEf8h4mIWxeu66W+uGHbmt8qjQjZ0S0aBY2ySVeXbNT
         jR7EDBI/vzccKLNdLoV/pcmN2CRzZ01jhSzywPY50RH2+a6GQQoiO4rWG0IBDWUXD711
         nS1cgywaOO+l6p9p5v1eV+b+vehX75eYrbt6MRG5uQdBsbZWyUHcqZsqXYscSSDpwljG
         cqEggxj82qYThKIqXketjDLsQ8tGPnJ2krxXS8mnj29fN25zykZQBzMPwkNqbx4GVf/V
         gWxDTQ+rmn3lWKrjQxmyUU7x+HOfd945yP9duzc9f88gOnvpR+SwDqYaIRUHFlmus0D7
         u2ug==
X-Forwarded-Encrypted: i=1; AJvYcCUb1o5BHPmHyCeeoVxq5xUMWDdgyyTrPIPd1McNmThYebGrYBf3K0+g5YbA82tLEjD0HrTRrOFdwzOatdHn@vger.kernel.org, AJvYcCXwY2C98/WYJqF0tn5pM+UZrJHaaIsBS2tJrS4Kezcafar7b0LyrMRV424TrfL01xMgqrNqHMIBd2Le@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl79ApXGgwTK3EODcoxzjAVoq8EzZwxF5Z/P4kNdDc3sOVWzUx
	f9j+ZxE5hQVWwpQ58MY4pvjSdtymvl1LUWmv1ggXilyeV/RGU9r36XPfgBp8
X-Gm-Gg: ASbGncuQJhpsaYroiXe9yGezK5iKs1lAyZpaRCIDhw26AZKXKIGlxUpAKXVfwJEYqkl
	JWzfgrgMBvlJclj5LVng5dQaXclh9H1+8rxsSbMpiIFs7jHP40J3yALIdlfDM4Yo4skP9/lA+Pq
	uTZqFblt8RezzirKzmWMxns/itus6HEQP83Tao2EjVpSkrKjImZ6aFNRqHP0t17UDgdzKbuONyN
	E6RdHe9TraYBkwvAoaQi28ihnkkzsx5wDfFGooExZsT1DhFeg5cQLj5Oo++Vyo6zTX8H0oYVtdJ
	tFuUiVY=
X-Google-Smtp-Source: AGHT+IE/83d5OrDkNvu9lh6Exv3S7LwQO4ZBKxWveF7Sc0z2K+zmbxe4sxOGtyhks50aWk9SP6FYkw==
X-Received: by 2002:a05:651c:2120:b0:300:1448:c526 with SMTP id 38308e7fff4ca-30014eac030mr2199531fa.37.1733240077442;
        Tue, 03 Dec 2024 07:34:37 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb8e8dsm16746701fa.8.2024.12.03.07.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 07:34:37 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffbfee94d7so47292251fa.3;
        Tue, 03 Dec 2024 07:34:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+vuP/Qww58zBzwDr884BbRf3En/zgmnR87IcFMYaCLxNjTqzD7C6csaxQJmb595HpElu/uM751y76ZLuX@vger.kernel.org, AJvYcCVUlt0W3eZg8OsivLFTSBimVAITAlQ0xnWiKQTdnHctzz+oxMH8aqHmpoPlVbYJIla4+pTvf9q/7xfv@vger.kernel.org
X-Received: by 2002:a2e:be1c:0:b0:2ff:cb09:ccae with SMTP id
 38308e7fff4ca-30014e22085mr2966011fa.17.1733240076014; Tue, 03 Dec 2024
 07:34:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-a100-syscon-v1-0-86c6524f24d7@epochal.quest> <20241202-a100-syscon-v1-2-86c6524f24d7@epochal.quest>
In-Reply-To: <20241202-a100-syscon-v1-2-86c6524f24d7@epochal.quest>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 3 Dec 2024 23:34:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v66RAyKrpn7EJMoPUzM6W6J-3ch0xwQnY7uBm6dXgFJ5bg@mail.gmail.com>
Message-ID: <CAGb2v66RAyKrpn7EJMoPUzM6W6J-3ch0xwQnY7uBm6dXgFJ5bg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: a100: Add syscon nodes
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Parthiban Nallathambi <parthiban@linumiz.com>, 
	Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 12:43=E2=80=AFPM Cody Eksal <masterr3c0rd@epochal.qu=
est> wrote:
>
> The Allwinner A100 has a system configuration block, denoted as SYS_CFG
> in the user manual's memory map. It is undocumented in the manual, but
> a glance at the vendor tree shows this block is similar to its
> predecessors in the A64 and H6. The A100 also has 3 SRAM blocks: A1, A2,
> and C. Add all of these to the SoC's device tree.
>
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 31 ++++++++++++++++++++=
++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/=
boot/dts/allwinner/sun50i-a100.dtsi
> index 29ac7716c7a5284ccf8af675db9c7d016785f0ff..31540a7ca1f01c6c2e69e3290=
54aca16ffd112c4 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -101,6 +101,37 @@ soc {
>                 #size-cells =3D <1>;
>                 ranges =3D <0 0 0 0x3fffffff>;
>
> +               syscon: syscon@3000000 {
> +                       compatible =3D "allwinner,sun50i-a100-system-cont=
rol",
> +                                    "allwinner,sun50i-a64-system-control=
";
> +                       reg =3D <0x03000000 0x1000>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +                       ranges;
> +
> +                       sram_a1: sram@20000 {
> +                               compatible =3D "mmio-sram";
> +                               reg =3D <0x00020000 0x4000>;
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <1>;
> +                               ranges =3D <0 0x00020000 0x4000>;
> +                       };

Each child node should have an empty line preceding it, as mentioned
in the dts coding style doc:

    Documentation/devicetree/bindings/dts-coding-style.rst

ChenYu

> +                       sram_c: sram@24000 {
> +                               compatible =3D "mmio-sram";
> +                               reg =3D <0x024000 0x21000>;
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <1>;
> +                               ranges =3D <0 0x024000 0x21000>;
> +                       };
> +                       sram_a2: sram@100000 {
> +                               compatible =3D "mmio-sram";
> +                               reg =3D <0x0100000 0x14000>;
> +                               #address-cells =3D <1>;
> +                               #size-cells =3D <1>;
> +                               ranges =3D <0 0x0100000 0x14000>;
> +                       };
> +               };
> +
>                 ccu: clock@3001000 {
>                         compatible =3D "allwinner,sun50i-a100-ccu";
>                         reg =3D <0x03001000 0x1000>;
>
> --
> 2.47.1
>

