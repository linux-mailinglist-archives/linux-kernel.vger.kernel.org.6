Return-Path: <linux-kernel+bounces-313802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1335796AA03
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A4F7B2231C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933BF1C9DC4;
	Tue,  3 Sep 2024 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U640d6iX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9E1922CD
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398573; cv=none; b=LY5W/iBR7KQhLNacppOtNxuxLSJ+z9WS3DnzM0J98X8zpby7v+aCyOYs2qx5cz/UnYQeWqWy5VuSW4ZW4CHDyE4iwNHxV7y6XSwEC/PCK/bZw8cASPrD+hZu9mH1U6iHCpyRrXJlw/We0C0iL0L0YVblfxeItgceNWeuqgnT6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398573; c=relaxed/simple;
	bh=8P1Jum47rGgM7FDX62HMOHw91bamdwad0+5M/vSm+X0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=pj1DZ8tubQzZP2m80Hobf2YRQNQ7fhwYPPoqvFo8DcRgoIpwhu/0sYxoMBTiyoKDZz8U7HImzWk+eUa9uFIufgBR2m6j3tm5PfVQNWmVDvi2E+ug+5gKTPm/ZTLXr6vW9o6TuZkBGaT2ME6MVIACdq4NlZnuJIDWbp6QaB097AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U640d6iX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725398571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8BQfqOVIo0s9x5Bh8x8Xi9+zxZ5VGhm3NLe1eX0SoQ=;
	b=U640d6iXbRZbI42cUA81k+AhotHl6t835KYw8r2TuY8aQKYFrN3u3dkwEYkhdisZOVJdGb
	O86/ING9HdXSDaepBrYNlRFwCsRZw4rtlCSDCdgsTsDlurZchU7tMBH46SShFx6AGaNKAE
	FnMcl0u//dYOdIGv8VLMl+eNPj4RXyw=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-MDlf4KM0OSq4jBFGxn3Ykw-1; Tue, 03 Sep 2024 17:22:50 -0400
X-MC-Unique: MDlf4KM0OSq4jBFGxn3Ykw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-277f1e27d63so3955071fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 14:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725398569; x=1726003369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8BQfqOVIo0s9x5Bh8x8Xi9+zxZ5VGhm3NLe1eX0SoQ=;
        b=kdU2Y03pfUIHLEdXx4G3wz41p2UpKgonKHDUU0IGAeRdZKrH/8yJOLDojx0Y7u5UK7
         8jTEOXDNdYvehCclBZZoWexCwdJAV9Hy2G4uoV9SyksFh/iZP6GkQXmQBreBKd8Bs+Bs
         goWfnQo6M0RwwPhdLhnZqJfVQvK2iuMfeOKdXo3rn1a1ywuMK/UNQ4ccuckZ/r9aQlXf
         KVMJ8+a7W6kUCQwcStmO9AoNd7YUUvNpV4imSEDmcOjTHyiG+EPSeiRdoU3xPjB4kHH1
         Qwdae6l76ecZZ8xUwCvhUdl/URSHw6zCcHIn/rD0NoVT9+8kzFyj0EJBQ2nehzYeqWW1
         cq3A==
X-Forwarded-Encrypted: i=1; AJvYcCUdsKQSTbCyyClyaBugGSPz2rk3abzYfv4I+yMYedhQqeXoLgOhLRtbSYxkBRPh6swn2uBjdG6sW55QX+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVuNvzKz2MWJWz66TFlHfcGl2ihilOdK3OOdCQnxxctW54zNJ+
	l5LjrLN4RZeS37XCPg868Okf7OznciQTIGPej4sRcp8iIMy7bGDhRpz75NT9TCNBZXYc7ekUgpZ
	CDLoR8bAaIdD18CJM15mqKwr/P/scHA3wYJucXgWnaOC4rMGVz/o1pgjJsY01uA==
X-Received: by 2002:a05:6870:ab13:b0:261:648:ddc5 with SMTP id 586e51a60fabf-277d0440313mr13448329fac.22.1725398569453;
        Tue, 03 Sep 2024 14:22:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkeRLWZ/sDG45fCql0Gm6F6kVH9oaiaaJPzDMm1J3AN0Z6MSDkiIcKaR6kgJxb0RqGP1wSkQ==
X-Received: by 2002:a05:6870:ab13:b0:261:648:ddc5 with SMTP id 586e51a60fabf-277d0440313mr13448302fac.22.1725398569071;
        Tue, 03 Sep 2024 14:22:49 -0700 (PDT)
Received: from x1.redhat.com (c-98-219-206-88.hsd1.pa.comcast.net. [98.219.206.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806bfb8c9sm564737185a.25.2024.09.03.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 14:22:47 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	quic_omprsing@quicinc.com,
	neil.armstrong@linaro.org,
	quic_bjorande@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ernesto.mnd.fernandez@gmail.com,
	quic_jhugo@quicinc.com
Subject: [PATCH v2 2/2] crypto: qcom-rng: rename *_of_data to *_match_data
Date: Tue,  3 Sep 2024 17:22:20 -0400
Message-ID: <20240903212230.707376-3-bmasney@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903212230.707376-1-bmasney@redhat.com>
References: <20240903212230.707376-1-bmasney@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

The qcom-rng driver supports both ACPI and device tree based systems.
Let's rename all instances of *_of_data to *_match_data so that it's
not implied that this driver only supports device tree.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/crypto/qcom-rng.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index 7ba978f0ce8b..f630962469c8 100644
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
@@ -176,17 +176,17 @@ static struct rng_alg qcom_rng_alg = {
 	}
 };
 
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
@@ -212,9 +212,10 @@ static int qcom_rng_probe(struct platform_device *pdev)
 		return PTR_ERR(rng->clk);
 
 	if (has_acpi_companion(&pdev->dev))
-		rng->of_data = &qcom_prng_ee_of_data;
+		rng->match_data = &qcom_prng_ee_match_data;
 	else
-		rng->of_data = (struct qcom_rng_of_data *)of_device_get_match_data(&pdev->dev);
+		rng->match_data =
+			(struct qcom_rng_match_data *)of_device_get_match_data(&pdev->dev);
 
 	qcom_rng_dev = rng;
 	ret = crypto_register_rng(&qcom_rng_alg);
@@ -224,7 +225,7 @@ static int qcom_rng_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (rng->of_data->hwrng_support) {
+	if (rng->match_data->hwrng_support) {
 		rng->hwrng.name = "qcom_hwrng";
 		rng->hwrng.read = qcom_hwrng_read;
 		rng->hwrng.quality = QCOM_TRNG_QUALITY;
@@ -256,9 +257,9 @@ static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
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


