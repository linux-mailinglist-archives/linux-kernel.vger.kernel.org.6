Return-Path: <linux-kernel+bounces-561167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE42A60E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338801B60939
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508101F4179;
	Fri, 14 Mar 2025 10:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+Nj03o9"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8581F3BA5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946908; cv=none; b=Z21KdaJ01CWvL5B+pk19kkDckdYB5lPf8mDbRAARd4REfKhmIuFI1WBbvSV3YrNe9F8GNZ5pwwYGDx5S1AjdSd9Dtt6SN4TUBznyvkuCOvxW1tf3RGPDkuRGG9D0k6r6MIU3fZJVhRu5aJmgikkl3oXg5PTlbSD06HV9vdA641E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946908; c=relaxed/simple;
	bh=Gt/9/LzPfx6RB2Ri4REYVqp1qcpJjg1U1nS59zQ5wMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E0bjHm+RyjzOTCwsVvuicRlxR0dQBquvU/DIzx+cBWeO0FhGdNTA6obT9wchEpiDzpCCDcVy4UVKoNdvt4klGmzWCov9Zhe2+c5vcIRyr+2CmtgFxxDUkyQR8iCByKeU9QWQUBakqoX139X828g5kU4AgW174W1byLcYsuYHFX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u+Nj03o9; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-548430564d9so2154745e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946905; x=1742551705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt/9/LzPfx6RB2Ri4REYVqp1qcpJjg1U1nS59zQ5wMY=;
        b=u+Nj03o9/G6Q5npypn/X5zXy0HE3LmSGtyjbWd8mdYRJwrtUgqLSPkec4dEGk/ACXL
         ooVyGaQLstHEUyYoMlCEPiIbwqiJkc7qzgG3rjA8vZ/YnO7kXSmmoJLtP6r7G0dcX3OO
         v74t5vheXTEpJbyLqpCBGk6j8eW7cgRBxv8xqQPL5KP83OqMDNpJf38npIpc63XVfEkQ
         z+HWsgdDwvT+plIZ55k7EoNcEEaq44AUxIYeiJ+O5/wU9MdyGNrStIe5r1okuenYV9OS
         tXZE/87lJTJ1IOoO2ra12tfpLsx3CbJWp2p9PrMwF1Grv3lF93Kgm3kzaitBHGnjzFit
         2d9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946905; x=1742551705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt/9/LzPfx6RB2Ri4REYVqp1qcpJjg1U1nS59zQ5wMY=;
        b=RohH2TVxf7fSooDD/3dcmJUWzEtN0LVUxY65iFKg2s8Leq7MH8wN1WDe1WxgfzfkgF
         /ZCXMrhiohsDLr0aTyi3NAAVWafC9ds2Gtpa5WcTr21TVQhN+37wfbfPoasgDWje9mnz
         gdaOO3QmgCKwcq22H/qfyxDun28EDnlfuMl34HqstaQ3t+BXLM8LoCiJhimNs6gH2rJv
         pJ+WYw2EQvtt9piUmKkiIClJTt6sOknASKeJ1m1Qi9v7wvRrOUy67kBETkxAN3rAzZjL
         CcW1JU53LW8XzTQLO+8ug2DhxdrTDDPhUrfoqn99VawmQZx3bfiCwqEymoSBHGqMb9WM
         a8Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWcupmHcjHP7yCDL0DLRCqZ4O/d+jOUSrSTUacaRdd2CxLbqola3asMZxWo52vXOnugbmr1KZITVlOVp4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+uO8RDt8PfOpHmFYGnv0w8RL4sfzu5VhzCfiutjngGMZBOlMu
	XWDHRyTu0r7znGOeSpv3nDI7sOuZTBEwHShQ6/XpXun/+WHRoqhHqXElqfuZ0Eb6PkhHqaHKgZP
	oevnDRtR1tzYF9p9bgv2MrhmeU6wploIW6pI6gg==
X-Gm-Gg: ASbGncuGM9AlBKnJWsxtI3QtRM0aOMXsXtYK/qUsCiINX6xuCy6QirmzM4HlbdpE+rd
	2KAXatrOJtsu2tOZuUVdEhaxQ3YrlZ6f2/ypPRqhJXkexrI8PjFzkWPDW7nK3KVdMVZAsPJa9BP
	RdZIOWZF8+5uLfMp3eGoDSRgY=
X-Google-Smtp-Source: AGHT+IHJo15rlSs7Va08NHOofodKMD1H1XNIRjRaa5BY0in+MTDIERdp60qoDZO21fZpfDmKsEUFpvdk8Y2VP5vuLUk=
X-Received: by 2002:a05:6512:b94:b0:545:c1e:65fb with SMTP id
 2adb3069b0e04-549c38fbccdmr671564e87.18.1741946904682; Fri, 14 Mar 2025
 03:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736522006.git.Ryan.Wanner@microchip.com> <821255840c09d8d9cebbb1f2daaedd8a7c138875.1736522006.git.Ryan.Wanner@microchip.com>
In-Reply-To: <821255840c09d8d9cebbb1f2daaedd8a7c138875.1736522006.git.Ryan.Wanner@microchip.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:08:13 +0100
X-Gm-Features: AQ5f1JqSOmT4FHz5UOAsw4lJg3-dP8L_NWpCJ5kNHWtjrkJLgD54yy-3c3bbVqU
Message-ID: <CACRpkdYYeC+2G0u0LYSUjAX_ex7MjWLhEcu7QdNXudj8BEO4PQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 2/3] dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
To: Ryan.Wanner@microchip.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org, 
	Dharma Balasubiramani <dharma.b@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 5:03=E2=80=AFPM <Ryan.Wanner@microchip.com> wrote:

> From: Dharma Balasubiramani <dharma.b@microchip.com>
>
> Add pinctrl bindings for microchip sama7d65 SoC.
>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

This patch applied to the pinctrl tree.

Yours,
Linus Walleij

