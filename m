Return-Path: <linux-kernel+bounces-388256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C6E9B5CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74DD1F23470
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 07:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4E01DED7D;
	Wed, 30 Oct 2024 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iac8F2wW"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D65385931
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730272963; cv=none; b=fKjM4Vru6Yzs7r9zpVNUVQql7qkf8Z4O6PY5jkoVckggqe+BTBD40VmElVrbWdtgCrPCjNjrXco9FeS6+73qDoAfpEnAsw2G8NpBvbZcXRIdvM3n+fBgB+CQ2SvoIhDAK2vmKEJB9ceprgWT5yE1WURO/gVHLrAiKsLF7EHM0JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730272963; c=relaxed/simple;
	bh=8DRpEc7VtFUlMLWjtZcrcpHOSKqXDgge+8MU2MYPNJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1IWHbaThuKpY/3iil2JlRUCMmUJHkzZ25FvnhTLc7gMIpBfldkFX/0Y8xbHBjtt31uDw1VI5loEz3VNXmdLGroAvyK86BnYkbo8y29226iica3UoPTGXIiH5jOmLY2J+KeH7Nt+r58piy6BFLTuQjDbeITtmF8zNXToe7njljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Iac8F2wW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ce65c8e13so57225595ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 00:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730272959; x=1730877759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fM5s6QQy70TfZfd9/oqmPb/4xjVNQ5k0swJ7RQS7j0U=;
        b=Iac8F2wWMo7HdscnSpLbSOoDWhTCfLWEhRyUE+v3PQmeCiQrfOBFQUJh1fOE3bsIex
         yyiIXB0oN1USQCFpNt/HWMZ/7RJwsRix+XkCbsuQsCE53yDQyvJIe7uCUn5AibLl16pi
         g7Xvvca+wbhDJk8BIkbDkz1kDqZXMmgYBVHPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730272959; x=1730877759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fM5s6QQy70TfZfd9/oqmPb/4xjVNQ5k0swJ7RQS7j0U=;
        b=pQzAppJTun1SzrRj3cpXVdRVwSmPnDWAUvb/Ru1kV7Y8OIVDRbRntdf65LnSSKqaBQ
         OGwJNNhmRUPc738CmmPspAAb9i0i6YLMbG6i6Vd/zfuylwlnnpzTBEk/r4MjdQek1/P2
         ELsVt+SYWRnKuVYpcaiuYr1VW5jQYeFqtZbkjyFdFJ9RioFT5gtc8ygHEP8ocutDN2CB
         e30V/KaMkkpXl3aNnwpeXCi3XE1DuhfzfQRO5AhHXdJYsSY6ekZpX6BYx231WsNYE/3g
         sykCvqkr6vCBr/lQULtC9Ohiauh0xSTwaVWI0w6LSZ5bqy6iqi0WZzff/vaqm7OyWgTY
         FCmg==
X-Forwarded-Encrypted: i=1; AJvYcCUGJZo4yjUQ791fPx9DgIEdNpHCN7a3dnjpQ6Kb8SNY1ct1allodQN/4cXY22FcA6B0xjklkmMIzAOz7YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFvov3/cpDVRace2B/HqUeEr/MsmYW5l/Y5JQdJFey8clrgXyg
	SI4QxpqYeg/MN7rTAQ1UErwRN0Vn7pHyjEI4HolAteIozJJ5uUWTQzEvNwzIZw==
X-Google-Smtp-Source: AGHT+IEL/su+vsISUs9abpUuCumE5CbCLhz9veBdyK5LYmCDfHySC/SvqqxJuuhli8/bG+nFSB8S6A==
X-Received: by 2002:a17:902:e801:b0:20c:dd71:c94f with SMTP id d9443c01a7336-210c6cd3c45mr180749055ad.41.1730272959361;
        Wed, 30 Oct 2024 00:22:39 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d1f3:aa64:657f:d8a8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02e67esm76641445ad.186.2024.10.30.00.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 00:22:38 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wolfram Sang <wsa@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
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
	linux-i2c@vger.kernel.org
Subject: [PATCH v10 1/7] of: dynamic: Add of_changeset_update_prop_string
Date: Wed, 30 Oct 2024 15:22:22 +0800
Message-ID: <20241030072229.1013235-2-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
In-Reply-To: <20241030072229.1013235-1-wenst@chromium.org>
References: <20241030072229.1013235-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper function to add string property updates to an OF changeset.
This is similar to of_changeset_add_prop_string(), but instead of adding
the property (and failing if it exists), it will update the property.

This shall be used later in the DT hardware prober.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes since v7:
none

Changes since v6:
none

Changes since v5:
- Collected Rob's tag

Changes since v4:
- Use modern designated initializer for |prop|

Changes since v3:
- Use new __of_prop_free() helper
- Add new line before header declaration

Changes since v2:
- New patch added in v3
---
 drivers/of/dynamic.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h   |  4 ++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index d45a8df61380..0aba760f7577 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -1072,3 +1072,47 @@ int of_changeset_add_prop_bool(struct of_changeset *ocs, struct device_node *np,
 	return of_changeset_add_prop_helper(ocs, np, &prop);
 }
 EXPORT_SYMBOL_GPL(of_changeset_add_prop_bool);
+
+static int of_changeset_update_prop_helper(struct of_changeset *ocs,
+					   struct device_node *np,
+					   const struct property *pp)
+{
+	struct property *new_pp;
+	int ret;
+
+	new_pp = __of_prop_dup(pp, GFP_KERNEL);
+	if (!new_pp)
+		return -ENOMEM;
+
+	ret = of_changeset_update_property(ocs, np, new_pp);
+	if (ret)
+		__of_prop_free(new_pp);
+
+	return ret;
+}
+
+/**
+ * of_changeset_update_prop_string - Add a string property update to a changeset
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @prop_name:	name of the property to be updated
+ * @str:	pointer to null terminated string
+ *
+ * Create a string property to be updated and add it to a changeset.
+ *
+ * Return: 0 on success, a negative error value in case of an error.
+ */
+int of_changeset_update_prop_string(struct of_changeset *ocs,
+				    struct device_node *np,
+				    const char *prop_name, const char *str)
+{
+	struct property prop = {
+		.name = (char *)prop_name,
+		.length = strlen(str) + 1,
+		.value = (void *)str,
+	};
+
+	return of_changeset_update_prop_helper(ocs, np, &prop);
+}
+EXPORT_SYMBOL_GPL(of_changeset_update_prop_string);
diff --git a/include/linux/of.h b/include/linux/of.h
index 086a60f3b8a6..d0307e3b093d 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1651,6 +1651,10 @@ static inline int of_changeset_add_prop_u32(struct of_changeset *ocs,
 	return of_changeset_add_prop_u32_array(ocs, np, prop_name, &val, 1);
 }
 
+int of_changeset_update_prop_string(struct of_changeset *ocs,
+				    struct device_node *np,
+				    const char *prop_name, const char *str);
+
 int of_changeset_add_prop_bool(struct of_changeset *ocs, struct device_node *np,
 			       const char *prop_name);
 
-- 
2.47.0.163.g1226f6d8fa-goog


