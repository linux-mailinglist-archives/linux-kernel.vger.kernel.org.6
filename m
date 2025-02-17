Return-Path: <linux-kernel+bounces-517860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90D6A386A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3208188B4D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9280722333B;
	Mon, 17 Feb 2025 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="iW53sRBC"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43913223328
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739802978; cv=none; b=DCEDkdpE7nnE5i5L1iWarz9Ua4GRKHJN/fpOGcT6OxECi3JhehB3NEGi6HlFmIC/Ohanbpo0LnvJ0Tjx6kP/dKO/xDaK/tX2SmT5fmr8OHRkAsf1581+eu+6QhgZNGOG6wRKGOvcdX4u7mQ2qjKkkg34ygM9STpdvuJIcfkGF1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739802978; c=relaxed/simple;
	bh=uxdDc8NwSSoU/KhYSVoLNE3SLLqdDtG3WoHdkVTCuPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiJAz+ruTx5OnHTx3qMOmKO6nRMOKM1r5uUC698GAPLinpXhdIQknhO+aF+nFPj/uJsXNdyL4WZo+MulVNgIioq7HzhUaYJKzVj+MLPmQ0+VUEy5Sx6GfxDBL6sfA6JCDoMHxRw8TeOmk08XpK/FVjITGhhQKYdm++wl5Z4D+Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=iW53sRBC; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 15BA23F868
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739802976;
	bh=v4sbOHRoeQS1MOSALsPLtSJ65COLeoaPvTmtbuEu58k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=iW53sRBCxn/x+uWVN/Z7nGx4C3N5Pkan+e7ljLY5/5uJPSQZ7PrnBCAg/JvnIQlJ2
	 R1t1dKLuBr7DItopTUgKUJBwR3ayoopJRjDNHXmR+1xUIUeEH4mAl253+1NIDi966I
	 9y/12PVLCaibVP01q1DGDpeMlsjgwCkZDaPdECfTRmEDsl/cI9CIXNVBJC/icQuSdH
	 OTef9lQUkMTxYkucZHx8HBQBBUiX07f16o2FlHkb41sva4SDoV31WG93KiampZhBME
	 asek/xcBW94sN5awZvNPVcUDsT0Jm2gyDZ3DNRAJflCBAKmsgWhBShSlrUloyjPksZ
	 0gIqQtKpT2baQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fbfa786a1aso14003479a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739802974; x=1740407774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4sbOHRoeQS1MOSALsPLtSJ65COLeoaPvTmtbuEu58k=;
        b=dAaYweoA1AB1ck/hdbzgQhDFOACmEUtSK8Uo7oo2Iij8SrvThAVdSrC2Q6i4rT95XV
         JbBLLUDeyPpF7W6jigoa5scRcRJnABXFXc9NhiiJlHIfg+FrJoqUws26BfPqFlZbaDKS
         P4z+WP3VSe5RTiw9f4diagQRuQbN2ceYu7632bfvDhv/d6WYa+0JDe11f0lVxZrsTt3J
         nQcuSc1tjE6S1vyPp4A7+LHNURWwZn1qHZDaHXADBwqp8jIjxKNQPng6MepdWGeZTmEy
         uvRCOAokslyBqW8UIBPjRJFvKfecKZ/Z3KaORnvv5bNw35jpUreaBkesh8qAcaSCYGML
         mNvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3225KNeycI+TcIneUaqSiHcbN2Jua0B/kXPmVoYGfjzP1xMnBaMYYmGwnRGzYpXB3Leg2tc2W55FR4yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznMpa5I5+v+VaNzzK6mlZAk5pDwIVPyJ6IFO9uge+SAuqA8Gzv
	MWx+07iVnjJAD1gVL6RqFlUgYtnsniC3NFZ6mqbEGcY8kJqdOe3rvnooX8lrSpM2qSnP9xtXELf
	DzN91fT/5zOmqBHNQ4/fOrfW/npzMM/3R14mmN8QmPq437QWTFZlhlDnaNAdwUjEZm4sWpxq9SR
	lxaw==
X-Gm-Gg: ASbGncuD8YrED86P+yPmO+PAMvD0GpBY+ZV+VPLY3pcmqq5iDoH8yvZNi5oEX29ovMB
	/0rxGdsvKPpI1fDXlKBRzld+CER6ae/aFw5LXu2h5Sm9NFKdFMstF4Y/ArLaLQUZ/E8vbBYG5VL
	ofXDAHzCy9R2D5ZuN9RP3CwY1nWapBiSZqyXfqCNhK3b7DBScNwvA/jgPKw26ZMSTqo5tLaGE4c
	oFcTHq9Mmp4wtcHHqQ7XB0y/x9UgRgprEJ4MGgFmTJcSq5DBi7IZVnIcEB8F//VzYyCKYRVmZYd
	0tsBFpzjs94VMGpAdmnCf4Y=
X-Received: by 2002:a17:90b:2fc3:b0:2ea:b564:4b31 with SMTP id 98e67ed59e1d1-2fc40f21c49mr14264468a91.19.1739802973317;
        Mon, 17 Feb 2025 06:36:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/i6ZhPeP35hWJ24mm/LIhcXbBPRykLdefs72sMWFjgXDC7lFQiPxRDAVbpwrRAEzufAxZDw==
X-Received: by 2002:a17:90b:2fc3:b0:2ea:b564:4b31 with SMTP id 98e67ed59e1d1-2fc40f21c49mr14264311a91.19.1739802971508;
        Mon, 17 Feb 2025 06:36:11 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:a6da:1fd8:6ba3:4cf3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b3305sm10057757a91.6.2025.02.17.06.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:36:11 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/9] gpio: aggregator: add 'name' attribute for custom GPIO line names
Date: Mon, 17 Feb 2025 23:35:27 +0900
Message-ID: <20250217143531.541185-6-koichiro.den@canonical.com>
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

Previously, there was no way to assign names to GPIO lines exported
through the aggregator when the device was created via sysfs.

Allow users to set custom line names via a 'name' attribute and
expose them using swnode.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/gpio-aggregator.c | 84 ++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index ec102453817b..692d90246674 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -61,6 +61,8 @@ struct gpio_aggregator_line {
 	/* Line index within the aggregator device */
 	unsigned int idx;
 
+	/* Custom name for the virtual line */
+	const char *name;
 	/* GPIO chip label or line name */
 	const char *key;
 	/* Can be negative to indicate lookup by line name */
@@ -530,10 +532,40 @@ to_gpio_aggregator_line(struct config_item *item)
 	return container_of(group, struct gpio_aggregator_line, group);
 }
 
+static struct fwnode_handle *aggr_make_device_swnode(struct gpio_aggregator *aggr)
+{
+	const char **line_names __free(kfree) = NULL;
+	struct property_entry properties[2];
+	struct gpio_aggregator_line *line;
+	size_t num_lines;
+	int n = 0;
+
+	memset(properties, 0, sizeof(properties));
+
+	num_lines = aggr_count_lines(aggr);
+	if (num_lines == 0)
+		return NULL;
+
+	line_names = kcalloc(num_lines, sizeof(*line_names), GFP_KERNEL);
+	if (!line_names)
+		return ERR_PTR(-ENOMEM);
+
+	/* The list is always sorted as new elements are inserted in order. */
+	list_for_each_entry(line, &aggr->list_head, entry)
+		line_names[n++] = line->name ?: "";
+
+	properties[0] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
+					"gpio-line-names",
+					line_names, num_lines);
+
+	return fwnode_create_software_node(properties, NULL);
+}
+
 static int aggr_activate(struct gpio_aggregator *aggr)
 {
 	struct platform_device_info pdevinfo;
 	struct gpio_aggregator_line *line;
+	struct fwnode_handle *swnode;
 	unsigned int n = 0;
 	int ret = 0;
 
@@ -545,9 +577,14 @@ static int aggr_activate(struct gpio_aggregator *aggr)
 	if (!aggr->lookups)
 		return -ENOMEM;
 
+	swnode = aggr_make_device_swnode(aggr);
+	if (IS_ERR(swnode))
+		goto err_remove_lookups;
+
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 	pdevinfo.name = DRV_NAME;
 	pdevinfo.id = aggr->id;
+	pdevinfo.fwnode = swnode;
 
 	/* The list is always sorted as new elements are inserted in order. */
 	list_for_each_entry(line, &aggr->list_head, entry) {
@@ -559,7 +596,7 @@ static int aggr_activate(struct gpio_aggregator *aggr)
 		 */
 		if (!line->key || line->idx != n) {
 			ret = -EINVAL;
-			goto err_remove_lookups;
+			goto err_remove_swnode;
 		}
 
 		if (line->offset < 0)
@@ -567,13 +604,13 @@ static int aggr_activate(struct gpio_aggregator *aggr)
 		else
 			ret = aggr_add_gpio(aggr, line->key, line->offset, &n);
 		if (ret)
-			goto err_remove_lookups;
+			goto err_remove_swnode;
 	}
 
 	aggr->lookups->dev_id = kasprintf(GFP_KERNEL, "%s.%d", DRV_NAME, aggr->id);
 	if (!aggr->lookups->dev_id) {
 		ret = -ENOMEM;
-		goto err_remove_lookups;
+		goto err_remove_swnode;
 	}
 
 	gpiod_add_lookup_table(aggr->lookups);
@@ -587,6 +624,8 @@ static int aggr_activate(struct gpio_aggregator *aggr)
 err_remove_lookup_table:
 	kfree(aggr->lookups->dev_id);
 	gpiod_remove_lookup_table(aggr->lookups);
+err_remove_swnode:
+	fwnode_remove_software_node(swnode);
 err_remove_lookups:
 	kfree(aggr->lookups);
 
@@ -658,6 +697,43 @@ gpio_aggr_line_key_store(struct config_item *item, const char *page,
 }
 CONFIGFS_ATTR(gpio_aggr_line_, key);
 
+static ssize_t
+gpio_aggr_line_name_show(struct config_item *item, char *page)
+{
+	struct gpio_aggregator_line *line = to_gpio_aggregator_line(item);
+	struct gpio_aggregator *aggr = line->parent;
+
+	guard(mutex)(&aggr->lock);
+
+	return sysfs_emit(page, "%s\n", line->name ?: "");
+}
+
+static ssize_t
+gpio_aggr_line_name_store(struct config_item *item, const char *page,
+			  size_t count)
+{
+	struct gpio_aggregator_line *line = to_gpio_aggregator_line(item);
+	struct gpio_aggregator *aggr = line->parent;
+
+	char *name __free(kfree) = kstrndup(skip_spaces(page), count,
+					    GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	strim(name);
+
+	guard(mutex)(&aggr->lock);
+
+	if (aggr_is_active(aggr))
+		return -EBUSY;
+
+	kfree(line->name);
+	line->name = no_free_ptr(name);
+
+	return count;
+}
+CONFIGFS_ATTR(gpio_aggr_line_, name);
+
 static ssize_t
 gpio_aggr_line_offset_show(struct config_item *item, char *page)
 {
@@ -707,6 +783,7 @@ CONFIGFS_ATTR(gpio_aggr_line_, offset);
 
 static struct configfs_attribute *gpio_aggr_line_attrs[] = {
 	&gpio_aggr_line_attr_key,
+	&gpio_aggr_line_attr_name,
 	&gpio_aggr_line_attr_offset,
 	NULL
 };
@@ -795,6 +872,7 @@ gpio_aggr_line_release(struct config_item *item)
 
 	aggr_line_del(aggr, line);
 	kfree(line->key);
+	kfree(line->name);
 	kfree(line);
 }
 
-- 
2.45.2


