Return-Path: <linux-kernel+bounces-253510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E17B93224B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40F41F229B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECD31957EA;
	Tue, 16 Jul 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kuZaKThF"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E76D194C8F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120205; cv=none; b=kmHhiAFsbB6sd2IV73wY2XEJ8K1dqrC32ll+VlmXd9DVPYpR1UreW2ZMhXMOu189oTNm2BTL+pf6wpvS1rBVZZFwqPgGLTCFWLEaSWsvetyiTKFfDJ2lFHX8BMHN5kFfhJABM3hqHVmaV8neYSeFctAc9+N4/o2ElblK83wazHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120205; c=relaxed/simple;
	bh=S7vuiD846vmR+8eV4UTJqMrlNZgfXQtbzarlx52QRw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jiQVZ7zwFIJzwaxMdGotM+sMU6+6sRT3hk86G2sIArtbGPAiq0PZH7C+Frl+L8CZ+wP/lE0C0AKWGmkqOhrFBWWbaSwnMf7u60pZezOswBUG9vy0+aMi/u5UbBYUNGmKHMgtelMNd5+tnGHCl2hNrGho1zuD531MzsfgRiKRf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kuZaKThF; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec61eeed8eso66682571fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721120201; x=1721725001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXprlyHr46bmF7ruMUWhQiYhStrhQKFzfO5a5WBJEkU=;
        b=kuZaKThFBExsQc5tLw9LcqZ5gkzKvn7q6W2p/p0DDt189czK1nxNX2/Nj5ffBg31tT
         Y9dnHpTPwauRYauNb0v0KrH+MA0D10ke2l+LbOtKzteyh16Y93MQz8NS0tt/FJj52igr
         +1D0wQKJHLw1JIviGq//lmpfuchhLltzdbRQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721120201; x=1721725001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXprlyHr46bmF7ruMUWhQiYhStrhQKFzfO5a5WBJEkU=;
        b=qIUicXrcLMjyQtj1k2Lp2N9tAPBrLDvoZQg98gfVT6c/Z6PdjZy+4ePGVVHnsWn7aw
         /Kg5+fsELmKdaNXv014E0eIQpjQi+VJSUHlZxErI0455k6Su2mCRhkgSklXLiZylJdW9
         OxzEkxyKcNSeQ3S3FcLsDKPOn78CXMxfkvLtNDba8vvU/jYa3sEiUMXBREqwe6vKqRYK
         NREINZ92+TvZKZWfLOLg8YWd1nzLAbxTTMF5IQM5Zcx+RwL6waMvGjyzgkpbitE3GR2W
         wrtYfcXmbHi8QWQg+yMSPlk2FExPQG0ZMn8B83jU6eWLyhJT/i7LYzDtmgseSZtN35jv
         JPsw==
X-Forwarded-Encrypted: i=1; AJvYcCV9tYqymEaN+OhUzM0E+1EzRwWXOyZ65ke4BAfVm4C5G32od5Hx6tJmjullJ3RNGSbrnOrtd3n0/jK3X/MNpx1jruhURygd7FbtN3Nu
X-Gm-Message-State: AOJu0YzNkYI9CSR0VOimMH4AbV2j4KmZPU0jtMx3+9/sIaB0H3UqGGxX
	e3/cCyjhoWa610aHP9Azp+w7HpSuB4yDpFKb/kX/5/QNRAmU1Gwr1/XNHkJavRAjbTWwJkqMCkT
	U8Y6VGFCXiEQ4nVNKSnpvHseoKKmLA7OSdzwC
X-Google-Smtp-Source: AGHT+IFOZD4OsAPa2Bctjcjq/xHuvKjPdnaXt584JGD+IHrW84XXJpnxyXAfVMsVyPA31dCb/ZrU6JiMiZw+X7LhjfY=
X-Received: by 2002:a2e:9e97:0:b0:2ec:500c:b2e1 with SMTP id
 38308e7fff4ca-2eef415bc24mr9244161fa.5.1721120201390; Tue, 16 Jul 2024
 01:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715-cros-backlight-dt-probe-v1-1-0b5afe64c94b@collabora.com>
In-Reply-To: <20240715-cros-backlight-dt-probe-v1-1-0b5afe64c94b@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 16 Jul 2024 16:56:30 +0800
Message-ID: <CAGXv+5F=sRPi7sQrxyzM7t5gbZYzOE1oymxeJEvmkCtPT6QHTQ@mail.gmail.com>
Subject: Re: [PATCH RFC] arm64: dts: mediatek: mt8195-cherry: Remove
 keyboard-backlight node
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 12:13=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Commit 970c3a6b7aa3 ("mfd: cros_ec: Register keyboard backlight
> subdevice") introduced support for detecting keyboard backlight
> fuctionality through communication with the ChromeOS EC. This means that
> the DT node is no longer used. Remove the unneeded node.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Different CrosEC FW versions could potentially not support discovering
> the keyboard backlight functionality, but I've tested both a recent
>
>   tomato_v2.0.23149-099cd3e539 tomato_15699.72.0 2024-01-03
>
> and an old
>
>   tomato_v2.0.10686-234e646fd8 tomato_14268.0.0 2021-10-07
>
> version on mt8195-cherry-tomato and on both relying only on the
> discoverability works. I've tested on both tomato-r2 and tomato-r3. I
> have not tested on dojo, however, as I don't have access to it.

I grabbed one from our warehouse and this works as explained. So,

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

Note that there's actually one SKU family for Dojo that doesn't have
the keyboard backlight, which I haven't tested yet. It also needs
a new device tree to describe the slightly different keyboard layout.

> My motivation to remove the node is because the DT kselftest expects DT
> nodes that can match to a driver to be probed, and with the "breaking"
> commit, the DT node goes unprobed which results in a failure:
>
>   not ok 225 /soc/spi@1100a000/ec@0/keyboard-backlight
>
> I can also solve this in a different way, by adding this driver to the
> ignore list of the test. But this solution seemed better as the DT
> isn't meant to describe devices that can be discovered at run time
> anyway.

I think this makes sense.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64=
/boot/dts/mediatek/mt8195-cherry.dtsi
> index fe5400e17b0f..20dfa18c9dda 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -1228,10 +1228,6 @@ cros_ec: ec@0 {
>                 spi-max-frequency =3D <3000000>;
>                 wakeup-source;
>
> -               keyboard-backlight {
> -                       compatible =3D "google,cros-kbd-led-backlight";
> -               };
> -
>                 i2c_tunnel: i2c-tunnel {
>                         compatible =3D "google,cros-ec-i2c-tunnel";
>                         google,remote-bus =3D <0>;
>
> ---
> base-commit: 91e3b24eb7d297d9d99030800ed96944b8652eaf
> change-id: 20240715-cros-backlight-dt-probe-7754a832ad60
>
> Best regards,
> --
> N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
>

