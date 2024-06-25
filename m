Return-Path: <linux-kernel+bounces-228594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79562916206
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2643B25A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AA014A4DA;
	Tue, 25 Jun 2024 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1yCPyd2c"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46751494D5;
	Tue, 25 Jun 2024 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306575; cv=none; b=sfuLmS71UUbdjvLs6UJQwhZ3+ZnlX8HIrDkr07qFVNaioHWOi/pl8A378Pyhsgo/63ulJVazTvxFlMZGksB38tw74EkTGG4ZlmW1FwGX3eX9iYmorAsAfyq17ASA1W9ubbPdMhlzXzmAJy5/7/Ew1sNtK7W9zNv6eQ+ERFHFZ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306575; c=relaxed/simple;
	bh=r6fuS4iXNYY0gxO3bxmrjdmcyomSmCDYU0r8I6w8lSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Di3Al8RU5lGUoTTzUC9GQOZNKuML06s/P0JdiAo/9vDkt6wtMZHNjb8wnm9j3R4gAh+jfPeqE/dvkOheW2q4vv3JD0xNMUTawJzKGqIIxHkLz2MlkFk8d3gtJPL/lcwvblOXXhedUd15kMO8gB4/QyWM9nBK9I3dpXzDieRCntA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1yCPyd2c; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719306573; x=1750842573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r6fuS4iXNYY0gxO3bxmrjdmcyomSmCDYU0r8I6w8lSU=;
  b=1yCPyd2c729omtzIJr5/U3I9gzsLeBWwqAnbbp7eyEaedRZWn8yGMUbX
   xZnYDJb/JpTjlGYpSn/gpLs1OIsHDQjNqF4gcAwuZlHiUh5hWzho95RAF
   5Sc7cWFKJfBXBChumcanlj2evjMtEOXDuElblEVooJfrQaWrUCKiZo6nl
   aK8Q00C4eq3vLBEjVI7iWoVQkT8tIoGr7tr9kTywnlu0bMXFHRUOvrVkQ
   4eminv2JS82oS00842j7WCN8pd1b3+IzIDKH4GsEq6uB3SOmya74OE2vA
   Zq5JxNvAZjVhKw+1SNTIUxb0tV9sBjq7u+aS5wTTfPldiUg9eaSDU9wEL
   g==;
X-CSE-ConnectionGUID: VUslT87US1uPmx+Nea0QOA==
X-CSE-MsgGUID: ptazfcsATBqRk1hUoXo57g==
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="29096475"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2024 02:09:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 25 Jun 2024 02:09:01 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 25 Jun 2024 02:08:55 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <megi@xff.cz>, <javierm@redhat.com>, <neil.armstrong@linaro.org>,
	<quic_jesszhan@quicinc.com>, <maarten.lankhorst@linux.intel.com>,
	<mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <dri-devel@lists.freedesktop.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 0/4] Panel HIMAX support for Microchip's AC40T08A MIPI display
Date: Tue, 25 Jun 2024 14:38:49 +0530
Message-ID: <20240625090853.343176-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series adds panel himax display controller support for the
Microchip's AC40T08A MIPI display.

Manikandan Muralidharan (4):
  dt-bindings: display: himax-hx8394: remove reset-gpio from required
    properties
  drm/panel: himax-hx8394: switch to devm_gpiod_get_optional() for
    reset_gpio
  dt-bindings: display: himax-hx8394: Add Microchip AC40T08A MIPI
    Display panel
  drm/panel: himax-hx8394: Add Support for Microchip AC40T08A MIPI
    Display Panel

 .../bindings/display/panel/himax,hx8394.yaml  |   2 +-
 drivers/gpu/drm/panel/panel-himax-hx8394.c    | 153 +++++++++++++++++-
 2 files changed, 153 insertions(+), 2 deletions(-)

-- 
2.25.1


