Return-Path: <linux-kernel+bounces-574703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F67A6E8B3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48ED9174159
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF9C1A01B0;
	Tue, 25 Mar 2025 03:29:34 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4FD19E971;
	Tue, 25 Mar 2025 03:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742873374; cv=none; b=fSchqHe9YKczBb3uU10jKGFW0yeVuemPZmx2B/+oK5H0yhxmElIFQsMj2ezTMyfHZo1OGUNeqe7b9C1MiySRxkhNjFusuBdRkN+Us0v5gMwr0zTGXGyyF4qHTbF6mTgxEi8qN5sBm/+RAN+5X+zDKKaYhEdrjKbcWcjOMOTZe9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742873374; c=relaxed/simple;
	bh=6o+CHdy5QkJF6edUb3JpjX3/cjxJ13Pr6UqZX3sCqE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=glZfM2rSwdifUfnzoWXP9lZD8lXX/XymoDH/8aEef1cNIqaHN1MiGR40GHl3+4Mj3CcjSHeM2vcqBSdNbLtWvMNzTGmR9Trux3d11XttK+U/4e+JlGIy2g5d736P2xpp1vcHjzFMJB9fuuTqMkJ5hXAhbEwPH0iflvDjlAhuvfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowABnowsJI+JnbvMuAQ--.961S2;
	Tue, 25 Mar 2025 11:29:14 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	ckeepax@opensource.cirrus.com,
	u.kleine-koenig@baylibre.com,
	megi@xff.cz
Cc: linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ASoC: sun8i-codec: Remove unnecessary NULL check before clk_disable_unprepare()
Date: Tue, 25 Mar 2025 11:28:33 +0800
Message-Id: <20250325032833.604073-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABnowsJI+JnbvMuAQ--.961S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyrKrWkZry7Kry3GrWDtwb_yoW3CrX_Zr
	48uayDWFWUJr9Iyay3Jr4qyr4kXF1F9Fyxtr9ayrWDJ348Ars8Cry8tw4fur97JrykCF9x
	Gw1qvrZrA3409jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbakFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjfUrrWFUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
Remove unneeded NULL check for clk here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 sound/soc/sunxi/sun8i-codec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 8b9eb1a202f7..a27976c375fe 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -274,8 +274,7 @@ static int sun8i_codec_runtime_suspend(struct device *dev)
 	regcache_cache_only(scodec->regmap, true);
 	regcache_mark_dirty(scodec->regmap);
 
-	if (scodec->clk_bus)
-		clk_disable_unprepare(scodec->clk_bus);
+	clk_disable_unprepare(scodec->clk_bus);
 
 	return 0;
 }
-- 
2.25.1


