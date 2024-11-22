Return-Path: <linux-kernel+bounces-417952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9DA9D5B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68864282D80
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05261BD9E9;
	Fri, 22 Nov 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="SeNbLyu3"
Received: from mail-wr1-f98.google.com (mail-wr1-f98.google.com [209.85.221.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D87A18A6D8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264929; cv=none; b=h17O2pIj6UnoDTljZjB1rTfFZuvb+KY5g5UpT8iTYbb1NS14UtBbZt4WcIndzRigleVq/2Lcgyri3dsBiVOL7G5HDjalKDJWf3YFt/WyQ6f1b0g5Fg401K4J/chyJ/53xpg5bb1XfkKcuuOXDZs5XY+QazRX1sYLWASqpL5tGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264929; c=relaxed/simple;
	bh=Ot66rVNwD26UO/5YVx8cEhDAVFdsS6j0qnhs3PRBvE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JxWO1ti/3iU9b/DnUi14v6yo9AaAGgPXK/LPhpBorHN3RnhZOMcg9Cy8gJfea+1FewXENEJPBCdlSzJaz/UtCzJV3lbsGnpTd6RlZDrpaoSRl9J5jOvamCZn3tQWByz017G9VdLxy1WHJl6YUvuu5D5Krdiua85WhvcxrJBVjyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=SeNbLyu3; arc=none smtp.client-ip=209.85.221.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f98.google.com with SMTP id ffacd0b85a97d-38245e072e8so1680635f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1732264926; x=1732869726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3SPKEgnk0/CKlGg8ZlQK9CMOXwXblPgVAtkOWHzh5A=;
        b=SeNbLyu3QnjiBOibbWGufpCV+O1IJs4wyge5FHAOQt4vqgQWglROLrmO0Z6tqPM9Y/
         Y+igDc8fHRwwx4LeSga98kjoilJQhaWRaXTDZg5hu0wvU4/F7IpypUBonzr/cXKvRmHn
         e+XZo69v7OTDsqoZeMmqZNrgH8YNTcX1M7oGm2TOl1rftgm6N2SxWvPnQt9bgZmp6WWi
         QTc/JErh8duTZyawvKbbqAHKfvf+icHUaFIc3SVp+CcxcEnpMWK12nhXnqnkZGt0n/VK
         IaBwM0ReAPY1Vi3DMyIavq8/VX40IKZijMkiwdfJpenjuh7MsgxgY611rPZrlsYI8uZ7
         jj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732264926; x=1732869726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3SPKEgnk0/CKlGg8ZlQK9CMOXwXblPgVAtkOWHzh5A=;
        b=Gqf2LIwpue0LN/9Yb/yaXSKCyILQ2kY/o9pAiWiRj3rKIhIOXa7/+iVCizRfObZ6lL
         ohN2dSydEGoPN0GOeTIEJadVIIOTYBbvPVKkWLedhWTgZiiFzX0gp7fsXfAZ4n+KeEzW
         yRUjuxANcXB4F1T5d6Ca4gCQFcUFURMef+wo6Bqo8fiWJQ3a9Lwe6VyzoasA2RosuNrN
         1mGHieZKV1SoydLZ5HdNFL9uitDgAEr8M1FHdN/Hk1YIFDK//GvdOZ5QZTDi7a+/v8YQ
         msW0UPztEjlgiIA3hG7TSRaGFQY3RXXUPeilH0CKNlIs6lNidkgtpH7iZwFcinaW8D6E
         ghHg==
X-Forwarded-Encrypted: i=1; AJvYcCUR5c+TME+WutM8WvQs6bSEdYhXYv7z464yr8DT7rOdc37nkox7Axts2FdkKExaAcjNS0u24NDy4ePSePI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFuSYJ/UCD+zfDEfDAfiYLoS5z87zh5FiNxEWs4058yVyMa2yp
	vzYdWbHvayogcH9XCuIl/cbeGckjeRq6kQDTzvJs7gJ3PTx+4PPieOWs9SNIVpprJ6bRtrn4HtJ
	gfChEimLRpKjSmStXxPjs292gPw4oJapR
X-Gm-Gg: ASbGnctGhBIBrPM09k0tONlHxgAsZNRabs/VUdGgAT+on66zl7xvchK1Bgz+cXLOYDg
	y5sX4YPXg2RZHtu88lFMvXHsQxWU1vS1MfFQr4Y9VvSHhHdoy9QPpxh4PEMo1tbZPoZQR13e7KH
	6KlsWqEiNA65qJ1I3mPuZf3B897JQYmgDl5PfhdKEJKr5LO+lhVBkWEjbl81PvgxxWJBC1s3Iwu
	XpCfVy/Cic0bgqmliM97U1zx1XV9E6G1jm+Z9m5rq5wttg9K3MDM3v4Bp3r5Oogaw==
X-Google-Smtp-Source: AGHT+IHmji/NlhW6PAvhLcBhuxCxYDetKytLXU6htY+yIaqQpm+gV+XdE8J9vax0xtcHo5/qC5bhqV9GxA4x
X-Received: by 2002:a05:6000:4189:b0:382:40ad:44b2 with SMTP id ffacd0b85a97d-38260b8b4a4mr1324154f8f.34.1732264925767;
        Fri, 22 Nov 2024 00:42:05 -0800 (PST)
Received: from raspberrypi.com ([93.93.133.154])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-433cde98a88sm1124745e9.36.2024.11.22.00.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 00:42:05 -0800 (PST)
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
Subject: [PATCH v1 4/5] drivers: media: bcm2835-unicam: Fix for possible dummy buffer overrun
Date: Fri, 22 Nov 2024 08:41:51 +0000
Message-Id: <20241122084152.1841419-5-naush@raspberrypi.com>
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

The Unicam hardware has been observed to cause a buffer overrun when
using the dummy buffer as a circular buffer. The conditions that cause
the overrun are not fully known, but it seems to occur when the memory
bus is heavily loaded.

To avoid the overrun, program the hardware with a buffer size of 0 when
using the dummy buffer. This will cause overrun into the allocated dummy
buffer, but avoid out of bounds writes.

Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
---
 drivers/media/platform/broadcom/bcm2835-unicam.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/broadcom/bcm2835-unicam.c b/drivers/media/platform/broadcom/bcm2835-unicam.c
index 550eb1b064f1..f10064107d54 100644
--- a/drivers/media/platform/broadcom/bcm2835-unicam.c
+++ b/drivers/media/platform/broadcom/bcm2835-unicam.c
@@ -640,7 +640,14 @@ static inline void unicam_reg_write_field(struct unicam_device *unicam, u32 offs
 static void unicam_wr_dma_addr(struct unicam_node *node,
 			       struct unicam_buffer *buf)
 {
-	dma_addr_t endaddr = buf->dma_addr + buf->size;
+	/*
+	 * Due to a HW bug causing buffer overruns in circular buffer mode under
+	 * certain (not yet fully known) conditions, the dummy buffer allocation
+	 * is set to a a single page size, but the hardware gets programmed with
+	 * a buffer size of 0.
+	 */
+	dma_addr_t endaddr = buf->dma_addr +
+			     (buf != &node->dummy_buf ? buf->size : 0);
 
 	if (node->id == UNICAM_IMAGE_NODE) {
 		unicam_reg_write(node->dev, UNICAM_IBSA0, buf->dma_addr);
-- 
2.34.1


