Return-Path: <linux-kernel+bounces-364323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A3199D279
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F54CB26A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275BA1C174A;
	Mon, 14 Oct 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jb4S/I5q"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE611B85D0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919487; cv=none; b=dyB+MHzXqoZ+SUIRcO0cJZYEqgc97MzDJOzeAcR6/XAsqult+CoOG08tchT/xgMwb9+uBe9Ui6vuP4okXV6fj5W68jLRQwtL8ZCQbm15bwo++UKbjGyIZ6Cg+av8TV7spAy1rXKZcJ45bB9kXpiovuInsuIr7AvNQtiGDGAoFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919487; c=relaxed/simple;
	bh=0ONmNV9vzQUGV6frLDhiV8OgSXVkIdlWsYOsJ1KXX2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiO9x/lynT0KbrL+bYs7SaCKaDrPmaoIlLmxF8fUcB1CsNIv7dHwzaKB0Il9YsxB+Y8eU8sBMt+mXHEPpnGSGQkHX25vHkfr7A4Woyf8n5blJYquSnT32lScauc21HPLJrN7darhozT7+HASPvjVmDzRnxbQLMF5QSianF5TurI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=jb4S/I5q; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so1051656f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1728919484; x=1729524284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvkSVt8VpmX4gMY6ZJ043PHdZhz1ZoH+BaE3ci1zs5w=;
        b=jb4S/I5qA15TE/GGPwwMJJXd50/byw1rJtxglFwKu9RHDaybS95MZ09NjSNhnPz2v3
         CPPkaff1xzcm38hPUdrbdWgn781pvIv7OK35wCvihD0REI3mJDNIfzSIBJNInQQp4kSv
         MRQcMVNqhKWYlYfw7e6HOHEhMi7ghjZ9BI0h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919484; x=1729524284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvkSVt8VpmX4gMY6ZJ043PHdZhz1ZoH+BaE3ci1zs5w=;
        b=UwN1dH8QaPvSKDuZXmbdGhwixTK53+++FMEjJvF1Xdzcupd8WZyK+uVp4L77zkJMIE
         BVzRvaZq3Xi62LwC7t+6Hrj1s3EgS7kiBFAaLE5nC8yWpiSGmXi9zaCqP5njy1FdGFtr
         oZH+qA4he+1Io3+p0gmS4zQz7P7wcoLz4YrsrAJlN2fAMYgwoGgszCOE0EMbIeFDVJW/
         aEg8As3dda7snAUiJb0r7YJe72+OMl12LsY3Gos6LWOOsT50gWkbf7YEETFxfdIUwcQ0
         crf0DjnvVckpMFtpuHIlNs4ydZ5ujYnPnMbje7SIr2hztYyBN/IYgmWywuvEFvis1dVp
         Kriw==
X-Gm-Message-State: AOJu0YyAzk8Qx2vquwNGM1PhqII7hHRwnW/x0ZUc7mnaXDxoCKNcVk42
	ij0Xd8GoGxnTvByKHyHWyQdnFYzGzyWq1YB10NANpa4GXbG4ox//CZoT3/GNhajya6zvE5Rb6Ar
	ImHI=
X-Google-Smtp-Source: AGHT+IGU6W/9rfcwX33740fJ/ldX1KMdmDVw4ohUw0JiVPbpOmH7KL8veexmd93cyiyKKuklxb5y8Q==
X-Received: by 2002:adf:e88b:0:b0:37d:4cd6:6f2b with SMTP id ffacd0b85a97d-37d551d2566mr7314184f8f.14.1728919483907;
        Mon, 14 Oct 2024 08:24:43 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.40.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd1b7sm11629911f8f.37.2024.10.14.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:24:43 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH 1/6] can: dev: add generic function can_update_bus_error_stats()
Date: Mon, 14 Oct 2024 17:24:16 +0200
Message-ID: <20241014152431.2045377-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
References: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function aims to generalize the statistics update by centralizing
the related code, thus avoiding code duplication.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/dev/dev.c | 30 ++++++++++++++++++++++++++++++
 include/linux/can/dev.h   |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 6792c14fd7eb..0a3b1aad405b 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -16,6 +16,36 @@
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
 
+void can_update_bus_error_stats(struct net_device *dev, struct can_frame *cf)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	bool rx_errors = false, tx_errors = false;
+
+	if (!cf || !(cf->can_id & (CAN_ERR_PROT | CAN_ERR_BUSERROR)))
+		return;
+
+	priv = netdev_priv(dev);
+	priv->can_stats.bus_error++;
+
+	if ((cf->can_id & CAN_ERR_ACK) && cf->data[3] == CAN_ERR_PROT_LOC_ACK)
+		tx_errors = true;
+	else if (cf->data[2] & (CAN_ERR_PROT_BIT1 | CAN_ERR_PROT_BIT0))
+		tx_errors = true;
+
+	if (cf->data[2] & (CAN_ERR_PROT_FORM | CAN_ERR_PROT_STUFF))
+		rx_errors = true;
+	else if ((cf->data[2] & CAN_ERR_PROT_BIT) &&
+		 (cf->data[3] == CAN_ERR_PROT_LOC_CRC_SEQ))
+		rx_errors = true;
+
+	if (rx_errors)
+		dev->stats.rx_errors++;
+
+	if (tx_errors)
+		dev->stats.tx_errors++;
+}
+EXPORT_SYMBOL_GPL(can_update_bus_error_stats);
+
 static void can_update_state_error_stats(struct net_device *dev,
 					 enum can_state new_state)
 {
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 23492213ea35..0977656b366d 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -201,6 +201,7 @@ void can_state_get_by_berr_counter(const struct net_device *dev,
 				   enum can_state *rx_state);
 void can_change_state(struct net_device *dev, struct can_frame *cf,
 		      enum can_state tx_state, enum can_state rx_state);
+void can_update_bus_error_stats(struct net_device *dev, struct can_frame *cf);
 
 #ifdef CONFIG_OF
 void of_can_transceiver(struct net_device *dev);
-- 
2.43.0


