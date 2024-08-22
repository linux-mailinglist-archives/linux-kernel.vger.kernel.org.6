Return-Path: <linux-kernel+bounces-297869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC72695BEB6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 299E1B23A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F501D175D;
	Thu, 22 Aug 2024 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5b70VjH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118361D174E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354150; cv=none; b=bJP9bER+/vWTfSi7ov4o5Eb84Z0aOZcf+W8BOsHzdGEhhLEgRHeBaw9VE36K7pp8APU12g3o3fUpdkLdrcdnbhkCqJhU8LGAhAxSMbODnsmddSklBld83lTJO9GW5McpVwsCnm8HaUSKbQN6VyQJ/xvCeG5Slq6ckzLW/VaNA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354150; c=relaxed/simple;
	bh=3IkVv+qB4U5hLvXfbSxIYJIDDH95Yvi/JvCEmYiEG0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H4RJB6MYdmkc8cDQ4rk4Gnz3rNxgM7VaZ5mZvj5SPEAAZ5ARuXkSyrd42z00DMfLnpfB7FAnXZrwbhIBA+pj/hOlyFg4payLYcZFY8yjMOkpAAovXDtkjFmlnF6Up9g16+r8thkyZEoVPJjxLfkPlaqTybZpYgxHjx3ImM1aaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5b70VjH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC970C4AF12;
	Thu, 22 Aug 2024 19:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724354149;
	bh=3IkVv+qB4U5hLvXfbSxIYJIDDH95Yvi/JvCEmYiEG0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U5b70VjHfQEHCBxGcuJkIaZuR3G/OzNuKadvdXSUyLMPsPPYw5KHYR5RNmZ4R81tr
	 5U8hq/bgBfqVHmd4RaNTTKLmhWpSIvhs+1HVg8J1r/gN6M/3bfDFx72BPrAIH+F2J8
	 4BkKW8CP6RYQfXgOngDOsBcq+HnW0dwSD18fvTwkJkAGiZGm1MZgZmVALySIF/io43
	 R2C3c+1d0mhm0rVhN/thZ5ybKAn9TgKp8m3R/iYdStDyD0ngzF01dzgsCyra/Gg9xY
	 R+7frdyONZQ9KZxnVDe+vfQ++8bueNVc1Mcj44MPYyu6FQWlWFx2JgQyNRuaXtiYaN
	 BWxE0XEfNPTjQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 20:13:39 +0100
Subject: [PATCH 5/5] regmap: Don't double lock maple cache when using a
 regmap provided lock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-b4-regmap-maple-nolock-v1-5-d5e6dbae3396@kernel.org>
References: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
In-Reply-To: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 maple-tree@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=3508; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3IkVv+qB4U5hLvXfbSxIYJIDDH95Yvi/JvCEmYiEG0s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmx45Z28y0ReLetC9q+2YdjmiA9bBTW+merSGJe
 7fXi8QJgY+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZseOWQAKCRAk1otyXVSH
 0CHEB/4su90f4gO7Qt9qNpuaveRhDVSkPq+70sBLqnd/TbhsYX1jIHDW1A9Qfz5h+u8gLoJJflf
 jdGXYJ1a+pR5vDp3krO/QpawNW3lwaI6acc1SqbGzseANmX/sVpWjOb6l8plm/vFCdoJVjgVzP2
 IHtmE7JEwMP5ldgQAu+610rCQRFeW3Oqr02p1fDApahKnw1hVNOrAWfFWrrmutoQuOYKGceqyo6
 Y6dbwEs0nrrGzWyFNSB4C1q8z8eUd5DJw2Jgprqv6mKRiq1ASMR2SWEXlQEfXmTram5pkcbY/3y
 Me6usgkEUE3WhqMjVulp0qD/k/vxWmd4oAo+/jj9U9jckyf9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

It is not possible to use the maple tree without holding a lock of some
kind, by default the maple tree incorporates a lock but it does have
support for registering an external lock which will be asserted against
instead. At present regmap uses the maple tree's internal lock which is
unfortunate since there is also regmap level locking above the cache which
protects the cache data structure and things like read/modify/write
operations.

Let's reduce the overhead here by telling the maple tree about the regmap
level lock for cases where regmap does it's own locking. We also support
external and custom locking for regmap, neither of which will benefit from
this, but this will cover the vast majority of users.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/internal.h       | 12 ++++++++++++
 drivers/base/regmap/regcache-maple.c |  9 +++++++++
 drivers/base/regmap/regmap.c         |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 83acccdc1008..a5fe052a70ce 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -59,6 +59,9 @@ struct regmap {
 			unsigned long raw_spinlock_flags;
 		};
 	};
+#ifdef CONFIG_LOCKDEP
+	struct lockdep_map *lockdep;
+#endif
 	regmap_lock lock;
 	regmap_unlock unlock;
 	void *lock_arg; /* This is passed to lock/unlock functions */
@@ -344,4 +347,13 @@ struct regmap *__regmap_init_raw_ram(struct device *dev,
 #define regmap_init_raw_ram(dev, config, data)				\
 	__regmap_lockdep_wrapper(__regmap_init_raw_ram, #dev, dev, config, data)
 
+#ifdef CONFIG_LOCKDEP
+static inline void regmap_set_lockdep(struct regmap *m, struct lockdep_map *l)
+{
+	m->lockdep = l;
+}
+#else
+#define regmap_set_lockdep(m, l)
+#endif
+
 #endif
diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index d2de3eba1646..1247ff3ae397 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -365,7 +365,16 @@ static int regcache_maple_init(struct regmap *map)
 		return -ENOMEM;
 	map->cache = mt;
 
+#ifdef CONFIG_LOCKDEP
+	if (map->lockdep) {
+		mt_init_flags(mt, MT_FLAGS_LOCK_EXTERN);
+		mt_set_external_lock_dep_map(mt, map->lockdep);
+	} else {
+		mt_init(mt);
+	}
+#else
 	mt_init(mt);
+#endif
 
 	if (!map->num_reg_defaults)
 		return 0;
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 9ed842d17642..f66b5ef56cf8 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -729,12 +729,15 @@ struct regmap *__regmap_init(struct device *dev,
 				map->unlock = regmap_unlock_raw_spinlock;
 				lockdep_set_class_and_name(&map->raw_spinlock,
 							   lock_key, lock_name);
+				regmap_set_lockdep(map,
+						   &map->raw_spinlock.dep_map);
 			} else {
 				spin_lock_init(&map->spinlock);
 				map->lock = regmap_lock_spinlock;
 				map->unlock = regmap_unlock_spinlock;
 				lockdep_set_class_and_name(&map->spinlock,
 							   lock_key, lock_name);
+				regmap_set_lockdep(map, &map->spinlock.dep_map);
 			}
 		} else {
 			mutex_init(&map->mutex);
@@ -743,6 +746,7 @@ struct regmap *__regmap_init(struct device *dev,
 			map->can_sleep = true;
 			lockdep_set_class_and_name(&map->mutex,
 						   lock_key, lock_name);
+			regmap_set_lockdep(map, &map->mutex.dep_map);
 		}
 		map->lock_arg = map;
 	}

-- 
2.39.2


