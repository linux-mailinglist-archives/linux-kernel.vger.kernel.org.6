Return-Path: <linux-kernel+bounces-423523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557D09DA8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156172824B7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E9A1FCFD9;
	Wed, 27 Nov 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TmAcDJRz"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2C1FCF74
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714985; cv=none; b=msDe0e27R8b4frGERmFycEx0Tjgz+zevl6K+zz9ukuBJxRixcZEVh1ZVjty4BhA1OV3xUblhHHC9yaucicJupotaPHumyGZxbD6vLEarY4dT8o8Phw4h2mKaL9QB8XgI/NIxcSpoxdhiPDeXx5O0VRKM0c/MlsHgO9P4974z/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714985; c=relaxed/simple;
	bh=d9O4E1eCJUeYe6MNqeJOsmL4aDt7l0VgmbNT/ZslYvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QB4BRv34UJwcBF5dyb2uLcVLPdDuGulWBgQCP6nqUZKn2r5dAb5o7V2dYZaJDtOKafM688Rkd7hY9qiWk3GV+6nn4a2aq1G7Bvw6Knue0bDAywstG7o16nqakSvBkXV6Uk81yMjnLLd/0rbIuvK4O6snjBbFR/GZU4czwPAAjX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TmAcDJRz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434aa472617so7087625e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732714982; x=1733319782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyZuZfXEwO8d6lRLKEFPF6ZWKWzWzABGPH32iU5IC2w=;
        b=TmAcDJRzPfy5d980IyAWj56OS4xtTu5uSgen3Miz/3Ao4EgbmAZ7SJbR7IEgCeE3j1
         qcoTMFyT3sQgeX13Pfwu1uxjF5bg10TsmCRrMWCj3lMDIPcwmsOZPjqS+ar5xlO3xsLJ
         I71XROuyYnJAQ+/F++9QFihSM3t8LEAtLytcFrcy56lgFqq0BRvt5ibkGm+dBEmxQ2Nd
         CWIDby74m6XkBmmeKVPuTu5nMBonXG5KLgZnltIilhJfN++XDPVYlpHgfxr6t0JlhxYe
         IRJKYJwITsqyJLZYOeFUuXGgALA76tZMTyVfACP7TcByw7UydHGtb6SIheww1pi/qYJ6
         mu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732714982; x=1733319782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyZuZfXEwO8d6lRLKEFPF6ZWKWzWzABGPH32iU5IC2w=;
        b=g8Q6C012PQS5ABnpS8rtsSPi4tI31hkPPW1/Bi+OV1edllJfgjtYvfKSzv0IhEK3DN
         jEGDAyO+TpUIwMal695kvQjvJsuSx6ULozA+5FVOM9uMv2e+AG/Ppi4qAqJfD56BcWpl
         k2AsfEOM7TWygPdiu1mq3fiNewkz8Bckfa5uoPI53m/I0yi46/7mWfaFVQ2gkInri3ms
         VJhDDYG6UG5VnqV/Yi2eXL8TqEPDl3LbY3oz1TPWjSNiWwkDWWfeDVW9qhosDyNTkTYV
         HCOtTGOQTJC7/JXWDnayBlm8wHA7EjnWkRxo0CKK0rl4HCYuU+2TZxkU+zep80BE0kR1
         OPcw==
X-Forwarded-Encrypted: i=1; AJvYcCUehIpBMLPHYHnxKm8bPNqAyJ0EkoiZLwW0lV7I1B68fqTRECF/tYZBEpdxYdm/a+8BW1P5FbI5nY3c55k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywso+MKJP05hydijZmF2ZAGOWXsriTU7iFhdZMyOtq2q14CAEd/
	X/z8nyuyQuAOS3gFmVzxy+5EFWcixdgbcCKba8gdDy8ocAelhn4nqVt1EiNUf4w=
X-Gm-Gg: ASbGncss0Y5fRI4MnBg5hNVGfvq/bb3QDbDw7TNduNFpqcgPQvwa/BgeWEgMa6EL63a
	ykg+aFPqFZM4S1u0biviXurT0tgB9FCw9C3DKkXJc0zg8TpRIHnRvYRJ1B17QHf0ixEy4XH5bJb
	sCgAKopIsSORZFvt5sp7kY9Pq4uLUxTePNRAPjmSibgq3XAuyxspqDmvS9vU4taNK4i2EQeXKPk
	ieC13tHBYbr8eq47k+lso5LIMGMjafCmU+i/fMjhFS6jdtz/3t8
X-Google-Smtp-Source: AGHT+IGBVYI2t/KGowZk4skZcgBiYypH1fP6FHAu95XaFsNOk9JsQ26I9KCwHiJ4umfksH9uVkQHgw==
X-Received: by 2002:a05:600c:6d46:b0:434:a5d1:9917 with SMTP id 5b1f17b1804b1-434a9de4533mr23641915e9.21.1732714981728;
        Wed, 27 Nov 2024 05:43:01 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6829:901:9ff7:e7c5:5e0f:c5ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5fa2sm16804645f8f.1.2024.11.27.05.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:43:01 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com,
	james.clark@arm.com,
	Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 2/9] coresight: configfs: Update memory allocation / free for configfs elements
Date: Wed, 27 Nov 2024 13:42:49 +0000
Message-Id: <20241127134256.2254851-3-mike.leach@linaro.org>
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

Previously, the objects backing the configfs directories and files were
created using devm managed memory on the coresight device.

Now we are adding configfs load/unload, configurations can be loaded
many times over the lifetime of the device, so it is more appropriate to
use normally allocated and freed memory.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-syscfg-configfs.c     | 119 +++++++++++++-----
 1 file changed, 88 insertions(+), 31 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
index 433ede94dd63..6e8c8db52d39 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -14,7 +14,7 @@ static inline struct config_item_type *cscfg_create_ci_type(void)
 {
 	struct config_item_type *ci_type;
 
-	ci_type = devm_kzalloc(cscfg_device(), sizeof(*ci_type), GFP_KERNEL);
+	ci_type = kzalloc(sizeof(*ci_type), GFP_KERNEL);
 	if (ci_type)
 		ci_type->ct_owner = THIS_MODULE;
 
@@ -175,6 +175,19 @@ static struct config_item_type cscfg_config_preset_type = {
 	.ct_attrs = cscfg_config_preset_attrs,
 };
 
+
+/* walk list of presets and free the previously allocated memory */
+static void cscfg_destroy_preset_groups(struct config_group *cfg_view_group)
+{
+	struct cscfg_fs_preset *cfg_fs_preset;
+	struct config_group *p_group;
+
+	list_for_each_entry(p_group, &cfg_view_group->default_groups, default_groups) {
+		cfg_fs_preset = container_of(p_group, struct cscfg_fs_preset, group);
+		kfree(cfg_fs_preset);
+	}
+}
+
 static int cscfg_add_preset_groups(struct cscfg_fs_config *cfg_view)
 {
 	int preset_num;
@@ -186,11 +199,12 @@ static int cscfg_add_preset_groups(struct cscfg_fs_config *cfg_view)
 		return 0;
 
 	for (preset_num = 1; preset_num <= config_desc->nr_presets; preset_num++) {
-		cfg_fs_preset = devm_kzalloc(cscfg_device(),
-					     sizeof(struct cscfg_fs_preset), GFP_KERNEL);
+		cfg_fs_preset = kzalloc(sizeof(struct cscfg_fs_preset), GFP_KERNEL);
 
-		if (!cfg_fs_preset)
+		if (!cfg_fs_preset) {
+			cscfg_destroy_preset_groups(&cfg_view->group);
 			return -ENOMEM;
+		}
 
 		snprintf(name, CONFIGFS_ITEM_NAME_LEN, "preset%d", preset_num);
 		cfg_fs_preset->preset_num = preset_num;
@@ -204,14 +218,10 @@ static int cscfg_add_preset_groups(struct cscfg_fs_config *cfg_view)
 
 static struct config_group *cscfg_create_config_group(struct cscfg_config_desc *config_desc)
 {
-	struct cscfg_fs_config *cfg_view;
-	struct device *dev = cscfg_device();
+	struct cscfg_fs_config *cfg_view = NULL;
 	int err;
 
-	if (!dev)
-		return ERR_PTR(-EINVAL);
-
-	cfg_view = devm_kzalloc(dev, sizeof(struct cscfg_fs_config), GFP_KERNEL);
+	cfg_view = kzalloc(sizeof(struct cscfg_fs_config), GFP_KERNEL);
 	if (!cfg_view)
 		return ERR_PTR(-ENOMEM);
 
@@ -220,12 +230,21 @@ static struct config_group *cscfg_create_config_group(struct cscfg_config_desc *
 
 	/* add in a preset<n> dir for each preset */
 	err = cscfg_add_preset_groups(cfg_view);
-	if (err)
+	if (err) {
+		kfree(cfg_view);
 		return ERR_PTR(err);
-
+	}
 	return &cfg_view->group;
 }
 
+static void cscfg_destroy_config_group(struct config_group *group)
+{
+	struct cscfg_fs_config *cfg_view = container_of(group, struct cscfg_fs_config, group);
+
+	cscfg_destroy_preset_groups(&cfg_view->group);
+	kfree(cfg_view);
+}
+
 /* attributes for features view */
 
 static ssize_t cscfg_feat_description_show(struct config_item *item, char *page)
@@ -314,6 +333,17 @@ static struct config_item_type cscfg_param_view_type = {
 	.ct_attrs = cscfg_param_view_attrs,
 };
 
+/* walk the list of default groups - which were set as param items and remove */
+static void cscfg_destroy_params_group_items(struct config_group *params_group)
+{
+	struct cscfg_fs_param *param_item;
+	struct config_group *p_group;
+
+	list_for_each_entry(p_group, &params_group->default_groups, default_groups) {
+		param_item = container_of(p_group, struct cscfg_fs_param, group);
+		kfree(param_item);
+	}
+}
 /*
  * configfs has far less functionality provided to add attributes dynamically than sysfs,
  * and the show and store fns pass the enclosing config_item so the actual attribute cannot
@@ -322,15 +352,16 @@ static struct config_item_type cscfg_param_view_type = {
 static int cscfg_create_params_group_items(struct cscfg_feature_desc *feat_desc,
 					   struct config_group *params_group)
 {
-	struct device *dev = cscfg_device();
 	struct cscfg_fs_param *param_item;
 	int i;
 
 	/* parameter items - as groups with default_value attribute */
 	for (i = 0; i < feat_desc->nr_params; i++) {
-		param_item = devm_kzalloc(dev, sizeof(struct cscfg_fs_param), GFP_KERNEL);
-		if (!param_item)
+		param_item = kzalloc(sizeof(struct cscfg_fs_param), GFP_KERNEL);
+		if (!param_item) {
+			cscfg_destroy_params_group_items(params_group);
 			return -ENOMEM;
+		}
 		param_item->feat_desc = feat_desc;
 		param_item->param_idx = i;
 		config_group_init_type_name(&param_item->group,
@@ -343,27 +374,22 @@ static int cscfg_create_params_group_items(struct cscfg_feature_desc *feat_desc,
 
 static struct config_group *cscfg_create_feature_group(struct cscfg_feature_desc *feat_desc)
 {
-	struct cscfg_fs_feature *feat_view;
-	struct config_item_type *params_group_type;
+	struct cscfg_fs_feature *feat_view = NULL;
+	struct config_item_type *params_group_type = NULL;
 	struct config_group *params_group = NULL;
-	struct device *dev = cscfg_device();
-	int item_err;
-
-	if (!dev)
-		return ERR_PTR(-EINVAL);
+	int err = -ENOMEM;
 
-	feat_view = devm_kzalloc(dev, sizeof(struct cscfg_fs_feature), GFP_KERNEL);
+	feat_view = kzalloc(sizeof(struct cscfg_fs_feature), GFP_KERNEL);
 	if (!feat_view)
 		return ERR_PTR(-ENOMEM);
 
 	if (feat_desc->nr_params) {
-		params_group = devm_kzalloc(dev, sizeof(struct config_group), GFP_KERNEL);
+		params_group = kzalloc(sizeof(struct config_group), GFP_KERNEL);
 		if (!params_group)
-			return ERR_PTR(-ENOMEM);
-
+			goto exit_err_free_mem;
 		params_group_type = cscfg_create_ci_type();
 		if (!params_group_type)
-			return ERR_PTR(-ENOMEM);
+			goto exit_err_free_mem;
 	}
 
 	feat_view->feat_desc = feat_desc;
@@ -373,11 +399,36 @@ static struct config_group *cscfg_create_feature_group(struct cscfg_feature_desc
 	if (params_group) {
 		config_group_init_type_name(params_group, "params", params_group_type);
 		configfs_add_default_group(params_group, &feat_view->group);
-		item_err = cscfg_create_params_group_items(feat_desc, params_group);
-		if (item_err)
-			return ERR_PTR(item_err);
+		err = cscfg_create_params_group_items(feat_desc, params_group);
+		if (err)
+			goto exit_err_free_mem;
 	}
 	return &feat_view->group;
+
+exit_err_free_mem:
+	kfree(feat_view);
+	kfree(params_group_type);
+	kfree(params_group);
+	return ERR_PTR(err);
+}
+
+static void cscfg_destroy_feature_group(struct config_group *feat_group)
+{
+	struct cscfg_fs_feature *feat_view;
+	struct config_group *params_group = NULL;
+
+	feat_view = container_of(feat_group, struct cscfg_fs_feature, group);
+
+	/* params group is the first item on the default group list */
+	if (!list_empty(&feat_group->default_groups)) {
+		params_group = list_first_entry(&feat_group->default_groups,
+						struct config_group, default_groups);
+		cscfg_destroy_params_group_items(params_group);
+		/* free the item type, then the group */
+		kfree(params_group->cg_item.ci_type);
+		kfree(params_group);
+	}
+	kfree(feat_view);
 }
 
 static struct config_item_type cscfg_configs_type = {
@@ -403,6 +454,8 @@ int cscfg_configfs_add_config(struct cscfg_config_desc *config_desc)
 	err =  configfs_register_group(&cscfg_configs_grp, new_group);
 	if (!err)
 		config_desc->fs_group = new_group;
+	else
+		cscfg_destroy_config_group(new_group);
 	return err;
 }
 
@@ -410,6 +463,7 @@ void cscfg_configfs_del_config(struct cscfg_config_desc *config_desc)
 {
 	if (config_desc->fs_group) {
 		configfs_unregister_group(config_desc->fs_group);
+		cscfg_destroy_config_group(config_desc->fs_group);
 		config_desc->fs_group = NULL;
 	}
 }
@@ -434,9 +488,11 @@ int cscfg_configfs_add_feature(struct cscfg_feature_desc *feat_desc)
 	new_group = cscfg_create_feature_group(feat_desc);
 	if (IS_ERR(new_group))
 		return PTR_ERR(new_group);
-	err =  configfs_register_group(&cscfg_features_grp, new_group);
+	err = configfs_register_group(&cscfg_features_grp, new_group);
 	if (!err)
 		feat_desc->fs_group = new_group;
+	else
+		cscfg_destroy_feature_group(new_group);
 	return err;
 }
 
@@ -444,6 +500,7 @@ void cscfg_configfs_del_feature(struct cscfg_feature_desc *feat_desc)
 {
 	if (feat_desc->fs_group) {
 		configfs_unregister_group(feat_desc->fs_group);
+		cscfg_destroy_feature_group(feat_desc->fs_group);
 		feat_desc->fs_group = NULL;
 	}
 }
-- 
2.25.1


