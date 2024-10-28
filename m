Return-Path: <linux-kernel+bounces-385969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F7F9B3D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD63283C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EF31E32D3;
	Mon, 28 Oct 2024 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhvBuG7R"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95F418B463
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730153930; cv=none; b=KVMxG0Urz9M12TYqPYVcbbZIMdZkSz3jsiv6VyiA06h2rFwIhlNdepnZsFdaEzq/uG0aJXIi3OF0hjZ7YP1IBTw5g5Ccm8eQqC2wc2lciVPkzCDxiwbblg7N1m5FNNaVtCEVwIBFJ+AheLEd9dkBRxewf7p7QYygSNKNX6jMjhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730153930; c=relaxed/simple;
	bh=fyDzP1KDNX4YUcpzq6bZDMAMYCXTmjZ5IQwgWmqRgvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwKnfX7VWCxmiySd2ui6hb4ag8S5UJuirTKRcfV3KDG50vx1YWUdRhAQ94WS1mlMtC7NYzJTLaqMaWJPKp+Dh+eP5XyoIxJqtcU7NqO4kyhjoeEBKwwH8vrT4SjPs3IuY1gh7XIt7ER/7xu99iyES+EXLonRenxkZyIOjijrRjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BhvBuG7R; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb561f273eso43233861fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730153927; x=1730758727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Se9iykGyBG/chmZUoFvEpKM3NIz9y6V7vYmAmFmIKg=;
        b=BhvBuG7RO4OmO67/x4sJ/xTIjH/D5lvsAqSvJ2S9uLwRhhxl21fJ+BYWVRnfQVYrKR
         uKIsmfHcZt0nsZapDx+Vo0XUHHB65gvvb5z5YL5WmJg3BUy8oe20Zm/FixIWGLhJQffy
         0w++IT0fGuwvKFJ7dFfL+JRRSm8A/E03KGQzUT+8dXZJcNq33H6auF9moaS7bABPlbvO
         ehHwQG5+ghl0qTieKnMjTrMaNpVysS0FdHNceaSANTwsa0hfajDU+LflxUCPu6PCEyDr
         gEosHgOhrwBh8HwxZXQJjxEMsSwN5heebon3PhN7kL7uBA2bGq8L5Sjs2ORr+ATQBG8I
         b7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730153927; x=1730758727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Se9iykGyBG/chmZUoFvEpKM3NIz9y6V7vYmAmFmIKg=;
        b=gFXKYW/Ftg6ZNgrVfZdysopnEG160529aTuAn7t2K/T4S+UwDlYO1ky4VzvjNs9Oyw
         uc6WVfrYiuqrcYPG/xhipiUhwxdC5LVwumymC3POL/3gMp+smMgt+rwv7u7T+dEG7/5I
         D3MNbQlxwxWi6ighARJfGhj8WMUt4acUVBFv/vRS6/eLJAbhgH8V2z2x2Fi2S2go8iLP
         bSREc+/n6ZfFzOXibPHMDiIYiEkjvhFBco77OxHdcCFyyyTD11BO4TSRCWhay1AFCt/m
         6tk2dRI4lIqg7bUjndBmnfHtHwwI5uU/NRh5k5y5vrJeo3WUKRb2oLyrr+hPDKArrHWo
         9JMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzifoh2Ye3CTD+W6PGf3n6UFJwSlEuj70as3GbyOZPbQcyzwkDX1/SmQfEg7qbV7CurKIU5T3Bn5C6juc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ87QBNy7HI5uRF+WLYZlc/pwSFQWTb6r5OFb7eeSJp7PhtPtx
	9fqhhoGt2r/1O1sgkkrLg9/2xGfskpDWf7mzsL5OCAcTvoGWO2r5gvqppWghSXYLpiv99jIzNc+
	LyL6tDEwBen7AUCy1apONZiLPXCb7h3154rEaow==
X-Google-Smtp-Source: AGHT+IHaahqy5DPShaY8Y+oAdhFIt+zH9Ye+ooBv20FjvxHxSAXvsJDg8v4Gn3ijuKz+t3/EBWpVyq1RsiK+6mnMrto=
X-Received: by 2002:a2e:be9f:0:b0:2fb:5bb8:7c00 with SMTP id
 38308e7fff4ca-2fcbdf5f01emr41441461fa.2.1730153927011; Mon, 28 Oct 2024
 15:18:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1730123575.git.andrea.porta@suse.com> <b189173d893f300e81b18844a1c164fe4ad5bc20.1730123575.git.andrea.porta@suse.com>
In-Reply-To: <b189173d893f300e81b18844a1c164fe4ad5bc20.1730123575.git.andrea.porta@suse.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 23:18:36 +0100
Message-ID: <CACRpkdajY9efD_DMwoE0wpKDVf=+kcWzYQXOQMHC+pQS-ntsvA@mail.gmail.com>
Subject: Re: [PATCH v3 08/12] pinctrl: rp1: Implement RaspberryPi RP1 gpio support
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	Stefan Wahren <wahrenst@gmx.net>, Herve Codina <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 3:07=E2=80=AFPM Andrea della Porta
<andrea.porta@suse.com> wrote:

> +config PINCTRL_RP1
> +       bool "Pinctrl driver for RP1"
> +       select PINMUX
> +       select PINCONF
> +       select GENERIC_PINCONF
> +       select GPIOLIB
> +       select GPIOLIB_IRQCHIP

Just a quick thing:

You don't happen to want:
depends on MISC_RP1
default MISC_RP1

So it will always come in tandem with
MISC_RP1?

Yours,
Linus Walleij

