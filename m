Return-Path: <linux-kernel+bounces-350322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B7E990370
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F8F1F2146B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ADA20FA97;
	Fri,  4 Oct 2024 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="akpGldQZ"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47B920FAA5
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047099; cv=none; b=empXzRUATO98f7g3uJmAyvnBFwA3VfTrAMV1FYbp+5ijzQpouVWkI0J+AjF14+K3YYwwmpDQlO0aPGToQ4i2p2fqStb759v1dx8+22PsL0725U77ccKptfCvmVj6ITQ+YCIzC3zYYt+8LnxfYJvJEwbVUumr0E493Lm5Itj4rzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047099; c=relaxed/simple;
	bh=qqSKowVgiExwCTKItsRXI5m6aV4meAX5YXyRU8P+ERY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uS5elVLdsEhIKZObULSNtldXgnKUskHh0HE9DBs7y6RjnfysDSlz75U+LEm47QIJd6lVrc5bV8ybDYlXiHLRaRJuotkfhJuxhzQWLwaK3zd4rgvZyVGjslxHJX3YXToCp5lcMECZi79HP5iQ4kc34oMvtfAPp8otR829cqsjG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=akpGldQZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37cd1ccaf71so1810761f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728047096; x=1728651896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NB+OTwv7KhCxQhNRfvwJ8makfTxQYrktnchDrBIeFU8=;
        b=akpGldQZyZ0zm4B3raC+7F9urMMEAsJgCRVtKI+7lRRC8n4z3hZJH5N28IBd0ahSab
         eCRt/PxwLO0nuS7bWC7ZUULqBeXQ6bQPA+XgPFYJZI/+MortBYq+rQFuOu+PYpGRPYCf
         fQiyanj6JoGyywxQsVLKpuplgoJzed25P9l83XzBUU19TGA7LKGCNOIl1xJJKVhYxGNq
         OfQln5BJU81Mi79pou1vWBn1IxX90IaICIsK2D1XVRGnuxSm0di8uRuzHAJTrIXkARSU
         G7pOdyrgPnuEVOOhnSGFSEB507QqqUgXKMJtDBeG5zrR/HQK5Wq5UOns3DiQkrV9IGUz
         9IVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728047096; x=1728651896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NB+OTwv7KhCxQhNRfvwJ8makfTxQYrktnchDrBIeFU8=;
        b=TxYvRCoynk0u9v454F7YZsGex6OgUKbUfd7VePNghJBGp7IKxQnTqg9ptqf4595jg5
         GW3ZIvTyMnjnGE1tjpQ8Spe7OC8z97VaZ/3obtZLGhJydbd3EomFflv5KWz8L1tXX69q
         LcDizaqUrFm5OCvwLgLse9fN8OdDz7u3bJ3w6tMnaOZ5PlsG98w2sjImjhbFU2NPVou1
         Jx6USKUGkL7JffqVH3ZiKOcIVDHAINpq7whUzwpEXWRV7T0EZaxocgOEglA65OnMkHGA
         PQBIaagjNVQ3Urbz4sViC9VQZ6KZbzjD627MXk9EInhDijdlESERplEz/75zv8CW8N7d
         UcBw==
X-Forwarded-Encrypted: i=1; AJvYcCVVGsPmQsTD3nOv6J6tgoFP4h2iKILRdYWJkD725HwPlzGmkb4KIP2+DaXJ26JtMcnNMkIV5YzYi8YnHTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmfpY3sEsRX6beMDOVgf5hN0fq4r7u8NQmY5sDvfah2j5gc97
	RJamjs7kzBUbtgfWH79IbqMH8Z8zaXBEFQcZuwwLAZGVt0fhET1nIDo7opzZxhZgItoRes0FU+9
	9
X-Google-Smtp-Source: AGHT+IFvlYUaMQp7mO2HKne9Jf+cx0RUIFDz10F2F9W4zeht5Ec8QoZE0iLidX28kk1iLsnrlmOCFA==
X-Received: by 2002:adf:e541:0:b0:37c:bafd:5624 with SMTP id ffacd0b85a97d-37d04a783bemr4483343f8f.25.1728047095862;
        Fri, 04 Oct 2024 06:04:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:80ea:d045:eb77:2d3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d0822b94fsm3219041f8f.46.2024.10.04.06.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 06:04:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] power: sequencing: make the QCom PMU pwrseq driver depend on CONFIG_OF
Date: Fri,  4 Oct 2024 15:04:49 +0200
Message-ID: <20241004130449.51725-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This driver uses various OF-specific functions and depends on phandle
parsing. There's no reason to make it available to non-OF systems so add
a relevant dependency switch to its Kconfig entry.

Fixes: 2f1630f437df ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/power/sequencing/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index c9f1cdb66524..ddcc42a98492 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -16,6 +16,7 @@ if POWER_SEQUENCING
 config POWER_SEQUENCING_QCOM_WCN
 	tristate "Qualcomm WCN family PMU driver"
 	default m if ARCH_QCOM
+	depends on OF
 	help
 	  Say Y here to enable the power sequencing driver for Qualcomm
 	  WCN Bluetooth/WLAN chipsets.
-- 
2.43.0


