Return-Path: <linux-kernel+bounces-232485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C11191A983
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CD5284CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832A619882B;
	Thu, 27 Jun 2024 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iI/iXE4o"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50321974FA
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499487; cv=none; b=OAmdjlVlvdQb44HmNdI5QKbp97w9Th8f+VlrudoFAhlfjEyDqEMvTKYyVDtmJedddkldmsyO+gR9pWqN490w4swHjEVck/5Vk9heo25D7jhFvdtqGXiL+gh6+k3+AIoilkadqpvqsk8P6Mg9tcJqKk7LIbWaIIzLNy7T+Kv8EKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499487; c=relaxed/simple;
	bh=RCY/4C0+GrYFBzSYId6jLzfsNK5WXotKJnVh4nnnjG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r4wz358agqel4HAAIVxd/h3AaEn36dMPEb9hAypT2lJLMYEhOSHB6RacGzwMtw0MHN1oI70U8DAQDdJhf1GmM3HzxQNKBk3rByZO6ZSBDH0CIXqARy8dxTLTlIIxnHA2k2arE7hGJ411xzw99w7ALO+wN/YjE1jvlihVPtbAm04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iI/iXE4o; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec58040f39so55417871fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719499484; x=1720104284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWQEDBR2cvKHd61KPN3Oc0zu2avyS++NhmAlrTQ8dMU=;
        b=iI/iXE4oZULgFvOOa2KTmIwztrvc1sBqm+2Odc05mhcd968nLqnOjTn9HO//hi2Zh1
         7MhsDL0u9Wi34xSuoq9252mHbIuy4JR95bJfHbL0aeAbYGTNK+AVgiFBjA+K9TeyOYG7
         XGZgZAnL74e1uGJJHnhBA9kN8rIoGIZw+Y+UD5xu+y2mVfGLMuGrgu7CHNE8SEuQBY9D
         ZW7XoTSSotqrxUrSwK/NrplIXFfEkxpPG8l9sBx9tYzpDbG2dwFyEkHx07O2m4DHoVsS
         1A4szh8REpcHuvjg6LyfylUx4UFhiKQORDKbsiGeeOLtQTCv4sMvIU/Z82pwpgyAvlOd
         njDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499484; x=1720104284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWQEDBR2cvKHd61KPN3Oc0zu2avyS++NhmAlrTQ8dMU=;
        b=YphJk4GesyqLt+Hl50BoFFk/pW1pr0FSu+U/6SdXLTEN1PD3gi8BTlAC2/cj/SOdmG
         3Opx4WbTkGGdFHgtuqxJkJdRqf9iPZJ/y184u1T8x5312T2fa5vrf4XuCjy2+z6u+wJK
         UsZ0a5VWcdNVzMEnqQfLMRUuwF8AdcRWppuLigh5NFZlbNZefLlxEvnuYubni6uFIbT7
         kUniKvtGTs0tELe6aZDv8PcJePw4wTIIe4u045jnSqnZmXQ7MRn7LAsxwb2sHdRVuQv9
         G5ciy1rtsEwmlzmA5nTxMbhZDHq/3AJqXgOlhUPn5eOR5i0frE5w3xUCG4BGhfoEwp5B
         ChHA==
X-Forwarded-Encrypted: i=1; AJvYcCUyGRN71f2QkNLaVCkaEuasfJbOp+x9wwwxWcCU4jv4ET/m/hggp1D6hUqzzxtFWTqJ9kX86H8CrNlp6fEiTll5FOHpm7cO5/HV6+nR
X-Gm-Message-State: AOJu0YyOTgGk8Co82A0BfljRvEVyY2u5FbCGASIWjOy2124osRY4QYiQ
	Vv53qwbrrWa8TcWSinYoKwsDT0CuxGuaChHwt2L0NMWua1YU/0YlsYFqidk2icgIeQAQacWy2uj
	FHPI=
X-Google-Smtp-Source: AGHT+IF8lRY4yxVYxkR4RRTjf0SHogAEtg76W/F0NnLyvHUeyA8JM9QhKMO2Pbyo9TObJ219yDtmqA==
X-Received: by 2002:a2e:9d81:0:b0:2ec:57ff:92c7 with SMTP id 38308e7fff4ca-2ec593d8613mr85645941fa.14.1719499483920;
        Thu, 27 Jun 2024 07:44:43 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a34447fsm2775911fa.11.2024.06.27.07.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:44:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 17:44:40 +0300
Subject: [PATCH v4 1/7] usb: typec: ucsi: move ucsi_acknowledge() from
 ucsi_read_error()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-ucsi-rework-interface-v4-1-289ddc6874c7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1498;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=RCY/4C0+GrYFBzSYId6jLzfsNK5WXotKJnVh4nnnjG0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmfXrZ1Gmvzxm4i0ZRKQCtxunw01G50Fjio700n
 1wqd1wu/bqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZn162QAKCRCLPIo+Aiko
 1eSUB/0RSAnq/bhc3trWD1uYPal7bW48CKzEDX0qEHMDzyjk1GJlHlUnP0d00i2vy8nmi4Y1sGn
 JAiSOJ/lwWBwJjTPJX+SM9WsqCMpMe+OhNP0pqyWhqupbTGR/xgmDHGDJN2LlgU/i9TwEYv+syQ
 JtwlhKuXilFvwSmQC0JHXxvdRzCHZ6YbtmckLEsqLLKsM8LmjI52G/ak/FSYcgemaKyXQs/iinQ
 bGgfFtTdVreI1ds55pjr1dCQ02q4k0RWJlgpVVqNAa43/P04n3jC5shcezrTu99ROP34Y0ORwxe
 +6Z9pQxIEgaq8/bd0vT5Eeas2kReYuVdzwWPirdh2qdhBySr
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

As a preparation for reworking UCSI command handling, move
ucsi_acknowledge() for the failed command from ucsi_read_error() to
ucsi_exec_command().

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 59eaa49042f4..651c22473472 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -71,11 +71,6 @@ static int ucsi_read_error(struct ucsi *ucsi, u8 connector_num)
 	u16 error;
 	int ret;
 
-	/* Acknowledge the command that failed */
-	ret = ucsi_acknowledge(ucsi, false);
-	if (ret)
-		return ret;
-
 	command = UCSI_GET_ERROR_STATUS | UCSI_CONNECTOR_NUMBER(connector_num);
 	ret = ucsi_exec_command(ucsi, command);
 	if (ret < 0)
@@ -182,13 +177,14 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
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
 		return ucsi_read_error(ucsi, connector_num);
 	}
 

-- 
2.39.2


