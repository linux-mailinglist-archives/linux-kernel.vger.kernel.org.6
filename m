Return-Path: <linux-kernel+bounces-224602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2B91248D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989911F21F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A913175550;
	Fri, 21 Jun 2024 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqch0rhO"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12A172BC7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718970952; cv=none; b=nMwfKXR01He/lbqOtJCIASff6Ev/hw+DbeiIAQ5BZqV55V6+KMJKbTm0THa0/JPhER6BFxNw/+7dO9xpWO4DgqMjxs97mbIKVCVT8DdydEyaCk6nCXP4f3lOlaIuVxwE4Sqa0wScwXlK+IMVLvZHBKr0Y0VP8I4K7VBupaoU34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718970952; c=relaxed/simple;
	bh=aWiQYGEg2y2EGgR7XhKaODeG7DKNuY8R0pJ3wGri6rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbHzgpBwE4fTTZw5JBK+2S8GLXZnnze2XoFs5Mt8zoyY7GtA+1xBbWHeH9fYyiHUSHSmwGiSKTb4DXJ4oVS8KgfqNOYKy7WiWBJ8jazbodg/7AO82Qg3F77YDa2KujKA79hJlMidEC3hFk03MCO0wYz6t1vo7qLzTmspHWYVGik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oqch0rhO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52c819f6146so2374619e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718970949; x=1719575749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyW5+VbIADwYbvLjE/DRg3OiI2Mx9SABmjT69Y7dUKk=;
        b=oqch0rhO3u4u6o/EaulwX73x5xxypsTs7TScaHCGign1oBEOci6osYyG94fG3t8LDX
         BumsSC+/IyhLVz5OpaNN1eBH6fxfRaiCK8Sx8ou6VKyrzhiCcVHeYC97Uo4Vw9SI2BN2
         f653br/CMHQe5AqYNiPjzPJPsnSxOQUhK7MICsGbIiEu2fpBUIsThZdhvSphFPY8FZga
         svXg0sFtKfmiCjzq0J6bQ8JCcRVEP6FXmW45MAAKYYwlXqTC+p/JzuoGjAeU7sgdfqaT
         U5/B2e0xHQ/IwqfZsmt6wHD4CjnBATVN9FpU5VyUedEK0pDhviy7f63I+cKdJ7zXeiXu
         tHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718970949; x=1719575749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyW5+VbIADwYbvLjE/DRg3OiI2Mx9SABmjT69Y7dUKk=;
        b=mupaBqtaBZ3Jnu6Y5TeTKixwjGATfVg5A/w9j3kPEMhQHY+zXChnE7wRxqQOrjprfU
         yd4LQuBZnCTWuFX5tIxuEWE6gUESO7hXAxIwFZP1c7j0kLtpAzPPUlVbEMD80P6ozrZ2
         ZeVamjg9nhaguMGwYyQhOZGsvPkksRa8QPbTQw8aRenwAWaHOfx6Zi9XEtUft/T5YXNT
         zOrBm9wSMpMFMIEgAe3rBB/P9SA5j4SAvKKc08pL3kbHI6yyJ7X3jjd7+MgWGdrQEJNE
         H5A2JB0Jyn1V+IuMQx31Rhn2IImVXcO6l+L+dlp0MCBLq8j7DpXHMqxwtkpjgCeQ56rn
         mjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAMWoB3cEvEfpZwwNCbuchnio6/8eFMfi9t6FePC5Jc0Uv1aw3RUaBm5QGHS7EBURrqmyjgYLSafUEXjzKP5C+LLCPu1G+rq7qkgqN
X-Gm-Message-State: AOJu0Yy3b2WWoESWSQNOdv5Pun9rEySyZBOpHF9Cvqm2gb5i6ls2Ed87
	CbTdrtuy3h4P0T8md/Vin/C34o4TUtr2v8q5gwW1DU7SAqp7Uj82jziS+H3wNWE=
X-Google-Smtp-Source: AGHT+IEK99mzL+zVK5iwlAts85kqCZbOM80etX+4cRw1BqvCAihCDCG8nvU55FlE1jsMiBzfFG2c3A==
X-Received: by 2002:a05:6512:e98:b0:52c:cb97:ebba with SMTP id 2adb3069b0e04-52ccb97ec44mr6156327e87.24.1718970948984;
        Fri, 21 Jun 2024 04:55:48 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510::3aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208dcesm60386725e9.31.2024.06.21.04.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:55:48 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: lee@kernel.org,
	arnd@arndb.de,
	krzk@kernel.org,
	alim.akhtar@samsung.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v3 1/2] mfd: syscon: add of_syscon_register_regmap() API
Date: Fri, 21 Jun 2024 12:55:43 +0100
Message-ID: <20240621115544.1655458-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240621115544.1655458-1-peter.griffin@linaro.org>
References: <20240621115544.1655458-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_syscon_register_regmap() API allows an externally created regmap
to be registered with syscon. This regmap can then be returned to client
drivers using the syscon_regmap_lookup_by_phandle() APIs.

The API is used by platforms where mmio access to the syscon registers is
not possible, and a underlying soc driver like exynos-pmu provides a SoC
specific regmap that can issue a SMC or hypervisor call to write the
register.

This approach keeps the SoC complexities out of syscon, but allows common
drivers such as  syscon-poweroff, syscon-reboot and friends that are used
by many SoCs already to be re-used.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
- Move kzalloc allocation outside of spin lock (Arnd)
- Link to v2 https://lore.kernel.org/linux-arm-kernel/20240620112446.1286223-2-peter.griffin@linaro.org/

Changes in v2:
- Keep syscon lock held between checking and adding entry (Krzysztof)
- Link to v1 https://lore.kernel.org/linux-arm-kernel/20240614140421.3172674-2-peter.griffin@linaro.org/
---
 drivers/mfd/syscon.c       | 48 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon.h |  8 +++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 7d0e91164cba..33f1e07ab24d 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -192,6 +192,54 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 	return syscon->regmap;
 }
 
+/**
+ * of_syscon_register_regmap() - Register regmap for specified device node
+ * @np: Device tree node
+ * @regmap: Pointer to regmap object
+ *
+ * Register an externally created regmap object with syscon for the specified
+ * device tree node. This regmap will then be returned to client drivers using
+ * the syscon_regmap_lookup_by_phandle() API.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int of_syscon_register_regmap(struct device_node *np, struct regmap *regmap)
+{
+	struct syscon *entry, *syscon = NULL;
+	int ret;
+
+	if (!np || !regmap)
+		return -EINVAL;
+
+	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
+	if (!syscon)
+		return -ENOMEM;
+
+	/* check if syscon entry already exists */
+	spin_lock(&syscon_list_slock);
+
+	list_for_each_entry(entry, &syscon_list, list)
+		if (entry->np == np) {
+			ret = -EEXIST;
+			goto err_unlock;
+		}
+
+	syscon->regmap = regmap;
+	syscon->np = np;
+
+	/* register the regmap in syscon list */
+	list_add_tail(&syscon->list, &syscon_list);
+	spin_unlock(&syscon_list_slock);
+
+	return 0;
+
+err_unlock:
+	spin_unlock(&syscon_list_slock);
+	kfree(syscon);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_syscon_register_regmap);
+
 struct regmap *device_node_to_regmap(struct device_node *np)
 {
 	return device_node_get_regmap(np, false);
diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
index c315903f6dab..aad9c6b50463 100644
--- a/include/linux/mfd/syscon.h
+++ b/include/linux/mfd/syscon.h
@@ -28,6 +28,8 @@ struct regmap *syscon_regmap_lookup_by_phandle_args(struct device_node *np,
 						    unsigned int *out_args);
 struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_node *np,
 							const char *property);
+int of_syscon_register_regmap(struct device_node *np,
+			      struct regmap *regmap);
 #else
 static inline struct regmap *device_node_to_regmap(struct device_node *np)
 {
@@ -67,6 +69,12 @@ static inline struct regmap *syscon_regmap_lookup_by_phandle_optional(
 	return NULL;
 }
 
+static inline int of_syscon_register_regmap(struct device_node *np,
+					struct regmap *regmap)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
 
 #endif /* __LINUX_MFD_SYSCON_H__ */
-- 
2.45.2.741.gdbec12cfda-goog


