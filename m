Return-Path: <linux-kernel+bounces-207502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD8F901821
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 22:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E50281245
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 20:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5592E4D8BD;
	Sun,  9 Jun 2024 20:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UdFrUZmL"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188F247A7A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717964846; cv=none; b=DUjaM2jgJgfyUr7MfZH0zvtnlSXWshNOO+EvUXhbOnmVZ9RBD9qrRGm3uikCx3jBgw17mJ6TRjJHYwAMUr2UhI+8SWojHz1K0MmfotbA70xXxH8iFjCZB70NZwaK2Xkg+kv0Y9YmnflDTgNjjX0uOMhs6ecoMbpavXqwUEK51XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717964846; c=relaxed/simple;
	bh=P2yzPJodq4h5YIN8ovSMmJRCJKvyoJQi2FOaksZYxzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W8bafIyLjO3jx6C5I5lWWN+J9FvFIrypfvepj1eMIbGo30c4ZGkwtK5uxlOl0pdC5p6hnjAhrjE9n8vvUCT93rqcOXBKjWFkq6BD0BkPk3eTmJcW3oDQH44eQkdG4JPAl5Y5Scgmt6MsBkIc6pEfUtFBElxfDTilKDJi2aarl0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UdFrUZmL; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f361af4cb6so1108545a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 13:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717964843; x=1718569643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FmHzB4XbyiULyr7+qCoY+u5mwDNUrkNjS2sO5Rn1BI4=;
        b=UdFrUZmLQh/taAvgECDNEjqxGC2fu9/HAgGd8Tgra8bJLst7e5XgdQPlnc4aZ0Hrn2
         VrWiHJ7k4NizXNhmS0L/7koOO/yLvK3WGx4uzWIzJLm9+drUopt90aKTU+AZNfcHvT/4
         9w863NBoR/D4s/w9Iusqm62IM8YKtNRmaFOSKM0MSfMEH+enu7qoIB6G5NZh3cBHFE1g
         UkoJK7VHPefnGKB105zMOVPFnbj8aJROxX3ejxKaPyWEnRCnHcxcum9ddq5YSDw3Age7
         Q3VWmLTQ21qGXYYrmCsT65Y1HbPAov7c7o900SLYL5rN9X5NusOkKYZcVQeAme4bRE2C
         /tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717964843; x=1718569643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmHzB4XbyiULyr7+qCoY+u5mwDNUrkNjS2sO5Rn1BI4=;
        b=qfR3QQaTPpp0qdydDls7FY6kvBK1JUEhP1GJ+MQJ4QWNVYjBklPGAQgaGR986TqBrC
         0rSoY5xN16d94JkvbBjK1MxFxubkERj62rFIrDm1gWCsMo393AEMmLYPWsxxxUX0qMO9
         lkjj3LWtTdCpkh8kc5qk6mTb9z8ekUw1REpjrzBFHHcIYD5J1lT/cvx5lTyquMC54suI
         4RgFhnzx832APiHIUaEq2i4Lq5UG6F4W+9W03km7QKsj2zBegJPyy41kY6z4ow3LDdMe
         GWmt25O4I60I9fZHCPygDxIdOX/PZDYNQe+2J1uOrLvEdV8gooPudGDMPql0nqm9cgEO
         bQVA==
X-Forwarded-Encrypted: i=1; AJvYcCX/Vdk9j8INSgvbSDriD+b/7jHQRTSKK9JzAReCUtp3tpk1V6PLrricGvwFzj2PuzW1+zkmt2/pC1PPXIXLIQFXmHIKiwWtqufRdmG5
X-Gm-Message-State: AOJu0YzGhmdf8H9TlhZC+n8Jztdw9uvVJm2umnqTLfPNNtY6PVAx8a94
	qwwXMAiNHuKv4A3yDfVRIvpfvOOIsi1cJfZKfqil69AT2NZwUrdUezFA3MHFDlo=
X-Google-Smtp-Source: AGHT+IF64Klfnj9wuTgopPxzcjnx9CZmadAde8hhEAskWb8v6MHBZanNtQf2+2ut+ZEx70xohRLCvg==
X-Received: by 2002:a9d:5f08:0:b0:6f9:8a29:8e8c with SMTP id 46e09a7af769-6f98a298fddmr3582617a34.23.1717964843113;
        Sun, 09 Jun 2024 13:27:23 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f94dca1d06sm1541555a34.44.2024.06.09.13.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 13:27:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] counter: ti-eqep: enable clock at probe
Date: Sun,  9 Jun 2024 15:27:11 -0500
Message-ID: <20240609-ti-eqep-enable-clock-v1-1-1e9e7626467e@baylibre.com>
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

The TI eQEP clock is both a functional and interface clock. Since it is
required for the device to function, we should be enabling it at probe.

Up to now, we've just been lucky that the clock was enabled by something
else on the system already.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/counter/ti-eqep.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 072b11fd6b32..825ae22c3ebc 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/counter.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
@@ -376,6 +377,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	struct counter_device *counter;
 	struct ti_eqep_cnt *priv;
 	void __iomem *base;
+	struct clk *clk;
 	int err;
 
 	counter = devm_counter_alloc(dev, sizeof(*priv));
@@ -415,6 +417,10 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
+
 	err = counter_add(counter);
 	if (err < 0) {
 		pm_runtime_put_sync(dev);

---
base-commit: bb3f1c5fc434b0b177449f7f73ea9b112b397dd1
change-id: 20240609-ti-eqep-enable-clock-91697095ca81

