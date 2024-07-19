Return-Path: <linux-kernel+bounces-257155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8449375F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55DB1F24317
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C293E12FB31;
	Fri, 19 Jul 2024 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xtQDCHUk"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C64282877
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381990; cv=none; b=nbsgB8SUSDVMok9S98zgho3yw3U7HsZ0uG8QAKr9JlhFvreDo1JUnB+LvIz4myXzzCZsRh4Id1YKTPSI3mUcpIF9HOcaCyK6CP9PIFoQG6ucJ2eyih0lhH0QxOwewWDQVbt8gxO4u2QDKRm61MmB9OI8si7Rapg9enpHVRHRJtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381990; c=relaxed/simple;
	bh=qeJlyBqsETHxFoWL51EbJtaruSa98HAkPjxf8ZXN+zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdUHNtBtRnHy40Yenb1Hfy3xY4BUfNgBSsQKt/2jSHG4kOOhjmXxQaBa+NP4e49AwKzrZpiyl8o+ZoywtT3xxa5p3ouC+JjJmPO/u/4NIMID58gtPrFV3E38/02Wk1yMH3BpgRdolucOaTlqI6H7cXno9I2QljY2Zrz8pyJnDXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xtQDCHUk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-426717a2d12so7548005e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721381986; x=1721986786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok8qT5sg/ukyA77onQiJddqngdYN/iGCzJwgTQrvtPQ=;
        b=xtQDCHUkVqUpRH3WQLKTZb2YFypk3ZEJX5tn3xtAWXJVapLpQmK5LEEuvPfVaFtVug
         NO7jbuitL4qmo0+a69tXAvtJfAfoKvbeq8KiDF5VfWYobdBCNsq6nKdwq753i9wuDFib
         Fh5TabrdFhoD6bqO9ON2cEim79FH+GmBsQ+CEGXa0eAJB5dAHhxZ+tcLODVOx6kLCZjl
         6d6QQiDf8JNzOuuMER5IhlrBdmThs2bOZ45HICPDHwB+ki69TihVaFGJbpolzMPmFSY6
         TbwiQ/sm+uLmruqFu2dYpCcR5P6amzqCualEAMOBcgrPOoZB9t/Gm/vBM8HA+yQVnXNP
         A+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721381986; x=1721986786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok8qT5sg/ukyA77onQiJddqngdYN/iGCzJwgTQrvtPQ=;
        b=E2NEL43n5yHCfi+p486KO4UkuLMXSNf2q3QLWzKxUzuMXphjFY1EnbYAigoWtgIlod
         pryveSp95iwk8bYNNvf9TPk1sb9V7ubZebbJD/a/gfrlhg/QF9jM5iSXjrrXUHe/NJ8E
         XGxFAY/sqKrE3RQfD7SCHcB6bXUNyVKL2/sAkV5UUHgaN6khR5XUKGW9OGTAO7U5mh4D
         DShnPaghleW0F0FxEbTHnxxLJzDvSHA9Do+nrhBlrsKjZSIOBjKar6a4Ft0pBf0/6UFS
         u1O6osDYiQj66MaeNa11c8sektICksxdFYSE/tZQMSei5LonLhjw2X/JLTvu6XyX0Naz
         A7/g==
X-Forwarded-Encrypted: i=1; AJvYcCVHeYgCLXqA9rsQjCcTB/Y1BWbW3BPWFMBecDqrplB4egnTPxM+iZUtu7BJCfBqd/AsHQhg0ijuLEYXIRdcnytrRDaPcsGvBaDueMvf
X-Gm-Message-State: AOJu0YwkvxOB9BabTv2qLH/KVGYKlTWjDvLMQbhMx9QpMc8zcaUe057m
	8ATIdDaBTENduC2aLFjx5rq6g/hrUh0XFMYJthpf8vK/73VqSJlH2GJvum7Kq2gPvaKyaGJGnET
	Bpa0=
X-Google-Smtp-Source: AGHT+IFRBg62WuWS0T4N15ozxDHT5px+Wx0AGbkCxcIEYMBTBgmOQqIY2DCIWNCIKkRjdhVXnuc1yg==
X-Received: by 2002:a05:600c:3110:b0:424:71f7:77f2 with SMTP id 5b1f17b1804b1-427d2ad9f96mr23848925e9.16.1721381986549;
        Fri, 19 Jul 2024 02:39:46 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:5ac4:5655:4dfe:ce97])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3687868bc91sm1100956f8f.45.2024.07.19.02.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 02:39:46 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 1/3] dt-bindings: clock: axg-audio: add earcrx clock ids
Date: Fri, 19 Jul 2024 11:39:30 +0200
Message-ID: <20240719093934.3985139-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719093934.3985139-1-jbrunet@baylibre.com>
References: <20240719093934.3985139-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

Add clock IDs for the eARC Rx device found on sm1 SoCs

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 include/dt-bindings/clock/axg-audio-clkc.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/dt-bindings/clock/axg-audio-clkc.h b/include/dt-bindings/clock/axg-audio-clkc.h
index 08c82c22fa5f..607f23b83fa7 100644
--- a/include/dt-bindings/clock/axg-audio-clkc.h
+++ b/include/dt-bindings/clock/axg-audio-clkc.h
@@ -155,5 +155,12 @@
 #define AUD_CLKID_SYSCLK_B_DIV		175
 #define AUD_CLKID_SYSCLK_A_EN		176
 #define AUD_CLKID_SYSCLK_B_EN		177
+#define AUD_CLKID_EARCRX		178
+#define AUD_CLKID_EARCRX_CMDC_SEL	179
+#define AUD_CLKID_EARCRX_CMDC_DIV	180
+#define AUD_CLKID_EARCRX_CMDC		181
+#define AUD_CLKID_EARCRX_DMAC_SEL	182
+#define AUD_CLKID_EARCRX_DMAC_DIV	183
+#define AUD_CLKID_EARCRX_DMAC		184
 
 #endif /* __AXG_AUDIO_CLKC_BINDINGS_H */
-- 
2.43.0


