Return-Path: <linux-kernel+bounces-339173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F0986183
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B8AB2D9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F710187877;
	Wed, 25 Sep 2024 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cb9WP9P3"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96139187FF3
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272317; cv=none; b=GjgkplapAqOAq3ieuqp0s6pFW9GBFG/mEybgMUA18X0eU211wELd9Wi8CF4Uf7dUzaSR70ujLWvmWuaEegLxXvXQ66nHopHlH6q/8DGAlw9m8jDXbUIYbfsoZepDjC9hxr2yfkEr/BvDiPwoC5xRzoYBVGXRRuSyMFvEBqfqfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272317; c=relaxed/simple;
	bh=mWoPMcI7ji8ZME18L6ZMT3RlitxSf5eGF1zuPbBA8hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FxBMqgOqvFOpa4SiCEIgc9Eo6DaMpZvabhbkmxbRpsvSSeBjuElm7BsmyEf8CD9dP3ElXHr0u1J0VmQoXdRsGSt0bilt2/dZcbyR1dlUJIDJ6EqP2kbmyl9I3qeHjr5rVRtDy3tzJWwd9u7j+S+AYZY1brPk4RJB3kOl1oiFlcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cb9WP9P3; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727272316; x=1758808316;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mWoPMcI7ji8ZME18L6ZMT3RlitxSf5eGF1zuPbBA8hQ=;
  b=cb9WP9P3QexbGAVOiqPjMBDjxOU6+ZmlnW1asP0JkjGse7fH4soTAjyZ
   Q0H68OR+cTI+4a7g7A6DoMlpQ/GuasBLjsCD8lV1756j3Ick7rSqJ9TT0
   05wUTvHAwFE6q8r89O1OGTmqlAFr6O7zxZu4zElpAVe3t/8eg9g+Ul4+8
   b+5O67RXKRttoQ9Ee24N5Vm3HvIcl4qFFXxyXpGYHvDJ1p6WW6og3VIVS
   ZNoA7m6XO6aKIPO2w4ILSTB9t7LhV0to2L0YRziwtRa9dwSEmKeDsH4tM
   gZxoqHMxPnimLC58IXzeveeF4pHBqIuw3SS0qhsT1S1pA10dGQ1tGaaUZ
   Q==;
X-CSE-ConnectionGUID: /Z2CJI2IQbCM1FLnYGXUpw==
X-CSE-MsgGUID: NVKkHTY8TyWYrWAdKupnQg==
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="263245828"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2024 06:51:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 25 Sep 2024 06:51:26 -0700
Received: from [10.171.248.56] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 25 Sep 2024 06:51:24 -0700
Message-ID: <1f1f22de-692c-4428-a754-0aa625294bbd@microchip.com>
Date: Wed, 25 Sep 2024 15:51:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] MAINTAINERS: Update maintainer list for MICROCHIP
 ASOC, SSC and MCP16502 drivers
Content-Language: en-US, fr-FR
To: Andrei Simion <andrei.simion@microchip.com>, <claudiu.beznea@tuxon.dev>
CC: <linux-kernel@vger.kernel.org>, <cristian.birsan@microchip.com>, "Mark
 Brown" <broonie@kernel.org>, alsa-devel <alsa-devel@alsa-project.org>
References: <20240925130711.122950-1-andrei.simion@microchip.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20240925130711.122950-1-andrei.simion@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

(adding Mark and alsa-devel to the thread)

On 25/09/2024 at 15:07, Andrei Simion wrote:
> To help Claudiu and offload the work, add myself to the maintainer list for
> those drivers.
> 
> Acked-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks a lot to both of you to continue this work.

Best regards,
   Nicolas

> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
> ---
> v1 -> v2:
> - add acked-by tag
> - adjust commit title
> - update maintainer list for MICROCHIP SSC DRIVER
> ---
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 09d0f09c36cc..12e6777bb6b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15088,6 +15088,7 @@ F:	drivers/spi/spi-at91-usart.c
>   
>   MICROCHIP AUDIO ASOC DRIVERS
>   M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +M:	Andrei Simion <andrei.simion@microchip.com>
>   L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>   S:	Supported
>   F:	Documentation/devicetree/bindings/sound/atmel*
> @@ -15196,6 +15197,7 @@ F:	include/video/atmel_lcdc.h
>   
>   MICROCHIP MCP16502 PMIC DRIVER
>   M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +M:	Andrei Simion <andrei.simion@microchip.com>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Supported
>   F:	Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
> @@ -15327,6 +15329,7 @@ F:	drivers/spi/spi-atmel.*
>   
>   MICROCHIP SSC DRIVER
>   M:	Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +M:	Andrei Simion <andrei.simion@microchip.com>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Supported
>   F:	Documentation/devicetree/bindings/misc/atmel-ssc.txt
> 
> base-commit: 2b7275670032a98cba266bd1b8905f755b3e650f


