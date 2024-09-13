Return-Path: <linux-kernel+bounces-328909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DF9978AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B722B28A372
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BC5154C09;
	Fri, 13 Sep 2024 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmHtDYoR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5662A1537DA;
	Fri, 13 Sep 2024 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263448; cv=none; b=XyeitYuRssAcIFadWdxFbLLWJ4Q5sHa4Zj2KJuPCmJMO4IxqsZgYcZDMHpzr91KdTD3KXekxJrAc6pZ400AnzgFvCa13mNF3/jYHRSixY0mGfur5uXoZJZ4vvbwAIS/KknS9mIpmfQIy00OBNw4HpQTaeOYZ/a1AVWSasdsccEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263448; c=relaxed/simple;
	bh=manW/XLXA8gVmKWJwstgFB2hSWZWCj5W3+3ArJJtYCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raizsi1/ULxcmaUiTsHvW/ILKjMj6ukKHTjFxQmANaxpGDcMyD7QsiWn8ZHJF3CICMzqAtl8IikewiUNGNBMwInS3VzuAboMNLwlN765v0sK2a4MgMI8OSHpedhp+jik8YEKb0+hFmmsKk0oos+9g7mBKmLeJPv8xJpP3Qt3+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmHtDYoR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAF3C4AF0B;
	Fri, 13 Sep 2024 21:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726263447;
	bh=manW/XLXA8gVmKWJwstgFB2hSWZWCj5W3+3ArJJtYCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WmHtDYoRSLlStBr4+JqA3TLmkSnIto885ESxtd3uz4a9nOn2Dj0z+8Hof6ptOTjI7
	 9m8nWQryaXnu6DnH/3uWVEnx30IdftMZNPr1tiJ42oUowZtob63ACpkc9yO6EFqMOS
	 +BllsiEAgEnvh3ABvMuyTVjLF7h0btiqfOeTAW10y1VPe1ac4j9BzOg83TwR84yEES
	 C+eZikkDPtBRpZd35Onmbhw3WBqUa6faarQAoksnG2KlTDMX+CYORgLuw6C0iJYIOv
	 apvuyhjH0XIg8qEY7hdnGE6vcoiX2izuA+JyiC5uyN3w+JRHZLMUPMNh3YmaoAkJFF
	 l5j37iToF4qJQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so30974281fa.3;
        Fri, 13 Sep 2024 14:37:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDFv78rWu2CFZd0wTASa5+H6dhPuKHrdF23Ufsk0uvT2TnZ1ODQY609ZQ+aXaWd691QRpoEl+mIC3b@vger.kernel.org, AJvYcCXT4ANIksfzTLAeQ7Kdtzwg4EXuVM7NlYn1RgkLfwTnlkqgoBQIUOtH/89JkSnZuCy5Mhp2XgNTnyrUQlRS@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEfMPh8LvlppS8Q64XuBV+XkDc0DmQvfZks2wfOGTbUr4kMCP
	BryKLNTbKC8ecqkb2m5hOq5MgwgMhyeQW394liBA3JIfHMZCRsBZbczt1wIwL+3F7yTpH8cUmS6
	pqLHFr2R0bhhlQzbKLbAFb/zx/g==
X-Google-Smtp-Source: AGHT+IF3i2ra1hDCoZJWXdELHFse3nu1BoApDVkgvdYBd1QEEsCBiERlIo516YbDjDMsGqLm6EgWpki4O1VGoMBcV4M=
X-Received: by 2002:a05:6512:b96:b0:52c:e133:7b2e with SMTP id
 2adb3069b0e04-53678fc9930mr5368033e87.35.1726263446242; Fri, 13 Sep 2024
 14:37:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912144430.3161717-1-treapking@chromium.org> <20240912144430.3161717-3-treapking@chromium.org>
In-Reply-To: <20240912144430.3161717-3-treapking@chromium.org>
From: Rob Herring <robh@kernel.org>
Date: Fri, 13 Sep 2024 16:37:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJngFLbNtT3m--xi5nNt9o7M=se8Qkhf20TxRCj-G=6dA@mail.gmail.com>
Message-ID: <CAL_JsqJngFLbNtT3m--xi5nNt9o7M=se8Qkhf20TxRCj-G=6dA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: mt8183: Add port node to dpi node
To: Pin-yen Lin <treapking@chromium.org>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, CK Hu <ck.hu@mediatek.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, Fabien Parent <fparent@baylibre.com>, 
	Jitao shi <jitao.shi@mediatek.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 9:44=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> Add the port node to fix the binding schema check.

The dsi node has the same issue.

> Fixes: 009d855a26fd ("arm64: dts: mt8183: add dpi node to mt8183")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409110843.Hm5W9upr-lkp@i=
ntel.com/
>
> ---
>
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8183.dtsi
> index 266441e999f2..0a6578aacf82 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1845,6 +1845,10 @@ dpi0: dpi@14015000 {
>                                  <&mmsys CLK_MM_DPI_MM>,
>                                  <&apmixedsys CLK_APMIXED_TVDPLL>;
>                         clock-names =3D "pixel", "engine", "pll";
> +
> +                       port {
> +                               dpi_out: endpoint { };
> +                       };
>                 };
>
>                 mutex: mutex@14016000 {
> --
> 2.46.0.662.g92d0881bb0-goog
>

