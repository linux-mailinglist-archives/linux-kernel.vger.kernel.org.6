Return-Path: <linux-kernel+bounces-386846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6339B4895
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615001F238F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47746206073;
	Tue, 29 Oct 2024 11:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PinnH299"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7720604C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202398; cv=none; b=h8mJjfHw9d743a3msZop6uGL1k4MndiKDKnLfwJqV2YBzS4Da/WjEo+FKpxvys6wDdFqto2q9isd38Gz9Yek0kPXVuYg2yyZia+wWCqOQW/JwcjJTKhjMK+XOM0DSfm1i/lAqeqJ6C/JdwQuCcEIWhy4HB08z6Qk4B2OGv/PfhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202398; c=relaxed/simple;
	bh=ObcxKrOJuRTNwCOEUuw+kHKZ0OKSz2WYHmM1Yr7rSe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0hn2p7gKAacrT85WUCibpdZmcrckTe1UKicsguDTSSUq4F6x2gDnSeZmekqU/qF4nMYJLlCMJI9e3ep4ozlY8T915j0Conv985NvVmaE/LfZKLJ9jC+wXKYtwrMID0mTaXl7+8aEoydFF09A8Bx0Btaa3aKlPC6k4P7DKsfbcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=PinnH299; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so6760714a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730202395; x=1730807195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7adbskWkIDNXIMmiplteQ28nVqw9eSy+g9bzGzeRhzI=;
        b=PinnH299/uEy4TxyYXuZhDS/pn+2eH4oHGcd9XwzRb9S4mBn0goYlyuqvWoSxyR+LD
         ti7Go3C6H8l850c6IlCpeqywWGELhU12icqtX3eVBXHq9bsp1hXeNAnzBJOs1Tj/AiTZ
         5CucjPNsDO4bhRxzCDD3Scz0e76R6e9R6HAWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202395; x=1730807195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7adbskWkIDNXIMmiplteQ28nVqw9eSy+g9bzGzeRhzI=;
        b=Wr07ao0dRxFGH/I+PjpwKbK4duFLB7ff0N9JTRG9y7hvlYFHnoNAB7i8noTOIgOoLg
         mG6TetE0QovKZG27aq6GPpl1sI+77xbWnmkt4efFuu4e5fC8ojovdsAnmCCK5sKWFTJG
         fUySWHX/QRvkqMElmPNFlw7MFiR9Mc+Z69RD0WkEggx04ap1Y+YBhdC7byqyI1KYjjea
         lbH61yrRQzX6/zxC1Pj/Ba7wMaoSSpgCXo+Uzw1NjpIzbOUu48E9bvGu59UvX6JuxAFi
         3JhBBvXTuEO+7DCYsdJ2+HCqB5KJMn7pf/EDwF4MBNyHm5JzpsED6vKLbPcInLEImpy7
         CKkw==
X-Gm-Message-State: AOJu0YxD2WHevxaKTa5zVpcOvD0G8UdJDUR1k54FbkYNpCFymaJeoj10
	RiHQimesWyQYEGT28Oj3Iam4wCZX2rZjsF/xeDdZl+KhLmW/vQ09H7xIM8aNWGAPZTyO4aThBzC
	rF5E=
X-Google-Smtp-Source: AGHT+IEHZCG9S0yeWDe0PN2X2hte0+8dcnp+dlwTiRKwdv0plWgzGS6JkeJjpjq8WZy/HEjHYA/Vhw==
X-Received: by 2002:a05:6402:43cb:b0:5cb:6ca3:af96 with SMTP id 4fb4d7f45d1cf-5cbbf8acc32mr10238323a12.19.1730202394731;
        Tue, 29 Oct 2024 04:46:34 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.41.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6297a09sm3869301a12.21.2024.10.29.04.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:46:34 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Han Xu <han.xu@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v3 4/6] can: flexcan: use helpers to setup the error frame
Date: Tue, 29 Oct 2024 12:45:28 +0100
Message-ID: <20241029114622.2989827-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
References: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch replaces the code that directly accesses cf->data[] for setting
up the CAN error frame with the appropriate helpers.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v2)

Changes in v2:
- Replace the macros with static inline funcions calls.
- Update the commit message

 drivers/net/can/flexcan/flexcan-core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 790b8e162d73..85a124a31752 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -828,33 +828,31 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	if (unlikely(!skb))
 		return;
 
-	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	can_frame_error_init(cf);
 
 	if (reg_esr & FLEXCAN_ESR_BIT1_ERR) {
 		netdev_dbg(dev, "BIT1_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT1;
+		can_frame_set_err_bit1(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_BIT0_ERR) {
 		netdev_dbg(dev, "BIT0_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT0;
+		can_frame_set_err_bit0(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_ACK_ERR) {
 		netdev_dbg(dev, "ACK_ERR irq\n");
-		cf->can_id |= CAN_ERR_ACK;
-		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		can_frame_set_err_ack(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_CRC_ERR) {
 		netdev_dbg(dev, "CRC_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT;
-		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		can_frame_set_err_crc(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_FRM_ERR) {
 		netdev_dbg(dev, "FRM_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_FORM;
+		can_frame_set_err_form(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_STF_ERR) {
 		netdev_dbg(dev, "STF_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		can_frame_set_err_stuff(cf);
 	}
 
 	can_update_bus_error_stats(dev, cf);
-- 
2.43.0


