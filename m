Return-Path: <linux-kernel+bounces-324335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A0974B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DD11C24DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCBF142651;
	Wed, 11 Sep 2024 07:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JOvuQXKv"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673D13D635
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039707; cv=none; b=ug8neGK0nfTk4DewALcO8GxG94T85/mmOJ7GpyFNx1MUjhBhbo4wA1yncGJAazOvEOqfPtgWdiP1OPs1+UWgjmNvhal+S1fvM/CtQSDQ5+gU9qAUcsJ524iXKTIAKbg4SFFSfBuPEa5uZvO7Admido8seDE16Re88dE45zNdiOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039707; c=relaxed/simple;
	bh=WIfkiNtSKIwyx7GizcoCeKoQku6qSRlQSE16sb4sWRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhmWjrngPmJOgodlbn5xy3StdSz3vLrNGQQ/sQIWmzRWc8+htvyuZmuJW6IjZEjYC6H+TdFtAebIQY7UeoXARyL1vPyB9XrhraTXnCUZzgMcgYjU0lxx6CnJhcR+/3EFIC3C+CrVXJn5Cuq0RaJB+cLyVxz0EUpsMiFwEWBHgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JOvuQXKv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718d6ad6050so4036228b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726039705; x=1726644505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHYuF087WkDWw6t01rd+JoBLqqCohsT20qRvxciVpzs=;
        b=JOvuQXKvQXdA+EWJKiDscgshBbTYFfQFZrP7j5E/nkmRN0mHQKkqeGnvJ51LE6RgwC
         tfUIGBOKOiAT1zl4G4mZYIbygfss5v2U8YC0YIk0KPTjZBZsrloa9tCApA1Az3m754Ss
         XprxpzgBZTJmzGKwVPg6omsQmi8zRXArGXRXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726039705; x=1726644505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHYuF087WkDWw6t01rd+JoBLqqCohsT20qRvxciVpzs=;
        b=NWGpdnPkahOHtS7eaa+x7SI83oyU6wokVokXlpb1MMuLr4ldbM6N+jVEy7BvWs0OZs
         BfLr9QkaKepYJI9g0pdjhoSmK7gcWIscy+r9BhkpZdPCXQACmE3NOYeyugZSlI7cQ8ei
         PQGzudJznkGbF5U4AHyXONPs7J4cskQ5QqNGacBPITaFAy/fTps+2dVHCZIXVMBNX1qJ
         AoOBoeMqj/JZIgtD51CQMb2kC9nfCzMs6oCvM+tU1wMOZK6neA81fbX6yoiuysDCBF2D
         lvAqPjWgrrYGRLmvf9nf56m/vaNSYmtYYIf0WLHxcvP7dlPhksgn+LnBlRfHyLpbV2kg
         bJFw==
X-Forwarded-Encrypted: i=1; AJvYcCU+80acvzwxT13VrrTwBwgrLfst5QgIlrMTFRzJ5vpQchrYwOb1b1UJcK4I3lRe8Dt7051ornC32oMXlsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsYF7qPhKuj39a+Xk9cRZz8Kn3XRK3ex4Apdwk8+G575bOwYvA
	xTsKYJyfJTcQgEomPIVbM2pKCth/UbnK1gAqRvOcOSbP+ZuXx6D6rI+PXGQ4iw==
X-Google-Smtp-Source: AGHT+IF7NCaFQn5NI21IL8mvEhnYcnrMWrYJBC5MrY8umX2zBuXqZDWtQyZtz6v7uD5SvjxSxtithQ==
X-Received: by 2002:a05:6a20:2d0b:b0:1cf:6dd7:fa50 with SMTP id adf61e73a8af0-1cf6dd7fa7cmr114263637.11.1726039705459;
        Wed, 11 Sep 2024 00:28:25 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8398:fe34:eba2:f301])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fe4e7esm2399415b3a.80.2024.09.11.00.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:28:25 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wolfram Sang <wsa@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	chrome-platform@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org
Subject: [PATCH v7 02/10] of: base: Add for_each_child_of_node_with_prefix()
Date: Wed, 11 Sep 2024 15:27:40 +0800
Message-ID: <20240911072751.365361-3-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911072751.365361-1-wenst@chromium.org>
References: <20240911072751.365361-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are cases where drivers would go through child device nodes and
operate on only the ones whose node name starts with a given prefix.

Provide a helper for these users. This will mainly be used in a
subsequent patch that implements a hardware component prober for I2C
busses.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v6:
- Changed helper name to "for_each_child_of_node_with_prefix()"
Changes since v5:
- New patch
---
 drivers/of/base.c  | 35 +++++++++++++++++++++++++++++++++++
 include/linux/of.h |  9 +++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 20603d3c9931..d3c123b3261a 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -628,6 +628,41 @@ struct device_node *of_get_next_child(const struct device_node *node,
 }
 EXPORT_SYMBOL(of_get_next_child);
 
+/**
+ * of_get_next_child_with_prefix - Find the next child node with prefix
+ * @node:	parent node
+ * @prev:	previous child of the parent node, or NULL to get first
+ *
+ * This function is like of_get_next_child(), except that it automatically
+ * skips any nodes whose name doesn't have the given prefix.
+ *
+ * Return: A node pointer with refcount incremented, use
+ * of_node_put() on it when done.
+ */
+struct device_node *of_get_next_child_with_prefix(const struct device_node *node,
+						  struct device_node *prev,
+						  const char *prefix)
+{
+	struct device_node *next;
+	unsigned long flags;
+
+	if (!node)
+		return NULL;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+	next = prev ? prev->sibling : node->child;
+	for (; next; next = next->sibling) {
+		if (!of_node_name_prefix(next, prefix))
+			continue;
+		if (of_node_get(next))
+			break;
+	}
+	of_node_put(prev);
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+	return next;
+}
+EXPORT_SYMBOL(of_get_next_child_with_prefix);
+
 static struct device_node *of_get_next_status_child(const struct device_node *node,
 						    struct device_node *prev,
 						    bool (*checker)(const struct device_node *))
diff --git a/include/linux/of.h b/include/linux/of.h
index 046283be1cd3..48cfb39197d6 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -289,6 +289,9 @@ extern struct device_node *of_get_parent(const struct device_node *node);
 extern struct device_node *of_get_next_parent(struct device_node *node);
 extern struct device_node *of_get_next_child(const struct device_node *node,
 					     struct device_node *prev);
+extern struct device_node *of_get_next_child_with_prefix(const struct device_node *node,
+							 struct device_node *prev,
+							 const char *prefix);
 extern struct device_node *of_get_next_available_child(
 	const struct device_node *node, struct device_node *prev);
 extern struct device_node *of_get_next_reserved_child(
@@ -1468,6 +1471,12 @@ static inline int of_property_read_s32(const struct device_node *np,
 	     child != NULL;						\
 	     child = of_get_next_child(parent, child))
 
+#define for_each_child_of_node_with_prefix(parent, child, prefix)	\
+	for (struct device_node *child __free(device_node) =		\
+	     of_get_next_child_with_prefix(parent, NULL, prefix);	\
+	     child != NULL;						\
+	     child = of_get_next_child_with_prefix(parent, child, prefix))
+
 #define for_each_available_child_of_node(parent, child) \
 	for (child = of_get_next_available_child(parent, NULL); child != NULL; \
 	     child = of_get_next_available_child(parent, child))
-- 
2.46.0.598.g6f2099f65c-goog


