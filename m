Return-Path: <linux-kernel+bounces-190326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA77F8CFCEC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078C01C21A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A0B13A414;
	Mon, 27 May 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZatztFKV"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB87013A269
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802290; cv=none; b=Olj7fzzz0lfSpj9/2TcPwj7Es3GmpDUp+QImXa/H43Rl3bm983c4twJy98A1CqHF8B8UACBulQc6uuxWaXcN2kU5CV5NKBMwlxdC8zxTzbhIad3Q2wnSVnpGnjWvPGiyjr2PFgM18wJPYk4Njg0mpxIjrytZKrAAEcsWo9NpeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802290; c=relaxed/simple;
	bh=7QuK+dRxWekrg4574FU6ZFuSg2KV//r1UAoPSO1UBcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkxgobet/567e5Hj6vZeoKCE20AAOMeE+rBAjvOzE0TCVdnmNg9k4pTyGSlozWyhG82ZkIaP17nKgMWm80D0aSjIVD/3cLmvPnqPCrNFCUmlsqY7lKFgfYYuXoOvx5JDULYTQhm+oianz45YtdHQ1N33VaD5kmpWiqm59eK0JR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZatztFKV; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5238b7d0494so11770800e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 02:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716802287; x=1717407087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nsle90kquxqyGATVLGaUwfEqMygpQJmcBP3wYD4Xyos=;
        b=ZatztFKVqWS4qJ8Oxy++xStcbzHAQgPQR2v71e9dokfKPy4I4lty/oZ9SwO4cjL2Yl
         GiHNwaOx3cYy4+XCv3f9UDkxGG/rRZoovDijOFoXz1Hf+u+F/9F+UADhMC5nSnxz34in
         UTIce5eoTpllOEJe5EeYhdUKNhZCW53lSfEDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716802287; x=1717407087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nsle90kquxqyGATVLGaUwfEqMygpQJmcBP3wYD4Xyos=;
        b=i9IDapy0Aa8+tGCuvxLhhrGdLDZBfEylzAVk+GSx5mpszPm2IYAcGBi5Y2jSxEEJLo
         c93SWGYDwSqE5IbEjYoDGEsDKz996fQXQJyIClwjaQE1L/niwmUhA3iY97I5kPnG2/O3
         ja6jkrJua+GSiC6tGu8C6kV1R0/xhG7d32ZssdSFN3ukIQWMGlJWqORt9Grt9Dd9kuSH
         o2wFUcW/faVUsi43goHe/qGk0kblN+/P12omtaQP5Ln/LHoHsQmqA/l0ebtaTwJbuWEn
         hdpJXQd1qxyMi8gVGFhUu5J8GYlTfW8qH+cHEYbGInCtGtLPJj9BZssnvKOCAYTLSOu4
         xLTw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+2N91Olo0rBMFij1ZErlduKimkqV1vBGBupaaDAuRBqVHQ2dlLCIphPi2tgQ71gdEJMDafZneiaQCwvfB5wPNxtpD/xsdTZa/m+w
X-Gm-Message-State: AOJu0YxbF4R7wsJ8p3AcrWt2YcroOW3FdLg2GFBxsV2Gs4Fvm8JZQdjZ
	8nu3e3E0JFaM6VldO3R1VxraZxzvaKfqsO3fAlrGTa9WK+sXy0NZ+T7SlGtEyotAgSicth8C/uM
	d2q9o2ypOhPmPixk0YZhSVdLuCk8Ajh/z+sHC
X-Google-Smtp-Source: AGHT+IEkCNM2qY1QxwWMjQ5Y6VGnSYpnCwe9tanGjyyeQWcnQ9MczhIoPwNeqRZhqbClYjaT+d8vnb65A/W5+FPMd1k=
X-Received: by 2002:ac2:4d91:0:b0:51f:53e0:1bc8 with SMTP id
 2adb3069b0e04-5296556f885mr7749628e87.25.1716802286862; Mon, 27 May 2024
 02:31:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527092513.91385-1-angelogioacchino.delregno@collabora.com> <20240527092513.91385-2-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240527092513.91385-2-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 27 May 2024 17:31:15 +0800
Message-ID: <CAGXv+5G_n1B0yaoOBx0k8syRPma=7NnuRcSL4M0N0BJONa5fCA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpu: mali-bifrost: Add compatible for
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

On Mon, May 27, 2024 at 5:25=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add a compatible for the MediaTek MT8188 SoC, with an integrated
> ARM Mali G57 MC3 (Valhall-JM) GPU.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml =
b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> index e796a1ff8c82..4cf676190ae8 100644
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

I believe you also need to edit one of the conditionals below so that the
number and names of the power domains are properly constrained?

ChenYu

