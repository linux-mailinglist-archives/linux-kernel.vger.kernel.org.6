Return-Path: <linux-kernel+bounces-232491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E86D091A996
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E69D2857E9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1744E1991B2;
	Thu, 27 Jun 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ISjkY0uz"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BADE197A62
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499491; cv=none; b=P4UlrNIhbbmDCY14BDE2CZIyc1zQEdfFwhsVH2k7u3GBA+OTKNM9fDY2iplK9mYY93qfZF39NfYd1oHjcNslMak5eQ9K3NBfHS10+O1X+4dCX7MwKjvynrKempukWjWuW70t2PZg18e6nOPR/Nf6mYFoDUXBC0VNNj9YNpcXxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499491; c=relaxed/simple;
	bh=SvL4pINrFSRfen69Stj/4WrpwjGf+jKWJ5TFSri6EH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LwcUnZ2PvElN/09EsVP87+rbnODlu6ykMFol+Jk8PwdfCa43z6+RyJOs56bYCI8pTRJgVKQ16cTz3SsmNyQIugI1KmpvG5WV6cbfpY+q1el1F+1b23KAzjofi4KIH+H3idbVKcpTG1Es1xFn8ydJpgWrpOkOp61nHEldZNpfHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ISjkY0uz; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so89986221fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719499487; x=1720104287; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efQFGr6jGBKjwmMdwj9cOaioErJGFDxQ/6GTKiEu6I8=;
        b=ISjkY0uzEaUKcTtmmBcaXyQRxc1savsL7LlDJI4PU2yAliqWsjRZoOwtMKYp6bkKaS
         fpeOfZYJTDyahVPxMZcZ8bd/jInub/R+UaNGs92FsILEYzsJ8d46INI9LcxT1VWowtak
         vZVhpvaolnTF3VPauubJKpsI0C7XcPewsL7KdgeX0MaYVYvwyiwn5TP7oaF9Zv1vmYiP
         H7XF0SByhXDL8rPO+vutbPLGbpr4yIPm4ceRu1YgNH/X15NCPjBFhQ1KNy31J6Av/QWo
         sEl5yVKx7VadGt2E1Wsd0t4WSqkjpLJV31UM618JVTP9LV3KLN/iIJU1ShhDjOPV4VD0
         6GDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499487; x=1720104287;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efQFGr6jGBKjwmMdwj9cOaioErJGFDxQ/6GTKiEu6I8=;
        b=oDJiMC5E+l78i7w7NldIZ72S3+7BkgqSz9P5Me3ON2eUxjcy0/TtTaQO9co7pQwoxx
         WrEWbQcq4n7h7peb9kDiunw0S5ajpwKX1snsY8XFLf7k6FkvWJKZTPkQLPundgrtdRnw
         uBu3kFFOaNhZ8G5OXq7saJbjGAaAqfNtio50GSr0/7FuhrOY6GViVzq/cQ6k9wfPJd1K
         ZKaQ9pfdBkoFgeh7MaTs5zPO/YMQ9Rwmh4AyoI76XJBfiT+UIwIjJ/GRD/pH+KqEIUzS
         oWujqf1fu8qIZsxomQOL4IdPZZCnLhe93DkbvCLfgjkZAb5NiHVnDKfeeIxtjtsXjdFn
         wYNw==
X-Forwarded-Encrypted: i=1; AJvYcCXjD3PNOUR3S8dMFYrm07P69k0WyoITVub15PJIXMWAldK4X7rsOCfg2xKlfG2JXQ8BIKYOPz6BtjErbA85LEbGa4jOBjL/IwLATqm0
X-Gm-Message-State: AOJu0YwZpXKdaW5W/qQqyiHMix7HTcgKvSag2Vf95yA5fdOoZceMpTQx
	HweZwnUcFogkJLBNkTqFOYETK+ArT5XFSX8+a0+7kysKFAcL/ieJflTIVz53/w9Ovq+k4e1v3Sj
	gVOM=
X-Google-Smtp-Source: AGHT+IEEpm4AxqCI4MvWw10l4nicg9YGmxodxCLh1opitXtQr+B6jBW4EVR2xxnMzOMkHx2ZA4GduA==
X-Received: by 2002:a2e:9e96:0:b0:2ec:588d:7eb8 with SMTP id 38308e7fff4ca-2ec5b37a303mr79821721fa.21.1719499487664;
        Thu, 27 Jun 2024 07:44:47 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a34447fsm2775911fa.11.2024.06.27.07.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:44:47 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 27 Jun 2024 17:44:44 +0300
Subject: [PATCH v4 5/7] usb: typec: ucsi: inline ucsi_read_message_in
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-ucsi-rework-interface-v4-5-289ddc6874c7@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1732;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=SvL4pINrFSRfen69Stj/4WrpwjGf+jKWJ5TFSri6EH8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmfXrZIK3sNxYmewLsvSN+DxSJY8UC0w0Xoamap
 /iSt4ILkayJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZn162QAKCRCLPIo+Aiko
 1TewB/0eEGE2cnF0wQ2wiEEsma6QExZ1Yav41XkW8NpVgs9JLW96sutdqzAxS5BpJsP1PoyaRCD
 lVRCv4c2T2eHdMrZRGrTExG691TNA1w2rDx/gDgFf7lEdxtOwgxSmsxk+CZrGAP00z9k5kHoWNY
 Vl0IFKa8sP3qSpbB0wkrpjQtK2vRBUgU4B8WqycBSdLOhQ+exl7xVKHjc0No1McFtSOU7arST9a
 zqlmROo8rQ3p1nZ3ASP///xGQKpo21+K1ATF8ekM5/kHEdhrW88lVnMrvqP88SBLbPnauJG13pH
 e5DyIzX3Lb9EIQqQgnWEHAhv8mFDrOhGm+yKzc1znzn2VMcp
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

There is no need to have a separate wrapper for reading MESSAGE_IN data,
inline it to ucsi_run_command().

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 10a8fe893333..2d87fe277c62 100644
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


