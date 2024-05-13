Return-Path: <linux-kernel+bounces-178058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6558C4805
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 22:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2901C22C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C05E7F499;
	Mon, 13 May 2024 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="RfVuyz35"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61397E765
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630585; cv=none; b=tgUzhJBcYUuFR2NuplNv5TXcCCRAv9sfpspPMhH1oM0XO8WbTIb542tNvsN/8xGAaYa756bWkMLKgoR6X154DXJa8S5G9ukIjifaOqzT9GmRCoZjp0ZMVXOnw5t9QBLKdI1b+AqRgtv4rglkrypfBMVTJsx0TeRLG4VvBQS2DDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630585; c=relaxed/simple;
	bh=s1hXVf6tyL8uq55NXv8OQrk/qgk5wctwVrIENTgbzus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XEwcMTItx8bbZk8HWmYW/z072GJHMxkoUsRodXpof2UjESNE5yKhfir+5Te6cfZJvSlxoH/O6A4OPBbBpoGTWyH9YHeFNIIluepq47hmIkN1Wx1dg+2G/+qXPPIzlo5m5QjtU4ZpH4OM47n17u2njCAhVm/fSTfb9Qp5w+4h9ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=RfVuyz35; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-241ad94775eso1439827fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1715630583; x=1716235383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/mC8iHyEmlHpwqktNUilmvaxLB5nXIdCTUQODGPwBk=;
        b=RfVuyz35LfglAVOIwUtsA9iQZYEWDGQTmQEh6h2L4OPk2VqLbrWnDWFrE5heLsGTaJ
         8mKkQnBoY5rttBzbfPUqmmggKu4gO4QbEcBKcu8zGWtTSuX9Qvj0K9j8rteqlkR1PB6o
         y9FLJIpN4sBLLxUsMUn6Pcxq3h8CMmyTXRHTlM5uztiYsJSyXfo1O85tmdECBqdVmR+G
         PtQG4Rkv/jLeVVcZfVfiONnYBlK4Tpjc8GGzK2pnGyUT1DOHDghAGYWJV2PxhiaaK61f
         24GnvLpCXClUCfAC60XEQ/8JLYLrM9X/uD0FBZ+Py90j+WF73hoXPl5Cc1cAVRYSywaZ
         9p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715630583; x=1716235383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/mC8iHyEmlHpwqktNUilmvaxLB5nXIdCTUQODGPwBk=;
        b=scLUVL68WlbJ3nU9OLaPxNEbFMpuLcbdPuAUNEn8dVZWGHzc7A0rQ6gVdR7DsRJR9p
         ndRml2EYXUjYG2mRd9Uu48P2g/KNq+nr/LBGqwwQ47/q9ckUf02dDgssif4drN5tzKRy
         BeO0f0YoreEO3+9nnK1XqQURNcKFFljLRNkJNctPuQA1FLWY5ohyH3cE8swNupuVX6VX
         2qsE9318MTvTXOOLb+XD2ub1s4p8C8BL941bAT2wTcbC+x7jUHf63hrFSBOBo5reruV5
         DHPIBOIY4RC7mK2GUgM28guwZ/YXXecqRwbDVTyF0KuLUUtDLf71C7eFOi4O3pt7n6fl
         vKAA==
X-Forwarded-Encrypted: i=1; AJvYcCUNf70mBnjV4MCHsH2f6GX/zo0ufrFg0jLONPthYzdhc1a7wT3VB8J5Uj/ZPvKLC/V5yHgZ/qebIjhhp5XjXrp61VFGPWOqwkr4eETU
X-Gm-Message-State: AOJu0YyeS2By94HMcVzrg/1dafNShexWJ3/vDfulfx8GekhN+z3+0ia5
	juUDLqNiEWIDkT/6fTgZl6cGQdOVzory5eKcA1fbqP2hUpUUOcoCE/RYREeVNe+q1b9xv77M7K5
	ru6vq8Gf+CA5K1nfBpqrRrPPUG0opJ6mU0MXa
X-Google-Smtp-Source: AGHT+IHMvY4NwUqw059de60Gzl/JLpgWiP6Cdv3/1rHDK4v1S2yPxePJas+PW6SFNOzXbZEEw2kevniOpnmdQuaVQcA=
X-Received: by 2002:a05:6871:b27:b0:244:bb9e:bdbc with SMTP id
 586e51a60fabf-244bb9ed677mr6392251fac.10.1715630582870; Mon, 13 May 2024
 13:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513184514.3200222-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240513184514.3200222-1-harshit.m.mogalapalli@oracle.com>
From: Crt Mori <cmo@melexis.com>
Date: Mon, 13 May 2024 22:02:26 +0200
Message-ID: <CAKv63uvAe=RkZ6ytWfNkM5exy5ys5n2NwcJER=VMVAP+61-+rw@mail.gmail.com>
Subject: Re: [PATCH] iio: temperature: mlx90635: Fix ERR_PTR dereference in mlx90635_probe()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, 
	kernel-janitors@vger.kernel.org, error27@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,
I agree it is is copy-paste error. Minor remark below and a few typo
fixes in commit message. Thanks for your contribution.

Reviewed-by: Crt Mori<cmo@melexis.com>

On Mon, 13 May 2024 at 20:47, Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> When devm_regmap_init_i2c() fails, ragmap_ee could be error pointer,
When devm_regmap_init_i2c() fails, regmap_ee could be error pointer,

> instead of checking for IS_ERR(ragmap_ee), regmap is checked which looks
instead of checking for IS_ERR(regmap_ee), regmap is checked which looks
> like a copy paste error.
>
> Fixes: a1d1ba5e1c28 ("iio: temperature: mlx90635 MLX90635 IR Temperature sensor")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is found using smatch, only compile tested.
> ---
>  drivers/iio/temperature/mlx90635.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
> index 1f5c962c1818..2b61489d5ee0 100644
> --- a/drivers/iio/temperature/mlx90635.c
> +++ b/drivers/iio/temperature/mlx90635.c
> @@ -947,8 +947,8 @@ static int mlx90635_probe(struct i2c_client *client)
>                                      "failed to allocate regmap\n");
>
>         regmap_ee = devm_regmap_init_i2c(client, &mlx90635_regmap_ee);
> -       if (IS_ERR(regmap))
> -               return dev_err_probe(&client->dev, PTR_ERR(regmap),
> +       if (IS_ERR(regmap_ee))
> +               return dev_err_probe(&client->dev, PTR_ERR(regmap_ee),
>                                      "failed to allocate regmap\n");

Maybe fix her would also be to this regmap error message to include
regmap EEPROM?

>
>         mlx90635 = iio_priv(indio_dev);
> --
> 2.39.3
>

