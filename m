Return-Path: <linux-kernel+bounces-198481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B97618D791B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48CA21F215D7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 23:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75134839FC;
	Sun,  2 Jun 2024 23:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPAmxdjW"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91626811FE
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717370705; cv=none; b=PwsMrJ3msgpRoIPVIzAmmI8rZK2EMuQZwyDoE7WCjgMr+wDcAOWLq9LhB2nEw8zG4CpLUDbyjsUuDlKE9wywf2cVm8yRCVdEYCHc2NmsbqG7p+TCsnAP1HEnDT1Tli+DI9+r/iQOZKqdBxvCCdrqPNLsLvIfLPwfnhWHrXfmuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717370705; c=relaxed/simple;
	bh=qwhd20pcT6mKmuOmdJvReDADwvss13IfbnCS0P5O90U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5HBAmpyTqzeuHmdB8ZvauJMpozC3c7+flZEqdE2tab9Fksm/No3os/e+uCIwt5/F2kDyqStTyyGfbmLo1ygJLVo7CIs0khsmzWj56mW6Gm7DLRPaLzySFBZWZi8YJMupkU94oJVd7pzEmt38ecGGVJM9KVBWspKx733UIpKhTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tPAmxdjW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52b93370ad0so1654658e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 16:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717370701; x=1717975501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8Iq+3RgEig8Cx0iz/mpoUKg07pqVjSqpR5cr51J2sg=;
        b=tPAmxdjWhtIQBTKVcAuPpJpM6qNMEfAqaXzwdemOZl3uXnrwp/HfXTQ7kYFrj1DIRT
         sSAvsaR4fbm68vJhalIoHPqQROmBptZvdEsoUtOkjdKzRe4+hHLCrXmahJ0IlHSvNwfa
         TKd1I5c4wVxXITL5Au+IKwbI5g2/7wXCcyN3PClz7qdprzlHqTmHR+GKlRfk03r/KASg
         BcYUwllskBcTkkMDwXMZRYK6rDZXEP/TMzYoKVFuIjzMwuOH0wziXOy4m8+tEDuRq5hJ
         JLF8szIcL6CVOrhve4hsEgfK6p/ylpSKl9GZyCBZibFzlfcbhVJajEysvzb8uCYLL6gE
         kyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717370701; x=1717975501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8Iq+3RgEig8Cx0iz/mpoUKg07pqVjSqpR5cr51J2sg=;
        b=AlxbvB88k1T4WBj6il01J4TyBuPSKoMpE/U+LRlfjfTs2PM9kzqD3DF+HG7OzEB1tD
         mxLJoJbFqfLRGCXFcGuBJMExMgtnW/QgtH/M3UklQPdsxv0uL4HjJTp/M+KLVw8trlBZ
         b8lbERisS4pE8Otpsm/dMTlImXGx/N90H2lIVbTq5brsezbgnJNe5xIMD27VPh4VXMO6
         w2avN7BNQtwr+ZP7V97iKS34xMI07yWkDIK/EanfoUN1Xk3cHY8et5zKwqhvV/h1d8dN
         cO9oCcrE63ApfcMS2WBF5OCUf6TvW1MeRR1BFZnBgjOSwjA/IfiWmrHHC6DAOofSjMQV
         afGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeyuIeH83PsJE6WsSqYhe0s5UkR0rnJbxOwDIOZW8/nl+7su46hnbmRsVbpPI33hN8QOwdSxsKmBvbTihFEB7G929xT4NI/EN6IUcF
X-Gm-Message-State: AOJu0YzfaEE+NoJKDeLV9FiXk7va3SjZqQ0XAGnyWZAD7SMQPxrVfQA4
	dSpdjLtPINarlMEMHahDo8m3ApH8zxcpGeGOBszY1a4bPrA6pSlqOklxF/KUgmpS3XSVBZiuj3f
	z
X-Google-Smtp-Source: AGHT+IERXsZJtbptbub4OPpmYt4izzdy6vVE3d9VwxncjVETVSXMGoMmwAAaAqx2FFQoGX/3InI1uA==
X-Received: by 2002:ac2:58e7:0:b0:52b:88ba:da88 with SMTP id 2adb3069b0e04-52b8954ea17mr5935410e87.26.1717370701481;
        Sun, 02 Jun 2024 16:25:01 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b959008aasm392369e87.269.2024.06.02.16.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 16:25:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 03 Jun 2024 02:25:00 +0300
Subject: [PATCH RFC 7/7] usb: typec: ucsi: reorder operations in
 ucsi_run_command()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-ucsi-rework-interface-v1-7-99a6d544cec8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=qwhd20pcT6mKmuOmdJvReDADwvss13IfbnCS0P5O90U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmXP9I9UoE+huJlSrwgEUi7zxKYLl7ib9SuXtkX
 fxqsDm1/vWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlz/SAAKCRCLPIo+Aiko
 1ZPnB/wJiXKUWKNGHNVrmNmaiYUeTXAzLFk/CckWZubxbjYiTn17Iv99ejxUhjRVFoYE2cwU8lE
 SxN7gerADf7/9A3HXwgOOU40QkmSFfc+FAo2sjoBUw8Nq7Lisst2c7LvRypbflv6wXu44KyYh+R
 cq4NC5KGZPlvD1io3PThZep4n5w7OrgFBl2deD0gg14CCl9W6NvMoYWarHh6jGN3G3t9Xez6JjP
 8iQ8r/aWZvXmBySF+7nS+Ohc6U0dC6AE4R3VSB8FCKMUUEACMEVU0mQlf4693IcOC0KvJRopr3x
 KVVbA1SK1EL9fbV1BpZSHlFPziFH+A+NPxqCFOlMsw/GUGwy
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Streamline control stream of ucsi_run_command(). Reorder operations so
that there is only one call to ucsi_acknowledge(), making sure that all
complete commands are acknowledged. This also makes sure that the
command is acknowledged even if reading MESSAGE_IN data returns an
error.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 4d36a04dc63b..4666dec005a6 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -95,7 +95,7 @@ static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 			    void *data, size_t size, bool conn_ack)
 {
-	int ret;
+	int ret, err;
 
 	*cci = 0;
 
@@ -120,30 +120,24 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 	if (!(*cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;
 
-	if (*cci & UCSI_CCI_NOT_SUPPORTED) {
-		if (ucsi_acknowledge(ucsi, false) < 0)
-			dev_err(ucsi->dev,
-				"ACK of unsupported command failed\n");
-		return -EOPNOTSUPP;
-	}
-
-	if (*cci & UCSI_CCI_ERROR) {
-		/* Acknowledge the command that failed */
-		ret = ucsi_acknowledge(ucsi, false);
-		return ret ? ret : -EIO;
-	}
+	if (*cci & UCSI_CCI_NOT_SUPPORTED)
+		err = -EOPNOTSUPP;
+	else if (*cci & UCSI_CCI_ERROR)
+		err = -EIO;
+	else
+		err = 0;
 
-	if (data) {
-		ret = ucsi->ops->read_message_in(ucsi, data, size);
-		if (ret)
-			return ret;
-	}
+	if (!err && data && UCSI_CCI_LENGTH(*cci))
+		err = ucsi->ops->read_message_in(ucsi, data, size);
 
-	ret = ucsi_acknowledge(ucsi, conn_ack);
+	/*
+	 * Don't ACK connection change if there was an error.
+	 */
+	ret = ucsi_acknowledge(ucsi, err ? false : conn_ack);
 	if (ret)
 		return ret;
 
-	return 0;
+	return err;
 }
 
 static int ucsi_read_error(struct ucsi *ucsi)

-- 
2.39.2


