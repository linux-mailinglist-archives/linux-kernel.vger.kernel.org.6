Return-Path: <linux-kernel+bounces-417953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545569D5B30
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5D21F23021
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602111D364C;
	Fri, 22 Nov 2024 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="jumFb7s0"
Received: from mail-lj1-f225.google.com (mail-lj1-f225.google.com [209.85.208.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0750F1C3F0E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264931; cv=none; b=FNlooS+Q7MFsl3ux85O7zDjrFtrTEGGeSsp8+v8ISVGV5X1GV/UDl84Z3EBnYlM1SWxRWN1O4CuHzIZ+KBoGVk2BFZKhBnRZ84VfK/syIZnwfvOP8J9wEMzURHEgy7NqPXrIBM7Z6RAIrWFxjbzTVRVq+CqzgANDZUSDtjfL4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264931; c=relaxed/simple;
	bh=5AKvefdb2FKkKG19uxXZOCMpFrT7SuQ7/tYup9Rr538=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tgx+IbWkElxWyW8BtPhD1AEqxjCyzXSi/FW35YNmt4hyl4yPUC4uH/dgDz1PR8pvf8biJOO7k79RLWBRI0lQwKH+TPE7QnvHZjgkXzdKhfb+HuVlcDrU+++3fYAKC4SQ2y1xeKEGQo85JD5j7/Hkpgwr8syMfbXb18zWZo9AAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=jumFb7s0; arc=none smtp.client-ip=209.85.208.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-lj1-f225.google.com with SMTP id 38308e7fff4ca-2ff64e5d31bso19311011fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1732264928; x=1732869728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEuuR+8psNj062NlDHnckyMnQqgbbgHkJzIBccpjbSA=;
        b=jumFb7s0/s+0uX619lFsGR6mqHQyn0GZws9ZZ3pRtsTXSwwLcGyJYHaz5gebJBf6g4
         Vgq5SoX/cf7sCDNSlSbSDQu4zVzUeYP2yfE0r6zqx1huDYta/jVDeIATlSjZbah49n7V
         fGWGX2MjdPGZN4uqFIzd7r27S5Y4gpemjbQnkxnPehkDgnCY/35LXV3CZC4aomLYGrgb
         VfrSbXTHXBhkCYUxcbHcp8130VQBzBJUoUnvXrpWjOfr9KQk40hqSmEulBsGs1ughQnv
         wyT2jpt3FhCCbjdyFvCGsuc2xAquoORCTj6j+ZMZCTydNAExIUUWr13d1rfmuQVoiH4w
         ZYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732264928; x=1732869728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEuuR+8psNj062NlDHnckyMnQqgbbgHkJzIBccpjbSA=;
        b=vkcesmCy1McCVXVQ0RcrycO8oCTvprq6Bjq2YbIFCu66RnLiPornQT7H+u3IFhGAjN
         IFTUTJJWSG+YUPkGrI+4PBOxL9QJ2el0rObRr48clIFqdH1+ctmuGKUwBT1t74py0djG
         0h2BE6YHpnDiB3BQRy4GK6mdG6HNJ7doC8xf2CbdQ07hefIKh9zYr8FN9lG6NDz2Yr0J
         ayPSIUAVF+TMCy8KIxkrATPEGpQxoz1uyEGTNAT36zL1jm8z6PeTShZURwKDdOFNoqdu
         YXuWZDd/iarjoHkM6c31Z1aZZQyMFqSbiUzXLIXdJaiODrJyPjkHRGoKy40SJrPYn9cx
         sYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8RSR3bSKmN7I6Tekyk+mfJOFflUY44fAcGdFOi/9rdy/yn/gpuRwlNN7RDhPSgCwkc0N5PA04eEk9j6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrNRULuAjABcDCJLCtPLiOn6B+vzfcNfzWG8YN3eGP5UgdF8hg
	n2OKavpHmWMlciTOlNPpm7KhLKfrvjtBYKHC53hikmhE5JWs/XvafUMrLy9con/PawevLJGi7Ic
	7Hu2CWBpxxTu0z3WPdQRFcBTDoGz47X7T
X-Gm-Gg: ASbGncv+M3oCTMzp6y7X7bFum/UHNAaL0fkAZPCMVxA8Iq29qRDi9KW1dRSt+35ZT/R
	2xuIgw9LyfgydGfg3wgXByqiigY/AClFOs8Qwr60Ido3rtYXBiJ5LI8raxdkIgUAdqviRO5qPp2
	QqT6B2mR9WAhKHBtH1cJm4CwA8LunZyvMNCIQ9MjTTGQjvhc2U4vsS4ySiOoZsn25OCQ4KWJSB+
	4c/lXy+vUQqhChROXvh3czSteoKf85YuDY2gyQxz7sGdIGX7o2ky/ZHBLwWJX5gQQ==
X-Google-Smtp-Source: AGHT+IH59DQEKrXu+FgyMtFbQ1vxHpRwe3lqUuQy9ABiaFsiJEh89r7ztVYjLZAP7d2u3qmvDeDJw57zHVk6
X-Received: by 2002:a05:6512:10ce:b0:539:ea0f:cc43 with SMTP id 2adb3069b0e04-53dd36a0f38mr982109e87.19.1732264927961;
        Fri, 22 Nov 2024 00:42:07 -0800 (PST)
Received: from raspberrypi.com ([93.93.133.154])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-53dd243bb76sm31151e87.11.2024.11.22.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 00:42:07 -0800 (PST)
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
Subject: [PATCH v1 5/5] drivers: media: bcm2835-unicam: Correctly handle FS + FE ISR condition
Date: Fri, 22 Nov 2024 08:41:52 +0000
Message-Id: <20241122084152.1841419-6-naush@raspberrypi.com>
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

This change aligns the FS/FE interrupt handling with the Raspberry Pi
kernel downstream Unicam driver.

If we get a simultaneous FS + FE interrupt for the same frame, it cannot
be marked as completed and returned to userland as the framebuffer will
be refilled by Unicam on the next sensor frame. Additionally, the
timestamp will be set to 0 as the FS interrupt handling code will not
have run yet.

To avoid these problems, the frame is considered dropped in the FE
handler, and will be returned to userland on the subsequent sensor frame.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
---
 .../media/platform/broadcom/bcm2835-unicam.c  | 39 +++++++++++++++++--
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index f10064107d54..0d2aa25d483f 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -773,10 +773,26 @@ static irqreturn_t unicam_isr(int irq, void *dev)
 			 * as complete, as the HW will reuse that buffer.
 			 */
 			if (node->cur_frm && node->cur_frm != node->next_frm) {
+				/*
+				 * This condition checks if FE + FS for the same
+				 * frame has occurred. In such cases, we cannot
+				 * return out the frame, as no buffer handling
+				 * or timestamping has yet been done as part of
+				 * the FS handler.
+				 */
+				if (!node->cur_frm->vb.vb2_buf.timestamp) {
+					dev_dbg(unicam->v4l2_dev.dev,
+						"ISR: FE without FS, dropping frame\n");
+					continue;
+				}
+
 				unicam_process_buffer_complete(node, sequence);
+				node->cur_frm = node->next_frm;
+				node->next_frm = NULL;
 				inc_seq = true;
+			} else {
+				node->cur_frm = node->next_frm;
 			}
-			node->cur_frm = node->next_frm;
 		}
 
 		/*
@@ -812,10 +828,25 @@ static irqreturn_t unicam_isr(int irq, void *dev)
 					i);
 			/*
 			 * Set the next frame output to go to a dummy frame
-			 * if we have not managed to obtain another frame
-			 * from the queue.
+			 * if no buffer currently queued.
 			 */
-			unicam_schedule_dummy_buffer(node);
+			if (!node->next_frm ||
+			    node->next_frm == node->cur_frm) {
+				unicam_schedule_dummy_buffer(node);
+			} else if (unicam->node[i].cur_frm) {
+				/*
+				 * Repeated FS without FE. Hardware will have
+				 * swapped buffers, but the cur_frm doesn't
+				 * contain valid data. Return cur_frm to the
+				 * queue.
+				 */
+				spin_lock(&node->dma_queue_lock);
+				list_add_tail(&node->cur_frm->list,
+					      &node->dma_queue);
+				spin_unlock(&node->dma_queue_lock);
+				node->cur_frm = node->next_frm;
+				node->next_frm = NULL;
+			}
 		}
 
 		unicam_queue_event_sof(unicam);
-- 
2.34.1


