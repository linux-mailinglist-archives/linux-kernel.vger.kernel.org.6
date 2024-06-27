Return-Path: <linux-kernel+bounces-232493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1F091A99F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7046B1F25723
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2541993B0;
	Thu, 27 Jun 2024 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y+YXnDaM"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B7E197545
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499494; cv=none; b=sv7D+hLHxFrimioMseY3/P+tkoxdzUdjtjWWqBZBC5nvs++d7zZejFdjXpgRyKRAlhTpQsyU38/Kasr2qyoZOOnviGUvwrIvhK0C1t2w0sQQoczPcWUpXCBsQf6l+fxon/ZIZz6gVRJ1OWfdgsEPB5riZMShOySj7pFxQn2Ei1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499494; c=relaxed/simple;
	bh=8t+rc0a05n9eyrWDZO2kMieJ1aEfnXGXWDcAD9GfTds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZW+Vt6zH3X4E0SVxFq/9n3vLpv8PMyB+dU1yvm1wZtqQ/GqUfyLfQ1ZBZVuD2C7j9KUHRzT2GfqiVy74fWOB6CFYlwlB4WgcSYFJ7lFtS5QCOynYSgAN0Yd+PNPMjnUTo1yMjsR7BmBUIX4HPGGSnk+ig036SYtOhJWJeHLP5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y+YXnDaM; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so110592681fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719499489; x=1720104289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dO9vc3WlwnOOdxIv2wYOfRp/f4HDsDDrITVn2Ghy1d0=;
        b=Y+YXnDaMdWsJTtfAhzELTG4b+I0slocRHSiwTQk8/vbxL8+CoJAdcEmX8CulOG3WhC
         KvvAZpkiVkUIvztDD+a6nVTLhjNuk61yBTR49rN20uCn/dDdz8XOrlARePfJ3rODLa4n
         DtFAvy797BQ6rPSOfbBxvNx0e7ddz/2+zMuX03l34/WmNaqS2HxeXaW3L/8snIJwX0D2
         f7srD37OmbSEG8TITTlWGHrhBO+b3sgQeQAMIkuIUYQrq3fwDJnJYP2FXfh/BNnrJD0w
         kXOsjHrQnASW2wPpG1HhV8yWXVqIRVi14H6fGG9zewbIfIVNJLkEXkn3NbGIFDrcE6Ds
         Gu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499489; x=1720104289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dO9vc3WlwnOOdxIv2wYOfRp/f4HDsDDrITVn2Ghy1d0=;
        b=AMzUz444oqX1kSR64eKyiPcORinIHWbO6E204xg7Rt/KbV7gdzybkjgkZEwE5Sgm18
         KOYIk1gJzzp7SA0gr4vBGlL1NVJ2z+6dQv5cS6M26ZWM4kQhsa9/+bjl4DrQlNzUrBL4
         MgKF8yNrGnA357RBotSZRHDKCjuHTfVaSBNVXJZGB8pd8kSQxdoE4SSEL33v9IKCf/5m
         FUyVV/5qCmiCORIRhyvJCY0Jr7FYMNg8IQexDxHcjI0h4I0LrBGw9dn9E3EFrwt/Zxlw
         qRgG8+oQF21JzF7UhY6RtSzOAGNiucoJwvY/ObJQtjOpqayPyrbIClBmYxvLzp7hUZVi
         QAZA==
X-Forwarded-Encrypted: i=1; AJvYcCU10/vlNICLrbBZg/0mK8R86pg8vxF5/dJ9qv0SP0dOVPj5g7MrLGTBmBOEOHZapN6kQWBW+cTUx9Ekd2mOFA6BzAWOueNZspX/BQQZ
X-Gm-Message-State: AOJu0YyVj30qKFFWFADlJLo/tJhpCfDN3BZFcYcT01ntY46P4DvtkguK
	4pLlD3Uy4h1LURp5n99biXjuk0aTA/BArXzu0Oe681TpB9YhNhw66qKJ9nPy/scAEnGBOyHYReb
	5km8=
X-Google-Smtp-Source: AGHT+IH7syasty7HaTDsD5E51KorF8XfnrmM9ehc/fLT067hmE63RvbKOsoAR+lMidxzL11uJ8ieFA==
X-Received: by 2002:a2e:a5cb:0:b0:2ee:4a67:3d82 with SMTP id 38308e7fff4ca-2ee4a673edcmr21435651fa.28.1719499489631;
        Thu, 27 Jun 2024 07:44:49 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a34447fsm2775911fa.11.2024.06.27.07.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:44:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 17:44:46 +0300
Subject: [PATCH v4 7/7] usb: typec: ucsi: reorder operations in
 ucsi_run_command()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-ucsi-rework-interface-v4-7-289ddc6874c7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2214;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=8t+rc0a05n9eyrWDZO2kMieJ1aEfnXGXWDcAD9GfTds=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmfXratpXe2Md2H7XXIFiFlNCnAymp1cbi5Lu3s
 qKILWjJemOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZn162gAKCRCLPIo+Aiko
 1Vy9CACQ+eAL9dx+gexu83BB5XxVSv6Vuxl4xliWjn7OFQ5qhxpaKRh9ucFB2OfRdDoDeIVc18T
 MoqzXZJWA2gqYP1kStZ4QPCA6+0iw8+2UHZd9AsQKWvzcrmtuwKzwy1V462QBHKrujuB1iw/5CR
 T/5lE2vCu/gucwCPeeSYreoIpc6c27v32N8foNt1wKRy2iNpl5mhJloJqi00fHLWHDVVYTwzdV1
 5RKDglkwuPy7nsSYxwg/s/2tRnL8pyw70IotCuYqMpoix5oGImSWc8bxTX73YyyXJ6FCuiDNHPW
 +4ySKPNRD0Ud8QgBYaG+IbKt41a4Heejgijje2FTFn7iNol4
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Streamline control stream of ucsi_run_command(). Reorder operations so
that there is only one call to ucsi_acknowledge(), making sure that all
complete commands are acknowledged. This also makes sure that the
command is acknowledged even if reading MESSAGE_IN data returns an
error.

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 25d2ee5ee8bb..dcd3765cc1f5 100644
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
 
 static int ucsi_read_error(struct ucsi *ucsi, u8 connector_num)

-- 
2.39.2


