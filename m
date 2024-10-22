Return-Path: <linux-kernel+bounces-376457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0FF9AB1DB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E38A1F23733
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEDB1A2562;
	Tue, 22 Oct 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="H2C7Y1Ay"
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8174A18
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610419; cv=none; b=dxdzkbl4amoBjjxR4ZripYQrnBK9omScdbBXsrHHm0IEpio0736Y1t7X/hDt8CwomTuo2BkeRL2xqwYgbIm9Rpmu0c7xovRS4bCFXByUhh7Jk28NTbM/AaWvmuFiRmJKmPI+kKdp3voQBt3/fErYQ3xpz613WFKuxBmeBaTS+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610419; c=relaxed/simple;
	bh=FFWS8ppweNfThpQsCDSh22hFJ8GHB6BfnvDXD70Q/fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgRTGZB/l7LtRJMJUiCBe4K42erGihDI8/s7p0fwZ75oTns/dwa0SmoRjk/tZNsPflE5TAm1ObgraHnTmBiR0xDzs7xJzjQI43ewwRY/V5R8sQdSCIqCcrdxLa6XBXcv6arbqa9d+wb4KDW2fFogbdsAcX7RezvPFyfIK+1lpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=H2C7Y1Ay; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XXwd43WKmzksN;
	Tue, 22 Oct 2024 17:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729609912;
	bh=gytrrwHk0gzSPEN5tIehpljuS72vEBMQ53w6/u9Ro3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H2C7Y1Aynh7/Pw+jf2fY8qKkyv9cJU+rNeqBm0h+lFIOhsO5JZWZjJZGGq3Dk7Icj
	 Rm39MlWWmTj8Hc0XNDLOLXjwUaOvy8gyoTBgsNO/wxecrk1u7LnF5Tlna1eewVV/KK
	 f7rO8Fn36aUdS5oag9Z3eqPBw84er9R1Bvqs/as0=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XXwd40Drzzrgd;
	Tue, 22 Oct 2024 17:11:52 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Paul Moore <paul@paul-moore.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 1/3] landlock: Refactor filesystem access mask management
Date: Tue, 22 Oct 2024 17:11:42 +0200
Message-ID: <20241022151144.872797-2-mic@digikod.net>
In-Reply-To: <20241022151144.872797-1-mic@digikod.net>
References: <20241022151144.872797-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Replace get_raw_handled_fs_accesses() with a generic
landlock_merge_access_masks(), and replace get_fs_domain() with a
generic landlock_match_ruleset().  These helpers will also be useful for
other types of access.

Cc: Günther Noack <gnoack@google.com>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241022151144.872797-2-mic@digikod.net
---

Changes since v2:
* Create a new type union access_masks_all instead of changing struct
  acces_masks.
* Replace get_fs_domain() with an explicit call to
  landlock_match_ruleset().

Changes since v1:
* Rename landlock_filter_access_masks() to landlock_match_ruleset().
* Rename local variables from domain to ruleset to mach helpers'
  semantic.  We'll rename and move these helpers when we'll have a
  dedicated domain struct type.
* Rename the all_fs mask to any_fs.
* Add documentation, as suggested by Günther.
---
 security/landlock/fs.c       | 31 ++++------------
 security/landlock/ruleset.h  | 70 +++++++++++++++++++++++++++++++-----
 security/landlock/syscalls.c |  2 +-
 3 files changed, 70 insertions(+), 33 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 7d79fc8abe21..dd9a7297ea4e 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -388,38 +388,21 @@ static bool is_nouser_or_private(const struct dentry *dentry)
 		unlikely(IS_PRIVATE(d_backing_inode(dentry))));
 }
 
-static access_mask_t
-get_raw_handled_fs_accesses(const struct landlock_ruleset *const domain)
-{
-	access_mask_t access_dom = 0;
-	size_t layer_level;
-
-	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
-		access_dom |=
-			landlock_get_raw_fs_access_mask(domain, layer_level);
-	return access_dom;
-}
-
 static access_mask_t
 get_handled_fs_accesses(const struct landlock_ruleset *const domain)
 {
 	/* Handles all initially denied by default access rights. */
-	return get_raw_handled_fs_accesses(domain) |
+	return landlock_merge_access_masks(domain).fs |
 	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
 }
 
-static const struct landlock_ruleset *
-get_fs_domain(const struct landlock_ruleset *const domain)
-{
-	if (!domain || !get_raw_handled_fs_accesses(domain))
-		return NULL;
-
-	return domain;
-}
+static const struct access_masks any_fs = {
+	.fs = ~0,
+};
 
 static const struct landlock_ruleset *get_current_fs_domain(void)
 {
-	return get_fs_domain(landlock_get_current_domain());
+	return landlock_match_ruleset(landlock_get_current_domain(), any_fs);
 }
 
 /*
@@ -1516,8 +1499,8 @@ static int hook_file_open(struct file *const file)
 	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] = {};
 	access_mask_t open_access_request, full_access_request, allowed_access,
 		optional_access;
-	const struct landlock_ruleset *const dom =
-		get_fs_domain(landlock_cred(file->f_cred)->domain);
+	const struct landlock_ruleset *const dom = landlock_match_ruleset(
+		landlock_cred(file->f_cred)->domain, any_fs);
 
 	if (!dom)
 		return 0;
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 61bdbc550172..e00edcb38c5b 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -47,6 +47,15 @@ struct access_masks {
 	access_mask_t scope : LANDLOCK_NUM_SCOPE;
 };
 
+union access_masks_all {
+	struct access_masks masks;
+	u32 all;
+};
+
+/* Makes sure all fields are covered. */
+static_assert(sizeof(((union access_masks_all *)NULL)->masks) ==
+	      sizeof(((union access_masks_all *)NULL)->all));
+
 typedef u16 layer_mask_t;
 /* Makes sure all layers can be checked. */
 static_assert(BITS_PER_TYPE(layer_mask_t) >= LANDLOCK_MAX_NUM_LAYERS);
@@ -260,6 +269,58 @@ static inline void landlock_get_ruleset(struct landlock_ruleset *const ruleset)
 		refcount_inc(&ruleset->usage);
 }
 
+/**
+ * landlock_merge_access_masks - Return the merge of a ruleset's access_masks
+ *
+ * @ruleset: Landlock ruleset (used as a domain)
+ *
+ * Returns: an access_masks result of the OR of all the ruleset's access masks.
+ */
+static inline struct access_masks
+landlock_merge_access_masks(const struct landlock_ruleset *const ruleset)
+{
+	union access_masks_all matches = {};
+	size_t layer_level;
+
+	for (layer_level = 0; layer_level < ruleset->num_layers;
+	     layer_level++) {
+		union access_masks_all layer = {
+			.masks = ruleset->access_masks[layer_level],
+		};
+
+		matches.all |= layer.all;
+	}
+
+	return matches.masks;
+}
+
+/**
+ * landlock_match_ruleset - Return @ruleset if any @masks right matches
+ *
+ * @ruleset: Landlock ruleset (used as a domain)
+ * @masks: access masks
+ *
+ * Returns: @ruleset if @masks matches, or NULL otherwise.
+ */
+static inline const struct landlock_ruleset *
+landlock_match_ruleset(const struct landlock_ruleset *const ruleset,
+		       const struct access_masks masks)
+{
+	const union access_masks_all masks_all = {
+		.masks = masks,
+	};
+	union access_masks_all merge = {};
+
+	if (!ruleset)
+		return NULL;
+
+	merge.masks = landlock_merge_access_masks(ruleset);
+	if (merge.all & masks_all.all)
+		return ruleset;
+
+	return NULL;
+}
+
 static inline void
 landlock_add_fs_access_mask(struct landlock_ruleset *const ruleset,
 			    const access_mask_t fs_access_mask,
@@ -295,19 +356,12 @@ landlock_add_scope_mask(struct landlock_ruleset *const ruleset,
 	ruleset->access_masks[layer_level].scope |= mask;
 }
 
-static inline access_mask_t
-landlock_get_raw_fs_access_mask(const struct landlock_ruleset *const ruleset,
-				const u16 layer_level)
-{
-	return ruleset->access_masks[layer_level].fs;
-}
-
 static inline access_mask_t
 landlock_get_fs_access_mask(const struct landlock_ruleset *const ruleset,
 			    const u16 layer_level)
 {
 	/* Handles all initially denied by default access rights. */
-	return landlock_get_raw_fs_access_mask(ruleset, layer_level) |
+	return ruleset->access_masks[layer_level].fs |
 	       LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
 }
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index f5a0e7182ec0..c097d356fa45 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -329,7 +329,7 @@ static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
 		return -ENOMSG;
 
 	/* Checks that allowed_access matches the @ruleset constraints. */
-	mask = landlock_get_raw_fs_access_mask(ruleset, 0);
+	mask = ruleset->access_masks[0].fs;
 	if ((path_beneath_attr.allowed_access | mask) != mask)
 		return -EINVAL;
 
-- 
2.47.0


