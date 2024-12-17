Return-Path: <linux-kernel+bounces-449317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE8A9F4D18
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585EE167E70
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEA91F4725;
	Tue, 17 Dec 2024 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1903JU5"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB201F12FE
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444436; cv=none; b=d2Xr7xXNqQn//8HnEML3Kyj54o1PpVulAJ3X7I/4Y7Emj2Lc8v2yBScOqWOFBae/LlGwgvOVUalMGB/CiJOMGVoKeUzeb+mXrCfIjOWsRiIEcyoe10jLxJv5NphOrkXDk2gzoqTOs5uNXsWDYu7HCI9WxtojnfXTJa1BIZpMOiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444436; c=relaxed/simple;
	bh=AJ8xar4h5rk9ad9pw56nXrCo7RziMoyia/Xag/oqRJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDQrGGnowANK5CU5z3OI61csjVNgmHAjl8Cbb0tBUIG7dq/UqQWoZFCqWzUCUDUrpCsNSHcHJAOKotX7m8Wg+VWqq0TvL6OsWpFzm/yBl9umHMFicgMTrKVBW7tzFxU5+QxoyHXVr9tTay5iAnvNMonNMMfRgGxW5AUo/ydM/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H1903JU5; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3022c6155edso52705291fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734444432; x=1735049232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ8xar4h5rk9ad9pw56nXrCo7RziMoyia/Xag/oqRJk=;
        b=H1903JU5jwSaiweql2YtxIOekIkzQKMHzqMlwcXyBZ8+HjDu2PTLBNIQdEcKBFJwGs
         l9hGcxrWsaJZFi+V0Jf57LxIgPJ0lYKuqRZrQ4nF4cTyWEvjMlEnPJt5+d07hNpuPwsK
         gtpi51FvdeLrsv8CfweMlblGnBuex+NMej5YsA5gOr4Ey0Te94MmSmQxxLaHHVpCWK0k
         UnNgcwHFCL1Q4zn05+GYWBR2FQMzDHz4aRfq6k5hkB2Dbs+90lH63Jc4bGkEp+QTvylB
         bLTjVakuJJwOiViWNbgsbexIeGQtW41B/txXhmmaImpBEj5Ev9qYx5YGxt2hJDiRPrjd
         76Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734444432; x=1735049232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ8xar4h5rk9ad9pw56nXrCo7RziMoyia/Xag/oqRJk=;
        b=H6wEiNk2ofZgQVlEnRjeH/n4WYDrM9aaAL3WkHZS+UlGeY8FmrJPlmRGeD0kM/83NL
         gqZPk+NNrmNQ/dJc7fDP6MlLEg7c5vlGzQpiPeXHEYOpox18zY2g8JFAqIFyYpSRUahY
         euVAr58fNw+dn2rtJQtU79L88VqcoMvcRd3+znnTLHxPNzfl2Az6+dXbDb5ekBpWSLOF
         ncnUeQrXmnyFgvnbFkj4uUAEj5VivroNbqxB0lcY2BjcRHiq70C926+UolUeoJZfQ12j
         ETlCUP3TIkUPZW9YDegpgXe/Iee+8nwFt2vwfgv9k7B+IYWXReOP+R6BTXj7GFRPDEbJ
         +WcA==
X-Forwarded-Encrypted: i=1; AJvYcCXMIwI0h+CV1/jjhT5FmvXhkkPhFDxJfhxx1eeqSXWuAMLHLVnFVptlhE22zozw1jE3mE6utlGPW4TFeCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBd8QYMiINDoFkNcablszsrmHCNNVQQwmwN/j9l9PSoGRRD0W9
	PjGS3Z1GPTck/rIYcAWUQpsaGeYCgBJhGCW+yoDgXkyw73smVH05zXL5fdwxf1kA+L2VY3hbFm4
	pt96QBxUtLkTUMQgW9bMNgLCGiGeBSiFpK1CdtA==
X-Gm-Gg: ASbGnctRDvpmTHP2oOHcKranTav8Hm+fdmsZk/DSpVAB3Jd2YwQqErZ8MIt4Q0W1fBj
	Fi9Bq35QaPxOvhtpzCL8HBSncly4Evxo1FsKAPw==
X-Google-Smtp-Source: AGHT+IHZjPHjo4Swh+bqa4UnyeL5dWjKS+tvSH7lJWm3TCu3xkZDTEkEtpQJJwyqbndJ5XwyTn9A1top8YhlHpFm1kc=
X-Received: by 2002:a05:6512:124c:b0:540:2311:28c5 with SMTP id
 2adb3069b0e04-54099b72020mr5875156e87.57.1734444431628; Tue, 17 Dec 2024
 06:07:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206221618.3453159-1-zmw12306@gmail.com>
In-Reply-To: <20241206221618.3453159-1-zmw12306@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Dec 2024 15:07:00 +0100
Message-ID: <CACRpkdZrkt7R+NzjQmo60M9sMom_f4SRU8+g+=UEq7hqG9pKJw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: nomadik: Add check for clk_enable()
To: Mingwei Zheng <zmw12306@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiasheng Jiang <jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:13=E2=80=AFPM Mingwei Zheng <zmw12306@gmail.com> =
wrote:

> Add check for the return value of clk_enable() to catch the potential
> error.
> Disable success clks in the error handling.
> Change return type of nmk_gpio_glitch_slpm_init casade.
>
> Fixes: 3a19805920f1 ("pinctrl: nomadik: move all Nomadik drivers to subdi=
r")
> Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>

Oh I took out v1 and applied this instead, I didn't see the bug
but luckily you did!

Yours,
Linus Walleij

