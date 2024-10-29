Return-Path: <linux-kernel+bounces-386536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275249B44BC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC605283BDA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEA4205151;
	Tue, 29 Oct 2024 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eCzuHOiV"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72878204084
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191587; cv=none; b=FP8suh9TkNy34kLjO4HRos5qrb2qQsgHzo75n6Xnzn6rLTRJt+qIjodxwuUpx1dFDXBSJKW3IcKrMw5RrfjIanDVwoljIeqJTCYY7O0lKFNmNLolbe+49wPu9c97W/Iu9cwRs98ik+viNzqmkHGTpm3kS8bYAoXOamQcmKTdLxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191587; c=relaxed/simple;
	bh=7jZErEgYAUH8xk9j5Uoe+tHYPD+nw3TS+qHbiMcKb80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nx9kJ1m7XQ80H8SCife4cLWVlT4dvXJn4f5rBqMo/wGnnuuHoiDv6RT29EWQDxFwcCTQjq/0Wrf30DirGnLwIBVOJgFXTe/idMZM0hhrGUjya5jp1DDrrPC5oknlzVFwmAp3yA1R1nnZVhZo8VUFEi3nCvBJATBpJSBVTE+1x/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=eCzuHOiV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a93c1cc74fdso727452566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730191584; x=1730796384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDcquMlQbBV3XN4Io8qW6xdqDAgSIub1vLoIuhz6Z10=;
        b=eCzuHOiVtY2ZJD4owOG5zMGPhLDlJK3w008p7yR+ZGSJYLK19d5O+ylnP5iij8uGLX
         6nfWFoDmDmPT6cX8Qv/YIxbRIrM6uw1EsXPp9rIvp83RY/30wu0MSmd/J1NsqM4q3YaR
         au2CeflwBhByh/bIP3kdmyU9ERTonRhuUnlfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191584; x=1730796384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDcquMlQbBV3XN4Io8qW6xdqDAgSIub1vLoIuhz6Z10=;
        b=whho/R1H6qJbv3Nl4lALshypbenrhJweA/w5gw2HgX/TCmm0vFtUAe5rt8MWUEFz6U
         tvzF+nUYu14RC6crMEbjZJpSbrmeQO3vclTIEeCNbnonPdnGf2U3SEXtr8xAV3gYPdQX
         EjDubfG681Wt0Rsiox4IHhdtUc0sUUuw6jyCPngk9keWZeO0M6pZ1yk3cyKAR0POPOwq
         NFDcvxF6w8SFRcOzCfnd9UGh2amz2OfNLhjGCNEFggt/eFCCYigtNha8OJ/c30wA+Va8
         5hcB4bdMteDi6z/XZQiucZu3djlJlUgtO/y5+vMWc92OIGZWjdNOhlElBAOvGuIyo1x3
         Yqmw==
X-Gm-Message-State: AOJu0YxQBj/mhRqgHQA94l7DbjWZLx7EFjQ7RdX0AUtpDXtfAQ+HtHOl
	VoxMaKM2/pCFwvauuxdPnG2mVRw7jjH0NRrXirMVQe/Vr05Hs4/pmJArO+y5Wx3xt72pGmqUb6a
	i
X-Google-Smtp-Source: AGHT+IGQHk3b2V3qEBkaWlzGQYJYEEX9sbx1ZZHVJ7DYIM2F1SK1zV1W2kZaoYuPp8TXT2xduyix0A==
X-Received: by 2002:a17:906:c10d:b0:a9a:37fe:e7d0 with SMTP id a640c23a62f3a-a9de6199186mr1046662666b.64.1730191583525;
        Tue, 29 Oct 2024 01:46:23 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-68-117.business.telecomitalia.it. [79.40.68.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7dacsm450134166b.9.2024.10.29.01.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:46:23 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Simon Horman <horms@kernel.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v2 1/6] can: dev: add generic function can_update_bus_error_stats()
Date: Tue, 29 Oct 2024 09:44:45 +0100
Message-ID: <20241029084525.2858224-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029084525.2858224-1-dario.binacchi@amarulasolutions.com>
References: <20241029084525.2858224-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v1)

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


