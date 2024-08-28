Return-Path: <linux-kernel+bounces-304942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A4E96271B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743F81F215B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B956A175D5C;
	Wed, 28 Aug 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EnmRmkZ8"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D7175D48
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848136; cv=none; b=FW4Qas6iwfcZQY417Dlj+veVc1k1cNjXR7Xaw+umvNN56DSvUKaqNGGSQ6dSQRLp4Gx6Bw/XF3a4XcFVKIwJ2Moku77zYi8235hQ3KBr8SoHkF9THgXy58lmndnj2n1+Zn3dNgAmMTFXfalvTnDzYxLmrrXXdMYq12REfFvB5u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848136; c=relaxed/simple;
	bh=LMLHS4l05aC6vgzmk7ivVVkcaY6/Irsrqxa3gsI4yfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=uhn+En6hjuzJ4L/jURmix9+ynUkiCiP8lOn2Tgb7m7axgp1pG4esZ0XaOjydZMh20g60uEqWwPWo81TpSLdQ5IOAWz5r3ydKHuFlSjQevPyB0jMmA5zyt4HwA9PQ/PACN7sHRs2hZiz0fOdo3WtQ4CsvpzzyrlBWU86zxpsVymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EnmRmkZ8; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240828122851euoutp02b34d84638c524bf1d6e4f2e5325f9896~v5DzDb76P2856628566euoutp02h
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 12:28:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240828122851euoutp02b34d84638c524bf1d6e4f2e5325f9896~v5DzDb76P2856628566euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724848131;
	bh=NSj5vkqYTM3e+hX7IsHJ3VkGf9PQv0mvXnMfgqsUvYw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=EnmRmkZ87PTD/BkqOHcMJXWhBxP/ML1mz1TYVJL0mcUUQuj6jRNxLKjjRx4Udx6iO
	 zZ4eyQysgbFw7TUY0mVMiMnTIePZzlWDfApoV4gIKlm1RXcQEwf2k+0Kv3ZemiHWfd
	 PbsDMwb/sjJ8YKD8iQNd1EmkI2G5jbenK70Krjwk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240828122851eucas1p24f8b636bcedfe2f375d14f077fb10763~v5Dyq6FNw1791517915eucas1p2C;
	Wed, 28 Aug 2024 12:28:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id BC.98.09620.3081FC66; Wed, 28
	Aug 2024 13:28:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240828122850eucas1p27f050ad5fb011796b89bb90be353c417~v5DyC29y90037300373eucas1p22;
	Wed, 28 Aug 2024 12:28:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240828122850eusmtrp1115f8a027d7533c68810504c7dbb3b3b~v5DyCRr9W2497624976eusmtrp14;
	Wed, 28 Aug 2024 12:28:50 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-5d-66cf18031521
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id FA.17.09010.2081FC66; Wed, 28
	Aug 2024 13:28:50 +0100 (BST)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240828122850eusmtip2bc4934e9241c919a63c4619245f27d4a~v5Dxf06m01549815498eusmtip2G;
	Wed, 28 Aug 2024 12:28:50 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Mark Brown
	<broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Cristian Ciocaltea
	<cristian.ciocaltea@collabora.com>, "Liam R . Howlett"
	<Liam.Howlett@oracle.com>
Subject: [PATCH] regcache: use map->alloc_flags also for allocating cache
Date: Wed, 28 Aug 2024 14:28:34 +0200
Message-Id: <20240828122834.3778031-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djP87rMEufTDN4ckbCY+vAJm8W3Q2cY
	LZoXr2ez2N7wgN3i8q45bBb31vxntVh75C67xdwvU5kdODx23F3C6LFpVSebx6ZPk9g99s9d
	w+7x8ektFo++LasYPT5vkgtgj+KySUnNySxLLdK3S+DKeHD2O1PBYcGKa29uszYwvubrYuTk
	kBAwkVjQPZ8ZxBYSWMEoMXOKdBcjF5D9hVFi77/ZzBDOZ0aJA087WWE6Xh0+wAaRWM4oMWPF
	ZXa4lqtNZ8BmsQkYSnS97WIDsUWAOrZ3PmUCKWIWmM4ksexADxNIQljAU+Lrtz5GEJtFQFVi
	47oD7CA2r4C9xN8fsxgh1slL7D94lhkiLihxcuYTFhCbGSjevBXiPgmBHRwSK7deZINocJH4
	/7+bCcIWlnh1fAs7hC0jcXpyDwtEQzujxILf95kgnAmMEg3Pb0Gts5a4c+4X0CQOoBWaEut3
	6UOEHSWubdzCAhKWEOCTuPFWEOIIPolJ26YzQ4R5JTrahCCq1SRmHV8Ht/bghUtQJR4Sm4+Y
	QcI6VmLKtM0sExgVZiH5bBaSz2YhnLCAkXkVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZG
	YCo6/e/41x2MK1591DvEyMTBeIhRgoNZSYT3xPGzaUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
	VVPkU4UE0hNLUrNTUwtSi2CyTBycUg1MyxfOnTZ9dUa+9POahZ/Ywnvrejb6asRsaN7VJKjV
	/t/2jXFJfM4R+X+fWII3/Px29/2kO+EsHpuOp7ZJvuxTlLpyanHn484Axv0yKqEqHz62VG5+
	En/1mJWkiFb5MY3p9tPeVrreNFy91nP6ipNCpqeEvGNv3NP6K8GawGCwmaVsfmDnqledv4Lc
	ZqaujXcIsl4y6WbMbQPT+KaZSyfVqdefXP5yCnfixG26m1fMErm95+jtz11G86+aaIq//Pya
	1+7vjTWrHwafqNg71yd9oW3aL9uV84/z5tu96eEotUv5ra+7673B+YYJ2vO0Hy908PYx4N70
	d2KDyp9ZTxxfX70e/splZwaTndQsy28nWpVYijMSDbWYi4oTAYLt0wq0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsVy+t/xe7pMEufTDBbv1rWY+vAJm8W3Q2cY
	LZoXr2ez2N7wgN3i8q45bBb31vxntVh75C67xdwvU5kdODx23F3C6LFpVSebx6ZPk9g99s9d
	w+7x8ektFo++LasYPT5vkgtgj9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV
	0rezSUnNySxLLdK3S9DLeHD2O1PBYcGKa29uszYwvubrYuTkkBAwkXh1+ABbFyMXh5DAUkaJ
	d0s7mSESMhInpzWwQtjCEn+udUEVfWKUOLH5HztIgk3AUKLrLUiCk0NEwEziYOsfsDizwEwm
	iRMtyiC2sICnxNdvfYwgNouAqsTGdQfAangF7CX+/pjFCLFAXmL/wbPMEHFBiZMzn7BAzJGX
	aN46m3kCI98sJKlZSFILGJlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbAtmM/t+xgXPnq
	o94hRiYOxkOMEhzMSiK8J46fTRPiTUmsrEotyo8vKs1JLT7EaAp030RmKdHkfGAU5pXEG5oZ
	mBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YWpBbB9DFxcEo1MK1gjJ6Z/6C9USn/8MIf/qYn
	px50XshYukBNTvjmp8eVgis3cfSdjU7jv3H+hW2jg3a9ciPX3KLWqS46OxiWPV/Vpt/9N9tF
	QMJhTtXrJp2716x3qCis6C9ovsLFfihBo2R5Wku4b+DNgLZLs05zz4t4x8snn/o2dsKR5jXL
	wv+c4eRd9K5xB8Pp2J/5MXsKDpWvz5D5Zb34MENy1GKuhx+ife/ZmUcK93g/O3RlZcP6uV5s
	mSZrJk7fK/m22ej9ZOPvD9S2nri4tuqHrP4RgycbWqMnHjiv/oQ72uT504S9b3cwcq799Oif
	7WytFTsmvLnS7WzT7Mr4UitKZ+86Be2AIo1OD09tS+FZ7c/djiqxFGckGmoxFxUnAgDMAzSe
	CgMAAA==
X-CMS-MailID: 20240828122850eucas1p27f050ad5fb011796b89bb90be353c417
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240828122850eucas1p27f050ad5fb011796b89bb90be353c417
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240828122850eucas1p27f050ad5fb011796b89bb90be353c417
References: <CGME20240828122850eucas1p27f050ad5fb011796b89bb90be353c417@eucas1p2.samsung.com>

Commit fd4ebc07b4df ("regmap: Hold the regmap lock when allocating and
freeing the cache") introduced a locking around the allocating and
freeing a regmap cache, so adjust the memory allocation flags to the ones
given in the regmap configuration instead of the hardcoded GFP_KERNEL.

This fixes the "BUG: sleeping function called from invalid context"
introduced by the mentioned commit.

Fixes: fd4ebc07b4df ("regmap: Hold the regmap lock when allocating and freeing the cache")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/base/regmap/regcache-flat.c   | 2 +-
 drivers/base/regmap/regcache-maple.c  | 2 +-
 drivers/base/regmap/regcache-rbtree.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regcache-flat.c b/drivers/base/regmap/regcache-flat.c
index 9b17c77dec9d..f36d3618b67c 100644
--- a/drivers/base/regmap/regcache-flat.c
+++ b/drivers/base/regmap/regcache-flat.c
@@ -27,7 +27,7 @@ static int regcache_flat_init(struct regmap *map)
 		return -EINVAL;
 
 	map->cache = kcalloc(regcache_flat_get_index(map, map->max_register)
-			     + 1, sizeof(unsigned int), GFP_KERNEL);
+			     + 1, sizeof(unsigned int), map->alloc_flags);
 	if (!map->cache)
 		return -ENOMEM;
 
diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 2dea9d259c49..8d27d3653ea3 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -348,7 +348,7 @@ static int regcache_maple_init(struct regmap *map)
 	int ret;
 	int range_start;
 
-	mt = kmalloc(sizeof(*mt), GFP_KERNEL);
+	mt = kmalloc(sizeof(*mt), map->alloc_flags);
 	if (!mt)
 		return -ENOMEM;
 	map->cache = mt;
diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
index 3db88bbcae0f..188438186589 100644
--- a/drivers/base/regmap/regcache-rbtree.c
+++ b/drivers/base/regmap/regcache-rbtree.c
@@ -187,7 +187,7 @@ static int regcache_rbtree_init(struct regmap *map)
 	int i;
 	int ret;
 
-	map->cache = kmalloc(sizeof *rbtree_ctx, GFP_KERNEL);
+	map->cache = kmalloc(sizeof *rbtree_ctx, map->alloc_flags);
 	if (!map->cache)
 		return -ENOMEM;
 
-- 
2.34.1


