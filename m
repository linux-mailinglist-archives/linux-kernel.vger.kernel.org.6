Return-Path: <linux-kernel+bounces-429088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288979E17C2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A776B3BB54
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778FC1E104A;
	Tue,  3 Dec 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MvQxr23w"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99D1E0DC6
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217601; cv=none; b=Gx/mnWmLbd+JaKkY8L9xrxC+qeRXnxYO/bdSnmPuLVmoc/pQcs3j+AoNcJE+VZpMyuFXQ5JUzhTKp3a3l5HX0C+xLylU2haFjWYc81pS4smIs07bOVWuPSU98988AJRvL2SM7gf7VTyoi/v699tGN5MXymXhOMOUchnBMQDYwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217601; c=relaxed/simple;
	bh=Xy5gKbnsBkJc2FKfgIbY/ZU2mcaK2le76I/vIuWL2Mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rXlDcHkjyZXK0WJ6qpjsxkMxW19egeT0cdfcyo7zYouqWn30WWwZs5Yu2uZfkizyP0b98EE/WewaAZrkdhwYb9C7Fudk9MZGjGpk4KCyRx20l/kyxI1bKKUYt0L5GQQMU5PAfP1LYZwyuQfxPmaYVIYkm2sBnnbmoxu3Bw9N3bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MvQxr23w; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffbea0acc2so57252241fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733217598; x=1733822398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISF/64QR6+2FKLNb1nT6CCEwJdkaHvgB/2jCubwzpII=;
        b=MvQxr23wTkcLN0QffPC5cvSLy+pYRpNCbw+mZCDa6SYWtsC+Za40e01ahOgzRnzSB0
         GGCuQTRj7RnNAb0ARHon2/Jx8wtwfR/JvgCmvK0VGnmCr+wG0eUSW2CFj9/viwwOwOFE
         QYUVpYIBnhvwtII/XFnWSJtVr0PU7Adjf2U5A2OCGnaxhbHqDe43u7dw0fAQSOzgUUfL
         n7DCBXy8kuVj8n9W795Pw11BwWL6MjvNnBpDZ0lQePJCF69L4yGZDIn7f+Exv1dLw/va
         UzKVsLChz1cVq7ZYbkKm7zxU7vwejjUXngqaExASLaKKaXAz304u8VWPyH/ECM4hQ5YS
         sfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733217598; x=1733822398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISF/64QR6+2FKLNb1nT6CCEwJdkaHvgB/2jCubwzpII=;
        b=D9Jb+tccNLK0fN5zfiL8I5o8vmNNVIw541s/PUM7K1FAWc6Sce8QxduF8BJlsZDGYp
         057FSESyN7DvhWeQ6J2ihsKCgHCUHa26gvyz1TdqaNptsgIIi9PXfNro6GY3WFJa6KVz
         pYEXMgVY98HHqP5Jv83eWDDrKAZgpRjReIjDEk3KExZQSAtFk5WkungepNxXrOk3ybux
         Gy2Ifd92Lxm4kz7V3OMGL//pIiLkGc4nysFi/Ux2gufqa5Rn6Y9dVS/sNuhXAjZ4XZ7f
         PQ0qfltQHsA+0rK7W5+rPc7E1g3EssSasxz/XDFvrDi70uhlHPV9RRnEqBHdaWGohN7M
         cYdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPI5PwI3RqEeNW3Y5GE++LaRusrVczFwwHZivuXW71w7ENkz+tkYbxp0Wx12prSJ84n1chjgw0vMe0o9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDc2bXUaBdFjJmO+zjFvsmD7CjKFdPq5qt8254JJ9lN9/yDKto
	2MwecHHnTT6X1QJ6Un56AeVUB7qyH/2YnBk+zOpk1ttGdPlqq0ALWtK632JhbQw=
X-Gm-Gg: ASbGncsAHlxsnhdsPEh9FHr0RQOxmx9by6ARZJmRT/TRZCn0kKr/aQQtVojsyHKOvq0
	l1sAqeB8azrziEArwshuhlyMP72srB6G4KCbSXsEJVVAoMrvtukZj5invyQvjcsbmG0HWKnC0d6
	L3kK+Ym3ER/SLdWgk2tJeIgv3Xv5x5CbaZ7455SD12ksMDvxd94tMhWEakO50hdSuTYvsEH6qC/
	IsOXGJxm9UAhpby+pgbAzfdlDvVRfGRwdEG+1CoOh55AVbAJQ/gehVqIJlodXUsCBPv6dfrGbe8
	dA5hVHE=
X-Google-Smtp-Source: AGHT+IHaBLaSsIJWPu7p7o0yORpSo5yhv3wHRlgSQ3NM1wphPHeKCE2EEMt2FIsSop8RfoJMgXVREQ==
X-Received: by 2002:a2e:b8c6:0:b0:2fb:8774:4412 with SMTP id 38308e7fff4ca-30009cb820bmr9003191fa.24.1733217598161;
        Tue, 03 Dec 2024 01:19:58 -0800 (PST)
Received: from [127.0.1.1] (217.97.33.231.ipv4.supernova.orange.pl. [217.97.33.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb915esm15591811fa.19.2024.12.03.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:19:57 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 03 Dec 2024 10:19:37 +0100
Subject: [PATCH 9/9] crypto: qce - switch to using a mutex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-crypto-qce-refactor-v1-9-c5901d2dd45c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3847;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=cnqYifjiBVmCbHFlZxnQbldj5KyaOEJPM6w2WklbSN0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTs0zTfWx8MjlbvjYfTHKIJbV7ckw08uVj9nyU
 UFw0uaad5eJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ07NMwAKCRARpy6gFHHX
 ctYoD/4vTX+HSBP7ylOm8KAQzmwrakIgaF8n1RYlEZQ1ZT7E9R9zm8GadC/r096lx53eXXeogHT
 JFdXeYROsiAFqbffm9SbS+Hp8YxSiIWyKHhT5T2zUQ9fIka56dlVAO8wQammqtgYK9iRtRrvrMO
 3dhH7RZBdaAJbZ0ytApf1XgkuwMr5Ff7086pNAW/3g3xZLG8JLlccR/bFw09vIbMpq9vDlC/VZS
 YmRzf1udif7FH+HSUQmlHL7w+Kqj7fG/fDrODnZTxzMQ5VGyQwfx87yytWl5jxQtz/PeL/J2ocj
 qKlKwEaNzDmEn4krU5vb3AGhpLE7cRzMq8pkzliZRT6q2yvXYyi6l9034KD2sjDGkD1P772Ey5B
 2OOGNPvBZFCnYMwTiAhMBXEPwsYKt4NAdccamIvx9p5TIDnYmeQCaEJNgEPFI+eCdQnp4b7+4u4
 0mekSkMeUhJF6VpTFLw+pW/BzC5I5evBy7J6hy4NpQPpEieKSNhVja2jzaYGN7eATIrI4N3CU4z
 i3wDl8k1koACwUcm++fVkTnzDmZ4fLEyNwlNRNE6KjQyb5xBeXZ7k7e6zi9RtqK+zwqMFMWYJGG
 LS/fsAIzm0ohCcOl3UfQfG+rBiJsBiYjDygEIE1Xb+yLrqTEcTk5gkcqzkTVrhokB11nBt39Cs8
 GkJ5YLTMFCBPl/Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Having switched to workqueue from tasklet, we are no longer limited to
atomic APIs and can now convert the spinlock to a mutex. This, along
with the conversion from tasklet to workqueue grants us ~15% improvement
in cryptsetup benchmarks for AES encryption.

While at it: use guards to simplify locking code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/core.c | 46 +++++++++++++++++++++-------------------------
 drivers/crypto/qce/core.h |  3 ++-
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 6de9f1e23e282..e95e84486d9ae 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2010-2014, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
@@ -11,7 +12,6 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
-#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <crypto/algapi.h>
 #include <crypto/internal/hash.h>
@@ -89,34 +89,28 @@ static int qce_handle_queue(struct qce_device *qce,
 			    struct crypto_async_request *req)
 {
 	struct crypto_async_request *async_req, *backlog;
-	unsigned long flags;
 	int ret = 0, err;
 
-	spin_lock_irqsave(&qce->lock, flags);
+	scoped_guard(mutex, &qce->lock) {
+		if (req)
+			ret = crypto_enqueue_request(&qce->queue, req);
 
-	if (req)
-		ret = crypto_enqueue_request(&qce->queue, req);
+		/* busy, do not dequeue request */
+		if (qce->req)
+			return ret;
 
-	/* busy, do not dequeue request */
-	if (qce->req) {
-		spin_unlock_irqrestore(&qce->lock, flags);
-		return ret;
+		backlog = crypto_get_backlog(&qce->queue);
+		async_req = crypto_dequeue_request(&qce->queue);
+		if (async_req)
+			qce->req = async_req;
 	}
 
-	backlog = crypto_get_backlog(&qce->queue);
-	async_req = crypto_dequeue_request(&qce->queue);
-	if (async_req)
-		qce->req = async_req;
-
-	spin_unlock_irqrestore(&qce->lock, flags);
-
 	if (!async_req)
 		return ret;
 
 	if (backlog) {
-		spin_lock_bh(&qce->lock);
-		crypto_request_complete(backlog, -EINPROGRESS);
-		spin_unlock_bh(&qce->lock);
+		scoped_guard(mutex, &qce->lock)
+			crypto_request_complete(backlog, -EINPROGRESS);
 	}
 
 	err = qce_handle_request(async_req);
@@ -133,12 +127,11 @@ static void qce_req_done_work(struct work_struct *work)
 	struct qce_device *qce = container_of(work, struct qce_device,
 					      done_work);
 	struct crypto_async_request *req;
-	unsigned long flags;
 
-	spin_lock_irqsave(&qce->lock, flags);
-	req = qce->req;
-	qce->req = NULL;
-	spin_unlock_irqrestore(&qce->lock, flags);
+	scoped_guard(mutex, &qce->lock) {
+		req = qce->req;
+		qce->req = NULL;
+	}
 
 	if (req)
 		crypto_request_complete(req, qce->result);
@@ -243,7 +236,10 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	spin_lock_init(&qce->lock);
+	ret = devm_mutex_init(qce->dev, &qce->lock);
+	if (ret)
+		return ret;
+
 	INIT_WORK(&qce->done_work, qce_req_done_work);
 	crypto_init_queue(&qce->queue, QCE_QUEUE_LENGTH);
 
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index 39e75a75a4293..eb6fa7a8b64a8 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -6,6 +6,7 @@
 #ifndef _CORE_H_
 #define _CORE_H_
 
+#include <linux/mutex.h>
 #include <linux/workqueue.h>
 
 #include "dma.h"
@@ -30,7 +31,7 @@
  */
 struct qce_device {
 	struct crypto_queue queue;
-	spinlock_t lock;
+	struct mutex lock;
 	struct work_struct done_work;
 	struct crypto_async_request *req;
 	int result;

-- 
2.45.2


