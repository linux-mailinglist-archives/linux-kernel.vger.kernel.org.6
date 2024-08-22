Return-Path: <linux-kernel+bounces-297866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2915D95BEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CCD1C237C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9574118EAB;
	Thu, 22 Aug 2024 19:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8HEkCZK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E101D0DDE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354143; cv=none; b=pAqffJuT30RNdsrLQqpmrioAyhxFyPAyBKISjTOXEz2wBHANj0/5VJChstFs9CGZ6+mTU0nAfeZ/hRGXlODxepPpzDr+ftwQ23cDePNGklNFMzJ3ufVqs4rvWuyKiFaYWE/P0H6+xxZUHih1jYN10mHxPd7f7a60pmUXmTlPpTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354143; c=relaxed/simple;
	bh=HqTvO4EXWR9m8S4knK2OhOF8g7vD7aNMIK2A6uNJAO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQS/PeQNJv4RQ6ikEWJ3fK8Apj/g7f0cZ2hJvT918Wogq+TUdxeEBUvJN7Qv+80Sw6y4W2g/DoHicSlMAC+iIkn+Fuyq9R9kaT/aTT8UG9PoSsX/vyQwCCS8vOVyjIO1DSsLizcHng2mJnhXt5x52+2YAljDIAdxQ5mWQPGEHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8HEkCZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B2AC4AF12;
	Thu, 22 Aug 2024 19:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724354143;
	bh=HqTvO4EXWR9m8S4knK2OhOF8g7vD7aNMIK2A6uNJAO8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a8HEkCZKnKXnymobpVWtAm4avgezgATDH2uSDC/fqFclh/7AwmwSQiwL/dEuW3oY8
	 3UtIQ2KUfb7EjB8W/WuyZ1z23awOIEarRePcINmkUSjh0DMtbnxMFpy1mBeAYinWpp
	 8/NJeni7ZoxLfzbDVs9Dozm4WPgmsIsbhg1DsHRzea6PL3uTgtlsqTYPB/xZskTWOL
	 OOdF7roGhhi2Mf+kQfp0I/ulmuL/rltSGxMaESwTnZYxzPTwohXwqkhi+vpzX0Da3a
	 Hyw9GRXbwqrPQhY8FKARJjylxxTCVWjjzEfyl248uxNq7XROy2463GDs/ORWoPmys2
	 cHIOQH+EYdfYg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 20:13:36 +0100
Subject: [PATCH 2/5] regmap: Hold the regmap lock when allocating and
 freeing the cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-b4-regmap-maple-nolock-v1-2-d5e6dbae3396@kernel.org>
References: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
In-Reply-To: <20240822-b4-regmap-maple-nolock-v1-0-d5e6dbae3396@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 maple-tree@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HqTvO4EXWR9m8S4knK2OhOF8g7vD7aNMIK2A6uNJAO8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmx45W7hwqN8635GlhniM9IzBeNxeV+mEbT9v4O
 hPc/8CuTsWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZseOVgAKCRAk1otyXVSH
 0EOTB/wNrSyae31JmMwCaXdCreGvDhp2iBzo39oKF/d+fEx6wa5Bi1u3nZhgDhj/tZfP+nEjirv
 WEJdY7o4yBWI4lu9+lSSF9w8sAfo7cmjmQJFGJYnqhBVBQOLtd57WU+unlf60Aj17RxD5VoO6U4
 OvF75iSafkKRm5ADTxMPZMdjtKdtNeIwmxZiC9LvhLl4Bx+taoiodUVyIY0GGOtF7uT4joZQKdo
 QYdy1bY44VKxvI13LI1MFNh6Z7iMxvD1ATfbRmA/dpjcCRDyb/qicbzJ+pO3moKGSIXhENto0cF
 4Mbmi9s3Sk1Kq85eRfgJLbtHlMEVPAIS9QjMOAybBqufyqJM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

For the benefit of the maple tree's lockdep checking hold the lock while
creating and exiting the cache.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regcache.c | 4 ++++
 drivers/base/regmap/regmap.c   | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 7ec1ec605335..d3659ba3cc11 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -195,7 +195,9 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
 	if (map->cache_ops->init) {
 		dev_dbg(map->dev, "Initializing %s cache\n",
 			map->cache_ops->name);
+		map->lock(map->lock_arg);
 		ret = map->cache_ops->init(map);
+		map->unlock(map->lock_arg);
 		if (ret)
 			goto err_free;
 	}
@@ -223,7 +225,9 @@ void regcache_exit(struct regmap *map)
 	if (map->cache_ops->exit) {
 		dev_dbg(map->dev, "Destroying %s cache\n",
 			map->cache_ops->name);
+		map->lock(map->lock_arg);
 		map->cache_ops->exit(map);
+		map->unlock(map->lock_arg);
 	}
 }
 
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index bfc6bc1eb3a4..9ed842d17642 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1445,6 +1445,7 @@ void regmap_exit(struct regmap *map)
 	struct regmap_async *async;
 
 	regcache_exit(map);
+
 	regmap_debugfs_exit(map);
 	regmap_range_exit(map);
 	if (map->bus && map->bus->free_context)

-- 
2.39.2


