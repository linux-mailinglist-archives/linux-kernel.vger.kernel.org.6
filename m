Return-Path: <linux-kernel+bounces-406260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D74F9C5CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E0B2821EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7FE207A02;
	Tue, 12 Nov 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6vvqgMJ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FC22076BC;
	Tue, 12 Nov 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427125; cv=none; b=dII9gbDq8/di/coZnjMULhZLc1a0sve4GeTcSsQKxnm/EgP+NcaTTB7ZpBL8gcpeAckjKXJ5mj5+TWBk7tCS8g3wdE2uNSgCbe394ZSWBN20YPVfYjHM5D6pV+DpQ+mnSJUC7oX/s/fYhcXJ0qBvOyWCqJTLQkGsxefiIjroeDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427125; c=relaxed/simple;
	bh=xYrNNORV/XYxgedcM6FRYBpcFd78+3NGOiIjPUINCKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tm8tmnEn5gBjkm+nGNz1dLMxbMSHdZwgBbPXZwgogyYg3mPmQxCGHodhmXmxr6WywpTms0EDPTWrd34LbUMYOuh0l8nzr5DD8r7xb7BHNK3fUNCRUF14Bjwxmvk1PW8XcoFkKDZnL2e+N8rpZXt7tsbjCjZIbPMAd8R3B+x2LWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6vvqgMJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d808ae924so3625044f8f.0;
        Tue, 12 Nov 2024 07:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731427122; x=1732031922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MKCUUUxJD/2v5EQc5z8RrUear+TyL1L5ShZEVqt3HE=;
        b=L6vvqgMJ7Y4N3MhvjDcweBGvWBPNO3Kn6PstDX2SenbaOq+c/a3Ojla/O8wYt06vRn
         u6ad3O0l+W0AOby1dkLfW/0vnKXkhxGNL32LaaEVuK53wXjyeEVvrTrcxPsZs1vMGpOY
         SyDhrfD/OI1KYlSLBP6ZpVzVHz3F8dTZXVi7gTqCEBaGc/QMYW+394rtiTUKjkzjduW3
         S5YsIofz5UieJDF3Zueron3IOZAJypN2am7C/o2ApelqrWOC6U5+tNexB3WXUtoqiaWH
         WPQ3TCUfLkMtgL+2GsJI8i+TzLI619EOufiqvo836Xf/mAHp5DR5UFhKupCheJE1J2vO
         SbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427122; x=1732031922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MKCUUUxJD/2v5EQc5z8RrUear+TyL1L5ShZEVqt3HE=;
        b=jQwaaS0sIvANgNlmkuT85aXUEaENDuYR/0bHF0xnOKLN/D9azZl7CizuVOqNqa6lLH
         bfxJweGMoK7wxGs3a8UVILvFJ0TQk+5y0ruEheQJck4hgqUWxfipy67VBXX68ftRjfKw
         0SA++1Xn32mTj0euLOFDBXFsyGm3a4/WJ65LBhT+y/03EBhSBo7bRg4uS5MDNnaGuw4Y
         vWlEIz5rTCQY9Hml71wrEKCnfMQOZa761b3lLkomJ4UgJlZxe/cQGMW5JNVttOnUKr2w
         e1UIJ/YKDTSlG4p4+b3ljteNTrB6cMmsW5sNFtLx93/VHZqJ7UlXID6gbwBZ3au5NyLm
         4KYA==
X-Forwarded-Encrypted: i=1; AJvYcCW5/5O3iklo0YycxsqGeCARZg3LTnkp/cOt/5QmV7a6VThXrz/pGgOj6wQ6yCla0NHSHKQtkNgy5zM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7dRRKB4EZZ/ctDLmMKTXqYIJb0ps7ozOXC8C0nCHeOs7Zxtxo
	D5XRkIOQZ6dlSx7/wcL3wTysgdH3tQXZudLEfTaGREmff8CsBPp/bjRwoexdKpI=
X-Google-Smtp-Source: AGHT+IEajO2qYrPwbD2tIZK1Vgen3l8STSY7cu7vIlq85YMMKzVkH1SjjAa0k8mT+T5zrhdk31a1gQ==
X-Received: by 2002:a5d:64c5:0:b0:37d:52e3:e3f0 with SMTP id ffacd0b85a97d-381f1883da1mr14716985f8f.44.1731427121902;
        Tue, 12 Nov 2024 07:58:41 -0800 (PST)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381edc1104asm15991136f8f.88.2024.11.12.07.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:58:41 -0800 (PST)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: gregkh@linuxfoundation.org,
	andreyknvl@gmail.com,
	b-liu@ti.com,
	johan@kernel.org,
	oneukum@suse.com,
	stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	snovitoll@gmail.com,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH v2 6/8] drivers/usb/musb: refactor min/max with min_t/max_t
Date: Tue, 12 Nov 2024 20:58:15 +0500
Message-Id: <20241112155817.3512577-7-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112155817.3512577-1-snovitoll@gmail.com>
References: <2024111251-spill-hatchback-72da@gregkh>
 <20241112155817.3512577-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure type safety by using min_t()/max_t() instead of casted min()/max().

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 drivers/usb/musb/musb_core.c       | 2 +-
 drivers/usb/musb/musb_gadget_ep0.c | 2 +-
 drivers/usb/musb/musb_host.c       | 5 ++---
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index b24adb5b399f..61f3aee7b72e 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1387,7 +1387,7 @@ fifo_setup(struct musb *musb, struct musb_hw_ep  *hw_ep,
 
 	/* expect hw_ep has already been zero-initialized */
 
-	size = ffs(max(maxpacket, (u16) 8)) - 1;
+	size = ffs(max_t(u16, maxpacket, 8)) - 1;
 	maxpacket = 1 << size;
 
 	c_size = size - 3;
diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
index 6d7336727388..f0786f8fbb25 100644
--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -533,7 +533,7 @@ static void ep0_txstate(struct musb *musb)
 
 	/* load the data */
 	fifo_src = (u8 *) request->buf + request->actual;
-	fifo_count = min((unsigned) MUSB_EP0_FIFOSIZE,
+	fifo_count = min_t(unsigned, MUSB_EP0_FIFOSIZE,
 		request->length - request->actual);
 	musb_write_fifo(&musb->endpoints[0], fifo_count, fifo_src);
 	request->actual += fifo_count;
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index bc4507781167..732ba981e607 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -798,10 +798,9 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 		}
 
 		if (can_bulk_split(musb, qh->type))
-			load_count = min((u32) hw_ep->max_packet_sz_tx,
-						len);
+			load_count = min_t(u32, hw_ep->max_packet_sz_tx, len);
 		else
-			load_count = min((u32) packet_sz, len);
+			load_count = min_t(u32, packet_sz, len);
 
 		if (dma_channel && musb_tx_dma_program(dma_controller,
 					hw_ep, qh, urb, offset, len))
-- 
2.34.1


