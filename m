Return-Path: <linux-kernel+bounces-386818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE09B483B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA67DB2224A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E86205AA8;
	Tue, 29 Oct 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TPc6VxiE"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5820515B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730201182; cv=none; b=JITMHpXTtCSFhZM4Uxz02EO0utrIS30rT/iBXaWib2Lwbwanb2BzJLPmmeT5oaAdHExfBCwPfEAvibBJ4fezqsZ8Wtd8mKh5+K0Wg3euxYRG0JS2JmTReKyOrRSADjBRBOS1BCtwQY9txGowTOb9JRy3fkyoFcOvbpiJf6rEBh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730201182; c=relaxed/simple;
	bh=TuhtbHWut8WUmRnO9F2af11VQo6JDMWk6jUX5L/0C8Q=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhrlQFKEg/G8+TbpTGroecSfu7snYdduXC8GDwO8xLh1Y6YigZbyXUdMZAPf4nNvsPE9x7ajIriM2o8LuA+ET6PXv67n58NgzJgEVo94K2vJXdLa5Hh0hUjgEXNMT7evdt0aWcWzq1SB3uR+hR+eIugqQZLPXmQJOP7wmpdinuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TPc6VxiE; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ED64C4121F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730201177;
	bh=v61ehPphC3SpuWBobmkEMN1kDRB/yHy45WnKnBTik4Y=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=TPc6VxiETpv+l2wpr/mrGQ/CcLZuJEUSvddDiaVOe4cxUDrVZwfxp+Rwy45vuCS+T
	 2Df4AgshOPi16oSPxXxOjwxXSZ1QfNZrkaIoVrmoRoyKuQ8yzRt50cE7M7c5NQ/soT
	 xzfBknLybnaloXQ/0PiF18USII0UCmsLDrJu/RAVq3MsRyCEHuBPaClA7A/QwLvtHU
	 82ddWTZf3m0lAeDwYUxBupoVlXkK0ZMyJNQGsX6XLmuqA7M6e1oU/EpdJ2lKgDI8zc
	 1BD7Pvxvsdbcas7Pojp8RuLkrNOSheX5ftW8FJRyAdmg31lEHfE2wlEJSsCKV8L7FR
	 Rx/h70PRnu0Dw==
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-28879673bb1so4915357fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730201176; x=1730805976;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v61ehPphC3SpuWBobmkEMN1kDRB/yHy45WnKnBTik4Y=;
        b=L1jy6OI0npYzlql/bQdrbvj5lvzQ4nsN9rB5gqEyOPTMtVuWLL0Ddj/KBzL8g1jnCP
         EpGGNCCVCaGrXtx61RKWbJp72RQbQNvg3EvSyynMXbCgIB6CCjkaGzLb08AW1uFB39cK
         MiHvBs4C5//wIuT8i2Xd31xDl3tV9sZpwrH2GKcMj0gF1R7rs/7DhDZNkrmNMVpT52V8
         0Iie9LeOl0iZuTQI6FNUbcmaogSRN4QzXNAOh7BVU/A0nTJhHmvc4okAKXgcnkyv6Dup
         Gw6fF7AgENoq7frLNuLdOvq3RVG7VpmLoqpR7orheQS1oYIvh5SpNrMVxMD+gBNIlmBZ
         sqSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUT5fr5rFsiSsGuZXhtVSWlkbkcTpvSahRab6+N9XAF+MLliXd1pLEaki0cohjVJWMvhkxEcP58dJtlUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzun2j4O5E8qyQzIrj427pHvfYYMOXf0CgHZwJTdlF1qLaLQN2W
	RiphO2Xo2tYsGdERqEM+kKQxRhkFpzdOsUWGnUEK5FyhwI1PKEeiX5l4GfhbGEv1i4+H0mehOoQ
	spVNHB3BWXPeZ9JG2zuLjiyC/6hUnlJo0bU70MVOhRrr5LvSxGX/uYmdGpQEJTMmN9EB6gNEyu4
	GTHvFPZDKfzMFhEaZunERkqEc9PJLW12qx6ZqXRep/5DCcCsQBjV0tbos+2rxN1ycJww==
X-Received: by 2002:a05:6870:46a7:b0:251:2755:5a33 with SMTP id 586e51a60fabf-29051dd2a1fmr9702103fac.39.1730201176521;
        Tue, 29 Oct 2024 04:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6KUynuQ+DlJ0SAdxk9knLJkp8MoDFJfgMWvvrdfES/yU5CoPOQxKysfhlo/J2oaPVpFrqPL817POZllpwwZI=
X-Received: by 2002:a05:6870:46a7:b0:251:2755:5a33 with SMTP id
 586e51a60fabf-29051dd2a1fmr9702093fac.39.1730201176239; Tue, 29 Oct 2024
 04:26:16 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Oct 2024 04:26:15 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240902111127.15155-2-minda.chen@starfivetech.com>
References: <20240902111127.15155-1-minda.chen@starfivetech.com> <20240902111127.15155-2-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 29 Oct 2024 04:26:15 -0700
Message-ID: <CAJM55Z9sm6TVbjK4GpHN1yc5uub1uLh3++SPPP+h-T=CYhU25w@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] phy: starfive: jh7110-usb: Fix link configuration
 to controller
To: Minda Chen <minda.chen@starfivetech.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	linux-phy@lists.infradead.org
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>, Rob Herring <robh+dt@kernel.org>, 
	Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Minda Chen wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> In order to connect the USB 2.0 PHY to its controller, we also need to
> set "u0_pdrstn_split_sw_usbpipe_plugen" [1]. Some downstream U-Boot
> versions did that, but upstream firmware does not, and the kernel must
> not rely on such behavior anyway. Failing to set this left the USB
> gadget port invisible to connected hosts behind.
>
> Link: https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/sys_syscon.html#sys_syscon__section_b3l_fqs_wsb [1]
> Fixes: 16d3a71c20cf ("phy: starfive: Add JH7110 USB 2.0 PHY driver")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Apologies if this was already applied somewhere, but I don't see message that
it was. In any case this looks good to me, thanks.

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> ---
>  drivers/phy/starfive/phy-jh7110-usb.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/phy/starfive/phy-jh7110-usb.c b/drivers/phy/starfive/phy-jh7110-usb.c
> index 633912f8a05d..dabe59953070 100644
> --- a/drivers/phy/starfive/phy-jh7110-usb.c
> +++ b/drivers/phy/starfive/phy-jh7110-usb.c
> @@ -10,18 +10,24 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/usb/of.h>
>
>  #define USB_125M_CLK_RATE		125000000
>  #define USB_LS_KEEPALIVE_OFF		0x4
>  #define USB_LS_KEEPALIVE_ENABLE		BIT(4)
>
> +#define USB_PDRSTN_SPLIT		BIT(17)
> +#define SYSCON_USB_SPLIT_OFFSET		0x18
> +
>  struct jh7110_usb2_phy {
>  	struct phy *phy;
>  	void __iomem *regs;
> +	struct regmap *sys_syscon;
>  	struct clk *usb_125m_clk;
>  	struct clk *app_125m;
>  	enum phy_mode mode;
> @@ -61,6 +67,10 @@ static int usb2_phy_set_mode(struct phy *_phy,
>  		usb2_set_ls_keepalive(phy, (mode != PHY_MODE_USB_DEVICE));
>  	}
>
> +	/* Connect usb 2.0 phy mode */
> +	regmap_update_bits(phy->sys_syscon, SYSCON_USB_SPLIT_OFFSET,
> +			   USB_PDRSTN_SPLIT, USB_PDRSTN_SPLIT);
> +
>  	return 0;
>  }
>
> @@ -129,6 +139,12 @@ static int jh7110_usb_phy_probe(struct platform_device *pdev)
>  	phy_set_drvdata(phy->phy, phy);
>  	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>
> +	phy->sys_syscon =
> +		syscon_regmap_lookup_by_compatible("starfive,jh7110-sys-syscon");
> +	if (IS_ERR(phy->sys_syscon))
> +		return dev_err_probe(dev, PTR_ERR(phy->sys_syscon),
> +			"Failed to get sys-syscon\n");
> +
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  }
>
> --
> 2.17.1
>

