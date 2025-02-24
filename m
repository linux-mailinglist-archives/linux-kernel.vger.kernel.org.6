Return-Path: <linux-kernel+bounces-528320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF465A41639
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B691516CED6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E81240610;
	Mon, 24 Feb 2025 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kT03KoYd"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD80C4414;
	Mon, 24 Feb 2025 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740382029; cv=none; b=MFKlwJbRF3b17stmjRN7/QBnYHL1P6syb+bT/+kr10Mpvsimff4eu9usbI3bU6HykKdQvchxgujk4vPYzhMhA8FF+X8kFH5HsGLQXpKst2SIpQBHgzw/pjpV96yqye8l8svNyJPrnLsFs7AMeOZQAf492hz3DFeWbQdJ+gzWy0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740382029; c=relaxed/simple;
	bh=fj9ATARjbXR29ISCacUsG5uVWZEBOqKd2CTMA8IFPLM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwFB5gaB17LM5fzfLAsjQt2lrSQgTHHBb1Id+dnCjKpORmWnxRHvIIJVSBeUC95bcyolINQIzxkE5YYSvfqnht9lkEqHy8w7lUCwMu6OZT9X6VBdCnto6m5BF0Xr1mmvmQo0SVwQPOwprmdGS1zbBzGDP8aqMH1gjLAHKMLi4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kT03KoYd; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740382028; x=1771918028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fj9ATARjbXR29ISCacUsG5uVWZEBOqKd2CTMA8IFPLM=;
  b=kT03KoYdsFKAEPq0DQLXgh1wI8h0Nq4cJ4ttHeqK0lTrGXbSzt0li2z7
   K2ylPZ/I4jvU5w9wV1g6mvGFbgx4UCHwBPawi5Rphw0HOxdKwVG7/vEp8
   cJh888/G9HQHNKGltgIMZLMMJlJp9u/4J0pSja1PsQC6bqvexNLTV8KY0
   b3sX+O0kkXVEpw1aLDNMXqw5Vv7cVdIFAky0sJbdyFzZKsDGb8Oy2DzBm
   vFp8jfs4FJcqOMoBQhGvIoX+2/wyiabtXFU5KirgJ7f4JnLwEA/masOVz
   FAsRnpiEg3KaSp7LIjn9xwVJK95OSNWLkGLAaNVbAhvIezRYtz4QqFFSK
   w==;
X-CSE-ConnectionGUID: m2OKtz9RQ8GGzkYxdWztiQ==
X-CSE-MsgGUID: 4T49poF1RKCLNxbUY6QxcQ==
X-IronPort-AV: E=Sophos;i="6.13,309,1732604400"; 
   d="scan'208";a="38035487"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Feb 2025 00:27:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 24 Feb 2025 00:26:52 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 24 Feb 2025 00:26:50 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <thorsten.blum@linux.dev>
CC: <alexandre.belloni@bootlin.com>, <andrei.simion@microchip.com>,
	<broonie@kernel.org>, <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <nicolas.ferre@microchip.com>,
	<perex@perex.cz>, <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: atmel: atmel-classd: Use str_enabled_disabled() helper
Date: Mon, 24 Feb 2025 09:26:15 +0200
Message-ID: <20250224072614.6811-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250222225925.539840-2-thorsten.blum@linux.dev>
References: <20250222225925.539840-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hi,

On 23.02.2025 00:59, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_enabled_disabled() helper
> function.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Andrei Simion <andrei.simion@microchip.com>

> ---
>  sound/soc/atmel/atmel-classd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
> index ba314b279919..1f8c60d2de82 100644
> --- a/sound/soc/atmel/atmel-classd.c
> +++ b/sound/soc/atmel/atmel-classd.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/string_choices.h>
>  #include <sound/core.h>
>  #include <sound/dmaengine_pcm.h>
>  #include <sound/pcm_params.h>
> @@ -275,7 +276,7 @@ static int atmel_classd_component_probe(struct snd_soc_component *component)
>  	dev_info(component->dev,
>  		"PWM modulation type is %s, non-overlapping is %s\n",
>  		pwm_type[pdata->pwm_type],
> -		pdata->non_overlap_enable?"enabled":"disabled");
> +		str_enabled_disabled(pdata->non_overlap_enable));
>
>  	return 0;
>  }

Best Regards,
Andrei Simion

