Return-Path: <linux-kernel+bounces-566529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD24A67962
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D021219C5C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A238211487;
	Tue, 18 Mar 2025 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mHKGq8ED"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A5A212B1F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314962; cv=none; b=k1ah1O5POwwMLf1HCwPQ+zhvs/1eQTJ06ntWKN6f5p3k4VaT6z7bQJ+hT95uBpeF8ucZaOatEbuktnhpkVv+KXK+0G0NO6TftMDGRtBAs39hwuNwcxTNkzf45frjszyr8FA680iBTTgSG9LrhQFryFJnvkQj0ch8dyY7UWOaBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314962; c=relaxed/simple;
	bh=m+JIAMQNs/fA9slGvr+Q36JbmHk7Y9k8mlR9oLYnjCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovwkVA+BkTRkGEcDDLOb8znETPOZ8Q3PMCyzYkQWotjZkI6k5sv5dY5KHIMYnnMqYZtK6r1xWyLSyryAlQaVP98m3gslTr5q/8lOBGX3BcZwDIaj/Ucn59d9xjOy0Cy0xR70VFq/zixInDMDOuaYxKWP8X//7EbvxgREfLdp6+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mHKGq8ED; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390effd3e85so4863808f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742314955; x=1742919755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktzMOZYNlwNiDxoE8omHkFi9oPhb83P0wnx9jkyg590=;
        b=mHKGq8EDyNSQasYePA0ITb/NbqnOp593x176I8M/iC3HaNRSSTfG9bkuGH28zBqcqs
         Ip7RRq49gwaMHhvvFrodcy1ntBcj2XoLBniEqO/FwKZWtx7ZipJegnv4aDW1bVuCLb8a
         AvpmStt+aC0QCgcYHNrr9VNH9PJdv0UQunfdXbsnBipWyJAoxGiS6YjeoDSSAhxPDlh6
         Il4YqTNtFEw8YQBY4pkcGa9rO53JPKRYN5BfdGWpxOgfPr50QNVPiqCzFYW83CE9UcON
         DKSjpnWr4k7oH32wl6Y3PfO5Q2o2Zjq7/DQ5tV8qrirbhm4xj2/kaG/6kmCNjHqx00Y+
         qWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742314955; x=1742919755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktzMOZYNlwNiDxoE8omHkFi9oPhb83P0wnx9jkyg590=;
        b=CbseJDz0pHJVcvXtDbZNSsZvY19c5AgcWFrYIGFTpa1DtDTxvLt815dNSPrV73Ce/D
         8qZd3IS7s/7is9KHtWLiJujvGoR6Ka3mwxSXtWtzXR9vsmsYcQRYv4rK78xEi/jhCWDH
         Ci82QglXVAoTx2N/KJq+v8xERafVRbDMCXWLor/0DE7yJfyIZ7wNnNJPazp44qxWVrG4
         ghN9NUckT9yQDM5B0wO4PkmbInXEb26ERFwIFm/wITsJEZNgr0PjFjSwXtUfYE+t9WXw
         jjZyqCJXOl5cA85iDDEkra12+fcAFpdGYbqzGKadW2vZDkcmaHpDfA0LI5zOtfTdLkwJ
         RP1w==
X-Forwarded-Encrypted: i=1; AJvYcCX5xR1yuUD06mpCzNsoere3+AwnYjNvdUeU23UxZMwwdUAHChPYK5+h44YJmhip6TLP65S9CIGrZo89KAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXaQVIpM12mcQNqlJbkNW5/jwIy8jheWvxwJcWsGgajolvxoig
	gY785TOoQq//Hi2EkJXUwZGXjHQd+shns57Qe4e3iVVmMO0WXxEhYC/Ao0J6TdE=
X-Gm-Gg: ASbGnctAR+V0OH8pxhqK18PBIyj2r7CYxU1t4ZX9DCOrhdYqJjvesbwIdFEdKJ3P5Fa
	0HIw2TMHvXgpv99vzZ04vvcJO1oX6LmLzZgcltyUHal4pIdJWKCgA5j52t4IqtGE0Epx/dEMSC5
	M5pfZYAisL6akbUmmHoTPLPwEPZhGgkG7NrAa3LtBgFJ2MEkBPPW0/yOOMKJUIKOOL+dhBDhXyL
	f9yHxW2o8mi67H+Toy2lex3mpFlvMGj43sXvGqT5cs569Sht692jQRLt3alCFoflnZ4U17aUj+7
	fbMpeKJ6ZFdU8iCj2qJlNnwIlZ90X41UFDg5m8QPIs5RCD0=
X-Google-Smtp-Source: AGHT+IGJ+MGp/aQ7ouZ/3tsk70ncM8V1wNpnssWoc4eHTIu28PpPLIFGuzYHt7Mmu48slGPW7y2ccA==
X-Received: by 2002:a5d:5e0c:0:b0:390:fe4b:70b9 with SMTP id ffacd0b85a97d-3971daeb6cdmr13373876f8f.21.1742314954910;
        Tue, 18 Mar 2025 09:22:34 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975ae2sm18914732f8f.51.2025.03.18.09.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 09:22:34 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 18 Mar 2025 16:22:02 +0000
Subject: [PATCH v2 8/8] coresight: Remove extern from function declarations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-james-coresight-claim-tags-v2-8-e9c8a9cde84e@linaro.org>
References: <20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org>
In-Reply-To: <20250318-james-coresight-claim-tags-v2-0-e9c8a9cde84e@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Suzuki.Poulose@arm.com, 
 leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.14.0

Function declarations are extern by default so remove the extra noise
and inconsistency.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-priv.h | 14 +++++------
 include/linux/coresight.h                    | 35 ++++++++++++++--------------
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 6e8cf55aee0a..ce91e0fbb497 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -60,10 +60,8 @@ struct cs_off_attribute {
 	u32 off;
 };
 
-extern ssize_t coresight_simple_show32(struct device *_dev,
-				     struct device_attribute *attr, char *buf);
-extern ssize_t coresight_simple_show_pair(struct device *_dev,
-				     struct device_attribute *attr, char *buf);
+ssize_t coresight_simple_show32(struct device *_dev, struct device_attribute *attr, char *buf);
+ssize_t coresight_simple_show_pair(struct device *_dev, struct device_attribute *attr, char *buf);
 
 #define coresight_simple_reg32(name, offset)				\
 	(&((struct cs_off_attribute[]) {				\
@@ -160,8 +158,8 @@ void coresight_path_assign_trace_id(struct coresight_path *path,
 				   enum cs_mode mode);
 
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
-extern int etm_readl_cp14(u32 off, unsigned int *val);
-extern int etm_writel_cp14(u32 off, u32 val);
+int etm_readl_cp14(u32 off, unsigned int *val);
+int etm_writel_cp14(u32 off, u32 val);
 #else
 static inline int etm_readl_cp14(u32 off, unsigned int *val) { return 0; }
 static inline int etm_writel_cp14(u32 off, u32 val) { return 0; }
@@ -172,8 +170,8 @@ struct cti_assoc_op {
 	void (*remove)(struct coresight_device *csdev);
 };
 
-extern void coresight_set_cti_ops(const struct cti_assoc_op *cti_op);
-extern void coresight_remove_cti_ops(void);
+void coresight_set_cti_ops(const struct cti_assoc_op *cti_op);
+void coresight_remove_cti_ops(void);
 
 /*
  * Macros and inline functions to handle CoreSight UCI data and driver
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 00134a80d358..8cb07c132b01 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -671,28 +671,27 @@ static inline void coresight_set_mode(struct coresight_device *csdev,
 	local_set(&csdev->mode, new_mode);
 }
 
-extern struct coresight_device *
-coresight_register(struct coresight_desc *desc);
-extern void coresight_unregister(struct coresight_device *csdev);
-extern int coresight_enable_sysfs(struct coresight_device *csdev);
-extern void coresight_disable_sysfs(struct coresight_device *csdev);
-extern int coresight_timeout(struct csdev_access *csa, u32 offset,
-			     int position, int value);
+struct coresight_device *coresight_register(struct coresight_desc *desc);
+void coresight_unregister(struct coresight_device *csdev);
+int coresight_enable_sysfs(struct coresight_device *csdev);
+void coresight_disable_sysfs(struct coresight_device *csdev);
+int coresight_timeout(struct csdev_access *csa, u32 offset, int position, int value);
 typedef void (*coresight_timeout_cb_t) (struct csdev_access *, u32, int, int);
-extern int coresight_timeout_action(struct csdev_access *csa, u32 offset,
-					int position, int value,
-					coresight_timeout_cb_t cb);
+int coresight_timeout_action(struct csdev_access *csa, u32 offset, int position, int value,
+			     coresight_timeout_cb_t cb);
+int coresight_claim_device(struct coresight_device *csdev);
+int coresight_claim_device_unlocked(struct coresight_device *csdev);
 
-extern int coresight_claim_device(struct coresight_device *csdev);
-extern int coresight_claim_device_unlocked(struct coresight_device *csdev);
+int coresight_claim_device(struct coresight_device *csdev);
+int coresight_claim_device_unlocked(struct coresight_device *csdev);
 void coresight_clear_self_claim_tag(struct csdev_access *csa);
 void coresight_clear_self_claim_tag_unlocked(struct csdev_access *csa);
-extern void coresight_disclaim_device(struct coresight_device *csdev);
-extern void coresight_disclaim_device_unlocked(struct coresight_device *csdev);
-extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
+void coresight_disclaim_device(struct coresight_device *csdev);
+void coresight_disclaim_device_unlocked(struct coresight_device *csdev);
+char *coresight_alloc_device_name(struct coresight_dev_list *devs,
 					 struct device *dev);
 
-extern bool coresight_loses_context_with_cpu(struct device *dev);
+bool coresight_loses_context_with_cpu(struct device *dev);
 
 u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset);
 u32 coresight_read32(struct coresight_device *csdev, u32 offset);
@@ -705,8 +704,8 @@ void coresight_relaxed_write64(struct coresight_device *csdev,
 			       u64 val, u32 offset);
 void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset);
 
-extern int coresight_get_cpu(struct device *dev);
-extern int coresight_get_static_trace_id(struct device *dev, u32 *id);
+int coresight_get_cpu(struct device *dev);
+int coresight_get_static_trace_id(struct device *dev, u32 *id);
 
 struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
 struct coresight_connection *

-- 
2.34.1


