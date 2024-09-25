Return-Path: <linux-kernel+bounces-339187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAC1986134
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24670282649
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAF719047F;
	Wed, 25 Sep 2024 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jm2x4cJD"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE339190067
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272941; cv=none; b=ipGa1B3gBmY+1KKb0Pf4tD6bkQI1inSzEuLc6w5Z5Mee85ZDnVc/TK8dWjV+Vf8rjkaa3pjscvHEFLVDh/epsv2m2kCR+xJeLXjBOj6gkB0EDtG7oh14O9I2TYh6DykFllXAt5mXETKOeILFpJ63dnZ2FJ9SBcZRSyIlCLeONUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272941; c=relaxed/simple;
	bh=8YDbIe30UvCTr+iYs9UYlXuVaHXcwLqJ6aCT2H4HVPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZG2S28X0qt9qv0CGGLJ5GgG0RxTSGQANRZXtZ6SskO4VvQuP93R3r13XiYFcPcUBs6X8zuWWbwfOQXDhdnlx78mckfpQ9qj0sYeeSkTo1HCFNlcaHS6zDcY/BVa88/yI0b7r2A1PNPtVx1x7fNTNquPqjqOCa9rBSZS9m5hqt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jm2x4cJD; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1a9dc3efc1so6834022276.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727272939; x=1727877739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ToUKIzEuriYR9o6QD0qmgl4Fmelj6t2JR4wuG3YJ1Ec=;
        b=Jm2x4cJDhL9aeCvoBj26hX7AJYtpH28Rw6yhcsDcFUtiyoskD4xT/cVvWWm9k4wHNL
         ytsm7ISRQritfJidLUZBAbALxSZu5/djTbg5P/KKe/LfNJCmNiiBIdu2nJc5kcWCm7xD
         HkbEfW38ePft7IMtJFF06W1vT3gnWHtwsUBlmwbwAekUpon7b/hZjLM1LGD84tUOEarL
         pELarkq7fhcdfw2DK1zgUWeFxLwaeWwLYHcMKgquR4Uj3oIjByZFzaMFruu1lRRuaVVI
         F8akQ1LfsllfeUk6dU/Am8Vv7EPdP/MiGm7HXYsZCqBvMFnXkvi24Wo8gF1YubBHd57w
         +efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727272939; x=1727877739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToUKIzEuriYR9o6QD0qmgl4Fmelj6t2JR4wuG3YJ1Ec=;
        b=wdSR9wgwM7I1EAOEC47CJ6MBTVUPuWNAgSa9ATcpgVkNikOOOv9PGjjP8Z3oB07BiQ
         F+ADtKRXwUxP+bK2w+1UDM3qMQfbEGqIsWqYHmZTi1WG8X9rC2822LHYC/cfVtHMO0ut
         F807sguV1oQhqgBEvesZObNkSdgnX8EXd9SGWeuyMJ31FQ4VSER4Y8h+ioXUQnF6AtAP
         XcZVC1EO+q2CShffnbfO6M5dElGYualQ58vUfX1NBQ27fyxDIkEf9bjg7Gvr+eZVoEns
         0xCsntvtf80f4S1K9n2kOFaI3qeBSS9vM6qR/G89Flm21JRM02tMuqZgrJ/HWp5Mqbgu
         M6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCU0UYPoZ+D+phF+0oIu2TGXwD620Jxcafx00GLcCfGBWRZgKV2wv7tkf1dqAMshfkdqicltujXlAJYA4UA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZknHg/7470pU34nmgesCJsr87f2ulnhSA3/qHWWXSa7HzQ3aw
	BO9uOhI5m8zrVTsArJNunphQ3q+fCEOvLaFwEEWNfJBduAdMdvO5lAhnPkGX9CPpD0ZdvaoWkiu
	3AQ7NJgAlI7An9zdGSCxadCXtuftBFtOLXPCygA==
X-Google-Smtp-Source: AGHT+IE841pjxIKVha/+JpcEn2ee0Lx4ty464a7C8jVO8vOObnE+8Yr/dOWMzAzJZ++Do5wiVDiWTFPS1iajgW2vevE=
X-Received: by 2002:a05:690c:67c7:b0:6dd:bcfd:f168 with SMTP id
 00721157ae682-6e21d833475mr25994197b3.18.1727272938607; Wed, 25 Sep 2024
 07:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826081900.2284-1-liulei.rjpt@vivo.com>
In-Reply-To: <20240826081900.2284-1-liulei.rjpt@vivo.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 25 Sep 2024 16:01:41 +0200
Message-ID: <CAPDyKFqJAwr7S9nMywnEica77+UeT9pbbcZ05g7+xmT_1Xtd7Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] usb drivers use devm_clk_get_enabled() helpers
To: Lei Liu <liulei.rjpt@vivo.com>
Cc: Neal Liu <neal_liu@aspeedtech.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Daniel Mack <daniel@zonque.org>, 
	Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Bin Liu <b-liu@ti.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Aug 2024 at 10:19, Lei Liu <liulei.rjpt@vivo.com> wrote:
>
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
>
> This simplifies the code and avoids calls to clk_disable_unprepare().

As I stated on another thread too [1], using devm_clk_get_enabled()
isn't solely a nice cleanup of the code. It may actually introduce a
change in behaviour. Therefore, I would not recommend applying that
kind of changes, unless some of the maintainers acks it or it gets
tested on real HW.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20240827074857.2671808-1-xirui.zhang@vivo.com/

>
> ---
> version 3 changes
> Fix the email thread.
>
> ---
> version 2 changes
>
> The files ux500.c, mpfs.c, and pxa27x_udc.c have incorrect usage of
> certain interfaces due to the lack of synchronization during the
> commit updates. These issues have been corrected in the v1 version.
>
> 1.ux500: Incorrect usage of clk_prepare_enable() should be corrected to
>   devm_clk_get_enabled().
> 2.mpfs: Incorrect usage of devm_clk_get_enable() should be corrected to
>   devm_clk_get_enabled().
> 3.pxa27x_udc: Incorrect usage of clk_prepare_enable() should be
>   corrected to devm_clk_get_enabled().
>
> Lei Liu (5):
>   usb: aspeed_udc: Use devm_clk_get_enabled() helpers
>   usb: pxa27x_udc: Use devm_clk_get_enabled() helpers
>   usb: r8a66597-udc: Use devm_clk_get_enabled() helpers
>   usb: mpfs: Use devm_clk_get_enabled() helpers
>   sb: ux500: Use devm_clk_get_enabled() helpers
>
>  drivers/usb/gadget/udc/aspeed_udc.c   |  9 +--------
>  drivers/usb/gadget/udc/pxa27x_udc.c   |  6 +-----
>  drivers/usb/gadget/udc/r8a66597-udc.c | 16 ++++------------
>  drivers/usb/musb/mpfs.c               | 22 ++++++----------------
>  drivers/usb/musb/ux500.c              | 18 ++++--------------
>  5 files changed, 16 insertions(+), 55 deletions(-)
>
> --
> 2.34.1
>
>

