Return-Path: <linux-kernel+bounces-384618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B059B2C72
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A949E1C2184D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089F61D54F2;
	Mon, 28 Oct 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d3oHDZMt"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837CA1D356C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110351; cv=none; b=pIxdyeS9vFUhR3Y9BLb4sKP7Ksxo17CAIKO+GbESyDMOPvaAESbqIz61MLLuoRF7FprBdLBsgSlklFdRyWiCvk8UtZvxNwrGgv5jAMuszrP8kwPWCGutpe4enIOOFY6cPvqKRdl+YC5fEKkASIeN0x3uru44/vM4Folb5bLFBU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110351; c=relaxed/simple;
	bh=NTUbVMYf2x+7q0/8Barwlk+9iZKYWLsfR/svD0SOK6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GhBCm43is/B1y8hJDVhGh/7XBtJRfNOnzSM5FtXLCV8eiX39hBBi9Q/SJg+HY//BXBDK7jjJUgHhQw8j9X+fs6E5uozBPcfWyV5mVOuuNvvTMrAIPRwrBGSzBpc5SjVtGXrxuzqEqRHhKYL1hw7pnDYCqYqa96UAnnXag1FKd2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d3oHDZMt; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b12a02596aso271001585a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730110348; x=1730715148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQttLL6CFS2JGt87dEF+H1Jt5OZPaXEa5P0U/qvO3f8=;
        b=d3oHDZMtR18DuCbqysVGh6pi6eeljQ3JK6Yz2PfKryIKssvbyVizk60igQBz6e8yM6
         17T5GLtrlJUjQFl5kuhwV2LZks0X0GJzL2RumsNmGypwYTx51+jrHdi4mj+acaSSqqYa
         5JLeen0kjS3O9ot4+miMlPaofp/x+xu5dD/l0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730110348; x=1730715148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQttLL6CFS2JGt87dEF+H1Jt5OZPaXEa5P0U/qvO3f8=;
        b=K8wZ0FDBT1fIXDGfxqu09MbGES/DhcXHyOv1ZAJ5xSt/DR/gM3hWGn3ZXHj+Y/f6Zw
         EaXtgVRUt6mdUi156h59s7Mx5LJICBxYx5an7GNZnhoILcb1BRBeGZdVr6kmdxBSzlfk
         WIm4c1pEDV1i892AqP5sPgT18fI8U8FIlH1piMPRGjprq2ygSiru/1qMVpC3KCVPZ1Jo
         b1wrPSgWz/OvyRxzgFdKNifzKgtSiQmC+YEDezn+Hvk4BofUGnJIQtHD2yKfFpGEi000
         1BHWb+4uq5HXIm4sY1q0N/YV3pkB2vAC/qV/i2Vi55FRjoMrXDtasST4fF3Hy1H+o99G
         4Tcw==
X-Forwarded-Encrypted: i=1; AJvYcCX98hSxFEO7ouLx7QwjgELslm7tM/p/HBkjt6Dw64xHBtuOD2+hndrByKzy8FKYSClXkvgHfeE2Y6Prc78=@vger.kernel.org
X-Gm-Message-State: AOJu0YylBYLdOiF/VMskOtMNblds5cV4QOVLibbLRaqNzD6/0uwXRfye
	6c1PFgZEo9Zc5pRyZiW5p4/0zA3FJJ3Jdb+pvJg8R8ZeTtXfXeaC6SE1LIsQMurz8ZZanHj7xQc
	=
X-Google-Smtp-Source: AGHT+IE7gju3lR9oh1XlvsgIv53d3OKuEjmakLCZimRscmiZdz5oon55ZQwCRr1XRbsUh4kcj4mSzg==
X-Received: by 2002:a05:620a:2413:b0:7b1:558e:97b0 with SMTP id af79cd13be357-7b193f75ca1mr1105568885a.66.1730110347886;
        Mon, 28 Oct 2024 03:12:27 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d279126sm305483385a.9.2024.10.28.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:12:26 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 28 Oct 2024 10:12:22 +0000
Subject: [PATCH v2 2/5] iio: hid-sensors-prox: Factor-in
 hid_sensor_push_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-hpd-v2-2-18f6e79154d7@chromium.org>
References: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
In-Reply-To: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Harvey Yang <chenghaoyang@google.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The function is only called from one place and it is a one-liner.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/iio/light/hid-sensor-prox.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 26c481d2998c..d38564fe22df 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -153,14 +153,6 @@ static const struct iio_info prox_info = {
 	.write_raw = &prox_write_raw,
 };
 
-/* Function to push data to buffer */
-static void hid_sensor_push_data(struct iio_dev *indio_dev, const void *data,
-					int len)
-{
-	dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
-	iio_push_to_buffers(indio_dev, data);
-}
-
 /* Callback handler to send event after all samples are received and captured */
 static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
 				unsigned usage_id,
@@ -170,10 +162,10 @@ static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct prox_state *prox_state = iio_priv(indio_dev);
 
 	dev_dbg(&indio_dev->dev, "prox_proc_event\n");
-	if (atomic_read(&prox_state->common_attributes.data_ready))
-		hid_sensor_push_data(indio_dev,
-				&prox_state->human_presence,
-				sizeof(prox_state->human_presence));
+	if (atomic_read(&prox_state->common_attributes.data_ready)) {
+		dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
+		iio_push_to_buffers(indio_dev, &prox_state->human_presence);
+	}
 
 	return 0;
 }

-- 
2.47.0.163.g1226f6d8fa-goog


