Return-Path: <linux-kernel+bounces-557607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3888CA5DB7E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A651D178E80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9E5248862;
	Wed, 12 Mar 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxpRm+nE"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162A24A059
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778742; cv=none; b=QxqGqzHc8IIos+OGPd6pTm3Oqz9yCt9q+aGGIhY1FJ/Hf1Kt6a5yD7sBrNDOCyse229LoeNRQGxdwNNaP+AIC2k4vbA0qZ9QNqR1A7yFimtbsZsFBLuLWTKOY34TKPu9tktc5wLxr2ZZkVijVpoCy0eYVLJWS0/ojQiwjyXqFKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778742; c=relaxed/simple;
	bh=2mAjhQ38xaV59CAo8Jko5V6MNwT7CgxOmLCldmytZvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNzQFNAtafDTv7o1PODsJC6PDkNiW2ge70a6QiEU9bcqoa+cD2hgcnbuUzSSFvs0l//4wf2GEg0NkSYSWIJnpgYZQ42ESiAbBudmbNb/U2jtxuKdrcNk2EmJVx+L5bONRR7SUCRSApfqgEwmpHD3M13ROjPwaBy7jyb6yyzQksc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jxpRm+nE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6fd9d9ae47cso61426787b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778738; x=1742383538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CiJA8cEstxgkTU1mTKMy0JGKZ+R8iGVjaXw2iJxWSRI=;
        b=jxpRm+nEkoXRMGyl6NreHJi5FcZFYUPeFG3nP0OILD3JnWXmlhFnwctheTqM52YIK7
         84Vh/1Mr+0H6zJ0w8xmQ4roiTVEopTFZ1mD1TTLCbxuONE6Ob+RRTYq50dagGU5tvsZh
         YNfxCwhAcovKC5WmUH4se0D1kCGWYVPYJ1I3hOn/YgNn5NHx+HVeImF+alRgDVYmcd7L
         HAB+I3y33GKkl01wvMOQd8EsDVlxbWK0E3Dw9fuhI5h3RKuuH/wgD1kwm6zGczR5x+gU
         ftAtJYUcY9Cq0KGLU0iEjSDlMbULqZ7A9MdNu0By+zp8ZQGV9ktavjvoCwZNgtB7ToEC
         DXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778738; x=1742383538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiJA8cEstxgkTU1mTKMy0JGKZ+R8iGVjaXw2iJxWSRI=;
        b=nGfxgexvuv5BT3NKPaT50e/N9OOqdeFG+U3Kqw1I6mam3xz4bhS/rpUUrsbYx0f3o1
         CjRaEBrQx4DMfpPpU/9MVfVH1booo1SXtw28ar1ZnhFOiJU/svVrLUDKEKCvbiHaZ0Ij
         x9CrDhyqLEXhoyYRKoH+krlG95E99C/Kh+hx3MtcE5DtIOyGsIP/KTCwYUwhdzuKDUE1
         ztzVnPDKE7z+ad3zNQKsPd4MU6AcB2bPQS2Ddd9dNWLLsZBEldZGVRCqOKcZBlXCWO0S
         DUwv9hn4LQCv/DhuFl5s236cN8PhT12u0sd9oDfgW9+H5DdxWcVBZy83PZW7MYIkvWaS
         PNfg==
X-Forwarded-Encrypted: i=1; AJvYcCUW2tTcOgd6PTZygw9fjtluuF3ZVy9KZo5CVVNyPOp7BfqjSBaoDIDQA/KvjVZyHwpdl91fIseOywi6fb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH9tU18Qy3N9XUx7iPySwS5er+v2KWY2SM6y73WsTum41jr5tx
	ppTKZzVaS7MEEpEeD/cjrgHWg2kDy97YSxTCFJKGwNGOJd4YAGVtoZwcxw8cGPYrAKsSBFNglbU
	UH7ZcwJ2SaV2FvSJ/dLpha65Y0ufDLiBodmP+Uw==
X-Gm-Gg: ASbGncsNkW8ysd1Ld4z92OVwOQdFuvAk/jw9WXUBODlVd9iiD8/rLKb5fApKDVSLg+G
	KlesxPR5AvIYt05pTUYXjVQAWbCV/TjH/i7Yz6yz8OKecau5JN/P1uq/Fet//K9HBl3B37BsojS
	A9k62MCSxDzIR3TJV67g/tL1Xul3E=
X-Google-Smtp-Source: AGHT+IFsXLs0G0P0sl4PUE6UPS3JqqtQHaqryQbTsh+V2XVD4bcZpoq0lGo1l4XslguvHjeCee00G9KHRf+J4fl/2ps=
X-Received: by 2002:a05:690c:4b13:b0:6fd:33a5:59a with SMTP id
 00721157ae682-6ff091eaa41mr105598827b3.18.1741778737979; Wed, 12 Mar 2025
 04:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307005712.16828-1-andre.przywara@arm.com> <20250307005712.16828-3-andre.przywara@arm.com>
In-Reply-To: <20250307005712.16828-3-andre.przywara@arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:25:02 +0100
X-Gm-Features: AQ5f1JpRnOY3arJkwpPqmP24JF8uLy0s3IwIKNA_9eLVMdzcVYtTB4PX7y_pSng
Message-ID: <CAPDyKFoFesrcYPDNDsvU_mLdkTGE2=7TCFrYkdFW3bp_0fLSMg@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] dt-bindings: mmc: sunxi: add compatible strings
 for Allwinner A523
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 7 Mar 2025 at 01:57, Andre Przywara <andre.przywara@arm.com> wrote:
>
> The Allwinner A523 uses the same MMC IP as the D1.
>
> Introduce the new specific compatible strings, and use them with
> fallbacks to the D1 strings.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> index 8e4c77b7e4ab9..9f3b1edacaa02 100644
> --- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> @@ -50,10 +50,14 @@ properties:
>            - enum:
>                - allwinner,sun20i-d1-emmc
>                - allwinner,sun50i-h616-emmc
> +              - allwinner,sun55i-a523-emmc
>            - const: allwinner,sun50i-a100-emmc
>        - items:
>            - const: allwinner,sun50i-h616-mmc
>            - const: allwinner,sun50i-a100-mmc
> +      - items:
> +          - const: allwinner,sun55i-a523-mmc
> +          - const: allwinner,sun20i-d1-mmc
>
>    reg:
>      maxItems: 1
> --
> 2.46.3
>

