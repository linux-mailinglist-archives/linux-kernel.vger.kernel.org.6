Return-Path: <linux-kernel+bounces-517864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2E1A386C7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8127B161138
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEB822576F;
	Mon, 17 Feb 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DHji9EP7"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C6822371E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802989; cv=none; b=gk+t1l81lYZoEtfxr9/13RbRzjtj9b3msDxgqrRuwquV7BusvfDHvErNEPfK47jaWnrSo3W4Ce/uqt43Ws99rh6BhIAIAjO+NHQVEpPaaBN+43PGk0K4KE/abljvwOOafVHdhFN0aOwMDkscOofm2YPSYxdtrvgUSITmsRFi+7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802989; c=relaxed/simple;
	bh=uvDPPe/zh18N6hlSUI3RGzfNlPtrpvVYWv/tx+FGhgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTXI0IleKGi4JJbPY+N0aA/1nHcJe5iyG0AW8Mr1qvRLyScz5Nd2y6t1PHOyR/anoFQX6hwsg2KAEqkAgRhjEtfj1hRwryl7taJ5EyiiCdZ3aoQqz51NZnpiQrrSHXA/K/gddr4r4/wmyv5AHMMlJQBqxJvZxQhWmEU+6a2rCwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DHji9EP7; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F0D813FA53
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739802984;
	bh=dSs/jDBsvmuiaXfkwHoPbsWqaGsAOzbJ2wNat8FrzKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=DHji9EP7tXZ1ZlupkAq2X12FuUZpogOM9X3KkW1D+TwhMnKFFiFrN/eoHDcypitOw
	 VaxIECDTF+2U9xHpOewWa13WBv0/awCF0mVtPn4bAyA7PHWoQNtriOvNF4V7RNA1t2
	 8CFJQaVId28GrdnTY9IRKCSQ9dYPDGiqScu3GQ13K9QTf/0UBB/ypVF3dxE0DaIGGF
	 zdxs1Cla8MDV8zdm/MWbfciyK66AgrpmoJUcB3jWC2TcaaojtT5sY1J/mzVAuGWuyo
	 n/zb2YpXuLkiXpPcAruvuPWrRYnULqxtM9s1jofoP9UPVfVfeQPgIEnQbAiYQ6iq1D
	 f/qzjWinxnlJQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc318bd470so6107406a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739802981; x=1740407781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSs/jDBsvmuiaXfkwHoPbsWqaGsAOzbJ2wNat8FrzKA=;
        b=kRKd9MNEs2yWgLldOpZwXYbbGTHywr4OhV7PEg4N//h8XfSPokRqCjkLHKGxl6PNqL
         7AO7OJPhD90Y/0aFOkTisQxUCIpa20jIoCsv56wgF80terwRz7OSV3IpDhHnW1ZJRLhG
         Z00IrQn8RyRTJvLOt0wk0YqqoMRUWbdLynOlIkwFu+zxtuB4K41NSDZHiJoWHsCp08II
         I1vmROpO/t9KjatxvIaCPWp8zr4UN/Eqiogo0DFqjBmpBVnEM4BoCf3skF4W4L5t0lZ8
         m7f7EKF8BfQN2toST8ZFgdNjwmRwHwajAeup8u+7stke4eesoNQTWl0VhKT44SuQ1E7X
         13yA==
X-Forwarded-Encrypted: i=1; AJvYcCUANDAzIHivXzm9x2ZZI4xgyA/xt+OyL6GyIWyE5WLqe+ln206g7FmO1NLHFSt9ZdIwQtuShx7/y8HWkfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrHO35iYn4wHJ5EdrbuUdOzDSKkYOX6psb3nYFQ2m+qIihXvk3
	NPKogVBwwofC5bpKFJR8uCdheGddSPfonVYnFnBTFy5M/8vFoh6JgCc7gg/PsQlcHfi4NLCC8B1
	esQmlRW4MO66JkC4w7nkomfX5qNMTcUWHKMWHTr+j+FWxej5MDGZOoCyLilyUZA63z3DIRhtMEH
	oG5w==
X-Gm-Gg: ASbGncsGgE4bJEm+scSroJYrfMI8URAO9Uh1Wiavtvzhk22z5u6epigHa1YPDNLTRAJ
	dAJxLBPUxLt++KAa7k0Zw5/AFj+fqf9jCHVYVgN/e1Q6uSYlP0pmU8r6wyAeeYIy6y7qcEjgkeU
	j+HQVJ1O2eaFwaXa0m4DfKEuxjsFzi4f5aASsTxZYIKz3AoRNRCBxjOdmZ/ZzXpBjoThBk9S6Lh
	+PgBMT4iux1PLJ1W5liC9U1nwar6AgliRMHKkdCqu7cAOuD9oKUCfqqrgtiYzO58cJdcZscZ7GR
	hgl0q07neGRzw091dp7kDPg=
X-Received: by 2002:a17:90b:4d87:b0:2fa:1e3e:9be7 with SMTP id 98e67ed59e1d1-2fc40d131d9mr14472029a91.5.1739802980711;
        Mon, 17 Feb 2025 06:36:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFw+izIBre53WvTTJHTp6m7C6QdXU/8idflMKHMYSzPd2m/IGL+jZNFSFLKI+SWsJNHweAuOQ==
X-Received: by 2002:a17:90b:4d87:b0:2fa:1e3e:9be7 with SMTP id 98e67ed59e1d1-2fc40d131d9mr14471996a91.5.1739802980395;
        Mon, 17 Feb 2025 06:36:20 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:a6da:1fd8:6ba3:4cf3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b3305sm10057757a91.6.2025.02.17.06.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:36:20 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/9] gpio: aggregator: cancel deferred probe for devices created via configfs
Date: Mon, 17 Feb 2025 23:35:30 +0900
Message-ID: <20250217143531.541185-9-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250217143531.541185-1-koichiro.den@canonical.com>
References: <20250217143531.541185-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For aggregators initialized via configfs, write 1 to 'live' waits for
probe completion and returns an error if the probe fails, unlike the
legacy sysfs interface, which is asynchronous.

Since users control the liveness of the aggregator device and might be
editing configurations while 'live' is 0, deferred probing is both
unnatural and unsafe.

Cancel deferred probe for purely configfs-based aggregators when probe
fails.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/gpio-aggregator.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 8f8793f27211..f6beb9f41b9a 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -72,6 +72,10 @@ struct gpio_aggregator_line {
 	enum gpio_lookup_flags flags;
 };
 
+struct gpio_aggregator_pdev_meta {
+	bool init_via_sysfs;
+};
+
 static DEFINE_MUTEX(gpio_aggregator_lock);	/* protects idr */
 static DEFINE_IDR(gpio_aggregator_idr);
 
@@ -1112,6 +1116,7 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 				size_t count)
 {
+	struct gpio_aggregator_pdev_meta meta = { .init_via_sysfs = true };
 	char name[CONFIGFS_ITEM_NAME_LEN];
 	struct gpio_aggregator *aggr;
 	struct platform_device *pdev;
@@ -1161,7 +1166,7 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 
 	gpiod_add_lookup_table(aggr->lookups);
 
-	pdev = platform_device_register_simple(DRV_NAME, aggr->id, NULL, 0);
+	pdev = platform_device_register_data(NULL, DRV_NAME, aggr->id, &meta, sizeof(meta));
 	if (IS_ERR(pdev)) {
 		res = PTR_ERR(pdev);
 		goto remove_table;
@@ -1242,14 +1247,15 @@ static struct attribute *gpio_aggregator_attrs[] = {
 };
 ATTRIBUTE_GROUPS(gpio_aggregator);
 
-
 /*
  *  GPIO Aggregator platform device
  */
 
 static int gpio_aggregator_probe(struct platform_device *pdev)
 {
+	struct gpio_aggregator_pdev_meta *meta;
 	struct device *dev = &pdev->dev;
+	bool init_via_sysfs = false;
 	struct gpio_desc **descs;
 	struct gpiochip_fwd *fwd;
 	unsigned long features;
@@ -1263,10 +1269,28 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
 	if (!descs)
 		return -ENOMEM;
 
+	meta = dev_get_platdata(&pdev->dev);
+	if (meta && meta->init_via_sysfs)
+		init_via_sysfs = true;
+
 	for (i = 0; i < n; i++) {
 		descs[i] = devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
-		if (IS_ERR(descs[i]))
+		if (IS_ERR(descs[i])) {
+			/*
+			 * Deferred probing is not suitable when the aggregator
+			 * is created via configfs. They should just retry later
+			 * whenever they like. For device creation via sysfs,
+			 * error is propagated without overriding for backward
+			 * compatibility. .prevent_deferred_probe is kept unset
+			 * for other cases.
+			 */
+			if (!init_via_sysfs && !dev_of_node(dev) &&
+			    descs[i] == ERR_PTR(-EPROBE_DEFER)) {
+				pr_warn("Deferred probe canceled for creation via configfs.\n");
+				return -ENODEV;
+			}
 			return PTR_ERR(descs[i]);
+		}
 	}
 
 	features = (uintptr_t)device_get_match_data(dev);
-- 
2.45.2


