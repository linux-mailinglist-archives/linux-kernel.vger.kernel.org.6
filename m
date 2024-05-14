Return-Path: <linux-kernel+bounces-178402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0594D8C4D1D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 09:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF44B221B0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 07:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935D5171CC;
	Tue, 14 May 2024 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZ9NXeBp"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD517C66
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671997; cv=none; b=YVMA0qEutXd3vua2HuCvSZpkunonfiLPWQAM5Q4hRbITq0xmCIC+GENfAVfcv0G1rJ35zLqPdyDjOIE6f/0OeQOy/luKP+QS7Yl2UD7ZQDNLbK1fbSJrZ16eNer791tZAb/wg+JJ152vmb0+lFYWciwRjJGC9fiw9SI3wVHeiXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671997; c=relaxed/simple;
	bh=C4wW5aa4W2kv01Iu3rTlOfBD8ed5XWvkaDVuJNLIYTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW3XTBeaLGcBYrFB+8NChO/tGonpiH9tKJtkL5pZCHjXWJUVgRqgdiE3t6JGS4DU3Tp4+W9yi+LxdMjbZ8LdBh0oS9/TSZK4XbHrYLtjkwwZoycVRAayFTBWn1fKxpDVoSIr7udIJL7n5HskGtgUpUhCHWgn+22RRB8To2izySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EZ9NXeBp; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-620314aa1d7so55616087b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715671995; x=1716276795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4wW5aa4W2kv01Iu3rTlOfBD8ed5XWvkaDVuJNLIYTA=;
        b=EZ9NXeBpXX/RyKsy7q+DqYaewifa6YWACXAbV4ePJBzHX4rT86pwMqnd9h6Fp1HYAD
         2oXHAIG3tw/GucaWG8TUgO9on8fd/2ZM8v0xtSRMT+jPFykjCfsNXfw6mpdv5oMrPrXC
         8NFDmwLAjvEEGhJNSbM/fIXqj0r62zJvHz7HUGlcfMNDI12TwHT5Wfvdp0jUMylXm52b
         RwDWzuvVWRCHTWHUIOhaTfMxPSTTu/tNbWEHFjTmyOW1OlKllhrTO7nE/h0m1AUWzLOB
         WsW9UsN7RhSwK8kjwl/idGkKywDgTm+mMpI2leZ9IBrfJbEFy4GN7uu8wr4AZ+ain4ap
         JTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715671995; x=1716276795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4wW5aa4W2kv01Iu3rTlOfBD8ed5XWvkaDVuJNLIYTA=;
        b=aZMr7d29gn2r2nHI+rAOB2lOisRSJu+0T9XDl7iCEud/OxQgRzwic71hOzj2+6a+D2
         GLkzYHI3r2cwTU9oBjRfEigrw9yOCR3vxFI449nDSNzT43WkEFefa2JCsw4V8+tTsoUP
         ffQKmgeJjqhr6V9Za8+LeVi+4sLonUsnoFQEmbU3tlukSkbegshEVAV3x8wyJdO94IBp
         rLDxGsE5tiOMZw3e+R/dJY7BoZM+IGQXtDqVUNez/Q4oWzG2Nh2ii8WSW55t6u4qlN5Y
         CWE+a75/r4RGSYmZ/GS1IoCcP6XpE4ws8BDd4VI+ZZ7XLWg8iA/QrKrZm64Oo/4PnwcC
         YxKA==
X-Forwarded-Encrypted: i=1; AJvYcCXDl5vnsAjtV2VtV0kwgBk5p4pc9wEWmN4oaSuZYFUKwcLUNfbVs/g3vsh983wS4BS5SM4PZvK0ys9wp6p+uv5sUik++5tYia6K1v4/
X-Gm-Message-State: AOJu0YzC85l621Bd7mdAgcQj7cVvYarn22ieLgld3sV8EQAIrWqV/yL1
	1YePeK/0P2UBWMK8jBPLVxuhVII23Pt696CHbRnjtmx0HBr8inKC9704dvH07qtvydMdQT7WnXa
	QC5s0oUGIgibfaunVMjFNDtYafXv/PDFufeNGOg==
X-Google-Smtp-Source: AGHT+IEj9rSUWA94F6VFaCC7a26gta7P6jlgI2cpDV7q9j/kgYnlADA3j4AJ721URmKt02c8jgw6oM4ErSC0l+EyUGQ=
X-Received: by 2002:a0d:cbd1:0:b0:61b:3356:d28c with SMTP id
 00721157ae682-622aff92355mr116464607b3.2.1715671995199; Tue, 14 May 2024
 00:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240504-pinctrl-cleanup-v2-0-26c5f2dc1181@nxp.com>
 <20240504-pinctrl-cleanup-v2-7-26c5f2dc1181@nxp.com> <CAMuHMdUD=1rpns_mLF2rMM-x5EnOK7TExaJxoJVkbXjVz1H8uQ@mail.gmail.com>
 <CACRpkdaUecnwvHFdtGkuM80SObvXpXZkWGYoUMgnNHcvObYF0g@mail.gmail.com> <CAMuHMdWCD+k8=iX8+tcK76DU_m9quR8BV+K68K73SygJzCz5VA@mail.gmail.com>
In-Reply-To: <CAMuHMdWCD+k8=iX8+tcK76DU_m9quR8BV+K68K73SygJzCz5VA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 May 2024 09:33:03 +0200
Message-ID: <CACRpkdYS8=cHT=7tGbzWZ73jbLhjqdpssbaHH-qREe=bcHYe2A@mail.gmail.com>
Subject: Re: [PATCH v2 07/20] pinctrl: renesas: Use scope based of_node_put() cleanups
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, Jianlong Huang <jianlong.huang@starfivetech.com>, 
	Hal Feng <hal.feng@starfivetech.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, Heiko Stuebner <heiko@sntech.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Chester Lin <chester62515@gmail.com>, 
	Matthias Brugger <mbrugger@suse.com>, Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	imx@lists.linux.dev, linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 8:36=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:

> > Does this go into the Renesas patch stack?
> >
> > I think the patch stands fine without the rest of the series.
>
> Sure, I can do that.

Please apply it!

> From your positive response to v1, I thought that perhaps you just
> wanted to take the full series yourself?

Sorry, I always prefer submaintainers to pick their stuff, they
know what they are doing and they can test the entire patch
stack properly.

Yours,
Linus Walleij

