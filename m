Return-Path: <linux-kernel+bounces-411904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3569D00FD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 22:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF82D1F2355B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 21:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F222198E90;
	Sat, 16 Nov 2024 21:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rA3t9YQq"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACE115E97
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731792783; cv=none; b=ZsQwdy617PpAPGxrBTOphRI3N2GCEQIF4QM92kKorIpb9HN21Mf0br1kZ7IahiB3SkQXRJI4wXrNsH0qgmRjHJhtBH+1QPmkY7yWjD9jIYu7gTJCGILu5IVF7YHvgQIAROUG+QzoPYeWwxi9z79mcECsoqYt0fD5s1kb7sQki/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731792783; c=relaxed/simple;
	bh=dEUqjXsUzaxQfHkbfghKnXfI2v3l1ipW3W1IFWCd5gY=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=p2/GccoL3v5bdhSghIWqStC91pnpLrG2iOSxLXLoI19bRpv/wTDPNxBuas5DE4O4m0+TX+wuxUHpMnxqkc/DfFlBYJkn56pSn1GuExf828anNSYJ6Z9PKdcG63sfc/rp+y9zO2OD8KoWRtc6YMXQA59PxsbuCmDoEdnZf7239hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rA3t9YQq; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2D2743F2C0
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 21:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731792773;
	bh=fmAemAqFyetLPXFFHnZ9TzZGuiy7HXnbjCZZxtYlmL8=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Content-Type;
	b=rA3t9YQqBDA0nvLeR08auH/+rhU5LdKt6PYVlqAZPYM9P32u76ANljcBGzNiY/AAH
	 W4SuXhCx8t0snzdWjIxPluIHNmPDPWzbQ03vKEgEnOmOt8EeN09p33DDjWTSwKyqG5
	 qmB6maXOA2yDL40ENloQFUT4pD17/+cCbulqgNgVjXbKzjRvKM94io9bPARVfjPj+P
	 Lj+bQ9hYG97uuG2F9LNbOyaMC+19wPzrwY4n6F36FOlMc4AAuRmZU8i7M6ZveRcBO4
	 7U255Z6y4KQbe40QgLcyjjpEizjyW5gGwt+dBTXD/EykI2reNrukEqbbrgW+5cx2pQ
	 Ttg70AXxvzZvQ==
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-2964720a511so673814fac.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 13:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731792771; x=1732397571;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmAemAqFyetLPXFFHnZ9TzZGuiy7HXnbjCZZxtYlmL8=;
        b=F14gcr7I+a1sjG4P9tiXqxLzH4+QQV5bScybaVeWgr9s1gw6OUNi09MPX/A/dFg6QX
         K6Kmp7+y+5hTuIvS9WpNLVd54rGahjBmhwXJtZF+YVzUT+5QMGQa/l5UQDjO0gEXD0Eq
         c3xa0U5HW+KMW/Y8QmY3wEEMU7m922QuJrHNvynk9srF0aFgz9cKQ0MjLlJc6NjkGyZI
         n3+PTkOXkD8YQtzcc4WZfhiksMjWGlCgCe1p/uuXpINZO5RR4elUTATjJTN3NPy3rM8L
         8WB/Go5hYOPRbf+aKIbnITJqT8hq18jUakS+QghhHas+L6GtB2PxdD7EzZlt1x9gvnLR
         5Z5w==
X-Forwarded-Encrypted: i=1; AJvYcCXjtWUOf6W9g3+DBCyYvPkWh1fpYWNu/hfMAOhN6VJl3fHSidxyW9EeqDuv9zRtrq+9LIMOeIHYjBJg4VU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztx/Zt5HLmeFP9kdHZ1dnbwO8BRZUnSsDv8x62VbTATa3/serR
	cGZynrbSjbpJKOq0Opz/6syzWgefGMWOL1pgZHpeo6lbWHyEnrC2PdUD9tmJfP3AWM8j3dwmBBx
	k4um4GXjxEXeffGAFdXbRpEoy0K0Dm6y/kRBQkhrRtwelj24prch4NUi5S4x3WHl1AFRUWqWPYB
	QXIvkmPyV0jRdgiciKC19xCQh2P/oggtx3pAkOIo18KhkfIlZlg/+9
X-Received: by 2002:a05:6870:75c8:b0:254:affe:5a05 with SMTP id 586e51a60fabf-2962dedb297mr6559784fac.21.1731792771130;
        Sat, 16 Nov 2024 13:32:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELtO4V2RHfs6Yj+eIbaX82LviojGiiluYE09Wmg5o0ei8JG6pU9J+XS5YGYrQ2jHlSSLFj13Doph221IgSbgk=
X-Received: by 2002:a05:6870:75c8:b0:254:affe:5a05 with SMTP id
 586e51a60fabf-2962dedb297mr6559770fac.21.1731792770837; Sat, 16 Nov 2024
 13:32:50 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 16 Nov 2024 16:32:50 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241113184333.829716-1-drew@pdp7.com>
References: <20241113184333.829716-1-drew@pdp7.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sat, 16 Nov 2024 16:32:50 -0500
Message-ID: <CAJM55Z_RchO-Ke1aXXAaB5f-OJEYcHU6n+MVtBTCUSXrHOQp1Q@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: defconfig: enable pinctrl and dwmac support for TH1520
To: Drew Fustini <drew@pdp7.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor.dooley@microchip.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Guo Ren <guoren@kernel.org>, Yangyu Chen <cyy@cyyself.name>, 
	Sunil V L <sunilvl@ventanamicro.com>, Hal Feng <hal.feng@starfivetech.com>, 
	Chen Wang <unicorn_wang@outlook.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drew Fustini wrote:
> Enable pinctrl and ethernet dwmac driver for the TH1520 SoC boards like
> the BeagleV Ahead and the Sipeed LicheePi 4A.
>
> Signed-off-by: Drew Fustini <drew@pdp7.com>

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
> Changes in v2:
>  - Switch CONFIG_DWMAC_THEAD from built-in to module
>
>
>  arch/riscv/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index b4a37345703e..d26e670404b6 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -167,6 +167,7 @@ CONFIG_PINCTRL_SOPHGO_CV1800B=y
>  CONFIG_PINCTRL_SOPHGO_CV1812H=y
>  CONFIG_PINCTRL_SOPHGO_SG2000=y
>  CONFIG_PINCTRL_SOPHGO_SG2002=y
> +CONFIG_PINCTRL_TH1520=y
>  CONFIG_GPIO_DWAPB=y
>  CONFIG_GPIO_SIFIVE=y
>  CONFIG_POWER_RESET_GPIO_RESTART=y
> @@ -242,6 +243,7 @@ CONFIG_RTC_DRV_SUN6I=y
>  CONFIG_DMADEVICES=y
>  CONFIG_DMA_SUN6I=m
>  CONFIG_DW_AXI_DMAC=y
> +CONFIG_DWMAC_THEAD=m
>  CONFIG_VIRTIO_PCI=y
>  CONFIG_VIRTIO_BALLOON=y
>  CONFIG_VIRTIO_INPUT=y
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

