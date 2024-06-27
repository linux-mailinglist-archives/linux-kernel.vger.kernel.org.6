Return-Path: <linux-kernel+bounces-232489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EF591A990
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C329BB24829
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFBE1990C8;
	Thu, 27 Jun 2024 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0B3sBjZ"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC7C198830
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499490; cv=none; b=H03R2d5Dtoj9ZlcLYWrinWklyDOe2hJiMI34jtiPZhzCB+I9iIh/o/WuZCpjnzBXn+wVOtIiFZTn436i8FaVL8OolUCX0iF+SFmCh+Pn4yVYyM5S9iSkZYVSxOmxakKZ1RLLJ9DKY2x2bEqk5wtlCedtE9e+N4mRHzpk5DIogb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499490; c=relaxed/simple;
	bh=IUlRPLcwpNg8JnyGbOvllbRci0dly68y4uffDqgWHcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YbkP4sCBbsL+Q7OM9Z/uz3fO1FD91+XKJwOdk+8NITIN8nQ0Z9trBoX/IGmSg2TdY8Jmhf3Srl33ASgzTA3mlIB42Mpvycbiom4f/cMklJXFdlGOTEEzcJaBGKznL3q8WF3JAbGw6fnioHX4t2Pk0ENK8sXlXVg0EIIrTi29jos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z0B3sBjZ; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso96171961fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719499487; x=1720104287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pv3PctyJy2SnI13bqUyVzb7EmYqWrJDar658iy+XONk=;
        b=z0B3sBjZUbZ6dM5QjzzLm0ic9fvlv9KXoR1DMK8nhJMN+GkF57tPonev7fBZVuEg50
         qXKq0IdjUCJ6zd02lWBcchS7DXGJ8VuWzzEESRvGOwYwexu2RAtUiVNydNjJd3YiMD4b
         jKoA9LRd8dq1bc6l/pwAjo0+3VK/CDFnNA7uQ+WiftZw2rtDc0QxrFjJXg7TEx1YDAYt
         oVr33fO0yRmNsckXO4QudbcJh5k+kHkkwKk8KvBAzqT302E2eZ9MtsoFtjZ3bCfaR8WA
         6xIRKpVL+2lYqmRC2zZgRVaP0pUetf62uNck8WugkKs4jvQ/GqQaFizbEAgKBsQGsrwe
         lMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499487; x=1720104287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pv3PctyJy2SnI13bqUyVzb7EmYqWrJDar658iy+XONk=;
        b=to+3iak2hhGaOl1Gx6VOUAL8URwdJ9HEDDtax8UYMvv20o+EcY0r2Hmz3y1M260QoV
         UYLBJfbHhleqxsrIgoGB1CT0lJEYbz988+EsdLCX37lfUb/8zFVowT8SszWJgONl1NZg
         zyiwHEeu6xfxTSZKTqHXxpleTMA8gown26/Pn46ymGaVowms//ZDi0tFpsNUMP9EuWBP
         D5cyZjWcEJ2fYZlVj2/qrg1Qtm2mF/YKUZzwgTeHMt81fVl9y7IrwwfgUqexjzd0M0CK
         UDFsrK+HBLRD/NjDAheIgmXKPgqowrOJ6M/1fm0e4piaRKu+/dL76VBwoRuvfOoqAVn5
         5n7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSkoSrKd4cjNQdUOmOc5xpZgFC/+7C2sUt2NOGn3vBnGC3ZkAcvE6nnCHI50d4qz1uvhlOp8JSYTRxs9kBf7W/4KpzoGLN6Zcp24Q7
X-Gm-Message-State: AOJu0Yx98VVmIROZegGilnlEnScj4mg6vTKVOra++qmV3kdXFlPJvXhu
	WJVP82/ZKOBC1gaNEX9WG7a9XJRCoA4X8tvWgG2O3ggXzEaSy2+G1fP3bVLPLrAsU6yq9TB+jvY
	78hI=
X-Google-Smtp-Source: AGHT+IGyKCad0pTtyjWDWYT4auTNDLJlAquHp5LlnqVILjGBHWKp/6jvkXxkAFrJTEFJQT7zvH22Gw==
X-Received: by 2002:a2e:b004:0:b0:2eb:ebcd:fc1c with SMTP id 38308e7fff4ca-2ec594034bbmr78292621fa.26.1719499486745;
        Thu, 27 Jun 2024 07:44:46 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a34447fsm2775911fa.11.2024.06.27.07.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:44:46 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 17:44:43 +0300
Subject: [PATCH v4 4/7] usb: typec: ucsi: rework command execution
 functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-ucsi-rework-interface-v4-4-289ddc6874c7@linaro.org>
References: <20240627-ucsi-rework-interface-v4-0-289ddc6874c7@linaro.org>
In-Reply-To: <20240627-ucsi-rework-interface-v4-0-289ddc6874c7@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Nikita Travkin <nikita@trvn.ru>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4910;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=IUlRPLcwpNg8JnyGbOvllbRci0dly68y4uffDqgWHcE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmfXrZU2jPKiwjQP35+8I88ou3BxaPfkpg4PJJq
 onR4FOLWHaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZn162QAKCRCLPIo+Aiko
 1cBnB/sEp9lqE76ma6UnCY7LbhqliIuPkO9FULEW8UHfMI5X8F+JdTgWpedlAKFdYNxEK48AiL5
 xytAUgkAj6ceGwOp0xx/JTMBPfGy/LNlBQVvbzU1YiRjUr+lbg6H1lI80C5VvdijDo+1hnCNQRV
 ecEYU8muhwSmRAj0FR1SIQ10cp13vLbTdEse+BDcmnHMwMh41KT4DknuX3Pfkler5ez4oOucu5o
 R/9mtPjhNSLk1SkyMDxYrJIC7Tq8ds8MBqBFTnWBzsHJ3CG9sS0o7HlCr6Wj78lqxsWVId+Mv73
 RrG8rgRv1c9gmbcNJ99Kk8jsDbZtPmbx4tG9QhqGFKT7lSTU
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Rework command execution code to remove recursive calls of
ucsi_exec_command. This also streamlines the sync_control / read(CCI)
read (MESSAGE_IN) sequence, allowing further rework of the command code.

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 138 ++++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 72 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 17d12c1872f6..10a8fe893333 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -63,27 +63,76 @@ static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 	return ucsi->ops->sync_control(ucsi, ctrl);
 }
 
-static int ucsi_exec_command(struct ucsi *ucsi, u64 command);
+static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
+			    void *data, size_t size, bool conn_ack)
+{
+	int ret;
+
+	*cci = 0;
+
+	ret = ucsi->ops->sync_control(ucsi, command);
+	if (ret)
+		return ret;
+
+	ret = ucsi->ops->read_cci(ucsi, cci);
+	if (ret)
+		return ret;
+
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
+	if (ret)
+		return ret;
+
+	return 0;
+}
 
 static int ucsi_read_error(struct ucsi *ucsi, u8 connector_num)
 {
 	u64 command;
 	u16 error;
+	u32 cci;
 	int ret;
 
 	command = UCSI_GET_ERROR_STATUS | UCSI_CONNECTOR_NUMBER(connector_num);
-	ret = ucsi_exec_command(ucsi, command);
-	if (ret < 0)
-		return ret;
+	ret = ucsi_run_command(ucsi, command, &cci,
+			       &error, sizeof(error), false);
 
-	ret = ucsi_read_message_in(ucsi, &error, sizeof(error));
-	if (ret)
-		return ret;
+	if (cci & UCSI_CCI_BUSY) {
+		ret = ucsi_run_command(ucsi, UCSI_CANCEL, &cci, NULL, 0, false);
 
-	ret = ucsi_acknowledge(ucsi, false);
-	if (ret)
+		return ret ? ret : -EBUSY;
+	}
+
+	if (ret < 0)
 		return ret;
 
+	if (cci & UCSI_CCI_ERROR)
+		return -EIO;
+
 	switch (error) {
 	case UCSI_ERROR_INCOMPATIBLE_PARTNER:
 		return -EOPNOTSUPP;
@@ -129,7 +178,8 @@ static int ucsi_read_error(struct ucsi *ucsi, u8 connector_num)
 	return -EIO;
 }
 
-static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
+static int ucsi_send_command_common(struct ucsi *ucsi, u64 cmd,
+				    void *data, size_t size, bool conn_ack)
 {
 	u8 connector_num;
 	u32 cci;
@@ -155,73 +205,17 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 		connector_num = 0;
 	}
 
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
-		return ucsi_read_error(ucsi, connector_num);
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
-static int ucsi_send_command_common(struct ucsi *ucsi, u64 command,
-				    void *data, size_t size, bool conn_ack)
-{
-	u8 length;
-	int ret;
-
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
+	ret = ucsi_run_command(ucsi, cmd, &cci, data, size, conn_ack);
+	if (cci & UCSI_CCI_BUSY) {
+		ret = ucsi_run_command(ucsi, UCSI_CANCEL, &cci, NULL, 0, false);
+		return ret ? ret : -EBUSY;
 	}
 
-	ret = ucsi_acknowledge(ucsi, conn_ack);
-	if (ret)
-		goto out;
+	if (cci & UCSI_CCI_ERROR)
+		return ucsi_read_error(ucsi, connector_num);
 
-	ret = length;
-out:
 	mutex_unlock(&ucsi->ppm_lock);
 	return ret;
 }

-- 
2.39.2


