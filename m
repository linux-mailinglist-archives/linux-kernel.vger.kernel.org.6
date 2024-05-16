Return-Path: <linux-kernel+bounces-180990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB9F8C75E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76241284E76
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBE8145B3D;
	Thu, 16 May 2024 12:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gULFJuir"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C4E145A12;
	Thu, 16 May 2024 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715861939; cv=none; b=pnlwVfVDeVbK7uxKcFDDL1CzuKhWtbiKEctnkBYhqdsJAtIDb1UsLikATJ4oMV7BW3QsGkDYJkX9NCtA+aUt/lKk+NbII9yeghOqH6f45ZSOthZFXmoYe00qGllz6uIhdIsdTfWDeVe0pp8rIbjavA1kztinaHNRSlu+LF8VhVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715861939; c=relaxed/simple;
	bh=W0y+avRcgtWQeVDf9R7wQoPEqMAtWWjnPy4BajP6cTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDknYbzd+56lmZzMUOaq75kRMY039QN6qkwwoGIR8mHVdhkn2+7TAqbC4P9AiLBHETlZ2JPrS3i3arj4k0ZmshBsfA71XR5so750paXaaev+h4ivpFJN8/d1br42yDMQkAfXYN+Nn2yNyilRaYHkkExXs3lmebOTiuvxotdTef0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gULFJuir; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b33d011e5dso103002a91.0;
        Thu, 16 May 2024 05:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715861937; x=1716466737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jekx64oHBwBXL4RMdSdE7ZiJluoUVRftBtOqhrpyhts=;
        b=gULFJuir/xN/EY6cWEhsKimMuRmRWNzzEXynQLoHOf16mswmKAS3vEInFI9bClUUTz
         uUiER4OFJHcDDGESVGq6q7eYoQWWopP2rpl0i5QzEt+yhTUW29rrPfoYz5PnKfeGW62F
         ToR8cY5aU7jy9KUGnEBxkck9zoOFdApotgJARLqspT03htPSP2KvRuFztc2TgX/lCT/c
         8PB8/StPJbapIQHppQnNGGO800qqDOEp/rSe8JJ4B6FR3pobFtONHG0Hdu33mkelUhgw
         oWMhVQaazr84nqQW5Jz9K4Cyu8CUhNHMAEhzgTM6tR3qMv9szKJ/ZCRVjNuuj4tOuFzn
         3zXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715861937; x=1716466737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jekx64oHBwBXL4RMdSdE7ZiJluoUVRftBtOqhrpyhts=;
        b=B7DO/6pyBNSvFlJ53GpkEuwhtzhmxYba+MMrhHTSMXic1K4FtVJCGg1fTnCmqipN6G
         U0thX7EJfNy4LNpjdoulPmA1Ni+4+tugdk70A7G7/hNQF074AH14TgHWS1nHSR5HBAQN
         VsqFMdhILXWtUirmuU0uQdPxyNLHctDvXp9LV0JK6V2AUN0CDjPH0oYdkdqy89uReljp
         piY0AxTEmomfZieTC1JEHHSs4QpDeaIo37vV/7P6J8+S8YP2U5Z4s0v29RUhRxUid5Pk
         Jc/lXF6N+G55Pb3jyvLTWUBLmvVccJ6sp0GUAMl1ZMCgYMEIRxgRCNGhMnEaenFbSpcb
         jmQw==
X-Forwarded-Encrypted: i=1; AJvYcCUq5X635V9PdQj5J+WstBpN6ptWEfLdtKo8xLcCT78+jGdcdvaJ80w72vqNGwTkf+e4w0JkA6I3CimyOvhrCnRKjm9sMSzc5g0pQrRbLm+pOBhhOF1vNKdLq0ujb0o+GipE3R7uX4Mg
X-Gm-Message-State: AOJu0YyN1NKI6118E9aOZbTLccgbj26pgYt5vVubL8rK/nZYBv95fplu
	kHq4gKRTzkL4XZa/AWXeaDK6lZVfYFBqpD4jSEe2YwAoP3i5BS9GsrWUP5c1pIuKuwYEINsNqf1
	YPltzysS3oOXDyr0wY4edZ95oQg8=
X-Google-Smtp-Source: AGHT+IHV+iGjWHQDDc1/wQXU0afN0otrO2sGh1kGYMr0abLfezvPHuUi+aKEXVySo8r5fXaooMNwMiEYCAl9GxsOl74=
X-Received: by 2002:a17:90a:6982:b0:2ab:8324:1b47 with SMTP id
 98e67ed59e1d1-2b6c75dc6ddmr27526142a91.15.1715861936928; Thu, 16 May 2024
 05:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504-imx-clk-v1-0-f7915489d58d@nxp.com> <20240504-imx-clk-v1-6-f7915489d58d@nxp.com>
In-Reply-To: <20240504-imx-clk-v1-6-f7915489d58d@nxp.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 16 May 2024 07:18:45 -0500
Message-ID: <CAHCN7x+Sv6_QQStEacjQP8UAVntyWHdvHrErQO0j=n_pe9zqmA@mail.gmail.com>
Subject: Re: [PATCH 06/18] clk: imx: pll14xx: use rate_table for audio plls
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 7:42=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.com=
> wrote:
>
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> The generated clock frequency may not accurate, for example
> the expected rate is 361267200U, but result is 361267199U.
> Add rate_table for audio clocks to avoid such issue.

Wouldn't it be better to fix the clock calculator and eliminate the
look-up table completely?
The LUT seems like a work-around for a bug.

adam
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-pll14xx.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.=
c
> index 55812bfb9ec2..6b2c849f8b71 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -64,6 +64,17 @@ static const struct imx_pll14xx_rate_table imx_pll1443=
x_tbl[] =3D {
>         PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
>         PLL_1443X_RATE(594000000U, 198, 2, 2, 0),
>         PLL_1443X_RATE(519750000U, 173, 2, 2, 16384),
> +       PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
> +       PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),
> +       PLL_1443X_RATE(245760000U, 328, 4, 3, 0xae15),
> +       PLL_1443X_RATE(225792000U, 226, 3, 3, 0xcac1),
> +       PLL_1443X_RATE(122880000U, 328, 4, 4, 0xae15),
> +       PLL_1443X_RATE(112896000U, 226, 3, 4, 0xcac1),
> +       PLL_1443X_RATE(61440000U, 328, 4, 5, 0xae15),
> +       PLL_1443X_RATE(56448000U, 226, 3, 5, 0xcac1),
> +       PLL_1443X_RATE(49152000U, 393, 3, 6, 0x374c),
> +       PLL_1443X_RATE(45158400U, 241, 2, 6, 0xd845),
> +       PLL_1443X_RATE(40960000U, 109, 1, 6, 0x3a07),
>  };
>
>  struct imx_pll14xx_clk imx_1443x_pll =3D {
>
> --
> 2.37.1
>
>

