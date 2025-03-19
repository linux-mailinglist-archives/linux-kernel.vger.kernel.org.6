Return-Path: <linux-kernel+bounces-568334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE480A69415
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8323B772B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAEF1D63ED;
	Wed, 19 Mar 2025 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QDylvfxi"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE142048
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399216; cv=none; b=uPkQ1nxhtrKWzzl1c/mx3ZF0en3vN/okSlejWW365rdPRxzWZMyHSzZBsBRLOzcwmv06ap31idI+FYHNA2tSQox+eikRhMXLxZ3bw2ChmeVm3slLwU6MfCr7gojjCQEjN3zvG7lXHs3qGPzk+/gJAo/5JIH9MyF0xONuWXkqass=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399216; c=relaxed/simple;
	bh=9pMCzNmFWdLe6vDSYFjeTD258CmkaD/Q3eyHlD8VAw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WC6MKvCQnJ7l9il+gglzoX0FTF5HJh2ApQBxufo6hGucAGQ/klYgOLyr0sKb53TfZl+JeJREpmDePlMVSI6/3h9GJMda8ZMjFC3HJ4biwigtt4smWngvJfiEAl5w7y1WLphwB5glvJOFW1EO/xG3qHsfLH14D47hJ8hqwI4mOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QDylvfxi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso6527085e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742399211; x=1743004011; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/0VhlxMQtcpY13wu0b5KMVKTKByV05hUh384QXyKHs=;
        b=QDylvfximaEzE2mORuSu8wjxUuBaAeR1XV/u3mXqyg3fHjOleQvypuk7NbXchvNLS2
         77UsUTydqfj0bhy+QiOgzQ5DcWh64KbEdl8ORorOP9+ZH5qTrIrNY0FV5wDAAL81UTDa
         +C/XYr+baGMCV2LmyLwHT8U3QYnF2rhzcM6/VhuWcAdcmKowmshTLhYPcBy4HeoVwnx1
         mTFIhvW42UhB3mppv2o5nTR0QgIBQM8+JAUw4TGLzM3dU9+98l22ofgSLOsGjlwt0uRE
         DcrOIDjNmXrj8w5w5XHXpkTuIBeMQ7v+r03k5FNbaCWVwGe2EbFsxKMe7OM1hljS5wxP
         ORmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742399211; x=1743004011;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/0VhlxMQtcpY13wu0b5KMVKTKByV05hUh384QXyKHs=;
        b=Ni42cohAF9AKi3KfGRI+gBlY83zeNM87AuJBoOrOEAAO46yeRAefJxsSiSnB8ctPin
         mT+a4MOUgviy+b5mwl3Ho0jGK2oMyBUyoYRoUsjXvRu+7SsFLx26ApsFD48VFBN4/eJF
         vZQ3X7FgbeQB5xAt6TJMMSxqZhvaot0/CF023wK4VfG2irCU1gsR6l75vKEkNe2hL1t9
         pFvAThe+NMGGIyf5NWQRgtBpwu8mm6KBe5uzB71npFc8PqFQRnqZyNeKJaytYSy/AMdR
         uoXOetl4l5iCzhbJY5mPtbGhrh9XdOzg+rqAK8EHrkgY+lohJdV8Vl1SA1abdoUuKmwo
         THSg==
X-Forwarded-Encrypted: i=1; AJvYcCViCwkxutfCVa0fVAJ2k19DY4xo/GhzVw279pZmgufHPuoMR/aMn5lTp388i9DJ2M2vHGh91ZeGPRgIk7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhvi+epPRJAGhRglZ3QoRwsDkf3lv27g8qSPanqaq+YOctOkU
	Aq6S8HAYgSFQ7I9ns88rCDgfCezn3g59p3wFF0xYI3jBKQoKKDkAxcsQ7EAx7Qa7CHH07lvRqng
	q
X-Gm-Gg: ASbGnctaBNnNi1ld9ipVhZM5fbvA6r4D+2syQuDCh/EbWHUyZex3h3Gh117+zcwkVlp
	J44UpBYF1LD22MLKl3QTO4RtFKd0M+HjMUPo+2hKxwdCjSm12ue6h+ExBSqDj6EQ78G+8a5H0KD
	SVYFTwuFMOUwDB1MT8wj3kOsLCABdJuN7c9OM+IDxGXDVSxXcKQtUn8DlJ2suLvYlvA0RbEHFL+
	JI1ZpeAs7xmJdVaPAIpP2HeqQ+1PvRylyw7azgyh5ci3utdfI1+f5gVvSoXiB6aCuSJeATfBzKz
	byHIP8bNUHJS8BuwbXN0ZB54HlzbhyYFwamkARBbvxAL9ra9bgyILsJTpgKN1aJdFnXe/KAE5N5
	mv86G8mZWSn1PIH08zi4=
X-Google-Smtp-Source: AGHT+IEP0a0+rz1FpPGpDJILlNEcSmPDSzAVYxcrWs4HVj8yijchEkWPI9guaC2Y1C/4dowLWQqWYA==
X-Received: by 2002:a05:600c:45d1:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-43d3b9813f3mr64937165e9.6.1742399210923;
        Wed, 19 Mar 2025 08:46:50 -0700 (PDT)
Received: from [127.0.1.1] (host-87-10-75-167.retail.telecomitalia.it. [87.10.75.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f6bf09sm22565005e9.26.2025.03.19.08.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:46:50 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 19 Mar 2025 16:45:31 +0100
Subject: [PATCH v3] iio: dac: ad3552r-hs: add debugfs reg access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250319-wip-bl-ad3552r-fixes-v3-1-9975b38c0082@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJrm2mcC/42NwQ6CMBBEf4X07Bq62CKe/A/joWW30gSFtKZKC
 P9u4ehFj28m82YWkYPnKE7FLAInH/3wyFDtCtF25nFj8JRZYImqrGQDLz+C7cFQpRQGcP7NEQ7
 OWm6IJKEVeToG3oq8vFwzdz4+hzBtL0mu6Q9hkiChdbIk7QwrNGdrpt7bwPt2uIvVmfAfD2YPa
 qUtka7rI395lmX5AGECNvADAQAA
X-Change-ID: 20250319-wip-bl-ad3552r-fixes-4fbbe9dd1d2b
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.14.2

From: Angelo Dureghello <adureghello@baylibre.com>

Add debugfs register access.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v3:
- remove unneeded debugfs include,
- move max_reg_addr in model info structure,
- set read size to 8 bit, always.
- Link to v2: https://lore.kernel.org/r/20250319-wip-bl-ad3552r-fixes-v2-1-2656bdd6778e@baylibre.com

Changes in v2:
- set reg size setup as inline.
- Link to v1: https://lore.kernel.org/r/20250319-wip-bl-ad3552r-fixes-v1-1-cf10d6fae52a@baylibre.com
---
 drivers/iio/dac/ad3552r-common.c |  4 ++++
 drivers/iio/dac/ad3552r-hs.c     | 20 ++++++++++++++++++++
 drivers/iio/dac/ad3552r.h        |  1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
index b8807e54fa057fe02afd9734ad67a4eb0a498e3a..38baaea0e6c85cba7ac6f334a3c31c7be88ac780 100644
--- a/drivers/iio/dac/ad3552r-common.c
+++ b/drivers/iio/dac/ad3552r-common.c
@@ -43,6 +43,7 @@ const struct ad3552r_model_data ad3541r_model_data = {
 	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
 	.requires_output_range = true,
 	.num_spi_data_lanes = 2,
+	.max_reg_addr = 0x46,
 };
 EXPORT_SYMBOL_NS_GPL(ad3541r_model_data, "IIO_AD3552R");
 
@@ -54,6 +55,7 @@ const struct ad3552r_model_data ad3542r_model_data = {
 	.num_ranges = ARRAY_SIZE(ad3542r_ch_ranges),
 	.requires_output_range = true,
 	.num_spi_data_lanes = 2,
+	.max_reg_addr = 0x49,
 };
 EXPORT_SYMBOL_NS_GPL(ad3542r_model_data, "IIO_AD3552R");
 
@@ -65,6 +67,7 @@ const struct ad3552r_model_data ad3551r_model_data = {
 	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
 	.requires_output_range = false,
 	.num_spi_data_lanes = 4,
+	.max_reg_addr = 0x46,
 };
 EXPORT_SYMBOL_NS_GPL(ad3551r_model_data, "IIO_AD3552R");
 
@@ -76,6 +79,7 @@ const struct ad3552r_model_data ad3552r_model_data = {
 	.num_ranges = ARRAY_SIZE(ad3552r_ch_ranges),
 	.requires_output_range = false,
 	.num_spi_data_lanes = 4,
+	.max_reg_addr = 0x49,
 };
 EXPORT_SYMBOL_NS_GPL(ad3552r_model_data, "IIO_AD3552R");
 
diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index cd8dabb60c5548780f0fce5d1b68c494cd71321d..37397e188f225a8099745ec03f7c604da76960b1 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -464,6 +464,25 @@ static int ad3552r_hs_setup_custom_gain(struct ad3552r_hs_state *st,
 				      gain, 1);
 }
 
+static int ad3552r_hs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+				 unsigned int writeval, unsigned int *readval)
+{
+	struct ad3552r_hs_state *st = iio_priv(indio_dev);
+
+	if (reg > st->model_data->max_reg_addr)
+		return -EINVAL;
+
+	/*
+	 * There are 8, 16 or 24 bit registers, but HDL supports only reading 8
+	 * or 16 bit data, not 24. So, also to avoid to check any proper read
+	 * alignment, supporting only 8-bit readings here.
+	 */
+	if (readval)
+		return ad3552r_hs_reg_read(st, reg, readval, 1);
+
+	return st->data->bus_reg_write(st->back, reg, writeval, 1);
+}
+
 static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 {
 	u16 id;
@@ -639,6 +658,7 @@ static const struct iio_chan_spec ad3552r_hs_channels[] = {
 static const struct iio_info ad3552r_hs_info = {
 	.read_raw = &ad3552r_hs_read_raw,
 	.write_raw = &ad3552r_hs_write_raw,
+	.debugfs_reg_access = &ad3552r_hs_reg_access,
 };
 
 static int ad3552r_hs_probe(struct platform_device *pdev)
diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
index 768fa264d39e9e6d517aeb4098382e072f153543..9bb46a9e07a586d407a400094f1872ea79836dc3 100644
--- a/drivers/iio/dac/ad3552r.h
+++ b/drivers/iio/dac/ad3552r.h
@@ -156,6 +156,7 @@ struct ad3552r_model_data {
 	int num_ranges;
 	bool requires_output_range;
 	int num_spi_data_lanes;
+	int max_reg_addr;
 };
 
 struct ad3552r_ch_data {

---
base-commit: 6f9141cdd726e82d209b5fc6d6b5ea32ace339f1
change-id: 20250319-wip-bl-ad3552r-fixes-4fbbe9dd1d2b

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


