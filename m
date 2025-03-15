Return-Path: <linux-kernel+bounces-562661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B4EA63023
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE22176B5A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 16:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1DE204698;
	Sat, 15 Mar 2025 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rix3luJf"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2051DD87D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742056905; cv=none; b=WI4u3Mc1+/XfAnzhACF2zIoj2YH5rhasYqkMqRQKUpfXNasBvgqcYuaja2Ebxbx6fay/Tb70wCKDtMhTsrJf5idvkzPW1nnA0BOlziQoI1irnW0fQu7Qv4JYZX3bqUIF68DyhaxIPmVTBpqD/0I19hmiCwkGS3Ai72UY7B1NH6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742056905; c=relaxed/simple;
	bh=Y/trqAHztonL9N2oBMTBUS2AITNCJpyiU7FuUoJKaI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCkdzbZn1mqgu/eZANEEtJIiRq9L/jPCp+ep3V8/cgYuQq/TYo2AhbgE2Z3Ne6gpkVlncTtxgKhbKHkHAneiidTQH4H7j8TBNTK79hdO+LzwiIvW4fZcPeudtpTo1pZHa4nUlInmonXQLtoVxB9m6frK/WfM1ARs5DKnYSTf8rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rix3luJf; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3D0B13F5AE
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742056901;
	bh=YqI63cnlFxHvHbiIKycy1SSwr0GW+0W28cLAktX9jRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=rix3luJfUpHKi4gJeMAcW5+jeAaryLG1GVMfoq17CT8aHnQipCZ7wK3sN6Ctjkics
	 w/i1FBW60vLp/o4hqmvwEH3g+hxwkp+IB1nDDPlsS93z80j78SIAH3LXBAFjTMI3+r
	 UJvpfkc4eXTqXU1UfA/RtEaAnIeBHk3roN4qn07RY5lj9K6AphLALf6P5go4ozDZ7o
	 dWYpJjmqzS3GsI5VS1dba2Snk6fYJV4CFX0vNtUCVxOXFjwYWeub5VCwoW95wZU/Nz
	 l5JuveNM6wP0Xu1EDpj7bYnKzvXzNx7Wyea6+QUJ0Ju5SU32oNPdXPk28eHs82YMHc
	 04N88tkWD9Mbw==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225107fbdc7so49444565ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742056900; x=1742661700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqI63cnlFxHvHbiIKycy1SSwr0GW+0W28cLAktX9jRk=;
        b=SZ7idu5c9QkpfK71QMz+TGG7ufa3Lu52rpqm1JgOqW9y9VJJMNgosNfIH2GPElSjDH
         BNtFiFNNLnwutt55HeLO2v8hzLnveSth996LLVyRSQHRfeFB29uce0ET0qwW5GwoCmZl
         z/2LfIB2349AeVMRL8RLD6HP5RbPTzZaIjVDQey+/bpoR61aYUguT48xtP3vlOP0MQhq
         z1jT6Mm8ylBmCjA6nHZQ/4UI1geNdQ/PAEHsGk/tl3c0OaelD7TiC0wbxNPzZ94Ajdn5
         et0SFPrxmuFXkU8WjwvUBQpyvd4aBgSp1bW3C7Kz+zmS1nlx8wHjlC72AdfFq09LRSNZ
         DgTw==
X-Forwarded-Encrypted: i=1; AJvYcCXEK8SBdaGcTSb44aKXOv5l4lVbkTaHKc5/V1y0vY/nQsj03yUdftQ3zSZAsTqh7sEsU/OXifajTjLXICk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8xXBjMo9iNIQUnhuxmp63qEkKSoih0e7GWCrT1XOapfyNhcz
	wqVGrNHfLhWR0/S/4ffDCnMa/1mZYX0SJ66toVYYUtGRD3K9dZWtABQgeUpDUmpHA0U7tQ68J0e
	dCeFkl1QA0pT6MThNluWiRJ2L1n6zbcTvYFuo8zeQxhQdZvVUGDRpwY6/7xN76KeDOVoCmH7wBW
	dhTQ==
X-Gm-Gg: ASbGncu+oQyPJYdtmUMW1nJvoUMFXn6e0QOv5ppJNk9VpYJalpIk8QnrDbogj3tmiDC
	zFQNFVV7gQE7KiWlwAn1y3WLpUyBThYokgIoNeSW7HDblSeVS0CN+fHdAep0wwM0VxIuIWCvTj7
	5fHqHiP1tIw3sObqmUiF3jzd6DWQZ6MLJ4KGIKbKiLfWrba71R/Jsw9HDb0EVrGX0jMnyL//e5o
	lLrWxzytAvs3laR2WlLPTdqyREEcC3+cpmaYbKDSAblurhIRqTAF8UO/rBtDchUzKphIfirua7C
	R8wm24e74wnHGMrC
X-Received: by 2002:a05:6a20:9c8d:b0:1f3:2a83:7548 with SMTP id adf61e73a8af0-1f5c13c9108mr8797266637.38.1742056899838;
        Sat, 15 Mar 2025 09:41:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlQ0ZxJkbof5Sl7HVvOIKdRU7nWkglT9nuW0CmRzdrLz1arh/azPRtzobbcQ27o5qULxvlTw==
X-Received: by 2002:a05:6a20:9c8d:b0:1f3:2a83:7548 with SMTP id adf61e73a8af0-1f5c13c9108mr8797247637.38.1742056899553;
        Sat, 15 Mar 2025 09:41:39 -0700 (PDT)
Received: from z790sl.. ([240f:74:7be:1:83e6:3590:3498:db44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371155e3a9sm4637104b3a.71.2025.03.15.09.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 09:41:39 -0700 (PDT)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/9] gpio: aggregator: add aggr_alloc()/aggr_free()
Date: Sun, 16 Mar 2025 01:41:17 +0900
Message-ID: <20250315164123.1855142-4-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250315164123.1855142-1-koichiro.den@canonical.com>
References: <20250315164123.1855142-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the upcoming configfs interface. These functions will be
used by both the existing sysfs interface and the new configfs
interface, reducing code duplication.

No functional change.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/gpio-aggregator.c | 58 +++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index e026deb4ac64..2692a31e01ac 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -36,12 +36,41 @@
 struct gpio_aggregator {
 	struct gpiod_lookup_table *lookups;
 	struct platform_device *pdev;
+	int id;
 	char args[];
 };
 
 static DEFINE_MUTEX(gpio_aggregator_lock);	/* protects idr */
 static DEFINE_IDR(gpio_aggregator_idr);
 
+static int aggr_alloc(struct gpio_aggregator **aggr, size_t arg_size)
+{
+	struct gpio_aggregator *new __free(kfree) = NULL;
+	int ret;
+
+	new = kzalloc(sizeof(*new) + arg_size, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	mutex_lock(&gpio_aggregator_lock);
+	ret = idr_alloc(&gpio_aggregator_idr, new, 0, 0, GFP_KERNEL);
+	mutex_unlock(&gpio_aggregator_lock);
+	if (ret < 0)
+		return ret;
+
+	new->id = ret;
+	*aggr = no_free_ptr(new);
+	return 0;
+}
+
+static void aggr_free(struct gpio_aggregator *aggr)
+{
+	mutex_lock(&gpio_aggregator_lock);
+	idr_remove(&gpio_aggregator_idr, aggr->id);
+	mutex_unlock(&gpio_aggregator_lock);
+	kfree(aggr);
+}
+
 static int aggr_add_gpio(struct gpio_aggregator *aggr, const char *key,
 			 int hwnum, unsigned int *n)
 {
@@ -454,17 +483,15 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 {
 	struct gpio_aggregator *aggr;
 	struct platform_device *pdev;
-	int res, id;
+	int res;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENOENT;
 
 	/* kernfs guarantees string termination, so count + 1 is safe */
-	aggr = kzalloc(sizeof(*aggr) + count + 1, GFP_KERNEL);
-	if (!aggr) {
-		res = -ENOMEM;
+	res = aggr_alloc(&aggr, count + 1);
+	if (res)
 		goto put_module;
-	}
 
 	memcpy(aggr->args, buf, count + 1);
 
@@ -475,19 +502,10 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 		goto free_ga;
 	}
 
-	mutex_lock(&gpio_aggregator_lock);
-	id = idr_alloc(&gpio_aggregator_idr, aggr, 0, 0, GFP_KERNEL);
-	mutex_unlock(&gpio_aggregator_lock);
-
-	if (id < 0) {
-		res = id;
-		goto free_table;
-	}
-
-	aggr->lookups->dev_id = kasprintf(GFP_KERNEL, "%s.%d", DRV_NAME, id);
+	aggr->lookups->dev_id = kasprintf(GFP_KERNEL, "%s.%d", DRV_NAME, aggr->id);
 	if (!aggr->lookups->dev_id) {
 		res = -ENOMEM;
-		goto remove_idr;
+		goto free_table;
 	}
 
 	res = aggr_parse(aggr);
@@ -496,7 +514,7 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 
 	gpiod_add_lookup_table(aggr->lookups);
 
-	pdev = platform_device_register_simple(DRV_NAME, id, NULL, 0);
+	pdev = platform_device_register_simple(DRV_NAME, aggr->id, NULL, 0);
 	if (IS_ERR(pdev)) {
 		res = PTR_ERR(pdev);
 		goto remove_table;
@@ -510,14 +528,10 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	gpiod_remove_lookup_table(aggr->lookups);
 free_dev_id:
 	kfree(aggr->lookups->dev_id);
-remove_idr:
-	mutex_lock(&gpio_aggregator_lock);
-	idr_remove(&gpio_aggregator_idr, id);
-	mutex_unlock(&gpio_aggregator_lock);
 free_table:
 	kfree(aggr->lookups);
 free_ga:
-	kfree(aggr);
+	aggr_free(aggr);
 put_module:
 	module_put(THIS_MODULE);
 	return res;
-- 
2.45.2


