Return-Path: <linux-kernel+bounces-256228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F4E934B11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684561F249D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16070839E3;
	Thu, 18 Jul 2024 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IUlJO1ih"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49438002E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721295739; cv=none; b=bswhxPC6PSK0VE0bV0dOEzJWeI1n3+w8QhHGikuaWoRd6aew9fe+lIOPPORLpgB3KO7TmA6tpWpa8TBdcBnMdxHIlybrIinxa9azuVq6ylL4pl0G+SZCGlu0FQKRVDrBYqld6yXvio+nYIzOABiry0NFe48tMrUIXGRYU/gcR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721295739; c=relaxed/simple;
	bh=ma1jqCvpXLvw/qJ+K1BuBiSsJ9sT6SZ1Fzi3osTq3Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4jTRGEoQqzmLxmHcfmhU/DYiGpBNZ15ea0Q3yfHzgHll7wmhAkd8ulBN/fRmCd5WwkoRsXMcVksdPIn+3SfZ1jxFEUhmDV0GIrmNyzCNC087TQvGjY0eBDM/yLnB4ywCpb9y3b/O79sIEOEElQmLs56mf1CefB+Ei6p4MmYsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IUlJO1ih; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-824ae03efbfso41985241.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721295736; x=1721900536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WurLU3I0ZY0rwZGNbG1KQfDTWM2GScsE4+HGMoCekcE=;
        b=IUlJO1ihpZxhv1O/+rr5lj2aYpAESctxWkKByH88QcAfRDMRsqSptGLPPH3irrc8DD
         M0Io2wnQVHn0bd2eKirP3w//RMBOFKp9XnJ+CA5lcv7UWZeEATyTBC7mLMD6df0auAhu
         9iQTUE0ilsvGop1AiY/wCvNShT9Bu+duDdins=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721295736; x=1721900536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WurLU3I0ZY0rwZGNbG1KQfDTWM2GScsE4+HGMoCekcE=;
        b=UylCKvlxVeBcunQ6umwsLx3kWRV7wrHWMJWjD2pHCcjqhbtMvy4UevUcW2kCkdRwxe
         TpT3toHo8jcgnz4TzPfC20nuGtsHdpVm8y5mDgiQbkEI/EdISwwCb0+9j45DJvaizy43
         MH8nZOI7apUmN1HaSNt5/VIkErkYqwdmfofFAfyOoFZHS8FstSpl68ncLkjxYybYv1sA
         W3AVOloZklPAYfSOMhDs7rgwxfuUlvQlyoNV58SmR4Ldb5VBdlmmgWmh/bOHE8HelbwH
         Vh4mrRz5S+6kbHmwXTFmbXcwfdSdCXfrMDcKimeMHJ1jazcYF6qCXrhOss3pW0ONlqAO
         eKbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfxAzvIZXVtZNkjgtmNyJXohp7+ulH13yNhyGrP3f4PfXrEBLbg9QiQQHYR9Mkka5jUl7h1rQYVcvei+NSlr1kmvmRdh8vvMexnlBB
X-Gm-Message-State: AOJu0YxzYbN6vFakYcUGIUdLOED4PF5eY2T483sB/9NFq8aFCGsKLkoL
	0j6Joa13lnhfyl2QK/5YZgKT4ib1zxUDtztFSF2BljDDAiChzRo5OrjYwodp6qjJeH+RAXcAjQT
	MBQ==
X-Google-Smtp-Source: AGHT+IE3UYDH3SV1c68OjdSK/ijE7twG+2idCzWQUq6kZcyfX9fa3gkoe+h5PH6YaBNzbteOngH6Cg==
X-Received: by 2002:a05:6102:578c:b0:48f:e86c:5e1d with SMTP id ada2fe7eead31-491598e1ec3mr5960892137.9.1721295736437;
        Thu, 18 Jul 2024 02:42:16 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-822c4ec801fsm130862241.2.2024.07.18.02.42.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 02:42:15 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-48fec155a0bso220115137.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 02:42:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFuE5vF29a3psldrbXYvf3wtazy5tmVG4S6TBVIxNrtsbJAPDU3lf49ZT7g50tetJC+iiLKFQAleCYUPwvPWzsfrGHud9H0zet5AKC
X-Received: by 2002:a05:6102:8014:b0:48f:bbf3:b8b5 with SMTP id
 ada2fe7eead31-4915986a8afmr5862849137.7.1721295735028; Thu, 18 Jul 2024
 02:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718082528.220750-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240718082528.220750-1-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 18 Jul 2024 17:41:39 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhmuGfaQrK-3TZzY3-c1_cDbB5g_Zp2nXOzg6zQZ-j4Lw@mail.gmail.com>
Message-ID: <CAC=S1nhmuGfaQrK-3TZzY3-c1_cDbB5g_Zp2nXOzg6zQZ-j4Lw@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: reset: Remove unused mtk_register_reset_controller()
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, matthias.bgg@gmail.com, mturquette@baylibre.com, 
	p.zabel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-clk@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 4:26=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Now that all clock controllers have been migrated to the new
> mtk_register_reset_controller_with_dev() function, the one taking
> struct device node is now unused: remove it.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/clk/mediatek/reset.c | 59 ------------------------------------
>  drivers/clk/mediatek/reset.h | 10 ------
>  2 files changed, 69 deletions(-)
>
> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
> index 290ceda84ce4..069f9e909cb0 100644
> --- a/drivers/clk/mediatek/reset.c
> +++ b/drivers/clk/mediatek/reset.c
> @@ -110,65 +110,6 @@ static int reset_xlate(struct reset_controller_dev *=
rcdev,
>         return data->desc->rst_idx_map[reset_spec->args[0]];
>  }
>
> -int mtk_register_reset_controller(struct device_node *np,
> -                                 const struct mtk_clk_rst_desc *desc)
> -{
> -       struct regmap *regmap;
> -       const struct reset_control_ops *rcops =3D NULL;
> -       struct mtk_clk_rst_data *data;
> -       int ret;
> -
> -       if (!desc) {
> -               pr_err("mtk clock reset desc is NULL\n");
> -               return -EINVAL;
> -       }
> -
> -       switch (desc->version) {
> -       case MTK_RST_SIMPLE:
> -               rcops =3D &mtk_reset_ops;
> -               break;
> -       case MTK_RST_SET_CLR:
> -               rcops =3D &mtk_reset_ops_set_clr;
> -               break;
> -       default:
> -               pr_err("Unknown reset version %d\n", desc->version);
> -               return -EINVAL;
> -       }
> -
> -       regmap =3D device_node_to_regmap(np);
> -       if (IS_ERR(regmap)) {
> -               pr_err("Cannot find regmap for %pOF: %pe\n", np, regmap);
> -               return -EINVAL;
> -       }
> -
> -       data =3D kzalloc(sizeof(*data), GFP_KERNEL);
> -       if (!data)
> -               return -ENOMEM;
> -
> -       data->desc =3D desc;
> -       data->regmap =3D regmap;
> -       data->rcdev.owner =3D THIS_MODULE;
> -       data->rcdev.ops =3D rcops;
> -       data->rcdev.of_node =3D np;
> -
> -       if (data->desc->rst_idx_map_nr > 0) {
> -               data->rcdev.of_reset_n_cells =3D 1;
> -               data->rcdev.nr_resets =3D desc->rst_idx_map_nr;
> -               data->rcdev.of_xlate =3D reset_xlate;
> -       } else {
> -               data->rcdev.nr_resets =3D desc->rst_bank_nr * RST_NR_PER_=
BANK;
> -       }
> -
> -       ret =3D reset_controller_register(&data->rcdev);
> -       if (ret) {
> -               pr_err("could not register reset controller: %d\n", ret);
> -               kfree(data);
> -               return ret;
> -       }
> -
> -       return 0;
> -}
> -
>  int mtk_register_reset_controller_with_dev(struct device *dev,
>                                            const struct mtk_clk_rst_desc =
*desc)

I guess that means the "_with_dev" suffix here becomes redundant and
therefore can be removed.
Do you want to update it all together?

Regards,
Fei


>  {
> diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
> index 6a58a3d59165..562ffd290a22 100644
> --- a/drivers/clk/mediatek/reset.h
> +++ b/drivers/clk/mediatek/reset.h
> @@ -59,16 +59,6 @@ struct mtk_clk_rst_data {
>         const struct mtk_clk_rst_desc *desc;
>  };
>
> -/**
> - * mtk_register_reset_controller - Register MediaTek clock reset control=
ler
> - * @np: Pointer to device node.
> - * @desc: Constant pointer to description of clock reset.
> - *
> - * Return: 0 on success and errorno otherwise.
> - */
> -int mtk_register_reset_controller(struct device_node *np,
> -                                 const struct mtk_clk_rst_desc *desc);
> -
>  /**
>   * mtk_register_reset_controller - Register mediatek clock reset control=
ler with device
>   * @np: Pointer to device.
> --
> 2.45.2
>
>

