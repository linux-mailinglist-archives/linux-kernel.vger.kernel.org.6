Return-Path: <linux-kernel+bounces-305983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9702D96379C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507A11F2320D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DA73A1A8;
	Thu, 29 Aug 2024 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jl7Agfz9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2468D22EF4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894497; cv=none; b=H6QYLm8QRXb9PU0s1g0FYxlnK5gZABoetHBuu0ktyj2jizjIMlfZgtTs8BIYfk1eKqrdYvwbzHpnzn5weSeMJH7OIw8/mAm2sHV7mjvaBeLO9SRdva5jklc3ZZkWxmlSfPZfuDbisFYwQUC9q2//SAeL7LQQEEEwudCYMMBHetw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894497; c=relaxed/simple;
	bh=5cZ/tjRZEvLlBlcMgDypjgg3mVu/wSmTlQDFzZ8a8WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=cL7YVKkbPLI+U8rZ8TBd3CAU280zuuxcv9utiV7oNrVXtqFI8imh6m7NqJ8PNd7PNjOHQJF6pdU1CUkioTgHLJUOCPmXGmFpQx6bv8lammgj4EmZpubbT8ojn56nvW9j+NN/fkZwxWZbDGtQ6s9TOqHae6JS9A+DUWF2JDtzI2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jl7Agfz9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724894495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NZAUVynLNTnl3J66RD+E9gv/iCwUnMmJ5YyN4QH4Ew=;
	b=Jl7Agfz9GGLmPLAQ/M+PUYuzcf6g7A/R2GaPEOtG1TwJiaJhLR6U+q8iYtYd7kSpn50Upb
	XDKWY90iQCoYaVEM/SsFE8ao9H0CrJPD7JHfYg/QTs8dAbJ4hnwqCxl1agUNLhwTlKKrNd
	NyWTQrFDg+LElzlUhcbMvaaM3uEoxqE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-UJ7A7S8FNZCE-AHcI0AbNw-1; Wed, 28 Aug 2024 21:21:33 -0400
X-MC-Unique: UJ7A7S8FNZCE-AHcI0AbNw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6bf6d3e210eso1616276d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724894493; x=1725499293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NZAUVynLNTnl3J66RD+E9gv/iCwUnMmJ5YyN4QH4Ew=;
        b=P0seqCcwzbLLOYabR2YFvciIzcCWtF1mGsyE6PfeklsdlkB8KToJ53x3+TlESesqAQ
         CYjys1xsP0peAHiFURV7ZfW3UXI0GSusPwp8bX6o8i6cHGGDaVQGt7rYFwdyf38V8DWS
         MWxbXD2LbuEl2t0b08zag3SCLxLQbeesD8DT7wrnIyb7wQNUC6wXPI+dnY0VYB6dTmZ5
         xlPKPCRp+v8tqY6TIdOKrfnQ8MkDBgg1SJ3NCm+/HBpyMDiRLYecUeb3f6L/x0pSw5Yo
         g9zwRyMHMYG9rLNUV8KJ+qy67uh11XEhbb9DpIBvFCNPt4zA2jKJVwwhqH3C5ruia1CA
         1qjA==
X-Forwarded-Encrypted: i=1; AJvYcCUrK/4ZlfnzuXHK7+gXO09NKxogGUISy/jgiWCfrLCk6RuLbQDQ0S2vr65W1TvBw5M6hxKS2LhHs83TlIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRHXIJ2AlYcpzdIR7ReNdXoQMt0jQwnj3qRq4nxC+2+efkLv7
	UUrNd4O7jXp6Cn+TWWde+/4IojUNUO0IhDnii6hJQS2+urMG0bKdUVSHxYQ7Xf4fFBScSebIXI0
	QdLpzbdxwNDNS3fxl7XaE9+6aRW9NDGb5mOtTCksjlSVJg2XPoXn2DcTKcds36ynT+MsPHUmX
X-Received: by 2002:a05:6214:451b:b0:6bd:778b:6594 with SMTP id 6a1803df08f44-6c33e6962a0mr14117446d6.54.1724894492857;
        Wed, 28 Aug 2024 18:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFicbErcyZiL6ygZRYadzj1SdSXTCvwnpByTUjprwT++cXLx+ACzuYsCKWZ7aVgr6os4cyMlg==
X-Received: by 2002:a05:6214:451b:b0:6bd:778b:6594 with SMTP id 6a1803df08f44-6c33e6962a0mr14117266d6.54.1724894492488;
        Wed, 28 Aug 2024 18:21:32 -0700 (PDT)
Received: from x1.redhat.com (c-98-219-206-88.hsd1.pa.comcast.net. [98.219.206.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c96825sm1013236d6.75.2024.08.28.18.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 18:21:30 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	quic_omprsing@quicinc.com,
	neil.armstrong@linaro.org,
	quic_bjorande@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] crypto: qcom-rng: fix support for ACPI-based systems
Date: Wed, 28 Aug 2024 21:20:05 -0400
Message-ID: <20240829012005.382715-3-bmasney@redhat.com>
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
ACPI support was broken when the hw_random interface support was added.
Let's go ahead and fix this by checking has_acpi_companion().

This fix was boot tested on a Qualcomm Amberwing server.

Fixes: f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface support")
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/crypto/qcom-rng.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index 4ed545001b77..470062cb258c 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -176,6 +176,21 @@ static struct rng_alg qcom_rng_alg = {
 	}
 };
 
+static struct qcom_rng_match_data qcom_prng_match_data = {
+	.skip_init = false,
+	.hwrng_support = false,
+};
+
+static struct qcom_rng_match_data qcom_prng_ee_match_data = {
+	.skip_init = true,
+	.hwrng_support = false,
+};
+
+static struct qcom_rng_match_data qcom_trng_match_data = {
+	.skip_init = true,
+	.hwrng_support = true,
+};
+
 static int qcom_rng_probe(struct platform_device *pdev)
 {
 	struct qcom_rng *rng;
@@ -196,7 +211,11 @@ static int qcom_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(rng->clk))
 		return PTR_ERR(rng->clk);
 
-	rng->match_data = (struct qcom_rng_match_data *)of_device_get_match_data(&pdev->dev);
+	if (has_acpi_companion(&pdev->dev))
+		rng->match_data = &qcom_prng_match_data;
+	else
+		rng->match_data =
+			(struct qcom_rng_match_data *)of_device_get_match_data(&pdev->dev);
 
 	qcom_rng_dev = rng;
 	ret = crypto_register_rng(&qcom_rng_alg);
@@ -231,21 +250,6 @@ static void qcom_rng_remove(struct platform_device *pdev)
 	qcom_rng_dev = NULL;
 }
 
-static struct qcom_rng_match_data qcom_prng_match_data = {
-	.skip_init = false,
-	.hwrng_support = false,
-};
-
-static struct qcom_rng_match_data qcom_prng_ee_match_data = {
-	.skip_init = true,
-	.hwrng_support = false,
-};
-
-static struct qcom_rng_match_data qcom_trng_match_data = {
-	.skip_init = true,
-	.hwrng_support = true,
-};
-
 static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
 	{ .id = "QCOM8160", .driver_data = 1 },
 	{}
-- 
2.46.0


