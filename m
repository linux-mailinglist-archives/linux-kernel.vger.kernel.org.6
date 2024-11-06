Return-Path: <linux-kernel+bounces-397933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 897889BE2A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4360F282E2E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B6C1DC19D;
	Wed,  6 Nov 2024 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gtDX+Q/h"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7461DB92A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885654; cv=none; b=eS3GNxD7uMD9oT9KB9IeYSEK14ZsGpCQw+EM0ZKSMmf8WXoIegLz3T3q0N73E8Ktd3MEG64vL3+d/Q0fTSJ68WdOFMREE9Oqc0DLg6IiAV+TrpT9smrAE4/hfypCKAi4ncADk2roKbEW6VLWTTtExtWgCuUVOVz0uczp90sxE9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885654; c=relaxed/simple;
	bh=F5ArjWom+MQi62Ghn0rbbhm+sqeF3wwa6gc09F6PrqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHo5BTJPTXYiAIwx1fI96IClMRqtZGQSYssU2e42tI1cDdWMlT19eNO9w/Yv+I/moUDaFvAEZWImKzZVl0ZQy2YcVxNhnWTBODoaH1jE66f/0i2oXHnv1Rsz0S4BCzmRGBerMcaskyna22+Oe2cJo+Y3pdSlNd92pZjnsnWLTyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gtDX+Q/h; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c9978a221so65978245ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 01:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730885652; x=1731490452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbfB757zoogv3EY5nGOvTyWU1LRL3RJGksVkmiyRShA=;
        b=gtDX+Q/hoaHvFTRrGSk7/Ep1hTMTrB7P9ZuONBDwYm4n/nCqMn5dlSdAn8vgdBKypt
         hkzNnnj8XWkAECcl71McltVHCcndnic20ope4+cZap2ETZolM0i5vbG+09/GFk6TjG+A
         IfAv1FS2FZn2uhlgqXzrZqyqO8pB4cbvo/nas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885652; x=1731490452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbfB757zoogv3EY5nGOvTyWU1LRL3RJGksVkmiyRShA=;
        b=e4Smc8uWokPak3cKicArYN8M5Djl4tppFFuROy5ANv3FoudCD3gfrYfy8OE9pxdHp2
         HF8MJIsk/nw4g8m/g2CZlVdXr56MR6XthV3NQepA2Coh0QJIKXpwlgHTzrUuPQGNr8gk
         YgC/LgH2PGqHLeMd4TVRH4gQkVncBKpv+UgyEmtmrzmCgLtDrOKvOlixPt3tOb4/7tEj
         BpghsQxvXQQyeZv1qixx8+JPZyhPpsTYsH4hqZkyr0W6FrdmQmXspgSOwwnMQf//qceW
         oFfIZnGW7DP0x4YT/38mlZYpXE+8ueuB0MdRqXmZXrvLXnZNllmFWUzBvdK3VxrnwCIu
         6gYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOqv0I845WmXhrFtOQhoKpNOh20Lu7/eZhLNfpqcYDe4gopk0l6L+mrP1erQmggFh+6biLC/cASDPGBs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFzBTvtJJPscJn2/aFRQk9WmoHXZLFcoFQccyZ/88Ml0+PSvYd
	gfoFnItc4p1TrEALz+bbysb+f6e1DmrjGdSb2fAJZdSDL03HXDpGr+pu5VJNWw==
X-Google-Smtp-Source: AGHT+IGsqJnP2c29fT7ec18QitUEURWR4HKremiykkNa1vQPN87ztDDGEmp/BT6g/9KjaXSGkYd/CA==
X-Received: by 2002:a17:903:234c:b0:20c:5b80:930f with SMTP id d9443c01a7336-210c68a9c02mr560445915ad.12.1730885652382;
        Wed, 06 Nov 2024 01:34:12 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:93fe:1d68:b50:3213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057062b8sm91478665ad.63.2024.11.06.01.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:34:12 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wolfram Sang <wsa@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	chrome-platform@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v11 2/7] of: base: Add for_each_child_of_node_with_prefix()
Date: Wed,  6 Nov 2024 17:33:29 +0800
Message-ID: <20241106093335.1582205-3-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
In-Reply-To: <20241106093335.1582205-1-wenst@chromium.org>
References: <20241106093335.1582205-1-wenst@chromium.org>
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
index d94efee4a7fc..a01e5534c2fd 100644
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
index d0307e3b093d..f921786cb8ac 100644
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
2.47.0.199.ga7371fff76-goog


