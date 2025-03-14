Return-Path: <linux-kernel+bounces-561160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BD2A60E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6193B2284
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87411F2B87;
	Fri, 14 Mar 2025 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCUjcV8S"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE4E1F236B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946739; cv=none; b=WB0s2tkyTTF2wXQ7AAz9Xnu8wpH67uyMyxN7+y/2xWz+DgqWOuVXEIUjQFnpruY0yZza1I1XaZd/l9DC0YGEYzjMbzCbzGGzD2pbBx6NL+dFwJr2Yp++yTN4KX+nkrbWktxTX2qXQYXTsEqBAp3QZozVTMN9ZCiosfdKaSCkFEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946739; c=relaxed/simple;
	bh=eh7XBUEDnEVmfAyoNroU4thpP1DbmQyPdxpMEoCLtgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpuKEdOhwwn3sEt0aQCbeArbdriqOgo/RU2B0Kw8epY8j9v/hrCQDlpDtSU8jgxlUDBYzYII6jUkCkc2t7BBm4/QGUODBnbuMv9Um+JHyz4d7JeYAFWQwnwj7qObRD/ptFMPX7SIPbIMr7IEjhpCRpUvzwZGrgQ+SmavJ0XVhXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FCUjcV8S; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-549b116321aso2176984e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946735; x=1742551535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh7XBUEDnEVmfAyoNroU4thpP1DbmQyPdxpMEoCLtgo=;
        b=FCUjcV8SX92CMT3X0ijaQMvHZ9pDAfqTcACj3xPrUrYRp695WKeNmLJh52zXlt3HoI
         EEykGgzvpRTyX2vQGP1VNlYi19LgXJQKuXL2Lh9jMzyvtLy3hthwyVeKeWiUfpHbtbCz
         o4wptzBJGCQKO+urNfBPCml94JNk4V6E6t+hh6Wk/yCfGgLFqUK0z0nZw0Wj6ZTs4nJQ
         9Uw83meDvpUaxb2JUIrj8XQbN9v/l385hQtumdjjNAk2ZszYWXyhjgilEhnHQ2jEthpz
         knZKaSjmh4M15KrOiLE46tU4X1dLn1Y0AMsuq+tRCYW85NeVW1ULUfHaHxN2f1hUB3Va
         CekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946735; x=1742551535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eh7XBUEDnEVmfAyoNroU4thpP1DbmQyPdxpMEoCLtgo=;
        b=Dwxbse7tfPg72c+mEToj5o/YkXedo50QQZ17QpS7Sw61tQGwmfJt+4w1rmDtmVzb1P
         EvPv9pvcuxEdxu1HzeycVm/SwobHJLvQ5PBW9fXt6A4AHCieTxLV5pNUk22nCm4SQZgQ
         l1BRWMADXyQccigrlWZVTK6is2IS8/20oKaoTlJTxMEgSlNfcmpNaAYblC7mf1LcQsIV
         0dYW/aopiPLSMleFtWGEEUXtDRSMGqjF3HJ5jZCfNjlqdg3WY6riTquRMxArTSCLBrD0
         0Mn3Pl2XEUhVs8wOkzOPsBpYGX+ivZxxyc1QBbq/BScm8wIB3td3Oh+Q/FUDNGMRULMx
         mF2w==
X-Forwarded-Encrypted: i=1; AJvYcCUTF9Uekgx+rRsYVrEKbEpoXVpe37QUu/M0rq7FGxkkVC2DoaTIUVxvL46t++gROGXWp6MA1pc/IfY+2CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVCINSSPQLZODjO7sS7Qmaa3+kydtYBCJZmE/mxoAklVqMLuD+
	K1GV26mWKXndMRIkwXKyr0fSyPsY5gibsMxtin6gV3ECgBLwKNbZkaqBpjax1DGsLACm95IMYlT
	cYhcU1FqqFWb4PFAnoMKrO5wAM+KXOR2LFDRdYQ==
X-Gm-Gg: ASbGnct3BRL8qwh05grI1+yuWt8CgTZLDtTJWybTSzfl9AMN1Ee3wQl/e/9JqhOkpLz
	hjRrfqw82qu+kvD4UN6WXtbK1fjhHLWv3FylzdoqSqXlSa9DbiZgClohS93ztmpC91hbB40D2Jx
	Lae691ZQmLg+urJIbpw7c4fZs=
X-Google-Smtp-Source: AGHT+IGq7cAxgMP4haGgqamo8wwHKjXDUhcyOZqf0mmG9W3VrgKR64kadUBSXZx7M7CIcN7MhQwmpihvt4wmbXLx15o=
X-Received: by 2002:a05:6512:234f:b0:549:8809:ee32 with SMTP id
 2adb3069b0e04-549c38e3902mr515413e87.22.1741946735490; Fri, 14 Mar 2025
 03:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306050542.16335-1-pshete@nvidia.com>
In-Reply-To: <20250306050542.16335-1-pshete@nvidia.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:05:24 +0100
X-Gm-Features: AQ5f1Jo6_TwKRRb74yZji8D81Rnz7yhFrbdO-8qqdDKIhG5TYe9RyB3pUy492vY
Message-ID: <CACRpkda-VjHnd9q1gijWZZ0zygUogPtN6VY-G+GEqdj-EbOv9w@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: tegra: Set SFIO mode to Mux Register
To: Prathamesh Shete <pshete@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, linux-gpio@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 6:06=E2=80=AFAM Prathamesh Shete <pshete@nvidia.com>=
 wrote:

> Tegra devices have an 'sfsel' bit field that determines whether a pin
> operates in SFIO (Special Function I/O) or GPIO mode. Currently,
> tegra_pinctrl_gpio_disable_free() sets this bit when releasing a GPIO.
>
> However, tegra_pinctrl_set_mux() can be called independently in certain
> code paths where gpio_disable_free() is not invoked. In such cases, faili=
ng
> to set the SFIO mode could lead to incorrect pin configurations, resultin=
g
> in functional issues for peripherals relying on SFIO.
>
> This patch ensures that whenever set_mux() is called, the SFIO mode is
> correctly set in the Mux Register if the 'sfsel' bit is present. This
> prevents situations where the pin remains in GPIO mode despite being
> configured for SFIO use.
>
> Fixes: 59b67585e242 ("pinctrl: add a driver for NVIDIA Tegra")
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

Patch applied.

I can't tell how urgent this patch is so I have applied it for next
for the moment.

Yours,
Linus Walleij

