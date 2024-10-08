Return-Path: <linux-kernel+bounces-354679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F19940DF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F941F274E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F796193400;
	Tue,  8 Oct 2024 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TMdzIPV7"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C2019306A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372902; cv=none; b=XQflrx+LK2suoWiBRHhMRW8RMAQE3o5DRyMfO2H6pMvzO2yAXGFhfOYpc/BvzjH8v6YDThjkK7hrkSlvOdrit96O3QDGvJcMJRcWUyxLM4udJ0SjvEsxHgNLHHHwjCTSj5QfFRDyokhm8RKlUNjv2Ki01xIg4P3oTRheQ4RntPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372902; c=relaxed/simple;
	bh=gXjuduCVGO2j8sqJb5iF3L7iFMOR5ktk3aJWGPiAS4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWnTmjxn678Oc1AKS1Ei9kA6HRB/hGVWtsg2pDdHpMEIXfCNptsjTp0kiQRtxyiXn3zJRl2ZgT6xcp3tXi/GpebWQjwJZR4HEkAZ6Fxhly032S7nBy5/QSzCOQFnAPL7yofRnboRoLEOPUpNlZ4Mp2CRzfq6gOmJraGI9jGKmCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TMdzIPV7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20bcae5e482so46088835ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728372899; x=1728977699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAzJUH3GBLmDSj5mGwoVwjPdbB/GnZ3tZ1Hq/uKMSGA=;
        b=TMdzIPV7FAlPddvaPbxZzg3XbN/Wus/4Rzl4/UmoVY5xslNl9iiQRvgXmtEmow5po3
         9H9DvAyb1rC5wY0K/3LmDMsvT+k7p6xL2zZQh+EFaUAXsEnRRMPQhzNd1IVLTUgJFv4r
         e23aYgChjlfBPj8hGpbx00hPJ8C7K0RoIagG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728372899; x=1728977699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAzJUH3GBLmDSj5mGwoVwjPdbB/GnZ3tZ1Hq/uKMSGA=;
        b=oFd1Ip7203jvE34QWkHKO32iyF+c8qPqZsAMOprPZwHIDa6fctAhu3n8v/mRER6SIL
         kl4sLA2jJVhrgWTTuyH0YrXg2UGoxNVYXkzAI2J7UH6KQKaL731UcOllQ2T9C/BWm8qD
         A367HBYT4oNm0/jcx6C1RQmE+nY6wrZQp5E9rbq5uUbqxe/98tncI+QraEFPm4oiXoQI
         yZBcIEj9n/vUfuguwANTmr8tegVPvaYct7YlnSzP39hrOOt+pRd3bgpRZh8jw9tBxvJq
         PzUgB9xSlMAZSjJ6XgNnU1/1M+4VrEf1+B5THQMCm+/RkMh8YoGyKOjI5p9oarkmYe7V
         2Ypg==
X-Forwarded-Encrypted: i=1; AJvYcCUVTd81AlAnDP1o3hz408acY95qj84WgzUDoAkAWNF1wTGnvPl9y1bwAF90EpDYhrP9U4VQUSut5j+YoQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoerW24Or00De7Ecsm9yvoeHnxFRr/aabV1VHSKO+6ZJY6T9AQ
	nPcyxnxfgvNcqEAVO/q3qpNpZ8cIVkJDrb5IvOPvCBXQZ8U0/pJ5j2uLS+GuLg==
X-Google-Smtp-Source: AGHT+IHIKHmfMvFJnBjVWzQP4Z8JAEL56srV5DFJYO66fK6FEpy7LiHndoNxlP7Wsz8kCnkdjMt78g==
X-Received: by 2002:a17:903:18e:b0:20b:5aeb:9af with SMTP id d9443c01a7336-20bfe07d26fmr146811785ad.22.1728372899314;
        Tue, 08 Oct 2024 00:34:59 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:10df:d27e:8d4b:6740])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13939bd7sm50121175ad.120.2024.10.08.00.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 00:34:58 -0700 (PDT)
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
Subject: [PATCH v8 1/8] of: dynamic: Add of_changeset_update_prop_string
Date: Tue,  8 Oct 2024 15:34:20 +0800
Message-ID: <20241008073430.3992087-2-wenst@chromium.org>
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
2.47.0.rc0.187.ge670bccf7e-goog


