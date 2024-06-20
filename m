Return-Path: <linux-kernel+bounces-222498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E717910278
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 13:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74AE1B21A52
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D841AB90A;
	Thu, 20 Jun 2024 11:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCCfvIGI"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56641AB8E5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882694; cv=none; b=M0CgSD0Iyii0TW9Sa3ZD1yde+ANDeiSOpTKi7Q8S7Ac9D4Mrsvcl3ZQI6ASbVAg4DLE07rqNuW8EJlI6FcCqkt7+CU2aCL84nl/xYtX2rK7K84hl2Bjpk1GfRaipDfffbl+f8spTNS/8K5mvYa0fMwrAqSdMZw+xWD7IlILPEiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882694; c=relaxed/simple;
	bh=tW3+FRmdT+LhW6+/gh7jWAg5hDYyMsWs2xc2h3wzP84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQN9f0I9LRO3oEigD4fd3GEc7g3mocVPmpViwFd6DhMSb1zNSZkXW7s4sLWfG67nqsH+MQZiC0oriZHnnMQnXEuBNLJGLdmb71fl4iJ5Hmt1dOthtEjbqwScPmpaQuCmcfl9kWzwkVL9A7zysPGcgtcQy80Pf0Dh/ZdiVcgyTTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SCCfvIGI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso9578295e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718882691; x=1719487491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=987jsaZOwPOhpdxKZBmiiodJXPiBJ4LwBLho6zc60+8=;
        b=SCCfvIGI2xhYTyAGXPhXUywuAwrZgW3fKqO+fj7AwlSeDPalDg7AfQvPdxm/8eLHg0
         Tf0fDDJ0Pu//tOH7Z4w0lH1sbbERiy3i5tpn4Iy0C1IHKcep5ldA843nxeTGysDsC3+5
         9KorXIyXQV8bumGMWioNdzN22vH3AXmMBNP+hFwvQmglJGIK22Rvr9KDo0zs4SikQbao
         eBnmcsK84yMZHoFU7A2mIiJckAGTLWhBHq5/dxvEczAEWZ5DFpMyVAwhzU053W2x4ego
         buB9y457Huxiq1wUdVVSkhwkhp+cxDOWrNE17dPi8tK4Dg/30wFus/Vej/AMwf2u4Ecn
         v42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718882691; x=1719487491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=987jsaZOwPOhpdxKZBmiiodJXPiBJ4LwBLho6zc60+8=;
        b=a60feldI2HjF845BUqLTKW7nkdTx2SAjpW3Kp+hU5KnVyO6rPoEHMGajfpV0JBUHef
         r769VJXjG2NMFEzUJW/r8DkARCA1DSW4Xq7kicsiUUnuW39i1Z+sR3UZh1+T9TYpcJyI
         vDWRmOC7Hgl0SujmAt1R3dltpRYwDe3s0p87TVA7J9MZ2ETYk8C/8odw1M9ce+GTZO+R
         AoPwJcNbjgv8HBUOWVrWWxTMs4a27ROQQvFe7WNnIcA55k9hhiZHD0UjhfJ9xYB4Cf8P
         3hzhrkz0ZDvHtEGzUz/zNNDxIlCxHtcmBj/5PkqH0sMlOFM64Yqv3eRLG2EcuqIdac+d
         LImA==
X-Forwarded-Encrypted: i=1; AJvYcCWG5KoAEi4KSoEUVzcQSUCNFB5bSfl90o8ICIRZvQf4SQVPxlxHgND7SFDOGpViWcdrXBKWiERdO8BMjVMQVJcDgR0f02Hejmrt3oxA
X-Gm-Message-State: AOJu0YxdjJMXdmA83LLQj58pTH2i4PCUi7gQ+sf4H9N/TsiMDmghk2df
	sp37iv6n8fhHCLFelFfqgujUoXW44E89mnjTwnVbrGq0pahFhuCYfcq8Gn5Bhqc=
X-Google-Smtp-Source: AGHT+IEWYOFclmv+Dob4SK4leA35bYz4CV1ZSG93H0XX8NLBeMikAyl8HGO+4UJqtWZ0FffKI/BoJg==
X-Received: by 2002:a05:600c:4b27:b0:423:b5f9:203f with SMTP id 5b1f17b1804b1-42475079466mr46049795e9.5.1718882690982;
        Thu, 20 Jun 2024 04:24:50 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510::3aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3647bf3092csm2025371f8f.97.2024.06.20.04.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:24:50 -0700 (PDT)
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
Subject: [PATCH v2 1/2] mfd: syscon: add of_syscon_register_regmap() API
Date: Thu, 20 Jun 2024 12:24:45 +0100
Message-ID: <20240620112446.1286223-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240620112446.1286223-1-peter.griffin@linaro.org>
References: <20240620112446.1286223-1-peter.griffin@linaro.org>
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
Changes in v2:
- Keep syscon lock held between checking and adding entry (Krzysztof)
- Link to v1 https://lore.kernel.org/linux-arm-kernel/20240614140421.3172674-2-peter.griffin@linaro.org/
---
 drivers/mfd/syscon.c       | 54 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon.h |  8 ++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index 7d0e91164cba..75379e089b6b 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -192,6 +192,60 @@ static struct regmap *device_node_get_regmap(struct device_node *np,
 	return syscon->regmap;
 }
 
+/**
+ * of_syscon_register_regmap() - Register regmap for specified device node
+ * @np: Device tree node
+ * @regmap: Pointer to regmap object
+ *
+ * Register an externally created regmap object with syscon for the specified
+ * device tree node. This regmap can then be returned to client drivers using
+ * the syscon_regmap_lookup_by_phandle() API.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int of_syscon_register_regmap(struct device_node *np, struct regmap *regmap)
+{
+	struct syscon  *entry, *syscon = NULL;
+	int ret;
+
+	if (!np || !regmap)
+		return -EINVAL;
+
+	/* check if syscon entry already exists */
+	spin_lock(&syscon_list_slock);
+
+	list_for_each_entry(entry, &syscon_list, list)
+		if (entry->np == np) {
+			syscon = entry;
+			break;
+		}
+
+	if (syscon) {
+		ret = -EEXIST;
+		goto err_unlock;
+	}
+
+	syscon = kzalloc(sizeof(*syscon), GFP_KERNEL);
+	if (!syscon) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
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
2.45.2.627.g7a2c4fd464-goog


