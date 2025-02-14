Return-Path: <linux-kernel+bounces-514781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982ECA35B82
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6FA16F120
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C07D2586D2;
	Fri, 14 Feb 2025 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dR8dTbRQ"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F901228375
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528734; cv=none; b=QWP16bbObmPMkY1r1NUaeQMwLsUNIcYU8x0fq/ewEOzlrvySA3Hs0n3Qy+uiwiqKNefithoCVeTSp5mn/Czydv4CMQc60YyFQrzvb8Nf9QaHbq1ohHf64CYY52Yrq5/DjBf6PabeTagzRJkfG1ZwNM33pN5JTFi/LD/XA4QPCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528734; c=relaxed/simple;
	bh=k0ZA9ZOZTnv0fajLPHLG7bzzy2Bw8GSC45UzvaKQ3pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W50b8OirVKlpdMi+qVmNI75iTFmtktZKXy1ny2ldE+8bU5LDsF35PhykJgeTKa3Ng6PUEIEZ+WVZQ/3wNEcAYgwFwgh219cQEBYPfaKQywuJrI51/WSQWITLMsOfpgP0LqFyxEEuiKyFNUDIsyiwK5tJLyFsUMiKHhJUC8N8ipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dR8dTbRQ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30762598511so20376241fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739528729; x=1740133529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0ZA9ZOZTnv0fajLPHLG7bzzy2Bw8GSC45UzvaKQ3pM=;
        b=dR8dTbRQt22xnk4ZypUGOO7iU+X/uwhuyRr4WIN28RMqoYqktRDq7M4uuMpz0WJXMO
         L2vt2QOsdc3iVGTUndnZ3rTdbiz+jM949+7Cm/gbf3/b1hGrvg08CX45OsW3KIHB69Vv
         N1csjluvm2OULfmEZJ1OHqsRgHGrLwD39n8oxniR2CmLoJQBLvmXbmLvLRiqdA0KR+kz
         aukezJVu8kGNDCGMwLCkcvd24TgFztKI3SUWIdVOm1ihdBei/T2cHirCqvABa8+oDcN5
         BRP5OkgTNi6weGUkUqaQFXhUFYj+9inOUIKIGTNn2uU5xzZ+oweKdA+rkJ9zXzyOdL2j
         D9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739528729; x=1740133529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0ZA9ZOZTnv0fajLPHLG7bzzy2Bw8GSC45UzvaKQ3pM=;
        b=m7xZN6QzPa2BMBSmSQc/xRPPmnzJYc4WZDGk+jZrcOb0oCgNNpaZRO3YWm9Wp07Au/
         t67nkszJBTXRABD8kISdNJM1ZeS2YnsNErVJCC/o4yUI8NuLwbc79lBufRhkiHL7NbBE
         MoTmO0tCPpe7GX0YSN4s2wZPNjRCVv10hFXFyEzeiMlM/x0Q5vTLvmUt/Ph01flZZ7/g
         QoRYQVbm38XxfyLH/IL6u1RV76N8YSyn01X3jOICQuQ4ojFT+73oMhkiNTTj95VUGZWp
         rwmj5ZdtGNRU9LMTe9vwb9sAwUp4h/23HyuG+AJus1wLPk22laxTKCFYHbJurfCQ/Vcr
         C+CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHhuhARw7TggNRB8O3clFf6MiUH4tpB0nPQ3apediGvkdo8uR+06xnrX013hCkecJ4RdqQ9P8Gm3M6GLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgtAPFrSYOYvNc6ryoZHY39Ah1oTWs5DQ/OgrwZvrWTEhm5QPn
	WmVQkVrB4WGE55y5cNhL9zMSWp/xGadP+Z3Ff0U7h2LP3L0OPll4UEJS0NWXul2Y/H2/hJCm4Rz
	HETV8D7PNfcoK0MZwu0Oc6G2k+2sRJC8szJ7CSg==
X-Gm-Gg: ASbGncvJvLUElzVCI/sKCDSy796iyRDNrE37fxzgKRMtEJ6owweeQMkf2aQE307f4qp
	lKl1Ev55WpAzGgLlkJXp4YRIyFd6prXBpx47xV+tvBVt0kYYxmjZf9sSKFbz9dhVuxXahJ+u7
X-Google-Smtp-Source: AGHT+IE9Hh8FY7yC6rWfR8h5HiUv5X+JqNPHfu9DuGImiZxAFDUtqBx67po7/8F/mivoIIRcv6W3Us9lZpgR3fWcZMk=
X-Received: by 2002:a2e:a595:0:b0:308:f580:72a4 with SMTP id
 38308e7fff4ca-3090dcb712cmr21363841fa.1.1739528729288; Fri, 14 Feb 2025
 02:25:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212100532.4317-1-hanchunchao@inspur.com>
In-Reply-To: <20250212100532.4317-1-hanchunchao@inspur.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 11:25:15 +0100
X-Gm-Features: AWEUYZm3QlH_GBZnkUEfNjfulhzgaPXWxFksRd157QzemkZUnJaOAOo2a3cEisA
Message-ID: <CACRpkdbiNg66sToZ2X+G7J_qJSTpkRj1BgWbYX1_YmbGKdCmGQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nuvoton: npcm8xx: Add NULL check in npcm8xx_gpio_fw
To: Charles Han <hanchunchao@inspur.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 11:05=E2=80=AFAM Charles Han <hanchunchao@inspur.co=
m> wrote:

> devm_kasprintf() calls can return null pointers on failure.
> But the return values were not checked in npcm8xx_gpio_fw().
> Add NULL check in npcm8xx_gpio_fw(), to handle kernel NULL
> pointer dereference error.
>
> Fixes: acf4884a5717 ("pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO driv=
er")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Patch applied.

Yours,
Linus Walleij

