Return-Path: <linux-kernel+bounces-305684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A097B9632BF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A961C229ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960E71AE040;
	Wed, 28 Aug 2024 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyGgxMy7"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5815A85A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877776; cv=none; b=MgNg8raD2np7HbqRwTDUnc76qUl+vXya6w49xMx8rl5RX2Gmqe1XeZu6i/N50/bNqV5tHL7RMOtQ6A8u8wQTcmTTECvc8UVofAFIe7xoZUjEzqJkOpRpvAQTwPgKixRsB2GqpKH3ZAUJb9puicytCpvEnaJlNbDWGI18SkHpJOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877776; c=relaxed/simple;
	bh=Frq+3epul76UcmI0rbsR3svObXHfjBsgRLpnibMuogA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQ443OorjzfvgH7UfgaPVMvvfpLlLRauXB9bT0U1eq+kSawsoGOBaVUoeeOxMjf/nZoiYIl/Vvf8CAS4jAoLxeEOStkz6Msj+VolLUVhV2pxYoQt5/4HD2ughcc1IRUB+b4u6dPbaQRdIw6FjTElA1UUaPxY90xCXTPCkAdlUpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyGgxMy7; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd967d8234so4386152a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724877774; x=1725482574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FjEx5tdv3nZVwlNmoE8bfgVqDsNw3yY97eVIqJ09dVA=;
        b=ZyGgxMy7fMoj+OmIQj/WsfpxVRTt/rkwye8aNqu4W8y+aF5VO52EsW62Td5HjaQ2bJ
         M+l38vtRJdsfNn4nB9hHmYagnDed+Mvfi6Vcc4x2zFEJEbKckiOGuJFLfeffG9oqmsAW
         5Gty+JontgkiB98OhwfpPpDofjRF6PBti49d9wSjqjF7Kilqr9899Keh7PLOrWLU9ied
         1vvtVmUBxprU9jj3pRP9t4TuJH7pFlszShgclErnXq8Xu94zhTRdCv16U2dNYKMrItCm
         nTc9vR+xkrW0PmMNl5d18cL/6LoqRUgKIgLFDo81M6CAi/f84h0VXRYlcRdkOBtuP2M1
         p4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724877774; x=1725482574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjEx5tdv3nZVwlNmoE8bfgVqDsNw3yY97eVIqJ09dVA=;
        b=InIIyH5JVNvO7Xr21qxCxh2LG1Hvyq0779I2NV4+08ahYDrAQlAgw40T4isib9FRVK
         eNTJPXwwoihrNvKQQ7rYs3YTd3dPNwew4oH22s6q2N7b864SlaODgaDRnzCGThYdkt3M
         DIzaySNwS/oZoV1jLeLlaEhTOljAGV5w0mu9RQveUtRDLwnpMUNnV8uFh95ua2m/p4mU
         xrBg3cbQuo2z17TeY+51GO2/elPS0k94TPDNLNR/X2Hvuf8ig/v/uRJacX3sPUceMO+y
         02URQbfQHL6JVKDMNJna3AYm4YqbZK7awmLh22AJzFxSFWGQVXZCpyTh1ccmiqI/VspL
         tMFw==
X-Forwarded-Encrypted: i=1; AJvYcCXz1BQvVpbWSJTzmhaKV3rM9iIZUaMY5W+bgnvbzhlMewNc8Ug9EeSj0Jlmz942mZW/8jS9j53lfXjbiEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgQVNdKKAbbf1uBNRWoAVoFhPoZ6Eu5dsNpmThYRNMjqrgGWK7
	ntu2B0+JkvtRoBpW3cBGA/hm4GW0xTGm2mh/2GRknVd6CxZai014rUxSpw==
X-Google-Smtp-Source: AGHT+IHb3N/IUBj7gHtopGAwdUeYWifspln/GnUSvIM5JMBR8zK6kc8GyHGEEuUExcswXqV9G7t+AQ==
X-Received: by 2002:a05:6a21:6b0a:b0:1cc:d73a:9408 with SMTP id adf61e73a8af0-1cce103ac01mr553546637.31.1724877774288;
        Wed, 28 Aug 2024 13:42:54 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e0a3fsm10528870b3a.109.2024.08.28.13.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:42:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: 
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next] net: ag71xx: update FIFO bits and descriptions
Date: Wed, 28 Aug 2024 13:42:49 -0700
Message-ID: <20240828204251.6642-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Taken from QCA SDK. No functional difference as same bits get applied.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 48 +++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 5ef76f3d3f1a..0674a042e8d3 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -149,11 +149,11 @@
 #define FIFO_CFG4_MC		BIT(8)	/* Multicast Packet */
 #define FIFO_CFG4_BC		BIT(9)	/* Broadcast Packet */
 #define FIFO_CFG4_DR		BIT(10)	/* Dribble */
-#define FIFO_CFG4_LE		BIT(11)	/* Long Event */
-#define FIFO_CFG4_CF		BIT(12)	/* Control Frame */
-#define FIFO_CFG4_PF		BIT(13)	/* Pause Frame */
-#define FIFO_CFG4_UO		BIT(14)	/* Unsupported Opcode */
-#define FIFO_CFG4_VT		BIT(15)	/* VLAN tag detected */
+#define FIFO_CFG4_CF		BIT(11)	/* Control Frame */
+#define FIFO_CFG4_PF		BIT(12)	/* Pause Frame */
+#define FIFO_CFG4_UO		BIT(13)	/* Unsupported Opcode */
+#define FIFO_CFG4_VT		BIT(14)	/* VLAN tag detected */
+#define FIFO_CFG4_LE		BIT(15)	/* Long Event */
 #define FIFO_CFG4_FT		BIT(16)	/* Frame Truncated */
 #define FIFO_CFG4_UC		BIT(17)	/* Unicast Packet */
 #define FIFO_CFG4_INIT	(FIFO_CFG4_DE | FIFO_CFG4_DV | FIFO_CFG4_FC | \
@@ -168,28 +168,28 @@
 #define FIFO_CFG5_DV		BIT(1)	/* RX_DV Event */
 #define FIFO_CFG5_FC		BIT(2)	/* False Carrier */
 #define FIFO_CFG5_CE		BIT(3)	/* Code Error */
-#define FIFO_CFG5_LM		BIT(4)	/* Length Mismatch */
-#define FIFO_CFG5_LO		BIT(5)	/* Length Out of Range */
-#define FIFO_CFG5_OK		BIT(6)	/* Packet is OK */
-#define FIFO_CFG5_MC		BIT(7)	/* Multicast Packet */
-#define FIFO_CFG5_BC		BIT(8)	/* Broadcast Packet */
-#define FIFO_CFG5_DR		BIT(9)	/* Dribble */
-#define FIFO_CFG5_CF		BIT(10)	/* Control Frame */
-#define FIFO_CFG5_PF		BIT(11)	/* Pause Frame */
-#define FIFO_CFG5_UO		BIT(12)	/* Unsupported Opcode */
-#define FIFO_CFG5_VT		BIT(13)	/* VLAN tag detected */
-#define FIFO_CFG5_LE		BIT(14)	/* Long Event */
-#define FIFO_CFG5_FT		BIT(15)	/* Frame Truncated */
-#define FIFO_CFG5_16		BIT(16)	/* unknown */
-#define FIFO_CFG5_17		BIT(17)	/* unknown */
+#define FIFO_CFG5_CR		BIT(4)  /* CRC error */
+#define FIFO_CFG5_LM		BIT(5)	/* Length Mismatch */
+#define FIFO_CFG5_LO		BIT(6)	/* Length Out of Range */
+#define FIFO_CFG5_OK		BIT(7)	/* Packet is OK */
+#define FIFO_CFG5_MC		BIT(8)	/* Multicast Packet */
+#define FIFO_CFG5_BC		BIT(9)	/* Broadcast Packet */
+#define FIFO_CFG5_DR		BIT(10)	/* Dribble */
+#define FIFO_CFG5_CF		BIT(11)	/* Control Frame */
+#define FIFO_CFG5_PF		BIT(12)	/* Pause Frame */
+#define FIFO_CFG5_UO		BIT(13)	/* Unsupported Opcode */
+#define FIFO_CFG5_VT		BIT(14)	/* VLAN tag detected */
+#define FIFO_CFG5_LE		BIT(15)	/* Long Event */
+#define FIFO_CFG5_FT		BIT(16)	/* Frame Truncated */
+#define FIFO_CFG5_UC		BIT(17)	/* Unicast Packet */
 #define FIFO_CFG5_SF		BIT(18)	/* Short Frame */
 #define FIFO_CFG5_BM		BIT(19)	/* Byte Mode */
 #define FIFO_CFG5_INIT	(FIFO_CFG5_DE | FIFO_CFG5_DV | FIFO_CFG5_FC | \
-			 FIFO_CFG5_CE | FIFO_CFG5_LO | FIFO_CFG5_OK | \
-			 FIFO_CFG5_MC | FIFO_CFG5_BC | FIFO_CFG5_DR | \
-			 FIFO_CFG5_CF | FIFO_CFG5_PF | FIFO_CFG5_VT | \
-			 FIFO_CFG5_LE | FIFO_CFG5_FT | FIFO_CFG5_16 | \
-			 FIFO_CFG5_17 | FIFO_CFG5_SF)
+			 FIFO_CFG5_CE | FIFO_CFG5_LM | FIFO_CFG5_L0 | \
+			 FIFO_CFG5_OK | FIFO_CFG5_MC | FIFO_CFG5_BC | \
+			 FIFO_CFG5_DR | FIFO_CFG5_CF | FIFO_CFG5_UO | \
+			 FIFO_CFG5_VT | FIFO_CFG5_LE | FIFO_CFG5_FT | \
+			 FIFO_CFG5_UC | FIFO_CFG5_SF)
 
 #define AG71XX_REG_TX_CTRL	0x0180
 #define TX_CTRL_TXE		BIT(0)	/* Tx Enable */
-- 
2.46.0


