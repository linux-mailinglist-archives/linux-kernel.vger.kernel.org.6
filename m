Return-Path: <linux-kernel+bounces-223652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAB991160E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62F3EB227F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC833152E12;
	Thu, 20 Jun 2024 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nknPfNbC"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B6143746
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718924130; cv=none; b=uLiFR5K8TxqaUBbPFboTWQx14joQJVQfDnYsuaWmeyomZKBNFlZBMgtwM18vAlYuS7VrX0xNrDzdlSGMFpqbFH7pHRLkK29aNAjrt1+OuAr9LkHAnDfqad8fRunTz4jE+Kf8E6hKPHYfzKwLBhU5Uacm47c9CEvpOxRN0XzVNoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718924130; c=relaxed/simple;
	bh=42Enl7rJ+JieEa2j+TC+Pkbg3DYxAPRfCHYi64Mdal8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fGIM/piRl8uSFtQrxL5s+5Jp0lAt3KAGB7/KqH2nxbTLJNnBhww9f+dasjD1n/6HHb06z4JmZmpgaBU30f7X2XO9okBdFaXkIwBS9dk52BLyO1o5uwkPZRo5jBKgCUilJRa/qJl8ly2YwmAJElP4Ct5LQs4eUNZmAw0LG6fd28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nknPfNbC; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec4a11a297so8468161fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718924126; x=1719528926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=71+mH5Floh82G3AnJlaDTvShrwKqWGqG0Bz3hMtCxBI=;
        b=nknPfNbCjNrToZbJkCqZyksLCuMzHyZmAUfMaWJ3BwjtaQGcoNUdUavZpaZILjMuXy
         rezLd3nhIcXWTVZ00rzZzkjVa4zGfVb5tiRVtx1BboeRmGusPngKxkfY96D0DZ0I7P3X
         SMopLFdzMtSWhdBO3Xrf02BFXZZub19EqGPzwzBbrXj0YW0KsXGUGkxOa1EJMDfsZQsM
         svtYQJ+zTabd/y+xsd4lG2Bl8XfYwLsGPW1iEokTvJpnaEROIKD1RD8GHt7LXqSvUuYq
         rQMh0riQAnWQ4rnaZuVqxsbldqY+LCziefsO0OHz2276vA65F4ud0o+7na6ChjwZaCdV
         njUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718924126; x=1719528926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71+mH5Floh82G3AnJlaDTvShrwKqWGqG0Bz3hMtCxBI=;
        b=TQIanBsZ4oX9dh+nGsOfZMKny7npawJfUNPRShIWrTTNuqwDSLfIdLjIDsQN9tf7dk
         4t3apEloDDEKvk1pwgnJJti0jr564kDiGTt4FoSRWcY9Dnvo2VCldM9uPjBtA3bcFh/H
         Z2JvLu39XI+avho8O2tLY7nd3HDRn1wPpAPq2pjx6JdoMNMkhaTV++JU4H7l64S6aZ1Z
         mIahGJaPoFmItYkLP0PvxS1oyMkSHjpU4SNlb4H0DfaPkGopClh7wGxYAqGyJw+nDsjY
         S7/U2K7+6mehV8qUcicm55U8pPGA0Pj3uFFP4bti4hqO66ezPtE5k9Lv6GFgOoZpAyTK
         rEAA==
X-Forwarded-Encrypted: i=1; AJvYcCUdve8qoBDp14yhcO3a/14Inq4CAEcsk3rNwRqxFB/PchDAsYEzzhEuulZU6uLlds+eSU7qN0c4joJL4nLigPIqP0D6QiIqy4PN84ZX
X-Gm-Message-State: AOJu0YzmpSEZP39bW5lxfEn8DiohtZw/0pOnzkE0xaYaKUmBa5Uyd247
	/MwYlYlc2zpW0Dgd+DY77P/YcuKKJKxpwFwGaIga+j1iB/ZThzOyKwy/I3gFK9s=
X-Google-Smtp-Source: AGHT+IFZM+I+YtVh64S4lDZ2udWYywALAsQznYgcpbJetOLRC5X51Yoe0ZNnbkCPl3SnLSja0Yx9VQ==
X-Received: by 2002:a2e:818e:0:b0:2eb:e3a7:8b with SMTP id 38308e7fff4ca-2ec3ced134amr43741981fa.26.1718924125887;
        Thu, 20 Jun 2024 15:55:25 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d60126fsm510461fa.20.2024.06.20.15.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:55:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Jun 2024 01:55:23 +0300
Subject: [PATCH v2 4/7] usb: typec: ucsi: rework command execution
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-ucsi-rework-interface-v2-4-a399ff96bf88@linaro.org>
References: <20240621-ucsi-rework-interface-v2-0-a399ff96bf88@linaro.org>
In-Reply-To: <20240621-ucsi-rework-interface-v2-0-a399ff96bf88@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Nikita Travkin <nikita@trvn.ru>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4449;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=42Enl7rJ+JieEa2j+TC+Pkbg3DYxAPRfCHYi64Mdal8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmdLNZW1iosGP2/ESy5WgAGVEoe8PqaPXapLjv8
 Z5ef9DvoauJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZnSzWQAKCRCLPIo+Aiko
 1ccECACV/t1O7ibAb++EUfbXBQHS1BVPzE5BfW10D8XOLBh4Y71iTfBan0XZMR56o+hvJy1B9Un
 TOtp0zCUfQMQKPEUE79oVfhEP9Mm+fBKLvLx4uIyvOsEA0FpLA9kwFLUC086n/8zEsa0Llcvjib
 wFwaHncYK92DaNRJaJ6dDPUHV0jk3rdY5b2rcGbymUfniut3PZJZ0azC5ckc5SjbVI7dqS8q9N9
 dv/mNa8u9muxna9inYtyRMJrFPiAioRycDC7vtAOpkz/c5AHvWPFSzHJjilKSi28Lwyk1WQ5BJX
 rJ+TYTACbKFBmMVjJ8A655Zjq34XmFx+wIewFisYIdqB3AdQ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Rework command execution code to remove recursive calls of
ucsi_exec_command. This also streamlines the sync_control / read(CCI)
read (MESSAGE_IN) sequence, allowing further rework of the command code.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 134 ++++++++++++++++++++----------------------
 1 file changed, 64 insertions(+), 70 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 81b459b26b74..58d9602bd752 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -63,25 +63,74 @@ static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 	return ucsi->ops->sync_control(ucsi, ctrl);
 }
 
-static int ucsi_exec_command(struct ucsi *ucsi, u64 command);
-
-static int ucsi_read_error(struct ucsi *ucsi)
+static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
+			    void *data, size_t size, bool conn_ack)
 {
-	u16 error;
 	int ret;
 
-	ret = ucsi_exec_command(ucsi, UCSI_GET_ERROR_STATUS);
-	if (ret < 0)
+	*cci = 0;
+
+	ret = ucsi->ops->sync_control(ucsi, command);
+	if (ret)
 		return ret;
 
-	ret = ucsi_read_message_in(ucsi, &error, sizeof(error));
+	ret = ucsi->ops->read_cci(ucsi, cci);
 	if (ret)
 		return ret;
 
-	ret = ucsi_acknowledge(ucsi, false);
+	if (*cci & UCSI_CCI_BUSY)
+		return -EBUSY;
+
+	if (!(*cci & UCSI_CCI_COMMAND_COMPLETE))
+		return -EIO;
+
+	if (*cci & UCSI_CCI_NOT_SUPPORTED) {
+		if (ucsi_acknowledge(ucsi, false) < 0)
+			dev_err(ucsi->dev,
+				"ACK of unsupported command failed\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (*cci & UCSI_CCI_ERROR) {
+		/* Acknowledge the command that failed */
+		ret = ucsi_acknowledge(ucsi, false);
+		return ret ? ret : -EIO;
+	}
+
+	if (data) {
+		ret = ucsi_read_message_in(ucsi, data, size);
+		if (ret)
+			return ret;
+	}
+
+	ret = ucsi_acknowledge(ucsi, conn_ack);
 	if (ret)
 		return ret;
 
+	return 0;
+}
+
+static int ucsi_read_error(struct ucsi *ucsi)
+{
+	u16 error;
+	u32 cci;
+	int ret;
+
+	ret = ucsi_run_command(ucsi, UCSI_GET_ERROR_STATUS, &cci,
+			       &error, sizeof(error), false);
+
+	if (cci & UCSI_CCI_BUSY) {
+		ret = ucsi_run_command(ucsi, UCSI_CANCEL, &cci, NULL, 0, false);
+
+		return ret ? ret : -EBUSY;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	if (cci & UCSI_CCI_ERROR)
+		return -EIO;
+
 	switch (error) {
 	case UCSI_ERROR_INCOMPATIBLE_PARTNER:
 		return -EOPNOTSUPP;
@@ -121,78 +170,23 @@ static int ucsi_read_error(struct ucsi *ucsi)
 	return -EIO;
 }
 
-static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
-{
-	u32 cci;
-	int ret;
-
-	ret = ucsi->ops->sync_control(ucsi, cmd);
-	if (ret)
-		return ret;
-
-	ret = ucsi->ops->read_cci(ucsi, &cci);
-	if (ret)
-		return ret;
-
-	if (cmd != UCSI_CANCEL && cci & UCSI_CCI_BUSY)
-		return ucsi_exec_command(ucsi, UCSI_CANCEL);
-
-	if (!(cci & UCSI_CCI_COMMAND_COMPLETE))
-		return -EIO;
-
-	if (cci & UCSI_CCI_NOT_SUPPORTED) {
-		if (ucsi_acknowledge(ucsi, false) < 0)
-			dev_err(ucsi->dev,
-				"ACK of unsupported command failed\n");
-		return -EOPNOTSUPP;
-	}
-
-	if (cci & UCSI_CCI_ERROR) {
-		/* Acknowledge the command that failed */
-		ret = ucsi_acknowledge(ucsi, false);
-		if (ret)
-			return ret;
-
-		if (cmd == UCSI_GET_ERROR_STATUS)
-			return -EIO;
-
-		return ucsi_read_error(ucsi);
-	}
-
-	if (cmd == UCSI_CANCEL && cci & UCSI_CCI_CANCEL_COMPLETE) {
-		ret = ucsi_acknowledge(ucsi, false);
-		return ret ? ret : -EBUSY;
-	}
-
-	return UCSI_CCI_LENGTH(cci);
-}
-
 static int ucsi_send_command_common(struct ucsi *ucsi, u64 command,
 				    void *data, size_t size, bool conn_ack)
 {
-	u8 length;
+	u32 cci;
 	int ret;
 
 	mutex_lock(&ucsi->ppm_lock);
 
-	ret = ucsi_exec_command(ucsi, command);
-	if (ret < 0)
-		goto out;
-
-	length = ret;
-
-	if (data) {
-		ret = ucsi_read_message_in(ucsi, data, size);
-		if (ret)
-			goto out;
+	ret = ucsi_run_command(ucsi, command, &cci, data, size, conn_ack);
+	if (cci & UCSI_CCI_BUSY) {
+		ret = ucsi_run_command(ucsi, UCSI_CANCEL, &cci, NULL, 0, false);
+		return ret ? ret : -EBUSY;
 	}
 
-	ret = ucsi_acknowledge(ucsi, conn_ack);
-	if (ret)
-		goto out;
+	if (cci & UCSI_CCI_ERROR)
+		return ucsi_read_error(ucsi);
 
-	ret = length;
-out:
 	mutex_unlock(&ucsi->ppm_lock);
 	return ret;
 }

-- 
2.39.2


