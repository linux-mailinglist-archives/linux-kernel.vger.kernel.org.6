Return-Path: <linux-kernel+bounces-274337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D499476EE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 639691C20E82
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 08:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7584014B966;
	Mon,  5 Aug 2024 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZXXjgvqI"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08C013C906
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722845485; cv=none; b=WUpWyp5O/pRlwmMc03MnY9/vowaIcr58KzcF+QJ4eCClXzJWWZX41ZZlQrjy5GLa34h+z/ZoddEoU7E0Vm7Za1n5YEC24klgbQFm84OQ0SqdvCS9mTvfDAsZQw/QRDeTlMKnN1nUWueJE/fKoNX4RnQ0+d0dJz8nKwKBxATzICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722845485; c=relaxed/simple;
	bh=OGaVx+qMhZ0b7otpK3O02Kw7IL7OQu7ghb0iUPKBQPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zl7CzcSkS0CoW7SgLA9b4sCTxQtnOl6mzRnkQkcedBFSPJVv6WKyzSQuPtNbiQYpoe1iXweeMZkDqMgtS26q/cQ9s26tCYcbWOo/ywOk5lVr8UosEFaKfMu02AEMpIiskRAmnpK9Lquyv7QJHQy4WRanoefKnhx+lt0r2zNhgRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZXXjgvqI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f01993090so14147038e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722845481; x=1723450281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGaVx+qMhZ0b7otpK3O02Kw7IL7OQu7ghb0iUPKBQPk=;
        b=ZXXjgvqIc5ePHCwNR8+DkTdAWjGsWOTN2rGFbNRBQbEZEExu2gDdX2Hj+sKMNZdHuo
         oJvb0U4F+aEo7QvSAale5n1Ixh2eeTUAhoqNu1DQ8kPIVCXE+Tc6NInk9GJ1TIEgqchS
         efs7VeT8zgMAaA4zKbn27VXl2e+rFIkZoPHxr/jRbcNss+cRx8Vg0iAdz1ryTKBfcoss
         txQdAQKbQK9UOTScsYSPqHY40TaeKVo+ActZy8DzdVO6E2+UhfJUlx0XDhIkuy2m1w7V
         qeXoCvKApuSqAIE0+sPWsNxDNIri15pJi1oyZ21aSBNyk/NOic5tsjwJT12A40JUG2ft
         TT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722845481; x=1723450281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGaVx+qMhZ0b7otpK3O02Kw7IL7OQu7ghb0iUPKBQPk=;
        b=m5GWeinPfpx27Z4hoIDjidhASPLj1mwbLCLSiI42lsXYgbn5P0dp7OZd+rNJH+6W0m
         MNIENYU7WKDyCbx2yqvdZoc2o7lY0cnKP9uBI9E72BmKomopXrmIo7vOnezVocQZVpe+
         iXsXVOY4SRqtO9snvjw2z1oqeCQH6J0NFfdcru3yqh0wQhAF66h4pMzvmQyiCk3IXjQH
         4HL2SfCNTb/xDHZ24ttnbDmoJbmP+T2U5dwxrhUfkMFacdGR8wgEHX0xh1y2LWtbYZCv
         mz0B17/IXqTi8FmvU6Vg/3RkA8VDhWsgm32BqeARn8167a1gSf9x9fhT8/dNKGUKIUOI
         B+TA==
X-Gm-Message-State: AOJu0YyTKYlHqlwrKV08dVJtGsi6VH0dfPHSgJrGAaEWkAsEF9wdpGFQ
	SpZa14B0vSwsAx96thOfPjKW5L5LgmuWB6aAGQg/YUTV7294g+zEdyvxjLiIDCxxdBgeuz0rohu
	9jrsDG9cTxaQZXKpGPIOnSksalg94VLXSuiLezQ==
X-Google-Smtp-Source: AGHT+IEexVYi+TyR4tI+GJL56PCbzdQ1IM0K1XkXHiZ4BaBgjJiBD9SkZedwISuAdeYS+5aa+vlh1tFok3PdTds2jiQ=
X-Received: by 2002:a05:6512:32c5:b0:52e:95dd:a8ed with SMTP id
 2adb3069b0e04-530bb385320mr8050795e87.35.1722845480886; Mon, 05 Aug 2024
 01:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723-supervise-drown-d5d3b303e7fd@wendy> <20240723-handoff-race-33160609553f@wendy>
In-Reply-To: <20240723-handoff-race-33160609553f@wendy>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 10:11:09 +0200
Message-ID: <CACRpkdYdxdLG8=_Xd7HLwQ5+pxwGw6Xte7=UNbknB8HR474bcQ@mail.gmail.com>
Subject: Re: [RFC v7 5/6] gpio: mpfs: pass gpio line number as irq data
To: Conor Dooley <conor.dooley@microchip.com>
Cc: linux-kernel@vger.kernel.org, conor@kernel.org, 
	Marc Zyngier <maz@kernel.org>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

thanks for your patch!

On Tue, Jul 23, 2024 at 1:28=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:

> Since the interrupt mux is going to provide us a 1:1 mapping for
> interrupts, and it is no longer correct to hit all of the set bits in
> the interrupt handler, store the GPIO that "owns" an interrupt in its
> data pointer, so that we can determine which bit to clear.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

I don't quite get this, the irqchip of the GPIO is clearly hard-coded
hierarchical, then why don't you:

select IRQ_DOMAIN_HIERARCHY

And use e.g. girq->child_to_parent_hwirq() to handle the
hierarchy?

See drivers/gpio/gpio-ixp4xx.c for a simple example of a hierarchical
GPIO interrupt controller.

Yours,
Linus Walleij

