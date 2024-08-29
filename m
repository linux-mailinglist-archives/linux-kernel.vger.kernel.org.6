Return-Path: <linux-kernel+bounces-305982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C97963798
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BACC2B22C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1449322EF2;
	Thu, 29 Aug 2024 01:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBzPa2D0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97094D29E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894495; cv=none; b=sLTEhggjW3G7ARz33Wxua1StUlFN+Kmz2KqsBSnUH8RNX1EPzRLOrO+zkPyLVYgft5qVr2UPAXun6CyBlt1u9GuYleTTRdHVEt8UNVUrN20wAuixZuiHcmy1/Bp49e9LzBRdw7afrbdQcfyQaA3rbxTXxm4dQLStCWgwh7OpNG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894495; c=relaxed/simple;
	bh=pVIsjIwUVSuD9f5vpgG6Je4vWyRG4TASquy5YfmS7vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=R52eRCm7id5nkjAHHoHYYHv5SlTOb6o7QeZu/ijbbckLOZwNO+ivDauPJ/CLTUCRfcZKCdxJ/8NouhMLENjnY6LyLBAUhOAfGyb5OfFmy5HJfAjn44H0S4ivq1frFSEyp9Q/vIl2yEbVMGWjZbfEeTDUR/4nR/wtg9fv7kiwPTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBzPa2D0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724894492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uPFXZeRskPV1LBySPC5AK+d7TuSi/RtTN6Kvr+xrijg=;
	b=jBzPa2D0nwrawaPlJZ6Dtvf0JczRl5HVesapRd3HnHVr205XjBndLklHQNosG581so0VLV
	qrQX3kJdGzriTJ6lAvML2f4Q4tmREcYVmXTf6NOwgS6nMdjyDWqyM8iJXHjhWM1wW0bOZT
	FY62Y//qnODXiETJH6pQfo+AM2PoRos=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-ZDlgSVDQPF-uCrZ42VO-7g-1; Wed, 28 Aug 2024 21:21:30 -0400
X-MC-Unique: ZDlgSVDQPF-uCrZ42VO-7g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6c1610cd159so3234546d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724894490; x=1725499290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPFXZeRskPV1LBySPC5AK+d7TuSi/RtTN6Kvr+xrijg=;
        b=Hg1vQSaTxC2QocALogGE+p3JNzCryCXd+mg3zcP4KfH7DU4b4C2ntBgLy2eWRGhbNR
         Foc8btyub1+ugE2SZ/eLJMX2/KWEp46c+cbcWtIpUlv/SjW8tSZTkgafUwk0CjiFlQ4j
         YIQG5oBxImLPBNdTrSkYrbN9jchYmgkcgL8E83dli7pVi2bTRVHOb7KHzArDoLlVz+JN
         CwLCiKmt/fI0ykYiXqRxDGNTAXHGIx598DorRKqi6Win+IW5CDnQzTqaKWVO+RfoOQ7O
         XoM65rfI2rnih+bWe6yqq95GnGZB91UMZHQlBImRvQG4FjPXCxDyYliSpugKM3eLLPMj
         SKQA==
X-Forwarded-Encrypted: i=1; AJvYcCWFIt8137YLeezpBDkmvTTdwDKWI3ogwuKvQDh4wISYbVCR0LrAAPm+7liQfqvAZ5ucU1vSnWxK1VJ+a4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHdBxzjwYZDZ704tqgDk4hnHT3WIOpS5Yo/cnaY/mRQKmLHLYw
	OC5ogRlgJ6oCfnKb/Uf9u3yQva1XeuhjBLMpQ9Aj9KJtaz97T26F2U8xD8LMb+LpjFs0pnIWnna
	3bJLF9GrAK799rTYCpaxWhSGKT+r2nyi8hOJi1do4qhyxMkBP39ouoBoz+zDj+Q==
X-Received: by 2002:a05:6214:1946:b0:6bf:7efc:1117 with SMTP id 6a1803df08f44-6c33f33d66emr20160196d6.9.1724894490323;
        Wed, 28 Aug 2024 18:21:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+83JODhwFjiVeEZ7C0/0RpEBcm05e8lIief195xyZB9E5UbynGRmQWhUDqK+J30xjphpQgg==
X-Received: by 2002:a05:6214:1946:b0:6bf:7efc:1117 with SMTP id 6a1803df08f44-6c33f33d66emr20160006d6.9.1724894490020;
        Wed, 28 Aug 2024 18:21:30 -0700 (PDT)
Received: from x1.redhat.com (c-98-219-206-88.hsd1.pa.comcast.net. [98.219.206.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c96825sm1013236d6.75.2024.08.28.18.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 18:21:28 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	quic_omprsing@quicinc.com,
	neil.armstrong@linaro.org,
	quic_bjorande@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] crypto: qcom-rng: rename *_of_data to *_match_data
Date: Wed, 28 Aug 2024 21:20:04 -0400
Message-ID: <20240829012005.382715-2-bmasney@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829012005.382715-1-bmasney@redhat.com>
References: <20240829012005.382715-1-bmasney@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

The qcom-rng driver supports both ACPI and device tree based systems.
Let's rename all instances of *_of_data to *_match_data in preparation
for fixing the ACPI support that was broken with commit
f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface support").

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/crypto/qcom-rng.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index c670d7d0c11e..4ed545001b77 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -36,14 +36,14 @@ struct qcom_rng {
 	void __iomem *base;
 	struct clk *clk;
 	struct hwrng hwrng;
-	struct qcom_rng_of_data *of_data;
+	struct qcom_rng_match_data *match_data;
 };
 
 struct qcom_rng_ctx {
 	struct qcom_rng *rng;
 };
 
-struct qcom_rng_of_data {
+struct qcom_rng_match_data {
 	bool skip_init;
 	bool hwrng_support;
 };
@@ -155,7 +155,7 @@ static int qcom_rng_init(struct crypto_tfm *tfm)
 
 	ctx->rng = qcom_rng_dev;
 
-	if (!ctx->rng->of_data->skip_init)
+	if (!ctx->rng->match_data->skip_init)
 		return qcom_rng_enable(ctx->rng);
 
 	return 0;
@@ -196,7 +196,7 @@ static int qcom_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(rng->clk))
 		return PTR_ERR(rng->clk);
 
-	rng->of_data = (struct qcom_rng_of_data *)of_device_get_match_data(&pdev->dev);
+	rng->match_data = (struct qcom_rng_match_data *)of_device_get_match_data(&pdev->dev);
 
 	qcom_rng_dev = rng;
 	ret = crypto_register_rng(&qcom_rng_alg);
@@ -206,7 +206,7 @@ static int qcom_rng_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (rng->of_data->hwrng_support) {
+	if (rng->match_data->hwrng_support) {
 		rng->hwrng.name = "qcom_hwrng";
 		rng->hwrng.read = qcom_hwrng_read;
 		rng->hwrng.quality = QCOM_TRNG_QUALITY;
@@ -231,17 +231,17 @@ static void qcom_rng_remove(struct platform_device *pdev)
 	qcom_rng_dev = NULL;
 }
 
-static struct qcom_rng_of_data qcom_prng_of_data = {
+static struct qcom_rng_match_data qcom_prng_match_data = {
 	.skip_init = false,
 	.hwrng_support = false,
 };
 
-static struct qcom_rng_of_data qcom_prng_ee_of_data = {
+static struct qcom_rng_match_data qcom_prng_ee_match_data = {
 	.skip_init = true,
 	.hwrng_support = false,
 };
 
-static struct qcom_rng_of_data qcom_trng_of_data = {
+static struct qcom_rng_match_data qcom_trng_match_data = {
 	.skip_init = true,
 	.hwrng_support = true,
 };
@@ -253,9 +253,9 @@ static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, qcom_rng_acpi_match);
 
 static const struct of_device_id __maybe_unused qcom_rng_of_match[] = {
-	{ .compatible = "qcom,prng", .data = &qcom_prng_of_data },
-	{ .compatible = "qcom,prng-ee", .data = &qcom_prng_ee_of_data },
-	{ .compatible = "qcom,trng", .data = &qcom_trng_of_data },
+	{ .compatible = "qcom,prng", .data = &qcom_prng_match_data },
+	{ .compatible = "qcom,prng-ee", .data = &qcom_prng_ee_match_data },
+	{ .compatible = "qcom,trng", .data = &qcom_trng_match_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_rng_of_match);
-- 
2.46.0


