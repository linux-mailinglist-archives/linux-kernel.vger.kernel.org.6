Return-Path: <linux-kernel+bounces-439683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843D19EB29C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B0616DE54
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434231B6D09;
	Tue, 10 Dec 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MxHEZvkj"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053C1B394F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839359; cv=none; b=TTqnY5/bkAL4nJeaCEyl7yG7e/G/3KnsRnTxxLpGQ32b53Zesze5xOf+Rd/aAnVitbQ9dk7vz1+nq4xT0s84bI85aCflYCgIcvrleRGD07TiiqRhQptVsEZo/HCYwn5rpoM/6iKYElo1C0ZVzPh0tVcS3aMD9IP8DfgwUQCsFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839359; c=relaxed/simple;
	bh=+VAbStbA6Dtk2xH4PoQloVbS2Ysd+xnTztR7r3KJspw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfmJw4dSXWaHGeZWHGznuNTvf/gLwxaj6sB5HM1mSo60crRZ5yYIhDuNY0oKwiHNrmEgrSHoVbqzwrh3S7JOV+WJZnOJOixEQox+xnHdBrwN0sP2+sTQSoWLTj3Px55tUUi25pV65c0p0FvBl09TzSSJzz9F23JrdkoMKNoAaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MxHEZvkj; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e398823d6aaso6153976276.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733839357; x=1734444157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=svYQuLfhEmqpsKGv5zmj/4CoEXZ8crstXQtR8B+VCUI=;
        b=MxHEZvkjU5pWnoR5pH6qtN/gX7VR/YJlN4Qaokl/dCjTrvFJ+XD9nDW3YRARTDddyK
         4dIm+8h2kJ9a4honmbTqN1FfqzMAKktZkrlWPS8QeValUU7eUmoY3/deTa3JA0th6rhd
         YIxjS18T0tnBoawtwAB2WAYMDd1vJBM8Ma8r4lka5lpXeRtTznWsDz6/Vc0kOeyY4stG
         Bl9c7nSgBe2zchdjy91LYRPOe9MdyF9RBS/rhvQLfP9HqHoy3bOh8Xpbt2VweRYAA3L3
         T9D+xJjWr9BnhtM6ty3w9YZaVmhVHCcvkAfZAx1XKuBmipouBtrcUIPI0WkitRdtdVXZ
         v/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733839357; x=1734444157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=svYQuLfhEmqpsKGv5zmj/4CoEXZ8crstXQtR8B+VCUI=;
        b=u3xoH86uWcvbWqdbBaQnllyKJU7ZD6ILznjXYhJZUKd1lR0sl0WUaDRWGRe1nPfnAH
         VrvtDp1NPIsyFylMUGGcjE/UlOC58Zrkk94WCRnf0FjNOQsWs8lvM8YeQ5/Nl45Z3DFU
         8FVpnBhqpUEo6PPVTMBMuvyTyLXhHK1/oIstuugX3ucfbDjXHDeiaf4M6+KoNRt0HHi9
         o4AsI1hzmXKwPl2kGcEPfzjSgsPFIx4fYPpkfc4N+iKGgo+hT864rAkPcHRIWBdbtmhR
         NfnwtkCEuPwaYbTBHCV9Cao9QA6rGlTqoF8ZTxiIhBEvFDkRbL/W1MfzGv0hZgAQ/GxK
         FO5w==
X-Forwarded-Encrypted: i=1; AJvYcCW1WKLNVfOLe3x0+/T4RJmnK1BdX07WJP34HdButGo1P93wGj7G7F9/3PYAOIAupWiePvksL5q7sAEIKuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7i5bLASLfSe6lIly0k6Pk1TGWwMftlIUiuWsTi5JtDdGvBlNr
	Kb3x00NMLFBUGHgrJvIkxX+v9ELPsf9gLlfTNQnssM1cRzQs81fhvW2g5DoWaDSjNcXInMzGJJZ
	x8mSpBUKCM769q+oZc7hATb2nbp1J8PFWTsV/QQ==
X-Gm-Gg: ASbGnctoAa+BQ0yTQv9G6S7zR6puo+zz3E0LY8/kMqfTw1ErjtkhmculMapDr7asekP
	Km3dI7lSgnDOX+C6YR7KQ4JU69bYtk4P78gL6
X-Google-Smtp-Source: AGHT+IEzJ57H7PCrVou6RI7FrtDurF9EfDkpfB6eGI/q6LZuE371TG4kiUTgbNmxJFhn26kfli9GuUqdDrNxsUfzIjY=
X-Received: by 2002:a05:6902:1501:b0:e38:b399:590b with SMTP id
 3f1490d57ef6-e3a5da3808amr3395172276.2.1733839357084; Tue, 10 Dec 2024
 06:02:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206112731.98244-1-peng.fan@oss.nxp.com> <20241206112731.98244-2-peng.fan@oss.nxp.com>
In-Reply-To: <20241206112731.98244-2-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Dec 2024 15:02:01 +0100
Message-ID: <CAPDyKFpWfqpgmMpuq+69ee2FU7wOSgHUmfEcLpS1Dy2vx8c-MA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pmdomain: gpcv2: Suppress bind attrs
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
> The gpcv2 drivers on imx8m series are registered as platform
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
>  drivers/pmdomain/imx/gpcv2.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
> index e67ecf99ef84..4db4d666f5bf 100644
> --- a/drivers/pmdomain/imx/gpcv2.c
> +++ b/drivers/pmdomain/imx/gpcv2.c
> @@ -1437,6 +1437,7 @@ static struct platform_driver imx_pgc_domain_driver = {
>         .driver = {
>                 .name = "imx-pgc",
>                 .pm = &imx_pgc_domain_pm_ops,
> +               .suppress_bind_attrs = true,
>         },
>         .probe    = imx_pgc_domain_probe,
>         .remove = imx_pgc_domain_remove,
> @@ -1549,6 +1550,7 @@ static struct platform_driver imx_gpc_driver = {
>         .driver = {
>                 .name = "imx-gpcv2",
>                 .of_match_table = imx_gpcv2_dt_ids,
> +               .suppress_bind_attrs = true,
>         },
>         .probe = imx_gpcv2_probe,
>  };
> --
> 2.37.1
>

