Return-Path: <linux-kernel+bounces-229115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2C6916B24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7DE6B270AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A26A16E89E;
	Tue, 25 Jun 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ot8D9QpH"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FB16D4FD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327273; cv=none; b=UYqqR2L2fwMKrCI10tWGgTE7+cpUGBmxpZ7oenyghu95ZWaWWmcsq0lZoyxEjW9Ru6b3qnj2/eHl1clynwTrkq1MqNDf+rov+MCiUCc0u7LLZNbrheelJDRJb7JleljCG+TmcR2wGzQM6i2Ybem2COj7pSdhPsRXKSINLduOlvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327273; c=relaxed/simple;
	bh=E+vOJjv2UvdlrXvKnRgzVGWs8xl24PgUq84JxgbpN+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mOVKtzWKl/Hg/WofKCcIqzeDdJxOTwWQh3e3sPzsgoFVNJ4YlzxsjmRs03pHGNtm+GHLJ1MZxY5BSrotxMMIDiyz56hcAfs6lSSJBCcPbmkphRnFN5Bup/1fG8AI+yfCCwrIWmDRLTXp4+xBgv0dP8cBf5vnMniqLZh2tl9/CvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ot8D9QpH; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bbf73f334so4352316e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719327270; x=1719932070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JAfmKGbaHSRN3BDyb2Ps0ChAgC9WErixxC6u5jSyHcs=;
        b=ot8D9QpH0Xknfeg0Zy7p5K+JY98y55p+aozKKMdlJ0TInRBT9ZaZUkxHFxC5NzATSx
         TFWPcowvZvVWhuzfn67ldXmKbn28sIEx8A/qQUieuKfG/bZoLSFyqP6EE2ddX7VyFolp
         IwB+J4wNr9oYLrC4eqcRDV4/bbCsjQXhP7eOe1bjujUEhRIpsO2k6gl/4pyqiReVeUdZ
         ajXuYUBYmokH1oyMeSqLO8hYaqt//bk+WEjUf7daLXMz7lP45QH+0hPCjb6Cu+kl7Xhs
         7pqBcD7lLK0vsYHUZelP0nPDP8axRfruo3M+GZJW60XqWUdLruD5ScNecRZMxWHVZCQD
         YYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719327270; x=1719932070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAfmKGbaHSRN3BDyb2Ps0ChAgC9WErixxC6u5jSyHcs=;
        b=JlfAGAXQjCDBquLYqhvnStGV+JTrE28xY48ZzYp/1W98SIF8+wSj1l+XjNRT1QNwyx
         9v/AProJW1ZIq1bK2PnukhydrSXEjDUNwH0u344EfBBxwdaZk56x8nbWXYzLrIoARnwi
         cqr3EN42Pdn5OSmPTDiJcFMjnnat886UoyKzw+v1J8RC6rXdsEpUYu7RRMdMwJS26VM5
         FeHJCHHMRCcxXEa+ZUY2G2MKE9afU8w6K6kZk21cDlY5EEX8oQtZ/r5ph14BLK7d7IM4
         51SNIyrsmjCSUti8elGTAQyORUJmuZWOemsQyCmiTLHr7A3uyMaJRZZ42wOI4jhOd8aL
         912Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmytzTQUD1lVR/pumz/gmb2r8dtf8WXs+Thqz3A/xMRhUtckitFzXJoFZJRTTFY4qaMsCoEDDgjxNUIGZZ2cnLW1NgaQbcCnuDtF9D
X-Gm-Message-State: AOJu0YxQUnKjnvSD5P8JL9v1dr0U39UoWG0/vYhgBzLkveo2sjcDB1QB
	4cZfi4MgllBPysG0Tgoiuldvim4vAQW6RVNoo3gFnKefM4kVBlypCf8mP5TU+Lw=
X-Google-Smtp-Source: AGHT+IGZFf/nSGa2e2d62pxL5I+qOFEUEnjG9EKzs41xvEO8rAlHlgWJuddbGqx0uxqUQDIYsbz3Rw==
X-Received: by 2002:a05:6512:453:b0:52c:d943:300f with SMTP id 2adb3069b0e04-52cdf7f6705mr5392914e87.38.1719327270161;
        Tue, 25 Jun 2024 07:54:30 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd64328b7sm1251877e87.221.2024.06.25.07.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:54:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Jun 2024 17:54:26 +0300
Subject: [PATCH v3 1/7] usb: typec: ucsi: move ucsi_acknowledge() from
 ucsi_read_error()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-ucsi-rework-interface-v3-1-7a6c8e17be3a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=E+vOJjv2UvdlrXvKnRgzVGWs8xl24PgUq84JxgbpN+M=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmetojmtp4D7cmDhXFyPFb6rzvpO9SqHUmDn68o
 x84cE4DSNWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZnraIwAKCRCLPIo+Aiko
 1dsqB/wKU/73Da/F7fXX3mKihmmgqnEt8z5DsYc/2Ek86sZ2QOVH5pcoOyQjGE2tEHJM1A460DU
 fniZ9SvZ17LHTf335zpqrqK1baAzCc7as/KU5FPsnsANZRV0di+AWzepIIFaNaN3bkEDgvyhGv3
 D9plJZY56ZqgzDBYL4OkX/69YyQk2ndc/DcQOa6sbOSLN+5tjeH9gnPwh9coPGY9Cf2n3auuqJz
 1jSXserA6xSdR0TK2kuorPqnD+k9K6yufTUWdeB5SNheTQwuDx4uTO2SUb42q1522ZwVKmxA7Bp
 KSyWF53xjvQ5qHB3NY1c+iU9Gf62IqbUUg5WbVjtBFRAZ1HM
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

As a preparation for reworking UCSI command handling, move
ucsi_acknowledge() for the failed command from ucsi_read_error() to
ucsi_exec_command().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 76c48d873b2a..297d939e8da8 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -70,11 +70,6 @@ static int ucsi_read_error(struct ucsi *ucsi)
 	u16 error;
 	int ret;
 
-	/* Acknowledge the command that failed */
-	ret = ucsi_acknowledge(ucsi, false);
-	if (ret)
-		return ret;
-
 	ret = ucsi_exec_command(ucsi, UCSI_GET_ERROR_STATUS);
 	if (ret < 0)
 		return ret;
@@ -153,13 +148,14 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	}
 
 	if (cci & UCSI_CCI_ERROR) {
-		if (cmd == UCSI_GET_ERROR_STATUS) {
-			ret = ucsi_acknowledge(ucsi, false);
-			if (ret)
-				return ret;
+		/* Acknowledge the command that failed */
+		ret = ucsi_acknowledge(ucsi, false);
+		if (ret)
+			return ret;
 
+		if (cmd == UCSI_GET_ERROR_STATUS)
 			return -EIO;
-		}
+
 		return ucsi_read_error(ucsi);
 	}
 

-- 
2.39.2


