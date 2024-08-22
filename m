Return-Path: <linux-kernel+bounces-296975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A36E95B164
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA7C1C2036F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A3217F4E5;
	Thu, 22 Aug 2024 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P+hiKvZ7"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFCE17DFF7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318426; cv=none; b=UkLWrZxpnBBY8iuuD01h271s9JWrHSeqw7d9xtgQ+S3g+W2qiqPSJoCyDoEVkkhrrnwHaQuyafdnB45mzGEUarHKxkwlLMdtFvXYorYvh8Cg2e0e5W5IxhnwQgzB697/AXNHkbDTzDi/ylZVKZkqseQVXaPTl1PjyzkricO8GGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318426; c=relaxed/simple;
	bh=UpiWOo/TltGJssQsJUrLPTTkx2+aS45gddRc0ilmepo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oud4KXITqF6YN4zzcTUStKYaY9kLz7WbJJYofzcgYOt82AEz7TJOBtOrOCMmTxRJofhlMTd65TBc/ARC+d8UhXgAqDKOQJdRQwwtUKtIfdHL9t+a2Vu7XLItlqXEmo0NLt1eqCPjuYDE9QVJjajBfP5gD1BY5ZWoRQVAO1N4F14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P+hiKvZ7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7143165f23fso467391b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724318425; x=1724923225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJpiCpdFfWAtf8uPPEuTBRfORRdyXl0KF9nHABZqeeQ=;
        b=P+hiKvZ7sxI+v41o7cHmXNf9yUQYVIAYRy1FyPocKlLnpT7NUYjhEGDKbMX1KFpIQl
         PMRpe/nb1ceSULkzkObjpT51ZLwXcHRiOaViYBH47zkTSGMs9r+XTwSUPuhXuuAX+Gig
         0AGadylDng7CKkGHAgVCOjGNdTqfKkpEy8GCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724318425; x=1724923225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJpiCpdFfWAtf8uPPEuTBRfORRdyXl0KF9nHABZqeeQ=;
        b=L7yn8lf6lnVJLApyVyaMnVqw1CVRNxJsAZRohDEKb4Au0GQYk+TI/Xb0XkGOxgvXYN
         elQwN/UzyjGeLY6n5wMNkGgKX5JNXIsWv0VLBAF+0Bm2Q2o0AptC6sWmw6/FG6+AvWD3
         qrhUU57eoB4ToGi+4FRlyvplJHPOC3Lol4T5GyQOHzufyfh7z6EHh8pOxeZNMUwaH1XY
         ENGd4OI2BKFUlsaVRGHUUoauVj9SfnuIhvun+X7QRH1uavORn3aGspPpWSOXtnspCdLM
         OOT5KLNW8EWegsqaHnoM0TYElFcZn39OkneEgfTGFGi7A196ZQpHE1dfPkM7EYDwnCWM
         slVA==
X-Forwarded-Encrypted: i=1; AJvYcCU2DIhgTY6Kt/PC2Vd/zfHojlTS1cjv3pt11V4U5Nsh2HvBQnJXht0K12sxleIG56lmXhD3Ed/gXnNCHTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrxhOb9gGb0gJYn+rVs/vy0JHIG8oRaCsgq/pf7RR3jTV1Kc9M
	AQ2TQq1t+OpNqEW+iy34G6g+6+QdIIw0zx8IyCK7Pdh1O0DJV1zEdU7NampfPA==
X-Google-Smtp-Source: AGHT+IF3q7kEnTwTdOeElAbMIG4ut51tj+GRpPErjT+Nd/r+ne8//cdW649YGpsOCjtM4GbM7nHD1A==
X-Received: by 2002:a05:6a00:2288:b0:70d:2a4d:2edc with SMTP id d2e1a72fcca58-7142353f2bdmr5844551b3a.20.1724318424602;
        Thu, 22 Aug 2024 02:20:24 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8470:6a67:8877:ce2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434335e69sm951398b3a.194.2024.08.22.02.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:20:24 -0700 (PDT)
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
Subject: [PATCH v5 01/10] of: dynamic: Add of_changeset_update_prop_string
Date: Thu, 22 Aug 2024 17:19:54 +0800
Message-ID: <20240822092006.3134096-2-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240822092006.3134096-1-wenst@chromium.org>
References: <20240822092006.3134096-1-wenst@chromium.org>
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
---
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
index 110104a936d9..daa69d160a78 100644
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
index 85b60ac9eec5..046283be1cd3 100644
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
2.46.0.184.g6999bdac58-goog


