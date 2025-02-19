Return-Path: <linux-kernel+bounces-520877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EF3A3B05B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 05:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5782F1895B96
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 04:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058F11A7046;
	Wed, 19 Feb 2025 04:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FcxhHo88"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A418715746F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739939370; cv=none; b=OhefEzYrl+dBNAMrNQi43NdFT5ZBCSrdFajw8DV9KMtmlSCdTTy42GL33KxihxL/FO1Kto8zfaSy9rG1pGpETFr9a7JR3uDSiRpMBw/1sWQxtLpoKS5QUbWeMLgRF4HU36wFWzkFKZF42qJCK2XEc1zsbmMwkd724jr/rGrkHIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739939370; c=relaxed/simple;
	bh=zb/9KgFfbpk6f/2smouuL+kG7zlSq7ptifNXDJHDfA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ai/vzC9kidBpPaFicjvlwSjOvbDmATM6GzxPcW0sqaK0wop4dUO9TwfoyEGKjrHzsgrrZ7B2gxZstk66pdlmfPCgiByj3zx4H64o9SEo3VNHmez9+ris2rsA8fwUZPY6oVZpIhYzBIUJJxsOnKmWaFKfVHtZkrrj3Nl89P/0PVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FcxhHo88; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5452ca02bdbso4576741e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 20:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739939367; x=1740544167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VEqGe71O4B6jvfykXcb0jRrukuykdD7MfjxVd1svFc=;
        b=FcxhHo88lA3YUC6lyZGCLtuE8o8haZuf05zOPMCMiChbPYAlGSs1rXu3phsaFt+/ud
         FcHr6ild44OfnrLB0ubk5EDXNon5iyG0DPXR15poxsczeDqunu1ypeDyZlL+4V4IzhSW
         xXqFxKH2fYCp815Oxtd1YMwJOkwDJ1+XZDbz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739939367; x=1740544167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VEqGe71O4B6jvfykXcb0jRrukuykdD7MfjxVd1svFc=;
        b=tz2GWdueX63wkeNia+/Fbv/4VdnmnBE5gWcUPZQyH2j8x5PzRZCth7M4Ghb7VCFawF
         c7sOMH7ptk4s1CT4jHZsqwXmj/j9phbPpsyVU0gBu1qW06bOO1jCZICL4BoZJeQIzSxJ
         MvlfNXLbJwa6JuvUfacAUZigjnQpY4EZe8b8QKVNkkKUMefS413XjjNmNhBFuLKGt/De
         TJmM8zujgWnuwOx3tE70klS2XZS0BNIfcr/+hiJzH6RdSrnQP8iRDbht7EC1jinVFKdv
         O5yuxH/VNkGrTFHpjtDw3oKQLGsHjzvH03579nO7P3Tl37TPmvPnELGNS09q9GeRjK3D
         UGQw==
X-Forwarded-Encrypted: i=1; AJvYcCU9ZmRiIGszeiUEI3bDWg/MUkl4fXa0VaNkyytzvCeQznV3N0mge5cCSyg9rCFm7q90yDmbhetL39ov1ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWmtEI1esCiFJ6WfQnnw+StpZd8v47vp79+eLUJJ1GjtxnJlht
	4KCSj/gHgl7AlHkTTA57h1aGm0f5xIX/FaOZ28xpjazmhRfVwpKgAYVv0NhH052QzMp8FWQEM7X
	fomOkgfkea0SPpwukUBbAdVchM7dJOLwvK0sQ
X-Gm-Gg: ASbGncujPOSLoY2ZV6wnAVdpZAWBnDmHMTuAQQIcKek82U6Jc17bt4leXhhd+eWpvUS
	p3giUt4Q0v04mTFrjMeqS+Yoolb4eaz9ng56wMx/Ij0liz6WQYEZmfUeiP6MUCdab9nmV7hac8M
	oEaLgas6+MnFMIwH5+uqNXqRWl
X-Google-Smtp-Source: AGHT+IFDON5BTBrIkCqYoruAW+GgEU4kzLUMfNza88SwUu5KL01SJq4OJVKPavaKWnoXBdabjUxCkcKdf2JVNhz5ek0=
X-Received: by 2002:a05:6512:3d8a:b0:545:85f:4962 with SMTP id
 2adb3069b0e04-5452fe5bd65mr6877441e87.20.1739939366740; Tue, 18 Feb 2025
 20:29:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com> <20250218-genio700-dmic-v1-6-6bc653da60f7@collabora.com>
In-Reply-To: <20250218-genio700-dmic-v1-6-6bc653da60f7@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 19 Feb 2025 12:29:15 +0800
X-Gm-Features: AWEUYZkGeDpr43jARxyOu4uYPJJwq5tj1ueAuV0HV6f4Jx2FAOS0QlcBYZWYQSE
Message-ID: <CAGXv+5H1pfJMQPBTF_K72D3-JFsZDvZ277erZ449sc6FTkNFSA@mail.gmail.com>
Subject: Re: [PATCH 6/6] arm64: dts: mediatek: mt8390-genio-common: Add routes
 for DMIC
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, kernel@collabora.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, parkeryang <Parker.Yang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 5:27=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Add necessary routes for the onboard dual DMIC present on the Genio
> 700/510 EVK. The dmic is supplied by micbias0 and micbias2, and inputs
> into the MT8188 DMIC DAI.
>
> Co-developed-by: parkeryang <Parker.Yang@mediatek.com>
> Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch=
/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
> index a37cf102a6e928440cc88e7e8fe0225fc28ec962..efdeca88b8c4e58f0c1782515=
6276babf19af145 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
> @@ -959,7 +959,11 @@ &sound {
>         pinctrl-0 =3D <&audio_default_pins>;
>         audio-routing =3D
>                 "Headphone", "Headphone L",
> -               "Headphone", "Headphone R";
> +               "Headphone", "Headphone R",
> +               "DMIC_INPUT", "AP DMIC",
> +               "AP DMIC", "AUDGLB",
> +               "AP DMIC", "MIC_BIAS_0",
> +               "AP DMIC", "MIC_BIAS_2";
>         mediatek,adsp =3D <&adsp>;
>         status =3D "okay";

Shouldn't there also be one or two new dmic-codecs, and a dai-link here?

ChenYu

>
> --
> 2.48.1
>
>

