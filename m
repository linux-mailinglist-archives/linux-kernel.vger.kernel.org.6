Return-Path: <linux-kernel+bounces-189991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0CA8CF828
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3E8281D21
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8468BFC;
	Mon, 27 May 2024 03:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5oKuML4"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47D4C85;
	Mon, 27 May 2024 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716781421; cv=none; b=tMjDYA4beERmCQe5biVDLyty2/E1alwkmABAC6bYe1CtlT4wVnrIQ9MiiQe2Xdi8b6cd3xR7YRZuxijbpvOp8uNBqtvriYL1LCFBKg6sFCDECXmmznpQmP4AEWogoIAHJV+4A77hf1blrurQdVG9d76ZmYEbzh0nUNjfZZAhh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716781421; c=relaxed/simple;
	bh=53XFiw3wcH5MEHYvmgoOoQBcB9x5uThYREaPmL4h+tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpXzzQcGz14V0/R0CtUDL37T8f3JQzo/xX6WKrJqpqZ0HJYSP40pLbFpQfonlhghl7kEpjrG4pakRlavO3M57eOKrQoRkGGFdRpN/6HiLqZOfApoe/ednxYdi7AHBpOP0/WNWHZMeCqzWuvP9DhWTz9ut0hGKkma4osmIOQchr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5oKuML4; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3737b281d89so13548525ab.0;
        Sun, 26 May 2024 20:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716781419; x=1717386219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRrRcXmuLZcVS0a1HI//2b0lm2ojNew43pXaiTtTIT0=;
        b=Z5oKuML4msXzlF0gJWN8Gr/LCqzyGTGj7bmkLAczzn4ykIpoBk64OLOu/UiD0wAsQz
         EZyWvjKOlY1zE7KUWDVqHRLpZ9CMhKc2EsxDellGShNCpC9KxfewtzrPWZdA0X8+vcSw
         DzhgpZ8z9eWPBVEMqkdojlBXKMLRDPUFUHFEP4qqmPP94PKWxplu+zUpdkWNkHKVqKB1
         Sp25yMMknNqcJfGUthnXLjp3yAgu7ig+TcSqoA5D+tMOd/ZTXd0JUs9Iw8TUjMYcTxfk
         +d9Te43YrWhG+67YiWFno9cKYANztXmWfBOrBm7Jb5PcVtclvftJ5rDBiuuZBNLPvu88
         CqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716781419; x=1717386219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRrRcXmuLZcVS0a1HI//2b0lm2ojNew43pXaiTtTIT0=;
        b=RHADU8GqFXDXXj7Qsw53KNFnbDp7O5TS84CGTr56WAfK3YzVPT2bgBqnb6N0iUlQc9
         nYxhf01HvhL5s/ooPq/t903ePXpEBEGpceEBpGy4wimKPxZqL2LFGY2N1dB4m2MpEAgr
         N0MFQCveVh3/3vyl9RXo2DX4bXBrSg2637t3FBOZiG+O8FacRz/Uslwrp8nHwpXdDXkP
         hRDaE5o1ppxbMmOa2lmF6wEs9NaHieGL1Q1JWX5+u/QVi0R9drvbbxv2ZrOyKAwFfXtY
         wug3GE1+nQYt0UzSMfxSmV8/N6Q1VDi6G8KkGaoyoMX4mnZplsfzYly3VUNtNo37CIj1
         e9+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUO28xAHfh6WfoKYO1xtM7k5llEk+KhmfOk8JCFD7ostNPvIOVKIpHCZXWMqWHxh2rtC4ppiBBk256AVfE0L/GHWArsdqw7orVWUDd5zbqlsICWUun+W+jrhXuhovwhQJMYi2hP6rl6SvBb5veq6pKByR4b3ZU9E23tSUC/M9OoSEfkGtvf7A+ameY/zVc2nB6P48P4/eSmJrcT4ohvAV2BrIcvKg==
X-Gm-Message-State: AOJu0YzoOt56PxQGGg1NTjr7yK+8M3svxb8CT9SzxYoC6+fmS1SpDA/2
	vu45D88Tia3Z7S/q6TvMej8F93doGBkoRLQYSreODjQdP+4GmwpURp9lf9YFO7DDYuZaCusVmBo
	9gw5+nH11NSDe1n9XiF+ePHPg3dE=
X-Google-Smtp-Source: AGHT+IFer+okIhIMWyZ3KDB5sub/J3A98AWgoEcUO098+9PFGoUSKu3O2L2vhwhC/BxcGv8gjuJlt8qOcDZPXnhr1ww=
X-Received: by 2002:a05:6e02:1c07:b0:371:252c:d8f6 with SMTP id
 e9e14a558f8ab-3737b3032f7mr94193515ab.11.1716781419196; Sun, 26 May 2024
 20:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716458390-20120-3-git-send-email-shengjiu.wang@nxp.com> <4c53b063-ad12-405d-b088-9b992284ba08@web.de>
In-Reply-To: <4c53b063-ad12-405d-b088-9b992284ba08@web.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 27 May 2024 11:43:28 +0800
Message-ID: <CAA+D8ANu6S1vrmAD4FU2X7=9U-B6SwnZu245mu4dXTfgetjDEA@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] clk: imx: clk-audiomix: Add reset controller
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel-janitors@vger.kernel.org, imx@lists.linux.dev, 
	Abel Vesa <abelvesa@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
	Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 3:27=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> =E2=80=A6
> > The reset controller is supported by the auxiliary device
> > framework.
>
> Would you like to add an imperative wording for an improved change descri=
ption?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.9#n94

ok, will update it.

>
>
> =E2=80=A6
> > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> =E2=80=A6
> > +static int clk_imx8mp_audiomix_reset_controller_register(struct device=
 *dev,
> > +                                                      struct clk_imx8m=
p_audiomix_priv *priv)
> > +{
> > +     struct auxiliary_device __free(kfree) * adev =3D NULL;
> > +     int ret;
> > +
> > +     adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> =E2=80=A6
>
> May the following source code variant be applied here?
>
>         int ret;
>         struct auxiliary_device __free(kfree) *adev =3D kzalloc(sizeof(*a=
dev), GFP_KERNEL);

ok, will update it.

best regards
Shengjiu Wang
>
>
> Regards,
> Markus

