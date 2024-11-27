Return-Path: <linux-kernel+bounces-423525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D459DA8DE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCFCBB2488B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17A51FDE1E;
	Wed, 27 Nov 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L99asXYp"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D81FCFCE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732714988; cv=none; b=nMfyRhv3pZyhTlGz/m0yEOLilLQPEFrlNyVcv1j4Bfi5KL3aZSe7+wmxemr21FqfbS/jfBtrhcc+hANE2FCQ6V8o/F9wJKuRGQE8SWiGVocAOeJjCzRhh1NcpVV60998Ooyyny3aO+fngVHOtxgjS/hlRFeXGA1Umn/mfQIsxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732714988; c=relaxed/simple;
	bh=vukTZa9XOwMb5eNo/a6kUVG96iSGKafAmMoX92L81fU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pne+DcApbT7s0N9WP6dC64dXpdQ5kn8h3GZyMsryQeUDpF4M9LBe4FqVB9VR7aG3taG8nFH5CKpHMworDYhqTDZvbjjBe+Rvn/O5ViTu5RmJg9d3SYaYrQAQbL7sysFStOf0ywKTikqUD8yEDsiSkfkokYN4MlxS2SuaAN20tNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L99asXYp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3824a089b2cso4139390f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732714984; x=1733319784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ITMOLuXbwxTSugO6IH6IP9VkXl8XSoFNARYxodcSSA=;
        b=L99asXYpP1FZ17qXQ8BKit5psujpRKdHcX4izX738Mz0f8yEUUJpnK8j343/Cj/8kh
         ea5aUExNMG/MzjLKAZe2ovM5qxFfdk41PtgOs9qzGyccxxyziqmcU24Eys1js+RjYI0+
         EwEyu+fyr0rlVhxk/qDdvQA/azLhsk/5kBXkRA6l0KlxqIdJKjT8EJ3AbmqKL/AEBRp8
         eZJv8Fqa4GlBbWJJkITsWPapEm+Hx5W+Tzm8ZuQseeu/ae6K4ZIGNRD6TmmzLyf51Bo2
         f8M27iUA/R/Tp+mh/MbaRtkHub/OOG29w4kmNMO/CtWbw21cd3Xwmwp/BKePaehwDydW
         usrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732714984; x=1733319784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ITMOLuXbwxTSugO6IH6IP9VkXl8XSoFNARYxodcSSA=;
        b=J9AlzwbLN1eJdeRmeXLZQi8v3joAuKKsvxe+xQnaKts2b0W4p4kN9gFxKSMVlLrhVd
         ru54ydLUmwHyf0n1uzqm7usCI+CTAGvfdCjsqk2isNstT89NMJK5GMNCAp5sdsvOsXzo
         TfdbFZgD7Qz/KNz4KKy68d5awJvypgVo5MZC9doYjWNLNmhnpdVBYet13QnTnEkK2P/S
         9+S+jJE9R6wzS2f4k8tfXam2yPmklwBOgcbAwC6W5Ge3dtPFG/YVBJoomjTRBIV6Q9Gz
         AxpVmK98gOtCMjqgrztfb95HI6ircioht4kmtzXFTStJdVv7mahzTtEIvc8jpEPvfvGU
         ghkA==
X-Forwarded-Encrypted: i=1; AJvYcCWV8GASXU3fejITthNBD7Ur8g6eHjAWkLUhwgIvYUmZFN80vDeaUC+x9XorFua82vvjpfKClogu2Dp9h9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJgTlqm/0sWpFr8fL1kuVIYbqOZpRbJuc1Nfr6l5zwNZA9U2/
	jiIKd/oVwDycrZS6+fvdBzlqrgE+tCtlNZzixC+DmV7y7FpYDn1UlpzBf3K8YkA=
X-Gm-Gg: ASbGncsHDY67ZV1zw4OJmR+dwrI/x8QhMsjgVLO/oOn8fF6TNZtUstvAt+lZSaUT4ie
	tBoeEuRqxoz2gqKq6NQmrk3WNbd15Gnp11f9Jah0eB2484P0rlUZOStuHLcwgKypx9mx8AOyM8M
	ei7HUYcVhv4fKmnW0pzXy43Yk+gBkr4wwc/czYkwzpEKDkf7xt1Vi3p6r1Ey+J78EFu6I7wWWnL
	RKkN0xaMm/bSwzsjT5W2SUJ+HxuZAH80n5jUKnmsco4H3MMUkp/
X-Google-Smtp-Source: AGHT+IFV2jJmdKrtGXDNBn0faBCdSKKOm2jok/QDUilDkRPeSOsI7kb8yVZCyBno96tZfMHWgdo/dw==
X-Received: by 2002:a05:6000:491a:b0:385:bc42:52e4 with SMTP id ffacd0b85a97d-385c6eba8bemr2618099f8f.24.1732714982786;
        Wed, 27 Nov 2024 05:43:02 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6829:901:9ff7:e7c5:5e0f:c5ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5fa2sm16804645f8f.1.2024.11.27.05.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:43:02 -0800 (PST)
From: Mike Leach <mike.leach@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com,
	james.clark@arm.com,
	Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v7 3/9] coresight: config: API to dynamically load / unload config tables
Date: Wed, 27 Nov 2024 13:42:50 +0000
Message-Id: <20241127134256.2254851-4-mike.leach@linaro.org>
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

Add API functions and helpers to runtime / dynamically load and unload
configuration tables.

Provides locking to ensure simutaneous load / unload from different
sources cannot occur.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 .../coresight/coresight-syscfg-configfs.c     | 365 ++++++++++++++++++
 .../hwtracing/coresight/coresight-syscfg.c    | 103 ++++-
 .../hwtracing/coresight/coresight-syscfg.h    |  19 +-
 3 files changed, 480 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
index 6e8c8db52d39..d0aaecb0f4c7 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg-configfs.c
@@ -5,10 +5,369 @@
  */
 
 #include <linux/configfs.h>
+#include <linux/module.h>
+#include <linux/workqueue.h>
 
 #include "coresight-config.h"
+#include "coresight-config-table.h"
 #include "coresight-syscfg-configfs.h"
 
+/* prevent race in load / unload operations */
+static DEFINE_MUTEX(cfs_mutex);
+
+/*
+ * need to enable / disable dynamic table load when
+ * initialising / shutting down the subsystem, or
+ * loading / unloading configurations via module.
+ */
+static bool cscfg_dyn_load_enabled;
+
+/*
+ * Lockdep issues occur if deleting the config directory as part
+ * of the unload operation triggered by configfs.
+ * Therefore we schedule the main part of the unload to be completed as a work item
+ * & save the owner info for the scheduled unload
+ */
+static struct cscfg_load_owner_info *cscfg_sched_dyn_unload_owner;
+
+
+/* determine if load / unload ops are currently permitted. */
+inline bool cscfg_load_ops_permitted(void)
+{
+	return (cscfg_dyn_load_enabled && !cscfg_sched_dyn_unload_owner);
+}
+
+/* do the main unload operations. Called with cfs_mutex held */
+static int cscfg_do_unload(struct cscfg_load_owner_info *unload_owner)
+{
+	int err = 0;
+
+	if (!cscfg_dyn_load_enabled) {
+		pr_warn("cscfg: skipping unload completion\n");
+		return -EINVAL;
+	}
+
+	err = cscfg_unload_config_sets(unload_owner);
+	if (!err)
+		cscfg_free_dyn_load_owner_info(unload_owner);
+	else
+		pr_err("cscfg: dynamic configuration unload error\n");
+
+	return err;
+}
+
+/* complete the unload operation as work item  */
+static void cscfg_complete_unload(struct work_struct *work)
+{
+	mutex_lock(&cfs_mutex);
+
+	if (cscfg_sched_dyn_unload_owner)
+		cscfg_do_unload(cscfg_sched_dyn_unload_owner);
+	cscfg_sched_dyn_unload_owner = NULL;
+
+	mutex_unlock(&cfs_mutex);
+	kfree(work);
+}
+
+static int cscfg_schedule_unload(void)
+{
+	struct work_struct *work;
+
+	work = kzalloc(sizeof(struct work_struct), GFP_KERNEL);
+	if (!work)
+		return -ENOMEM;
+
+	INIT_WORK(work, cscfg_complete_unload);
+	schedule_work(work);
+	return 0;
+}
+
+/* create a string representing a loaded config based on owner info */
+static ssize_t cscfg_get_owner_info_str(struct cscfg_load_owner_info *owner_info,
+					char *buffer, ssize_t size)
+{
+	struct cscfg_table_load_descs *load_descs;
+	ssize_t size_used = 0;
+	int i;
+	static const char * const load_type[] = {
+		"Built in driver",
+		"Loadable module",
+		"Runtime Dynamic table load",
+	};
+
+	/* limited info for none dynamic loaded stuff */
+	if (owner_info->type != CSCFG_OWNER_DYNLOAD) {
+		size_used = scnprintf(buffer, size,
+				      "load name: [Not Set]\nload type: %s\n",
+				      load_type[owner_info->type]);
+		goto buffer_done;
+	}
+
+	/*  dynamic loaded type will have all the info */
+	load_descs = (struct cscfg_table_load_descs *)owner_info->owner_handle;
+
+	/* first is the load name and type - need for unload request */
+	size_used = scnprintf(buffer, size, "load name: %s\nload type: %s\n",
+				      load_descs->load_name,
+				      load_type[owner_info->type]);
+
+	/* list of configurations loaded by this owner element */
+	size_used += scnprintf(buffer + size_used, size - size_used,
+			       "(configurations: ");
+	if (!(size_used < size))
+		goto buffer_done;
+
+	if (!load_descs->config_descs[0]) {
+		size_used += scnprintf(buffer + size_used, size - size_used,
+				       " None )\n");
+		if (!(size_used < size))
+			goto buffer_done;
+	} else {
+		i = 0;
+		while (load_descs->config_descs[i] && (size_used < size)) {
+			size_used += scnprintf(buffer + size_used,
+					       size - size_used, " %s",
+					       load_descs->config_descs[i]->name);
+			i++;
+		}
+		size_used +=
+			scnprintf(buffer + size_used, size - size_used, " )\n");
+	}
+	if (!(size_used < size))
+		goto buffer_done;
+
+	/* list of features loaded by this owner element */
+	size_used += scnprintf(buffer + size_used, size - size_used, "(features: ");
+	if (!(size_used < size))
+		goto buffer_done;
+
+	if (!load_descs->feat_descs[0]) {
+		size_used +=
+			scnprintf(buffer + size_used, size - size_used, " None )\n");
+		if (!(size_used < size))
+			goto buffer_done;
+	} else {
+		i = 0;
+		while (load_descs->feat_descs[i] && (size_used < size)) {
+			size_used += scnprintf(buffer + size_used,
+					       size - size_used, " %s",
+					       load_descs->feat_descs[i]->name);
+			i++;
+		}
+		size_used +=
+			scnprintf(buffer + size_used, size - size_used, " )\n");
+	}
+
+	/* done or buffer full */
+buffer_done:
+	return size_used;
+}
+
+void cscfg_enable_dyn_load(void)
+{
+	mutex_lock(&cfs_mutex);
+	cscfg_dyn_load_enabled = true;
+	mutex_unlock(&cfs_mutex);
+}
+
+/* disable dynamic load / unload if no current unload scheduled */
+bool cscfg_disable_dyn_load(void)
+{
+	mutex_lock(&cfs_mutex);
+	if (!cscfg_sched_dyn_unload_owner)
+		cscfg_dyn_load_enabled = false;
+	mutex_unlock(&cfs_mutex);
+	return !cscfg_dyn_load_enabled;
+}
+
+void cscfg_at_exit_dyn_load(void)
+{
+	mutex_lock(&cfs_mutex);
+	cscfg_dyn_load_enabled = false;
+	cscfg_sched_dyn_unload_owner = NULL;
+	mutex_unlock(&cfs_mutex);
+}
+
+
+struct cscfg_load_owner_info *cscfg_create_dyn_load_owner_info(void)
+{
+	struct cscfg_table_load_descs *load_descs = 0;
+	struct cscfg_load_owner_info *owner_info = 0;
+
+	load_descs = kzalloc(sizeof(struct cscfg_table_load_descs), GFP_KERNEL);
+	if (!load_descs)
+		return owner_info;
+
+	owner_info = kzalloc(sizeof(struct cscfg_load_owner_info), GFP_KERNEL);
+	if (owner_info) {
+		owner_info->owner_handle = load_descs;
+		owner_info->type = CSCFG_OWNER_DYNLOAD;
+	} else
+		kfree(load_descs);
+
+	return owner_info;
+}
+
+/* free memory associated with a dynamically loaded configuration & descriptors */
+void cscfg_free_dyn_load_owner_info(struct cscfg_load_owner_info *owner_info)
+{
+	struct cscfg_table_load_descs *load_descs = 0;
+
+	if (!owner_info)
+		return;
+
+	if (owner_info->type != CSCFG_OWNER_DYNLOAD)
+		return;
+
+	load_descs = (struct cscfg_table_load_descs *)(owner_info->owner_handle);
+
+	if (load_descs) {
+		/* free the data allocated on table load, pointed to by load_descs */
+		cscfg_table_free_load_descs(load_descs);
+		kfree(load_descs);
+	}
+
+	kfree(owner_info);
+}
+
+/* return load name if dynamic load owned element */
+const char *cscfg_get_dyn_load_name(struct cscfg_load_owner_info *owner_info)
+{
+	const char *name = "unknown";
+	struct cscfg_table_load_descs *load_descs;
+
+	if (!owner_info)
+		return name;
+
+	load_descs = (struct cscfg_table_load_descs *)(owner_info->owner_handle);
+	if (owner_info->type == CSCFG_OWNER_DYNLOAD)
+		return load_descs->load_name;
+
+	return name;
+}
+
+/*
+ * Dynamic load and unload configuration table API
+ */
+
+/* dynamically load a configuration and features from a config table
+ */
+int cscfg_dyn_load_cfg_table(const void *table, size_t table_size)
+{
+	struct cscfg_table_load_descs *load_descs = 0;
+	struct cscfg_load_owner_info *owner_info = 0;
+	int err = -EINVAL;
+
+	/* ensure we cannot simultaneously load and unload */
+	if (!mutex_trylock(&cfs_mutex)) {
+		err = -EBUSY;
+		goto exit_unlock;
+	}
+
+	/* check configfs load / unload ops are permitted */
+	if (!cscfg_load_ops_permitted()) {
+		err = -EBUSY;
+		goto exit_unlock;
+	}
+
+	if (table_size > CSCFG_TABLE_MAXSIZE) {
+		pr_err("cscfg: Load error - Input file too large.\n");
+		goto exit_unlock;
+	}
+
+	/* create owner info as dyn load type with descriptor tables to be filled */
+	owner_info = cscfg_create_dyn_load_owner_info();
+	if (owner_info)
+		load_descs = (struct cscfg_table_load_descs *)(owner_info->owner_handle);
+	else {
+		err = -ENOMEM;
+		goto exit_unlock;
+	}
+
+	/* convert table into internal data structures */
+	err = cscfg_table_read_buffer(table, table_size, load_descs);
+	if (err) {
+		pr_err("cscfg: Load error - Failed to read input buffer.\n");
+		goto exit_memfree;
+	}
+
+	err = cscfg_load_config_sets(load_descs->config_descs, load_descs->feat_descs, owner_info);
+	if (err) {
+		pr_err("cscfg: Load error - Failed to load configuaration table.\n");
+		goto exit_memfree;
+	}
+
+	/* load success */
+	goto exit_unlock;
+
+exit_memfree:
+	/* frees up owner_info and load_descs */
+	cscfg_free_dyn_load_owner_info(owner_info);
+
+exit_unlock:
+	mutex_unlock(&cfs_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(cscfg_dyn_load_cfg_table);
+
+/*
+ * schedule the unload of the last dynamically loaded table.
+ * load / unload ordering is strictly enforced.
+ */
+int cscfg_sched_dyn_unload_cfg_table(void)
+{
+	struct cscfg_load_owner_info *owner_info = 0;
+	int err = -EINVAL;
+
+	/* ensure we cannot simultaneously load and unload */
+	if (!mutex_trylock(&cfs_mutex)) {
+		err = -EBUSY;
+		goto exit_unlock;
+	}
+
+	/* check dyn load / unload ops are permitted & no ongoing unload */
+	if (!cscfg_load_ops_permitted()) {
+		err = -EBUSY;
+		goto exit_unlock;
+	}
+
+	/* find the last loaded owner info block */
+	owner_info = cscfg_find_last_loaded_cfg_owner();
+	if (!owner_info) {
+		pr_err("cscfg: Unload error: Failed to find any loaded configuration\n");
+		goto exit_unlock;
+	}
+
+	if (owner_info->type != CSCFG_OWNER_DYNLOAD) {
+		pr_err("cscfg: Unload error: Last loaded configuration not dynamic loaded item\n");
+		goto exit_unlock;
+	}
+
+	/* set cscfg state as starting an unload operation */
+	err = cscfg_set_unload_start();
+	if (err) {
+		pr_err("Config unload %s: failed to set unload start flag\n",
+		       cscfg_get_dyn_load_name(owner_info));
+		goto exit_unlock;
+	}
+
+	/*
+	 * actual unload is scheduled as a work item to avoid
+	 * lockdep issues when triggered from configfs
+	 */
+	cscfg_sched_dyn_unload_owner = owner_info;
+	err = cscfg_schedule_unload();
+
+exit_unlock:
+	mutex_unlock(&cfs_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(cscfg_sched_dyn_unload_cfg_table);
+
+/*
+ * configfs object and directory operations
+ */
+
 /* create a default ci_type. */
 static inline struct config_item_type *cscfg_create_ci_type(void)
 {
@@ -517,6 +876,12 @@ int cscfg_configfs_init(struct cscfg_manager *cscfg_mgr)
 	if (!ci_type)
 		return -ENOMEM;
 
+	/* dyncamic load and unload initially disabled */
+	cscfg_dyn_load_enabled = false;
+
+	/* no current scheduled unload operation in progress */
+	cscfg_sched_dyn_unload_owner = NULL;
+
 	subsys = &cscfg_mgr->cfgfs_subsys;
 	config_item_set_name(&subsys->su_group.cg_item, CSCFG_FS_SUBSYS_NAME);
 	subsys->su_group.cg_item.ci_type = ci_type;
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.c b/drivers/hwtracing/coresight/coresight-syscfg.c
index 11138a9762b0..6379e29a3aa0 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.c
+++ b/drivers/hwtracing/coresight/coresight-syscfg.c
@@ -554,6 +554,23 @@ static int cscfg_fs_register_cfgs_feats(struct cscfg_config_desc **config_descs,
 	return 0;
 }
 
+/*
+ * check owner info and if module owner, disable / enable
+ * configfs managed dynamic load ops to prevent parallel load attempts.
+ */
+static bool cscfg_check_disable_dyn_load(struct cscfg_load_owner_info *owner_info)
+{
+	if (owner_info->type == CSCFG_OWNER_MODULE)
+		return cscfg_disable_dyn_load();
+	return true;
+}
+
+static void cscfg_check_enable_dyn_load(struct cscfg_load_owner_info *owner_info)
+{
+	if (owner_info->type == CSCFG_OWNER_MODULE)
+		cscfg_enable_dyn_load();
+}
+
 /**
  * cscfg_load_config_sets - API function to load feature and config sets.
  *
@@ -578,10 +595,14 @@ int cscfg_load_config_sets(struct cscfg_config_desc **config_descs,
 {
 	int err = 0;
 
+	/* if this load is by module owner, need to disable dynamic load/unload */
+	if (!cscfg_check_disable_dyn_load(owner_info))
+		return -EBUSY;
+
 	mutex_lock(&cscfg_mutex);
 	if (cscfg_mgr->load_state != CSCFG_NONE) {
-		mutex_unlock(&cscfg_mutex);
-		return -EBUSY;
+		err = -EBUSY;
+		goto exit_unlock;
 	}
 	cscfg_mgr->load_state = CSCFG_LOAD;
 
@@ -616,7 +637,7 @@ int cscfg_load_config_sets(struct cscfg_config_desc **config_descs,
 
 	/* mark any new configs as available for activation */
 	cscfg_set_configs_available(config_descs);
-	goto exit_unlock;
+	goto exit_clear_state;
 
 err_clean_cfs:
 	/* cleanup after error registering with configfs */
@@ -631,9 +652,13 @@ int cscfg_load_config_sets(struct cscfg_config_desc **config_descs,
 err_clean_load:
 	cscfg_unload_owned_cfgs_feats(owner_info);
 
-exit_unlock:
+exit_clear_state:
 	cscfg_mgr->load_state = CSCFG_NONE;
+
+exit_unlock:
 	mutex_unlock(&cscfg_mutex);
+
+	cscfg_check_enable_dyn_load(owner_info);
 	return err;
 }
 EXPORT_SYMBOL_GPL(cscfg_load_config_sets);
@@ -659,8 +684,13 @@ int cscfg_unload_config_sets(struct cscfg_load_owner_info *owner_info)
 	int err = 0;
 	struct cscfg_load_owner_info *load_list_item = NULL;
 
+	/* if this unload is by module owner, need to disable dynamic load/unload */
+	if (!cscfg_check_disable_dyn_load(owner_info))
+		return -EBUSY;
+
 	mutex_lock(&cscfg_mutex);
-	if (cscfg_mgr->load_state != CSCFG_NONE) {
+	if ((cscfg_mgr->load_state != CSCFG_NONE) &&
+	    (cscfg_mgr->load_state != CSCFG_UNLOAD_START)) {
 		mutex_unlock(&cscfg_mutex);
 		return -EBUSY;
 	}
@@ -705,10 +735,43 @@ int cscfg_unload_config_sets(struct cscfg_load_owner_info *owner_info)
 exit_unlock:
 	cscfg_mgr->load_state = CSCFG_NONE;
 	mutex_unlock(&cscfg_mutex);
+
+	cscfg_check_enable_dyn_load(owner_info);
 	return err;
 }
 EXPORT_SYMBOL_GPL(cscfg_unload_config_sets);
 
+int cscfg_set_unload_start(void)
+{
+	int ret = 0;
+
+	mutex_lock(&cscfg_mutex);
+	if (cscfg_mgr->load_state != CSCFG_NONE)
+		ret = -EBUSY;
+	else
+		cscfg_mgr->load_state = CSCFG_UNLOAD_START;
+	mutex_unlock(&cscfg_mutex);
+
+	return ret;
+}
+
+/* find the last loaded config owner info */
+struct cscfg_load_owner_info *cscfg_find_last_loaded_cfg_owner(void)
+{
+	struct cscfg_load_owner_info *owner_info = NULL;
+
+	mutex_lock(&cscfg_mutex);
+
+	if (!list_empty(&cscfg_mgr->load_order_list))
+		owner_info = list_last_entry(&cscfg_mgr->load_order_list,
+					     struct cscfg_load_owner_info, item);
+
+
+	mutex_unlock(&cscfg_mutex);
+	return owner_info;
+
+}
+
 /* Handle coresight device registration and add configs and features to devices */
 
 /* iterate through config lists and load matching configs to device */
@@ -881,7 +944,7 @@ static int _cscfg_activate_config(unsigned long cfg_hash)
 	struct cscfg_config_desc *config_desc;
 	int err = -EINVAL;
 
-	if (cscfg_mgr->load_state == CSCFG_UNLOAD)
+	if (cscfg_mgr->load_state >= CSCFG_UNLOAD)
 		return -EBUSY;
 
 	list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
@@ -1206,6 +1269,7 @@ static int cscfg_create_device(void)
 static void cscfg_unload_cfgs_on_exit(void)
 {
 	struct cscfg_load_owner_info *owner_info = NULL;
+	bool free_dynload_owner = false;
 
 	/*
 	 * grab the mutex - even though we are exiting, some configfs files
@@ -1240,6 +1304,23 @@ static void cscfg_unload_cfgs_on_exit(void)
 			 */
 			pr_err("cscfg: ERROR: prior module failed to unload configuration\n");
 			goto list_remove;
+
+		case CSCFG_OWNER_DYNLOAD:
+			/*
+			 * dynamically loaded items may still be present if the user did not
+			 * unload them during the session. These have dynamically allocated
+			 * descriptor tables (unlike the two types above that are statically
+			 * allocated at compile time)
+			 */
+			pr_info("cscfg: unloading dynamically loaded configuration %s\n",
+				cscfg_get_dyn_load_name(owner_info));
+
+			/*
+			 * as this is not being unloaded by configfs, need to flag the
+			 * requirement to free up the owner info and descriptors.
+			 */
+			free_dynload_owner = true;
+			break;
 		}
 
 		/* remove from configfs - outside the scope of the list mutex */
@@ -1253,6 +1334,12 @@ static void cscfg_unload_cfgs_on_exit(void)
 list_remove:
 		/* remove from load order list */
 		list_del(&owner_info->item);
+
+		/*  dynamic loaded config, free memory now */
+		if (free_dynload_owner) {
+			cscfg_free_dyn_load_owner_info(owner_info);
+			free_dynload_owner = false;
+		}
 	}
 	mutex_unlock(&cscfg_mutex);
 }
@@ -1284,6 +1371,9 @@ int __init cscfg_init(void)
 	if (err)
 		goto exit_err;
 
+	/* can now allow dynamic table load / unload */
+	cscfg_enable_dyn_load();
+
 	dev_info(cscfg_device(), "CoreSight Configuration manager initialised");
 	return 0;
 
@@ -1294,5 +1384,6 @@ int __init cscfg_init(void)
 
 void cscfg_exit(void)
 {
+	cscfg_at_exit_dyn_load();
 	cscfg_clear_device();
 }
diff --git a/drivers/hwtracing/coresight/coresight-syscfg.h b/drivers/hwtracing/coresight/coresight-syscfg.h
index 66e2db890d82..ba137b092992 100644
--- a/drivers/hwtracing/coresight/coresight-syscfg.h
+++ b/drivers/hwtracing/coresight/coresight-syscfg.h
@@ -20,7 +20,8 @@
 enum cscfg_load_ops {
 	CSCFG_NONE,
 	CSCFG_LOAD,
-	CSCFG_UNLOAD
+	CSCFG_UNLOAD,
+	CSCFG_UNLOAD_START, /* unload started by fs, will be completed later */
 };
 
 /**
@@ -79,6 +80,7 @@ struct cscfg_registered_csdev {
 enum cscfg_load_owner_type {
 	CSCFG_OWNER_PRELOAD,
 	CSCFG_OWNER_MODULE,
+	CSCFG_OWNER_DYNLOAD,	/* dynamic loading at runtime */
 };
 
 /**
@@ -108,6 +110,17 @@ int cscfg_update_feat_param_val(struct cscfg_feature_desc *feat_desc,
 int cscfg_config_sysfs_activate(struct cscfg_config_desc *cfg_desc, bool activate);
 void cscfg_config_sysfs_set_preset(int preset);
 
+struct cscfg_load_owner_info *cscfg_find_last_loaded_cfg_owner(void);
+int cscfg_set_unload_start(void);
+
+void cscfg_enable_dyn_load(void);
+bool cscfg_disable_dyn_load(void);
+void cscfg_at_exit_dyn_load(void);
+
+struct cscfg_load_owner_info *cscfg_create_dyn_load_owner_info(void);
+void cscfg_free_dyn_load_owner_info(struct cscfg_load_owner_info *owner_info);
+const char *cscfg_get_dyn_load_name(struct cscfg_load_owner_info *owner_info);
+
 /* syscfg manager external API */
 int cscfg_load_config_sets(struct cscfg_config_desc **cfg_descs,
 			   struct cscfg_feature_desc **feat_descs,
@@ -124,4 +137,8 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
 void cscfg_csdev_disable_active_config(struct coresight_device *csdev);
 void cscfg_config_sysfs_get_active_cfg(unsigned long *cfg_hash, int *preset);
 
+/* Dynamic load and unload configuration table API */
+int cscfg_dyn_load_cfg_table(const void *table, size_t table_size);
+int cscfg_sched_dyn_unload_cfg_table(void);
+
 #endif /* CORESIGHT_SYSCFG_H */
-- 
2.25.1


