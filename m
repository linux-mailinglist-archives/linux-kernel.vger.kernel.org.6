Return-Path: <linux-kernel+bounces-429087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D581A9E1732
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB341658C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A191B1E0E1A;
	Tue,  3 Dec 2024 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XtisRaYY"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A81E0B86
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217600; cv=none; b=a2jbAMy3GdbhsroyM0vr+jlxvoPbtJrfYbCr2Rnn5AfrmXCGYXhU6pOHHZjtr051LCBAr5hOsiEDzluZp0/CVPrdounmwYuGTkkP1egR36qfhvV8fZIXXCFTxR0pcWCaxpXunbj97d4YbhiwgyfoLn+NCE7BhcY5bqcwEE7gXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217600; c=relaxed/simple;
	bh=v36RVXGvlTlE5sonbFp2YQfvFCSumnQSXer1pNGWy18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hX7yNCWO5GpOL0VGGfS6sefEjRXxskDGmo9tsS6FeCD7/HRwP4T+QTSg/VaS5XgoKkV7QYVvg2atoVHp/KJRDqPrnFy/PxdtENGAxXkQRtWFzAdJnDF7VZSoskiqhCHCoduKIY40whZvOTVpbWMigB/uz01wH4fVReR+b48d5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XtisRaYY; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffc380b1d0so51878621fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733217597; x=1733822397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRH6cj3Zv8oaIGQjdTXxz7Bjv+j+MCyGC3Pj/yHr73E=;
        b=XtisRaYYgyhnxc3gwkcsw30NTSoF6RBvVNHu+HKfN02hC+dCyXuxn0fkZJRwqvJRlx
         JMyyDjdMX4juz2flVicS2macLirGcefaCmsoWQO4ipEm8Q7k69awHUcqOCQDYbj9RLTL
         o7CedU0Cg36FiJTIzpywIpd3F5dM5VlNQ/DShekc9Hbqj3cVi4nNUFGfkpI6kDdr4cMP
         orCovM2LFaRnQPJXiOpKR8km0uNd6Iw4BfgZVjAobQSnVePBaprUB0HXS8hqzljZmXC1
         viF68Vvu+V1r425w6i5d7egn0Ra5jNrmiUt8Ljk97pInM+CXfwRuDTc8d8dCyrtuhXIJ
         WHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733217597; x=1733822397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRH6cj3Zv8oaIGQjdTXxz7Bjv+j+MCyGC3Pj/yHr73E=;
        b=UXtZPDXnR+2mruW5Cog3g/yI/R02pQu3Y8tJg+1jByrOEyVGPWNgWy/CsRdYU32tj5
         FpZJcv6Z/BTNVGIrgTh1x4ylFmTe76Hfk6bdIwpaRbBYW6w9aR5et3qlaGiN4sON8erP
         g2HsxtVdumtNVoAYnTtnyCigCO1hEIrHVyWylJJu5KoFxry6pYIf4owf1EMcFukmfVf0
         gYqZBDEaxJtaKNpHMq2mLIhU4byTRxTqQFk010Bt0NWF4mdA35IQceAytSQYfE8ZishO
         VC2xIUfXaTb60j8UzNtcqnvVyrfgIPtsrub9dFD+gtZRbm8GHfQlOOHG7uT+uIcdyqwS
         Z4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWC3hWAu3ZFg4T5ykwncCudV8K+Y3852kJy6fkfZLlfRuTFkdw3uQskR1WeAA/XnzrniP+gdnVuqHi4DRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpINogzEYRzF9h8UVXuf+EQxDQpzyupVyreS5tV+eMibiIQY3R
	kWLM3VMl4x2hrJnNv2NvI3AEC2+20UpGV0ckE7CO/xygVqqDKNNC96v+TeTGsmY=
X-Gm-Gg: ASbGncsi00vDFqQqiQL2ii5RCbqk/bX1FTbnsGJGldTDGBeK3bJYJ6qMpU2jOzzsp+f
	U5Kr+/9UzqrGmPZLngAHMZf6OoURVw+g6BrkEPU0XenBNDVPUs3Xm15vG4Y2kpTSa850cnUF2JM
	8mYPM40lCWZAd9BdoRyJ3o/Gu0KVR2EMDO3Uin267bCEx78PmPxOE1HI/3QiJ/cVfrCZxkm1ZMW
	A3gzmmG+O06FfKPiQ4HVL3BIdpFDZksDedcY+p6RqCTqpbxBqxNhsNdq5uET4XLE7wU34j/IL8Z
	jZyi3Ls=
X-Google-Smtp-Source: AGHT+IEwQO/Tj+5na6vVlqf2KeawHQpVSNxOc1OX2QKgNgIzhPI5EiWxtK24ZF8BHykiFaKddauGmg==
X-Received: by 2002:a2e:a98a:0:b0:2fb:5a42:da45 with SMTP id 38308e7fff4ca-2ffde23e531mr75703801fa.16.1733217597191;
        Tue, 03 Dec 2024 01:19:57 -0800 (PST)
Received: from [127.0.1.1] (217.97.33.231.ipv4.supernova.orange.pl. [217.97.33.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb915esm15591811fa.19.2024.12.03.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:19:56 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 03 Dec 2024 10:19:36 +0100
Subject: [PATCH 8/9] crypto: qce - convert tasklet to workqueue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-crypto-qce-refactor-v1-8-c5901d2dd45c@linaro.org>
References: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
In-Reply-To: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
To: Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3375;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=bX/So5owe8asnIGgm+prnF/cLGwAYLG//DR0NWiAu7o=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTs0ybBYqgSqrqtV+nWWBjSFG4iZy8W0KJW9i7
 snficeCg22JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ07NMgAKCRARpy6gFHHX
 ckoTEAC/aYy5y66Se3hGIFX7dhzL9YSeLFKDk28WP24GKvN8fuYnDYupADG3wSgLOePVz5E3NUu
 krZWznJMKjOFgtwtk48FdqZLOoP9+vck+xqBQ8p7dcedyRqnnERZa4xZBJBdHOqb0/Q3FVoDpiZ
 QTaSt2n9flTMhiaU8ltUkXSSgV7yc9I/9+7YXNoTsAHvnZ60MRtTcDv3OA25+AR/ET9C9863eC1
 Dri7s86tK9M5zrj01TyStIUp/51YctfejFIczenhXHFW3/P+ts8l52OjvKXQSu5GkLITJasOxlM
 iHg2L71MfkleKyUZy+iFDIb+cbdnBizsV1VBj6jwEBBpYlLMN1esVskhj+zgBegtF0gwuxBDmIi
 V09vulaShhs8/sUEXx2LmgmvxgXNQRpnZJekiRhywTcIj2/0d0ARJ1QVSTMrpB/MWm43NP3PVPw
 Uhe0RAiGGMec5MXtFjs193sy4YF55Zp8vBjZiKiqe+qLnqsm5YcZ43Lv9HUoO2UypLhwufnf0wo
 2BKFQ/TQi3ZvEhljuy0NGlAhQ/rc730clVFbRSN2qKKXHV/7Cqu3VJhlDx0dUAxISury/FdVn8k
 8VtWB6so1T7EHCG7P5Oi/Khnjuz4BXGmG/9lhxD350vBYtNbLGOLOPgF8dznQIzod2p8UsGgFPC
 vo4rYQb0RrNBHmg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There's nothing about the qce driver that requires running from a
tasklet. Switch to using the system workqueue.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/core.c | 20 ++++++--------------
 drivers/crypto/qce/core.h |  6 ++++--
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 5e21754c7f822..6de9f1e23e282 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -122,15 +122,16 @@ static int qce_handle_queue(struct qce_device *qce,
 	err = qce_handle_request(async_req);
 	if (err) {
 		qce->result = err;
-		tasklet_schedule(&qce->done_tasklet);
+		schedule_work(&qce->done_work);
 	}
 
 	return ret;
 }
 
-static void qce_tasklet_req_done(unsigned long data)
+static void qce_req_done_work(struct work_struct *work)
 {
-	struct qce_device *qce = (struct qce_device *)data;
+	struct qce_device *qce = container_of(work, struct qce_device,
+					      done_work);
 	struct crypto_async_request *req;
 	unsigned long flags;
 
@@ -154,7 +155,7 @@ static int qce_async_request_enqueue(struct qce_device *qce,
 static void qce_async_request_done(struct qce_device *qce, int ret)
 {
 	qce->result = ret;
-	tasklet_schedule(&qce->done_tasklet);
+	schedule_work(&qce->done_work);
 }
 
 static int qce_check_version(struct qce_device *qce)
@@ -243,8 +244,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 		return ret;
 
 	spin_lock_init(&qce->lock);
-	tasklet_init(&qce->done_tasklet, qce_tasklet_req_done,
-		     (unsigned long)qce);
+	INIT_WORK(&qce->done_work, qce_req_done_work);
 	crypto_init_queue(&qce->queue, QCE_QUEUE_LENGTH);
 
 	qce->async_req_enqueue = qce_async_request_enqueue;
@@ -253,13 +253,6 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	return devm_qce_register_algs(qce);
 }
 
-static void qce_crypto_remove(struct platform_device *pdev)
-{
-	struct qce_device *qce = platform_get_drvdata(pdev);
-
-	tasklet_kill(&qce->done_tasklet);
-}
-
 static const struct of_device_id qce_crypto_of_match[] = {
 	{ .compatible = "qcom,crypto-v5.1", },
 	{ .compatible = "qcom,crypto-v5.4", },
@@ -270,7 +263,6 @@ MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
 
 static struct platform_driver qce_crypto_driver = {
 	.probe = qce_crypto_probe,
-	.remove = qce_crypto_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = qce_crypto_of_match,
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index 228fcd69ec511..39e75a75a4293 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -6,13 +6,15 @@
 #ifndef _CORE_H_
 #define _CORE_H_
 
+#include <linux/workqueue.h>
+
 #include "dma.h"
 
 /**
  * struct qce_device - crypto engine device structure
  * @queue: crypto request queue
  * @lock: the lock protects queue and req
- * @done_tasklet: done tasklet object
+ * @done_work: workqueue context
  * @req: current active request
  * @result: result of current transform
  * @base: virtual IO base
@@ -29,7 +31,7 @@
 struct qce_device {
 	struct crypto_queue queue;
 	spinlock_t lock;
-	struct tasklet_struct done_tasklet;
+	struct work_struct done_work;
 	struct crypto_async_request *req;
 	int result;
 	void __iomem *base;

-- 
2.45.2


