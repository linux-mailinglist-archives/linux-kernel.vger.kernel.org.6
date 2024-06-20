Return-Path: <linux-kernel+bounces-223089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E75E910D68
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088EB1F21C25
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9293B1B150D;
	Thu, 20 Jun 2024 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NorucK+F"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A36C1AC765
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901853; cv=none; b=WLAa23E1ZO9bkIB8I+vbpFMyEQlY7zlGugvhpi5u3nGIJFyPgYZigyhGygHLE10hhJWYKriVgl01MH3NQMKK1uqpfXrLWmBskv6V5FGGEZRiqzEQ9OoGoek5ks9C5dAVu4pVkRCASbehncCVwWecUz2UqT10Cxnl+HWpUt3EZkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901853; c=relaxed/simple;
	bh=76J+gcIMqVtrd1dnHd8BqIFVfLrshWfX+0uF+47IVNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UkXxsoXB3h5m/x6u79OAgCIRkHTqzC0L8IQS7IRLXH4irD9n8hNeEQoeqKE8B/U2GvJKof9YlgcGG56hHKoia+Y2VBwbVTxbV7KsbGNbKCjlbjGmy7U5egkOtjmOXd//ufSXW4ehuNW2JnBrq3zbUc7fUZLDd6oVpnU+QmBCzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NorucK+F; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f9a7120d9dso596177a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718901849; x=1719506649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C9VDkwL+Cj1v/F1tGicEGCYp7P9Va7Bog3dfkmqgF+k=;
        b=NorucK+FGhjQHAYaGPB89DWlEVuunUZNllzEXJW0A/olYepjkiUlmIEOTrdnyGj8AU
         o6dDv4VzDGy7t/qZzoNbP9wUzLZ3z1g6hp6ID7ZVS0RMTreeFwIy6u3I4SJbM2+0Y5M/
         T5xsBkuvC+YuH+udqpRK3nl3n/Pv7V3n4SSICuJw3oX2p9L4ko/X0CiblNkafnv5w1Kt
         wipdJe79Bz3rR0+5qBuu7oyjzRmWbcs7NmLcNUutXeJYPQQqg7CxBu9VwZG++cUQLpWq
         CRHK/RFMrcxxUozoHzHh25DCeegeoV1R2SsmQVmbmWESkM3v7DFe1Fri3AhYUUJxNSPU
         eCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718901849; x=1719506649;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9VDkwL+Cj1v/F1tGicEGCYp7P9Va7Bog3dfkmqgF+k=;
        b=kZVFh8DCqHKuq/rw7FGTo749aZp2na/DQnHY3Qw33gNEx/N28nlZEkzxzoBm9QGPIb
         AtHPZ1y6ifddB38J+q9492uj6ye29V6REINwtx7p828gDhq/HtUJjGMFF3RCUGkC0ey4
         exy0AwCuEFA4A76dp7h7s+s5MBWANISxwXWgYRWX7Y4hx8Ae69g/HIslhM6jyiK2HY7n
         PXAIp9jYuE4g+VW5hh5za0Y3P7OnrATyhlEliYfPQtchQTZ4PFm7cWGNMUdU5BwZA8mq
         uG7tFTy5uS6Q9xuWYQNGxcSfBfIGL5/qfIEHLPJqJkaAjmHCom0vT8kuyNLfYFMm32gG
         cH+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrkFr/j66Er/Xt/6Qc01rqNkvi2AU45NzRGJ4u01foVE+cVdJ9y1cgb/FAKYPJVVdHS6zvGToidxmV6ko5Q1YUWlI49KXhtDvtKcHv
X-Gm-Message-State: AOJu0YwetZ62FaAfHHw+CT2MrHHhb2kU/iOCivkG68f1vHpKtJf7Qjgn
	w69Rzdvf2lSbVBgbvMlHtjPK1QCsPIoV6SIj9GZFkeW0gJiJihcWYEACt+xCqrY=
X-Google-Smtp-Source: AGHT+IGmJO4WMFk5+tOgWThlf9Q5w5q4lByYO+901JreOLMbEyPeiwC8JLJrQVUJLWnjqc3VTClsWQ==
X-Received: by 2002:a05:6830:4112:b0:6f0:486a:6029 with SMTP id 46e09a7af769-700743fb532mr7476132a34.22.1718901846886;
        Thu, 20 Jun 2024 09:44:06 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6fb5afaa06asm2594140a34.6.2024.06.20.09.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:44:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: axi-spi-engine: fix sleep calculation
Date: Thu, 20 Jun 2024 11:43:58 -0500
Message-ID: <20240620-spi-axi-spi-engine-fix-sleep-time-v1-1-b20b527924a0@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The sleep calculation was not taking into account increased delay when
the SPI device is not running at the maximum SCLK frequency.

Rounding down when one SCLK tick was the same as the instruction
execution time was fine, but it rounds down too much when SCLK is
slower. This changes the rounding to round up instead while still
taking into account the instruction execution time so that small
delays remain accurate.

Fixes: be9070bcf670 ("spi: axi-spi-engine: fix sleep ticks calculation")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 3231f67ae265..103a68bd4f19 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -169,16 +169,20 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 }
 
 static void spi_engine_gen_sleep(struct spi_engine_program *p, bool dry,
-				 int delay_ns, u32 sclk_hz)
+				 int delay_ns, int inst_ns, u32 sclk_hz)
 {
 	unsigned int t;
 
-	/* negative delay indicates error, e.g. from spi_delay_to_ns() */
-	if (delay_ns <= 0)
+	/*
+	 * Negative delay indicates error, e.g. from spi_delay_to_ns(). And if
+	 * delay is less that the instruction execution time, there is no need
+	 * for an extra sleep instruction since the instruction execution time
+	 * will already cover the required delay.
+	 */
+	if (delay_ns < 0 || delay_ns <= inst_ns)
 		return;
 
-	/* rounding down since executing the instruction adds a couple of ticks delay */
-	t = DIV_ROUND_DOWN_ULL((u64)delay_ns * sclk_hz, NSEC_PER_SEC);
+	t = DIV_ROUND_UP_ULL((u64)(delay_ns - inst_ns) * sclk_hz, NSEC_PER_SEC);
 	while (t) {
 		unsigned int n = min(t, 256U);
 
@@ -225,10 +229,16 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 	struct spi_device *spi = msg->spi;
 	struct spi_controller *host = spi->controller;
 	struct spi_transfer *xfer;
-	int clk_div, new_clk_div;
+	int clk_div, new_clk_div, inst_ns;
 	bool keep_cs = false;
 	u8 bits_per_word = 0;
 
+	/*
+	 * Take into account instruction execution time for more accurate sleep
+	 * times, especially when the delay is small.
+	 */
+	inst_ns = DIV_ROUND_UP(NSEC_PER_SEC, host->max_speed_hz);
+
 	clk_div = 1;
 
 	spi_engine_program_add_cmd(p, dry,
@@ -257,7 +267,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 
 		spi_engine_gen_xfer(p, dry, xfer);
 		spi_engine_gen_sleep(p, dry, spi_delay_to_ns(&xfer->delay, xfer),
-				     xfer->effective_speed_hz);
+				     inst_ns, xfer->effective_speed_hz);
 
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list, &msg->transfers)) {
@@ -267,7 +277,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
 					spi_engine_gen_cs(p, dry, spi, false);
 
 				spi_engine_gen_sleep(p, dry, spi_delay_to_ns(
-					&xfer->cs_change_delay, xfer),
+					&xfer->cs_change_delay, xfer), inst_ns,
 					xfer->effective_speed_hz);
 
 				if (!list_next_entry(xfer, transfer_list)->cs_off)

---
base-commit: 3f685a501f2ee00111ce930e9a210b9eab5e759d
change-id: 20240620-spi-axi-spi-engine-fix-sleep-time-6f0b7c147a0f

