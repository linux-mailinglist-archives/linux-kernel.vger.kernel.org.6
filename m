Return-Path: <linux-kernel+bounces-515204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1C8A361AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8CB188CA12
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14B4266B64;
	Fri, 14 Feb 2025 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yQmypplA"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38EB2661A9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546862; cv=none; b=k9xM1ADW7cPUxpv17AkOETH3GfSHySd4wmoTYIvCtk9WXPp0XfcV/umRm/3XxY671ToCZKrygZId0LAkW856oGsm5lmTbBkCV1PeeRjo0kOde3eTT04Jklo1Qv7TJgrrZfJK9oIaYbS0U9T2asKQ+4erdWka3ZH7xyN/y+j1xlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546862; c=relaxed/simple;
	bh=XV8AT4C5Gp3NId7z/OQmyfyGNoiIpsTboDGzh/JM5Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXowJ8XJT/Rflc78jBIqmPM0K/KjYBlOoSiyLL2EGMxar5oRiFzE50mBw3mgG7yy+NaJiIXEqrcyQz0qWSmgtZb2UtOOkcgvex6Fy5jYjqcFxE/z9VsrcwLHnfLzWvHTxZFTkIAsrQXZznL6pPPYD+5Kd5BVtImhB/yD8h2KR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yQmypplA; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e549be93d5eso2420186276.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739546859; x=1740151659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wygEz6vt3imSF3NwvzsbaEgG5kEjxbe8ddM+Vd/l/w=;
        b=yQmypplAo+bysWaEaKZ3ULDutOw5rDZQx76SFfcPaxlN1GqcxvawtHCw+z5khRyH4E
         6JOQLVhbIZ84vug8gYJLFtVG2Nif3vc61k7W+1bdZwx4IyQvRnLoo+U3ZNm2ZOm8UPmt
         KV4y+vjOyxa2bCyJaKhiNPMxZTRIXhKk9ltgHzK3RIS1y8hR3kYJT8PsQNjHpkZZlQuk
         4hlW0QmB92m2JoDJ6pqm7/CGmfxmqkkbkoOlmzprHgQCe6IFshmHK6jGT9CfSTjjweab
         7ibkuy7PbGG68IreLZZwPDahVtfJvwucA3pa4NigZrFCLXNITu/tRGGNr4U9sWxtYYwl
         ekLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739546859; x=1740151659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wygEz6vt3imSF3NwvzsbaEgG5kEjxbe8ddM+Vd/l/w=;
        b=KYkrVVsfE78Tr3y7jTfEfwdmnqcrmys4tg0GfepXVRq/a0UP4gQ/zhOrWOEJf7wti9
         4aJr5+c74QSjRRzuNkoYu0bq5l4UVcWPPNyn+ltSNnWlte9Krx62IMepMSMTNP27o+dW
         OmRzk+mwc/ouACj1DSteCDFq0deEY2S8yhjKe0QruF4h1ARrs47/YwcLPQc0ht9TrZVX
         sAGwSCpzVDb+I8sQF6NrWhuMmG+D0S2DMEeC00Ki2K8vVAT5eIN0eCrY7K0hkEvziX8R
         LMlet9Ug76d3K0826uCUiMT2fyR4s2AkZ2fKvEUyWGzHudAdj6ZxEpGmpNzZy1DYO/p4
         28iA==
X-Forwarded-Encrypted: i=1; AJvYcCXIQTW3oTmFjuTeMNnuB12pNXcGZxEYWR6cETri/k8T1nNvQX2mU3aIJYgSbS0lTBdwoEsus6u4Ztx9pBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSVCJ6+O3Rn1A41lFYhEWzXYccFU2ltj+jSRVzfDzo+Tvuh5wM
	94Pa+XMqSsoKuFPQ3n+eI5e0a5v1sxxyfs8eRfR2ODnpuPffprNUSB9IDnSe3Q8yoA6ua4eAdtC
	ymikJjwhbDI/Pm6K8gAPGbvbNfsuxqrsoVVeGIg==
X-Gm-Gg: ASbGncvU7ba5hvxSReWCM8wfrMMNq7CZCePatC5IRNHhD1luJWxa/ajsZQJbJNt9mgC
	P9qEuFQWwY703C/R4M00U40XMYFPjb68FIwBe0cWuLDk3/65h+1K4ihw+lmSlOHuwmF5FOpmiYX
	jrNa9aMMGu8hXs6AIAg4D6sl6mU8pPVyw=
X-Google-Smtp-Source: AGHT+IG4t59iStpuyGq1+m+dvxq6YGK16dQkcUOiGs7tsyDTNdFxcN+r/HnSGFs01wlQ6aVqrC6vhWCS/t0g0Qj+n0o=
X-Received: by 2002:a05:6902:f06:b0:e5b:21fe:d9bd with SMTP id
 3f1490d57ef6-e5da81026d3mr6137510276.10.1739546859693; Fri, 14 Feb 2025
 07:27:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-spi-s3c64xx-fifo-depth-v1-1-e1b1915e3ee7@linaro.org>
In-Reply-To: <20250214-spi-s3c64xx-fifo-depth-v1-1-e1b1915e3ee7@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 14 Feb 2025 09:27:29 -0600
X-Gm-Features: AWEUYZkkGWUD60LMpHEHi4hDR2nuH8MPeQ82wDcgpZ-r7ywAfZ4HSSClhEmifNo
Message-ID: <CAPLW+4n3bQOGDewkh1Yfftticp5n3sOnvmVxgNz=rnmWVf6vmg@mail.gmail.com>
Subject: Re: [PATCH] spi: s3c64xx: extend description of compatible's fifo_depth
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Denzeel Oliva <wachiturroxd150@gmail.com>, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 1:32=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
> The FIFO depth specified with the compatibles's data is used where all
> the instances of the IP define the same FIFO depth. It naturally has
> higher precedence than the FIFO depth specified via DT. Specifying FIFO
> depth in DT becomes superfluous in this case. Extend comment about
> compatible's FIFO depth.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 389275dbc003..9c47f5741c5f 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -139,7 +139,9 @@ struct s3c64xx_spi_dma_data {
>   * struct s3c64xx_spi_port_config - SPI Controller hardware info
>   * @fifo_lvl_mask: [DEPRECATED] use @{rx, tx}_fifomask instead.
>   * @rx_lvl_offset: [DEPRECATED] use @{rx,tx}_fifomask instead.
> - * @fifo_depth: depth of the FIFO.
> + * @fifo_depth: depth of the FIFOs. Used by compatibles where all the in=
stances
> + *              of the IP define the same FIFO depth. It has higher prec=
edence
> + *              than the FIFO depth specified via DT.
>   * @rx_fifomask: SPI_STATUS.RX_FIFO_LVL mask. Shifted mask defining the =
field's
>   *               length and position.
>   * @tx_fifomask: SPI_STATUS.TX_FIFO_LVL mask. Shifted mask defining the =
field's
>
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250214-spi-s3c64xx-fifo-depth-6787f108be83
>
> Best regards,
> --
> Tudor Ambarus <tudor.ambarus@linaro.org>
>

