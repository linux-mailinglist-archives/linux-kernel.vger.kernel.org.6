Return-Path: <linux-kernel+bounces-310988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728559683A1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27AFF1F21887
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AB71D3184;
	Mon,  2 Sep 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fQJmJfM3"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33F1D27BC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270625; cv=none; b=Xo6PyoNWBiKNU51YOoFK8rJx2MUHSoxvA5PGXUM1BTDMOBCkWT0gcugt/eK5MwgWMPJVH1SdFL1OhbtrWi8/k6o9j7QvPdaSbW3ugDLNI2R8+xVZRMIvMH9odXqkIkm1SwzwLnjh4lFCHZVbP7e1zGzkeXpW8nlL+rWN5/MPG/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270625; c=relaxed/simple;
	bh=28McJcVKs42ZY9Sq0kv5hG33Yboh2UqyM8r6czZX88U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvgzNVmyIC/1MprzG3+tBg2cd+bDYfcQQySQuYhrTn5594WXW5/ZfMY3lspk+ZAZDGFmI55SvxeIm1YrDUw7VNX1LYA4EPPTiWpeWPVT7AWrV4In83JCAv2nc7d78CkMHzCf+GoW1h1er7Nkya0OlcujstLje2RlndkYxX60FIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fQJmJfM3; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f3f90295a9so44096551fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725270622; x=1725875422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28McJcVKs42ZY9Sq0kv5hG33Yboh2UqyM8r6czZX88U=;
        b=fQJmJfM3bxDIA8JgfCiwG8tAZrBQpb0Ta8h1hshKZR/wqjq8diVlFu3v5wISePnfmr
         7CBwrfOFTRVhSJewyZjTjigC0RqpomBTVN7QrNfKtcsOR9kLdYYPWKm/xL3K5CcZjogK
         8eV3kqoZVehKa/zqDVIwTH6JLClY8E2mi2bJO5KZT0gLHe7/vnRqIFEhmjoXVZshTDGN
         aUTOIkcOesVnEmkHqGnZKjzw5vLC13Xk6kCSratOYjSB5z8sJRDKsdYV2ugLwJWvRcmf
         GqD9OniP1NrpiJnZrUlQtKPQIWzpDjXVdFO01JdJkHWA6RkPANZYkdrsyiML1wRyOkSD
         0Yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725270622; x=1725875422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28McJcVKs42ZY9Sq0kv5hG33Yboh2UqyM8r6czZX88U=;
        b=Fomd2KYQz7JYYLAdMFCflbQgGOE5zB7DHwvahU+1Ztqa7hP1F6UDj9kXB1uh78Mi8L
         NqPxqwx4q+fZs2SDIGDMBFc6T/YtGtxqMQs4rcUaNShwdsXdejJLAki7ro8HuhrAkqo6
         uvuY+pv7OXGWajTi5G9Iexc4xvCVXPDl3Tcn+gOaQErmBlHXQvJ74m5XNDPK5yOuHFf0
         hqSZ3afcJ73cqhiRpDoehzUKDDeL56sIixhXRQVGZsExqZEezMINbmSI+3ZKrLVlobxg
         h7BON1OnicTc7fh2euV8LmCrlQAFAAybhkLduVK1QmReVh+zJwYDT7cgxynWlQPU79QB
         ozrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbnh0t5EtQgNVZ8swVFsfOufBKBAhn4MQFJUMArScQ8B7wYDierKZq0LPzw8HUmTi7YVErcMBJC3XZAxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3mtX9xB0h72wlgkNndWfEMab2p8Acre8aoDF/KO/YcZ/3Ivx4
	bgImFaWrv2ioWwh8eSqusxg8RGcMUCYw1rs5XcqVtLUbtbvF26dWk6NEbwprQukXuz0KBeyCxfD
	WfPCUnUaL8pN0T38VAqga7CdnFQQhaym320/L5Q==
X-Google-Smtp-Source: AGHT+IHzAjC82O5fFXZUuxREWWYMeyebjNflKtG1tJUMYRTIdDHBfO7anU/6cm0HwOYbXK/491VB93Nh9ac09yNZ/4I=
X-Received: by 2002:a05:651c:552:b0:2f0:25dc:1886 with SMTP id
 38308e7fff4ca-2f636a04470mr20450581fa.10.1725270620988; Mon, 02 Sep 2024
 02:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828-dt-bindings-gpio-hog-v1-0-63b83e47d804@linaro.org>
 <20240828-dt-bindings-gpio-hog-v1-2-63b83e47d804@linaro.org> <CACRpkdZzF5yJQnnDsjU8cTr9Fpe7wZZXoW3K-wFYuAq2vv8XxA@mail.gmail.com>
In-Reply-To: <CACRpkdZzF5yJQnnDsjU8cTr9Fpe7wZZXoW3K-wFYuAq2vv8XxA@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 11:50:08 +0200
Message-ID: <CAMRc=Mcv9nfiG7N-ttS_A=Ay-5Wv2mYpT+41G1u8G4GrMQAuEA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: qcom: add missing type to GPIO hogs
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring <robh@kernel.org>, 
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

On Sat, Aug 31, 2024 at 12:32=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Wed, Aug 28, 2024 at 11:36=E2=80=AFAM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>
> > GPIO hog nodes should define type, otherwise "dummy-hog" boolean
> > properties would be allowed.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> I suppose it's best of Bartosz applies this to the GPIO tree with
> the rest of the series?
>
> Yours,
> Linus Walleij

Ah, I picked up the GPIO changes separately. No problem, I'll pick
this one up as well.

Bart

