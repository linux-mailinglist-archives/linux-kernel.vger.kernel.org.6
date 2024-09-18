Return-Path: <linux-kernel+bounces-332320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250397B847
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD7B1F21735
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D14F15B57F;
	Wed, 18 Sep 2024 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cd932QZ1"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF1D13CFBC
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726642814; cv=none; b=t/LxvNasLfH8JXizm/ZcprQbOYxnwioscwgZ97b4g+kzmakfiEWgCPRNVRirPrvun4gFkz6muYeJWVjeUSY3/1Dr6npLYpze9vpHCR+i6P3n2QC0I2dAbdkPahq4tliV6YV4IZydFA1xo7wL+Q4zoidnJS80zsjOUbIIZic1w7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726642814; c=relaxed/simple;
	bh=VGj7MFbbpbV6gAewaS84mKaTbH5kyGiVAY8srxXcrHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nreR6AyMydCm1D6tjRLVnqdKZyxgsyKSY0Pa7Y7Pyf4XhYVuKq63Ks78u1Gj+q4TatfGCgsljQRyDr2pfeppJK60yV4qa6QiDGy6VxZW5KT76Ps4KEMf0/vauaevZ7p0bCtYcE4o5Vd4A6QgmifZPivxqt6AyuPAYz19+0Q6srE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cd932QZ1; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-710e1a48130so1446197a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 00:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726642808; x=1727247608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOqc83yMPmUNy7v5ZCgAL4TGfjubvgZuTWuJi6zr/fg=;
        b=cd932QZ1fXLzJLwwBucfEuXoMCvwoZ9Ksk1BB8+8eHudztFWah/Mz8e64RBwsfUiMU
         l+quW7pDdWeI6Ma2/v4WXVH36rkkKZ33XAtvBCv5yV9A8FmAsx65ZsLpTp45zaP04x/b
         8+KuPXnuw//3A/lIUWZBydiqjXGFY5ZeT49fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726642808; x=1727247608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOqc83yMPmUNy7v5ZCgAL4TGfjubvgZuTWuJi6zr/fg=;
        b=erkNNj1rhTt4KCvxZz6ub5kfnG9Fzeu1K+J+rRQeSRjWYaKfBy5nvjNnjjvFXsdXj/
         tXm+GGI1StBheUOU3N72UIOE2OzmcGpuW4sgId1VPD5oJ7VHiA1dmBzIp6tjdvz6sVt3
         NuU7V7/oCA4NOKYhm0ZAJcRI5JXM5Ajzy1qEhoADl4y69ie+py8Cv5v7pae9SuTzIC9K
         r1NFouuoSp4+F17ZRYtovujI2S5UQr3inyooZ1FhgqaKeoECYb7qpfp7FmVvdx8ox0r9
         bFb0hVuyHnK5fiOtDMdjMYVMvrolqTYVgy4eOd9leHBPaVK6wUChu6GqAL1P+/Mz0HR3
         MV4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDwNGQ/bBq/VnFjDfcVHSGBUYWrLErD2B+llbIiLdWL6ca/qFQ/HzTuiIHcQO2TLHNGk/ya4bz6Tn+uxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuHM3g530uEzO89VWcvUzj2zTS4mm9AMvTUJDqYbncCzDB5zfo
	clztBljGyQyLFf7m5gMTTIRKgQeSO6jYniphjFEm25YLfpAECcYdlev63UwXjKUmaiEpyqgDLVY
	dMtNcUOIvycEsHrtWlpajfnpN40++DGFIQ6zX
X-Google-Smtp-Source: AGHT+IEBksw6fFdlYZ7q/FBpGRgy55uXZtW9PS9HPUQ2weMty0HZGZxThjuKX6anaB5NViscVV3L7qxmQJ9lVWMx6WM=
X-Received: by 2002:a05:6830:3703:b0:703:6434:aba8 with SMTP id
 46e09a7af769-711168e8f6fmr11760759a34.0.1726642808164; Wed, 18 Sep 2024
 00:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916162956.267340-1-alpernebiyasak@gmail.com>
In-Reply-To: <20240916162956.267340-1-alpernebiyasak@gmail.com>
From: Pin-yen Lin <treapking@chromium.org>
Date: Wed, 18 Sep 2024 14:59:57 +0800
Message-ID: <CAEXTbpc=ZgF_V9AwxgTTJ8Ki1pb5M7bJ=se2fPE7Qg7s9H7XdA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183-kukui: Disable DPI display interface
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	Pi-Hsun Shih <pihsun@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	Chen-Yu Tsai <wenst@chromium.org>, Fabien Parent <fparent@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Jitao Shi <jitao.shi@mediatek.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 12:30=E2=80=AFAM Alper Nebi Yasak
<alpernebiyasak@gmail.com> wrote:
>
> Commit 009d855a26fd ("arm64: dts: mt8183: add dpi node to mt8183") adds
> a device-tree node for the DPI display interface that feeds the external
> display pipeline, to enable HDMI support on the Pumpkin board.
>
> However, the external display is not fully described on Chrome devices,
> blocked by further work on DP / USB-C muxing graph bindings. This
> incomplete description currently breaks internal display at least on the
> Cozmo board. The same issue was found and fixed on MT8186 devices with
> commit 3079fb09ddac ("arm64: dts: mediatek: mt8186-corsola: Disable DPI
> display interface"), but the MT8183 change wasn't merged until then.
>
> Disable the external display interface for the Kukui device family until
> the necessary work is done, like in the MT8186 Corsola case.
>
> Fixes: 009d855a26fd ("arm64: dts: mt8183: add dpi node to mt8183")
> Link: https://lore.kernel.org/linux-mediatek/20240821042836.2631815-1-wen=
st@chromium.org/
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>
>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/=
boot/dts/mediatek/mt8183-kukui.dtsi
> index 22924f61ec9e..07ae3c8e897b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -290,6 +290,11 @@ dsi_out: endpoint {
>         };
>  };
>
> +&dpi0 {
> +       /* TODO Re-enable after DP to Type-C port muxing can be described=
 */
> +       status =3D "disabled";
> +};
> +
>  &gic {
>         mediatek,broken-save-restore-fw;
>  };
>
> base-commit: 7083504315d64199a329de322fce989e1e10f4f7
> --
> 2.45.2
>
Reviewed-by: Pin-yen Lin <treapking@chromium.org>

Thanks for fixing this!

