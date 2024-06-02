Return-Path: <linux-kernel+bounces-198478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295208D7916
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9071C20B7A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 23:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B208982863;
	Sun,  2 Jun 2024 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+C2XaYk"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFBF7E583
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 23:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717370703; cv=none; b=AikHo/zHbZMkP3FAoq/DGhsZSG/adm2z4d59Q/kYHTjTM2tPyd1YhHhioBpmHucXgTp7MfY8EkGXvrZw8CMWPVVU7OaRHVuI1rsE8M06vFbnY8WA4zGCBZfPx2Fs/WN3vYAerwJ2payHx9tgPOiS1481p2usCCKttDS9L3Qz6d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717370703; c=relaxed/simple;
	bh=Qlvm0O1XPt3pR+fGT5Ihsrd6DrRUvL18urSNodiPM/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KvAJqmo17nhREbSfkk1YaERasfgwQ1sTa7kjPEFCyfxMKq/fPdTNScPQSNd4mKGUMiCH6jXNdhK7A+Z0Gm9Q81gCxjpgieQ46n1gE2OzpWiCDxyUL3DX8z99WHLsRYzb5krGMOBBm4JkAwHAK1EcukdsvP2buCvHsTPPPjpngrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b+C2XaYk; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b938587a4so1167090e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 16:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717370700; x=1717975500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RS0RRS8kWTy5YtdarUDO9BTC5OYKf3Jm1kS68cq467k=;
        b=b+C2XaYkeBIIVW6JkIGa9QeQivURht3Hmp7Y0QTO4E1uU5vkKCV1+bMimfPqPOlj/W
         HWMTwNtsDqrTLuRuf+5xDS3kerHI2Pa2IYyde6VK9JAYfUY5WwWVQUtD4uEZvZGy/2Ma
         K7lk9vSVoRa5EEIZRb6z4QNagsJ0PCLvAgF6OkZsVZv+iICEG0syCznfqtAK+zZNv7DD
         fi077KDS2HzNDM1/Zzw+ULgO6eMwbEQm065L7H7sNE3KpxbRWB+HHmc5vxN1SKZZ9iw0
         CbfEeqARfYxyqE8ldqrlB4FbInAe8xoU5+YO+4FtQPjzP1q7V+aB6uM4YKVPU1/iNvtp
         zIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717370700; x=1717975500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RS0RRS8kWTy5YtdarUDO9BTC5OYKf3Jm1kS68cq467k=;
        b=kMMv6tpPPGqMwmpEW57lHpgQfGvaZsJKBcsTQPz1dbEtUTn5XNNDFqZjh9SlCTkbS0
         hvnzfIwQ8KB7xTiC+4j75ElV4jpVo8bHwGfEwRXel0DXz6hvG8y3IqrYQiwhGLqCupD+
         cOlGgdjKRGpfZGKmo5jbcaRV55x+gqvOduc5jrg4l57ieyeBOSEwpztZn1O7T9lKKX33
         sJmMr1Q+upBxuairaZrsotFAKyZf6nQUlqDwYkjOm/IFpeRs0VLhgw7971oBzk79D09Z
         3LZRXFXrOYcU/vb5tPj83l4CTCUZn8RTdbtiFcsrSH5F4M3Poj7c9L+vHGdgdbLJ8u/C
         v0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwTOeibERLBk9MMee93p7xqae+b6uvq2eTpZ9PiESTkKXHFPxTNCI7yTMrTrpm+FyR3QIVafZ/m17BvEEykq+Yy/ahoiJtR1peQGt1
X-Gm-Message-State: AOJu0Yxma6mCX9SR4KrRFEImM7NoggLlregWOz+omyinFv5EHTK7Z9qe
	O+sQkAnKWL4WWi//wq3Jy7GS3jCwGlj3cUCJ9ls/oro7+WwYsJVYMLpe7HsaUJL7W9H2sltjLnt
	x
X-Google-Smtp-Source: AGHT+IF+7ECElpfPWCZ815PFEw8gDVd7yShai1/+oSnWq0vMjhxFgQHiWSjlGgySRRjvFrPegfiCDA==
X-Received: by 2002:ac2:4296:0:b0:52b:8363:34ef with SMTP id 2adb3069b0e04-52b8957535amr4327645e87.15.1717370699513;
        Sun, 02 Jun 2024 16:24:59 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b959008aasm392369e87.269.2024.06.02.16.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 16:24:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 03 Jun 2024 02:24:57 +0300
Subject: [PATCH RFC 4/7] usb: typec: ucsi: rework command execution
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-ucsi-rework-interface-v1-4-99a6d544cec8@linaro.org>
References: <20240603-ucsi-rework-interface-v1-0-99a6d544cec8@linaro.org>
In-Reply-To: <20240603-ucsi-rework-interface-v1-0-99a6d544cec8@linaro.org>
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
 bh=Qlvm0O1XPt3pR+fGT5Ihsrd6DrRUvL18urSNodiPM/A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmXP9HRhpoJUkVmxwoBwDeeIJduNwYx81xqhxun
 KdkqwkkPk2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlz/RwAKCRCLPIo+Aiko
 1bUZB/4xcmd1cxqLd8b97oPAYAEfMP/CdrDSsChcE9bqtNRiHX+0qrVNseJxk2CFl+ROSR64LNn
 gKZw+qyiXaDDk+k04/3Y0HJ8fTmy0um3lkCN9mY5Hesh8+FQILSfOLL4+cy4uY/2bVV0vV90jVl
 kBGQrqD/MKruFqGbPxGl6upEXpsHCL4V4Fs3fkzxrq+jmPFCFcIAUFGFsP+3vPX89pqpvHV/xFE
 7w4bCyjn2Wr+lJtHMFX/4pzVTyiMsHgaBIw/H7Xb6XUR5y0AaIjsMHlaYMivSjwnTZIkTL3g85a
 QkfXmhOg5YtUNjAzRk3cO6D+I0uIt0OKIF/Sn+OvRrpYJFMA
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
index a3a29ea4e325..54a2c505442f 100644
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


