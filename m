Return-Path: <linux-kernel+bounces-571909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32378A6C432
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3974A3BC8E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D323237B;
	Fri, 21 Mar 2025 20:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qxw+Q4b7"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109B3230D3A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589011; cv=none; b=KoRuVxpMy2mnuyuJ90su8eXpnamo3S6CTtbV/JHVeXM4Ya/NsDCMA/1vkgYs3PNj94REptxHSGV6CfI8NAPw3+x+Mv66YBNdweXPL5Rye7Rrpl2Lq/oxlFEyIYmwwW/F8Myzrua5Q6eYgrYg+CFiQxAUIzYck8Go6/j1gUjx/uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589011; c=relaxed/simple;
	bh=hWSr+N4q8jPBwyhE+M9punDDVddf1n2Qdd8iVHO9YtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSoFRV2OGP1XJvCCssVe+/PFFZrkxtarbnhlWgX+RC9ArWsuu3z7V6SWskhGH3LWLMENT86t+Kwxu5rLtKyjM1n1L7tLLXQI/pDZ8ukFelJvutgHe+xZRpQZpze2x4gGZGc1ZGUi5UGFO7cWQcYZHbMxCvyrqo4t3+fAzs/zVTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qxw+Q4b7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso2181173f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742589007; x=1743193807; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hl8ec5RDehNYBKLIScFWmbMlzzx1NzVQIVCz8eQlZvo=;
        b=qxw+Q4b7IJ7P8+PLD0Elrll/p4/sRkpufAO5EvF5cHRpsrkMcumqf8ykd+wZdVbSL2
         +yXg5SyBkfZRrruYKZi1WY/JaUhAiVhunRr8ARDTzNPSG8JETEeUbgXyJh+rYUaVcPZP
         iPWjjiOi8OiWzTysG6G909G3d1i/SdSjbpjhhvGUqUGkbOlfWxwsTzSYUYWgQuIyunrq
         5paWU3l/3QfD7jNljDn+GgDH8m3n6RGnKF1L5iBe1cIrnuk3+zQfQNxfhiP5u+to2lzX
         c0OtDMnMbZDhGG7MlvYqD3aWPuxkJmFkFJYjIwiB83Bj16DJ/8W8NN/wi66Vq/HzuKX6
         HBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742589007; x=1743193807;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hl8ec5RDehNYBKLIScFWmbMlzzx1NzVQIVCz8eQlZvo=;
        b=Nd21Qb/XSQHgzpMkyqrkrkOwUwQltBW/vFXe2kkYfZJcaQXXDa3AvQF+F6DICJHKF7
         0w9qhYtkWFFVKJtNy2hWJ0l9czYxnEHpR1yT3gU9ml0WEAb1CktfethkaszEa2MNFQlR
         jfuF0DBQ33w80viIwNmdz68SDvmJFzNAd8ZtFlUaRFSWG93qu8yfVjdNI1Se/IF2XX2p
         twsuH+Ehmidi84GPk/t28SUvUu37nL7DGaUAnsPUVjGtIJkq7U74IbnohBw9vQpssxWG
         WJB5SltWGsKejHL/Kgf9jGDorDF/um5IsmDk4/FBK9KiYcYjjuaVI+GAymct4/qcGrhK
         27Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXrtYNZjv/sCeKLlWGw+UF7IUJ1mxXE1yfd6EMJLfrMBr4b1jrInWtYw6WH5dnAKdOywTDRhbRlsnazhS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpry1m3rzzY1QgJ3H0MEkifNjKB37QLgmslMwQiHxRHFabjIfZ
	j3NaRWFo3/h8zZab0FK1H7hAHrdODUP3goHNC35zd5w1H/N+G4UIrQh45Fzapbs=
X-Gm-Gg: ASbGncvDuNudv7/4I1/XAomMMGopVBzyJXaWQTACyWSEFqW8xSIWoT6A6wF0BD9EuQo
	vwBrLdmlnhWzH4Y022O6AUI3N6j/WyuqYXUrfFT2mLm07l8SHXs13Lb2bfULh35N/htwUzqR/bQ
	uFuIJ4WbVMsMYj2Ouyyl0huUs3RPIPpxMFdWbyNDUHH7xfcYa1ifwTgnkRMAmQPCQr6wZEXfUqm
	QmoxyVeRzo0hBjXiDgjgt5dBDIQnk2d4M49BiSF+oA6EBwmUUYwX4YHK1ojHxg3nZCbdmOsbtE3
	/zN7wX/1p38ymqlx8dn+kXQu5n9LQJJPXl/NrVaRL/axwpWn9bdPIT/QTbbAkz0/uhMo+gyCtKV
	jxOs3WqYJXOQZ8g==
X-Google-Smtp-Source: AGHT+IHCTLucmhuzq/4rYnKJArEU8s60wFNIODgk7NLbKNSu1KiGUCksZNi/AgFQk55m9xo5mz+pag==
X-Received: by 2002:a05:6000:400e:b0:391:3f94:dc9e with SMTP id ffacd0b85a97d-3997f90394emr5540891f8f.16.1742589007075;
        Fri, 21 Mar 2025 13:30:07 -0700 (PDT)
Received: from [127.0.1.1] (host-87-8-62-49.retail.telecomitalia.it. [87.8.62.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9955c0sm3258380f8f.3.2025.03.21.13.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:30:06 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 21 Mar 2025 21:28:49 +0100
Subject: [PATCH 2/4] iio: backend: add support for data source get
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-wip-bl-ad3552r-fixes-v1-2-3c1aa249d163@baylibre.com>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
In-Reply-To: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

From: Angelo Dureghello <adureghello@baylibre.com>

Add backend support for getting the data source used.

The ad3552r HDL implements an internal ramp generator, so adding the
getter to allow data source get/set by debugfs.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/industrialio-backend.c | 28 ++++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index a43c8d1bb3d0f4dda4277cac94b0ea9232c071e4..c1eb9ef9db08aec8437d0d00cf77914ad6611b72 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -380,6 +380,34 @@ int iio_backend_data_source_set(struct iio_backend *back, unsigned int chan,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_data_source_set, "IIO_BACKEND");
 
+/**
+ * iio_backend_data_source_get - Get current data source
+ * @back: Backend device
+ * @chan: Channel number
+ * @data: Pointer to receive the current source value
+ *
+ * A given backend may have different sources to stream/sync data. This allows
+ * to know what source is in use.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_data_source_get(struct iio_backend *back, unsigned int chan,
+				enum iio_backend_data_source *data)
+{
+	int ret;
+
+	ret = iio_backend_op_call(back, data_source_get, chan, data);
+	if (ret)
+		return ret;
+
+	if (*data >= IIO_BACKEND_DATA_SOURCE_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_data_source_get, "IIO_BACKEND");
+
 /**
  * iio_backend_set_sampling_freq - Set channel sampling rate
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index e45b7dfbec35c094942a3034fc6057a7960b9772..e59d909cb65924b4872cadd4b7e5e894c13c189f 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -84,6 +84,7 @@ enum iio_backend_interface_type {
  * @chan_disable: Disable one channel.
  * @data_format_set: Configure the data format for a specific channel.
  * @data_source_set: Configure the data source for a specific channel.
+ * @data_source_get: Data source getter for a specific channel.
  * @set_sample_rate: Configure the sampling rate for a specific channel.
  * @test_pattern_set: Configure a test pattern.
  * @chan_status: Get the channel status.
@@ -115,6 +116,8 @@ struct iio_backend_ops {
 			       const struct iio_backend_data_fmt *data);
 	int (*data_source_set)(struct iio_backend *back, unsigned int chan,
 			       enum iio_backend_data_source data);
+	int (*data_source_get)(struct iio_backend *back, unsigned int chan,
+			       enum iio_backend_data_source *data);
 	int (*set_sample_rate)(struct iio_backend *back, unsigned int chan,
 			       u64 sample_rate_hz);
 	int (*test_pattern_set)(struct iio_backend *back,
@@ -176,6 +179,8 @@ int iio_backend_data_format_set(struct iio_backend *back, unsigned int chan,
 				const struct iio_backend_data_fmt *data);
 int iio_backend_data_source_set(struct iio_backend *back, unsigned int chan,
 				enum iio_backend_data_source data);
+int iio_backend_data_source_get(struct iio_backend *back, unsigned int chan,
+				enum iio_backend_data_source *data);
 int iio_backend_set_sampling_freq(struct iio_backend *back, unsigned int chan,
 				  u64 sample_rate_hz);
 int iio_backend_test_pattern_set(struct iio_backend *back,

-- 
2.49.0


