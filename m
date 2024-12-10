Return-Path: <linux-kernel+bounces-439682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B819EB29D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABBD1881E87
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960361B3F3D;
	Tue, 10 Dec 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uEyXd1H2"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747501A2547
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839358; cv=none; b=OJjkSkRZC8n93eSbTJv9pVxNg62yl0pLbNvhapPV1jB5+4ZiFETfTuLDIlBFdIJ3AGM2cWIZY9GKrPbKqSh8DYiMztbVuiC+ReMaTHnukZShXoqiy5PabHyWFH5CpEQclK7JaUDavRPVT3iUeDi3+gYFysph1/YF72WQDvLnPOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839358; c=relaxed/simple;
	bh=TRfjmBKfiMFehXKfcPR5PjcSzxFgFyiC03eittaPsog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRN8Iov9nnMAEN9thff51SFBnU+xE4KdQlqKpHmt2sAmaBUkyE6wvEFwE34ZTBY+UAlSalMHSYGZLQwmY6FOv5kh61r2/9yfFmSwngg45ACcs0B2ehM9fuuNXP+IoMWN9jpFbAi2+7/bhFmQe9mZDJ4jHqEGCfPaUqVFB0GYal0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uEyXd1H2; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e3997835700so4433760276.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733839355; x=1734444155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=besKoqTUl8UspqMzSV4i/1U3YcYukO65Us63dIVJlmo=;
        b=uEyXd1H2sGUfptuvtqPpiahykBneao1Qix7Y4obhLNBLxTq5vC30nlIm50yL7n5fDS
         qMEnUfoarTdrar4RP1BTwgoE2vspu8bIlqMXDsPCxCLn1k+3P8PuI3RrHCYJCT9eb2z5
         /JYEYRRdFQxlygFoAzggFadtNFio6aV9r6oZ4vWDnz2AkvcHKnbcs/DaHJZtDfuDJRhB
         ytmNwk/Gwxy0DgtKlBi9vbptlKVlBNxkdkb8CliW3o51bQdWTrC7gt9gjl9mPyJQo9F+
         Pn+F2437/OqlJpoeFEXytCX5kHXuL8GqHa3xGFSZ6LK0l/OpHd1/yp2buzWfaToRwiYh
         Ca6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733839355; x=1734444155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=besKoqTUl8UspqMzSV4i/1U3YcYukO65Us63dIVJlmo=;
        b=e9kBREhgLvYtF4zhCHfsZlI3xeCNqbg8xZgbXjSpIvDDYtv2K8OvKT6L3+9maBJA0W
         NVXBjDj/8Mgn6TCGf7HgZVOTNihWAAR4gYNKZ0gNa5d126hX1/PRY7LkVxYxBqNpvCG5
         d4SAbpGy776oELcHimNe+7B/oXXB8AgKXtkDQQiqWthCi4kVghc3Td0HEcCJRLiCeNm0
         sNh+yE/6ukyUrqhdTu77HXV+fGTLOcpEn93rSNi+f2jK2y5GGt22sZaueKsPpt8ggIyL
         QBsLg0SRdlmtT/cRpJeeH0qVCODsyr8ozcWFzj9nAO1cRQaN5gokZSyLrwwd8moM2OHJ
         YqZw==
X-Forwarded-Encrypted: i=1; AJvYcCUIbpTp+tW5BCV9FmJHI1sxgYBCnXR/5cfCs2xEW8tZw72RGc+FLO1io2vrN9Muv7izqGTf0/jQLgEM9OE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfp5kBmUR+9DtOtwRkCdl957ilPaVWWxwYbHReXHiZnnUp4R69
	7kwySHKFqm1mxk6jODDhfykHkPNR762spa6kI89BJtNyLitGpILdkwdO11nl4Gj683HNNmaUqm0
	AT2Ht89IRVdmclxjPMduaPDlpRAaIXwO9yHZqCA==
X-Gm-Gg: ASbGncsbfE7ZbxV6LweHrmJI0jCZfrl8smVhPvszOUfOEM9VybZpQkj9PEINU1qdSAq
	Eo8xODbD5sCGq28XBTx7C7e3nkElPPnQ1Qzoh
X-Google-Smtp-Source: AGHT+IFN1yCbB7HlDLaJwtDy5HM3+UgGOrK5CihsW5CiH9M8fU1rwshFqKnyFZ0DMkKGTqWE5e1F/csj0lrK/77hhbM=
X-Received: by 2002:a05:6902:2b86:b0:e30:d4df:4974 with SMTP id
 3f1490d57ef6-e3a59bdca97mr3979566276.40.1733839355475; Tue, 10 Dec 2024
 06:02:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206112731.98244-1-peng.fan@oss.nxp.com>
In-Reply-To: <20241206112731.98244-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Dec 2024 15:01:58 +0100
Message-ID: <CAPDyKFrM6wX5uWY8g0pgZNEZn8uG5hbD4JsAijBenOMWkEgD4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmdomain: imx8m[p]-blk-ctrl: Suppress bind attrs
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pm@vger.kernel.org, aford173@gmail.com, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Dec 2024 at 12:28, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The blk ctrl drivers on imx8m series are registered as platform
> devices and this opens the possibility of reloading the driver
> at runtime.
>
> But this doesn't actually work. There are some hardware sequence
> dependecy between blk ctrl and gpc, also power domains are used
> by other peripherals, so fix this by explicitly suppressing bind
> attrs.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/imx/imx8m-blk-ctrl.c  | 1 +
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> index 23db85b7aa9e..912802b5215b 100644
> --- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
> @@ -894,6 +894,7 @@ static struct platform_driver imx8m_blk_ctrl_driver = {
>                 .name = "imx8m-blk-ctrl",
>                 .pm = &imx8m_blk_ctrl_pm_ops,
>                 .of_match_table = imx8m_blk_ctrl_of_match,
> +               .suppress_bind_attrs = true,
>         },
>  };
>  module_platform_driver(imx8m_blk_ctrl_driver);
> diff --git a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> index e3a0f64c144c..411dd548c67c 100644
> --- a/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/pmdomain/imx/imx8mp-blk-ctrl.c
> @@ -862,6 +862,7 @@ static struct platform_driver imx8mp_blk_ctrl_driver = {
>                 .name = "imx8mp-blk-ctrl",
>                 .pm = &imx8mp_blk_ctrl_pm_ops,
>                 .of_match_table = imx8mp_blk_ctrl_of_match,
> +               .suppress_bind_attrs = true,
>         },
>  };
>  module_platform_driver(imx8mp_blk_ctrl_driver);
> --
> 2.37.1
>

