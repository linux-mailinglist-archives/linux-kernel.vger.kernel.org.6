Return-Path: <linux-kernel+bounces-249445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A5492EBD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282522858B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F6D16C69B;
	Thu, 11 Jul 2024 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b="5WInBIWD"
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69B416C86B;
	Thu, 11 Jul 2024 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.87.146.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712375; cv=none; b=OL0jE2RjE5kruw8Wj0Ey8NGgjtzBv56zJCudvQga5a87nmVClTGqAfOs4Pgc1Q/TJoR0EOGHJPFHi1I1VuUBYWVu48VdYR/d8eMiZEcJXQ8b6tX98+xAc5Amf/WmvpC+tNQOWB/mf8VsxonTBQcAHyhy8mDA/4baZHDZXFsg/6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712375; c=relaxed/simple;
	bh=BvMMY1pmMmts/9HoUMplH81BSkTvam09q6qLfTIXWFE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Gc4GXPrGGwgUFDi4JbJIaQCoKw1xkk6E20us2h2o/X8JmFGDbpKFO/txU3fgITiKgfNapUqJCvFcgZDzFnBnOKxNZ+/J939TWSEe8SlqAKSYI/WAzNEiZxzxmom91TQ9EOzM2IXWDnRK0ZrmLUSb+YZM6GCRQOH4IFiqpr98/9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru; spf=pass smtp.mailfrom=trvn.ru; dkim=pass (2048-bit key) header.d=trvn.ru header.i=@trvn.ru header.b=5WInBIWD; arc=none smtp.client-ip=194.87.146.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id A49E242518;
	Thu, 11 Jul 2024 20:30:22 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1720711825; bh=BvMMY1pmMmts/9HoUMplH81BSkTvam09q6qLfTIXWFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=5WInBIWDlcQHHL696i4CXMq6ciOsmJ2JptFzhgqfpeSpBtVzmGHdpOOMVPPKQZ56u
	 8gst1S9gGp47x257aQ5vpqrJbST+voWHBwaBgPb8u9KGRrrexzCGq27NNoFmdQ8PCV
	 o44oSHaEHslP9S03qv00i7w2/E36e7+DQDTv/WlTHRh34jbzxM7GnkOPHAi2ZVW9/i
	 8+pZ32VRpxvgZQPj3Ez4Kv7HXaYH4pBFnAqtyahe9K6UYvhB5+QwnBbbN0HNfhPGRq
	 fgnP7blMW4xo5LGfsdMWJXFuS2H7JMiAXl7CvQuDy757LD9pyahZb5LPR0O27gu1CO
	 adccfxzMjf2dg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 11 Jul 2024 20:30:17 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Bryan O'Donoghue
 <bryan.odonoghue@linaro.org>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform: arm64: EC_ACER_ASPIRE1 should depend on
 ARCH_QCOM
In-Reply-To: <f5f38709c01d369ed9e375ceb2a9a12986457a1a.1720707932.git.geert+renesas@glider.be>
References: <80e17dffa8f4c1d3fdedd4d82df3a722aa4044ff.1720707932.git.geert+renesas@glider.be>
 <f5f38709c01d369ed9e375ceb2a9a12986457a1a.1720707932.git.geert+renesas@glider.be>
Message-ID: <315e6f5fa10cc779ca399f6aec203c32@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Geert Uytterhoeven писал(а) 11.07.2024 19:30:
> The Acer Aspire 1 Embedded Controller is only present on the Qualcomm
> Snapdragon-based Acer Aspire 1 laptop.  Hence add a dependency on
> ARCH_QCOM, to prevent asking the user about this driver when configuring
> a kernel without Qualcomm SoC support.
> 

Oh yeah, you're right. Thanks for fixing this!

Acked-by: Nikita Travkin <nikita@trvn.ru>

We should probably do the same for the C630 driver as well...

> Fixes: 2b3efb7c515111ea ("platform: arm64: Add Acer Aspire 1 embedded controller driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/platform/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/arm64/Kconfig b/drivers/platform/arm64/Kconfig
> index 8c103b3150d1d0a6..058a4baa216a83b8 100644
> --- a/drivers/platform/arm64/Kconfig
> +++ b/drivers/platform/arm64/Kconfig
> @@ -18,6 +18,7 @@ if ARM64_PLATFORM_DEVICES
>  
>  config EC_ACER_ASPIRE1
>  	tristate "Acer Aspire 1 Embedded Controller driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on I2C
>  	depends on DRM
>  	depends on POWER_SUPPLY

