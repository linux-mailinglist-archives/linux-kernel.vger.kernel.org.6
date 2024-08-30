Return-Path: <linux-kernel+bounces-308206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C1B9658A9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425E528207B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53013152170;
	Fri, 30 Aug 2024 07:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GovxOQT+"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3474690
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003251; cv=none; b=SA0skE4LjTETjeGFFC9x0EGcr1kFZNt6bpehbgZD9HxrR10ODkCDCqWiUE2NQrjlJWmqE4s8tRUjoY/+K/bsiL/VpBLVXKYUlg/8r6WeScVu4fJJAKBts+QvZfCnf3P/9glgBPQofRRk2o4i3HzuDZbs8xCl5/4osx/5csIgJSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003251; c=relaxed/simple;
	bh=6rOS4thftdkLACj8DL7TH3x+spejxCMrwKCO+yys2/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPFSqfqTlDzGbjNaIsUdFdq0vvz1ENe1z385cAP3yAUe8nsS7AmMMwreZ71Z9jn9EyykBC5difdkJBk70S47KbBS58mzGtSh0H8nP8qqoBqgOA9YfYPHj3vxNrhnUcYFIeF/k16lrm22d1OGowlVDaJplosFXAuT6jaoK00EA/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GovxOQT+; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5343e75c642so1918647e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725003248; x=1725608048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjDU8SQTmKK/G7tRsKNeXWmyDKNqd21oMmlCsoUCz3w=;
        b=GovxOQT+7iNGbjTBkO2T0jecegq8KMdrK8u6Lis1tp56uTAQDpH6lFxFp5eEfCcZgX
         WM+OsLkGgjudzDoIkKuemt4puNHJQLA8K9WVliI4RWyTcsVjAaT0YT1OFoe0MFykByqB
         yA7ooDKoppM2o7v/5GZjVhpbPAzceM8ZeAynE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725003248; x=1725608048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjDU8SQTmKK/G7tRsKNeXWmyDKNqd21oMmlCsoUCz3w=;
        b=karn4nUAXNrATyS7l2B1lBxV6+S8WUcpUHQAtD0rws+5VyMEn/RG9Yx/QWtbxYEVwJ
         Tv6I+ssiUlKNPwQe6wNaj4usHQh75NL//g8XP23yP2yrL+WneG4QwndE/eUGn6i8ft0z
         nmVEFq87xJ9o8LMjtAuJyf9P/OoVIscyDcghs6QLiqp8WjLuuE3x9TxcbJkCsE/uEo/O
         f/wunPRkqqGFAzQf5RbfIjpsxDwEzkTe0peDEmOgvU/TZKbC9OPhYOxf36PTmcRiO3hN
         YhnkKDMYnnhxhfdVWvqitGUQRZzeDhPGr9EdzXFqL5lOqD8dAsdizNlo5NJyNAzsgpoF
         u7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmCjD6iJbAON8popYOMIP2U4SNlBZpolTrWiIf8PHw9syytY9eskxDemAbOL7LBnKyoSrWXBYfzgrTuMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpTqt3Y9XpbC6xoWUehKGs7ZefpDa1mQxzDKcs/GzWFXj6UpLo
	PPf0tENoOeRjuWPOnS6WFcGQne/DiJD4EX+fELSDW6UQ3U8/ho7VaOl6wn9HuPhLRzsIxY72roo
	jC3pGNTV28Zta+fg3NNz0ApXhW4PfpJTeSpKI
X-Google-Smtp-Source: AGHT+IH7wPgJ8Pq7AE8R2q3EPuMVp2JyMekh2CKFeRsvF5v6qHF2reC1sUgRVhEZPF19o77fSOnVpNkjJfV9Xd2yI9Q=
X-Received: by 2002:a05:6512:3c85:b0:52e:9a91:bba3 with SMTP id
 2adb3069b0e04-53546b0ba84mr856388e87.15.1725003247536; Fri, 30 Aug 2024
 00:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830072611.332886-1-yanzhen@vivo.com>
In-Reply-To: <20240830072611.332886-1-yanzhen@vivo.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 30 Aug 2024 16:33:56 +0900
Message-ID: <CAGXv+5HtbAUvC0v5bnJrxD50Tfmb+i1h956-aJkbi+i_BWXcBg@mail.gmail.com>
Subject: Re: [PATCH v1] soc: mediatek: Simplify with dev_err_probe()
To: Yan Zhen <yanzhen@vivo.com>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 4:28=E2=80=AFPM Yan Zhen <yanzhen@vivo.com> wrote:
>
> Using dev_err_probe() to simplify the error path and unify a
> message template.
>
> Using this helper is totally fine even if err is known to never
> be -EPROBE_DEFER.
>
> The benefit compared to a normal dev_err() is the standardized format
> of the error code, it being emitted symbolically and the fact that
> the error code is returned which allows more compact error paths.
>
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>  drivers/soc/mediatek/mtk-mmsys.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-=
mmsys.c
> index 938240714e54..2f2aefd4d830 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -399,8 +399,7 @@ static int mtk_mmsys_probe(struct platform_device *pd=
ev)
>         mmsys->regs =3D devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(mmsys->regs)) {
>                 ret =3D PTR_ERR(mmsys->regs);
> -               dev_err(dev, "Failed to ioremap mmsys registers: %d\n", r=
et);
> -               return ret;
> +               return dev_err_probe(dev, ret, "Failed to ioremap mmsys r=
egisters");

Nit: I would just get rid of `ret` here.

>         }
>
>         mmsys->data =3D of_device_get_match_data(&pdev->dev);
> @@ -413,10 +412,9 @@ static int mtk_mmsys_probe(struct platform_device *p=
dev)
>                 mmsys->rcdev.ops =3D &mtk_mmsys_reset_ops;
>                 mmsys->rcdev.of_node =3D pdev->dev.of_node;
>                 ret =3D devm_reset_controller_register(&pdev->dev, &mmsys=
->rcdev);
> -               if (ret) {
> -                       dev_err(&pdev->dev, "Couldn't register mmsys rese=
t controller: %d\n", ret);
> -                       return ret;
> -               }
> +               if (ret)
> +                       return dev_err_probe(&pdev->dev, ret,
> +                                               "Couldn't register mmsys =
reset controller");
>         }
>
>         /* CMDQ is optional */
> --
> 2.34.1
>
>

