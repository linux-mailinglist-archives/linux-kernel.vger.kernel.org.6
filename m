Return-Path: <linux-kernel+bounces-223651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B907A91160D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 00:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC97B22AED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 22:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C7615250A;
	Thu, 20 Jun 2024 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N80MIUB5"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E914A4C8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718924130; cv=none; b=bjW59YcClcJcAFIjWLZs6EhuFz2rCfjq4na+jeHtP8zP8fAF4sOUcvD0nc550EuvppDwrzOxLDqaodbPj6xW7SqDRspVyioK9IFrrjX1w7ZDuRrj+fgKZMsRarmF0TQjCgQaJBfyKY9dz7zYQG5+uF7c2J1St8EIPH5UISnPNVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718924130; c=relaxed/simple;
	bh=5JJ0FuTmJ51m3GFnw66fokeLW92y7ep22LnE63sLqV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nn1qKGoven7LUOYf5PgHQ3JUw0zdCEXAIj4IzIp0azubl+H/RxceH2a3ZQgER6i/x80UiHiZtysgPXq/3LmoC6znO3t9rd1F3AtiLhMk7hDeg6v0Xh5uByMPZV2kwRgiu5VO4TT0Znqw1vtj1vZIXWIitURktgBWc5HS14jI0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N80MIUB5; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so16710981fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718924126; x=1719528926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQohNPpaTb5KYVE0BZu3/ef4lat3R4WjEfszMMJQNKU=;
        b=N80MIUB5+2q6R87c4+soEPY0/k1hd/AyuaiX4oyMjRurtONCYTe8WCzgZtGpBA0MEv
         LmvtQPhLZZDFaJoEhpG6+lqnWrNKoUYaK50U4nIe6pnm0BpCAGU8om5PQ1PFAK3xp5tY
         XyLS+jwwaCQHNM5U9PPw2ViFag1XLpmTEsLHuIhRj86rpecR46TFIgjzHqf9L0DHIzT9
         n2BfR2hPmqOdvXyg3SM8poo5kDXLcK7DyQ+6cskHXQHZcRHR+axLp2riFAUC0CSINgor
         BvlF3ZKlhLoNk2n5ixCYDcpX+8GfbS8a0vsn7H3RpAMa9RMQqoJrvIFFV2x45+lxRvYo
         FaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718924126; x=1719528926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQohNPpaTb5KYVE0BZu3/ef4lat3R4WjEfszMMJQNKU=;
        b=qcU2C4gwEDSe6KzU1SUAlSZCKb2xIGZUja2BQEjGuhKUo9cdFm22hBE//nvbBoEzDV
         1kiynmgY2qBFwGeu7Pw+ADjcHXyrkCJiQJrYNjkysxOjz9vAiiZkFSOcM6J6/I28+Pwm
         Gxkbc8bA5+KkHhWdGomKuf8PUu5Bivk6u+8aqx0KiBHUTVZxSxwWdWYlDzhN7i3UOYaI
         OErt+wS92CmvLpTJeSy3n2YAq/0CAWJ9AYUWQy8x1nJvv/jRZWGHjaB5KQn/qf3+BSdg
         tm64QP0h8I/ewnoVYOHaIQAaxLGlXYdR7FHZqObDjOgXXn7fE0ovWGZJ37IaAw1M/kGn
         DPvA==
X-Forwarded-Encrypted: i=1; AJvYcCXh7MKv+h0wucLHBBuGcdK6OmkB/ReKR0XhOyTOzVxed0J3K+KTwc9ZNVE1XRi7nlx8Y4TBxYQfI3L2aoShricXxV3elBsC4frbOejk
X-Gm-Message-State: AOJu0Ywqet5qNQySbNuq+FWIeorAZq9A43fwO0nVc4o+UPjgnAFKlo9F
	bD+4lvMNgGT1pJZDOJ/bssuRGsVY5ZUy+MN8VM2PtsM72rjAigZHnQhKIWL3YK8=
X-Google-Smtp-Source: AGHT+IHiX4zKNBalbolTrJjjqJsWAjc1/tOmVInlXcwDg2oe43Um4+0q1bXe0brVi/wRnLVylxIuGA==
X-Received: by 2002:a2e:9e16:0:b0:2ea:e98e:4399 with SMTP id 38308e7fff4ca-2ec3cfd74b1mr42903741fa.36.1718924126551;
        Thu, 20 Jun 2024 15:55:26 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d60126fsm510461fa.20.2024.06.20.15.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:55:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Jun 2024 01:55:24 +0300
Subject: [PATCH v2 5/7] usb: typec: ucsi: inline ucsi_read_message_in
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-ucsi-rework-interface-v2-5-a399ff96bf88@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=5JJ0FuTmJ51m3GFnw66fokeLW92y7ep22LnE63sLqV4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmdLNaDofb3amsRcu0qvjDc9UZGAvmIhod3B7mD
 g3oylyO/0iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZnSzWgAKCRCLPIo+Aiko
 1QtNCACdBMXW0rp0duCVy1o696WTIt9Z8/8Fok4J2crdv8mHpLp/GVcEY0Ukoxe3RlnwPD/5UVu
 kxoogwkMVQAh4Dr1qvYAFY/Kte2dVgLzhY1tvMt+mBGza88/7dXk0fuXBKuqQooTBylLFIV/j3l
 LOozQbRYT9JrdTJ7epm7qs1OjKBfmG9qrKZ5hIf2Y6mhXA43e40xiBqBY+fwfjpWaJn+uUQTcpe
 jMIL3J/BU7/NkWKmtt9ADgm+4sxLJaPHfAwIAJQA5sMmD0kssmK79YxPf6lZNt3mI8OYZUkNC67
 Luoqk+ml0bImb8JxFgJ+JbQXLrTnXwVtQgWJD25MA+/Nbgkv
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There is no need to have a separate wrapper for reading MESSAGE_IN data,
inline it to ucsi_run_command().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 58d9602bd752..4ba22323dbf9 100644
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


