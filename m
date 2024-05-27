Return-Path: <linux-kernel+bounces-190615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD338D007D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF191C22235
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050AA15E5DE;
	Mon, 27 May 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHuA/6Gp"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61401DDC9
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814433; cv=none; b=HgVY7zqHGYIEhHbpzQk0qi26JTOK+5l1SfK427P/bRs7HnW6eKgQHJCszmPi3UEd4Y3e8c/DriwIjT3jO0D6orwh6fzxQoTKGoRptXGN4iFiPdwOPnExIAO+pYcnng99EsPDFHL1+bZAWdUQf9uYy8wfB0ykZxQN7N8MQFU44XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814433; c=relaxed/simple;
	bh=kRzIkfk9aA6AIARat06tGUsnw6dX00qMxa9B4WK7jyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GyYKiFNkPW7rP3az3/GxI/EpBn3oysKn9aVu4ooQg7C4wDXfPoPPOq1yJHsvhGHw8QhRQzxRJEXEZMHFFhfwNGZFN40L8XavX1/XXj2f6ixA8Q60sDdbl9nW4IgZvYkg+X71DXpnkxMek8FWhFAhWkMmbrO5IhfYa/quLXFW5tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fHuA/6Gp; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-df771b6cf71so3419972276.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716814431; x=1717419231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n38xc1OaRNv1MJQDIDghtRWtDAZeB5O1XOyPBUpnu/Y=;
        b=fHuA/6GpxbFta6a2KX9JdEHNG6t+L6ldm26F55NMH3FVFDYSmaI4b8hfgB9elpuPE8
         4QOi7ghU1ZJ+aEvgPDvzFMAzicQ9ciDAx4wZlNqt35IGHzvRz8QT4ezg3lVUKMGJ1i8p
         PasFVK1F3HTj61j90aXdVEKFBGFfKEPbnoLl+0Bmwl5UsrKMduzD1VLlLT7ll4X4CEVB
         th33+gx5wbhrOy8ArFLXwq8foalOZpDCOLI3ASrnmvhXFhRSm6ePV+/n3Uo3xxp3g8z4
         8CjKpD9rPfd7bMqCidsUp07WXvjRshPbpet+UB3iLo7U6uZFvlJdd0dwPA8yT2mKxurM
         l9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716814431; x=1717419231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n38xc1OaRNv1MJQDIDghtRWtDAZeB5O1XOyPBUpnu/Y=;
        b=GZsn0sqx6ECO3vjvdKDt73gtEJY6NDvIjyHKFIyEvJorY7rknWqXg/psmvb+zvPm/W
         bJ+OAmYVPtcPzQPUx8aRrGQSmwG0yAHRInXIJYkcVvKTmIdZ7S+MlHkYn7SGrKfhDxnP
         eeuqI511kiiI9GJM4T+GQryUMWkFq8P7icveNFrc17KZBFQnvLv5mOseNgDZFu1XahX7
         vsLtUttHdhK2wt/FDy5mfco0UNmyYsie9F6FgLnnt/mRNLzGx5NO//HsHbuwj20sD24G
         p3MYcSmhxuWgCLi9wHNLKKFI509CcmwnFVtb4SmfZS0ZX/a+A9yzDIDvn3zv7y60h866
         xWYA==
X-Forwarded-Encrypted: i=1; AJvYcCWHraJhIAyKf+TEV3bzWBBJQrIUZpeGTEtGnrTMKI7SPqJPk4i3CuV5lw3/j2RSBpGRJGS0BZ85Na3acfLnKMIOXRBiwCU0xj86x3O5
X-Gm-Message-State: AOJu0YxTnJ7DRYrnNu4a8znYhzkY/VfRubnzdGJQCo4uQhlgHpbcErSA
	5VDlCc9sCZocVf7PjonNOHbm6kt8GgaXfOnKx1UZFB5JNwpNTcVSZU59Ux03qm3xmFoEjD2VEKJ
	YwU1RSdbWaBpopjFDca2Tv6SLIxvM6Eisyq+eWw==
X-Google-Smtp-Source: AGHT+IFzU18N+mOTSmGUX+D8nV9CprtXNPZ2YG3J4xB1E5yVmFBi3UzDUGrPZaFYiDw2nCnS3zR2JAFmDI/T6iCD3W0=
X-Received: by 2002:a25:ad50:0:b0:df7:887b:abfb with SMTP id
 3f1490d57ef6-df7887bb0f3mr6066354276.15.1716814430908; Mon, 27 May 2024
 05:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521-pinctrl-scmi-imx95-v1-0-9a1175d735fd@nxp.com> <20240521-pinctrl-scmi-imx95-v1-3-9a1175d735fd@nxp.com>
In-Reply-To: <20240521-pinctrl-scmi-imx95-v1-3-9a1175d735fd@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 27 May 2024 14:53:40 +0200
Message-ID: <CACRpkdanc3gJ7_z+V5zwKbn+L-Qy1+nwsPLCSF9ZQ_xk3qJOXA@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: imx: support SCMI pinctrl protocol for i.MX95
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-gpio@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 8:17=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> +static int pinctrl_scmi_imx_dt_node_to_map(struct pinctrl_dev *pctldev,
> +                                          struct device_node *np,
> +                                          struct pinctrl_map **map,
> +                                          unsigned int *num_maps)
(...)
> +static int pinctrl_scmi_imx_pinconf_set(struct pinctrl_dev *pctldev,
> +                                       unsigned int pin,
> +                                       unsigned long *configs,
> +                                       unsigned int num_configs)

The code in these functions look suspiciously similar to same code
in pinctrl-imx.c, I bet it is copy/pase/modify.

Can you look a second time if it is possible to share code between the
drivers?

It's not super much code, I'm mostly worried about bugs having to be
fixed in two places.

What is the opinion of the othe i.MX pinctrl maintainers?

Yours,
Linus Walleij

