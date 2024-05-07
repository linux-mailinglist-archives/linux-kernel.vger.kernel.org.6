Return-Path: <linux-kernel+bounces-171073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEB38BDF7D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F841C2124E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4779C14EC53;
	Tue,  7 May 2024 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ronazVYD"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069D214E2DA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076820; cv=none; b=DS3BEEQmgWk/MPW5rPbeVV+0QXjisHwE/PBS78wth2NFvsjHRjnRIxmzHuPGk6FE+iEMGUIT9YnQ42bx4L+viAi8Y7u71bVz3MTTsOqdorJi4wdmwfJJ2ZXGamLdNkYZHA4xevDoCbEqrCKlBEAiDmtEz1cclbG067XwLaJuQWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076820; c=relaxed/simple;
	bh=m3tCofB4NMIGnHABhiBunpQUZgNSb7hU8zxpgMZ6Rz8=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGrKADOYoVqtF3PjWgpvfZunBH0Y858FxgbDtGZPyNXPl6SZijFbyitEcP2Fq7uhQmM2xfAGLH4khwJLhul4dLwQCf2zQImHMOQWaACkaoeF5VMVgJ+wON34Y0VeXmW0ggExiJNzrJE9/GGtbBCZzjurTFcgjC/8J9IljG+Re0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ronazVYD; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D7B4B3FB60
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715076816;
	bh=397X4zZ5qk6cmfxvJ66g5Oe/KXHQi7SbJr6mL/vXFTk=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=ronazVYDfRESfDFXThriTvfHZoKRxPX56aJndWDCsD1z5uV5mxyFZHJeDCrhmXkS0
	 WkLuCqU2a1yFJXvV5NNiq5Me4ofaWwLtxladK+rwGJEOZJvmgfupqzyEJStrEJ0S/9
	 VZIWjIwaqwDR4SRDflhUfrEidRSS/+OuhU8iLkYnaYGFzNXhR+LRiESis0a2BWw0g6
	 bb3dfK87xEW3tkh5kV5DYLfCfYUOIsTZdyaKZVqIZjVPhwXuwLyqWPfz//ZmV0nMEq
	 jiFloOdblr8AWRwSXB6yjBV3utsh5QpU10gaYsmaqqH+M6fSOTY5Amc7GQHaVNY246
	 GCgiSUWEoKaQg==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43d175821fdso38554571cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 03:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715076816; x=1715681616;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=397X4zZ5qk6cmfxvJ66g5Oe/KXHQi7SbJr6mL/vXFTk=;
        b=WNxLAa29nnGXWwNJ0hXtuqnQ5msjOLq5+UAvime+yyvT0hIGbiEdIZFZ8FyOCYkkEO
         DIX7pya3jEzrxlybtLY0+Zzn6CgCI9f7UC565+Lxx4Pe/3PXsS34BqVvS+wH+h0aQ3un
         hAfI6cFe5jZzLF+PrmmpkAx71XKdcf4WIT0jAELXHbgOlY0SXQ55efD20P4PW2Jdi34l
         3d1nsG6bjTqNaAcx/3ZIek7IdZZQjcs67dQZ1/q8fnezE1YJv5QHetEI3x6h8Ob/C2eX
         uLCc0vtW5owHU+7Y9Pj9Eg5/4f7Fq9clhtLmIGzFnyzw5SoF3leXbjKfvfDbPHs7uzeu
         aG3A==
X-Forwarded-Encrypted: i=1; AJvYcCXig8Pf+oVHfuAryIYM7TQxgW10fqpnZPmGtXMA3MkUr6mUBCrT+48AQLkkKQXIstJuSl8yw+ps4YOXVehy3KBkK7TcdwI96N2zRe8L
X-Gm-Message-State: AOJu0YyAlKhzDzlrWK9HmdpPIeLW/h65KfftwmsxtoxzFOiufAO0AP0h
	YjiqFXwb9pvGOtCfEgk/1+cFQAlkHj4uf4494CUhAwmW1aVG6bBgLt68OyG2zdObB3hQDgxwtVc
	zvzXPA4M9II7HE93dcTHDJPdH1dmDggW8syxa/ekb07kvKjVRrFsSade2gAHlLM42Lq26HaYthy
	r+v1R/iv69+VBLRyR1aIln4PDxSiAawrwfgTaTUYLobi1razoCuwGp
X-Received: by 2002:a05:622a:4e0b:b0:43a:712a:bb97 with SMTP id dh11-20020a05622a4e0b00b0043a712abb97mr15579367qtb.7.1715076816028;
        Tue, 07 May 2024 03:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjgVEjWFG0Er1wzm6XME0OZo9sKv/t6H0/VJqg3xbQh7tYq4BfD/1KVLjHaQMTeCkQMWpcnkGoRTUTZ7VYW1c=
X-Received: by 2002:a05:622a:4e0b:b0:43a:712a:bb97 with SMTP id
 dh11-20020a05622a4e0b00b0043a712abb97mr15579347qtb.7.1715076815802; Tue, 07
 May 2024 03:13:35 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 May 2024 03:13:35 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240507065319.274976-3-xingyu.wu@starfivetech.com>
References: <20240507065319.274976-1-xingyu.wu@starfivetech.com> <20240507065319.274976-3-xingyu.wu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 7 May 2024 03:13:35 -0700
Message-ID: <CAJM55Z-p9OLYCWHzhQ9HJ3vEt+u-qx0kxcWmGnO8FoarxJQiQQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] riscv: dts: starfive: visionfive-2: Fix lower rate
 of CPUfreq by setting PLL0 rate to 1.5GHz
To: Xingyu Wu <xingyu.wu@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Hal Feng <hal.feng@starfivetech.com>, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xingyu Wu wrote:
> CPUfreq supports 4 cpu frequency loads on 375/500/750/1500MHz.
> But now PLL0 rate is 1GHz and the cpu frequency loads become
> 333/500/500/1000MHz in fact.
>
> The PLL0 rate should be default set to 1.5GHz and set the
> cpu_core rate to 500MHz in safe.
>
> Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 SoC")
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>

This should really be based on Conor's riscv-dt-for-next branch, eg. the change
should be to the new jh7110-common.dtsi instead since the Milk-V Mars board
would most likely also benefit from this change.

In any case:
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  .../boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi     | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 45b58b6f3df8..28981b267de4 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -390,6 +390,12 @@ spi_dev0: spi@0 {
>  	};
>  };
>
> +&syscrg {
> +	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_CORE>,
> +			  <&pllclk JH7110_PLLCLK_PLL0_OUT>;
> +	assigned-clock-rates = <500000000>, <1500000000>;
> +};
> +
>  &sysgpio {
>  	i2c0_pins: i2c0-0 {
>  		i2c-pins {
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

