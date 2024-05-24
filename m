Return-Path: <linux-kernel+bounces-189079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7148CEAC1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE151C2098A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629EC80603;
	Fri, 24 May 2024 20:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WPhpa23q"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078457333
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716581902; cv=none; b=LLHipP5vXnWFKL03hfjzVMc2ibaurcR4vksUoxbmltfR+I4+0hRY1VH4xPVGllsp1eARECwCYNr4QcrYuE6X5YUxklvUwiOQ8A6lt+9jQBIeYW2FF+140um5zVw5egPkqStjFmybSGl3yT+riKo9i/CTCrCPTOYXijZ6+eHJzKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716581902; c=relaxed/simple;
	bh=bYYuHzRG311cDXeGndQWVZB69Of4dQS40MzsRUiyPbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqX14q7S2S8mPytnBrzRiRLtseiQupuU3jiTdxQPmhf9nyy0RuxIRMIWIjr3ESoCTPGeAkxe2Hj3gRFZq8uFmfk62vqo9UCtsCtKx8qAvuKkmmAxqypHS/uZlcY6fWhpUNmU+M23GfVQYxCfABTOhl++cpQuEN4cPW3stqqYdAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WPhpa23q; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-24c0dbd2866so2789724fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716581899; x=1717186699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sykLvYr/gOGSRUZAM2N3tbLtBfP+F9YMWbHwRYeKemw=;
        b=WPhpa23qwfMo7teBUAK0BdEbd/JFQDNGGFLfqEr8Fe8KDlPC14qG136uvZpSY0UQYG
         74Z1cSfY2RkgY67qmjN95JRzto6EJ6sKkSAEOM1DCI9DHLETZvi+5fCRZiqDDb+Oiu/B
         KoKOD2Fm5gCofLJ91XEP01JZDQOBoWmAANz/uN6LEWYJxNREdIfHEgcSOsIuNQzxdw87
         GyESwK0KNvwzYARkdzSThA0BpFLk3sn5mtFZtzo4tLnEsDi0XiH23jQOpv+XHJLalfVJ
         0YCaJdKN2Y/6j6drQs4rQCSn6b48ajyoHmQuu8KG87SmNMYQIpLbSxiVRX2/TfNUopQV
         Mjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716581899; x=1717186699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sykLvYr/gOGSRUZAM2N3tbLtBfP+F9YMWbHwRYeKemw=;
        b=KdxiTOYpv3S7BTWvR49LwD+jxj9AYvpAEr2G5uWQYJAE/Fu7BM34PD30ZHRuK2T3LQ
         Ux6FaK7ZVkl1pa3NjfvncqwU/12ow/apVq7Tkyf1t8JN9BF/BYUrAm2vCa9LfpvPazeg
         5iCbVahwqn4zv2QOgUxwTSiocj2K8HxTyAKKPSDfgggqHUWoQt2m9gmn12m67du+5EX/
         94EGjl8T3JyVMcDDVfV8X6pem8PXqXfHhirxNj0rDGONI1gbwPRrcHZ4tV2NXhEwq5nn
         QCmYyJcAx0zYqdLjPwTDAH85j3kgkrx0qpxHO5vAb33E5h//eTbxc730sWZghJ7+1SBg
         +bsg==
X-Forwarded-Encrypted: i=1; AJvYcCWDnugUKf3m1BYbbgR8a8B6RpyV9gln7wlXwdD1mgoHwfS6vD3MQvQ/lhyLb9Nx+fXH0zBdozGFvkhZ4LlpWyNzS7XqnhUzgF27XkLg
X-Gm-Message-State: AOJu0Ywv5QI7UeOsY762JlGmEiZLxcFeQ5Q0vjBF7VoDTZvEWxdTT7hb
	T0Sa1SXUVBC4wDg8IEs3LxUTohkWD2/5YT5TMda2bBWdvF8dui9ebWyNlPkZ7yOJb+DH8KW4YxV
	vekQ=
X-Google-Smtp-Source: AGHT+IHAevnZuRCsFSPJzWXtRe81dz5ChfteCBc9cIC38XtQdOL6ERojL4L2hC72yg+K4kj9dkbqAg==
X-Received: by 2002:a05:6870:168e:b0:23d:1a0f:f034 with SMTP id 586e51a60fabf-24ca13dd501mr3512549fac.46.1716581898265;
        Fri, 24 May 2024 13:18:18 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-24ca2840481sm516737fac.57.2024.05.24.13.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 13:18:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iio: introduce struct iio_scan_type
Date: Fri, 24 May 2024 15:18:07 -0500
Message-ID: <20240524-iio-add-support-for-multiple-scan-types-v2-1-a6c328fdfab7@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524-iio-add-support-for-multiple-scan-types-v2-0-a6c328fdfab7@baylibre.com>
References: <20240524-iio-add-support-for-multiple-scan-types-v2-0-a6c328fdfab7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This gives the channel scan_type a named type so that it can be used
to simplify code in later commits.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes: none
---
 include/linux/iio/iio.h | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 55e2b22086a1..19de573a944a 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -173,6 +173,27 @@ struct iio_event_spec {
 	unsigned long mask_shared_by_all;
 };
 
+/**
+ * struct iio_scan_type - specification for channel data format in buffer
+ * @sign:		's' or 'u' to specify signed or unsigned
+ * @realbits:		Number of valid bits of data
+ * @storagebits:	Realbits + padding
+ * @shift:		Shift right by this before masking out realbits.
+ * @repeat:		Number of times real/storage bits repeats. When the
+ *			repeat element is more than 1, then the type element in
+ *			sysfs will show a repeat value. Otherwise, the number
+ *			of repetitions is omitted.
+ * @endianness:		little or big endian
+ */
+struct iio_scan_type {
+	char	sign;
+	u8	realbits;
+	u8	storagebits;
+	u8	shift;
+	u8	repeat;
+	enum iio_endian endianness;
+};
+
 /**
  * struct iio_chan_spec - specification of a single channel
  * @type:		What type of measurement is the channel making.
@@ -184,17 +205,6 @@ struct iio_event_spec {
  * @scan_index:		Monotonic index to give ordering in scans when read
  *			from a buffer.
  * @scan_type:		struct describing the scan type
- * @scan_type.sign:		's' or 'u' to specify signed or unsigned
- * @scan_type.realbits:		Number of valid bits of data
- * @scan_type.storagebits:	Realbits + padding
- * @scan_type.shift:		Shift right by this before masking out
- *				realbits.
- * @scan_type.repeat:		Number of times real/storage bits repeats.
- *				When the repeat element is more than 1, then
- *				the type element in sysfs will show a repeat
- *				value. Otherwise, the number of repetitions
- *				is omitted.
- * @scan_type.endianness:	little or big endian
  * @info_mask_separate: What information is to be exported that is specific to
  *			this channel.
  * @info_mask_separate_available: What availability information is to be
@@ -245,14 +255,7 @@ struct iio_chan_spec {
 	int			channel2;
 	unsigned long		address;
 	int			scan_index;
-	struct {
-		char	sign;
-		u8	realbits;
-		u8	storagebits;
-		u8	shift;
-		u8	repeat;
-		enum iio_endian endianness;
-	} scan_type;
+	struct iio_scan_type scan_type;
 	long			info_mask_separate;
 	long			info_mask_separate_available;
 	long			info_mask_shared_by_type;

-- 
2.45.1


