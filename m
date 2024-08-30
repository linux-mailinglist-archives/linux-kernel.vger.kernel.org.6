Return-Path: <linux-kernel+bounces-309537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A4D966C76
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B0E1C2192E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CACA1C2DAD;
	Fri, 30 Aug 2024 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gc+D61Rz"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B8F1C1AD1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725057119; cv=none; b=cdqecYef9/JTQo84MPzJLZvCTVxkWUlf3n1/g7Z4J1hoO7XgDNeT/+HmbbUwngZEbALlAZkI03XqLi70Nk7DPrrm1mwmWQ2cqWTlRmazCLiK6Win/DPk9ElENR53XHn4fbdigmQxL4XfNw3ukoXKXjecDvdYPDGXHx/1ReDXmiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725057119; c=relaxed/simple;
	bh=KFKG3Hu1nlWUnpmyKv12SHPAEdjyrNL7oAPMm5KuvUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAYJMdIDM/T7IbKOiMf+G5SVnY8SLxKUn+n7RVGW3eiedhQFQDaKSLPnmL7p0ztv1Cu2pPEEQA4/OdQ04GQ0IwV4KCfE3S811jPNKoEUnAY55nFBeACp89P4emHJOBO5HYUbuoZR96uDDgghzF8kc3azoe6X4tdkmvw7SsoDAzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gc+D61Rz; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6d3c10af2efso14171137b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725057116; x=1725661916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFKG3Hu1nlWUnpmyKv12SHPAEdjyrNL7oAPMm5KuvUI=;
        b=Gc+D61RzNtZ5UD2WMu3a46oO1gofA35+sNAnni7LFNu8GqdGZALzc5xTz4vwpEE3xN
         jFajIqn7bK/kw2SV8A+153BFlg/Ayu9LUWFN+34uDdqMLfPdh1ifZ6jrqCx56zwjyM/u
         U4uzZ62nYxwU6H7LG8i7Wy0c5nLnijKSibQacgS7r7jXfutr85ksjFHPOM5IfofgZ6sb
         4g4M49n6OTv4o0WvuSNWqBU5ljzsnvG+OwYu6YBVjxw66Gz4qsvIV6YJd9c2kdLx8RfP
         0xMoV9+emt9bbO/cJzTtlQRVCLh8tXJO4qU9KszLaW09abGRxS7zX69CN98COuiRaT3o
         8qjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725057116; x=1725661916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFKG3Hu1nlWUnpmyKv12SHPAEdjyrNL7oAPMm5KuvUI=;
        b=Vi2l4PeLmPMJ/X00tVfM4NCBjOT27dgdjV8MTwulh05xPHf9A1fszlf1MLJJIJ4EZL
         LQc2UbpVoVb1pouGIOfx3lGOiil2HWIcaTrDf8AgN+HKW+d8AX8pxw3hWBJ6b6p+G5hi
         tRI02QezKEHRTc+4T2qrSGO53bsVSCKf53qp7fEyiuGXBEWGS8pxHD+GG13F9fFBuKDY
         9KWjypiAKimzdO8X4/JtfCWVqLmeArOWtXRIsJL6bB0/qVTwWKsyg5KZ1XeoOtKg1zkp
         gAKs7yKCWiFTKhR5oMAMqkWG9SukStKzi67VFR8FD+ErT+bVqtOPBv9ZRt1T3T8lO7MQ
         c1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg9ZHd2kEWi+iR/vuLWBw/5Bd9x19OMuGToXngIRZ5AHWMDltrY86QdXWOWCkFSfTId0fRyr674CaPWOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpVQarViawffuKoBWCSOOeMvtoh7UvVVmojw0X4MPTYTrgeS9e
	n4+DtewpaVNtnsF4kMHqFH2gsl4H2ni4QXi2PDuCvVJdDgqaO5HIIKQcz5a1BcC9rtz19KqgJ5H
	NZ5gxF3MJ9CfRuf4D1VRYe04dolN3BzCqXmWBcg==
X-Google-Smtp-Source: AGHT+IFqP+CzrvoB2S61/4pRdTw0AxY6t4jTtKN7C5yPQXEGWe74JgnEezcm+LFW4t+C4VT7OfM7HAVzLldND7oy2+s=
X-Received: by 2002:a05:690c:4589:b0:6d4:f41d:de2f with SMTP id
 00721157ae682-6d4f42d2475mr13586507b3.39.1725057116454; Fri, 30 Aug 2024
 15:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-dt-bindings-gpio-hog-v1-0-63b83e47d804@linaro.org> <20240828-dt-bindings-gpio-hog-v1-1-63b83e47d804@linaro.org>
In-Reply-To: <20240828-dt-bindings-gpio-hog-v1-1-63b83e47d804@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 31 Aug 2024 00:31:44 +0200
Message-ID: <CACRpkdamSDSPmTM9eEd=QAdZPM0Mb4mjh2+mQv7cx5TRT7MBNg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: gpio: fcs,fxl6408: add missing type to
 GPIO hogs
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Bjorn Andersson <andersson@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Daire McNamara <daire.mcnamara@microchip.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:36=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> GPIO hog nodes should define type, otherwise "dummy-hog" boolean
> properties would be allowed.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

