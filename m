Return-Path: <linux-kernel+bounces-569883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574E8A6A8B6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADC93B8161
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03174221549;
	Thu, 20 Mar 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtGsKc6m"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CF11E570D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481320; cv=none; b=lJfVVMO1OsElkowjlEdHtUt0Z74BC9cb+7GOAWUMdgwrM8ofcbUaBeVDl7qyGf4+17Z7dJiumbSlLcAkSkH4mGyGocyTwOKdHXSGLj8Mclu7SmMO3OxY8w/l3Zu2TOz9+f8sCzPkCs4fDWKU1MIokNIi1JEGSYb+F9bIDpIfi10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481320; c=relaxed/simple;
	bh=m+JIAMQNs/fA9slGvr+Q36JbmHk7Y9k8mlR9oLYnjCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uPONxlElq4iv8HLJAXPeW6TXftvyVcYtukdiWRDaxPpTgw2E7U4/NcFu4bYTfe6HJ0J9w9lIOCZ+3EXfIDX6GFegUkMzfEsgAk7hMie+qoXrnDRXgg2TM3JPur92+IgvE/HfHX+EDW2lRNyGyKE4Ab2CVlwPHAkffRGqyvbCFW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dtGsKc6m; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso5794065e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742481316; x=1743086116; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ktzMOZYNlwNiDxoE8omHkFi9oPhb83P0wnx9jkyg590=;
        b=dtGsKc6mffah9q3Tad4+CsaFVBo45ecPB85VO9XjCWpU0h65BDe9MXn5+LKgLa/mCd
         BYfRVrvvI3nbRvD7gckzJ5RKBC/AFKvu+0ED/1XVhzNrHER/wfdXDaSW4fHbLS15kGy4
         oTY5r0gOjT+kFEr8njHT7lBC/VxP9cus9GJSA3zY9iIJGzWMzqLQsW1SLwlDs8rKVKbw
         kI1mNOJO/m5XXniSyfLR7aX1H66Cjpi271ldKpt/Ftu6MKMyOt2rRqOXRUEzvz5afWr3
         b7bwADCiEKxAdEMbz9Ed35RgC6RMcGZDXh3CwZKW7SgkF/38QOEw5B4YA9GyaSUgvzqI
         meaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481316; x=1743086116;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktzMOZYNlwNiDxoE8omHkFi9oPhb83P0wnx9jkyg590=;
        b=nxOILnNal03vQx03obAfzMg2qnaaWruIU0JXwRiZtxzJ/MP8d5/ECf2iKjXJt6FwlU
         W8j8ex8lp8TLRey4o4F7oWp+amyAq1RqQJdgJRE3bhOV0pB5yeP2QLOlc/QpkwpCgqC7
         JUQ2HaqtfMb44JkObfFaIheMltRAM40cFbK3Q8r19o4FnO/akDIsaqmoE+w83b6tA3VE
         qTB1Wdh5/V/ZunvcRgz+Q8lyOtpAjrtm2wOaEnlADqhK9jKFpGxw7YRPCp7V0BBX4ub2
         +8oIFnZnaKUuZNpDjsvLlyTelt6brQGfcjh3/tojIDtkzuNevwzK+mNWv/Av69G2BULB
         qFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKys73ajJvY12dyD2GGzkwpo/PqG5wH4oIuJkknZDVmAklsUCTxvOYCyMAmcR1YEkYq2WhW5WxzGCspSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWyxVNfKe/DwDrv/7YUpLEno5KPDVZrP5IBKlHm90o9+EkWvjQ
	uRrKo+tiqomrOJRpNiJcx6xfgHaWDh+kliBm/dMK32kB1iwa15sFsTO1oEFQBQ92vlamdyfLXfu
	6
X-Gm-Gg: ASbGncsoigcZCHuQTDMw/eCj3tSF+Rgt03Wu0tUg2ww+r6mQ+7qJ7zDu3i9trIMbdD0
	Pw9aBXjTT+RDtOpurGKV4Sp5v4SRE7ILT12oyJug+/7bHjcdACjT3+AJWrgfentK8qB3rf6RRPR
	d5bTk+PvpMg2XlUq/4yppZaR9MeLjF4DuTJPpxBoiljxozPaHTbF4LL7qFdyCukLpnaDVMB13mD
	jnn/J0Mznh9tm2QhUiMIn+DGAEOnZ1+rvxEGeGvl6g6vSNMrhI7wJxaPp2JZTFTh4R407irW5ny
	syTbyNkmtyi7evsonQcH+s6qsR8XdBuoopaAfRdLhSAb2Po=
X-Google-Smtp-Source: AGHT+IGWLVpm4TQ0kdAiwRFUVf9LxYmBruxCxdW+BZGKM/2Bj+7qbRWxjTO13KNGwhsfFVq1+NGRWQ==
X-Received: by 2002:a05:600c:b9b:b0:43b:cd0d:9466 with SMTP id 5b1f17b1804b1-43d4378cf45mr58703935e9.9.1742481316328;
        Thu, 20 Mar 2025 07:35:16 -0700 (PDT)
Received: from pop-os.lan ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a27sm24238187f8f.31.2025.03.20.07.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:35:16 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 20 Mar 2025 14:34:16 +0000
Subject: [PATCH v3 7/7] coresight: Remove extern from function declarations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-james-coresight-claim-tags-v3-7-d3145c153820@linaro.org>
References: <20250320-james-coresight-claim-tags-v3-0-d3145c153820@linaro.org>
In-Reply-To: <20250320-james-coresight-claim-tags-v3-0-d3145c153820@linaro.org>
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


