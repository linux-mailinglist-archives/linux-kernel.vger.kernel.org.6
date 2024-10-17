Return-Path: <linux-kernel+bounces-369545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8309A1EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9B3289506
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D911D6DD1;
	Thu, 17 Oct 2024 09:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="POZKVmSS"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931A6762E0
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158159; cv=none; b=OKszAyKLJ7Puk531O8pMVRKXdr+MT7n9ymTYFOS7Cvru0yHjLm1Z2epym50QKunXa3qct5d9uYYLrjzbYH2J0PV2M4UyJlJ5ehAWk5LRtaBT7gNIpntYOO28eDLwl3O3+hFhAnPfWB2paD753DEYYtVdwqOsZ44PNeOAszH9cTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158159; c=relaxed/simple;
	bh=V/n7WzzFgqcIbOXGpqToEE3eBDOc2ugJNgUyK4Dqt3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4ahV4NNZRkaPku6r2JFSR9CC51EHo+Gct6Cug4KIV/RsVYfTTW+SYbICxKxJmUHAykFD82rExAxv6pAEpTvCIG+lkfP95LoQ16woCe4tn8jMoDyWK6LL1xhTMFhm6UkW6WE4KA+pzPmfhQ0En1dQfgrmYr9xMZP+yRwu9m/Hbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=POZKVmSS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cf6eea3c0so6182625ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729158155; x=1729762955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6FZbts9QCxoLKhhcQZxuM7DUHh34aD5doQpW7slZ5I=;
        b=POZKVmSSWwZf1er0s0t249d3bX/uZC249yMpWlmzwPrrbjMpV+d9vNuVjraCbhsvJI
         26jxQHUsx/QkV4zTrVHeGbYFbbm/meHwCJVgOtlTKaV76Ae/zPtRO20iBxhkWIyZ3b0V
         sq42Ch/gfoVkcI0j1E0N3Yk/iJXcwGJ2HRKno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729158155; x=1729762955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6FZbts9QCxoLKhhcQZxuM7DUHh34aD5doQpW7slZ5I=;
        b=O3SvVpQf4c7B5rZzyfN9u8aDYPz9Dyxkwt+Oq2qMjkOdfZAUht3C6HxJ7OcYSu1WNf
         7AyluViukn/3x5u10K5YpGT7MNVI3zRxNJTjncU1zLpmjyCRy1BEE/YUu4ZV3t+rFAN6
         nPQeHBy9NZSLC9kPaAmh613AEn+mIMAZwJdxZFVliMn7fdFFgpj6ZjFWWrAvfb3CzGLU
         I7mQSmEzHkL43s+VoMMJTZlcroad+SDi5Ni2/nhNKnqhNh+npt2da21JueclZvktg0J/
         bmR5crNeyFx4t+b0yt2XEVyFX4i294rsS0SbV5F1zWkVv7unDr1s2k9faeGicaZUbWKQ
         cPJg==
X-Forwarded-Encrypted: i=1; AJvYcCVRQ/Ot3m3R8Cu+ZsH4ir8FIfmIZO1W1TM79C0KvtpYD/LAxzSViVxv6z8mZ6c1fFs/DqYD936E4t6RA3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgpi46BtN54uuevP/j008853kSs+BCfbez8ZT3ybpZ+c06sT43
	VNt+9g2wd8sqamkOja6KkPEDPRwMpkoAX9XMVONQvElnZ2ZYyT6GldPOcEBe7g==
X-Google-Smtp-Source: AGHT+IG0EPLVHHmR9wrOAnasXV/P1d6JWPLrEg/AThFAO/2GTIkhM3VA+1j1tPEZBxObpDzVuNjxrg==
X-Received: by 2002:a17:902:d4c6:b0:20c:bb35:dae2 with SMTP id d9443c01a7336-20d27ed00e8mr83383385ad.28.1729158154872;
        Thu, 17 Oct 2024 02:42:34 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:fabb:a7ab:3d7:9aaa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f87ccasm40638655ad.62.2024.10.17.02.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:42:34 -0700 (PDT)
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
Subject: [PATCH v9 1/7] of: dynamic: Add of_changeset_update_prop_string
Date: Thu, 17 Oct 2024 17:34:36 +0800
Message-ID: <20241017094222.1014936-2-wenst@chromium.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241017094222.1014936-1-wenst@chromium.org>
References: <20241017094222.1014936-1-wenst@chromium.org>
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
2.47.0.rc1.288.g06298d1525-goog


