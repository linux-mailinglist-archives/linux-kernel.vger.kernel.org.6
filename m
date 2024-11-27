Return-Path: <linux-kernel+bounces-423366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC969DA65C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B63116390A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D821E4106;
	Wed, 27 Nov 2024 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="J02qb997"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD51E378C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705255; cv=none; b=Fov2dyHmB/QUlM6EkCEHlKKbD2KDLOSJcoKU9e58efCXRNkHZua3m50Ur2HfqHULY1EuN8K0kzP/3fZ83eNCJOHic055k42CqOHoQK15rlUaR5MLBx3jGzmBzYMX1FrANF+xDLdZOduzhkFU5U7Zz1tb2ys9AfN6NJb21esftOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705255; c=relaxed/simple;
	bh=2K2CmkzGm31M8XLyGv7/pOA/7R0aXkI1pvoJGGT/4/g=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8wDH0f2SN+wzwb6YKBxld1oRCPvAxc/iuT/DA/EmHpu41iENHi3B5Z0sPWgYrBJ4FfKJBH3du/o7J+uMEL7gU+G2MHMlLItubNhjUdfjvE2/kTCS5rSsquIzbfrpfbHkuZY2zu+iW93q2NGfqJGcPQm9a0Rsok2uOQLmyF0Zto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=J02qb997; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 69BEA3F84F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1732705250;
	bh=mosoAglVY1ZAnOADGv13gAKCAWy+sADEeedgXWjhMxc=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=J02qb997v9EGqDoniySy98e6DkuMm4oa2mFVU0SNCFaLFmtrGKXrL2RlPTnqIhsze
	 b4HraWCH9b7FoKBY7rDgPxh8w9GWCM7FckTDzOQ+djuSRso7kEt2ytSddSwUy+HBAU
	 6cpJEP3osFZHvTk0eSPqTrUpcVQL2xFKURAzjytoZXQk4km/Y9Kcot/p2Gzkd8UbIo
	 wTYFEk6AKAazuAnEgOlDN3nXFxGQSoqZQQ7nfsu9/2KLOZDYcrnDGTfDulsh7T9G1F
	 qNiLUpYUalnhcH5Xa8F9Qto7kNA0hK29Ue8mDij5EI+QC2EDaI3Goqzr3nW+yV2Hkd
	 3bNjhjUQVBSHg==
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2967f717d96so4176432fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705249; x=1733310049;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mosoAglVY1ZAnOADGv13gAKCAWy+sADEeedgXWjhMxc=;
        b=g//X2mQAgI0iDdCM8PV2pCCpxnEnPC+iv/Rg0piA/spXjlHRQPn3nL6aODQdgs+cxk
         Db6LPQonLiNpuUZbL+KVCGEmQgz+zgqzhpVXzkVRD/4a3tHK8gSN4LLdf4yMlWNLwGk+
         dDW8xn+x9LagXr5T0dYx0e5t2wn+IMTZeSraJFwx5aUpXWN+7Psr9lkmcCcgc8cGgAzj
         wEt14begGNBircVTkdQlAOvLTJ/0WtTkPKsVBdOzwsSNMCXuEjGyq1Jb5x9zPTRtYAHH
         mQjm+Vw/2+pksYtZdff+PcXWS/xTCE01cOfVnGNO/NXjlGO3c5+7KCl9LrtebI4BVeXn
         bUJg==
X-Forwarded-Encrypted: i=1; AJvYcCWtvV3lRBYDSkN1/NBjiyBazqfC4csdDN4T4SRCGTn9tE8SCDU3xPGWGux+L0W57MDGs3/fVA8wJ8qTJSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzytsMjRECGmLOIC1PHCIlkSXJtq5BBSn1Z051C3sJFOuqccQ5T
	63l3qL4FbJ4OfVuD1eHQ1HiHNvT/hTdbNA5NO0cRKxDmM4vMmxr8ymm6xZAPtIhd5Lqgj+LadSD
	jdWJ9Umb04tVPXn/DOvAa+z2NkOFld4JUW8+gHMqzjZ7YOhb8zMwVkX9rOPEDqW818oRomXGhuE
	maje9m2Hgp9t7N7ywfCLL381JXm74Mg6ml7qwd3eOiv/6QxTXjrBcV
X-Gm-Gg: ASbGnctKHEoQZXOlzxVtzHe0e00bjLLL2taCWlMab8VIlV1fXiRzoW8yABADLxdodBk
	woXCEPtE9X/fXjwV0it4KMvHoDTTd9VOTQeKroLPHLFuvD5nBQ9XlIc3XCKdS
X-Received: by 2002:a05:6870:3308:b0:296:dd1d:ce73 with SMTP id 586e51a60fabf-29dc3a8f3e4mr2061148fac.0.1732705249257;
        Wed, 27 Nov 2024 03:00:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0o2pIMw1ikbScyW4yH5U5LfEBQrUJgeVFSfiFp9KhIwhipamnH7e5phDxfaZSX86lSGZprFcwCS4lHwkMaRM=
X-Received: by 2002:a05:6870:3308:b0:296:dd1d:ce73 with SMTP id
 586e51a60fabf-29dc3a8f3e4mr2061084fac.0.1732705248834; Wed, 27 Nov 2024
 03:00:48 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Nov 2024 03:00:48 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20241126075740.17419-1-e@freeshell.de>
References: <20241126075740.17419-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 27 Nov 2024 03:00:48 -0800
Message-ID: <CAJM55Z9wWCaS+FxZ=Gg_RfXXafNEJZC1zHZoPWQ2Y9QYDf9OyA@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] riscv: dts: starfive: jh7110-milkv-mars: enable
 usb0 host function
To: E Shattow <e@freeshell.de>, Jisheng Zhang <jszhang@kernel.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

E Shattow wrote:
> Enable host mode JH7110 on-chip USB for Milk-V Mars by setting host mode
> and connect vbus pinctrl.
>
> This functionality depends on setting the USB over-current register to
> disable at bootloader phase, for example U-Boot:
> https://patchwork.ozlabs.org/project/uboot/patch/20241012031328.4268-6-minda.chen@starfivetech.com/

Hi E,

Ideally the JH7110 pinctrl driver would be updated, so Linux can do this itself
and doesn't need to rely on u-boot doing it. I already asked for this here:

https://lore.kernel.org/all/CAJM55Z-+Cxdebcn4MLXfQdOVhx4c2SQ+zMH8cjn-Yq35xO8g0A@mail.gmail.com/

>
> If the over-current register is not prepared for us then the result is no
> change in functional outcome with this patch applied; there is an error
> visible to the user and this additional usb configuration fails (same as
> it is now). On Milk-V Mars with four USB-A ports this applies to one of the
> ports and the remaining three VL805-connected ports via PCIe are not changed.

Thanks for the patches. I don't quite understand when you write "no change in
functional outcome with this patch applied". The USB-C port is already
configured as a peripheral, and I just tried setting up an ethernet gadget on
my VF2 running 6.12 and that works quite well. Does it not work on the Milk-V
Mars board? If it does then these patches would break that functionality.

Here is the script I used for that:
https://paste.c-net.org/BravoLonely

At the very least you'll need to explain in the commit message itself why
changing the USB-C port from peripheral mode to host mode is OK. But ideally
maybe you could make it work in OTG mode, so userspace can choose how they want
to use the port. The same goes for the PINE64 board too.

/Emil

>
> Changes since v4:
>  - Rebase on latest master
>
> Changes since v3:
>  - Rebase on linux-next/master
>  - use tabs for code indent
>
> Changes since v2:
>  - Rebase on 6.12
>
> E Shattow (1):
>   riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function
>
>  .../boot/dts/starfive/jh7110-milkv-mars.dts    | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> --
> 2.45.2
>

