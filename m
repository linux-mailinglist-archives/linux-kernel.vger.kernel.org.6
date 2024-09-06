Return-Path: <linux-kernel+bounces-317990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F096E6C9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E356E1C20ECD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EB51DA32;
	Fri,  6 Sep 2024 00:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fh/IxRjP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C704F1BC59
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725582344; cv=none; b=PKxp5HPsHseUahuAeq6pi/VrhvJMtWuiADrnpAPA1PZNG62X6zpiMDUISLiV0XiJY6qZbonA5h6HFnJVjAVFw70CycbNtQhJbhrlfkzmT54n9w66FdF+cD46kW6b1XbwS8XoNLfNjQxv8F8fIZj08mMXUm9P667E0AUO+NlrjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725582344; c=relaxed/simple;
	bh=xeoEgQHWnJv9aAUQ7kLmifOvd3ou+ngyzhfdJVGfNH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-type; b=XxiFmZ8VH4sfJOltR3olnLpwAoWI4p59nh2I0B0xk5ovaqU1gcuckNt9e+qePu4uu30kiOoFIGl0MOhOaoLFmePoQaQeNglQw01UHkfURLuz9jlRWWoBvDA53PttQoENmJpx4JGapV8LIXX4WTrnEZ6Ft5iHiQ6WJQW53IQ4k2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fh/IxRjP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725582341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFmgUYgQ8XPCtLmWU1gSlO7qvWg2iDsHAEghO13whZ4=;
	b=fh/IxRjPTRKvkldNfcEVtXuStCo2od/UdnjTF3vK+FVqSqejLgknQEWIoEtQ78sLU7BknR
	uF8KMtx4GT8XL2x4dVuVVg2+CvRELvD4a2v0P1jXEjVrwaWrsxV6tSbGBIazXA08PUeAdl
	sb5/qahSypeY81ZMPrGN3Zhu17XNNyc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-3eVIjHHXO_qTgYSEtWb3NA-1; Thu, 05 Sep 2024 20:25:38 -0400
X-MC-Unique: 3eVIjHHXO_qTgYSEtWb3NA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a80b9f8771so256612485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725582338; x=1726187138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFmgUYgQ8XPCtLmWU1gSlO7qvWg2iDsHAEghO13whZ4=;
        b=Hnz2vjj0fL+7QztOnlkhuiSf4iQyYxfaPjxuHhamQJ8s7XCbJ47FTpRJRYnJD1hH2g
         m9P278FVpSKAyTiej3KMK2GJjE83BLNfO2BDcmbf88zCQH+JTZ25pluDT+KWmmq6xEmI
         po5xBeH9YVmuko5oU54uE92XN5/Ele68R1ND6K/wRQ1FQYja6koWCFyMge7ug/7cR48D
         6Wfw3m9AWTEegnrNRzeJiIgsqQ9GfLegi2AuArJJmcypmPq/T7mBBrEBZNaVljApgpQD
         afl10ik03G3tesHQSXuwS67Uxdv9xnwzS/Y29dvfMD2feX59pQsA8m2DlmachzxKQGtJ
         j3lg==
X-Forwarded-Encrypted: i=1; AJvYcCUAokxHNylNTEsy81pBm4zWcte8Y2hdigsAQH9HcuhXoszB4dn5godaC2LE18+RU64Ay4rRnZDAN2Aoex8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz006VIORLtymkMzXsc+Xpgyoufp+Ms/4pSx61vjZiTOke0/OF
	qgSVh9zYyvfUZlgL6c3UA+HgIrc9XT1pFcteGrqS9UKHowxh5SSzst9wJVvh2a/53zAq0gdvpFn
	kDzLzwNXjMo2vuJ52mn4GFPOrO3jqEnAuMc9xJ6QxvsvZy28uhG5sfYGJNZlemA==
X-Received: by 2002:a05:620a:2891:b0:79d:6d7d:e5b3 with SMTP id af79cd13be357-7a8041f4696mr3047811685a.42.1725582338088;
        Thu, 05 Sep 2024 17:25:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYQx7/fvvOSNZf5EqatDNkGRptl/2APlKW+uDWTwN3cDQR0sw3Wju0jKTNyuHCb5DTaeJ5tg==
X-Received: by 2002:a05:620a:2891:b0:79d:6d7d:e5b3 with SMTP id af79cd13be357-7a8041f4696mr3047809285a.42.1725582337498;
        Thu, 05 Sep 2024 17:25:37 -0700 (PDT)
Received: from x1.redhat.com (c-98-219-206-88.hsd1.pa.comcast.net. [98.219.206.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98f026309sm120779185a.128.2024.09.05.17.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 17:25:35 -0700 (PDT)
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
Subject: [PATCH v3 1/2] crypto: qcom-rng: fix support for ACPI-based systems
Date: Thu,  5 Sep 2024 20:25:20 -0400
Message-ID: <20240906002521.1163311-2-bmasney@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906002521.1163311-1-bmasney@redhat.com>
References: <20240906002521.1163311-1-bmasney@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-type: text/plain
Content-Transfer-Encoding: 8bit

The qcom-rng driver supports both ACPI and device tree-based systems.
ACPI support was broken when the hw_random interface support was added.
Let's go ahead and fix this by adding the appropriate driver data to the
ACPI match table, and change the of_device_get_match_data() call to
device_get_match_data() so that it will also work on ACPI-based systems.

This fix was boot tested on a Qualcomm Amberwing server (ACPI based) and
on a Qualcomm SA8775p Automotive Development Board (DT based). I also
verified that qcom-rng shows up in /proc/crypto on both systems.

Fixes: f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface support")
Reported-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Closes: https://lore.kernel.org/linux-arm-msm/20240828184019.GA21181@eaf/
Cc: stable@vger.kernel.org
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/crypto/qcom-rng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index c670d7d0c11e..6496b075a48d 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -196,7 +196,7 @@ static int qcom_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(rng->clk))
 		return PTR_ERR(rng->clk);
 
-	rng->of_data = (struct qcom_rng_of_data *)of_device_get_match_data(&pdev->dev);
+	rng->of_data = (struct qcom_rng_of_data *)device_get_match_data(&pdev->dev);
 
 	qcom_rng_dev = rng;
 	ret = crypto_register_rng(&qcom_rng_alg);
@@ -247,7 +247,7 @@ static struct qcom_rng_of_data qcom_trng_of_data = {
 };
 
 static const struct acpi_device_id __maybe_unused qcom_rng_acpi_match[] = {
-	{ .id = "QCOM8160", .driver_data = 1 },
+	{ .id = "QCOM8160", .driver_data = (kernel_ulong_t)&qcom_prng_ee_of_data },
 	{}
 };
 MODULE_DEVICE_TABLE(acpi, qcom_rng_acpi_match);
-- 
2.46.0


