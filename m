Return-Path: <linux-kernel+bounces-222306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF1F90FF84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684A0B255DD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9CA1AB519;
	Thu, 20 Jun 2024 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VMx6jyOA"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F21A4F17
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873398; cv=none; b=rz4LAaMkIxphZsU+V3kgcN2BJFFIxZFT9shgaTa5qSgAYzAprLJcji4meWVyX6wj0XppokUL4sO6YyI2qyqIngeVmu3Hp5uHU4613cawXYgApfYbYCBu7gmMxnLeYyElJMmlT0ZB1iITy2Rq0r1IBK2zhyePnfr4IVnSbddsYng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873398; c=relaxed/simple;
	bh=2CIj8Y9AUmvIjg+JAcqcZ+r+tVIYJcXIr4N0cIi9dVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ci9TS4SCX0rtYR6gqbm0QUUXvSQc5OILKTq3gWwC2cm+XaNiAY7RXkL2zikYdcPLuaoKjCDKxnr9vG+jHSSETf+BlhoESAj7KbDsjuXk3EAKxZtXLwpONYuxc0Z6yYjlhG0WIbuxrrctPu2EhQfLDuGlnTZpTFJkzGp/GmmDO2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VMx6jyOA; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-80f67420dadso121154241.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718873395; x=1719478195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wnzPQkY7olrxeTisghk4ynlDr11qeA45cqHLGGh55Sg=;
        b=VMx6jyOAEKOX8z2b0EXx2+mh5v4QPkZkGlLiyFjMQDAoN/Cq87cRfe9iFaCDjghauj
         +zKLm42RmUH62NF96b9b7k/AfNd54XtjzpQSy7WIVEv00q006838UnLIE5swpx5198Ju
         8IJhlJV1F8/6IicVr80KePG3uv9M48wJHlnUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873395; x=1719478195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnzPQkY7olrxeTisghk4ynlDr11qeA45cqHLGGh55Sg=;
        b=dzDteymVaHK27aKO9zpJCBQ6SufFSK1vriHyBFFYkhDYg2T3BbuouJm86nmmxE77d0
         SR79hQ8+KFGGwLkpwTUxWXDi2aII+wroTNd+l7WubdC/BAQUsaluAswV6PFPL5f/0t4r
         mSh9AOvUmivyup7aUpmRuQCIvReQ5zuSri9vPqoS1eW92/nN7qokML3HdeJ4l+zI7tR/
         /Mebp6sH41e4J1DHwe4RZL6VAVEbJw2CTc2r+limeml6kS4w29sw1GJjwjlLVvavsW5b
         k0QAJW+69h36EyPX1hhhWu5zWnfhWDQVlLfH6bTmG5jOYk2+5Jfo4Rvtvr3AibZ0IiIe
         dgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtomMX/EnrmHsPsnbZn5rk9qcOM9Ff1KgQgwD9CPclL9FlCjlbd740ADhHt1gr+xfxtuUulj4HeeEiurzDgFyq36gCDfFJuyteLui9
X-Gm-Message-State: AOJu0YyZi2fROIWFbjP31cBJqTz10VWmyE8yPquj1v9F3ebykZXLK5BU
	NsqBzQ+bRfXERen6BZu5T94B/qoTrfdEfajdihqd2kfmu4G77umiuoirrSfEDektv4Yb9Bnz6y0
	=
X-Google-Smtp-Source: AGHT+IGtP+7YK4pOEc1mdetgxRQ2f/yjuWLXjlXqkDcCip0sDXDBrRWrI+A0lop+sYa2sCDhoMNmFA==
X-Received: by 2002:a05:6102:4a4a:b0:48f:1337:fa70 with SMTP id ada2fe7eead31-48f1337fc83mr5181695137.26.1718873394872;
        Thu, 20 Jun 2024 01:49:54 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-80d78a6fd95sm2929451241.29.2024.06.20.01.49.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 01:49:54 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-80f4b2b8c9eso184565241.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 01:49:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQK1GUyWtNYZCabvSllAPa7wSQfoQfs0z3+3JJnb9UWDvCtgda6zHYqb49Kb5gVyYcULQaHHsiz76bGLK39P3TsAMAGSbwu99mJe9X
X-Received: by 2002:a05:6102:1889:b0:48d:7692:51ba with SMTP id
 ada2fe7eead31-48f1304d706mr4853217137.4.1718873393626; Thu, 20 Jun 2024
 01:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619085322.66716-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240619085322.66716-1-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 20 Jun 2024 16:49:16 +0800
X-Gmail-Original-Message-ID: <CAC=S1njt1tEH-S2YYKvewRmqta468DuteZFCXKgC02vMUoiBdA@mail.gmail.com>
Message-ID: <CAC=S1njt1tEH-S2YYKvewRmqta468DuteZFCXKgC02vMUoiBdA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: mediatek: mt8188: Fix VPPSYS0/1 node name/compatibles
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: krzk+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, 
	jassisinghbrar@gmail.com, garmin.chang@mediatek.com, houlong.wei@mediatek.com, 
	Jason-ch.Chen@mediatek.com, amergnat@baylibre.com, Elvis.Wang@mediatek.com, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 4:53=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Like VDOSYS0/1, the VPPSYS0 and VPPSYS1 are syscon nodes, as
> described by the mediatek,mmsys binding: fix the node name to
> be syscon@address and add "syscon" to the list of compatible
> strings for both VPPSYS0 and VPPSYS1.
>
> Fixes: 9461e0caac9e ("arm64: dts: Add MediaTek MT8188 dts and evaluation =
board and Makefile")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt8188.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8188.dtsi
> index 3b02170562ae..77c4f2d104cd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -1331,8 +1331,8 @@ mfgcfg: clock-controller@13fbf000 {
>                         #clock-cells =3D <1>;
>                 };
>
> -               vppsys0: clock-controller@14000000 {
> -                       compatible =3D "mediatek,mt8188-vppsys0";
> +               vppsys0: syscon@14000000 {
> +                       compatible =3D "mediatek,mt8188-vppsys0", "syscon=
";
>                         reg =3D <0 0x14000000 0 0x1000>;
>                         #clock-cells =3D <1>;
>                 };
> @@ -1349,8 +1349,8 @@ wpesys_vpp0: clock-controller@14e02000 {
>                         #clock-cells =3D <1>;
>                 };
>
> -               vppsys1: clock-controller@14f00000 {
> -                       compatible =3D "mediatek,mt8188-vppsys1";
> +               vppsys1: syscon@14f00000 {
> +                       compatible =3D "mediatek,mt8188-vppsys1", "syscon=
";
>                         reg =3D <0 0x14f00000 0 0x1000>;
>                         #clock-cells =3D <1>;
>                 };
> --
> 2.45.2
>
>

