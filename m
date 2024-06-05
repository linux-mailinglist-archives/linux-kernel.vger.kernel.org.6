Return-Path: <linux-kernel+bounces-201743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA41B8FC29C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 06:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656C8B224E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052F373476;
	Wed,  5 Jun 2024 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m5YInhKJ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB82624
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 04:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717561229; cv=none; b=ojer4/cnC+Ln6qF2D01J945yEM+szLlW+zwWPZTW8jn6x2enbDxzz3qCjX6kwsSXeTI19RFrEv73Ku77gNhcIJ4aiPCNvQ/mAFjeGY+YzdcPcxE1Tn27nUCRrdP75kDGXQ21GMABuEW47N+L1roRLrNQn+opT+flGJXrSt0wLb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717561229; c=relaxed/simple;
	bh=3LZDHieJ/4GM7xzNV/3GL4OdbwuZh84bv9wkWZHpSzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpVEDKawSmYSo1pq0wN7RFbxVxOon5BqZsS8ziBVVST99IPcmCeisdyp2oSWBFvxpGc3GaQ48kmCOm53IVcsx+tdgZnwSoFyNJZcu7OzcN++9LWmxlON3s3zhAaoSYwfCN1mkWaRHwxldt+sr/rMHZjMBFCQKC9umAwz0l8fONE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m5YInhKJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b93370ad0so5406321e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 21:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717561225; x=1718166025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzVsE2WVQtDSaAM6UmCM20Z/lAeEvRcu2iqhxm+Mwa8=;
        b=m5YInhKJcOOrYPcsOSy1mWKAhzerK+RmbcwYwG62wCG+X4/xtt+qk0PljFnuaPHC6B
         qg9yblt7ol6WvZqS1X53XzQVuAh8mLNFjr7hZEKD1n03vuB0v1XpefCjqF/pJSOMG4K0
         sbTkBJ7jun9ac9Z6Nkec8kMHlyYPh3LtgCbX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717561225; x=1718166025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzVsE2WVQtDSaAM6UmCM20Z/lAeEvRcu2iqhxm+Mwa8=;
        b=djNmKaguaKZByStviT32CA+dcYZhjV2ZYhmI937ewKjbnw8Xn3bzmwcOG31W7Ldifu
         ekMDq6IEZmqbMpXzsNhjM0wZRsHh940AoP/OeYimRVHYLUQ2UGAfQ5Y0r7VSjpLR/ISU
         JgWxUui3IN3EAnEVWdx3YCz87mLPEmWCgixaNA74+TQJfqZWgQu/icuVcyhx/fRPMYcr
         X9UEk6AACxLXqYpjk8A0l8y2L+ltXEn+z77crKu0UhzBRyNX/zFaH24H0HYgRTBKbysm
         Dc8i/NBBUb+2y73UGnS+Wp4g0R13XCNDw+TGVUfF6ervs/m8xBTHn/IRUoKsFAI7pyAc
         nHqw==
X-Forwarded-Encrypted: i=1; AJvYcCU7yrSngLcAGFPJjxImRnF3oXK70ceK7iyFqtLcbJy9/+dOvnnrlF06u6f9tn0Aemq61M0mH9n0cU26FOt+jf7y909s0n2ytLSHX1Y2
X-Gm-Message-State: AOJu0Yw2OyTjKO/42PR1wW9qedCPxeF6WrvGDivEVjBGB09Nb9AZl7ve
	90NfoIQPS+Xc5AAIE3m46Nol5gKT5pveOLASaamaGUQtnKkGUwUu0Af1K/NsleVsKmqjT/N6FUe
	3jlDzuh6pJsRfSjnYHaj0yacGAYCwKqhLIx1O
X-Google-Smtp-Source: AGHT+IFjiCTeLxR5Rrc6kuVzd7PjI0caEZqFLRKsHokalU9T+t04/Xl7kHt8MmAkD3exLz2xwKl4SHO//vTdXIubI38=
X-Received: by 2002:a05:6512:b9e:b0:529:b718:8d00 with SMTP id
 2adb3069b0e04-52bab4ca25fmr1391310e87.8.1717561224514; Tue, 04 Jun 2024
 21:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604123922.331469-1-angelogioacchino.delregno@collabora.com> <20240604123922.331469-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240604123922.331469-2-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 5 Jun 2024 12:20:13 +0800
Message-ID: <CAGXv+5E09RGRX=7Ra0H-VtbPKMVg6MiM+hZn75AyJ0KmEd5EEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: gpu: mali-bifrost: Add compatible for
 MT8188 SoC
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: boris.brezillon@collabora.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	steven.price@arm.com, matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 8:39=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add a compatible for the MediaTek MT8188 SoC, with an integrated
> ARM Mali G57 MC3 (Valhall-JM) GPU.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml =
b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index e796a1ff8c82..8acb46adabe2 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> @@ -34,6 +34,7 @@ properties:
>            - const: arm,mali-valhall-jm # Mali Valhall GPU model/revision=
 is fully discoverable
>        - items:
>            - enum:
> +              - mediatek,mt8188-mali
>                - mediatek,mt8192-mali
>            - const: arm,mali-valhall-jm # Mali Valhall GPU model/revision=
 is fully discoverable
>
> @@ -195,7 +196,9 @@ allOf:
>        properties:
>          compatible:
>            contains:
> -            const: mediatek,mt8183b-mali
> +            enum:
> +              - mediatek,mt8183b-mali
> +              - mediatek,mt8188-mali
>      then:
>        properties:
>          power-domains:
> --
> 2.45.1
>
>

