Return-Path: <linux-kernel+bounces-244865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD9E92AA8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCCA283148
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCF614BFBF;
	Mon,  8 Jul 2024 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpBFcbj4"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4812414B962
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720470417; cv=none; b=lwaJO8Gy2xMjJxmfTfZdWYYOXmaMxiNDWE9L9mJmIxo3rrv/989ZJ6nqvTcT/nmRJgSnvTO5GTIXkeXmDPsZGmT2xF+3uPmAOk14cxubKZMFKb8QMS6R/c3tJ/TsmIYEcDTYaCBQGvzWPrcyLWeNzCOtIFIIAfKt+idsa448oLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720470417; c=relaxed/simple;
	bh=iP0jvq7PGIFczaEA5bqaPg8rzTLnc33XdldzK181P5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Md6zSVTGL6LsUe1WuyLF29IIcjhDn5d3hbDjoGZJE9sh4IxnZ8e1VY2ayR+hhECjGnXC0gf57Dm2dXy2OoFxeUejK7AH+q41Eo8SjVPzaFz2jks4yaWjXjVTKaNTbuQl/+foYp0F3lhbZR8vI1Etfsf/XnV5ow252/NXuD9HVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bpBFcbj4; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-654ce021660so24842957b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 13:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720470415; x=1721075215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQqAxoPni/sISUNtLPGbi6yaKTLLkE7TWz06MwgXUpw=;
        b=bpBFcbj4V+g9sYzyufrCz+ceNYlJ8B73U96MDIBLf8IBoUzymmB61yuip291Ci8fgF
         iZNDkatbR/84jHsW26gu1p1J9s8dJOFOmTR2qa7TbXtLx3MNLGdagquAx3xGadeN13tg
         hx2Dx3Y4W3rD8C9xMvbJOFUR9s+IS4u7OMhnLm4IAMIA6hN1vn4gWzBE973ffeeugQYe
         d6MMfsRBTp2Rh8aj1A6o56UPpp1A4YMhfH/tNtkFPR36rZFhK+W9BsyZ4OZ8ETiC6lAA
         t8ljsWtS5g2koclncYr7vQyW1giEPdUiHAdE1XIybYoSYuDoERDjDmojUzA+j0XcErYo
         KBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720470415; x=1721075215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQqAxoPni/sISUNtLPGbi6yaKTLLkE7TWz06MwgXUpw=;
        b=GBTEbp1ZAvqoqmD+h9YSdjRc/fYigx1h73bNbYLkJ5E5ZAy9Vo6X1y7I8urW6n5ZFQ
         gMxNDtZGMwax1HQyXLqt9gr/QUOemdVA77OrlQxdjcwL7KQymudW/zOvBmsA8YZXaMyI
         sMt0XkJPnf7nwbOx3Yoy2OAwQT8463Ubf59T5lYYswFctjdfFltPHLEiMcWr2zEUcyLL
         4cn8UYu9DrKilETVIf/0LZHGoOAmz1wpH0rnGXx4sWEpIrfRHtyFCxla3G//BcvnTV5Q
         cmaf/gZMOVcTFaJ0pCOiX/X330ZKOKAp/OsL/JD+uzH6I7yM6A3ZFd8jWJAhNlIaCm1+
         FsoA==
X-Forwarded-Encrypted: i=1; AJvYcCWioIHyh8AvfyNjPm26oKRa1bSYBd5/xxrUCXcUTWPuH7PgFcqU3rNoWHVFSlS3T4gph+zvzBjE/73y9hjSpXQnQKoRacyNXEgyJ45H
X-Gm-Message-State: AOJu0YzvI1+Xu4+DVCYo1v4y5hpy/xiTTGEBlMzOGqvo2HXie4PWpDm+
	N9rkahjh5oWHEULlMyJqJW19vjJmvmpBv8XczObHbrvXXLp4vLBeF9RnA4AnDg9MrtUHeyJG4Vl
	xqIFVlcN+nuF6gNYkblYRYBj1C9TaSFLj0lI6QQ==
X-Google-Smtp-Source: AGHT+IGO2ni/QPKZ5DyTQznLmq+yxlD7B6UffX80ITsFXuqHyccHxv2wbcoz3FyUQBIlQaTdDB4QDOW83uoQ6RkVu50=
X-Received: by 2002:a81:ae04:0:b0:649:fa54:1f8c with SMTP id
 00721157ae682-658f11a595cmr7769077b3.48.1720470415272; Mon, 08 Jul 2024
 13:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a956a3e2-c6ce-4f07-ad80-ec8a96e00d16@stanley.mountain>
In-Reply-To: <a956a3e2-c6ce-4f07-ad80-ec8a96e00d16@stanley.mountain>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 8 Jul 2024 15:26:44 -0500
Message-ID: <CAPLW+4kwiKUUdwPW-TjdXEWivWbh4dTe+LYqsR+YssYy6XSzvg@mail.gmail.com>
Subject: Re: [PATCH] phy: exynos5-usbdrd: fix error code in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 12:04=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Return negative -ENOMEM instead of positive ENOMEM.
>
> Fixes: 497ddafe915e ("phy: exynos5-usbdrd: convert Vbus supplies to regul=
ator_bulk")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/phy/samsung/phy-exynos5-usbdrd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsu=
ng/phy-exynos5-usbdrd.c
> index df52b78a120b..9cbf90142950 100644
> --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> @@ -1745,7 +1745,7 @@ static int exynos5_usbdrd_phy_probe(struct platform=
_device *pdev)
>                                            sizeof(*phy_drd->regulators),
>                                            GFP_KERNEL);
>         if (!phy_drd->regulators)
> -               return ENOMEM;
> +               return -ENOMEM;
>         regulator_bulk_set_supply_names(phy_drd->regulators,
>                                         drv_data->regulator_names,
>                                         drv_data->n_regulators);
> --
> 2.43.0
>

