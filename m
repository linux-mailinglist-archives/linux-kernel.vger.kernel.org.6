Return-Path: <linux-kernel+bounces-397932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FD49BE29D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD971F253A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81BA1DB520;
	Wed,  6 Nov 2024 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ggpLwaxS"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB97A1DA60B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885652; cv=none; b=ozUBpEp3fEbPhvsLXjIGeTF0Cx/7uVe2dEN3S+Dvsn3IZdA3kZV3mcB1ZlkifvLLo3nXavSlwu3G0+S0tnOpWkIxNG7ra4rslTWQzL/f1zBiMLAutUjWghgjUYlqQ1v19N4lRqtGIHOoeav0V51xRDBiD6d4d9AZi/mBRmoBaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885652; c=relaxed/simple;
	bh=Zz2M0sneWoPuGkYkdOhI3CuKEUZZTQY3lZ2/MbU5e84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raRETTbf2+9h2jIAiCoUhk+tMIYLlj4a+5ugFEiLNMLMvAC4PV7teUBS9lbSJB8fPjcXDDG439WyMc8pTj3YfSKOAE8U/z8ss3wS/hw3/B03/BkTzP2wc6Y7RVFa/5FORdgZf14ltNKCtcpr/c1qzJwxLPYSjM61LImjCb7AfbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ggpLwaxS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20bb39d97d1so62180725ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 01:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730885649; x=1731490449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llYngkqgiFGTwpRX3D7wCxxqCsKOgB9wOxApc/ic0J8=;
        b=ggpLwaxSNqJ6WyfhBTQtUArmNcyxPQaoUBaQScnnuUI+4VF2zsEqIrg1EkE3IMRQ3+
         cnyo4ZYbRCgGhvGtbSkKDotw4mQaZ9DZtSLKH19KibZN5V8hI1yVnHATX16yW1NoicHF
         gxlejT5I9bjdZ7CnaFP3QI85WI4OpkbDJXU04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885649; x=1731490449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llYngkqgiFGTwpRX3D7wCxxqCsKOgB9wOxApc/ic0J8=;
        b=WUQiz2/8347CYYi2um7MROSJgSN6AmqRQne9qBigP9nMdlF7JAn9E7wEEdBp7kVJSs
         PFFAc5uMylE1/WbSTzNZtzVIj0q9MMMaN3G80oMziBlZWKWEaaCofWHlM/J291ivUQ5G
         OLx6wnwosAKp3afFveehkNhHtpbwn4W2Tnxb2V8jzweYNRmbw8colYv3Uc9jnxMLKizj
         VeHS8K8oZ1/+AdGepBVZIOSLgOOcQgrBphKevq00VTNwUrC12UPU/Tiax48DiVPtLtjM
         ev3rAsrbYR8Hrst/qndSo+HDCI+/Ni+oOAOcoBGefdzHQR/llBdxHXztGH3d3wN97oX1
         bHGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFU8Xs+0dtJZq6siFctukZXpuz9X0X4ENnUuWceH7dc7MoO66W95xUtXu9PxAE5RR3cciEtRheCd7EmSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1R56EQzolEASwOLsyV6UO2X0rnR6kXnv78N1t+E5XpKxgm2zH
	lBBZMUrWNDSLM3UIE2DE9CTaz5b7NcWExCy1yIBkJ4N8w/oQXMlo+FWRwmqGQA==
X-Google-Smtp-Source: AGHT+IHKOHXdDAUgO9QjYpvJtulYfjKvmKS2PsJrrTevb2UOA/ICT/NZEufa/1uemsVqPCJNroTu4g==
X-Received: by 2002:a17:903:230d:b0:20b:7731:e3df with SMTP id d9443c01a7336-210f76d6780mr400638435ad.43.1730885649028;
        Wed, 06 Nov 2024 01:34:09 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:93fe:1d68:b50:3213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057062b8sm91478665ad.63.2024.11.06.01.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:34:08 -0800 (PST)
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
Subject: [PATCH v11 1/7] of: dynamic: Add of_changeset_update_prop_string
Date: Wed,  6 Nov 2024 17:33:28 +0800
Message-ID: <20241106093335.1582205-2-wenst@chromium.org>
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
2.47.0.199.ga7371fff76-goog


