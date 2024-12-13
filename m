Return-Path: <linux-kernel+bounces-444601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDCC9F0962
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED32E18842F3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881EA1B87DB;
	Fri, 13 Dec 2024 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n1jyphI9"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C51B4148
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085597; cv=none; b=h6XKb7ypP23tP7jTTe8d7AH0eb07b/80a4x7IkNMTnF1D2jGrnDlJsg6ol5Ov/D1AjOJCjsIsCDA3Y23cXrn8uLWkgs1PQFOVhyUPj9RpJyP0GjBnCgoaKPpNy9oqbf2RDf9kyTxNgewSZBfm85oi37nBnSlOzyj7eY0/IL8/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085597; c=relaxed/simple;
	bh=FZell5Yk6YkTJ23+SinIBFSOK/Zawuga4Qf4iOV7bSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoVSo/Rt5z9Iz9yldLmQK8X0kLQsVgKdfey0j6a5cgo9n5Aht8aOSvf96AYNuWOmqTHaLlsBnEQsiyz2gMxE2vlGHKra26e3mzBP2cVT/r+CPiE495KME+VPVGuoBcivBVIXK0cQ6BL/PXuekxFjCrRcaWQ3OJgF7QFsZNWdAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n1jyphI9; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e16519031so802585a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734085594; x=1734690394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKqDqgeGFaNiglPykk1ZWFq+KoOVfgPfTAi6q8lDcbU=;
        b=n1jyphI9kVCVo/lYYgmOq3d5EwLLFWld1Qr2VGaZN9RMAU3rMmcDvjKAQ7fTrK6inr
         NmsV6YGd1i3mfhP3aDBMhsmyAGtT+XRV57LrLEr3uPTawKpYUG9JibVY/BxnR5g7afO9
         MLKFN/+8abnQPHThlz7FCaqbUXgqObnKTWb/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734085594; x=1734690394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKqDqgeGFaNiglPykk1ZWFq+KoOVfgPfTAi6q8lDcbU=;
        b=ngscnUVzib5H/Tgg7o6ag553wrI6N/ycJhQbLMlq0Ec7WraaXEoMhX2cb7+l/55nkI
         qEHqqNbABoio6NJD2dtD/RUG5kxKPVxSmZ4tJisK6+G2Va+hEANW2LUqRKfNnaZ7OOdm
         uqvT9qTLPSbJneB2832ErNRPriBSN/TtmPiw7XvNu0/YYj1oE0iX7fYwmZkI8tDD0pn3
         16n49Y1Lan6zsV7zApuXeDO/Sef7oiD441wutQcZJsVnARLSu7/qseLOpFwHMIfjapRF
         P6Widn6coP7oI41/5qEwTExqfphBsJ5jYdRJFSr9womt6fIm7fbj+tTzIZjvgSV4+Ctb
         /G7A==
X-Forwarded-Encrypted: i=1; AJvYcCXP4ugNugZsE4Tz4UajhDuM5aMsha/mXjodM42wfnnQLikGRXu4I6k5CKBHtvSg6fKEjvAUiEbPEQdiJII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAvLen+1Mri5iXVOYliVR8dkEFiS6GDzboVVt9YxXWp3BB4rt3
	WbwUT3nn6IlueUb84ynQXo7VXAxDdMW229oG44TPQLt5i76p/HUqLViNefN+f8coltFDmM80cHV
	Sp/r8RNO70ExNkvbXhrnI9NUWRsXaumJkfGLJ
X-Gm-Gg: ASbGncumcKpY05hL4HePY3Z1klkNgzelUsIZm0HvniXZV8wwCoHS/ChdHZr7L0gGlKq
	qPaGpSS4B6xvP/N8GbPoB0noUlnV8t2vvUlHDO0q7TzMT9bfh+qmVUFToP6CV31K+
X-Google-Smtp-Source: AGHT+IENCMH98mpXyF3VrVAuDfFFYvkYege6xGr7xJlAm+RCTMb9aQXAq9gG3Wn85+C8PlkKAH60Qe9TT1gWu6utMaQ=
X-Received: by 2002:a05:6830:448a:b0:71e:30e:e022 with SMTP id
 46e09a7af769-71e3be44e5bmr1104651a34.10.1734085594573; Fri, 13 Dec 2024
 02:26:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213095044.23757-1-jason-jh.lin@mediatek.com> <20241213095044.23757-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20241213095044.23757-3-jason-jh.lin@mediatek.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Fri, 13 Dec 2024 18:26:23 +0800
Message-ID: <CAEXTbpcp31oWOCh2c41QbWOc5F_gpD1Bia0NiZeVyDbqKo98Lw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dts: arm64: mediatek: mt8188: Update OVL
 compatible from MT8183 to MT8195
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, 
	Shawn Sung <shawn.sung@mediatek.com>, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, 
	Fei Shao <fshao@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Fri, Dec 13, 2024 at 5:50=E2=80=AFPM Jason-JH.Lin <jason-jh.lin@mediatek=
.com> wrote:
>
> The OVL hardware capabilities have changed starting from MT8195,
> making the MT8183 compatible no longer applicable.
> Therefore, it is necessary to update the OVL compatible from MT8183 to
> MT8195.

This probably doesn't need an (immediate) respin, but this patch needs:

Fixes: 7075b21d1a8e ("arm64: dts: mediatek: mt8188: Add display nodes
for vdosys0")
>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8188.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8188.dtsi
> index faccc7f16259..23ec3ff6cad9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> @@ -2488,7 +2488,7 @@ jpeg_decoder: jpeg-decoder@1a040000 {
>                 };
>
>                 ovl0: ovl@1c000000 {
> -                       compatible =3D "mediatek,mt8188-disp-ovl", "media=
tek,mt8183-disp-ovl";
> +                       compatible =3D "mediatek,mt8188-disp-ovl", "media=
tek,mt8195-disp-ovl";
>                         reg =3D <0 0x1c000000 0 0x1000>;
>                         clocks =3D <&vdosys0 CLK_VDO0_DISP_OVL0>;
>                         interrupts =3D <GIC_SPI 636 IRQ_TYPE_LEVEL_HIGH 0=
>;
> --
> 2.43.0
>

Regards,
Pin-yen

