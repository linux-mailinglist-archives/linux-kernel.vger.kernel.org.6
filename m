Return-Path: <linux-kernel+bounces-229118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A4F916B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB461F2431F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1896C170845;
	Tue, 25 Jun 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hiTIGksk"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8516F85F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327277; cv=none; b=TzQIDf5dfz7McVrFtGHmMk1jGf0Lr4aDqoUYEALLTv6G0Xu6WVhSa1MpYeMTANQwiH6CjdoZZCOY73sjnL97Y/XdZ1Xq6oG+CYTUttpGqSrNZiPRjKLi/M97zZC/guM8OoSF6FhhuwtATwN/gCIiX/nWiVtBTSzLEt2VIb3k4M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327277; c=relaxed/simple;
	bh=iGz/1CTodFFLxhp6bKYq0V9qXiKSF7JlfOGZtn0n3AI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jNcLEGq0F2z0MsVZYZOxKbSAbVsLZFS8/4SFQfAeG+I2huF2QlqyvEMZRUVMn5GajsJUY0QcdB6PgiCiHGgx4IVwSSbI10O3iSk5xUz3s3i+f7KUsCKss69vrAoUhqtaIpkNqxHniX4Bf/vrIVIbOZMuCUYJvc9ids6qmR4cgRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hiTIGksk; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec52fbb50aso40577761fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719327273; x=1719932073; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KB8pq5NQAZ6n/rTI4y8OIrQXRuJ/BDLkN3YelnKCzI=;
        b=hiTIGksk89zMJUFJnB69SRRfhUbMnTHFX5+Yg1/cEyLcRyaW97rCBBBAnNnapjclLN
         qBzm3ROHVVdo1orBXXhyXeleF6CFYR8TA+88uaRj85QUGDFLKH3HrKOL5NI9WCXPh7Se
         qrViRtkI4MeA+BJYjbqHTJbcwtMdQdiE2hzI/NRyWxR01RNuZ/S/8RhlbVYhC/YRjMeW
         ekUDI0/QxqESOSaAuJSkQgvSHUUZ23x96kjXkh1q8VH0Xj7tKPaNOWZw1HJebbpzFEps
         JArub/0sUfzQVmY+OkXuQ218nMqSatf3PPvyX4cmY0y3SN3ech8ZPr7Pm00VRvppf8wt
         fFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719327273; x=1719932073;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KB8pq5NQAZ6n/rTI4y8OIrQXRuJ/BDLkN3YelnKCzI=;
        b=cTOWh2HRycBTOUswPAVnwSApv1JDFxjvkf2sybZkn1DeqFolBa2bAf439g/nrJ9/IC
         HHQZifQOtt9qeFfwdlYOUM08RvjW2ni5BEi8xb8S32zpy5MzYATmGheiLy4fxuK5FKQF
         acQSmoRDfZRenNrR/aUiPekmnxRKka3z5ufzSvY4ur12Rpl+W8RvesHqA//c4NJftohG
         4p+rJP5fQoN8v7EikfSl6iTBZaXF+9EaF7n9JpKd+cnH0QAyvwNHlxXClg5VIcSj5K6e
         ehGu7hV79sRUfwE5/z39etCpfy1b5KhcgwIVxAXsRqu9zKoIC9K+S3W/fI0USIkAkCoN
         K/EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF3uqqMUSzyamvg7YZdK4eN2ys/iGbyIkX/xwo9UueVRpzspilVJs9hgBIuWsQ8rPsEnjqn/8fY5glN+MHkAdjl2K91wzwj1oGmc8D
X-Gm-Message-State: AOJu0YwI/JZQ0hX5o7FC76N3tgjrzqOKDXKPR7W76ZdnnqxMS3JmIJwB
	otQ8IMb/02P9Rrwm0NPZPe3RS9qsiqQkVtBTI7jqjQtsU2R39sHuyw3nUftEesFob64jg8cdnFN
	FeMQ=
X-Google-Smtp-Source: AGHT+IGtQxo5jV6cMwfXqOOOPD8YZNEebt3pWP+GVzXLpNydBk0U1gGSF/EvGWsWZGvWy6VumzOMyA==
X-Received: by 2002:ac2:58f4:0:b0:52c:dacf:e5ac with SMTP id 2adb3069b0e04-52ce185d218mr5415211e87.54.1719327273412;
        Tue, 25 Jun 2024 07:54:33 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd64328b7sm1251877e87.221.2024.06.25.07.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:54:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 17:54:29 +0300
Subject: [PATCH v3 4/7] usb: typec: ucsi: rework command execution
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-ucsi-rework-interface-v3-4-7a6c8e17be3a@linaro.org>
References: <20240625-ucsi-rework-interface-v3-0-7a6c8e17be3a@linaro.org>
In-Reply-To: <20240625-ucsi-rework-interface-v3-0-7a6c8e17be3a@linaro.org>
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
 bh=iGz/1CTodFFLxhp6bKYq0V9qXiKSF7JlfOGZtn0n3AI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmetojsGNpr741Om5LXvH7sB4VKPc9Jwl3kjr86
 7L8QXP96iqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZnraIwAKCRCLPIo+Aiko
 1WCzCACcWhUjxOL5ffytSZW+F/ypklLcxsDF6YxBlJcdE7up+io2SCqomp/iKmX+5dY/ORLmd66
 lJuECdbPx9ngWe/pTO+CJNJYrH/dMWh81YM5i2PFb8n73II9/yqhxJmdrhlsw2LgK7If03UgJ2+
 k+iO+dPgvCxceKi4Y0cN36dzDSztbdn1k2lHng2/DUhrTuUPscI8g120u9GusllZQ+D8YZjhBuo
 rUBkA3HL1EDs5Z0URtChJIRQ7i6Vots9o3vGO35gdat2BHFsIzzFeHrLvwp8vV5bQ0mLZVCxQ95
 jS/FEKz7Q4a/a0K7/6AjoUN9hZ3Uf0r86rV6mYKJDAiL2jh5
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
index db25f51ff71d..5f8e5ed9e0f9 100644
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


