Return-Path: <linux-kernel+bounces-429084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 650CB9E1727
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D209161807
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A831E0B80;
	Tue,  3 Dec 2024 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yKGKuU/a"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CB11DE8B1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217598; cv=none; b=nh4wwAQcZ5kWZOqRSd0ecYHacu/xI5XN7NMOsWR7DidwtAQwDL+2ho6Wgew5xCE8IUWpyUAruiieL3UGkbOortfmw8YbNyDYx7diWQhBySfRHyJzMkUVn0HknMYi3fPNptMmToKeeu26oCsPFm8wvBPf6bReo3RhOX7IkoOaok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217598; c=relaxed/simple;
	bh=HD6F12ehGLkQs/vK8YhET8fqt4KkxJlOeNzxTaJtU30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VmvUsIiaaapflDSYFolEXl+b7eDaYX2pNUhNyVG7sPIBsqf72xnfZ38t/TGxs/xYRcgRIG1UPjcGlaPIRHzPehZcYy8wmxvqw+UUmN0Wb6uxEH+bdcAOXFcvzsto5w5Ug4NHbQ/GyI3PnJovBurO6PFVHndexy+5cS8QuSdw/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yKGKuU/a; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ffd711274dso56180641fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733217594; x=1733822394; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eftVblPKS4gARELZ0p732NX41Z2T9XexDLuwGnyPTVs=;
        b=yKGKuU/a7xR2mEQL3IbfP9VrkdyWpmGmB+SzgdE1Ebg1TdrNFt7/aunU0yYVhvomPU
         Qsj50JB/+zZWeroTPWyjMcw5eujWz44yPPaa0urvgBIVgwOTTnQPcUL4k9N2xBHAoLAf
         jOaQFUL/ndqxKB1jHm3qqXNKEDpub+qsBySHATq/ttVptzTSBoNNgTFbwGAxaeatUqxk
         gqii1bOrjcOknGadt2gQ/4QT+djC5yAeiynttRR8Ex6dB6aIZtIUfzGFHIOpEjVa0H3k
         tkkG8ayJ7/FZpeNFpJNfJCtIdGKoEIvhl/J991zrZrj8k80+Vjm8UPZF9t+wRGgDCZZs
         UW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733217594; x=1733822394;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eftVblPKS4gARELZ0p732NX41Z2T9XexDLuwGnyPTVs=;
        b=wu309AsJWJaBPMIBdA0Ip5Sz/LDl0Z4zuJl6cihjkFRjATbLGvpNjj6kRBnkk8re7I
         nN77YL9zi1usDYzYRI682lkS+F9tENWbKv7/jL39h12qMJMUFvBswNXRHAew+L9halRy
         2/pflsLMgPH8ug4udKPt3jqrD8rGaXpEEkh4NNdRrDWiIhfZoL3lygRMtZ88zaNvaV/U
         xJtE6hNwiv42Ss7RuatawqOtArm9hBR+7QzyUjifcdtdFJpdQ3Z4wEa4ngajshymE5Yx
         AE9huuWS6h7NJzt3nBu3eNawZblffpHhxel0l4xN/JzcMbhnxG7KvH4/c82UyeB/v8A2
         1osg==
X-Forwarded-Encrypted: i=1; AJvYcCXLUH1PHtfI+9+nOfAapE/hX/9HZFFcxga9wNZ/vbOSsU47V7JsKFlYXHz2Zxy1ijV3bLINRaIlTJwapzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA1xB8bZ0fcDsIWbmTLcKYbEcxukxYtGSRSYTmWGaO57IaFS34
	UZwwPSPSl6L3Wz1GlhqC5HIPjRawWX34k8+QWiKC9VY8zEpjP0PQX+TJZlksCQg=
X-Gm-Gg: ASbGncsoSvEz83zj1Id7ikeki3muXuuheokoCC5i+se392BIEHBF3ZsG7odbSUrcz2c
	2k7WdhEwFb/XuovbyTYBDvuWa34NYBEViObF46/Oe4i/qQmBJ/pUavwf9MqQKPMUmPpG7K9J5sY
	cfob+AfDo3TkhS2pnTtKDhfsAkLn9YPHHQwnbMltCMvxwOPR48yuo4l6Rxo6k5/VjRhd5m4Us0x
	gJpMnPd7T1ikiTDiZg5fB5RvkvIxB7qVFPoK2zjLx6yYrOdmsi0cwUo9qEaUS+cQD4VxL06wNGz
	/LwoSHA=
X-Google-Smtp-Source: AGHT+IEk8thFGeV9xvcpu2/iiVlx4e+FXLk1zP9i6j7DxGvSmKxBpAM9ERT9rQMBPxBN9BOkjqbtDA==
X-Received: by 2002:a2e:a542:0:b0:300:8ff:db52 with SMTP id 38308e7fff4ca-3000a2bda42mr6248931fa.19.1733217594013;
        Tue, 03 Dec 2024 01:19:54 -0800 (PST)
Received: from [127.0.1.1] (217.97.33.231.ipv4.supernova.orange.pl. [217.97.33.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb915esm15591811fa.19.2024.12.03.01.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:19:53 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 03 Dec 2024 10:19:33 +0100
Subject: [PATCH 5/9] crypto: qce - convert qce_dma_request() to use devres
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-crypto-qce-refactor-v1-5-c5901d2dd45c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3759;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=5anFU4gDXPczz4A13V8FA6PEG1xNDqU3mfQG1FqR+pE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTs0xDdrcq+p+ikfNKs5QrH/yE5ZsPIYMjGLl2
 K2K/QsfD2mJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ07NMQAKCRARpy6gFHHX
 ctNhD/0Tdpytetrv206QK1MRQTJhRd12RBnkirZ2p7yrQlAjvcgut6iBpLbLDnlBq8ytV4ke6nH
 De8n7jvThGT5/d5MCp8BFNh/2JzYqhzd9397GADyXHmTdN5kbFNNGQFRsWn6W78IYp34+UqwlBJ
 QH2rZU/djSLrtW/2SdgNFwLhto0ESKqAO/aVl+gSRy9GyRPaPfSJcvKji621OeqERwHn90ZLFaY
 CaLlkL1/1Ext4UbWitz0JaHpq65r+n8R1VDb6VIdnOTT7PB7denSYdrUX8zV1BdA0Waw/0SXOp7
 SaMRMoG+IYgNU7+ywKeFh5rg2iHjYK0FCTV33L/4Y9xII6bYtVrQT5SC3TXq4XibUuXfMnupd9Q
 3d9EGsD1oGl2xTkuOwyM74ouRvPnakYCx2awvAAsZ44ZMEFpb3YjGxeCTwyUueIQSPrYZjhsiot
 NMeAKJfzSjcALA+cBVRJ+y84yLAX8/5z8VULj9JnJKGPE+A7A47BuwoxPWRIq0V4KAKic4Fqcv4
 10132HwVEL76A1PRfIrIJ9NuYRgEs5JGzT8ZBpcpm/MOaoRch4hF1w5SGTk5p88lZfG/UYalZJL
 D3xccXbuWJ8wQPJCiWkTD8p5KMK5DL0Vj83jKgHGbxhsJfO+NMoJS28fRUAs1oj86bNB7Q6oLQq
 NmZt+7ppzMChmyw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Make qce_dma_request() into a managed interface. With this we can
simplify the error path in probe() and drop another operations from
remove().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/core.c | 16 +++-------------
 drivers/crypto/qce/dma.c  | 22 +++++++++++++---------
 drivers/crypto/qce/dma.h  |  3 +--
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index cdcddf8f9f02b..e2cda24960f63 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -232,13 +232,13 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = qce_dma_request(qce->dev, &qce->dma);
+	ret = devm_qce_dma_request(qce->dev, &qce->dma);
 	if (ret)
 		return ret;
 
 	ret = qce_check_version(qce);
 	if (ret)
-		goto err_dma;
+		return ret;
 
 	spin_lock_init(&qce->lock);
 	tasklet_init(&qce->done_tasklet, qce_tasklet_req_done,
@@ -248,16 +248,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->async_req_enqueue = qce_async_request_enqueue;
 	qce->async_req_done = qce_async_request_done;
 
-	ret = qce_register_algs(qce);
-	if (ret)
-		goto err_dma;
-
-	return 0;
-
-err_dma:
-	qce_dma_release(&qce->dma);
-
-	return ret;
+	return qce_register_algs(qce);
 }
 
 static void qce_crypto_remove(struct platform_device *pdev)
@@ -266,7 +257,6 @@ static void qce_crypto_remove(struct platform_device *pdev)
 
 	tasklet_kill(&qce->done_tasklet);
 	qce_unregister_algs(qce);
-	qce_dma_release(&qce->dma);
 }
 
 static const struct of_device_id qce_crypto_of_match[] = {
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 46db5bf366b44..1dec7aea852dd 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -3,12 +3,22 @@
  * Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/device.h>
 #include <linux/dmaengine.h>
 #include <crypto/scatterwalk.h>
 
 #include "dma.h"
 
-int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
+static void qce_dma_release(void *data)
+{
+	struct qce_dma_data *dma = data;
+
+	dma_release_channel(dma->txchan);
+	dma_release_channel(dma->rxchan);
+	kfree(dma->result_buf);
+}
+
+int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 {
 	int ret;
 
@@ -31,7 +41,8 @@ int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 
 	dma->ignore_buf = dma->result_buf + QCE_RESULT_BUF_SZ;
 
-	return 0;
+	return devm_add_action_or_reset(dev, qce_dma_release, dma);
+
 error_nomem:
 	dma_release_channel(dma->rxchan);
 error_rx:
@@ -39,13 +50,6 @@ int qce_dma_request(struct device *dev, struct qce_dma_data *dma)
 	return ret;
 }
 
-void qce_dma_release(struct qce_dma_data *dma)
-{
-	dma_release_channel(dma->txchan);
-	dma_release_channel(dma->rxchan);
-	kfree(dma->result_buf);
-}
-
 struct scatterlist *
 qce_sgtable_add(struct sg_table *sgt, struct scatterlist *new_sgl,
 		unsigned int max_len)
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index 7864021693608..31629185000e1 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -34,8 +34,7 @@ struct qce_dma_data {
 	void *ignore_buf;
 };
 
-int qce_dma_request(struct device *dev, struct qce_dma_data *dma);
-void qce_dma_release(struct qce_dma_data *dma);
+int devm_qce_dma_request(struct device *dev, struct qce_dma_data *dma);
 int qce_dma_prep_sgs(struct qce_dma_data *dma, struct scatterlist *sg_in,
 		     int in_ents, struct scatterlist *sg_out, int out_ents,
 		     dma_async_tx_callback cb, void *cb_param);

-- 
2.45.2


