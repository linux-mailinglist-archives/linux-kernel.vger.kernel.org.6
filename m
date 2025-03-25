Return-Path: <linux-kernel+bounces-575257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C07CCA6FAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C3C3BB3BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244AF25A2B1;
	Tue, 25 Mar 2025 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sytVmgVQ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA98257436
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903959; cv=none; b=KxwD8/X25/WszsniRZktzRAdWhPwwTFwEVXa5uaMuYyKdT0djWv2UEj5m1H3QBUHQkxZBFupl+0zULyo7P4nyOgWHHchzKu29ivvTfg2taiXdRMS235JTO6n96EOLJ8PjbYHRmFpU7d73gGakEi3PTiPNu6eU6O4vbATRcqaja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903959; c=relaxed/simple;
	bh=KSBDHSx6IKqT1IFTsph9P7mxQjNeakTzeyWhW0succE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uj9XVoGdRtGS7JBkwqeWX33iATOwdkL05SyLIMy13xfcrRGWDaGZ8yomB2js0eohVCJ3o8VqzO/jzeQcJiCZ2+fFMe0QdQu1porwwcD0UEnXeNasEoLQoeLsF2MhON6+uZaBTLVBFwU5UDSojgsQspZL2QV37YGvyZ3hhTmLAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sytVmgVQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso24904295e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742903955; x=1743508755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=URH02LmawsBwXwRAzrMyvcfzvtwZFgsdBIdO4zOCg7U=;
        b=sytVmgVQwJ8FbFnF/AgHMOlMYXIDfoiJj73fX8bzXG/2ZShKuDts2JJzKWloGJwQ9w
         Y7AYyDMNIAuiKEHs23lGMr/QNB/F3Fd6E1l73nS9+Hp22+cl1egFyodG7mpba7vrPG0e
         7o5Syo7MsuYkVXwLXLufHkC8UTJq/RwLT5jybpZrFsCP1ETZBKKTgig6jesHfRmAd0D9
         1FT9Hn2fJgCHHPA67ljYy+igvVtT5toh1EGktTDOkfgEkS1pX7tEPI+vmCe0qCeEijI+
         +WjPHR7z+BuMr2YIT3byJxaOHPq7iCj77Zch4u72WLD8h6NW6juOlR//S9BRHRW2VLSn
         o8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742903955; x=1743508755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URH02LmawsBwXwRAzrMyvcfzvtwZFgsdBIdO4zOCg7U=;
        b=niBq4MJ4xAtMjLYwnPnp5PMCh1XTsavUsX9Yvhd6vpPVsEQ/JYoBaDMXY1jotaJGWI
         0KjHkuauNL4HhROvIC/mMpK2lSYlnAKC/xQtyo5hSJhV45I+SgchjFSmqfKftZnVEd4w
         hbv+0+Wumv8Pe89iUSUSo1U9KB7Fm9Q1YqX7pGrMpcJB3c3bNrDfVsVzt0hX4lOlzuvi
         UKUoqNtH6EK8f7EKoT+ggiOT/3SCZ90SFtW2NSA1ef9HRoQ2pVv0jYWNg72AjaQUbZj7
         ikp5GqWSKFsGLhFx6biC0Cv1kahlLhlcD3axquDlkeaUBEf+0dhKrG/kzdUFx1JvP6rV
         sUcw==
X-Forwarded-Encrypted: i=1; AJvYcCUBFbg4jaIFf9q7ufusQyiOG35m1kqSIH/16EDhLB8NHgaDnf4N1O6iwKKrAJZP1q1qxgu4vHFMaQouGxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08SAEGR6oC8eWeCSpAkw+fddPjTI418bfxCEJ1CXXnDO7WOPA
	yj7Lmbj100lV95XGTFe0YUK1vvh09y2G/crRAwsTKTdGp6bpEHTv7SbgthdHYd0=
X-Gm-Gg: ASbGnctQq2Dt8Rs4JwbkcLUjjaZH4PujExAdrOTvljUpb/zQEuRpdJEaesP8hGzfkzZ
	d/n4FWzZgPhGtqGlEeB8KnZsjcQ5LjycFm+E/4J+SHONQOoxwbozHiCgSV24d0kVteLAPxLOdD/
	6qQmZEiE3c3mHzCpymWpLUnbyaDxpfcph4nDyuRS/SRYfzW7zJPaOCyRD01FZMMNSikceOrbT3B
	s+hbVgyDdvLrE6O9xplwEpmv/fxeHQTuv5LvHhBHQqoQD5KH5t2GKWlIWd47YJwGZybR1Ztlwz6
	fqzYhwDZxc1rEHmezXLkBMmGhfX1bDoKPLl5ExBoPMgoFjTuum+DawfgIGA=
X-Google-Smtp-Source: AGHT+IFY3J2BU7foR1zefvOJHNkMdBucCAWCq5rxXUSAdx/gx1dyi7mhO9IHsTs2kbA/bhGFxr9hVA==
X-Received: by 2002:a5d:5f8c:0:b0:391:275a:273f with SMTP id ffacd0b85a97d-3997f8f6089mr13909278f8f.4.1742903954627;
        Tue, 25 Mar 2025 04:59:14 -0700 (PDT)
Received: from [10.42.0.1] ([145.224.90.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6676sm13687169f8f.62.2025.03.25.04.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 04:59:14 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 25 Mar 2025 11:58:52 +0000
Subject: [PATCH v4 7/7] coresight: Remove extern from function declarations
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-james-coresight-claim-tags-v4-7-dfbd3822b2e5@linaro.org>
References: <20250325-james-coresight-claim-tags-v4-0-dfbd3822b2e5@linaro.org>
In-Reply-To: <20250325-james-coresight-claim-tags-v4-0-dfbd3822b2e5@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Suzuki.Poulose@arm.com, 
 leo.yan@arm.com
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.14.0

Function declarations are extern by default so remove the extra noise
and inconsistency.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
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


