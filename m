Return-Path: <linux-kernel+bounces-285560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F32D7950FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2163E1C220DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626B1AB50D;
	Tue, 13 Aug 2024 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="XfdtBVRH"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0321AAE10
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587719; cv=pass; b=RyeNVmummDUo7SQPvhTQHjRySqj2fXJFJITWLmTIgP70Yx6agFiNgBTLwwoKDfgn74A8UWCqgnhzrV1g0rwF3CiWoeUexInNxJEeXVNWAdeO2Xbzm9s2KJpkpALVqVJQUWMsbjZW7gOXyhN0zFA4FJFhOmg9UFgAkvwqDyZjn6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587719; c=relaxed/simple;
	bh=HoddbvvFCJ/zQw/U/MdzkUjnOV1Paoe9XsI+EKlZ8ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JEL0CVXRcd8veJ3HD4hz9eiX+By9tu47uHLrTBpYvNoHP+qb0TcSGAmzUYabvHKLNBmsTTilrWLLsCpMQn9eLPZNFFSrQBzkobSMySBHM5UaLff6oKtltjbyQinjPy+lDDOveN2H20WvMAewG9oVAFceqJoaf4drHJ6c6u/JCMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=XfdtBVRH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723587693; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eGQDv1CvqW9dp54oJt7pW5kGjsvEtwFJGUSR/2Hz6EkrtBRo1SChdipgNf5zHugUCvUQfqC1g5gUaBMvXWAK5GljMSC1Ngh0kE9CtR1SQVCGfXK4sQkdywVssJQPnnVROdAztJKoZiQ+EhZcXSOMue374cG5aP1udZtdYqhXrrE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723587693; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1XSqdjkbc9yGBfdxmtNjhxc/0apIUC4Pug2BZrnfPAc=; 
	b=bv4dfZ0CHY0cBAFaKNYVUUoNSDTqx6vhDHaZlXWvTG9cGM7DvWAB2/tIQbYusAVdNbpe5/rZ4uke7asYVS6GYaP1DUoIdajf+//Nspk9R+t7OoxB4KiYs9uXJQsd4NFDT9qxIYH9XlxDQimCnEXAzp2oLYLkXOwTIri9xqkPOcY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723587693;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=1XSqdjkbc9yGBfdxmtNjhxc/0apIUC4Pug2BZrnfPAc=;
	b=XfdtBVRH3g9phMaU+HATFmL1zNO8uZtLmizwpjhln3ytoCHtkZ9f13pUYm1dA8XG
	z36aOdZ/qIsrvu/672haM3a1kb+oAwNqqy1ltqjrsJM8vBBl5es1P5/xgxVChgFGe7i
	E/jeqDYbDMj8xxxLwi6z1G0DTGMxhDggSUr11hm4=
Received: by mx.zohomail.com with SMTPS id 1723587691918966.5081561540734;
	Tue, 13 Aug 2024 15:21:31 -0700 (PDT)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 14 Aug 2024 01:20:21 +0300
Subject: [PATCH RFC] regmap: maple: Switch to use irq-safe locking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-regcache-maple-irq-safe-v1-1-1b454c5767de@collabora.com>
X-B4-Tracking: v=1; b=H4sIACTcu2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0MT3aLU9OTE5IxU3dzEghygbFGhbnFiWqquYaqlcVpaokmqoYmZElB
 3QVFqWmYF2ORopSA3Z6XY2loA0MyzSm4AAAA=
To: Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.1
X-ZohoMailClient: External

Commit 3d59c22bbb8d ("drm/rockchip: vop2: Convert to use maple tree
register cache") enabled the use of maple tree register cache in
Rockchip VOP2 driver.  However, building the kernel with lockdep support
indicates locking rules violation when trying to unload the rockchipdrm
module:

[ 48.360258] ========================================================
[ 48.360829] WARNING: possible irq lock inversion dependency detected
[ 48.361400] 6.11.0-rc1 #40 Not tainted
[ 48.361743] --------------------------------------------------------
[ 48.362311] modprobe/685 just changed the state of lock:
[ 48.362790] ffff0000087fa798 (&mt->ma_lock){+...}-{2:2}, at: regcache_maple_exit+0x6c/0xe0
[ 48.363554] but this lock was taken by another, HARDIRQ-safe lock in the past:
[ 48.364212]  (rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock){-.-.}-{2:2}
[ 48.364226]

             and interrupts could create inverse lock ordering between them.

[ 48.365874]
             other info that might help us debug this:
[ 48.366460]  Possible interrupt unsafe locking scenario:

[ 48.367069]        CPU0                    CPU1
[ 48.367478]        ----                    ----
[ 48.367889]   lock(&mt->ma_lock);
[ 48.368197]                                local_irq_disable();
[ 48.368729]                                lock(rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock);
[ 48.369551]                                lock(&mt->ma_lock);
[ 48.370081]   <Interrupt>
[ 48.370336]     lock(rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock);
[ 48.370957]
                *** DEADLOCK ***

[ 48.371489] 2 locks held by modprobe/685:
[ 48.371854]  #0: ffff0000018898f8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0x54/0x210
[ 48.372739]  #1: ffff800081c6ca80 (component_mutex){+.+.}-{3:3}, at: component_del+0x38/0x158
[ 48.373522]
               the shortest dependencies between 2nd lock and 1st lock:
[ 48.374235]  -> (rockchip_drm_vop2:3114:(&vop2_regmap_config)->lock){-.-.}-{2:2} {
[ 48.374941]     IN-HARDIRQ-W at:
[ 48.375239]                       lock_acquire+0x1d4/0x320
[ 48.375739]                       _raw_spin_lock_irqsave+0x6c/0x98
[ 48.376300]                       regmap_lock_spinlock+0x20/0x40
[ 48.376845]                       regmap_read+0x44/0x88
[ 48.377321]                       vop2_isr+0x90/0x290 [rockchipdrm]
[ 48.377919]                       __handle_irq_event_percpu+0x114/0x2b0
[ 48.378519]                       handle_irq_event+0x54/0xb8
[ 48.379032]                       handle_fasteoi_irq+0x158/0x228
[ 48.379577]                       generic_handle_domain_irq+0x34/0x58
[ 48.380160]                       gic_handle_irq+0xa4/0x114

[...]

[ 48.466666] -> (&mt->ma_lock){+...}-{2:2} {
[ 48.467066]    HARDIRQ-ON-W at:
[ 48.467360]                     lock_acquire+0x1d4/0x320
[ 48.467849]                     _raw_spin_lock+0x50/0x70
[ 48.468337]                     regcache_maple_exit+0x6c/0xe0
[ 48.468864]                     regcache_exit+0x8c/0xa8
[ 48.469344]                     regmap_exit+0x24/0x160
[ 48.469815]                     devm_regmap_release+0x1c/0x28
[ 48.470339]                     release_nodes+0x68/0xa8
[ 48.470818]                     devres_release_group+0x120/0x180
[ 48.471364]                     component_unbind+0x54/0x70
[ 48.471867]                     component_unbind_all+0xb0/0xe8
[ 48.472400]                     rockchip_drm_unbind+0x44/0x80 [rockchipdrm]
[ 48.473059]                     component_del+0xc8/0x158
[ 48.473545]                     dw_hdmi_rockchip_remove+0x28/0x40 [rockchipdrm]

The problem is that the regmap lock could be taken by an IRQ context,
interrupting the irq-unsafe maple tree lock, which may result in a lock
inversion deadlock scenario.

Switch to use irq-safe locking in the maple tree register cache.

Fixes: f033c26de5a5 ("regmap: Add maple tree based register cache")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/base/regmap/regcache-maple.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 2dea9d259c49..7b2433c9747e 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -13,6 +13,9 @@
 
 #include "internal.h"
 
+#define mas_lock_irq(mas, flags)           spin_lock_irqsave(&((mas)->tree->ma_lock), flags)
+#define mas_unlock_irq(mas, flags)         spin_unlock_irqrestore(&((mas)->tree->ma_lock), flags)
+
 static int regcache_maple_read(struct regmap *map,
 			       unsigned int reg, unsigned int *value)
 {
@@ -42,6 +45,7 @@ static int regcache_maple_write(struct regmap *map, unsigned int reg,
 	MA_STATE(mas, mt, reg, reg);
 	unsigned long *entry, *upper, *lower;
 	unsigned long index, last;
+	unsigned long flags;
 	size_t lower_sz, upper_sz;
 	int ret;
 
@@ -89,18 +93,18 @@ static int regcache_maple_write(struct regmap *map, unsigned int reg,
 	 * is redundant, but we need to take it due to lockdep asserts
 	 * in the maple tree code.
 	 */
-	mas_lock(&mas);
+	mas_lock_irq(&mas, flags);
 
 	mas_set_range(&mas, index, last);
 	ret = mas_store_gfp(&mas, entry, map->alloc_flags);
 
-	mas_unlock(&mas);
+	mas_unlock_irq(&mas, flags);
 
 	if (ret == 0) {
 		kfree(lower);
 		kfree(upper);
 	}
-	
+
 	return ret;
 }
 
@@ -113,12 +117,13 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 	/* initialized to work around false-positive -Wuninitialized warning */
 	unsigned long lower_index = 0, lower_last = 0;
 	unsigned long upper_index, upper_last;
+	unsigned long flags;
 	int ret = 0;
 
 	lower = NULL;
 	upper = NULL;
 
-	mas_lock(&mas);
+	mas_lock_irq(&mas, flags);
 
 	mas_for_each(&mas, entry, max) {
 		/*
@@ -126,7 +131,7 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 		 * Maple lock is redundant, but we need to take it due
 		 * to lockdep asserts in the maple tree code.
 		 */
-		mas_unlock(&mas);
+		mas_unlock_irq(&mas, flags);
 
 		/* Do we need to save any of this entry? */
 		if (mas.index < min) {
@@ -156,7 +161,7 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 		}
 
 		kfree(entry);
-		mas_lock(&mas);
+		mas_lock_irq(&mas, flags);
 		mas_erase(&mas);
 
 		/* Insert new nodes with the saved data */
@@ -178,7 +183,7 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 	}
 
 out:
-	mas_unlock(&mas);
+	mas_unlock_irq(&mas, flags);
 out_unlocked:
 	kfree(lower);
 	kfree(upper);
@@ -295,16 +300,17 @@ static int regcache_maple_exit(struct regmap *map)
 	struct maple_tree *mt = map->cache;
 	MA_STATE(mas, mt, 0, UINT_MAX);
 	unsigned int *entry;
+	unsigned long flags;
 
 	/* if we've already been called then just return */
 	if (!mt)
 		return 0;
 
-	mas_lock(&mas);
+	mas_lock_irq(&mas, flags);
 	mas_for_each(&mas, entry, UINT_MAX)
 		kfree(entry);
 	__mt_destroy(mt);
-	mas_unlock(&mas);
+	mas_unlock_irq(&mas, flags);
 
 	kfree(mt);
 	map->cache = NULL;
@@ -318,6 +324,7 @@ static int regcache_maple_insert_block(struct regmap *map, int first,
 	struct maple_tree *mt = map->cache;
 	MA_STATE(mas, mt, first, last);
 	unsigned long *entry;
+	unsigned long flags;
 	int i, ret;
 
 	entry = kcalloc(last - first + 1, sizeof(unsigned long), map->alloc_flags);
@@ -327,13 +334,13 @@ static int regcache_maple_insert_block(struct regmap *map, int first,
 	for (i = 0; i < last - first + 1; i++)
 		entry[i] = map->reg_defaults[first + i].def;
 
-	mas_lock(&mas);
+	mas_lock_irq(&mas, flags);
 
 	mas_set_range(&mas, map->reg_defaults[first].reg,
 		      map->reg_defaults[last].reg);
 	ret = mas_store_gfp(&mas, entry, map->alloc_flags);
 
-	mas_unlock(&mas);
+	mas_unlock_irq(&mas, flags);
 
 	if (ret)
 		kfree(entry);

---
base-commit: 9e6869691724b12e1f43655eeedc35fade38120c
change-id: 20240814-regcache-maple-irq-safe-1e93ffa4e146


