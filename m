Return-Path: <linux-kernel+bounces-259413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3C493958C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF561C21896
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FAD3A1B6;
	Mon, 22 Jul 2024 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aekZUnLU"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D222F19
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721684101; cv=none; b=uUB024fmgvVDAGF59MNkNMagY9SubF7i234wpNdiVuHq2rj9lEKPjn8gjJgLfIhNR5TklO5GftPkNe+SYcV2zyVhYEK9BMqqU8nHM9AM2qDQCne2lQXJ0JqhjOu8pCIB1cQvogilnfKoH6GadvjqMetaE7wbW66NWMqHoup0T9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721684101; c=relaxed/simple;
	bh=DavKR6zlsHTTROZB3HzBGry3JUwnrQbFua6WuPnbWp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXGohx6L99eq+tuRFxPXkuRn0ufZqtlVsDYdZWa7EMVxJ+xpr2cZRPU/4hu3JK0z+Iy/FK1+aHkxRtJha3ecQEwUFfU25erq8HWBXApVEMSYU6ALF3BrfLobLioXtHB2+QBxRlUrRg1+4aNBxBnLIIIBw1PyDTvlberlJrzmOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aekZUnLU; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64b29539d86so45601407b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721684099; x=1722288899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bew7kISzf+Slt4HQdKRNoanuwNUVw3tMPgUQzbpwb8I=;
        b=aekZUnLUk6aVQQAgVJgBppyLsk0PRN9IP3rzKx7ylYE8JRGyYy+TrkHglCYMPWxMn8
         BZV5RWHtRN9Wa5gHBRlg2ui7OFf1DHkwgfYCxjYn49ixRz+spE2wri8jSAuokf4loICb
         hC86S5Vh2YXwlasYBV+eXXPSJjz9/KRyPgHF2/hmoxxvWQhoSHng7XRORlBep+dl5AVy
         HOgnuCgYkBjj8GzDshFwr9Xt7Atw8kltCkl6Wkwu7pO19e6M7L9CY/qdt33ESL5S/S5n
         +PKY5X8+G5OnYSaPlSBTBp/SV8zikL2ovoFwnX8hchTla+I2sOpLBNvUPTLDswDMGDTy
         rBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721684099; x=1722288899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bew7kISzf+Slt4HQdKRNoanuwNUVw3tMPgUQzbpwb8I=;
        b=Z0CpzMP5/t/RarHEBIyns0W3PH82BPGMI39sAfFZeng6bD31gvGCe2G4CuX3T7AF9u
         0QGLs/g7aODMlz/TjKGXoSEtmTsr0oY6H48iK/vxIy4NRUKTQW7nVP4FwqvD0zCg/57c
         JZ4pmqH+dNYNqPgrrawgmF/AXsvSLpsub2uDLrUVVnBI17mEjqcp7ec/qJiuA5o9hAsU
         X9wdBV5FdtQHjPqwXEnC1u6LZHDqfsDLs+OM+gx5h9KFXokvctlAdRxV0vHud9GXvxYL
         fX0M0MSycbezIgZh9cqsESwmny9R1vIFx0tQGyuSZ1tzSs4rk/bL5UI/HYUFdqZsR21d
         iwsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw94MlH9xX2k3PH8ng7z6/4py8zX6DtVPx1fOK4iqSxPGiRTTIFZap93F6JraFzTFkjH66gOM0kCyzkIP6C65xwJbrOrib6QtfhQmX
X-Gm-Message-State: AOJu0YwctXWoK2fbQ8HS12G43sBPqFeZKe6SmfmndAflavJ004oLdaGU
	8rLR+ppH2iJwsHNcrmbdgZhs8NbY5taJiY8yG1r0cxbwhZ9gZOEsSG6kW+2/NsTvZD/tmXHnu7K
	E8+a3Cy5Errgm9ea+IRxnRZyB0+Qh6HQtoPUyIQ==
X-Google-Smtp-Source: AGHT+IE0ltDhbLmGYW/fyUnYlpSuwc7uDLK7DxqB7eIHLb7TN7siloOmPdFA3AK/XHiKBZ174IJiHQAZ67jbE8WFQIA=
X-Received: by 2002:a05:690c:298:b0:66a:843c:4c58 with SMTP id
 00721157ae682-66a843c5e32mr107931177b3.34.1721684098995; Mon, 22 Jul 2024
 14:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240719120949eucas1p1b061c716ac55b4a79ba57c407c0b2d91@eucas1p1.samsung.com>
 <20240719120853.1924771-1-m.majewski2@samsung.com> <20240719120853.1924771-7-m.majewski2@samsung.com>
In-Reply-To: <20240719120853.1924771-7-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 22 Jul 2024 16:34:48 -0500
Message-ID: <CAPLW+4=MSeYjWs4GbriiY2rj8FsZ0_GGVRqfxV9GH4VxDREKCQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: thermal: samsung,exynos: remove outdated
 information on trip point count
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 7:10=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> This is not true as of commit 5314b1543787 ("thermal/drivers/exynos: Use
> set_trips ops").
>
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  .../bindings/thermal/samsung,exynos-thermal.yaml           | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-the=
rmal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-therma=
l.yaml
> index 4363ee625339..5a82764a4dbb 100644
> --- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.ya=
ml
> +++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.ya=
ml
> @@ -40,11 +40,8 @@ properties:
>    interrupts:
>      description: |
>        The Exynos TMU supports generating interrupts when reaching given
> -      temperature thresholds. Number of supported thermal trip points de=
pends
> -      on the SoC (only first trip points defined in DT will be configure=
d)::
> -       - most of SoC: 4
> -       - samsung,exynos5433-tmu: 8
> -       - samsung,exynos7-tmu: 8
> +      temperature thresholds. The trip points will be set dynamically in
> +      runtime, which means there is no limit on the number of trip point=
s.
>      maxItems: 1
>
>    reg:
> --
> 2.45.1
>
>

