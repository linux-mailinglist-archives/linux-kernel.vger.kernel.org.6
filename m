Return-Path: <linux-kernel+bounces-354680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9439940E3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4E31F276AC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664B423A6;
	Tue,  8 Oct 2024 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mEKXjCNP"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0451B6536
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372904; cv=none; b=ZmSvq+00kqzqwORPnfbv1isLyecwRCl1mvj8mWsAbswNfFfbgKfPDi8eFY22+6zqaHtJ32y/jCl/7hvkt6cLgRMCX3FzBJDwY3P9iIHX3heT/wfNFjHD/GBtbKzrMsHJ6J4DwCXcnDUBQjkX+8seojgbRr10B1HDsEeKztL2mw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372904; c=relaxed/simple;
	bh=dYl5KmG76YxlLR6pt0RMoPciG6AuuXW2FmrBPliVeEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiWDnixEKRyYpDuRyLb15c/M9sWfsKI+Oy5/thdEPHbrQRUztpZh2NlkPKQAmTYojijc0YOauQzP7EmXaImcJ1JK0kmc0KTHqpJy1tO1VqofvbmIihDxmrfCrQGzsjyTbDX8mBsDDGMdJ4rpbdyMquWXJNjTvm4IB1ukdBknADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mEKXjCNP; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ba9f3824fso39562295ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728372902; x=1728977702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAxUQ/gxQDnRaq33Q6rLVbh6EKahS1Y15WlLZB1S0cs=;
        b=mEKXjCNPdjCaClEdyREaVqon33tMppU+aaiNJsiATLumtWMq0B2qngLl5NneKJhq9F
         L5lKgH4BN3Tt8ln9RbxGFQnBTft07TinSjAWZtmNvHEKcmE/XbglSoMGJukCwNo+g3HI
         myGl7vmVwt8lcUo5u+AIXLc/cFg8/EGyvgFO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372902; x=1728977702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAxUQ/gxQDnRaq33Q6rLVbh6EKahS1Y15WlLZB1S0cs=;
        b=ieCAGqbkXRbMKO6ZeeC6YCH1WPVP4Vo115SGjO3sV9Al40AboN3cXGscodK9RyoVRQ
         94gAs+uHgYA0AY+7qQiWvuwBcTk+jwPWey7v2p+5ENTMP1+B19eZoBxtRf2ciZTL6Hqn
         t/Ln9UExN0LLEmOBPB/2s0W6KD0pXuUXP069mElqGRPA53Pxtb5xyAZDNy+FGwKBvqd4
         X+7qbQIbst8NlBh4ugZedMwKiW/2qmsAVqdzII2Niwb2qCkNGOih8tMBIR8U+q3J7yoL
         4hKWfkoglXD7a69q0tUzQWfVbZYdEny61lMJOTtG0gf8W+kSRIr7FWdniXMSB2TSD/7q
         HOKg==
X-Forwarded-Encrypted: i=1; AJvYcCVPC3tjyGfUasNyGzXxMdBGU/22shxFZNBkVlzS66sLB4bq9vpETrLA/mbu4dOYVZTt8qDTxZfi4iwQaXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNFuc0jNsXNcTBSsOTOv586OLeW/Pyp1S+HcShR7MWx7Zn03nE
	bjmZ+59PgYNEVfLvCZxuul1NURxYOBRBdx540hmEKHwM3ZhFZedFjSh5rH65bA==
X-Google-Smtp-Source: AGHT+IEkI2JuDhmy2Ntn94t3UfJbenoF4cvKN24CAZImwC2iBKZvWlacaurS6rWVfrNKcS9cT8F0Rg==
X-Received: by 2002:a17:902:db02:b0:206:d8c2:4a94 with SMTP id d9443c01a7336-20bfdfeeccbmr217436695ad.25.1728372902576;
        Tue, 08 Oct 2024 00:35:02 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:10df:d27e:8d4b:6740])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13939bd7sm50121175ad.120.2024.10.08.00.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:35:02 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wolfram Sang <wsa@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
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
Subject: [PATCH v8 2/8] of: base: Add for_each_child_of_node_with_prefix()
Date: Tue,  8 Oct 2024 15:34:21 +0800
Message-ID: <20241008073430.3992087-3-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241008073430.3992087-1-wenst@chromium.org>
References: <20241008073430.3992087-1-wenst@chromium.org>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes since v7:
- Collected Rob's Reviewed-by
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
2.47.0.rc0.187.ge670bccf7e-goog


