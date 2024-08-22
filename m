Return-Path: <linux-kernel+bounces-297868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E56595BEB5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C36428582C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757C31D1742;
	Thu, 22 Aug 2024 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQ4qPlhC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82471CEAD0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354147; cv=none; b=FIktMtLDzwCjYMs7ocvhdByEKwJdO83PP7QvaB553uy+lFz53JSpXdywzOohl5Kn8BgCrB7aS4XRlleFOo6jFBHGTSv2VKq/jvtgdxyo8wZGty5ooTKUy1wBc8Q97EBkNdm94i5jGKX99zZO4VzQmsGXdw+s5Mt/MhH91ZRP0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354147; c=relaxed/simple;
	bh=OBqVs0rQ1CiMM5qFzO+/1VLNqF3w4XsS2CGy4hdAxGo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWz8ft8dUBxWnBez3bS7/n46qQCYKW8k0PTEUV4DnLqWI2VRgIkHVo4lhUt7oiHFDii+GtcjKeBMeVAiEV+OT6VSXFvWd8rZx4AEc1Jwjo9VJ64HISDG39ZAWHscnf2kMXgkdYPCa1wT5wB6GJBVPkB8mD16mePQ/pVbMLfEKYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQ4qPlhC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023A0C4AF0C;
	Thu, 22 Aug 2024 19:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724354147;
	bh=OBqVs0rQ1CiMM5qFzO+/1VLNqF3w4XsS2CGy4hdAxGo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eQ4qPlhCEF5YOCmpS0UQxZkWeNJnWOrGyMTUxRDoGMV1K/l8JrhpiL6AifpkVLFxS
	 zbAmo4PxMIeb2WCG60SI2idnnmpWISI8RVAnAS473bn258XmFMpcCxpM/abZAhM9xI
	 RBPWYvWEyc1U/dqLTram27k6u6sGyVCZlHqdh3oVmmAk4ykUCT2IOTicjVZWvC6Xz6
	 3HiBR1FfmhbN6l/M+yOxjKBk3fbyOLaFg4B5svWlWkxjrBnLMbZSrSFL4NFp29Yqgp
	 tgO2RxxGsOhCxACfahu28n2ttUOOYI+lKrPEk0r0Rj9XoizMPmmQUT7Mrn+qzeBHHo
	 xwMQOijbW3JGw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 20:13:38 +0100
Subject: [PATCH 4/5] regmap: Wrap maple tree locking
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-b4-regmap-maple-nolock-v1-4-d5e6dbae3396@kernel.org>
References: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
In-Reply-To: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 maple-tree@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3250; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OBqVs0rQ1CiMM5qFzO+/1VLNqF3w4XsS2CGy4hdAxGo=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmx45Yne4Rw9lYzvkFQau2dor1n8Sxe2Cwjon6K
 vB1crJHzDmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZseOWAAKCRAk1otyXVSH
 0FcvB/4iyrhgWnvNVoQrKpcsLNdus42nmx8ZEdApoeflQqenqNixTVrspLKArPh6dm2ctgbXD5H
 sfEYxli/gChtp9Lyt9ruD+Gxlqd9pM3b3UhLz/xDCHjL15rOI3+WRBt/IdBm3n/a/mHC/2Zx5Kl
 wEiC7L5gZ9/qoHwYCnYpY+csxYn8hqOcUTdMdQeNLsC9OXfugWH40RTCy1L45wtDBx2kzOXVoLp
 s6o5oDhR5CF/utYgzqwlI/P0JD/7D/FQDFbxxCeUitdy/qA0IrHHJXpUwBX/DnBedPB73k25yYr
 lGAf0F+jW5wpaKlKp06AfsSyRqT38pQHFZPR01nPyEwLgWK2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

In preparation for using the regmap lock when available with the maple
tree lock wrap all the maple tree locking with some local functions and
only do the maple tree locking if the maple tree has it's own lock.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache-maple.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 2dea9d259c49..d2de3eba1646 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -13,6 +13,18 @@
 
 #include "internal.h"
 
+static inline void regmap_mas_lock(struct ma_state *mas)
+{
+	if (!mt_external_lock(mas->tree))
+		mas_lock(mas);
+}
+
+static inline void regmap_mas_unlock(struct ma_state *mas)
+{
+	if (!mt_external_lock(mas->tree))
+		mas_unlock(mas);
+}
+
 static int regcache_maple_read(struct regmap *map,
 			       unsigned int reg, unsigned int *value)
 {
@@ -89,12 +101,12 @@ static int regcache_maple_write(struct regmap *map, unsigned int reg,
 	 * is redundant, but we need to take it due to lockdep asserts
 	 * in the maple tree code.
 	 */
-	mas_lock(&mas);
+	regmap_mas_lock(&mas);
 
 	mas_set_range(&mas, index, last);
 	ret = mas_store_gfp(&mas, entry, map->alloc_flags);
 
-	mas_unlock(&mas);
+	regmap_mas_unlock(&mas);
 
 	if (ret == 0) {
 		kfree(lower);
@@ -118,7 +130,7 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 	lower = NULL;
 	upper = NULL;
 
-	mas_lock(&mas);
+	regmap_mas_lock(&mas);
 
 	mas_for_each(&mas, entry, max) {
 		/*
@@ -126,7 +138,7 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 		 * Maple lock is redundant, but we need to take it due
 		 * to lockdep asserts in the maple tree code.
 		 */
-		mas_unlock(&mas);
+		regmap_mas_unlock(&mas);
 
 		/* Do we need to save any of this entry? */
 		if (mas.index < min) {
@@ -156,7 +168,7 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 		}
 
 		kfree(entry);
-		mas_lock(&mas);
+		regmap_mas_lock(&mas);
 		mas_erase(&mas);
 
 		/* Insert new nodes with the saved data */
@@ -178,7 +190,7 @@ static int regcache_maple_drop(struct regmap *map, unsigned int min,
 	}
 
 out:
-	mas_unlock(&mas);
+	regmap_mas_unlock(&mas);
 out_unlocked:
 	kfree(lower);
 	kfree(upper);
@@ -300,11 +312,11 @@ static int regcache_maple_exit(struct regmap *map)
 	if (!mt)
 		return 0;
 
-	mas_lock(&mas);
+	regmap_mas_lock(&mas);
 	mas_for_each(&mas, entry, UINT_MAX)
 		kfree(entry);
 	__mt_destroy(mt);
-	mas_unlock(&mas);
+	regmap_mas_unlock(&mas);
 
 	kfree(mt);
 	map->cache = NULL;
@@ -327,13 +339,13 @@ static int regcache_maple_insert_block(struct regmap *map, int first,
 	for (i = 0; i < last - first + 1; i++)
 		entry[i] = map->reg_defaults[first + i].def;
 
-	mas_lock(&mas);
+	regmap_mas_lock(&mas);
 
 	mas_set_range(&mas, map->reg_defaults[first].reg,
 		      map->reg_defaults[last].reg);
 	ret = mas_store_gfp(&mas, entry, map->alloc_flags);
 
-	mas_unlock(&mas);
+	regmap_mas_unlock(&mas);
 
 	if (ret)
 		kfree(entry);

-- 
2.39.2


