Return-Path: <linux-kernel+bounces-417949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE29D5B27
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D562830F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA8E18BC32;
	Fri, 22 Nov 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="W1yWkMS0"
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C4187879
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264927; cv=none; b=GEdrGTCIKuLszj4TzmVXaXifo1IhNOu3WcIRPp9AuKdJa9Th0+s54QB3nfTBOSx16EHCsLmyXAOYvEzepXtZptZnTc6kPhsn0A6cEIWbqdkTu6Xr7RJtVmeZeEwDgSScaifZOAzqiSKJOqsdkZLXRiuOj6K0YiZZGiIwjTte4sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264927; c=relaxed/simple;
	bh=sP+4letafPvxfukJYV0UOYRRFVIebSXD/aQphVIz7qY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vq6gLg7CNc/bJrZ+/j5/jo/BOamAG48JIWVxMiTD61OlzlmfyoMnNbV/SqX1QsNuVoli5orqzQwHxxwwyc0nPIsp1uX4rlo9zIzRMQ+Qw8Sj38TRZGnHF47rV2PJPMk/8akkuyDwBDgCL8YxijPHBG9wfN+anstsyddMDb/BJUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=W1yWkMS0; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-432d9bb168cso16731825e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1732264924; x=1732869724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=su6tsEJry4BzuFP65MpXpBH51+aHQ+dE9vL6DxTxUwA=;
        b=W1yWkMS0SYWzQ3zoKcv8xeYylwxBCCcQ84wuqbjQXHN5S77VQj8YbvVze7OCqOwrhj
         WRuhrjreTn0/oh+2t8DzuqNR2RjovzsYUdxFVF2ivjeezmSCp0DxK5PqMicoWAyecVtd
         6RI3GfpJtkg3OSLmSdwgkdfEjMNaEigDx7gDBQCvWHJoUrEF4XY6vNroke2WC8y51dhq
         xxXPHb+RvgykV3IOwMmapN0u3aQe11Nyhhp+bol7BybuHdhwpAqrIGKqd/QSQUaxpLPm
         gSwRFoZDvwq98ZV7MPM6MGr1xHeGK2dwj6At+m5u0YIhMsHnABG9bQOeIP1+BjgrIXPt
         51NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732264924; x=1732869724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=su6tsEJry4BzuFP65MpXpBH51+aHQ+dE9vL6DxTxUwA=;
        b=EvXnfpPW4SPomWhScB+Qz6sH2R7PDGvCQWSMAKEFkCiau+rKJ1ZkeWqZDtRb4+Nms/
         TW2w+3BqJqrzn6ZxJ3bFCTtdXfYNUxn5t5hUDkE8h5plnAMbmMymJuwIFalLgmEOQJX0
         cDUoz6t0UvhqzRdE32d373X6L47j0+81zN4P2xYQqJYcPNiAsgLJvgD8cGZOGd/PXqgL
         yIKjKq2hRWT9McqNuyP4ifPTm0DW2OjpS/tSdI77/tEPINlfKVqg2UCxB4UPsULr+YT9
         rofsIY6MsekipcjSa2dUX2brwY8C7aM/fOaKWz1VmA0ZJFjLPojw3tJzkYBpGiD3FpTd
         GHXw==
X-Forwarded-Encrypted: i=1; AJvYcCU2uryUeF0gCKQWcJ2JkZ7DkHCme8v2OQ3zc8Yfj/txEPRfqaY5A2jdAEtjplfIxSjmth+SIPxgBQjVhQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCT1ZJkuuiG91DYKeCkmSLDp44cZEiTxvAur8dmVj5dKkNk3XL
	z1LSnoM3BD7jMITA9/uj48sqSwTVHpp8kyH69hSGn3PXJty3SCMOnBebx4N7NikgasM1yLzxSIL
	1bGx9iiNb9v5pZkwJDFJPQKDmryPuiayf
X-Gm-Gg: ASbGnctzmWRfiKZuoWuTtbqbFpcIfcl9PSSkWf53eF7woLYbJ4gwVJGwRYoH75Y6ecY
	uUl3p2cHxg3Cl3hzTBQ2kif1lEd/rrNe2P63VuESQ29ZUUs2z6xKgpThLIi7mw8J0788NJaBL3i
	3Vms9Zx8rJL/4OFSqX/vTIqEYpeGuoyurbfw2u2BmN8bMnDYR2njUsJBpME9uSm9VrvEXQZ1I1M
	pgIBP3zghEWm/pVq1fNrLGGSsVF+AfAkpJutW6yRVF+2iembNTCwZsU8sx8xgx/eg==
X-Google-Smtp-Source: AGHT+IHzC1eCRwXGViTOOLSFM/PDCwUqY6DKBuYcoiYSQl4qaaz1QaEXL2O6o2F/GfgoK5RmaU1tu7qT3rGx
X-Received: by 2002:a05:600c:5105:b0:431:15f1:421d with SMTP id 5b1f17b1804b1-433c5ceeb38mr52428355e9.16.1732264924132;
        Fri, 22 Nov 2024 00:42:04 -0800 (PST)
Received: from raspberrypi.com ([93.93.133.154])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-433b45c428asm4064825e9.23.2024.11.22.00.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 00:42:04 -0800 (PST)
X-Relaying-Domain: raspberrypi.com
From: Naushir Patuck <naush@raspberrypi.com>
To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: linux-media@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jacopo.mondi@ideasonboard.com,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Naushir Patuck <naush@raspberrypi.com>
Subject: [PATCH v1 1/5] drivers: media: bcm2835-unicam: Improve frame sequence count handling
Date: Fri, 22 Nov 2024 08:41:48 +0000
Message-Id: <20241122084152.1841419-2-naush@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122084152.1841419-1-naush@raspberrypi.com>
References: <20241122084152.1841419-1-naush@raspberrypi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that the frame sequence counter is incremented only if a previous
frame start interrupt has occurred, or a frame start + frame end has
occurred simultaneously.

This corresponds the sequence number with the actual number of frames
produced by the sensor, not the number of frame buffers dequeued back
to userland.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
---
 .../media/platform/broadcom/bcm2835-unicam.c  | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index 3aed0e493c81..36fb186a0421 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -199,6 +199,7 @@ struct unicam_device {
 	/* subdevice async notifier */
 	struct v4l2_async_notifier notifier;
 	unsigned int sequence;
+	bool frame_started;
 
 	/* Sensor node */
 	struct {
@@ -742,6 +743,8 @@ static irqreturn_t unicam_isr(int irq, void *dev)
 	 * buffer forever.
 	 */
 	if (fe) {
+		bool inc_seq = unicam->frame_started;
+
 		/*
 		 * Ensure we have swapped buffers already as we can't
 		 * stop the peripheral. If no buffer is available, use a
@@ -761,11 +764,24 @@ static irqreturn_t unicam_isr(int irq, void *dev)
 			 * + FS + LS). In this case, we cannot signal the buffer
 			 * as complete, as the HW will reuse that buffer.
 			 */
-			if (node->cur_frm && node->cur_frm != node->next_frm)
+			if (node->cur_frm && node->cur_frm != node->next_frm) {
 				unicam_process_buffer_complete(node, sequence);
+				inc_seq = true;
+			}
 			node->cur_frm = node->next_frm;
 		}
-		unicam->sequence++;
+
+		/*
+		 * Increment the sequence number conditionally on either a FS
+		 * having already occurred, or in the FE + FS condition as
+		 * caught in the FE handler above. This ensures the sequence
+		 * number corresponds to the frames generated by the sensor, not
+		 * the frames dequeued to userland.
+		 */
+		if (inc_seq) {
+			unicam->sequence++;
+			unicam->frame_started = false;
+		}
 	}
 
 	if (ista & UNICAM_FSI) {
@@ -795,6 +811,7 @@ static irqreturn_t unicam_isr(int irq, void *dev)
 		}
 
 		unicam_queue_event_sof(unicam);
+		unicam->frame_started = true;
 	}
 
 	/*
@@ -1413,6 +1430,7 @@ static int unicam_sd_enable_streams(struct v4l2_subdev *sd,
 		if (unicam->pipe.nodes & BIT(UNICAM_METADATA_NODE))
 			unicam_start_metadata(unicam);
 
+		unicam->frame_started = false;
 		unicam_start_rx(unicam, state);
 	}
 
-- 
2.34.1


