Return-Path: <linux-kernel+bounces-198479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B168D7919
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 01:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9318281785
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 23:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29C582D7C;
	Sun,  2 Jun 2024 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVHJWEv2"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3C76EEA
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717370704; cv=none; b=GRGtvgAesUanAzRiJwtZonM5e8tYDRppsEzExq7ajqHkROHHxjgw9/13Wq80F0clCWBjkGdeiMSN++0WfZnX7idoMYHLfTV834QdLsnqAgk2eB3w/A88DqT1K/BGvPbgiOiks5gaqqNwJ7a381nsy70E7SmS7Ap44TKg9Y/w+Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717370704; c=relaxed/simple;
	bh=mrPf66+/PzNa3/0SVv6o28YNwb3VM608GVeFzUihyTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j4PZgrZWpCDlwBnSLo8jk2cHcfhaV3dgOP/Fv8ubi2/LO24AuY6RJdehe5nUB8yjrPZWQDgZ/vHmWkiax8EPki15j3+VpD+T6KRAV0Eu23+JKPs0UdrnKp8Hhj+/o1HMinh0hm+HHwrmO2KfmZcrZ5HU/GfA4KhWFzRrggqEWI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HVHJWEv2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b90038cf7so2059017e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 16:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717370700; x=1717975500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMHRLla4ILsm5OyTHPffYpll4rFbwg7rZ0xiqfrtlAk=;
        b=HVHJWEv2axhMKd+BoNtPVeJxdLSDif/oNCAiZ5+mTslXnZFi2kOYzL4FTtPFDamuAc
         7t3OqVYVe4cipdQFnOaJh7ZFDBGsa3EoKLpjw2V+xjErUDDfL1p1bs6OePhxCTzGtM46
         w1iyKoDlOlyYMrTehTS+gosrCQPnq+6B7C/yRRsz/zRk2ywWPsk4/Aze+8Tm7hB+RkGw
         LK2hX0uPljt1rO03BflpZyT86E3RMBhBuTjnqz41oH6E+eR0FR8LhJRZCfGhh5yM5o+7
         yxclsFUhSkFyriTQmzafQtJC2Bnq6EMAPYAgw7WljqgcCkCwHuqxti0FXrXBVvuktVI+
         cbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717370700; x=1717975500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMHRLla4ILsm5OyTHPffYpll4rFbwg7rZ0xiqfrtlAk=;
        b=KMdFQhaCwGCt1xc4acJbCUkEKqEiyjwJ9HPlZUCDY5AFg6X56CTT5tbzouevB5XRkQ
         JT0j5GVwKxYQ06OB4KK2e4Tbm9UJeDwN+JAqVp2PmPOF0YxgLsQN57lwEMQKO+CWNbd9
         Ip5Au99RJ0Xsgi+hP59UCdE7Dt0pl+lpxKttnvune4gwnK9jpFPqLBZJu5DRJiIddKwa
         aQuzXYZqs1Q7RfD1DBhDbNVxwCvtD6QNzd6JKJ3vMzimcCy6OBoXlAifNETEEHWorCbU
         +tqhqdCfL1C60elhtio4BLeZ+qnUykdGahQ1XQgq7U0ExFOfMxIukmUihwQGtWEwOXYn
         yq6g==
X-Forwarded-Encrypted: i=1; AJvYcCXWJrVUpBulqs9mAKgG9aHLt788Qtm/bquEmkj5ZTjsLmSYC4fR/M7YwPJIaxyrotVvgMz0dBdBxrWiPhwctOVMi5HiYDnbLaZC6lm8
X-Gm-Message-State: AOJu0YwDJmKw0d+rxxcG8PIXlnNGjAfA2EICfQl4BAwB84gXCAboJQKs
	jsUYAOYmJDks0blOxs48+bIvWP8xQgdXV5pLCbo0tg116w6xPqgtyE07KcvVLAeYLJD2SsKCvKK
	j
X-Google-Smtp-Source: AGHT+IEinySEY+8mUF5JebFptkGUEBHH1p6v8JTLm5BkjmrOYM/dSR6lKjEU8RJ2VRVXxIay7X04zA==
X-Received: by 2002:ac2:5927:0:b0:523:b19a:2602 with SMTP id 2adb3069b0e04-52b896c1583mr4583720e87.54.1717370700174;
        Sun, 02 Jun 2024 16:25:00 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b959008aasm392369e87.269.2024.06.02.16.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 16:24:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 03 Jun 2024 02:24:58 +0300
Subject: [PATCH RFC 5/7] usb: typec: ucsi: inline ucsi_read_message_in
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-ucsi-rework-interface-v1-5-99a6d544cec8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=mrPf66+/PzNa3/0SVv6o28YNwb3VM608GVeFzUihyTU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmXP9HAufR5oVjQ0LWVWAxSmYfDH5vS6wJiYuZ1
 dHGzcQ447iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlz/RwAKCRCLPIo+Aiko
 1WYeB/9JZcDHr+OF40i0unPYw6KFSmRQ5469nPCT2YTGknUhZXQSaNZ5MjbUZg7XLCeUYccokgJ
 y5EPZdDTaWFO+eXLDilcoFpoNzbs4Kowo86yEfvPVm2YzydiXpGCkvHSnQcEskFxHbUnI0wEQSt
 zspOCM051maHPSZLoGtbJ6mt/sZ8KJiTBfc0iQi+XER2c5/lwFA0rcfEXQXEfqECNWB8tn7HF52
 W23c3lkftFGNTtNSGwh46VWLlcJQ00eVChhByC4oPoyqS+taGwm4IM5ROUGdRbI8RhVxx7BcVF7
 mLr41IHkns9dAUC5Ut/0i3z9vQBkNOX6Jz1pOI6DlKLYaPg3
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There is no need to have a separate wrapper for reading MESSAGE_IN data,
inline it to ucsi_run_command().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 54a2c505442f..ac4bd86b3fae 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -36,19 +36,6 @@
  */
 #define UCSI_SWAP_TIMEOUT_MS	5000
 
-static int ucsi_read_message_in(struct ucsi *ucsi, void *buf,
-					  size_t buf_size)
-{
-	/*
-	 * Below UCSI 2.0, MESSAGE_IN was limited to 16 bytes. Truncate the
-	 * reads here.
-	 */
-	if (ucsi->version <= UCSI_VERSION_1_2)
-		buf_size = clamp(buf_size, 0, 16);
-
-	return ucsi->ops->read_message_in(ucsi, buf, buf_size);
-}
-
 static int ucsi_acknowledge(struct ucsi *ucsi, bool conn_ack)
 {
 	u64 ctrl;
@@ -70,6 +57,13 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 
 	*cci = 0;
 
+	/*
+	 * Below UCSI 2.0, MESSAGE_IN was limited to 16 bytes. Truncate the
+	 * reads here.
+	 */
+	if (ucsi->version <= UCSI_VERSION_1_2)
+		size = clamp(size, 0, 16);
+
 	ret = ucsi->ops->sync_control(ucsi, command);
 	if (ret)
 		return ret;
@@ -98,7 +92,7 @@ static int ucsi_run_command(struct ucsi *ucsi, u64 command, u32 *cci,
 	}
 
 	if (data) {
-		ret = ucsi_read_message_in(ucsi, data, size);
+		ret = ucsi->ops->read_message_in(ucsi, data, size);
 		if (ret)
 			return ret;
 	}

-- 
2.39.2


