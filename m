Return-Path: <linux-kernel+bounces-392179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39C29B90B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89055282E4C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FD919CC20;
	Fri,  1 Nov 2024 11:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvCwlNdl"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D638A19AA41
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462073; cv=none; b=mNvxhWcz8/6xYSsRWtjcPMk9TjVHHGfmxbby9C/r0BGamQlc/xv7VtQS8z48Gim7JI/arj89G2cUHgmyLHfXxpYMFoU+HxaSt8kmo9S8Z0hPfsyDAHpZYt+Zy35ElmbJDWzgR00dk0smYpDEVy80NTf9HEiRFT7wzvEwo0xKnzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462073; c=relaxed/simple;
	bh=VTkHIu6x6J8oDnM2EYPHGTKSx4bAvmnfjc2sBE+Lf2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZKihfSPscg0kDRaLWlRtghwlJFTrHWzb4vWO/oHuC5IcGTN1D4kvKf7KGghtQt0i7ecoG/97xEbZL1QtgMcZ7Wkk8VaJeCpU1Bb7JJ6FPOhMab+4QhuAqEwDS8Y0kyqdCkxqNzRa6pn9Q4sXP32O7nZOPgf+jc0MvK0GkAp/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KvCwlNdl; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so17204221fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 04:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730462069; x=1731066869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTkHIu6x6J8oDnM2EYPHGTKSx4bAvmnfjc2sBE+Lf2I=;
        b=KvCwlNdlZHvuAo/NQ5ntgTz2uEH4MvpJYhRtkGuJBChah7TMnK2bcJGKzICMAV4w/T
         pa4vgCG3Ap8WwjrCkmmExzda5r9G0rsbWSXPSyNdEknA3EDl4bNPtE/qXWhcea+BgN4A
         FQHWhF/OsNG8AiJvhDVHrbXaXUBXlm6jHkefkSnVJRETESexQoXHjDPLKQeCHw7ON114
         m/QLQ5EUExO2wu/A0Evc2+ix7btfJsQAmMWDYsPT1kP3izFcREiC5dOf7BvSJj/+x530
         c6LkygrZkILgtzmTVT9sT5s03GPXOCCOoH/z+dfAiEuQfzdQPZmycj5yqOobbTQWtlP7
         mEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462069; x=1731066869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTkHIu6x6J8oDnM2EYPHGTKSx4bAvmnfjc2sBE+Lf2I=;
        b=hQP2cPjnpmagEFX2lKbd8U+PAdZoHomoIn+xlYOzwt1ZSZyWf780wL2mO4TMEbyFoW
         XoIXkkwHqFNo4cQNsJzn44Zl7Gu7BSRJZVfeFad8z9VFz1qrU29c7UkjvkMJe3STEslE
         ZuRm9OVF19KnKFtnV2MOCs+MvUtNrMeWBariziu4U/Uyc62E34nfx002cUEmXdQJ+jBl
         N4H8nb2aXTNE5ZredNtjBSjILHRE9XrqmSIep+qXgT2AdV4GMuuQtidph4GZJWiew6mI
         IO3qNNDBI8+xheX2bYixmNKfnv8tn03f2+ZDwUh+2jnmb/DrFFI+3SUI0sRamC2/RWZW
         XSxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH8As7FGMbax09LDNnzkt1lj5GS3trgRiydOBXY8e9Bb5U4HfI3vjhHLZ559nEuO9k95yEgAtMlLEvpFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzio7wiQt3aWq5nHhlq8WNuMU/AXgIrtkqYkVexgmNhiH2gi6WH
	+ROvNAh3bf5NXbc0VgnZkME1a5Uw7a/gBnuRdaezkhABFJSmTLnewr0eRavw3lZL1LfrjYrs+Ok
	B/1/Zb559pXlNIO0jC1GDWIf+ZtN2jp5WVL4D/A==
X-Google-Smtp-Source: AGHT+IElM+4cf5nJiQK/flMPFGUQS/qscWK2wONW7FVnOjF9n3NBlck/a/D8oXjerYOiHg6n+ZKlCTOw3SU28go/iqc=
X-Received: by 2002:a05:651c:154b:b0:2fb:6394:d6bd with SMTP id
 38308e7fff4ca-2fdec4e750emr31077211fa.12.1730462068876; Fri, 01 Nov 2024
 04:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101080614.1070819-1-andrei.stefanescu@oss.nxp.com> <20241101080614.1070819-6-andrei.stefanescu@oss.nxp.com>
In-Reply-To: <20241101080614.1070819-6-andrei.stefanescu@oss.nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 1 Nov 2024 12:54:17 +0100
Message-ID: <CACRpkda2Ss_oy8vX6V7KK9DCvSoWxSg2R_iCourt-XReHBcpLg@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] pinctrl: s32cc: change to "devm_pinctrl_register_and_init"
To: Andrei Stefanescu <andrei.stefanescu@oss.nxp.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
	Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>, Larisa Grigore <larisa.grigore@nxp.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Lee Jones <lee@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, NXP S32 Linux Team <s32@nxp.com>, 
	Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>, 
	Enric Balletbo <eballetb@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 9:06=E2=80=AFAM Andrei Stefanescu
<andrei.stefanescu@oss.nxp.com> wrote:

> Switch from "devm_pinctrl_register" to "devm_pinctrl_register_and_init"
> and "pinctrl_enable" since this is the recommended way.
>
> Signed-off-by: Andrei Stefanescu <andrei.stefanescu@oss.nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
I assume this needs to go in with the rest of the patches.

Yours,
Linus Walleij

