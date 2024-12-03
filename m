Return-Path: <linux-kernel+bounces-429085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F819E172B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E101611EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D311DF96B;
	Tue,  3 Dec 2024 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="t1Ik/Gsh"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAAA1E0493
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217598; cv=none; b=d8irqblpe5gnwZ7mIEsEdxJX5jdasH3ADL38Fdz1Nkgc2HZr+C+0QuVd4gA6MDlyfoQSpB/U74l+XcZkylyKVHvt+fYzBg+VQ+6HSOAuOicCHMsZuFawJ2rHulVKbMhYBfHyxMXh/72nJcDJR0NdKOEahVimsSYFm15XMYMTJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217598; c=relaxed/simple;
	bh=+VpEigVc6lxA9LKBiAOInc8aR+tM26asXGWOiNd0c8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tHKdzJu0bWeT44OtICBOeX7SwxN+p2NrBnlzBK6idCoHqgCSbwvRnlImJkAxd99a/qoD2VlECMxrIgPtjOZpKiPTRHKDlNJWNt9q8TD6CKbEczUXXddvpVglMY8L0de/UQSC0Y2Zo9zFkEriXGWyiAyFrkgXX7jWxguw067B1ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=t1Ik/Gsh; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3000b64fbe9so3594761fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733217595; x=1733822395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8j8u3Wa3a2CyIsUGNm4RzXAyNu0/dvUGsIrzSdp+VkQ=;
        b=t1Ik/GshkkyNCt1kIu2A9r8cEdVHmXfxzmBJZKC9bssCx9hQaUGsFPlAYKfy/ma//L
         rMB+kzp1cGUghRUxRDskGTAF972pQbk9URNOcF+GXylIZ6fyJpADVmV5ouAWdS0WuD5O
         GoI5mD4l4Wk4wLk1mH11k5sc4wkAumLun9G25tkqMbUvob9VNR1SFUqhVPOSys37LL08
         5U4msGUFm3nHM0W7J1iZnFxcbyIdWJ8+wXhoyTJtN8BbfN3AZCfniGkBZfww9jbjobhR
         fAjZlQcDvNfFdr3WZbFMAjWIRfcv4wNH7T2tVSefJzDoAA18nDGQ0wMhluiFcZJQDCIK
         bgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733217595; x=1733822395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8j8u3Wa3a2CyIsUGNm4RzXAyNu0/dvUGsIrzSdp+VkQ=;
        b=F+6YNJ80npu7D/50fbW/FaD5fj4z9/R54nlDvl8pl6grDx8mfbENy9JVC2wXI69HR/
         4Kl2kYe3Nu8M3NjJOsmPta//UcSu9XNbWLHmjnMVt6tcqRu5yjNaL7mBx1HhMbql6s4a
         LILdV+LPkUdlvbRC6zkj9p+B4VcEwsaPQgJQ1s+43hcyEoNlJEoYPuOWYL0RNF026Wsf
         YRVLkmNBcQxKVsS1Ovtn749QrwwON0hKKlpladXWS9W7gCo4y9/AKZlfk/navGpl7VCR
         5d3PBz/nqETdzkcmrkxfg2bWv/V6h9nIGqn0FAcznoXSEX/GncQFYASHugeXMCEWYi5m
         MNtg==
X-Forwarded-Encrypted: i=1; AJvYcCVOCx2v8rkVNOcMY5SmgUC1f4SbomvThlG1aUiutCcijFLL8gycT6UsO5NYl/H/47pK7i4JbhACQrolJ3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtvwMKhaSa0b+ZhW6EmMonfDAuNq/3GyWR7aqhfmNZBe0oi53Q
	hqnuOs9tUqF4RD+cOkZ+bpo4GHwmTiYhwC3t26RVfLh87UrX5TVHecVvdCcobrIjVkk7NcHhMYb
	tjGQ=
X-Gm-Gg: ASbGncvHGW4sYkcmjrowUKJ+4flpiStbhUCPIR8bqhSereE83A7lAMzgLm6iVck9ruw
	HFiQbBWfI46qN6nHdAgDpS5JMJxP01/JYKmdMDMWlMpog3G4BhAI7tS11B3QqXGutqIr4ncPdMl
	axQKRDH4oOpxD2wyF/HMzrW8cCL3NBghA85whzJd6HYjsOvkJPXHpncM6duUPa/qTwYW8NtDs1L
	qc0l6LdZueTi6fc5KnaoPxmBE1irPGtNbHRNPoNdbNUuSGmF9YpAIfL9uaNOH9VM3Zmd5NyO6q8
	hx0ut2o=
X-Google-Smtp-Source: AGHT+IGTRPHLzsa+Od2O+5Vq5r0Q0wNcJxcWkB+oMesKwMmytxjH29mLGq29QHRwrq5YMCpTL1tlZA==
X-Received: by 2002:a2e:be88:0:b0:2fa:cc50:41b with SMTP id 38308e7fff4ca-30009bf6023mr9288611fa.5.1733217595149;
        Tue, 03 Dec 2024 01:19:55 -0800 (PST)
Received: from [127.0.1.1] (217.97.33.231.ipv4.supernova.orange.pl. [217.97.33.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb915esm15591811fa.19.2024.12.03.01.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:19:54 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 03 Dec 2024 10:19:34 +0100
Subject: [PATCH 6/9] crypto: qce - make qce_register_algs() a managed
 interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-crypto-qce-refactor-v1-6-c5901d2dd45c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2091;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=nbVED4dd7+CBe0Mn4liIw0K/JKHlGMvh5/n4LZbE1tw=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTs0yY2lAugX/APXTAaiXr52sczuy5mBqSvOr1
 A1zuRZ7nQKJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ07NMgAKCRARpy6gFHHX
 ctp3D/4kRDqo7ceRU5VTbMDu5cHGuKvEQk4HFWugzwXQIkoWKFUvh4YLEBDGEKm2JRgijn4vvzV
 Bk6TxrOGczusyAdIZFdL/LvedFKBH4XsalF2V+qYROSB5sRBhPXWgpVfq+cLNyYZ/LECMmvRXYv
 U+qtM8FgrfNqwrVqon2EJ0GD3hEdEatVif+iS53g4nsWqVQvjPA+yzzQ6V96AkWYvyjyyEkuPHg
 sa2TnC73M0z4QK0fOFIvFoKT/39vqqpqHnkNXHziHTpv75xGKayrLSwYEUToXQ2UEeMwC35DV8S
 bMSXFOMKN14JbV8Bn2k3oXjTyuomyPmjI0EWuirUxfdeME3f/MCJWM3amBQKrNlaEDlS59Eg3dZ
 95gBOvNQzESMkHSYvMq8tbgshlhOybXbUTQZ6RCyxToP5uWqODoBuf4HuL9mbL+MIlEef48qcb3
 Qs6tvUFi0XS9Mwrq4IsefHGwvlmiPxsxRc628xwXJ9KtfTPmbXV/ryZPRm9idByg3EhDiAmA5eU
 KiEJR0jEHxQOHQTbHH+HtcZxiQeY5LwbHSRRtAqe44shWSqhH78uK25Kr0je2CDp7GqVKwKsWAA
 LcYTuBQxy8qfHhG4UjMHKOmlyCmotumyOhKMKfXFVZKG0vtR5bPu0XUzAXpv0FBAoPsuMArabad
 B7KdDGSu8v83r9Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Make qce_register_algs() a managed interface. This allows us to further
simplify the remove() callback.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index e2cda24960f63..5e21754c7f822 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/interconnect.h>
 #include <linux/interrupt.h>
@@ -37,9 +38,10 @@ static const struct qce_algo_ops *qce_ops[] = {
 #endif
 };
 
-static void qce_unregister_algs(struct qce_device *qce)
+static void qce_unregister_algs(void *data)
 {
 	const struct qce_algo_ops *ops;
+	struct qce_device *qce = data;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(qce_ops); i++) {
@@ -48,7 +50,7 @@ static void qce_unregister_algs(struct qce_device *qce)
 	}
 }
 
-static int qce_register_algs(struct qce_device *qce)
+static int devm_qce_register_algs(struct qce_device *qce)
 {
 	const struct qce_algo_ops *ops;
 	int i, j, ret = -ENODEV;
@@ -63,7 +65,7 @@ static int qce_register_algs(struct qce_device *qce)
 		}
 	}
 
-	return 0;
+	return devm_add_action_or_reset(qce->dev, qce_unregister_algs, qce);
 }
 
 static int qce_handle_request(struct crypto_async_request *async_req)
@@ -248,7 +250,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->async_req_enqueue = qce_async_request_enqueue;
 	qce->async_req_done = qce_async_request_done;
 
-	return qce_register_algs(qce);
+	return devm_qce_register_algs(qce);
 }
 
 static void qce_crypto_remove(struct platform_device *pdev)
@@ -256,7 +258,6 @@ static void qce_crypto_remove(struct platform_device *pdev)
 	struct qce_device *qce = platform_get_drvdata(pdev);
 
 	tasklet_kill(&qce->done_tasklet);
-	qce_unregister_algs(qce);
 }
 
 static const struct of_device_id qce_crypto_of_match[] = {

-- 
2.45.2


