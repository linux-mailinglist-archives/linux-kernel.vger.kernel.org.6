Return-Path: <linux-kernel+bounces-339107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154DD986064
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451161C2560D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DB41891A9;
	Wed, 25 Sep 2024 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OjvZvD2k"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1DF155306
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268761; cv=none; b=Cyj8dzk69iDDPl/fRvKTCFo0yKWqBQKzPL0626PZ47oCS219FT6cp5Yv3PsyTzR+m2x8DCnmy+UiEbODyksKawkPdpMJL10gKVsA/7rMBGGV2o5FORssYzYqODdb/GyCBNE/5/UyQ3lwiw6XKxZ+0Z4lARAbSdYdan7diZnZHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268761; c=relaxed/simple;
	bh=Mwnn00oukSCjlcABhWLHn9w06MN/xBK5wRyVA6+HC0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xbg8HZV9NPRaUEpaAIkfqePEkzlMNBjhGLzH0dL6KI9y5OPoEpIWwFNPdjLXjSHQ9Mv0qsxsQHX6lhHcTDNPms7haRASJoPC+TMUgm6XYVNZh4u5LPLrJG1GZuew9tTIQoMIHJn50e58Qr0jN+6S8rMW3oUMPqLVgarhdegmApA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OjvZvD2k; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727268758; x=1758804758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mwnn00oukSCjlcABhWLHn9w06MN/xBK5wRyVA6+HC0I=;
  b=OjvZvD2kra1rQtEyim18OfeV80yArogOrBVqAhaN8dMpinFo+4FIkQeq
   /4drk1on+42YOJM0GGNYYwRaP3B/mJv4+VRIuzPqIvZaowa8Sdjc59bP1
   cOJ+5S0Jupz/cm954x8430zP4oL6HETWH5LRBTzrKxIP6hi1i2+o6ca7A
   g8nXZpY1yxkmQXhnvi8g850sip3W2JsZNm4M3U027K7e7hN8UWJqXlIa5
   s8T4bNDg0mi1CpQBuoFPox6IC5DXtDOS4k4sbWQYnPBcCuwVpQ1IlgACS
   ehAVKXDKgxfGH+8ASYapxAehwy6xURh6YbfMwRATa5LBTT8e6pma/Zrr3
   Q==;
X-CSE-ConnectionGUID: EIdq/jyzQiynu0dqFC31iw==
X-CSE-MsgGUID: 9c+E8kA5QGyew97dJZUOcQ==
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="32092405"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2024 05:52:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 25 Sep 2024 05:52:07 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 25 Sep 2024 05:52:06 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>
CC: <andrei.simion@microchip.com>, <cristian.birsan@microchip.com>,
	<linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer list for MICROCHIP ASOC and MCP16502 drivers
Date: Wed, 25 Sep 2024 15:51:04 +0300
Message-ID: <20240925125103.122146-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <12fed7ff-6ca5-409a-8215-e3eb955eaa1d@tuxon.dev>
References: <12fed7ff-6ca5-409a-8215-e3eb955eaa1d@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

On 25.09.2024 15:26, claudiu beznea wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
> Hi, Andrei,
>
> On 25.09.2024 15:02, Andrei Simion wrote:
>> To help Claudiu and offload the work, add myself to the maintainer list for
>> those drivers.
>>
>> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
>> ---
>>  MAINTAINERS | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 09d0f09c36cc..7f2f87a2483a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15088,6 +15088,7 @@ F:    drivers/spi/spi-at91-usart.c
>>
>>  MICROCHIP AUDIO ASOC DRIVERS
>>  M:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> +M:   Andrei Simion <andrei.simion@microchip.com>
>
> I think you may also want to update the MICROCHIP SSC DRIVER section.
>

Yes, indeed. I will sent V2.

Thank you and best regards,
Andrei

> Other than this:
> Acked-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>
>>  L:   alsa-devel@alsa-project.org (moderated for non-subscribers)
>>  S:   Supported
>>  F:   Documentation/devicetree/bindings/sound/atmel*
>> @@ -15196,6 +15197,7 @@ F:    include/video/atmel_lcdc.h
>>
>>  MICROCHIP MCP16502 PMIC DRIVER
>>  M:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
>> +M:   Andrei Simion <andrei.simion@microchip.com>
>>  L:   linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:   Supported
>>  F:   Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
>>
>> base-commit: 2b7275670032a98cba266bd1b8905f755b3e650f

