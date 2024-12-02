Return-Path: <linux-kernel+bounces-427873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7494E9E073B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA7F16A3C2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3FC20898E;
	Mon,  2 Dec 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DkRyrnDG"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3198E204F8D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153044; cv=none; b=J3o2N6Pgx85fWEltyNH3nPM0hRN4B8OIFfEbj2vBZY3n5weokiWXU68pTdkDi+hEcJ9MdMGtUZyYqw7nYKvMBV2ZgrmvVYnWDxW61x3KhQzJ/19RaRo9eiFUuUKC/F17k+IlbnlhM2YZkUk2LmxcmkoZBojq7NRZsMarFQHqFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153044; c=relaxed/simple;
	bh=emBsO7UD/fsFeG160T0J2TEDqg+OGFUi4iJaEE8IBNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqVyKUv7zDplGSB7DhCbiXbA69aqz0X4MuPnpgZC62NXVYr8SUFPXcOL5njSDNxiWyDKcnJRRqgs8w9k9HRRyp3Vjd5DxddxDGSt1VWViWYY9oSd3CxII63N8m4YGyJV9GYkL5qqZdvkPijCJpKOcGeVz5k9ONjz6uk0ReL7MBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DkRyrnDG; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3982e9278bso3244116276.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153042; x=1733757842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aBidcxxw0LkaUAD5/9IMQ9Iuz+pdOXkp8f04uFCwiXE=;
        b=DkRyrnDGRJDp26VILXj//3dtmFDuGra1t1T6iCCb+ftjsGYAdDdbSr1/CmY/Awpgt2
         DR6vcmaGeKlb2yWBJFqkY2+ZfmxImy9Wft+W0eq3m12r+zLLq09lZFiAyq3O1QBBiG5n
         A2+7iSTqfPI6H4QSDggQPO6xkchnjJ2I+IPOooD1yZ2hctRDynsDort9qvyiWtSaFtc5
         8tqFCRllsC/gYw4YmUijD67mUOGLj+6YGKmQhFiEkEFOBUiSSTvkQ+4/BdwYnOIPbj5x
         TZmvuGljRo5V4zi3L8hAQ1j4BM7JYJ91/ZoGUDtAFvRcQ+oIbth7K/46e8N6FWwCghKn
         drNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153042; x=1733757842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBidcxxw0LkaUAD5/9IMQ9Iuz+pdOXkp8f04uFCwiXE=;
        b=IznSPgK/+OfQmNy9YAseb65r9q/8lSPhnyyvZQXd3fJkmAXLlAFye8m+w6cvNuLMLj
         YExe3OciFVCpKOxUv+vDsD7NshKYJ0ErGWFy+8ELlY435ho+WEmh7z0UwUBkbQPmcsrv
         bRDa9dYVD/oskvD7WZ4SrTLRq+rIfTOE3FMkhkjygK2JzHPGVaCrmgP1JTN6rb7ireyK
         T2XyPhpIL/e3+lMCPPZ274ZxIKHQxSKsUK2CKBf5a2CpLXN0mNCnieyr7i9BqHVHMPpi
         rcdkPxaEmZTOrstamoOn0aQewkycswrtj9V93Q8hfGhhFPpBqPe6NdLydK9bG1idgGHY
         z1Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVmr3Isi65KX6DNfRFMQkFkcs/C4dky8VNLCEpM3HaZLzJCwy4SdZaRrDuZKYBSYMd9Bc9vrZtqmqPrc24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7p6dR0/2mx3B81dbUACazH4bSu0DGlYg6D79F/RPQ/iBJ68Ii
	Nd55ofGl4femH5h1wDQjhgSLyA2se1ilA/Ao4Huq0y7IH1hs1jTmIhdEWtBxX1I7BoeTZ1pPU4n
	hsll9vRaxI2rrwnzuwJdE05EghSsvVyzfkanW2Q==
X-Gm-Gg: ASbGncuM/6kw8SbUcHOuXhfPapgFRaosxjoH/RQrY++TJwnrk1mWbuAdgkkJG0L2H2s
	2o/CuOfjvAsskAiOTLIws2Aya6KeprbJ0
X-Google-Smtp-Source: AGHT+IHloKnYMU2YPvEvU4xjaTsmIlSJr7XS8O22fOpOceAV6w9xzQeEE9Oq/ecfzP79HELT5y0lhlpm0hWJnPxFg30=
X-Received: by 2002:a05:6902:11c2:b0:e39:890b:a55c with SMTP id
 3f1490d57ef6-e39890ba7a7mr14479567276.20.1733153041992; Mon, 02 Dec 2024
 07:24:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113225602.1782573-1-robh@kernel.org>
In-Reply-To: <20241113225602.1782573-1-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:26 +0100
Message-ID: <CAPDyKFohGpnh0fCgktbeSatKyrD3Za7TsvnyB03xDmHh6AxKtw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: marvell,xenon-sdhci: Simplify Armada
 3700 if/then schema
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Hu Ziji <huziji@marvell.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 23:56, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> Properties are supposed to be defined in the top-level schema and then
> disallowed in an if/then schema if necessary. Move the "marvell,pad-type"
> property to follow this.
>
> "reg" can also be similarly described at the top-level with only the
> number of entries restricted in the if/then schema.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../bindings/mmc/marvell,xenon-sdhci.yaml     | 48 +++++++++----------
>  1 file changed, 22 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> index cfe6237716f4..3f48d8292d5b 100644
> --- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
> @@ -38,15 +38,9 @@ properties:
>
>    reg:
>      minItems: 1
> -    maxItems: 2
> -    description: |
> -      For "marvell,armada-3700-sdhci", two register areas.  The first one
> -      for Xenon IP register. The second one for the Armada 3700 SoC PHY PAD
> -      Voltage Control register.  Please follow the examples with compatible
> -      "marvell,armada-3700-sdhci" in below.
> -      Please also check property marvell,pad-type in below.
> -
> -      For other compatible strings, one register area for Xenon IP.
> +    items:
> +      - description: Xenon IP registers
> +      - description: Armada 3700 SoC PHY PAD Voltage Control register
>
>    clocks:
>      minItems: 1
> @@ -61,6 +55,17 @@ properties:
>    interrupts:
>      maxItems: 1
>
> +  marvell,pad-type:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - sd
> +      - fixed-1-8v
> +    description:
> +      Type of Armada 3700 SoC PHY PAD Voltage Controller register. If "sd" is
> +      selected, SoC PHY PAD is set as 3.3V at the beginning and is switched to
> +      1.8V when later in higher speed mode. If "fixed-1-8v" is selected, SoC PHY
> +      PAD is fixed 1.8V, such as for eMMC.
> +
>    marvell,xenon-sdhc-id:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
> @@ -147,27 +152,18 @@ allOf:
>      then:
>        properties:
>          reg:
> -          items:
> -            - description: Xenon IP registers
> -            - description: Armada 3700 SoC PHY PAD Voltage Control register
> -
> -        marvell,pad-type:
> -          $ref: /schemas/types.yaml#/definitions/string
> -          enum:
> -            - sd
> -            - fixed-1-8v
> -          description: |
> -            Type of Armada 3700 SoC PHY PAD Voltage Controller register.
> -            If "sd" is selected, SoC PHY PAD is set as 3.3V at the beginning
> -            and is switched to 1.8V when later in higher speed mode.
> -            If "fixed-1-8v" is selected, SoC PHY PAD is fixed 1.8V, such as for
> -            eMMC.
> -            Please follow the examples with compatible
> -            "marvell,armada-3700-sdhci" in below.
> +          minItems: 2
>
>        required:
>          - marvell,pad-type
>
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
> +        marvell,pad-type: false
> +
>    - if:
>        properties:
>          compatible:
> --
> 2.45.2
>

