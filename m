Return-Path: <linux-kernel+bounces-423168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0289DA3D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C322628395D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB10C184540;
	Wed, 27 Nov 2024 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J875uA/A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1C313C816
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732695851; cv=none; b=dWIHbcEehTfqSks8YhOhZvqlV5EqdrBbm3f3GPAqDe2L0IL5LBHeDZsSOlLFNf2dA36yiOhJjcDE2u01RvhD9W2aITmboAHMQAu+M32tPFkEY8BMCtd7UMEdakZUQv3l0qHb+QJqi9U/cM2lL+yf+9FqBCk+RJwzArY/XG1ZOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732695851; c=relaxed/simple;
	bh=D2zCNvv6RwYiCqPdzLthSS1rvZf7x6Pd4PMS/3lR1SA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Pk983jopKQXkzaAfUABDClJDAUrfzfE1HUhRtjnb83/awGcOlOnlKg+jMyofgXAu7MZuaeZNkP4QsQHhPMRFQNfnWfxJczwl7tYc9/ksOzksyjV/wljDKDkSPezVqb8LTzaJ8zifYNWQuO9GxdvVRzBv8opZndTCTfJSvUmfWgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J875uA/A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732695848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DLdQSuBYZn4bZL0sD7tkxRgW+8xJC7aPjWdDJFdluR8=;
	b=J875uA/Ao2As0ZrJ1pd552kLsd3moOG9/x0W24Fn7FZ5Jdvmzevrwz1l2J78KfPx68G1fs
	D/zbmuGJI/99FIXDmdRtsIxNXkx3bXohC4K9yCX7anNdUpMbicsmCafZQxIWMZ+H7mLjta
	3HPT3Xjvs3hkJAq19ZBoi7iY4c+kJ+w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-JPxWRil_PxegF_WNF8ciGg-1; Wed, 27 Nov 2024 03:24:06 -0500
X-MC-Unique: JPxWRil_PxegF_WNF8ciGg-1
X-Mimecast-MFC-AGG-ID: JPxWRil_PxegF_WNF8ciGg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434922f8300so3917295e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732695845; x=1733300645;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLdQSuBYZn4bZL0sD7tkxRgW+8xJC7aPjWdDJFdluR8=;
        b=tklG4MjeVCevXQ5CFR8fJGFxquKZI7PdwPiWLLXA5pxC5QQboUK8MfeqklKo1vwKJD
         tnJnbWzsYf0l+In9+IuYyPFEmP5wlqehUmtJsAyjjm3ICxqdH7Fto9UA9RVFumGV1Efd
         8zBpxyzMUeBmvjxnDEj02X5q4kRT+16FXL4EJ3g85ZaF3gEZ47/9crldtLJPHkqC7RcS
         9q6HZsFq/sfJV0/Kbm3AIZQqVmMsdx3lfqUYvbE44LwDpafVG40hl9UEpr+cIazPQoDe
         PLYBqmafFWFdaXtPtUn256Ql/SaZSEdvz0bTVrV0N0Qn49Gsvtr2AWzuWTWtf/V8/F2q
         xi5w==
X-Forwarded-Encrypted: i=1; AJvYcCXAlk+lRxpZS3z8Qr/GgfUWpFjqmVhBajnIskQDJrCc5+xWsAZ7r+TvM+TBPdAVEEW1Ry0+23FTR7PKNMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxilO/d8rA4Dk+GQotSbsptXgRHEkndLUaaiSmd9VOsvxKYpQ
	4aSb8u8UoX61BXG2bOKOgy91I+uEn26dwVJPb4neH5Og6wVPId24U3BBFwTw3eOa5Inr2AaAB0H
	m9F12KvXqbqaJ9GKomP+2urbAn63gSF6krrgO53G30BBVoUyyy2j1jRUAoFd6CA==
X-Gm-Gg: ASbGncs02wz3EFfB2+DpRuONs4Lpra70QoyqhvPLf3k+xGQrkWYsq8jdLttV+V8fxty
	XTvnTA+gVGLY4iAN5WBhmrIszTDSot1dLwI8HSkSBq0tf66/DTNtHzLDjEzGo5CLHR8FU9B11pD
	AzhHLfimuFgkuqyWJ3cnr4HGwz9O/s4+frDJg3HtqF08TvpjtfI0mc9m/WDxw47UahNF875r62e
	5vCTEUfQEW8XSfoC2/Tdai8mYzaeFUUoGpqfbknvM1twwcutC7pIYNLXKJFhvkDfPfyN4Zx488e
	CrwB8smcw4i+sM42QAk=
X-Received: by 2002:a05:600c:1d1e:b0:42c:aeee:da86 with SMTP id 5b1f17b1804b1-434a9e1ce8emr6680175e9.8.1732695845284;
        Wed, 27 Nov 2024 00:24:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7GbyJq6Op0/kUh8of8dCHY9qLEVFtAu4wzuAcMAOzg4JRz58ZFg7QoPddZ13kWOBq1Symeg==
X-Received: by 2002:a05:600c:1d1e:b0:42c:aeee:da86 with SMTP id 5b1f17b1804b1-434a9e1ce8emr6680045e9.8.1732695844985;
        Wed, 27 Nov 2024 00:24:04 -0800 (PST)
Received: from [192.168.1.51] (200.red-83-45-89.dynamicip.rima-tde.net. [83.45.89.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa78007dsm13105145e9.19.2024.11.27.00.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 00:24:04 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Wed, 27 Nov 2024 09:23:51 +0100
Subject: [PATCH] dmaengine: dma_request_chan_by_mask() defer probing
 unconditionally
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-defer-dma-request-chan-v1-1-203db7baf470@redhat.com>
X-B4-Tracking: v=1; b=H4sIABbXRmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyNz3ZTUtNQi3ZTcRN2i1MLS1OISXZA6XZM0I7NkM6NkCzNLQyWg5oK
 i1LTMCrDB0bG1tQDXiOkqaAAAAA==
X-Change-ID: 20241127-defer-dma-request-chan-4f26c62c8691
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, vigneshr@ti.com, 
 nm@ti.com, Enric Balletbo i Serra <eballetb@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732695844; l=1509;
 i=eballetb@redhat.com; s=20241113; h=from:subject:message-id;
 bh=D2zCNvv6RwYiCqPdzLthSS1rvZf7x6Pd4PMS/3lR1SA=;
 b=d6wKUqj3cMQazozorTN/arh1KBjFhAOsX/bo5B/+yX16/O3xEFZDPS9LxlOHt5vht7alVetvp
 xFILBftgKA+CalsReYgGnL7FBDHKW0w9RGtqrFjTXoQ/tTKeMyzrop2
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=xAM6APjLnjm98JkE7JdP1GytrxFUrcDLr+fvzW1Dlyw=

Having no DMA devices registered is not a guarantee that the device
doesn't exist, it could be that is not registered yet, so return
EPROBE_DEFER unconditionally so the caller can wait for the required
DMA device registered.

Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
This patch fixes the following error on TI AM69-SK

[    2.854501] cadence-qspi 47040000.spi: error -ENODEV: No Rx DMA available

The DMA device is probed after cadence-qspi driver, so deferring it
solves the problem.
---
 drivers/dma/dmaengine.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c1357d7f3dc6ca7899c4d68a039567e73b0f089d..57f07b477a5d9ad8f2656584b8c0d6dffb2ab469 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -889,10 +889,10 @@ struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask)
 	chan = __dma_request_channel(mask, NULL, NULL, NULL);
 	if (!chan) {
 		mutex_lock(&dma_list_mutex);
-		if (list_empty(&dma_device_list))
-			chan = ERR_PTR(-EPROBE_DEFER);
-		else
-			chan = ERR_PTR(-ENODEV);
+		/* If the required DMA device is not registered yet,
+		 * return EPROBE_DEFER
+		 */
+		chan = ERR_PTR(-EPROBE_DEFER);
 		mutex_unlock(&dma_list_mutex);
 	}
 

---
base-commit: 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
change-id: 20241127-defer-dma-request-chan-4f26c62c8691

Best regards,
-- 
Enric Balletbo i Serra <eballetb@redhat.com>


