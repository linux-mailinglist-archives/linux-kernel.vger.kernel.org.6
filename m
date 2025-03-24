Return-Path: <linux-kernel+bounces-573647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B66A6DA2B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1B851890840
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E6625E838;
	Mon, 24 Mar 2025 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Js2URNhs"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B787D25E820
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819753; cv=none; b=raadxlSxWLxAXoLk8fzYS95VX75S7iFgzcxMEYc4Mr59UCX2E0Dzy7VufAvrfp8HA6eDUjt0fS/h75vAcQuHJ59hjrxMNF9LQqoMQg3y33YQV8z0Wnnf9WY+ZJwYGNFWlgsT2mcP4FJqNnIY10cFKJpq0hwgRJP5f4649xwbRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819753; c=relaxed/simple;
	bh=X6emEjjOC84f7qnPUA7wy2KchrGlNUKQIwcPa5RYZG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b0/Gjgnorc7p1hG3tU2IErS1zTstgVAreAplgWymWOO4ORph9iW/mrdkefYSjBE0L0ziJ3auPBSOfNr4dlj054exAR4icAVS49/kNo0mYv//GPg7vHaM+dGwVo2f0+TS+3llFNAMBWV+BuJ9XTgTGVRjTxC+9GDq7CdC8X+s6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Js2URNhs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so41800325e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742819750; x=1743424550; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kl0vq5f5Bgwa1+0jsPX3lqnJG3p+rwJSH8N6lbEnisE=;
        b=Js2URNhsN1vrVCVkY4N9pn1DDtpFM8BBcmK0zqrc+rxejbXhTlDAjyspTJnl56/6zy
         lC9y2M+VJESdBQrHn8PwLtgkqEvef1UJVBCcpWeHIv8ApZPBDfxlZJxWkV5fVVi4vFsm
         ZMtDkEdL25AyDy1eBibIlarhxOreIo80X34rGtpNw3oQdWuqrwmcpXep6C9WVT+YgACC
         DwwJ1THyYbc2kp7WqcWF29HbMFHF7F+Kce96ar20qj9LGkjNRXwHGvMsu7TZCIZaEMp0
         8JhKt1Lta/05VFYRq2V0HG1bfyw0RLyQqf2PqeOac2JK+hP93cvYgZUhmhGi0RR+f9Gl
         wDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742819750; x=1743424550;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kl0vq5f5Bgwa1+0jsPX3lqnJG3p+rwJSH8N6lbEnisE=;
        b=U0EM/BnT9zqu4VJhDUsPOTEXCt0ZajqBjZd/KfiD8qy8XEatG/Zya418vjcXrF0RNt
         qXEH74DL5uKcTYm/ZojpJYKIbGYoErmh1a8d+lHaDrO4R8ra8QOiwjyZlyOIQHnyQbJx
         aioN49nZnldmRgi/PzK5LfUsvpmDWCnUHEn31Yte4Vx8Ccy8wAO29ZpQ/mtKbt9HdcJx
         9yweHYtHxgldB11sZIFrWddxgm/MlsCqvhh4aSKhbDfHhe03vUP14bn30X5O1siXF9na
         Dt4SUuDjEyQg04+IpiWDRw87EAfIjVoNgCbnRu860y/ieh3vHT0m+inD75NbICOP8Ce8
         dUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoW9mrw/p6HtMV7LwDvOhtZTPu66/M2PbbOBq/ZgvRV5TRcO9i67R2j+0bBKIhOkMaXab0aHUGPklFYcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKAwBYhPaJw0tVmAU/WlvvvmJLoGGfTpe6Xk6RG6CxRdBTHAG
	uOmho2KjL3hIHzixGYofLmucmrPgHmFVL0Ef26SFYP10kIE8La5PXSaIuTgEO50=
X-Gm-Gg: ASbGncuaddFbHe13Aq12+T41L3LMGMTpGJk6xrdUvFnO0qMbTbOP9SJo6B1+Xc6Qdrl
	zwW0E8ca00A9q0t7hq/e0N4q4+Madt2UQl45iLYxUk81GFXI+dRquI45zoHwkWMPU+Ssdjl8z4r
	SKrfxv37+amasH86G9uuLTFOFeWqgK8WYIWoKFxU7sZrnGzWtT/sF2m6B3dJToKxXlqYAXhjpFU
	S7gq25I4JDrcf5Q7lS1LFYv7aDLAe34hzt8IjVDVLfF5+S0QtvRCDa7HMI0MurAem/tdFcr9Hsm
	Tq18ySY159D0Iy0Ph8aY91FdVbZOgDbyc11/A7yJG0SbwVcGId26Y+SVjozURvB/WlSmcYp454R
	W/cGKUaDulM69r/4uHuPYhA7F
X-Google-Smtp-Source: AGHT+IG32wDy5/n84lFCxKwj9TquwTcP2buF+V75/lhHb+aISrySpFsEMSBsH5is09m5p/OOqaNbPw==
X-Received: by 2002:a05:600c:3c82:b0:43d:45a:8fbb with SMTP id 5b1f17b1804b1-43d50a1d1ebmr97951375e9.22.1742819749950;
        Mon, 24 Mar 2025 05:35:49 -0700 (PDT)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d3adc4488sm129419705e9.0.2025.03.24.05.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:35:49 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 24 Mar 2025 12:35:41 +0000
Subject: [PATCH] firmware: exynos-acpm: check saved RX before bailing out
 on empty RX queue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250324-acpm-drained-rx-queue-v1-1-577774335151@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJ1R4WcC/x3MOw6DQAxF0a0g17EEw6fIVqIUE/sBLpgQj0BIi
 L1nRHmKe0/KcEOmZ3WSY7ds31TQPCqSOaYJbFpMoQ593YaOo6wLq0dLUPaDfxs2MKRtBu3kIzp
 SaVfHaMf9fb2v6w8bGW4YZwAAAA==
X-Change-ID: 20250324-acpm-drained-rx-queue-ec316d4cbcdf
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742819749; l=3482;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=X6emEjjOC84f7qnPUA7wy2KchrGlNUKQIwcPa5RYZG4=;
 b=kmHuU8CHmjzA1eAgD8L77QQize35cLsSbdu7YXj0dYope2hTdkDdMQ/9byA+NXJFlyS62axcW
 MhXJ6fcZRj9A4EMb1rYbJ2soVBDODa7JBDCt69HAZc5vAxVsfXcFwF/
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

When we're polling for responses and get a response that corresponds to
another request, we save the RX data in order to drain the RX queue.

If the response for the current request is not found in the request's
iteration of the queue, or if the queue is empty, we must check whether
the RX data was saved by a previous request when it drained the RX queue.

We failed to check for already saved responses when the queue was empty,
and requests could time out. Check saved RX before bailing out on empty
RX queue.

Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Reported-by: André Draszik <andre.draszik@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
on top of krzk/for-next
---
 drivers/firmware/samsung/exynos-acpm.c | 44 +++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index a85b2dbdd9f0d7b1f327f54a0a283e4f32587a98..15e991b99f5a384a299c1baf6b279fc93244bcf2 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -184,6 +184,29 @@ struct acpm_match_data {
 #define client_to_acpm_chan(c) container_of(c, struct acpm_chan, cl)
 #define handle_to_acpm_info(h) container_of(h, struct acpm_info, handle)
 
+/**
+ * acpm_get_saved_rx() - get the response if it was already saved.
+ * @achan:	ACPM channel info.
+ * @xfer:	reference to the transfer to get response for.
+ * @tx_seqnum:	xfer TX sequence number.
+ */
+static void acpm_get_saved_rx(struct acpm_chan *achan,
+			      const struct acpm_xfer *xfer, u32 tx_seqnum)
+{
+	const struct acpm_rx_data *rx_data = &achan->rx_data[tx_seqnum - 1];
+	u32 rx_seqnum;
+
+	if (!rx_data->response)
+		return;
+
+	rx_seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, rx_data->cmd[0]);
+
+	if (rx_seqnum == tx_seqnum) {
+		memcpy(xfer->rxd, rx_data->cmd, xfer->rxlen);
+		clear_bit(rx_seqnum - 1, achan->bitmap_seqnum);
+	}
+}
+
 /**
  * acpm_get_rx() - get response from RX queue.
  * @achan:	ACPM channel info.
@@ -204,15 +227,16 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 	rx_front = readl(achan->rx.front);
 	i = readl(achan->rx.rear);
 
-	/* Bail out if RX is empty. */
-	if (i == rx_front)
+	tx_seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, xfer->txd[0]);
+
+	if (i == rx_front) {
+		acpm_get_saved_rx(achan, xfer, tx_seqnum);
 		return 0;
+	}
 
 	base = achan->rx.base;
 	mlen = achan->mlen;
 
-	tx_seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM, xfer->txd[0]);
-
 	/* Drain RX queue. */
 	do {
 		/* Read RX seqnum. */
@@ -259,16 +283,8 @@ static int acpm_get_rx(struct acpm_chan *achan, const struct acpm_xfer *xfer)
 	 * If the response was not in this iteration of the queue, check if the
 	 * RX data was previously saved.
 	 */
-	rx_data = &achan->rx_data[tx_seqnum - 1];
-	if (!rx_set && rx_data->response) {
-		rx_seqnum = FIELD_GET(ACPM_PROTOCOL_SEQNUM,
-				      rx_data->cmd[0]);
-
-		if (rx_seqnum == tx_seqnum) {
-			memcpy(xfer->rxd, rx_data->cmd, xfer->rxlen);
-			clear_bit(rx_seqnum - 1, achan->bitmap_seqnum);
-		}
-	}
+	if (!rx_set)
+		acpm_get_saved_rx(achan, xfer, tx_seqnum);
 
 	return 0;
 }

---
base-commit: f0dbe0d40d08199109cb689849877694a8b91033
change-id: 20250324-acpm-drained-rx-queue-ec316d4cbcdf

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


