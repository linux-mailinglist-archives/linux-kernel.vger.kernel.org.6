Return-Path: <linux-kernel+bounces-200398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B769C8FAF87
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E731A1C21DE1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35641144D1D;
	Tue,  4 Jun 2024 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JLLNPyxR"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0295D1448D7;
	Tue,  4 Jun 2024 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495461; cv=none; b=d0d0EsICpNLmCWgnN6qglVTN3hUOY7vDKxZo99aSZ9i34ueOpTNvwMaaYqXAuVi2wMJ6nxrUQ7lLrpcnExKnLYoBU5PC11XZHkvQzx/zcQ3kcrbQAH5Z8rFlzz0vFXD4g1Gs4EuB/PeyYX1/rb/AqXC1T6cH1OugOiE+AXCHgsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495461; c=relaxed/simple;
	bh=mT1/rVVdWV+5QoTSApPnuEEIlkiQJf0kw1vPslyrMIY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Zz/x3vPuFJjVPrcYdF2hzxPQamaCIlqveV90kqxGDw0DVvcMN7yIYT+A74WVA+556xtHWJkNX72+8fg/R7Gt5tHU3TQgKcALOd4fhCutGEISfk2TiD1Z8NdJJz5XYdueoSQEoWjfuiacfsgVRz+aYS/Ytugvfnt9hL4lCbJ3C88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JLLNPyxR; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 454A2DmO090283;
	Tue, 4 Jun 2024 05:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717495333;
	bh=lEeeA5XVGydla/KRte/WAZAqdb4muiovvZrIFmRss1s=;
	h=From:Subject:Date:To:CC;
	b=JLLNPyxR1w5+lmhYx9ZbWHXKfrSIa7/v6lEB+XvtUusMK0Yuzknk+sbqSrAVYd1xk
	 OiV92W0Z46cWH1GVjAo5FErQPN+MQkde10gOxWMnZRLyfR6KpkSYXQjzdK2UuyB0+m
	 z2o/Y3KWPkbiUFi/MgZ6nKASyUFW3An8WmnexC1A=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 454A2CJU007010
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 05:02:12 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 05:02:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 05:02:12 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 454A2BRB130365;
	Tue, 4 Jun 2024 05:02:12 -0500
From: Jai Luthra <j-luthra@ti.com>
Subject: [PATCH 0/2] Fixes for McASP and dmaengine_pcm
Date: Tue, 4 Jun 2024 15:31:49 +0530
Message-ID: <20240604-asoc_next-v1-0-e895c88e744d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3mXmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwMT3cTi/OT4vNSKEt1kAzPjtORkQ0uDZDMloPqCotS0zAqwWdGxtbU
 AE2GY9VsAAAA=
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=915; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=mT1/rVVdWV+5QoTSApPnuEEIlkiQJf0kw1vPslyrMIY=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmXuYgB8FlkmaUfeYeISFrnAiKrV3JaFHoPcw3e
 zYjan9orCqJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZl7mIAAKCRBD3pH5JJpx
 RXaTD/9mm61MjSw+c7tSjgOLv58uadvLpqkDpKp5w8Twl1roQ+6Y/taGUyWg27a1LrAa1LYObpk
 rlHA30idq7AIFHTFvj1cBE8GUekfbnzqXYlbjsBqV11/A8qAAwCf/U/AoqHq9TqDb8xSSTHgT3c
 GhTPbvpsxp5VQDKU5jQu23LEstByqjE1IIvkQxodPNl56G+BlOmKyhnewT7fi5xwzgH/fSnxaRH
 Ak2BKvE4mwjNBk0dtKt9q7hnrLdqVmhMy6gQGLZbJYj2p+Yl0Ql2OayzDKF1Ak8346YIJXvfHf7
 rMxS47tzEFll+D2fRHQTbu1ICPJK78jg2quD0rwOPXRFFEfNI+8UuGfxFdfLGvj+GiOV3Auy3Rd
 vS+NwJwJ5NnnV50viG/mjbARnLVlTSljB5yIHP85PcNLIq678IjLL9ad42O8UKkusHIhYLB8veY
 Uasuz0kLgig8uvxk3YtewOiTQlkIXIPp9RlYlNp4PasX8V+hGrLbfUXqYN2TfMKslvxZyL2PRLU
 m2aZBx3FWwLR3n47o7yBcoDIqU1nIHCJBDLDhjpAaKYG0R252XBXiYmvyEuHZAPnUt/R4aSu86i
 IiwHTfJ12nBbkLxagoaHh7TEXHChwLM95Gw/Un88WY+ffEYAVjpBAhNlbJKeAaSj3a7pnBjg08w
 Ja3MzA2SG36zlaw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This series fixes two patches:

1. Fix the dmaengine API usage by calling dmaengine_synchronize() after
   dmaengine_terminate_async() when xrun events occur in application
2. Use the McASP AFIFO property from DT to refine the period size,
   instead of hardcoding minimum to 64 samples

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
Jai Luthra (2):
      ALSA: dmaengine: Synchronize dma channel in prepare()
      ASoC: ti: davinci-mcasp: Set min period size using FIFO config

 include/sound/dmaengine_pcm.h         |  1 +
 sound/core/pcm_dmaengine.c            | 10 ++++++++++
 sound/soc/soc-generic-dmaengine-pcm.c |  8 ++++++++
 sound/soc/ti/davinci-mcasp.c          |  9 +++++++--
 4 files changed, 26 insertions(+), 2 deletions(-)
---
base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
change-id: 20240604-asoc_next-c063fcc190c6

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


