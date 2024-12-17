Return-Path: <linux-kernel+bounces-449331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A95DF9F4D50
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7264A1890035
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0E11F4E41;
	Tue, 17 Dec 2024 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ud2hNPr5"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BFD1E47BA
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444685; cv=none; b=H+E+mEL6qC/QjBAH+LV/arsPXlR1P1vVeW6jaRaFY0QXnHOCD3LdIheZ36Yq4BAY096jjch5beqBxZ5tjOKP+hqnkUr5URxv6BlLqZVUUcPjIXISbxXLjc4gjq6UUAeUy2JoBF1f0cifKWAwmSvsnImjbhKpAkYcgH0QtifRtWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444685; c=relaxed/simple;
	bh=8LEMCHKRS+LE1RqUP1A6fftRK+VowhA6EuhQTuy+2Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUBMPiwu1AvXH5SPZmN3AUIgb2Sbwrke6FTLrYD8vrfUg1dOu0XcfFuoxh/CH1jhFOQCZ9lLEQrBVBrSh9SlBWb+SN2+8N02I5ETc8N85x3n27loqlVpyx/zMiqVG1dW0MFx2GuimqqWFrVJpmIFohkhiryyw9B37AiXADJjaSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ud2hNPr5; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-540215984f0so6015670e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 06:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734444681; x=1735049481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAhkRZI/DJr0Mto92qRa3lv3xoIGjVxLYwjI1gESl2o=;
        b=ud2hNPr593IfYLfae+AirxmVozIu63PrP2mj2oaROzkn7kr0YZZW9B7qGJnAfHrvhV
         woX7hC3aQKnafZlm2Qku/iQ1rVC5qfkqqHmT+HBAHBLOxHA2D8lizfgyspOtdmHxnD93
         ChPg60sCJQeJEQE+9GHed0XbgoDUSOJ6oamZ3eYP+Vmc/j4onwDuUn9x1QLrSYc6RjfD
         FcUK6v7Uep2gSc0upbBTwDPigpm2NebVl+Jb9jpN8taTIrQ3tvIlcZfsp63Jpp3cg3IL
         x1HaCAEj1NmgijAPbKHGz99f0tQIGkCpne6NusfUyssv4pKjvmfLlPBauyxe8+JtAc8T
         1XUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734444681; x=1735049481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAhkRZI/DJr0Mto92qRa3lv3xoIGjVxLYwjI1gESl2o=;
        b=gY6UNnmOfPVk9Oej0RXlSkjWuOEqbwCHTa1DtWxqSAyYLHmnb1IVnPH/XETLL20HKg
         oH2i3VO8/EG1E71Q3uR7vYcaWHLUpGuQEAMe0rv3j6O+ifwlPDvWQbCgsX4TW6XuvdwR
         Nx3iSctlAr1wOmT+3N1eDXHSSJcK1b9K7hkAK5Jd3QjeTnBhs5i2LbuUmRtt78ixPUFe
         9Aj7b2dWSosRkoW7xrmprw+vTw6UFPYu4G72uUrsTf7awsHNoFBxJWVvQe9iuGGHw7Vl
         ZS/KPpzUFibU0T8vrnzro25YEw0nPIyTg3ZMKpI/jtPswaLrkGmb6gMAEsWT7D6yHkOR
         M2Qw==
X-Forwarded-Encrypted: i=1; AJvYcCV9Q4aPTveHGb74oN3W7SpVztNji8UAeM9Ll9+tZ14zcRC9ZDoA86n9OujA1+WDvZTP4AsJehSf1MEOD4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YykFhV7SNFnlM5nozVJcMzBarllU4oVxNcUD05vKaMFaEC0+dJj
	KRqev9GWou9m7k9qOTdy/ur01hZQaOtzVHmc75wUqbFvQSip4RG2HM7XFalFOiSRzQ5GJWuXeJQ
	98KBN8WYuxKOFjllVqaaUg5PiEjtD5/1JhDut0w==
X-Gm-Gg: ASbGncsxWPt4W2uCcBwYJGgLfuNlUJSjW1tU5dYFd8g50gLYMONWIvQR4sbQa+sqUCy
	hr/nFvnv1FyWWXk58BNRovfUln2Z2SuYc30ODyg==
X-Google-Smtp-Source: AGHT+IHlfNzVpuZ2mLV9cI8GhXcm+Cf/+nMgpvHestuuhPJYfxjJ7mzNvXw2jesvGX1QEluGHQQrwnwpLDCfoloHMOQ=
X-Received: by 2002:a05:6512:10d4:b0:53e:3988:f682 with SMTP id
 2adb3069b0e04-5409054c38amr5823134e87.18.1734444681539; Tue, 17 Dec 2024
 06:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209074659.1442898-1-e.shatokhin@yadro.com>
In-Reply-To: <20241209074659.1442898-1-e.shatokhin@yadro.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 17 Dec 2024 15:11:10 +0100
Message-ID: <CACRpkda4UGxAjXFOAu5SA9GX=9eNpXcxqUzkabmtA_sCqUG7=Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mcp23s08: Fix sleeping in atomic context due to
 regmap locking
To: Evgenii Shatokhin <e.shatokhin@yadro.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikita Shubin <nikita.shubin@maquefel.me>, linux@yadro.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 8:47=E2=80=AFAM Evgenii Shatokhin <e.shatokhin@yadro=
.com> wrote:

> If a device uses MCP23xxx IO expander to receive IRQs, the following
> bug can happen:
>
>   BUG: sleeping function called from invalid context
>     at kernel/locking/mutex.c:283
>   in_atomic(): 1, irqs_disabled(): 1, non_block: 0, ...
>   preempt_count: 1, expected: 0
>   ...
>   Call Trace:
>   ...
>   __might_resched+0x104/0x10e
>   __might_sleep+0x3e/0x62
>   mutex_lock+0x20/0x4c
>   regmap_lock_mutex+0x10/0x18
>   regmap_update_bits_base+0x2c/0x66
>   mcp23s08_irq_set_type+0x1ae/0x1d6
>   __irq_set_trigger+0x56/0x172
>   __setup_irq+0x1e6/0x646
>   request_threaded_irq+0xb6/0x160
>   ...
>
> We observed the problem while experimenting with a touchscreen driver whi=
ch
> used MCP23017 IO expander (I2C).
>
> The regmap in the pinctrl-mcp23s08 driver uses a mutex for protection fro=
m
> concurrent accesses, which is the default for regmaps without .fast_io,
> .disable_locking, etc.
>
> mcp23s08_irq_set_type() calls regmap_update_bits_base(), and the latter
> locks the mutex.
>
> However, __setup_irq() locks desc->lock spinlock before calling these
> functions. As a result, the system tries to lock the mutex whole holding
> the spinlock.
>
> It seems, the internal regmap locks are not needed in this driver at all.
> mcp->lock seems to protect the regmap from concurrent accesses already,
> except, probably, in mcp_pinconf_get/set.
>
> mcp23s08_irq_set_type() and mcp23s08_irq_mask/unmask() are called under
> chip_bus_lock(), which calls mcp23s08_irq_bus_lock(). The latter takes
> mcp->lock and enables regmap caching, so that the potentially slow I2C
> accesses are deferred until chip_bus_unlock().
>
> The accesses to the regmap from mcp23s08_probe_one() do not need addition=
al
> locking.
>
> In all remaining places where the regmap is accessed, except
> mcp_pinconf_get/set(), the driver already takes mcp->lock.
>
> This patch adds locking in mcp_pinconf_get/set() and disables internal
> locking in the regmap config. Among other things, it fixes the sleeping
> in atomic context described above.
>
> Fixes: 8f38910ba4f6 ("pinctrl: mcp23s08: switch to regmap caching")
> Cc: stable@vger.kernel.org
> Signed-off-by: Evgenii Shatokhin <e.shatokhin@yadro.com>

Excellent analysis, patch applied!

Yours,
Linus Walleij

