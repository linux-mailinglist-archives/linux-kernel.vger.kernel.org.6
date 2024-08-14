Return-Path: <linux-kernel+bounces-286311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED63E951974
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46F11F24555
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD771AE87D;
	Wed, 14 Aug 2024 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jBHUJNjk"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A414E1AE04C;
	Wed, 14 Aug 2024 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632848; cv=none; b=j9/MyUCVYfiyM0oyTMoMMKSvPEhcd7AFgd0w0rdNA1deVbPkBXrjVR55FFEFlHt3nFrTEP1gfleEYgKNJeqen9XwTZ23l+qOVUjMsKTofwaVfp83BXyccjr0eGxOpf4Y3sMU4uRxrLUdy8RyIn8TdbXfH/celKBOeYxcyTxc374=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632848; c=relaxed/simple;
	bh=wvyHmjI+aAqhTfrRSAqnJLQFzafV4/TL9UG+yqpNN24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvtRHnBJH1OKhC2D5+U/SYcY47D/YoVvPUpb0KJai8YRACrMCOMVPDyxYpptLNRKNsc0jpr9GgAqk+56+nV+E7ieAoDJd4kgTfCLcu/3fjm9z0S9yW9it0W8CnNZ0oX3udXqlJ64fZXw6VxJAXmKsJBXmgNATuStTeaxT0V4j7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jBHUJNjk; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723632846; x=1755168846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wvyHmjI+aAqhTfrRSAqnJLQFzafV4/TL9UG+yqpNN24=;
  b=jBHUJNjkU7VV9d5WtTL5svbc1hkifxH1szEuUs2cuc+jIMfQcZ79cPJp
   cvPgPLZZCFGxA1swn3wWmMjx8HyH5j/himG7ON381fgMnRFnGwv5xaSZP
   /dlA51aQshVqeVIBO/D7OXlyCsL1cmupiZs0Grt5MfNXwbSXoiCIPxprS
   lFfLrFg/R15eG+DEPzYiuVgEa+ndkZGGwBr01p3u0Z2wdzcnAEYmUc0aW
   56HHaHn5cNTsQdllO9nLkjSlcKPciIOaUAwv3/TbjuoOowDyTbGJGbAee
   egq159hPMx+aIaC4flXuQUTiVj+QINWt5NW6JaBUmUcBAlzmixB895p7w
   Q==;
X-CSE-ConnectionGUID: 87Nj+HQzThCqvIYPn78NVA==
X-CSE-MsgGUID: YzRbsmiLSjaxuPPPrW0rsg==
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; 
   d="scan'208";a="261393484"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 03:54:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Aug 2024 03:53:48 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 14 Aug 2024 03:53:39 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>,
	<rfoss@kernel.org>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
	<jernej.skrabec@gmail.com>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux@armlinux.org.uk>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <arnd@arndb.de>, <geert+renesas@glider.be>,
	<mpe@ellerman.id.au>, <rdunlap@infradead.org>, <dharma.b@microchip.com>,
	<dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v3 4/4] ARM: configs: at91: Enable Microchip's MIPI DSI Host Controller support
Date: Wed, 14 Aug 2024 16:22:56 +0530
Message-ID: <20240814105256.177319-5-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240814105256.177319-1-manikandan.m@microchip.com>
References: <20240814105256.177319-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Enable the Microchip's DSI controller wrapper driver that uses
the Synopsys DesignWare MIPI DSI host controller bridge.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 arch/arm/configs/at91_dt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 6eabe2313c9a..beb29c4832ce 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -144,6 +144,7 @@ CONFIG_VIDEO_OV7740=m
 CONFIG_DRM=y
 CONFIG_DRM_ATMEL_HLCDC=y
 CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER=y
+CONFIG_DRM_MICROCHIP_DW_MIPI_DSI=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_FB_ATMEL=y
-- 
2.25.1


