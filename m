Return-Path: <linux-kernel+bounces-423526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E06B9DA8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DD1282A63
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2FC1FDE0E;
	Wed, 27 Nov 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GrrgMVxs"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E21FCF69
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714988; cv=none; b=HfGGmw3lOOQM40BsufcsGUxCWwL9a+270cxHQpXIvIbvFTYkRFzvj1Pj7HJ8WNBCqXIHAL2p0oQfxHgAsCL+/tGWTbUcxrGVLx+HZlSs7TEWGsAgCtA8AfiWiyKSfYHS11XNUgP418+3CHIktdmBPhPjz9rl6x6iOUXPT4JMQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714988; c=relaxed/simple;
	bh=K7n0wxVY/ilMwwjUvSqV57HP9mOotkMw60khUxl2FW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLqw6Q+qPpkXkhABSJtkb6lGzZx/2OK7/Ap/5hDqyOSdSe8Ur52A1LGY/skCkVxzZ38jwrSm+/F4GrJvdmVz1JbKf63QIKTcuUgFy9RbUyL2UTOp7Yu7MnL8HIkj/tcciOrWlPtvE5lliOg/xGoKa31BOtp9fD6PI5zXJ4UT6L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GrrgMVxs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3823eaad37aso546817f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732714985; x=1733319785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwYuMbr1LfJ5VAFpw4rhCtYlWSRl0WXyDX33mfRehWo=;
        b=GrrgMVxsbhgYbsGLK5zns5rWKjI1+0rcbSkiUV5unm1u/RtVLHE/BIJypw6wEREoqY
         VRbpStWc/uvfcpiKDZQHuPu///kYS/LrKs1dhGgi+01jAOELkghUbimtfviqI1Uq+QnK
         AALjsQ1davO3sqceYtoHZsGPTdns88k+kSdKskUs6fIhNJAkhrEC+4yRWePmTJ0oSihR
         x/Owz9hLZjPSv26DNDACiqlAQUrPXnY+dAKY8+VP5Lpj3qfs5sfA6CrxJf46ncWjMCId
         Pf+wPE9NME2fxyp1HrXZ2C/XpDhaN45O1OkAQ10TppEjjqrc+EFcpQVtzzNnq+SEhzUU
         7KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732714985; x=1733319785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwYuMbr1LfJ5VAFpw4rhCtYlWSRl0WXyDX33mfRehWo=;
        b=DBMuU7uEonEFKwL4N5WthZ+LQU2SUfi4Iry5MSuq7ZShii77jGBl2swa0kksbvZC46
         cOrQxqKl0X4lV+uUwIZHiN3kWdnpv3zFfvRphgQGTN8YZ9FnTD1WTuXTGdsegXQDNTsn
         XpPXJw3Nf87LeU77/hFn1jhsHAuddXANtUdlSiDWhM/k3XMMB6JdSpfaTjyuUnb1fYPa
         2RTIL9owPMSqya00sYwlWCzTPjeT6hTWVTOu+FWc/PV30Puv9qh1+6vZkSeAQlF1KPDu
         QhevlPRvzrQ0QQFEiYk+JJKls12KNa98vlP/YkU5JoaJq1MB8Go0KJETSNaAru+8yvhe
         fTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrJ5I0z1wyotVSzWr2XzzubuVKBL2yj2/7D0lLK9+AS+uoQ+cSLqyb6BAG9pgwPNnbJnhXQ8Gz+pzGQfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9XTaatKf9/I1pczSCq74/MLrcwvkLlTq5MYYtd+apRA51gMcp
	Ub7APAXEcHkIWdpstzZWa+sw29RVciFwDGGspj1PYh5rHGYXGUbcTalfiWIKfcU=
X-Gm-Gg: ASbGncsGVYyHHkZO5Chxfl2M38T76G+YxkaNXEaGUQCVxmkmtoioxEFpikcJAegsZd7
	MBBiu1VOVunuUSohHhsy1lM6o+3ugbqCHfoqqzBSAj9YJS1cQCsgVXuh6QUj5dnva159bSjaAlP
	/R5bkQqkLuTjZvE6zF5VyF6w9ode7JXAXfviaU7/V+5s6Mz0SbNXrHkovZnJCkZdJjSoV9sJK+R
	GBhMZcnCHjvgBWxqCUmtVDhQkvSrBnfjN+AXwOXfD9rMOXxMbey
X-Google-Smtp-Source: AGHT+IHV4zsXiet1ZrBKIrnL9MpU+lNAH9wdVPgHqqFcCo9pkcAoRtI2rRGLhjawXq7Am076lKeAkA==
X-Received: by 2002:a05:6000:156f:b0:382:4a94:af0a with SMTP id ffacd0b85a97d-385c684154fmr2111461f8f.20.1732714984760;
        Wed, 27 Nov 2024 05:43:04 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6829:901:9ff7:e7c5:5e0f:c5ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5fa2sm16804645f8f.1.2024.11.27.05.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:43:04 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com,
	james.clark@arm.com,
	Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 5/9] coresight: configfs: Add attributes for unload operations
Date: Wed, 27 Nov 2024 13:42:52 +0000
Message-Id: <20241127134256.2254851-6-mike.leach@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241127134256.2254851-1-mike.leach@linaro.org>
References: <20241127134256.2254851-1-mike.leach@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add attributes to view last loaded configuration, and to unload
last loaded configuration, if it was loaded as a dynamic config table.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-syscfg-configfs.c     | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
index 83da4820be6d..d7883fe802b5 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -790,9 +790,71 @@ static void cscfg_destroy_feature_group(struct config_group *feat_group)
 	kfree(feat_view);
 }
 
+/* Attributes in configfs that allow load and unload of configuration tables */
+
+static ssize_t
+cscfg_cfg_unload_last_table_store(struct config_item *item, const char *page, size_t count)
+{
+	int err;
+	unsigned long val;
+
+	err = kstrtoul(page, 0, &val);
+	if (err)
+		return err;
+
+	if (val > 0) {
+		/* schedule unload of last dynamic loaded configuration */
+		err = cscfg_sched_dyn_unload_cfg_table();
+		if (!err)
+			err = count;
+	} else
+		err = -EINVAL;
+
+	return err;
+}
+CONFIGFS_ATTR_WO(cscfg_cfg_, unload_last_table);
+
+static ssize_t cscfg_cfg_show_last_load_show(struct config_item *item, char *page)
+{
+	struct cscfg_load_owner_info *owner_info = 0;
+	ssize_t size = 0;
+
+	/* ensure we cannot read last load while loading / unloading */
+	if (!mutex_trylock(&cfs_mutex))
+		return -EBUSY;
+
+	/* check dyn load / unload ops are permitted & no ongoing unload */
+	if (!cscfg_load_ops_permitted()) {
+		size = -EBUSY;
+		goto exit_unlock;
+	}
+
+	/* find the last loaded owner info block */
+	owner_info = cscfg_find_last_loaded_cfg_owner();
+	if (!owner_info) {
+		size = scnprintf(page, PAGE_SIZE,
+				 "Failed to find any loaded configuration\n");
+		goto exit_unlock;
+	}
+
+	/* get string desc of last unload configuration from owner info */
+	size = cscfg_get_owner_info_str(owner_info, page, PAGE_SIZE);
+
+exit_unlock:
+	mutex_unlock(&cfs_mutex);
+	return size;
+}
+CONFIGFS_ATTR_RO(cscfg_cfg_, show_last_load);
+
+static struct configfs_attribute *cscfg_config_configfs_attrs[] = {
+	&cscfg_cfg_attr_unload_last_table,
+	&cscfg_cfg_attr_show_last_load,
+	NULL,
+};
 
 static struct config_item_type cscfg_configs_load_type = {
 	.ct_owner = THIS_MODULE,
+	.ct_attrs = cscfg_config_configfs_attrs,
 };
 
 /* configurations group */
-- 
2.25.1


