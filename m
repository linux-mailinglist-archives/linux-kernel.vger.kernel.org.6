Return-Path: <linux-kernel+bounces-340295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878A1987124
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44924283116
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C191AC8BD;
	Thu, 26 Sep 2024 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFuXCF/a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070181ABEBC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345962; cv=none; b=DTDi+uAyJY0HDTxpXPKK9Y5r3pxQmSZBzI/mnr476/wOSa1pXX78I1LTABks8KPug/nM2KzdtXNRxFhVizyGkjW3XhcEDQF2JPPkUdur3SG0+fuIqUspNAo4u643yb7ia6gSziQHHUhwXxxcAE+3mESwl5DVjfXmUkkpyNZx7EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345962; c=relaxed/simple;
	bh=YZTVi6NsRh8F0R9fOHuPpd2nGsJu83XnTYyzXELkgNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QmUXuSt2daxAeyKtkdqpXOb8g0wG8NojHCdh9ubjyXgDlbKOSPxs9LUHSg2gvjd3LeztX9U9pzUEuUA0H9bSzHeH5e5WSPU/zW32CUKsegNO9Mj2rJCGpCUQNfYt1rVvaPXUxHg+ZeYqFkZ/jxRS1vCEh7XG5EuwWAkHCoC5QV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFuXCF/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E74C4CEC9;
	Thu, 26 Sep 2024 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727345961;
	bh=YZTVi6NsRh8F0R9fOHuPpd2nGsJu83XnTYyzXELkgNk=;
	h=From:Date:Subject:To:Cc:From;
	b=SFuXCF/a4UTrO4tKB0Qv0WJSJt3KPjtOwIrpFBSKi8tLd3oM0OzhOp3h/ZiNVLH2r
	 RacJ4awSWth0MjfLe+a2m9TLuQukre1hnh5eV3RnpvIkVVFTaitzkrG4Pqgd2jQQom
	 WjFignLLaQuczwCRY/3bwK4PVBLTEZTnkJXdd1gPNn9kvibGcmqlTP6KVk7sZwwiy3
	 LQzXL5D9bgJIPdXOwzhiqe2ckob4+aAj+RWpeWimYmw52s2zGBTlZQ2qA2csB3dU9X
	 LWvX+lxlNnMOASWJMkpIS3gDp7oB60JSXYVwNi6RKY3BXwXr1xc7D2tZQbfJSOcXSs
	 +uWMt2l4kIECQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 26 Sep 2024 12:18:41 +0200
Subject: [PATCH] regcache: Store values more directly in maple trees
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-regmap-maple-idiomatic-v1-1-685258a00a05@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAA19WYC/x2MwQqAIBAFfyX2nJCWhP1KdFBba6EyNCIQ/z3rM
 IdheC9BxEAYYagSBLwpkj+K8LoCu+pjQUZzcRCN6BolJAu47Ppkhe1r5Hd9kWVOqVb2RjnDEcr
 4DOjo+Y/HKecXLFXnLWgAAAA=
To: linux-kernel@vger.kernel.org
Cc: Liam Howlett <liam.howlett@oracle.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=13513; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YZTVi6NsRh8F0R9fOHuPpd2nGsJu83XnTYyzXELkgNk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm9TUnSd1mMA5tOIvW0x0qIrLvqnku4+w0tns5G
 GLB6+tZdCGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvU1JwAKCRAk1otyXVSH
 0H09B/0bvC5GdSvXw12IGnOIpYBMaaAlrdtM3hLYsXxOnEdGn2dWGHAaKS3wITU1Bdecbhkq8N/
 wKtJnl+HMxj/WfV5eAGD54YyOm6RdxIv0MBcyRl1IB9PHduI0TF5xT6O7+YwYiclokYIoA9IRHD
 IORB8PmL+3WvEkPa41ox3G5jsaHnknkVYPsqEDFYRCHPuxn2CHEYdGEZJ88nBchky5RJIdAc2wO
 2ksvBf0wKPMjEAfik+6FjPC3A3Win+bUqkLyjIYOAHtqfMPASBBCerP4SYs3afhTpOp02R1nfPC
 tOiRQnZ88qCGKzhUIZCzXKy1TdsXxZL53wEig+4SToXm/50l
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently the regmap usage of the maple tree is a bit non-idomatic, rather
than storing register values directly we allocate arrays of contiguous
register values and store pointers to those arrays. This is all quite
fiddly, especially around adding values (where we may need to combine a new
allocation with adjacent ones) or dropping values (where we may have to
keep parts of a contiguous block). One reason for doing this is that the
maple tree wants to store pointers rather than integers, and in particular
has some problems when we want to store 0 as a value.

For 64 bit systems we can take advantage of the fact that regmap only
supports 32 bit values and store values with an extra high bit set in the
maple tree, avoiding the special cases with 0 and allowing us to save a
layer of indirection. This approach was suggested by Liam Howlett.

That doesn't help 32 bit systems though since we don't have any non-value bits there. For those we
can keep the same code structure by switching to do a separate allocation
for each value. The resulting data structure is not a thing of beauty but
the code is much less complicated, and should be able to make better use of
the slab allocator in cases where contiguous blocks of registers are not
powers of 2.

Let's implement these two approaches, using CONFIG_64BIT to choose between
direct storage and allocating per-register storage. The end result is much
simpler, making more direct usage of the maple tree API and the detailed
optimisation work that goes into it's implementation. One indication of
the simplifications is that even with having the two different allocation
strategies we still have an overall negative diffstat.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache-maple.c | 320 +++++++++++++++--------------------
 1 file changed, 133 insertions(+), 187 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 2dea9d259c49..e1495326369b 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -13,26 +13,53 @@
 
 #include "internal.h"
 
-static int regcache_maple_read(struct regmap *map,
-			       unsigned int reg, unsigned int *value)
+#if IS_ENABLED(CONFIG_64BIT)
+/*
+ * On 64 bit systems uintptr_t will be 64 bit but unsigned long 32 bit
+ * so we can store the register values directly in the maple tree.  We
+ * need to always set an out of bounds bit due to maple tree's
+ * handling of NULL.
+ */
+#define REGCACHE_MAPLE_NONZERO (1UL << 32)
+
+static unsigned long regcache_maple_entry_to_value(void *entry)
+{
+	return (uintptr_t)entry & ~REGCACHE_MAPLE_NONZERO;
+}
+
+static int regcache_maple_write(struct regmap *map, unsigned int reg,
+				unsigned int val)
 {
 	struct maple_tree *mt = map->cache;
 	MA_STATE(mas, mt, reg, reg);
-	unsigned long *entry;
+	uintptr_t entry = val | REGCACHE_MAPLE_NONZERO;
+	int ret;
 
-	rcu_read_lock();
+	/*
+	 * This is safe because the regmap lock means the Maple lock
+	 * is redundant, but we need to take it due to lockdep asserts
+	 * in the maple tree code.
+	 */
+	mas_lock(&mas);
 
-	entry = mas_walk(&mas);
-	if (!entry) {
-		rcu_read_unlock();
-		return -ENOENT;
-	}
+	mas_set_range(&mas, reg, reg);
+	ret = mas_store_gfp(&mas, (void *)entry, map->alloc_flags);
 
-	*value = entry[reg - mas.index];
+	mas_unlock(&mas);
 
-	rcu_read_unlock();
+	return ret;
+}
 
-	return 0;
+#else
+
+/*
+ * On 32 bit systems we can't distingush between NULL and a valid 0
+ * value in a 32 bit register so kmalloc() extra storage for the
+ * values.
+ */
+static unsigned long regcache_maple_entry_to_value(unsigned long *entry)
+{
+	return *entry;
 }
 
 static int regcache_maple_write(struct regmap *map, unsigned int reg,
@@ -40,49 +67,24 @@ static int regcache_maple_write(struct regmap *map, unsigned int reg,
 {
 	struct maple_tree *mt = map->cache;
 	MA_STATE(mas, mt, reg, reg);
-	unsigned long *entry, *upper, *lower;
-	unsigned long index, last;
-	size_t lower_sz, upper_sz;
+	unsigned long *entry;
 	int ret;
 
 	rcu_read_lock();
 
 	entry = mas_walk(&mas);
 	if (entry) {
-		entry[reg - mas.index] = val;
+		*entry = val;
 		rcu_read_unlock();
 		return 0;
 	}
 
-	/* Any adjacent entries to extend/merge? */
-	mas_set_range(&mas, reg - 1, reg + 1);
-	index = reg;
-	last = reg;
-
-	lower = mas_find(&mas, reg - 1);
-	if (lower) {
-		index = mas.index;
-		lower_sz = (mas.last - mas.index + 1) * sizeof(unsigned long);
-	}
-
-	upper = mas_find(&mas, reg + 1);
-	if (upper) {
-		last = mas.last;
-		upper_sz = (mas.last - mas.index + 1) * sizeof(unsigned long);
-	}
-
 	rcu_read_unlock();
 
-	entry = kmalloc((last - index + 1) * sizeof(unsigned long),
-			map->alloc_flags);
+	entry = kmalloc(sizeof(unsigned long), map->alloc_flags);
 	if (!entry)
 		return -ENOMEM;
-
-	if (lower)
-		memcpy(entry, lower, lower_sz);
-	entry[reg - index] = val;
-	if (upper)
-		memcpy(&entry[reg - index + 1], upper, upper_sz);
+	*entry = val;
 
 	/*
 	 * This is safe because the regmap lock means the Maple lock
@@ -91,97 +93,75 @@ static int regcache_maple_write(struct regmap *map, unsigned int reg,
 	 */
 	mas_lock(&mas);
 
-	mas_set_range(&mas, index, last);
+	mas_set_range(&mas, reg, reg);
 	ret = mas_store_gfp(&mas, entry, map->alloc_flags);
 
 	mas_unlock(&mas);
 
-	if (ret == 0) {
-		kfree(lower);
-		kfree(upper);
-	}
+	if (ret != 0)
+		kfree(entry);
 	
 	return ret;
 }
+#endif
+
+static int regcache_maple_read(struct regmap *map,
+			       unsigned int reg, unsigned int *value)
+{
+	struct maple_tree *mt = map->cache;
+	MA_STATE(mas, mt, reg, reg);
+	void *entry;
+
+	rcu_read_lock();
+
+	entry = mas_walk(&mas);
+	if (!entry) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+
+	*value = regcache_maple_entry_to_value(entry);
+
+	rcu_read_unlock();
+
+	return 0;
+}
 
 static int regcache_maple_drop(struct regmap *map, unsigned int min,
 			       unsigned int max)
 {
 	struct maple_tree *mt = map->cache;
 	MA_STATE(mas, mt, min, max);
-	unsigned long *entry, *lower, *upper;
-	/* initialized to work around false-positive -Wuninitialized warning */
-	unsigned long lower_index = 0, lower_last = 0;
-	unsigned long upper_index, upper_last;
+	unsigned long *entry;
 	int ret = 0;
 
-	lower = NULL;
-	upper = NULL;
-
 	mas_lock(&mas);
 
 	mas_for_each(&mas, entry, max) {
+		if (WARN_ON_ONCE(mas.index != mas.last)) {
+			ret = -EFAULT;
+			goto out;
+		}
+
+		if (mas.index < min || mas.last > max)
+			continue;
+
 		/*
 		 * This is safe because the regmap lock means the
 		 * Maple lock is redundant, but we need to take it due
 		 * to lockdep asserts in the maple tree code.
 		 */
-		mas_unlock(&mas);
-
-		/* Do we need to save any of this entry? */
-		if (mas.index < min) {
-			lower_index = mas.index;
-			lower_last = min -1;
-
-			lower = kmemdup_array(entry,
-					      min - mas.index, sizeof(*lower),
-					      map->alloc_flags);
-			if (!lower) {
-				ret = -ENOMEM;
-				goto out_unlocked;
-			}
-		}
-
-		if (mas.last > max) {
-			upper_index = max + 1;
-			upper_last = mas.last;
-
-			upper = kmemdup_array(&entry[max - mas.index + 1],
-					      mas.last - max, sizeof(*upper),
-					      map->alloc_flags);
-			if (!upper) {
-				ret = -ENOMEM;
-				goto out_unlocked;
-			}
+		if (!IS_ENABLED(CONFIG_64BIT)) {
+			mas_unlock(&mas);
+			kfree(entry);
+			mas_lock(&mas);
 		}
 
-		kfree(entry);
-		mas_lock(&mas);
 		mas_erase(&mas);
-
-		/* Insert new nodes with the saved data */
-		if (lower) {
-			mas_set_range(&mas, lower_index, lower_last);
-			ret = mas_store_gfp(&mas, lower, map->alloc_flags);
-			if (ret != 0)
-				goto out;
-			lower = NULL;
-		}
-
-		if (upper) {
-			mas_set_range(&mas, upper_index, upper_last);
-			ret = mas_store_gfp(&mas, upper, map->alloc_flags);
-			if (ret != 0)
-				goto out;
-			upper = NULL;
-		}
 	}
 
 out:
 	mas_unlock(&mas);
-out_unlocked:
-	kfree(lower);
-	kfree(upper);
 
 	return ret;
 }
@@ -191,6 +171,7 @@ static int regcache_maple_sync_block(struct regmap *map, unsigned long *entry,
 				     unsigned int min, unsigned int max)
 {
 	void *buf;
+	unsigned int v;
 	unsigned long r;
 	size_t val_bytes = map->format.val_bytes;
 	int ret = 0;
@@ -211,19 +192,25 @@ static int regcache_maple_sync_block(struct regmap *map, unsigned long *entry,
 		}
 
 		/* Render the data for a raw write */
-		for (r = min; r < max; r++) {
-			regcache_set_val(map, buf, r - min,
-					 entry[r - mas->index]);
+		for (r = min; r < max + 1; r++) {
+			ret = regcache_maple_read(map, r, &v);
+			if (ret != 0) {
+				kfree(buf);
+				goto out;
+			}
+			regcache_set_val(map, buf, r - min, v);
 		}
 
-		ret = _regmap_raw_write(map, min, buf, (max - min) * val_bytes,
+		ret = _regmap_raw_write(map, min, buf, (max - min + 1) * val_bytes,
 					false);
 
 		kfree(buf);
 	} else {
-		for (r = min; r < max; r++) {
-			ret = _regmap_write(map, r,
-					    entry[r - mas->index]);
+		for (r = min; r < max + 1; r++) {
+			ret = regcache_maple_read(map, r, &v);
+			if (ret != 0)
+				goto out;
+			ret = _regmap_write(map, r, v);
 			if (ret != 0)
 				goto out;
 		}
@@ -241,9 +228,7 @@ static int regcache_maple_sync(struct regmap *map, unsigned int min,
 	struct maple_tree *mt = map->cache;
 	unsigned long *entry;
 	MA_STATE(mas, mt, min, max);
-	unsigned long lmin = min;
-	unsigned long lmax = max;
-	unsigned int r, v, sync_start;
+	unsigned int v, last, sync_start;
 	int ret = 0;
 	bool sync_needed = false;
 
@@ -252,34 +237,39 @@ static int regcache_maple_sync(struct regmap *map, unsigned int min,
 	rcu_read_lock();
 
 	mas_for_each(&mas, entry, max) {
-		for (r = max(mas.index, lmin); r <= min(mas.last, lmax); r++) {
-			v = entry[r - mas.index];
-
-			if (regcache_reg_needs_sync(map, r, v)) {
-				if (!sync_needed) {
-					sync_start = r;
-					sync_needed = true;
-				}
-				continue;
-			}
-
-			if (!sync_needed)
-				continue;
-
+		/* Flush if we hit a gap in the cache */
+		if (sync_needed && mas.index != last + 1) {
 			ret = regcache_maple_sync_block(map, entry, &mas,
-							sync_start, r);
+							sync_start, last);
 			if (ret != 0)
 				goto out;
 			sync_needed = false;
 		}
 
-		if (sync_needed) {
-			ret = regcache_maple_sync_block(map, entry, &mas,
-							sync_start, r);
-			if (ret != 0)
-				goto out;
-			sync_needed = false;
+		v = regcache_maple_entry_to_value(entry);
+
+		if (regcache_reg_needs_sync(map, mas.index, v)) {
+			if (!sync_needed) {
+				sync_start = mas.index;
+				sync_needed = true;
+			}
+			last = mas.index;
+			continue;
 		}
+
+		if (!sync_needed)
+			continue;
+
+		ret = regcache_maple_sync_block(map, entry, &mas,
+						sync_start, last);
+		if (ret != 0)
+			goto out;
+		sync_needed = false;
+	}
+
+	if (sync_needed) {
+		ret = regcache_maple_sync_block(map, entry, &mas,
+						sync_start, last);
 	}
 
 out:
@@ -301,8 +291,10 @@ static int regcache_maple_exit(struct regmap *map)
 		return 0;
 
 	mas_lock(&mas);
-	mas_for_each(&mas, entry, UINT_MAX)
-		kfree(entry);
+	if (!IS_ENABLED(CONFIG_64BIT)) {
+		mas_for_each(&mas, entry, UINT_MAX)
+			kfree(entry);
+	}
 	__mt_destroy(mt);
 	mas_unlock(&mas);
 
@@ -312,41 +304,11 @@ static int regcache_maple_exit(struct regmap *map)
 	return 0;
 }
 
-static int regcache_maple_insert_block(struct regmap *map, int first,
-					int last)
-{
-	struct maple_tree *mt = map->cache;
-	MA_STATE(mas, mt, first, last);
-	unsigned long *entry;
-	int i, ret;
-
-	entry = kcalloc(last - first + 1, sizeof(unsigned long), map->alloc_flags);
-	if (!entry)
-		return -ENOMEM;
-
-	for (i = 0; i < last - first + 1; i++)
-		entry[i] = map->reg_defaults[first + i].def;
-
-	mas_lock(&mas);
-
-	mas_set_range(&mas, map->reg_defaults[first].reg,
-		      map->reg_defaults[last].reg);
-	ret = mas_store_gfp(&mas, entry, map->alloc_flags);
-
-	mas_unlock(&mas);
-
-	if (ret)
-		kfree(entry);
-
-	return ret;
-}
-
 static int regcache_maple_init(struct regmap *map)
 {
 	struct maple_tree *mt;
 	int i;
 	int ret;
-	int range_start;
 
 	mt = kmalloc(sizeof(*mt), GFP_KERNEL);
 	if (!mt)
@@ -355,30 +317,14 @@ static int regcache_maple_init(struct regmap *map)
 
 	mt_init(mt);
 
-	if (!map->num_reg_defaults)
-		return 0;
-
-	range_start = 0;
-
-	/* Scan for ranges of contiguous registers */
-	for (i = 1; i < map->num_reg_defaults; i++) {
-		if (map->reg_defaults[i].reg !=
-		    map->reg_defaults[i - 1].reg + 1) {
-			ret = regcache_maple_insert_block(map, range_start,
-							  i - 1);
-			if (ret != 0)
-				goto err;
-
-			range_start = i;
-		}
+	for (i = 0; i < map->num_reg_defaults; i++) {
+		ret = regcache_maple_write(map,
+					   map->reg_defaults[i].reg,
+					   map->reg_defaults[i].def);
+		if (ret != 0)
+			goto err;
 	}
 
-	/* Add the last block */
-	ret = regcache_maple_insert_block(map, range_start,
-					  map->num_reg_defaults - 1);
-	if (ret != 0)
-		goto err;
-
 	return 0;
 
 err:

---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240925-regmap-maple-idiomatic-f99357b9fb1e

Best regards,
-- 
Mark Brown <broonie@kernel.org>


