Return-Path: <linux-kernel+bounces-406248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05629C5C98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7661F237C2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F75205AB6;
	Tue, 12 Nov 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JlSkjZl+"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500A220515C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427031; cv=none; b=TSItPFlR8c2mG4IJz3WV9+Yz6pXyjWkaQ0UzhJhyKMVVIwfMSkgJ3PeMw0ePr6eowYYCWekxuXHCNsugDFAcu5Mw5WESMPCiRrEQM15Q2G3g+AU0iJ1CUjxoLpd2sRrivQmn8fZJuUcfitaAHzvmFv0TdsJ6yOmSHp+4vEm+fQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427031; c=relaxed/simple;
	bh=7T1EWpUdFVknKbZI8QiuRaCYoZtqqd0I+lPaOsqrczk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gh/XXdEDtL/QB2Maf4upTsvh3tdIbqwVzGMCGq4ueup297+n6+ReLbDK2TbYl5BWNuqAGUDgeJCbrEmaGHi+W7jH5F7SHo+jhWYnLIBqQUVh3w2ZTNdYA2tW7kn4S0rhBimIXWuTTP56XJXHPtAlzgndLfk4kKaFOFh9CBK+7ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JlSkjZl+; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e2e41bd08bso59109337b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731427028; x=1732031828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wBk1KBzwEOHZKuHnC3LcVYLaBvifyeSlS2dX2zuDsKo=;
        b=JlSkjZl+lcABpzV2c2qb0SI35Ttlj6sWwim6B5osCcSbqVx49rDmt73hXQ2UHcQfIj
         Zm6bQU8t2ywTS9AuE9WfvxKYVf7YzdSQBBg56zfBPpFFyjcmuTQEkxhdereSvkZmWD39
         x5MvGoBHAPYKsIz/G3+CEEw0GnQhN2PkFJZpoOlu8GAD8tsJxO77iHkdQSkxvSL4DH8J
         CsNPvCTc72BcZ118c/RBMfw5HvBEaSj2IHakzv16NQhzH8XfeRep3BWNq31wewiEXRt0
         xHpHf0wYgy4tcNYig3g9YBcepuIswHOGng1kZBhixtlc2nNOA44571rXkTMfpOOTcRaK
         bHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427028; x=1732031828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBk1KBzwEOHZKuHnC3LcVYLaBvifyeSlS2dX2zuDsKo=;
        b=L3fjh8qhSmXddnoVL/cV+POSaMXVwuxDG6u4JumV3jhh/pp7WNSAzjmrWvLOrjUP/X
         HbWLEuPcA7p7anF3kHZVtyMxiasKwV5EhQHw52sRMDiSYVmYTT/GXO0D9LOOd8c3FScS
         q6d2jtC4FKISc6TG6vzlHSLgXdN+nn2UFdkEIQVrEmCHrdQU6Q0HsBswzyq0j0HH4y1t
         zz3H9uObFsHqFhF9g0XB2qzxKS/7Vc7iMnDDBcd9ESjpta3e+I/CzV4Jhj2I0g2QYnNK
         2KF9gaz16UbLVSw5db7pdxcsKAQARzO2pI6mP3QcmrepKWtFIujIFESN4JZYk1QS0Z1z
         5jBA==
X-Forwarded-Encrypted: i=1; AJvYcCURjRMJa05MzsjJeVObm2QngNCxd2sDiGSiw0QmHuOj2nSyBSIMirHf8GGYC4CsC87cV/YuMeXExRD9wcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVhAqFwes+nzZmH42rmue4PBozPpjoPrbqVYGh8yWLcAk/Nae8
	RcIsBPXTfu2WSXEbIasFvHc6hg5Tk7DzQbewC7yHcRlciIiR5LrW1NWPGMmKWaLY0FhkG+rXaxg
	NFInRs5hNsOTvFdBEdCl0i8ynbzh2oyxgqDdcbQ==
X-Google-Smtp-Source: AGHT+IEbIXuO/FqYjARrZep3wROIZJT+00STOjU9kzztmEI5hpPneiVqw/DMdVTNmBDXF4I7LbrGsgy3l8sZTRamFzM=
X-Received: by 2002:a05:690c:700e:b0:6d4:4a0c:fcf0 with SMTP id
 00721157ae682-6eadddbcfd8mr154933787b3.20.1731427028254; Tue, 12 Nov 2024
 07:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104190742.276710-1-robh@kernel.org>
In-Reply-To: <20241104190742.276710-1-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 16:56:31 +0100
Message-ID: <CAPDyKFreU6wVnsOwz9nstiQ=0sSKN=xtGOaqotwES5UByxQeKw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: Use of_property_present() for non-boolean properties
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 20:07, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/gpc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index 80a4dcc77199..fbb4c90b72c4 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -411,7 +411,7 @@ static int imx_gpc_probe(struct platform_device *pdev)
>         pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
>
>         /* bail out if DT too old and doesn't provide the necessary info */
> -       if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
> +       if (!of_property_present(pdev->dev.of_node, "#power-domain-cells") &&
>             !pgc_node)
>                 return 0;
>
> @@ -511,7 +511,7 @@ static void imx_gpc_remove(struct platform_device *pdev)
>         pgc_node = of_get_child_by_name(pdev->dev.of_node, "pgc");
>
>         /* bail out if DT too old and doesn't provide the necessary info */
> -       if (!of_property_read_bool(pdev->dev.of_node, "#power-domain-cells") &&
> +       if (!of_property_present(pdev->dev.of_node, "#power-domain-cells") &&
>             !pgc_node)
>                 return;
>
> --
> 2.45.2
>

