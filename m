Return-Path: <linux-kernel+bounces-209866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 667A6903C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187A51F25D98
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1A17C7AC;
	Tue, 11 Jun 2024 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yoblyMP9"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A9A17C207;
	Tue, 11 Jun 2024 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109421; cv=none; b=czENhQJNXivd8ad/2P7VqOEIuO/NBQWltIvpU3v6Ypqe8/y1Al26COLqk0pamEXJWkNa1ma6SDGkcHyQUqPzn8RYt4qabcKpCK6pwdDzmgZXuqFCzq/2ORLSLaelG6VkeenI0jj0tDkzWNYhksCURiLL63DeGx7OYRun01H/Cv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109421; c=relaxed/simple;
	bh=/JEDUExWQNwoOi5zUT9iDtsEq0qd3E0WRFsxqoJeC4U=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=QiiXL69PTHUlOXWWaU2MJA0ksHMW20weyUK/ZF9q+GgwxtLrdM6E6bf1lorAVIQt+1MT2HzDw9XdrwRZ5GharKXEcSqqdS3N4Xb5+rZY0Wq5BE+fdhXjUgSSv900RTZNW8dyvO+sCl8Wue1x5wa4hG2aTJJOWq7EJbKEAYKUJLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yoblyMP9; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45BCaXmU005559;
	Tue, 11 Jun 2024 07:36:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718109393;
	bh=u9cSUoRXmcbaPFPP8IaI0DTi4v+PCdOKv9htFxq5zTQ=;
	h=From:Subject:Date:To:CC;
	b=yoblyMP9xH97T8N+JtpU/JiOxCggmwr8F2wIvPc2jThc/rvTOZ8PdU8PQORyvVLyj
	 p67JvHtqY1BGGuCd0EEAzYbnJ+qY/VYxRhZOj+XjIotuspDYSH62alHqQRED9lIBmP
	 wULMQqOI0aKxRTWKBD8nDItmbNr3+JitqpGBt9AA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45BCaXxP007135
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Jun 2024 07:36:33 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jun 2024 07:36:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jun 2024 07:36:32 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45BCaWTR105880;
	Tue, 11 Jun 2024 07:36:32 -0500
From: Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v3 0/2] Fixes for McASP and dmaengine_pcm
Date: Tue, 11 Jun 2024 18:02:54 +0530
Message-ID: <20240611-asoc_next-v3-0-fcfd84b12164@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPZDaGYC/22MQQ6CMBBFr2Jmbc20lAKuvIcxpg6DdCE1LWkwh
 LtbWBgWLt/Pf2+GyMFxhPNhhsDJReeHDMXxANTb4cnCtZlBodJoUAsbPd0HnkZBaIqOSDZIBvL
 /Hbhz09a63jL3Lo4+fLZ0kuv6r5KkQMF1U1Jdc6V1exndifwL1kRSO03iXlNZe5TK2q5sTUX6p
 y3L8gVCtZUR1gAAAA==
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Devarsh Thakkar <devarsht@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>, Jai
 Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=/JEDUExWQNwoOi5zUT9iDtsEq0qd3E0WRFsxqoJeC4U=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBmaETM0yRfcun3sNNj794JLE6yj7x6Th/YOdUPV
 xDqladjUQWJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZmhEzAAKCRBD3pH5JJpx
 RSITD/0bh6UNfq2ZtG62Xu+6cYsJBp3BUUSSosjkD4IovEKizbuhi4Ph/oTBi0BYCOAM62ZEkGf
 saPiGlg0EfdlmcTnlvY7IXpPvZUUcvFdmF77/3yYSSX1ugbbn7RvTWzHDI1ws9BMaiZXGv6typB
 EAA6coMsNiCz/OQnxLINAlXs3FNoYauWgI56PIb5Z+vwyKpeAc4KUzdfYZzaYiYNO16u3i53HKn
 DOV1Cim2D3WWq0admLs+IhkVZ2NfU7BxR2NzvGOfp4FcyVNqt0EyEGrk5czZ+b1KEHgNmr8s3uG
 AYbN1rHEO3fgUbGYQHLrSdVR0GeQxZJQU8hT2ybWqvAPUD/Esft8oHNWYXNqH7Y3bFw3GxMQULk
 xD8I9TVa65s8OMOeOVxo/Z5uRn8G8lYF2BV760bS6GZncGJ7/wQWX51yXVMGSI3OSfbLzqskUbw
 2ZHYeZk4jNAXiE88jbKfi+QtrgRTL53srS905TTFwO7m0ngIqP6/voj2jEMkufUe2UAvfCMoC/h
 BgNX5pBm4/9QsaPDCQFnWFYsSGHViPUqNxZWmLk/nRRtf7u5nZmJQQ6hs/XUjr5L3aNS155WN6m
 c7XSNG3O1rS2SFn4ZiPKgQ6WkVluUIhmr/u9o8zWxXNDNlhcKqnuH6+y2LhS0a6lAXF0PhimZMR
 8jQVrhh9zSxKTgQ==
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
Changes in v3:
- Use sync_stop() hook instead of a prepare() hook for the DMA channel
  synchronization
- Link to v2: https://lore.kernel.org/r/20240610-asoc_next-v2-0-b52aaf5d67c4@ti.com

Changes in v2:
- Fix compiler warning for prepare callback by marking it static
- Pass numevt directly to hw_rule_min_periodsize()
- Link to v1: https://lore.kernel.org/r/20240604-asoc_next-v1-0-e895c88e744d@ti.com

---
Jai Luthra (2):
      ALSA: dmaengine: Synchronize dma channel after drop()
      ASoC: ti: davinci-mcasp: Set min period size using FIFO config

 include/sound/dmaengine_pcm.h         |  1 +
 sound/core/pcm_dmaengine.c            | 10 ++++++++++
 sound/soc/soc-generic-dmaengine-pcm.c |  8 ++++++++
 sound/soc/ti/davinci-mcasp.c          |  9 +++++++--
 4 files changed, 26 insertions(+), 2 deletions(-)
---
base-commit: a957267fa7e9159d3d2ee1421359ebf228570c68
change-id: 20240604-asoc_next-c063fcc190c6

Best regards,
-- 
Jai Luthra <j-luthra@ti.com>


