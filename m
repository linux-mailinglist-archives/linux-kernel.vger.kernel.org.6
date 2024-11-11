Return-Path: <linux-kernel+bounces-404580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A569C45AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A876B250AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31271C6886;
	Mon, 11 Nov 2024 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xjby3Xqh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C31E1C4606;
	Mon, 11 Nov 2024 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350906; cv=none; b=mDxDOl1L1U4PbZ3JVh9ZqDMserMxTfiAc+9YYUcu9zDiFyJ+vxAMgJkUQfz7DYJ01mIwuHKOd7z2wOQhk8Ffm4B3Ke5JrZsVSZKENtcQJtxN+P33xM2g9WBx/zjSesCPObhhlWReLDEJSbZVwlNRvyOjvofR5TkGSYvQQkQeK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350906; c=relaxed/simple;
	bh=+3ubjYkvQHUxzUP3STGWBXiumeVjpy8z8oic4cgcUZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DowroTPJS1vZ6FktT7kPhXi/7r0KeBQpCukhyyQMnf6LGz2mmTH4vn4yUEIxVc+QHQgt2TgJmWGz19E7Wit4kN7EK1/9uohRpvkyL+wI1fn0Gkd/AAxpzpKfEA2ElZqPelfL2YEBX1MC8CpUcJHSQsnBfNlKFMAFwIdFF/iwu34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xjby3Xqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C57C4CED5;
	Mon, 11 Nov 2024 18:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350906;
	bh=+3ubjYkvQHUxzUP3STGWBXiumeVjpy8z8oic4cgcUZk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xjby3XqhYiGu2w3g061H9zdk8pDh86btj0YtJM2RAkqZvWVi+2xdOsXoZUcTf90d/
	 GjZeCaHwpFX0oe2q5K6i14b8Xm8C4WUyszz9MTv2HnjlkMlIU4PMgnulq/ApRGSWhu
	 JoPkPCcqeVSCbzRnzmNRV1+3jf1r20XdQ1SVQWn9cHHy3CiMzX0WVzt070DPD0Z09x
	 cjkmm5zOGBnS2sebdZaC+1KH2HjcfFhHgMnsP1RsGSvQVMhTX6hc5s9nuwL0biplf2
	 60eKQIqqywqVDOMr+/n/vFVRSPdaWI2/BuKRr8fRAoigrOTIyqMziGivCpUTZKh9uN
	 S6lqmOYh+ceBw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:46 +0000
Subject: [PATCH 14/17] ASoC: max9877: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-14-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+3ubjYkvQHUxzUP3STGWBXiumeVjpy8z8oic4cgcUZk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFiT+PebAfKcSQE21txTjf5e9MvOTsJsAXip
 l8n8DOILLSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRYgAKCRAk1otyXVSH
 0ANdB/9Meugf0ABjz97u2Y6ZlX++IsIDIfuJ14Q1hji2wRZVCAQS//AXPXxAmEbB2uehokI1vbC
 FWfMc0aH5vX6GpubY6KvoloN/1AuEOmHPlhReWUjcBCCDxN+pEBppf55QcuPYHywi974CeVpUxC
 51BosVJUW+s1t1jhJoQ3NjqVQupBJ+WMTQKKwx+Vf52Xs91HRiBeMTvwk/YufWqOZ1CeMxE+cob
 IT3hZLdrxRu9B/b/n8FjSHlKxju24+Krm/XUnoEqDUu4fLWKKLaYo4+K1IcBmU4AKviET6Ms5OV
 VIErWcOTjgOgXsM447tjpuJ9RGeTMfTCXfSvHMzTF20lquhx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9877.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max9877.c b/sound/soc/codecs/max9877.c
index 1bd0d4761ca67df94cf2a0bfdd0944129e431504..6b89bc30b2c9a5046c1d7cc52df38bd87c2e94cb 100644
--- a/sound/soc/codecs/max9877.c
+++ b/sound/soc/codecs/max9877.c
@@ -130,7 +130,7 @@ static const struct regmap_config max9877_regmap = {
 
 	.reg_defaults = max9877_regs,
 	.num_reg_defaults = ARRAY_SIZE(max9877_regs),
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int max9877_i2c_probe(struct i2c_client *client)

-- 
2.39.5


