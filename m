Return-Path: <linux-kernel+bounces-301095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A825F95EC4D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6F21F20EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE1B13D532;
	Mon, 26 Aug 2024 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="akfXGzOA"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5682899
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724661993; cv=none; b=KhZ+YiTYMo3859ASKuprwWEzAkfFhVt3THqq0RKcQpaMWdZ5w1srl2UXzQzdTJlDImUjQa27xmlyQ27TSqdq4fxH/qO2gVBinbJ9rXOiggmwx4fi2lnsKLdmO9zQ0Gad/0aMXvsiWv3sCTYitoz+FDBnIbZGIoeNfD05khCO9Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724661993; c=relaxed/simple;
	bh=jRoGc8zZH4oC05abOb5eEX0kRMeyafNXbYdYJflymmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNjn0F+KE9crWYtmQhGnP5s9hC6Xnaj0AIkoWJomo5/8BJMelA05C5tbCEksEhW5jYlh8frq/4SRYtnUIAMKAy0+IH3E7OEb065n8Qw3XfeJ/GCK1vf3xqw0606ceLjGVdpPyvu+0E1pleWCGDKtJZhPz1NeJYxkXzTpfS0sDBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=akfXGzOA; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5334c018913so3937856e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724661989; x=1725266789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRoGc8zZH4oC05abOb5eEX0kRMeyafNXbYdYJflymmE=;
        b=akfXGzOACYv1vaXfxF9H4LBBq05lTfO384/4Rgu678ZMsDHKAzcYMtfD3WvTt/fCWG
         UXEsg/HQ4iqw0MPuuUnM1MFu5BE8PpcgKsc1CyzYEULseNRrvQwqJdDtAbZUDLPXGD6u
         G2wrTlS5kQpVoh1ygWsIF68u6S6ZO3oVkiJFXrLpdsAXXb27JkNVTFseJKvaci/k6zTA
         WwCdWEIQX6f2a2+uBxrTZYOcelRA740+vQ2pdmH+WdWpuNQiixYDYuOmuhfUJTjNc2rK
         duc1gSbRJY/C9bhAjViG+yIHZDH3ZaU+LUGDSggNbBzPF2ZWp9WHzGclUWKrJf89ZFi/
         adoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724661989; x=1725266789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRoGc8zZH4oC05abOb5eEX0kRMeyafNXbYdYJflymmE=;
        b=sdCjz6TM1yqtExCWgFUJpS1kZaluBW3jutZ4cPqdWE//69/94RrHDj7msuD0x40GtM
         +tsBI13IJkzz+BrKpXMGA2jGFUSHO7pafVzV5dWd+7XkoepHTtLzBvM/miEO4n+eM39i
         mYwlNgV6SMMIH/5bHHG7sXX+qPBFx3omWikqa4C+7z00R+9H/59kBtQG3+M6ZSUlFuIU
         cL8TEC7xJlYVh2yQ7CEVFKw6ps5OJW4IiN/fpwpEiaSP5uZLXpXhY/Scj49N9WnJ3K1Z
         hxOmuz7X/nMwPt1NfjmzKzdvNcLLngMqGjfm40FTH1I90ApCzEpXI4RdI8GmNwLfdhOY
         6ZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1RjLYnPXX4RXgJLKI8xi3HKLXrLCiDyRkaLKpOhMmwIuCy9rAEtjr8aYco0Nhh5OlK+UYYWqpTjsnDFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvSZm0snzqUm4ga1jo5hCmrYifxkBYT5ngQY5H7PcM/bllIHaJ
	RRHx9tgzPWRDzn3/pw7vXoDjNwcklL71b5pNGW5g78yQ5LydcGpI03tQqy/griZvGJik40xW/Fv
	woPEbQk7mOnmNzyx4Hki0B2Gyf/gYspkcZ078qQ==
X-Google-Smtp-Source: AGHT+IEAKix9avOZKhj3gUarttYPt1B5mxGGiNfGvZNqelGRoDbFczqf/+RGYgGgaLwvWmb22Hq7c+MIRiChzBxFm/8=
X-Received: by 2002:a05:6512:280c:b0:530:ab68:25e6 with SMTP id
 2adb3069b0e04-53438861474mr7188396e87.48.1724661989086; Mon, 26 Aug 2024
 01:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823072122.2053401-1-frank.li@vivo.com> <20240823072122.2053401-4-frank.li@vivo.com>
In-Reply-To: <20240823072122.2053401-4-frank.li@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Aug 2024 10:46:17 +0200
Message-ID: <CACRpkdb0rwN1YxF10MQDkVX1QoYTWot+heOJp4RodAtniCOdsA@mail.gmail.com>
Subject: Re: [net-next v2 3/9] net: ethernet: cortina: Convert to devm_clk_get_enabled()
To: Yangtao Li <frank.li@vivo.com>
Cc: clement.leger@bootlin.com, andrew@lunn.ch, f.fainelli@gmail.com, 
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ulli.kroll@googlemail.com, marcin.s.wojtas@gmail.com, 
	linux@armlinux.org.uk, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	mcoquelin.stm32@gmail.com, hkallweit1@gmail.com, kees@kernel.org, 
	justinstitt@google.com, u.kleine-koenig@pengutronix.de, horms@kernel.org, 
	sd@queasysnail.net, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 9:06=E2=80=AFAM Yangtao Li <frank.li@vivo.com> wrot=
e:

> Convert devm_clk_get(), clk_prepare_enable() to a single
> call to devm_clk_get_enabled(), as this is exactly
> what this function does.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

