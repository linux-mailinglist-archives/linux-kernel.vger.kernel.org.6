Return-Path: <linux-kernel+bounces-569313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F110A6A14D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABC78A6634
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3296220FA90;
	Thu, 20 Mar 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpVyZMeW"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5A41E3769
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459132; cv=none; b=OadCvQK8WdcQLTOsrzLlgFxWKn2V0bN4wM5bPY7vZge1y9Zxbm4+2s2P0Occ2ib2JI7PfG/ERUaz0oa6FwKwqWYNQlocMYWhGu3OE2/ezBW11AUNB8wtU2E6ZNv8RTc+sg0iolQFiwUrSItp01aJmLA6tB6HfLcQxgZ1TlmqFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459132; c=relaxed/simple;
	bh=4NlU39TF+0+mtsb+gKpldCCyeU5hR5tN2aSvcVkaIAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBfvboWq0wTXhInsSmU4IVDnRYLiNScftvygbFQ1jab9/x+0QIKbcS2k6BjO7pR8gwu36kbqd9ZoKIxYTCsgHs8qIrLfA/1Sc+IN/cRXYoXjAJFbsaiP+NTD+Uy4OjfwCXUH7J7HLC8jTtP+1dKZzNx94XUsrszEq6gvnv8Ls7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PpVyZMeW; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54991d85f99so1788290e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742459129; x=1743063929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16qP0iKOeuObwS+re3QhKbw386nMle6gGJlfNm8BBkU=;
        b=PpVyZMeWoL1fR/yzQXaBcv/d8L7+fBr75uPRuUs1nH6e9WlFCu0NWcqiXalaQ+eR9r
         LiHz1IVfx4gaRuFBeDIPgNgqSOwdzKWgz4+j875xKo5/YIDCGFBKRCqVkLzR7T3zuCXt
         f4KOmAHKXsWJRSIWpnMaL3eawd2ofMqw1iFjUaNCd6Jg1VC/r2p5hH2f4wwbIaa4QYKG
         ftIufdYBfg7nEyrKPEaBojA5alvM09cWiigiFsLyblg/D+aInJtXatwASyBvmM3hPoy6
         0Kq/mxrgFVbxBc+eNqSR+DmdOvG26wRSDI5LofYKq4OGOoH4KM5jVRtN3gUAObFHqJh5
         Ihgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459129; x=1743063929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16qP0iKOeuObwS+re3QhKbw386nMle6gGJlfNm8BBkU=;
        b=ae2WYA78GOHa/Tyx9wSBZgQ131qg1SAMmkVFAQlLCkrz3J238IYwPJz6i6m0ueYfY3
         GbYPpPf0iuVQpuqXxePJKhHcNOPDqCicaND7VTvn/PkWE3OAyyJEyFdBDLzqMPpQkU3E
         Q8WwGXfRQi/jhdX0Zn/P6tClNdKGeLiYJNuaS4NkOWOJFoDpMHdEThWiyUXT9w6xizXy
         9j/ri2b6MATQ9y4Hc7LZ5o8kiEu6A7KL0Kg0bxsdGq074dXzca3g7XGCFKd7+TZbTCHN
         w1eTyoQcrQsG0i1LGDyKjGgoVmkoZochBX+87iZ7Otb+slLH+Y85cllBK8zAyk11R0yH
         Adhw==
X-Forwarded-Encrypted: i=1; AJvYcCUnRF0mav7eq6eST59typfiWyR5/lBke/KLrtp9XtjzV9zR5ztUtonem12f8gzh0H4v7R6JPFKocqEWeGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTc4KIIvk1M/2btVHajkvQI7rWNx33lfRwosLyxcIerMVRuJ1o
	TnWZVzg2dz1OJa1ivWEMERP8/aQcbDFkqBSg2ASsUmR/giXW/Vy7VZXxc3MYJWXfrYExLQJ3sbR
	gibt6vjj5QjyZdUFgx6aNvK/oKE/7btgIT80tbw==
X-Gm-Gg: ASbGncvXMb0owDrOoXvRgJRGGrGQLrEUWOmGg0JzEqhThC+w8zAlHhhYpzfUK8Ui1eR
	jx84fpXxo9HK1nDteiWbAWw1+F/QQBECKQtZSm+CglsCyZ1G7Tbgy4VpjtkvDzlNfwu3BFlAC0R
	oCismXiaRoZ+7ljunRwuSya9nqsQe4cVygVw==
X-Google-Smtp-Source: AGHT+IHq0Q0yXnXqGtKHv9Bke5vXrikGDXl7DhMoVGtfC4QNO2PuMG89WTST+1v0HStjzStbDE96t7XIg8axUieQKWQ=
X-Received: by 2002:a05:6512:340d:b0:549:9813:3e6b with SMTP id
 2adb3069b0e04-54acfa0baebmr1261731e87.0.1742459128532; Thu, 20 Mar 2025
 01:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319092951.37667-1-jirislaby@kernel.org> <20250319092951.37667-22-jirislaby@kernel.org>
In-Reply-To: <20250319092951.37667-22-jirislaby@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 20 Mar 2025 09:25:37 +0100
X-Gm-Features: AQ5f1Jq80nLsRvZqzWNrpZV1254RJBUNEI94hRUGI-9keKpvk6uaZ6w6cZ8gkIo
Message-ID: <CACRpkdZ95MdKgmjqzL_68BLsqpF+gOgbq3qSuEc_JG=x-=RvQg@mail.gmail.com>
Subject: Re: [PATCH v2 21/57] irqdomain: irqchip: Switch to irq_domain_create_*()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: tglx@linutronix.de, maz@kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Talel Shenhar <talel@amazon.com>, Antoine Tenart <atenart@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Eddie James <eajames@linux.ibm.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, Guo Ren <guoren@kernel.org>, 
	Baruch Siach <baruch@tkos.co.il>, Miodrag Dinic <miodrag.dinic@mips.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Paul Cercueil <paul@crapouillou.net>, Vladimir Zapolskiy <vz@mleia.com>, 
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>, 
	Daniel Palmer <daniel@thingy.jp>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Qin Jian <qinjian@cqplus1.com>, 
	Changhuang Liang <changhuang.liang@starfivetech.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	Michal Simek <michal.simek@amd.com>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 10:31=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kerne=
l.org> wrote:

> irq_domain_add_*() interfaces are going away as being obsolete now.
> Switch to the preferred irq_domain_create_*() ones. Those differ in the
> node parameter: They take more generic struct fwnode_handle instead of
> struct device_node. Therefore, of_fwnode_handle() is added around the
> original parameter.
>
> Note some of the users can likely use dev->fwnode directly instead of
> indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
> guaranteed to be set for all, so this has to be investigated on case to
> case basis (by people who can actually test with the HW).
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

There are some stray whitespace changes which are distracting,
but as things are, there is
Documentation/process/4.Coding.rst
saying:

  It is natural to fix the style of a piece of code while working
  on it for other reasons, but coding style changes should not be made for
  their own sake.

...and you are working on the code for other reasons so I
read it like this is actually OK.

(Written mostly to forestall any similar comments.)

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

