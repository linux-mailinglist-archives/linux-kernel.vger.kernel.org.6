Return-Path: <linux-kernel+bounces-554834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CCFA5A10A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62ECA3ACFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC975233707;
	Mon, 10 Mar 2025 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iB0IHfs1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bh/F4PMr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34452D023;
	Mon, 10 Mar 2025 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741629404; cv=none; b=iF/FCeBUVThMKp/PEO+KV6jF+WXyIBP+CoL4ILedi3rcP3SObGLmjWEpjtNT2HyQShqeUU19w/wWMDBEYNui4gkRmsa0vejdPE2y2BnvN6Kd47QB2Kvtks8ARKAlylONP6u19u+xNeFZEKjhCqrLtTUxnBDCypME9J6lwyVdNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741629404; c=relaxed/simple;
	bh=erkuifRMYQK4tztGPHvImgvFQm1pB1g92AINpwj2/vs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ENneCLmxt5QlaAvMhoOR6ul13Jzc1uAVfaYYddU3tbGfMbebMv5DlPlwhz8YVm0jm8EsmCllveP5bJOou8pm5R7XwA3mvlGstxRy53JQXlUUUe4RGQZikioxirOGhGAt7dh1UdxRGONq7E211DaCD6RjrvuAanZFxOapHplyv6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iB0IHfs1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bh/F4PMr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741629401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I/jbGKRUts84NApaIU4ODSIOqYgEZ7ke4E1YEaVdoBo=;
	b=iB0IHfs12VxJhCVnUQPcHdSj6A35Caff7fnpnJc2rZHzEHS+J+VZOVZg0Y7Oq0J2yzI0ug
	UjbptTofrkQ3jTEvaBQ4pef3OI4GTh/EPGvnIZ+Cl7km1q2RL9WilUyRof7ANHeY/yOw4Q
	g+hH+vIfC5QYGHwrs1Yqh4wMHGcZ3SYARh3IDh3/kSW2A+rIRN5R4cslQDlLjcwzTBLRHP
	crEFNblsAF4eHXZnEilusHyv0psL8mReZhecpKSacf5LgGfGrNSHbt+0/51fMZfTWpfxgg
	QGGT50z6R6cwIRqss5f332b8PyKRlOLDn4ueRV58yWs9ZgDqJRg+Z2kGQk3C2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741629401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I/jbGKRUts84NApaIU4ODSIOqYgEZ7ke4E1YEaVdoBo=;
	b=bh/F4PMrokCyw/FNdKUi8/VPBZ3V3SiUaJ3FDva1iG/o9JezcsMxR/uar4iwib/R0af1Cl
	DwXqIg6jjxlSV9Dg==
To: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: Re: [PATCH v4 0/4] Add GPIO interrupt support for Amlogic A4 and A5
 SoCs
In-Reply-To: <20250307-irqchip-gpio-a4-a5-v4-0-d03a9424151b@amlogic.com>
References: <20250307-irqchip-gpio-a4-a5-v4-0-d03a9424151b@amlogic.com>
Date: Mon, 10 Mar 2025 18:56:40 +0100
Message-ID: <87h64022hz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 07 2025 at 16:49, Xianwei Zhao via wrote:
> Xianwei Zhao (4):
>       dt-bindings: interrupt-controller: Add support for Amlogic A4 and A5 SoCs
>       irqchip: Add support for Amlogic A4 and A5 SoCs
>       arm64: dts: Add gpio_intc node for Amlogic A4 SoCs
>       arm64: dts: Add gpio_intc node for Amlogic A5 SoCs
>
>  .../amlogic,meson-gpio-intc.yaml                   | 19 ++++++++-
>  arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        | 19 +++++++++
>  arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        | 12 ++++++
>  drivers/irqchip/irq-meson-gpio.c                   | 45 +++++++++++++++++-----

I can't take that through the irqchip tree as the amlogic dtsi files are
new and in Neil's for-next branch.

Neil, feel free to pick the lot up, I don't have conflicting changes for
that driver sitting in my tree. I'll reply to the irqchip patch seperately.

Thanks,

        tglx

