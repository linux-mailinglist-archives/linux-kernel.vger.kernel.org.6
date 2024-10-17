Return-Path: <linux-kernel+bounces-369853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD309A237E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889EE28AD65
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E641DE8BC;
	Thu, 17 Oct 2024 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aftDWt84"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3F1DE3B7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171064; cv=none; b=K9ioGYgWhWKHBiQt8i1fF7bpyqyiwSuu3ZEX9bhefkqcTjiza4EqBb6HmsM5cRTSmSuY64boxgU30q52bkUK4E1/JwqGfD+UsxpNb51IZGEtyNHPao+0KTXNb4ET8LEzn0x4KuvK6TcrY3j/qEcwEO3AFHisnjc7E0MurKZ1qMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171064; c=relaxed/simple;
	bh=M80KJaUJhwYjKgSWSRxGEkNHoJKkVbBVNZbxQNfoSa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7JfoR8GjbnuZPb1uMZNYAEBj0nT2SfHJhcJ0CAMzd5AcqZhfdiNzscDHtot7nt+pIYVsTRiAtzy/2mnPWUkRsHQVwcQJrqXqBwdCpLDE8yHzrOGbIw7qYSR8JvX8vlV+gbtuS60rPhkgi/LSPpzSs49yhoLmy2xIxnLrRYw+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aftDWt84; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e297bd161e0so834479276.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729171060; x=1729775860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M80KJaUJhwYjKgSWSRxGEkNHoJKkVbBVNZbxQNfoSa4=;
        b=aftDWt84hAC7wHUkZm6vXgWrflNsT5qLxnO+/kzev8dLjsLbYYLiCYOCrxmQhYlV2I
         /zsrk/m9d+T/KOeGxpqno2I9KKD67npTA41WPw9302GFBguOj1zzhqRmxVsx8JGkUqP1
         93RHUinqlekrq5EdIAeUmaaM/sqgG2WdMpvUWVaWANSJcQmdynRxamLBWf8Jnk9ZHLoA
         qbYAyB7HlvQXrvnm70I6t7wEQt32iY30dhUDVfE1P0P2BvMoKfhUm5OstlYbTV9mWEEt
         3J5p0gqexfTFpDyLU0XhXpkvTMLQnDRvE751oNEblttODwhHbs7A+hifTI5x5sw3KtyK
         ibMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729171060; x=1729775860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M80KJaUJhwYjKgSWSRxGEkNHoJKkVbBVNZbxQNfoSa4=;
        b=vldlo0UAuKBcP5OZ33CdVJvU0+5EY0Qtjt1MvcNLwBtRdd9z1ZpmQipIds80ohrVXv
         eODDKyRHIqiaQXPnTETXCMTtvzQ8bumLCmzMDhJ9W9Y+l9C0UFJgxq1pVmqsbZT5xrTX
         Xbjkn5LhTt3tdUPMuJBTEMNePk4Oxw1OkRl2KCdOZta96t1IPKO6nMROB7xSXkvNLEV8
         HI6qA1sXvflB2n9CVLRzvKQgGkFI2ODaw84MCpACsgrrueMH4e7Kv+xWRDgZ+FTryBiS
         TERQNRABhVLimVpJd9Jen4Q6fzJzSrWYvw9+k4txjJEvely+sO/6LQ1VTiM0BhvXgzUK
         +nyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiUKZk2hsI7ARMUg6igNCDEG3IQJRC7dKX/9KdtApULxRSJgysku2Af7IMmoasMb5jiaP9UISoV93T2lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTWPEC2e4hynI/JI/C8rvXjZacIh/2SRiziyEZVZNOfkCJdLmZ
	PT62abKBKMmO8orqodfma4g4wWait4z4YAkStKJR6JsqmC7krn7l+e9apaWC/YMwlgCZAF0M6NA
	K/FCavtBD/w4ceSqZ3hVDnhR3S8tqNYLrvmHwiw==
X-Google-Smtp-Source: AGHT+IHQyuuZiFyiR/8CqgHZ3Ze1mX3TGpRXO2WJHrKDNOMyyMzBPjljeY9XOAQRYtgoHlWy6njYbOGztV57jWUiMbI=
X-Received: by 2002:a05:690c:6408:b0:6e2:a129:1623 with SMTP id
 00721157ae682-6e3644d2f53mr155636427b3.38.1729171060105; Thu, 17 Oct 2024
 06:17:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017113942.139712-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20241017113942.139712-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20241017113942.139712-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 17 Oct 2024 15:17:28 +0200
Message-ID: <CACRpkdaTT1DDi1qVXJ8OBBrfQM_BxpESRuSx2repL=vjhJd8WQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] pinctrl: pinmux: Introduce API to check if a pin is requested
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 1:39=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Introduce `pin_requested` API to check if a pin is currently requested.
> This API allows pinctrl drivers to verify whether a pin is requested or
> not by checking if the pin is owned by either `gpio_owner` or `mux_owner`=
.
>
> GPIO pins used as interrupts through the `interrupts` DT property do not
> follow the usual `gpio_request`/`pin_request` path, unlike GPIO pins used
> as interrupts via the `gpios` property. As a result, such pins were
> reported as `UNCLAIMED` in the `pinmux-pins` sysfs file, even though they
> were in use as interrupts.
>
> With the newly introduced API, pinctrl drivers can check if a pin is
> already requested by the pinctrl core and ensure that pin is requested
> during when using as irq. This helps to ensure that the `pinmux-pins`
> sysfs file reflects the correct status of the pin.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Provided that Geert applies 7/7:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

