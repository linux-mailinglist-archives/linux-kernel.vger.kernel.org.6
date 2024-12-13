Return-Path: <linux-kernel+bounces-444666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F04A9F0AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D069D16A5F0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD851DDC32;
	Fri, 13 Dec 2024 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xDtMQgf3"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC611DC185
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088505; cv=none; b=eU0Ckj2tpnDlzBucYHHYo3b5dhGCbtXXQUcl2A2TVg/uytkPq7o0v6SXt50KiMM9aBJLPIh4UUCPrWlUCsWCgg5dDH/Q+pYQQfJMS4/Tdxae0SwzrkCIqvYVPHRtF0OpqN/dAH9xpGDtsGCoYOCIvP0nECpOWEVp6MflL4UV0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088505; c=relaxed/simple;
	bh=ttOyJrv8zTHg2rdoVVji4pSdjZVcBW8roI/XvLsijWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c0fYOLC9nmWNKsVBTpKPNWXU2gqIXY9/Jqv2bVx2vboU5L4n+uR2v8ugOfuMviw2WC/2PVLGGB1IECWJ2iYdqAmx5Vcc5R3lw8N1sin4Cd55Cb2uvQn+xcKfycn9Ng0/lXYQ8QIbmuU4WViDEhwkLR66KZM8vnDTp/1NpxyLRxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xDtMQgf3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-728ea1573c0so1395103b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734088503; x=1734693303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+wfFQYskdV7aQkNCJEMkDI7qXAKUnSs82tZtKJNPBU=;
        b=xDtMQgf3u2pvgi2m1OzkajYDbgeMHEKYs7qsTaZ5SNCxWtcq1VQu8SncKdFTOZIf4H
         +Bx+0m3RDNy4GWgyui2KQU4jinrunOAIeYNy9AVxg3E3OfCnTsAeuWI5FsiD4ASHyfML
         zczI5zY7uZ9pqElzAi7b5Fn6Cnq50jWULNxQR4EErMThCaqhlGHDDcsBskP3ECz4VG3M
         CJiAg10x1HAqDYi/yUSSTXzEZC40teCYtl0EEVhyEP3SPyRrvX1c5ui/UNZlkLNMsQrC
         cFYzi5RdzVAcvSHsbW5wpf6zJR0cLwsyLlWWWa7wF/vk5F4CvnjaGq6ogNgMUW4bqj+F
         n+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734088503; x=1734693303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+wfFQYskdV7aQkNCJEMkDI7qXAKUnSs82tZtKJNPBU=;
        b=TtIC+xIUfDmkaFpNUbDdb8ZXW0C7oEMEafEk9C0NhVXfXBFJHnw6r4s6mwE1973ofu
         7WH/jVHPeQjEaz/RLWpcAyx7WwhiaymB9F9/Qrd7m7ym4zLLgANCa/JvYp+LkARISchl
         ZL0ukg6ClxWrzf0pKlT5VgHjfunjfThdPuxQgCruCBsM8ufa1zh2Ty8/e4F1HdQhifsb
         /3sR0KIA+Qn+7MTMKUOuuyI6eDMZXJW2Snh9Yxj8vC2/IadxzrCjZAYPR61Lbmc7yNP3
         MdGNVGnbKsacNvgt8xo//HlOFt6Shw01DhSM/stFQYWGGx/8aYx/xpclZBwkCaqWjkOk
         t6MA==
X-Forwarded-Encrypted: i=1; AJvYcCWfx4Sd5P64/2ZqkgqNI4uYQn9uPCgQZk/WCkdrQ47qQThmHjAGBpGvNQjCGLidfFqav8zKlr6axn0nSmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypfauYPRpbqCyazdpQEn4AUAHiE1ohRB5iIzJFF1wpAS8M78yw
	AgdAH3CNtninqZdv5VtnCe+Wj5ijm6K0ATRhMuYKZmu9hDANIcjHLX5GDceTsZo=
X-Gm-Gg: ASbGncsNHzpLvaqmwXJEbdXtslilsakoMUCoHhOjPXCD/DghUSzePxqYyjYdAXu4DZk
	qCkvr2JMK57XjIlsel6bWRps6AroZ2fubxbMVeQ6megwPmSmQLxRFXBOETHndPHGCDqO5ovSnf3
	eU1ArncfmzcEpZ2KUuM6/AmRI03VGaavjkz9apdXNHsc5tzePhZSsKxj8l7tfHHOQoEQPGUzKLf
	RLnnok+H1EoHr+IKGw8FpBhSNfUg3nlwJlhWUJsVHVuc3kB9Z8PC26UfA==
X-Google-Smtp-Source: AGHT+IHMP0tqN0159Cr+hX+i6SOe4cEmnLTXhyBAlKbVDf6IqAnpjnTZYY0YnF0SddNDQJDC66IhCQ==
X-Received: by 2002:a05:6a00:4c19:b0:725:e1de:c0bf with SMTP id d2e1a72fcca58-7290c139e48mr3293884b3a.9.1734088502720;
        Fri, 13 Dec 2024 03:15:02 -0800 (PST)
Received: from sumit-X1.. ([223.178.210.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd55eb21e9sm7297807a12.84.2024.12.13.03.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 03:15:02 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Cc: jens.wiklander@linaro.org,
	jerome.forissier@linaro.org,
	linux-kernel@vger.kernel.org,
	Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] tee: optee: Add support for supplicant timeout
Date: Fri, 13 Dec 2024 16:44:53 +0530
Message-ID: <20241213111453.367031-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

OP-TEE supplicant is a user-space daemon and it's possible for it
being crashed or killed in the middle of processing an OP-TEE RPC call.
It becomes more complicated when there is incorrect shutdown ordering
of the supplicant process vs the OP-TEE client application which can
eventually lead to system hang-up waiting for the closure of the client
application.

In order to gracefully handle this scenario, let's add a long enough
timeout to wait for supplicant to process requests. In case there is a
timeout then we return a proper error code for the RPC request.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/supp.c | 58 +++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 322a543b8c27..92e86ac4cdd4 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -7,6 +7,15 @@
 #include <linux/uaccess.h>
 #include "optee_private.h"
 
+/*
+ * OP-TEE supplicant timeout, the user-space supplicant may get
+ * crashed or killed while servicing an RPC call. This will just lead
+ * to OP-TEE client hung indefinitely just waiting for supplicant to
+ * serve requests which isn't expected. It is rather expected to fail
+ * gracefully with a timeout which is long enough.
+ */
+#define SUPP_TIMEOUT	(msecs_to_jiffies(10000))
+
 struct optee_supp_req {
 	struct list_head link;
 
@@ -52,8 +61,10 @@ void optee_supp_release(struct optee_supp *supp)
 
 	/* Abort all queued requests */
 	list_for_each_entry_safe(req, req_tmp, &supp->reqs, link) {
-		list_del(&req->link);
-		req->in_queue = false;
+		if (req->in_queue) {
+			list_del(&req->link);
+			req->in_queue = false;
+		}
 		req->ret = TEEC_ERROR_COMMUNICATION;
 		complete(&req->c);
 	}
@@ -82,6 +93,7 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	struct optee_supp_req *req;
 	bool interruptable;
 	u32 ret;
+	int res = 1;
 
 	/*
 	 * Return in case there is no supplicant available and
@@ -108,28 +120,28 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 	/* Tell an eventual waiter there's a new request */
 	complete(&supp->reqs_c);
 
-	/*
-	 * Wait for supplicant to process and return result, once we've
-	 * returned from wait_for_completion(&req->c) successfully we have
-	 * exclusive access again.
-	 */
-	while (wait_for_completion_interruptible(&req->c)) {
+	/* Wait for supplicant to process and return result */
+	while (res) {
+		res = wait_for_completion_interruptible_timeout(&req->c,
+								SUPP_TIMEOUT);
+		/* Check if supplicant served the request */
+		if (res > 0)
+			break;
+
 		mutex_lock(&supp->mutex);
+		/*
+		 * There's no supplicant available and since the supp->mutex
+		 * currently is held none can become available until the mutex
+		 * released again.
+		 *
+		 * Interrupting an RPC to supplicant is only allowed as a way
+		 * of slightly improving the user experience in case the
+		 * supplicant hasn't been started yet. During normal operation
+		 * the supplicant will serve all requests in a timely manner and
+		 * interrupting then wouldn't make sense.
+		 */
 		interruptable = !supp->ctx;
-		if (interruptable) {
-			/*
-			 * There's no supplicant available and since the
-			 * supp->mutex currently is held none can
-			 * become available until the mutex released
-			 * again.
-			 *
-			 * Interrupting an RPC to supplicant is only
-			 * allowed as a way of slightly improving the user
-			 * experience in case the supplicant hasn't been
-			 * started yet. During normal operation the supplicant
-			 * will serve all requests in a timely manner and
-			 * interrupting then wouldn't make sense.
-			 */
+		if (interruptable || (res == 0)) {
 			if (req->in_queue) {
 				list_del(&req->link);
 				req->in_queue = false;
@@ -141,6 +153,8 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 			req->ret = TEEC_ERROR_COMMUNICATION;
 			break;
 		}
+		if (res == 0)
+			req->ret = TEE_ERROR_TIMEOUT;
 	}
 
 	ret = req->ret;
-- 
2.43.0


