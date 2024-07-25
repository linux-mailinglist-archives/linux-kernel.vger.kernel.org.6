Return-Path: <linux-kernel+bounces-261862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DA693BD1A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573491C215A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF3D16F830;
	Thu, 25 Jul 2024 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QpqeddnU"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A2171E73
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892488; cv=none; b=lu/04H/fPemiqqU9kRcJGrRPYNBpeRn5G/mT/yEhcGVOg5s+n5+CHEq+Ro9GtQwSgcr8ydPUn9C9uDEEYQmdZVrFISzOcznTbdHCJtoJizmOKN9KI9h2x8xTEIoa7U4c35MCcAI7sRrXqNL2l13rAd0ZRAlj7/QEiQpTudOQr6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892488; c=relaxed/simple;
	bh=TXOBc5RGZ07+uz9VYCDUS3ExxjW0iKxba918D4AYGB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7NkKHPRMyL55qMJew1uQ2W6JNdPrdC5p6AdFy5/cW6Z2axTkXZPsxlANl7UUtWwl5NZQhv8SNRXy8wnOm8JJW1GWGxF86jMdXMWeZIZcFw04AfVK535JOfMtVEjbs/fgvRsrXlSStOqaKVwIvlULtryYRnfSZTmL8uPgvxs6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QpqeddnU; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 450C91BF203;
	Thu, 25 Jul 2024 07:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721892478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/FpnzBli2yfcW7bypqre7oSlgbkhXnfElxFRUwfx8o=;
	b=QpqeddnUcTQuicvzmYoQns2jCjWVzKCSm4VbPJ0Gy/qNcjyDInmpuzMKMhV8vVhJAEzE69
	JvVExLnYdftFTGwE1C5d1nLh3nbd7K5HecqAMZe8IkjRjBEz+R/Ls07Et+mvjTdKGUYqQS
	wmKfSvt5c9UBwQy4Ru36RfcphPt3iiIGJ4xFqwHc8YB5776qfLRyk6yWE/7jOaETS9RvdE
	8IHL81X459c9f7KlARNB7PlwgvnMahfPvrbq5wvyto7cCScTNoQr/S8inOnH1oDsG+hXZQ
	uK0nt5HVGZ7urv2NCuRRvBgBvmC3dkTuI2MdDn/Cy/fXf1P4vst6srApKI/uJQ==
Date: Thu, 25 Jul 2024 09:27:57 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip: LAN966X_OIC should depend on SOC_LAN966 ||
 MFD_LAN966X_PCI
Message-ID: <20240725092757.2d062719@bootlin.com>
In-Reply-To: <578dafcbdf8287e73dd30e96e23814b8c029ea96.1721719060.git.geert+renesas@glider.be>
References: <578dafcbdf8287e73dd30e96e23814b8c029ea96.1721719060.git.geert+renesas@glider.be>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Geert,

On Tue, 23 Jul 2024 09:17:53 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> The Microchip LAN966x outband interrupt controller is only present on
> Microchip LAN966x SoCs.  However, when used as a PCI endpoint, all
> peripherals of the LAN966x SoC can be accessed by the PCI host.  Hence
> add dependencies on SOC_LAN966 and MFD_LAN966X_PCI, to prevent asking
> the user about this driver when configuring a kernel without Microchip
> LAN966x SoC and PCIe support.

I would expect a make olddefconfig silently disable LAN966X_OIC.
This is not the case ?

> 
> Fixes: 3e3a7b35332924c8 ("irqchip: Add support for LAN966x OIC")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The patch defining MFD_LAN966X_PCI has not been accepted yet.
> Hence my initial thought was to add a dependency on PCI instead, but
> that wouldn't make much sense, as the OIC driver cannot be used without
> the MFD driver anyway.  Alternatively, the MFD_LAN966X_PCI dependency
> could be dropped for now, requiring a follow-up patch later.
> 
> "[PATCH v2 18/19] mfd: Add support for LAN966x PCI device"
> https://lore.kernel.org/all/20240527161450.326615-19-herve.codina@bootlin.com/
> ---
>  drivers/irqchip/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index bac1f0cb26e67a2b..b8d5ca3183824c93 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -171,6 +171,7 @@ config IXP4XX_IRQ
>  
>  config LAN966X_OIC
>  	tristate "Microchip LAN966x OIC Support"
> +	depends on SOC_LAN966 || MFD_LAN966X_PCI || COMPILE_TEST
>  	select GENERIC_IRQ_CHIP
>  	select IRQ_DOMAIN
>  	help

SOC_LAN966 is used only for the SOC mode of the LAN966x.
In that case, the LAN966x OIC driver is not used. Indeed, this
driver is used only in LAN966x PCI endpoint mode.

depends on MFD_LAN966X_PCI is indeed correct but, as you mentioned
it, patch defining MFD_LAN966X_PCI has not been accepter yet and
MFD_LAN966X_PCI is probably going to be renamed (the driver is
going to move from drivers/mfd to drivers/misc).


Best regards,
Hervé

