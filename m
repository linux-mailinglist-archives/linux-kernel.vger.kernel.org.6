Return-Path: <linux-kernel+bounces-386848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B2A9B489A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC8F1F23986
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5971E206E7E;
	Tue, 29 Oct 2024 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qevd+j0V"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98B220695B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202402; cv=none; b=u9tPEinvxcnmHmjc49/yZYlBeMycLtR754kw1xY/TbG3iu+agj8xnahH2rFM1V64kOKPAW4cpbu8AWHeCMoWQDfyNGy0RWx++MiEaSSgPCI2anmXpmcDslbfxiyBrnExQef2l6UV6IrXySwOzAvPrme8tib/QqXBnlxIJCAMZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202402; c=relaxed/simple;
	bh=zGQNeCdJfkEacQEWhKkyV5Ry31CnGCgUtEGDHPY8Ta4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaObVe1ReM3UWQdTnH3J5ex0OAHxyzjM5PsGnfcSsY7Q2UHayiSFk9a7Eq5RS8pgTZytUtWRWdtboBftg/oOO3PnwquhWeNTkYTlqIywad5ZOWIt6e7EY5VkohpfcnrmY0MUxb70ApNslegFJEXKF69JePfKJ9FVDrtzial9Sb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=qevd+j0V; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso6385079a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730202399; x=1730807199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7zf1SxmTLYYJKdIBWggPPFkkyvCdLLyYv8BJT477vU=;
        b=qevd+j0VfLZCBEtrY68CFWvqnI32U6jQGkuFLKhVohrN3u084HFOk7u3latWqJPE9p
         fktwG9TBisZm1INugFL94ydvswjdNbATutcprpDWO1Y56BqNpn438CDkFXonvqxV5Bua
         r8spWVhzbICqRQ5hxfZYo1S/f/+P/6gduESLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202399; x=1730807199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7zf1SxmTLYYJKdIBWggPPFkkyvCdLLyYv8BJT477vU=;
        b=O4lzHs3LRB75+brDpYGWKMwQFYxJQt3HRHpmCSOfZNnSZy3qADMY8O5gtLBo2eaVzN
         ZDeDtCEFlN5b9v9CNZSiibjGJ8AbRn2Sq+AWDXSz5B96VyCY3uvuY0nN9+X2fCb978eJ
         dMo1q508v+wedKhSWGChvQvFDxC/R5OEp1qS42pBxBth+CpdKXvm+1dDxEq5dNN4CYjO
         UKeOKkdOoLZhb0OBcef1RXUYA2JtBl3sBmR2WcMJogEIHMeSFl3Nvbs8OBG+RrJNokHD
         rv6m8wD0oFHaiwj7YHGcbj7dSTRpDoCn50+mUP8v5A5xcqXXsDEviKlu+q0w8Hasn8VB
         X6KQ==
X-Gm-Message-State: AOJu0Yzb1BUdCOKRerGSFkb5tUnVxjZNwodx3xpH7fl/+wcLWzxlpftp
	eQ1HR+e88/MpevZP0hGtF30tEkpKmJLPRSmsx4QkDJiFUjlL8jiIwxkXrEapeIrRuXZDuC2dXk2
	L/mA=
X-Google-Smtp-Source: AGHT+IFQPjRGEu5AzAkALhjbGjgLzCygsqqvVu/v3wZnXp+FNxqihXgz0zlaCUYVkgQ0pA+esg6IPw==
X-Received: by 2002:a05:6402:40d5:b0:5c9:4022:872d with SMTP id 4fb4d7f45d1cf-5cbbfa66f3dmr9918447a12.32.1730202398864;
        Tue, 29 Oct 2024 04:46:38 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.41.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6297a09sm3869301a12.21.2024.10.29.04.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:46:38 -0700 (PDT)
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
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v3 6/6] can: dev: update the error types stats (ack, CRC, form, ...)
Date: Tue, 29 Oct 2024 12:45:30 +0100
Message-ID: <20241029114622.2989827-7-dario.binacchi@amarulasolutions.com>
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

The patch modifies can_update_bus_error_stats() by also updating the
counters related to the types of CAN errors.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v1)

 drivers/net/can/dev/dev.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 4ad0698b0a74..ed2bdc6fe4a1 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -27,16 +27,31 @@ void can_update_bus_error_stats(struct net_device *dev, struct can_frame *cf)
 	priv = netdev_priv(dev);
 	priv->can_stats.bus_error++;
 
-	if ((cf->can_id & CAN_ERR_ACK) && cf->data[3] == CAN_ERR_PROT_LOC_ACK)
+	if ((cf->can_id & CAN_ERR_ACK) && cf->data[3] == CAN_ERR_PROT_LOC_ACK) {
+		priv->can_stats.ack_error++;
 		tx_errors = true;
-	else if (cf->data[2] & (CAN_ERR_PROT_BIT1 | CAN_ERR_PROT_BIT0))
+	}
+
+	if (cf->data[2] & (CAN_ERR_PROT_BIT1 | CAN_ERR_PROT_BIT0)) {
+		priv->can_stats.bit_error++;
 		tx_errors = true;
+	}
 
-	if (cf->data[2] & (CAN_ERR_PROT_FORM | CAN_ERR_PROT_STUFF))
+	if (cf->data[2] & CAN_ERR_PROT_FORM) {
+		priv->can_stats.form_error++;
 		rx_errors = true;
-	else if ((cf->data[2] & CAN_ERR_PROT_BIT) &&
-		 (cf->data[3] == CAN_ERR_PROT_LOC_CRC_SEQ))
+	}
+
+	if (cf->data[2] & CAN_ERR_PROT_STUFF) {
+		priv->can_stats.stuff_error++;
 		rx_errors = true;
+	}
+
+	if ((cf->data[2] & CAN_ERR_PROT_BIT) &&
+	    cf->data[3] == CAN_ERR_PROT_LOC_CRC_SEQ) {
+		priv->can_stats.crc_error++;
+		rx_errors = true;
+	}
 
 	if (rx_errors)
 		dev->stats.rx_errors++;
-- 
2.43.0


