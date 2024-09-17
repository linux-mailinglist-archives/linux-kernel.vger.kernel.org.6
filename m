Return-Path: <linux-kernel+bounces-331589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E2697AE9B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400C0281CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ABE161914;
	Tue, 17 Sep 2024 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+wVIrlK"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065115D5B8;
	Tue, 17 Sep 2024 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568310; cv=none; b=WecPUnssghrz4SZLRNrvIoFbq/3HSzE97mA6ReozKv8W7GPEtYE0/9eOmv+PYoONRPLOD6WrV/VYoaIQ9aPW7uibfl28Actuy3zGFYsDn7RZIM/O1loJBuETLVqvtkl+am9BGipSPAS678tnTSVkK+SYqIsGX+h8PpzcRCjb6Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568310; c=relaxed/simple;
	bh=/CSOxkHfgO7zvTmBYBXJxaZ5unslc9ZBnbzkD7JUIXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fG4uU/UqL+Uzfwyy/k0ZT46r3ImSJqYFTND1mPo12/O9MJWmyj3TI7MXTKeQd5Pv/cZIk7ZsLqEmLERgq8pA1qLVwQFycrQH/1jwYoW3CHymd4g7nK+jgACed3G8Ew2mk0APCyiC/ynLLR/xfZkMkdEsI/JRCYaVl4E6/U+EHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+wVIrlK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d3cde1103so735328966b.2;
        Tue, 17 Sep 2024 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726568307; x=1727173107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j3I8RvtrkEGLcn/jjCsGtDX+89c/RzZJGXWndr0k2ts=;
        b=W+wVIrlKyBhQPtw2qoq43Rav3FhRQu9V8nHacXWo3ftjOthHIr+f422upBN3AVl+eG
         jg9ok72nE2VLFobNLJsine0Y2GvJMPZtoRF8JUn7M3MmfSindpwjiBoTnQG8SbHG8k8t
         cqOZucDBJTqXxPjCuf/uycmqpzhFipdH/EHlzhOQ/3A70dFG8+gowyUNa2gSKMkRPWaP
         PDSUReN8FHIxlpYw0xYTxrefFyIaVtYCYqEqRkfVgum3bL27UbQHYDQjm4B8Js3Qk1xT
         eaT1AuTlS+QFwdCtQ795ozLr3ZN5uTvuFZnvjSW3CasTJscQ7VC+wopQpTS2KvsQKeAF
         bDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726568307; x=1727173107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3I8RvtrkEGLcn/jjCsGtDX+89c/RzZJGXWndr0k2ts=;
        b=vTBkXky86BRauyKPkbo4eYVbLFrugM89GnTxlshqU72fpttwthV1W0nmm3DG+K9O5w
         DKFxdw6pvXSYOr2jRLk6A1CrCJvpKnu7vQBCNOiyZqfv8N/RVeb2mx2JxB2sdHwM5SaD
         KJ1LZ0kO0AmWxUg0LuyxLs+yIWddqM5gaPvpfCqfxGVOcgAJoa6aXuYlyOYyzwTrDrUI
         6EPiuPqu4VVHAfs8jwRBWOx6I0Qu7R2a4UZOQtn7lCVAA+HEN14OZJoO7et0WTnjl2QJ
         vc5IwM94xB607UFOqpHdusV/3slsCjsRyzYPU6pIG/LRoGjDjcL8Cp/j+0qsJiubuXIT
         /rhw==
X-Forwarded-Encrypted: i=1; AJvYcCWSuUW5TGdI+aS5YALIE7Kg4XpckEdtWDPSD/teeByYiXVLyG7zWICNNkpruBO2VoEAe64tL9iKLG2u@vger.kernel.org, AJvYcCX+KMKuFZB4i25cbB2mWdkA+1HBgvTiP4vg/YcFF/hcysLtvret8UKxNtZ1aZteYcheiJRBgjuwVBZLWuum@vger.kernel.org
X-Gm-Message-State: AOJu0YytxQpe0xcbWbNoajqdCrGMR8ud8/poNiYc7OXgGp7cMlUdn9ZW
	1Ox07ZQweO3qHAAYCiegVB2xn3e4PHE+d9lJinpRhw4EKHaNgWRFKh2/z/ypRqLfuKqAZMocHet
	kwVMyjqVZIidz5/UFWSYvekAwhg==
X-Google-Smtp-Source: AGHT+IFPC7DuVhYOkzCC23HgXMsE9KQr7nFypNg6U23LTW2Jqo3RSrdGkptdza7AxI6UwIQn0MGyh39umF9wjGpzJPM=
X-Received: by 2002:a17:907:f72a:b0:a80:7193:bd93 with SMTP id
 a640c23a62f3a-a9029447148mr1934202366b.25.1726568307199; Tue, 17 Sep 2024
 03:18:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917094956.437078-1-erezgeva@nwtime.org> <20240917094956.437078-4-erezgeva@nwtime.org>
In-Reply-To: <20240917094956.437078-4-erezgeva@nwtime.org>
From: Erez <erezgeva2@gmail.com>
Date: Tue, 17 Sep 2024 12:17:50 +0200
Message-ID: <CANeKEMMDj2D9x5jbOEbDDtbN_NG22mJwDPJva+bT-p6RJawMdg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: mtd: spi-nor: add OTP parameters
To: Erez Geva <erezgeva@nwtime.org>
Cc: linux-mtd@lists.infradead.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Sept 2024 at 11:50, Erez Geva <erezgeva@nwtime.org> wrote:
>
> From: Erez Geva <ErezGeva2@gmail.com>
>
> Some flash devices need OTP parameters in device tree.
> As we can not deduce the parameters based on JEDEC ID or SFDP.
>
> Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
> ---
>  .../bindings/mtd/jedec,spi-nor.yaml           | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 6e3afb42926e..d502b7fab2ce 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -90,6 +90,43 @@ properties:
>        the SRWD bit while writing the status register. WP# signal hard strapped to GND
>        can be a valid use case.
>
> +  opt_n_regions:
> +    type: u32
> +    description:
> +      Some flash devices need OTP parameters in the device tree.
> +      As we can not deduce the parameters based on JEDEC ID or SFDP.
> +      This parameter indicates the number of OTP regions.
> +      The value must be larger than 1 and mandatory for OTP.

Sorry: "The value must be larger or equal to 1 and mandatory for OTP.
"

> +
> +  otp_len:
> +    type: u32
> +    description:
> +      Some flash devices need OTP parameters in the device tree.
> +      As we can not deduce the parameters based on JEDEC ID or SFDP.
> +      This parameter indicates the size (length) in bytes of an OTP region.
> +      Currently the driver supports symmetric OTP,
> +       which means all regions must use the same size.
> +      The value must be positive and mandatory for OTP.
> +
> +  otp_offset:
> +    type: u32
> +    description:
> +      Some flash devices need OTP parameters in the device tree.
> +      As we can not deduce the parameters based on JEDEC ID or SFDP.
> +      This parameter indicates the offset in bytes of
> +       an OTP region relative to its previous.
> +      User can omit it if the offset equals the length.
> +      Or in case we have a single OTP region.
> +
> +  otp_base:
> +    type: u32
> +    description:
> +      Some flash devices need OTP parameters in the device tree.
> +      As we can not deduce the parameters based on JEDEC ID or SFDP.
> +      This parameter indicates the base in bytes of the first OTP region.
> +      User can omit it if the base is zero.
> +      I.e. the address of the first OTP region starts from 0.
> +
>    reset-gpios:
>      description:
>        A GPIO line connected to the RESET (active low) signal of the device.
> --
> 2.39.5
>

