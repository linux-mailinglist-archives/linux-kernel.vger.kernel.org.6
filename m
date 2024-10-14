Return-Path: <linux-kernel+bounces-364536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD6E99D5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BF41C2216E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4F1C729E;
	Mon, 14 Oct 2024 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAtbb0Gx"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8317231C8A;
	Mon, 14 Oct 2024 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928350; cv=none; b=tQtvvdURNzoyWbF/lFlfQV//uqWT01Uq3TkT2lq1pQT28mQey5I+EX/Q2TlYeTvfoq9jKUDX3Ikp06DaBUNwN+ccCbHYKcKgILxs42NndbCmIQ0fN5RNwlX4kfb/YTgic8LDoSUfYrimZD9f2eC0AGo99vNJqUGn2qjxqGVYHpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928350; c=relaxed/simple;
	bh=8vUxpQkMhcfgzkP6rklV9Wf2gTQM1AEoXaTpzeOxiHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9a2z7eK/QgQ8sVqx/4F6W51jkJre4rvW0XQVGi/egD6QTGaqbU95OISM55VqUpnSa3R/iqgpFFjHfaKipDXLe+aH5vhJCfrRtmAH86NloGZuTllXQTSy8UNeyRg1QxSjbClyd9hi8mSKX3Oy5qZMQLXr3L/EV+XbGMxEBtw9TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAtbb0Gx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so3931723f8f.2;
        Mon, 14 Oct 2024 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728928347; x=1729533147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ixu8D2HLAaDR+KK2uTRWPmXs/zMROzq2qZqU6zrIdcM=;
        b=WAtbb0Gx/cZ7GZAr+YI4PbtBWgcMSOb6eSIzoUbJqz1PpFcKnZtqvEPND7fGGuKok+
         z2BwAY+iOzgnYAloQxrRFM9Y8+YccmDUQemato+910tD5iVrE3IFtwYoEYeKKRkHVkAa
         5WBTDw49hgm17FtjAGubPCiIO63/eOh+5I3ZIUA9KURhnhhGIhIWfxI4mpUcICKOvTI7
         St1pdM8wc+qShKCqh35+0KjE/GVci50dA88LR6FMjWY8cE+hWVuXg3q6cgEY6MwM3XNL
         lLox1nq57BgnXmYE+6M1SzNjunClydLMCF/9tMPKVzYiwzaTmsBchf6RZs7W/VT1tEyV
         PBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728928347; x=1729533147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ixu8D2HLAaDR+KK2uTRWPmXs/zMROzq2qZqU6zrIdcM=;
        b=a8nVYSMXdHgAJjldgSPVSd9sgssPVkoOqR09Mi6WlMJxQQmxzqOKAvvd0NBF2RzkrD
         7gX/UBkRbdrAYbbGr2AqxgiKcCSSFr5IeG7uXif+FCjudqZZvm8pM+9R1yW2o8TrgKYH
         DCeONs/yapuG5/Lm9rNPCHGNxkUbFWs1KtvpJ9YzVEN2aPIOsXv53NvhPaPklCBlm0bi
         vO6dSsdbtRcEeRBr23flolqCUTDGXYhwiJNKu70QlUFlQ+BLojBlKxsHyNncBEasX6om
         7qrjPmkBvXFBW9HKw8OdzpFGN4BWnrMO8YS98kILRhHkFwxMZWtqsi7jD//OHfj3vtSy
         JOHA==
X-Forwarded-Encrypted: i=1; AJvYcCUSTfQx1QDmiGx0us9grliGJ0AoHc5Jk3nz7AigEuXGZtwrH7V660F4tcBTWAwkkON8xoAsAYpUMgOa@vger.kernel.org, AJvYcCW9B93YvVttuDGQbyIXnn4Pzte8JCD7FGqfO6/kxz1Nr8nsDN/o/Oi1Y2WoAcSIUHRJWjuIkOieLBE4ATKe@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYtfW5kqY8DoBLl3r06xUSmZ+byUGTFICfUrMb7WRAAfBycNC
	tHgeixiN/HOXx56rpR16ZvUOwSFaDyDdir9YkfOYmjP1DFjCCNrBRzeIsklCQtZJR/WT9RZ2TMB
	AJZC3kTCDoOWT3w8pUCf+ihA5OaA=
X-Google-Smtp-Source: AGHT+IHQ4uC66x2exWQtJqcMfm+3DuKjElbNTUY2NreiU68UqRFKvhPazV9idyfCVDmIeWVZP+QCLAdUUM++GZehcl0=
X-Received: by 2002:adf:b359:0:b0:37d:4c40:699 with SMTP id
 ffacd0b85a97d-37d5ff25593mr8841523f8f.5.1728928347035; Mon, 14 Oct 2024
 10:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014113026.78853-1-cenk.uluisik@googlemail.com>
In-Reply-To: <20241014113026.78853-1-cenk.uluisik@googlemail.com>
From: Jimmy Hon <honyuenkwun@gmail.com>
Date: Mon, 14 Oct 2024 12:52:15 -0500
Message-ID: <CALWfF7+b2zeUaB6N7DJVprvajNbvXmAn9wVUyVVt57D1oECwOA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: rockchip: Add rk3588-orangepi-5b
 device tree and refactor
To: Cenk Uluisik <cenk.uluisik@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Chris Morgan <macromorgan@hotmail.com>, Dragan Simic <dsimic@manjaro.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Tim Lunn <tim@feathertop.org>, Andy Yan <andyshrk@163.com>, 
	Jagan Teki <jagan@edgeble.ai>, Michael Riesch <michael.riesch@wolfvision.net>, 
	Jing Luo <jing@jing.rocks>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +&sdhci {
> +       bus-width = <8>;
> +       no-sdio;
> +       no-sd;
> +       non-removable;
> +       max-frequency = <200000000>;
> +       mmc-hs400-1_8v;
> +       mmc-hs400-enhanced-strobe;
> +       status = "disabled";
> +};
This is good. SDHCI is disabled by default, so just the Orange Pi 5B
board can enable it.

>  &sfc {
>         pinctrl-names = "default";
>         pinctrl-0 = <&fspim0_pins>;
> -       status = "okay";
> +       status = "disabled";
This is good. SFC is disabled by default, so just the Orange Pi 5
board can enable it.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
> new file mode 100644
> index 000000000000..55eee855cacc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
> @@ -0,0 +1,27 @@
> +
> +&sfc {
> +       status = "disabled";
> +};
Since this is disabled by default. So this is now redundant and should
be removed.

> +
> +&pcie2x1l2 {
> +       reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
> +       status = "okay";
> +};
Do you want to defer this part for now, and include this with WiFi enablement?

