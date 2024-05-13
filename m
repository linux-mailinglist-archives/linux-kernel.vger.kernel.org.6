Return-Path: <linux-kernel+bounces-177568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55038C40E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72E81C21631
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE2014F9C8;
	Mon, 13 May 2024 12:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA4Z7vP6"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB64A3F;
	Mon, 13 May 2024 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604047; cv=none; b=Jd03zIctPszdZl0WV+Lswqgq5+s4EN2aL85Dnj9uGiYKFPv2cYDkRlfKwb+i1c+bx9sk7gVVaPhjVyGmTLIAJv235BOiy51ZWalX/Q1LgBFIwyrck8sjrmKbBK36bwXx4YGXHeI+h7kKDt5MDbz2UPYVAhGIo63ot5RBVGdmSdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604047; c=relaxed/simple;
	bh=w2F7IUkcAC7aB3Nq4XW5MR7FrwSIJSgwqZe0Qj/b/z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dcKhZeTgsaGE/e+LLgOmxEQALvoS0ikPbfD2ixU1TLkZH7KhzO29fNQo/iDHzPOuYJ3CmRGoCsInljJySMPxNQ/CIh8k+cqYG97MOzuzCN7d1djI2wtKxNYJ7bLd34G5GtABZIgWzQUQI9177YaAswOsEvSqhm4Zc6cjeZAJdRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA4Z7vP6; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ad8fb779d2so3008736a91.0;
        Mon, 13 May 2024 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715604046; x=1716208846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5k8gT3oHNPh1LBJEkswvOb6QJDXdUG4eOyHdkELqHRI=;
        b=BA4Z7vP6Fh6+yzZPhe6Wo2zwpkJujTJVl1br23kvU0toFr72W+XoiQEPeFjyKpVN0e
         0d2W/Djw8fD8c3EAv9BcRXtI71U9dt11lhvkvE1E2ia6IBlxDc6jhc5ka4TTO0j5otM+
         71i9MJ39KhPU2qNcMl+HRPs159zwkgOZWcd+RKTAtLUf0awyVdYwszOowQDOFwM7Z7P/
         V+87sUW8mdUMV8ibEUOnocboqIKXmYCgvdQDOzkkThUG29EXPstTQs5plM76jCFNXvTt
         zQia7OjLD7iZ0A4zzQvGWLNZvtoB4dDt6JcGyXFU1n9D17zigP99A/ODDfo3Mr+WJZ18
         9Xmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715604046; x=1716208846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5k8gT3oHNPh1LBJEkswvOb6QJDXdUG4eOyHdkELqHRI=;
        b=kbeyvngueLvrRRcGdOsMnezkyvfCjDS713uOxg5rWxKiJtT1I3HaEZ2Y7ny/xU/50D
         kAtQOt73dIVB+ETEXtVJQ3KAiEV7Lkv+LolUSeMXzxBmIyEitXvNlo7Z1ScAaF0Pn3gd
         kpmWp1Q0sWO3bOCDUebXpOOgL0xTsjctoU5ThfJBwy6Ac0xGfOOEsAHD6nPmVNXHG5S6
         tjVw7Q7luwXdmtQlT3X8gX7+zv3xU4RUd4Td20FQxAJzOEjmX2HBAulMYUKmwzWe2Js2
         b7e3+UGv1r8WE+rXAqZwJDQoHyRSJw5bAaT/cUgaYpJza85Gpa0zjeABD7peOYnYFeW8
         YU4g==
X-Forwarded-Encrypted: i=1; AJvYcCV7ObbORTn+js4cDa4SOPCGUVtKHLw8XPLXydBtSB8UIgNIVFsSAmdCUinqKgb+onnJKZTAtNVlVLeajD5ylVHRjmMDecuOG5cpuYFqpEUGBP1Ak//JF8ONg8ODz0r/CGHYcca8ZIU/
X-Gm-Message-State: AOJu0YyDxo3+wJEWIAnlJluLIsmL809EcAvfCjFeIgrXArKQGEd79lwr
	ahC36DHGprcK6r3R4uFWpvteE8c+Zs/m+f1zmNmMFGImOO9v+uVNRritCKuBf4yNHBtjl2jr5vQ
	O1QpHPTeoFiCtTfUmWVEHrBP6MBE=
X-Google-Smtp-Source: AGHT+IFKvFGDNjWqsC37PG60kuZj37qvqWxTZdYiwXWhMF84+yxKE6jRgoEVdJx7ZcsxrhynwdD5U2PpnyKfQpChwU8=
X-Received: by 2002:a17:90b:1086:b0:2b2:7055:5a8b with SMTP id
 98e67ed59e1d1-2b6cc757f22mr450787a91.21.1715604045679; Mon, 13 May 2024
 05:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com> <20240510-imx-clk-v2-5-c998f315d29c@nxp.com>
In-Reply-To: <20240510-imx-clk-v2-5-c998f315d29c@nxp.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 13 May 2024 07:40:34 -0500
Message-ID: <CAHCN7xKXjuEBb1wTm0-r-j4iCnSYuq_f-AtPpOZG-h7DtSo4aQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] clk: imx: pll14xx: Add constraint for fvco frequency
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, Chancel Liu <chancel.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 4:14=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> The fvco frequency range is between 1600MHz and 3200MHz, without
> this constraint the fvco may out of range, the real output
> frequency is no accurate.
>
> Aslo correct the name for fvco and fout clock.
>
> Fixes: b09c68dc57c9 ("clk: imx: pll14xx: Support dynamic rates")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Acked-by: Jacky Bai <ping.bai@nxp.com>
> Tested-by: Chancel Liu <chancel.liu@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-pll14xx.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.=
c
> index d63564dbb12c..55812bfb9ec2 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -131,7 +131,7 @@ static void imx_pll14xx_calc_settings(struct clk_pll1=
4xx *pll, unsigned long rat
>  {
>         u32 pll_div_ctl0, pll_div_ctl1;
>         int mdiv, pdiv, sdiv, kdiv;
> -       long fout, rate_min, rate_max, dist, best =3D LONG_MAX;
> +       long fvco, fout, rate_min, rate_max, dist, best =3D LONG_MAX;
>         const struct imx_pll14xx_rate_table *tt;
>
>         /*
> @@ -144,6 +144,8 @@ static void imx_pll14xx_calc_settings(struct clk_pll1=
4xx *pll, unsigned long rat
>          *
>          * fvco =3D (m * 65536 + k) * prate / (p * 65536)
>          * fout =3D (m * 65536 + k) * prate / (p * 65536) / (1 << sdiv)
> +        *
> +        * e) 1600MHz <=3D fvco <=3D 3200MHz
>          */
>
>         /* First try if we can get the desired rate from one of the stati=
c entries */
> @@ -193,6 +195,10 @@ static void imx_pll14xx_calc_settings(struct clk_pll=
14xx *pll, unsigned long rat
>                         kdiv =3D pll1443x_calc_kdiv(mdiv, pdiv, sdiv, rat=
e, prate);
>                         fout =3D pll14xx_calc_rate(pll, mdiv, pdiv, sdiv,=
 kdiv, prate);
>
> +                       fvco =3D fout << sdiv;

The calculation of fvco here does not match the comment above where
fvco =3D (m * 65536 + k) * prate / (p * 65536)


> +
> +                       if (fvco < 1600000000 || fvco > 3200000000)
> +                               continue;
>                         /* best match */
>                         dist =3D abs((long)rate - (long)fout);
>                         if (dist < best) {
>
> --
> 2.37.1
>
>

