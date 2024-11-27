Return-Path: <linux-kernel+bounces-423524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627099DA8DC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B6D1632EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1BF1FCFF2;
	Wed, 27 Nov 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEwqmLKc"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869C1FCFCA
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714987; cv=none; b=iVhbhAB2HjUyAuKNzpKG/oDLxLGE9IYe4ktBPkLNXZV2JnnF6xEIh2rIpSEstTTpMcKPuPC/nTL+OSfKqAzKvHtcDFFkmy1a55XktxhV9YFizSyCorHmTioreLHljENNrudeNhtZyaNPNKC0+C8buJBwCkGvGGLoOcw5mMO/kLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714987; c=relaxed/simple;
	bh=Mk/4oOZJD/COA6vI8fctB4AcWiipnUaW6StudvCDXIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dqbgG/EvnD6ku9fo4RvVAjOEuoSY6KUA+rdx7AN/8TrJBrwH2Um/QgEFqyjSSyHpemUn8opD+bFG8WmQpB1fqzALP59ciU0rJZ/QiW+FTZYwoWzTTHevclHYdTrzIbjIciR7ZjuounNVTzYHLBFg61yXpmQISqTRc/DshTKr58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eEwqmLKc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3823f1ed492so478790f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732714984; x=1733319784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDdX1bl5lCymW1Raij3h1SHKKmloqC4GtdPMjepmrjc=;
        b=eEwqmLKclcYO5B8TRLjbnrE/RBc9zbk2vdSgrQeTMZL2Chjyh3pk0FkDTBuN8lQ+7Y
         nPOykw7fjGxLgb1g007PiK+BJTevnPluxpQw9hbaHf76QU5sthtegJWZJxgejxKZzRkb
         UypFzU+N49S5D1RJjns4uDRzJdLcje0sxQ0cH7sp/5zVnDP51EttTjml+mf+ObrDMhJt
         SIIvQqzkPIUhc26LxN+cMCpS6e7HyEFYhIU+vweYlAK1ZveCd+KvK4EI1Ouhl9hNxW+A
         hN2xu37PPEbowiMUGV9grGe1NRU6aNbbZSihjx2nmt73+6E985rQoN3MObEyNPrTLRMQ
         HfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732714984; x=1733319784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDdX1bl5lCymW1Raij3h1SHKKmloqC4GtdPMjepmrjc=;
        b=NJqhvRVTbVOag99Tiv6UlUr/Oz73u4xbcWwiAXCzQvL1dwZo+738BBFC4vLVCpP+BA
         cp7JZRv1sM97Zj0G/5+mpt1rPfIm0DQ9wSBdbJ24afd5q6b7AtyU1rlqwqIeqmdxk5+Q
         F4+5tMp3FTxc/VYphmsmbjMmlJI9URzp1BrC90CGfSKhQ7xO0ZOuUDkm0dS4zE8Ff32e
         82KoB1m0DbIOSLOeTWFaFDkTlVQenCOFViL/n2RZu5m/fkj15gfMCEiLAVDM7cCl58Sq
         NuEP60B2kjIBkhfrQlLBqIDXxBOa8AUMLA9/I5/ZG7JERXOZhL/Y5Idtf3pT5hEth14K
         m2CQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1f/n3PmybiZhDgxO77GfuY7XJv7tjD95/UeaE1aI1hV8UiZ1UvMmSgE+YMWChRhD+Yb2zQQPisyil/3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCB9UlP8jvs66G+gwBge4d08ZfmGZUQRHbOzhvOlm+styqfgfR
	ndyG+vLji1i3eLRs6PSR5yWfvWOR9NBvwrx1R1JgJtP3HER7yzn9JZyZSjFGJXE7q67xFX8MrpC
	0
X-Gm-Gg: ASbGncugQ4ndth7UrAzcPADj5Sof0u/CYzQXDJJmkv8XYHqIaYfxal/S+hTbqr6HHyZ
	EKovf67uEi5rUpqmUdsBXgYbfKqUsqrE6S3iQjfr+0Xn/giQ0F4Fcux1nqiGtO7GA2V4ywlcO0/
	YfV0qBhybBtgMwdEawt+DOihXf+OTd4Ikp3SFc83HLBHuA6RG1Peltt2VnixUuNLhUo0rO9cV/N
	mQlYViAJwrynO5KglSkLbZC1SOQmzTnvqej8xSVw7w0/6KX6CWh
X-Google-Smtp-Source: AGHT+IHnIHtF2qzsUAy84w9INuHabsV2StfM6k9CccIqh4w5X+PX/yHdHb7SF224RLo5vdd62N/PQw==
X-Received: by 2002:a05:6000:4008:b0:382:4abd:c3c9 with SMTP id ffacd0b85a97d-385c682052emr2879532f8f.7.1732714983771;
        Wed, 27 Nov 2024 05:43:03 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6829:901:9ff7:e7c5:5e0f:c5ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5fa2sm16804645f8f.1.2024.11.27.05.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:43:03 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com,
	james.clark@arm.com,
	Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 4/9] coresight: configfs: Add static type for config attributes
Date: Wed, 27 Nov 2024 13:42:51 +0000
Message-Id: <20241127134256.2254851-5-mike.leach@linaro.org>
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

Add in a static attribute ci_type and remove dynamic generated ci_type in
preparation for adding in new attributes.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-syscfg-configfs.c       | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
index d0aaecb0f4c7..83da4820be6d 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -790,14 +790,20 @@ static void cscfg_destroy_feature_group(struct config_group *feat_group)
 	kfree(feat_view);
 }
 
-static struct config_item_type cscfg_configs_type = {
+
+static struct config_item_type cscfg_configs_load_type = {
+	.ct_owner = THIS_MODULE,
+};
+
+/* configurations group */
+static struct config_item_type cscfg_configs_grp_type = {
 	.ct_owner = THIS_MODULE,
 };
 
 static struct config_group cscfg_configs_grp = {
 	.cg_item = {
 		.ci_namebuf = "configurations",
-		.ci_type = &cscfg_configs_type,
+		.ci_type = &cscfg_configs_grp_type,
 	},
 };
 
@@ -867,15 +873,10 @@ void cscfg_configfs_del_feature(struct cscfg_feature_desc *feat_desc)
 int cscfg_configfs_init(struct cscfg_manager *cscfg_mgr)
 {
 	struct configfs_subsystem *subsys;
-	struct config_item_type *ci_type;
 
 	if (!cscfg_mgr)
 		return -EINVAL;
 
-	ci_type = cscfg_create_ci_type();
-	if (!ci_type)
-		return -ENOMEM;
-
 	/* dyncamic load and unload initially disabled */
 	cscfg_dyn_load_enabled = false;
 
@@ -884,7 +885,7 @@ int cscfg_configfs_init(struct cscfg_manager *cscfg_mgr)
 
 	subsys = &cscfg_mgr->cfgfs_subsys;
 	config_item_set_name(&subsys->su_group.cg_item, CSCFG_FS_SUBSYS_NAME);
-	subsys->su_group.cg_item.ci_type = ci_type;
+	subsys->su_group.cg_item.ci_type = &cscfg_configs_load_type;
 
 	config_group_init(&subsys->su_group);
 	mutex_init(&subsys->su_mutex);
-- 
2.25.1


