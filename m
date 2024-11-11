Return-Path: <linux-kernel+bounces-404576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E109C4546
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF72D282B22
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3781A1BDAA1;
	Mon, 11 Nov 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0EqHnA/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939331BD9EC;
	Mon, 11 Nov 2024 18:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350900; cv=none; b=d5NkkyJdq3fvgaego2ij+JVXXUSBnEX+DHpjGVCfCHIB63AgJ30xLh5WklnSuKHSupR9i/m30933TSkE3vAkFCN9c1nuYR/c1uY/f5ervwhkIBhnD6u2GRtSwURUU2NBn5uteokYRJRb/CLudZadU13XCPL4JlS3wJzkIATeTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350900; c=relaxed/simple;
	bh=2Yw2lyGhOM67zJI4OO0X7e4T+eCJzeW7+KHB/QyTw5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GdxELsNsi1t+YFowyGHRopT2cx66LLKzj5bKypPlswYYiKgPdiWRopTjBjglj4O/pJGPxhqmbHB0E7CPShzehHWkdyVVnn8U040NW+VEnnEq4+Pwc2R02Ou7j85Zb5UOAyNAHXCZv24PYIMA0wCwurV9HWixVPGRunk/Az76b1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0EqHnA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6457AC4CED4;
	Mon, 11 Nov 2024 18:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350900;
	bh=2Yw2lyGhOM67zJI4OO0X7e4T+eCJzeW7+KHB/QyTw5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y0EqHnA/Cse72QjgsgkE7bxdrz4XkTdlfu1iraq32nCOwT/k1XjV22qneUCsfth5B
	 fe+kCi+Gy7GxRsLBYQ0mztiwnRGaYfq4u8E04xyH0oY3pqFvoLZTMYgesK9AFiYFCW
	 TrHrt52j7hZyfgOegGZ/mKWcHhjOWt76rINdIXON8LgEeWuNOY5aYZ2aRAMoAdwuNj
	 dE2Z75iliHm2RDKzNnrnFSyFljPAioixp+Ol60GFbs3m7kybJ75/IL5/1Aopt0yXtG
	 35R43qvqcnaTOwpiKQwIMpVc7rukevmPlSymGzlig+FavJxw0PUmRQu2a7Z1piLMuk
	 uTucB9rrGxQhQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:42 +0000
Subject: [PATCH 10/17] ASoC: max98504: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-10-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2Yw2lyGhOM67zJI4OO0X7e4T+eCJzeW7+KHB/QyTw5o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFfZQv8n0PwZxZxDFnoaGbqbu1sN71fgjDF0
 x1sgnYydNSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRXwAKCRAk1otyXVSH
 0G5aB/9hSeUX2b9G33sQzX11HqmcBTeUGhoSoCGGZm+DRmG20jGSA9SWXvpbmwgOfM2gblYhNIY
 rVx/W+fY+5ztO5N9+DmalkD1d8sKQsUj2Al6X0J2q4pPIP6GJZNZlBDo/SRKvHTH4YgbjtHJjMT
 crLn2CNZdCu+ibxmWboOJvoSWJWgSpKjpfTD4r5MET/1Vg1qyZjOzmwewXKblTLzis8v5p42hqu
 +Rhk/hNfJsE682/aKMbprYTNExiYDdgo+z2nqz/1XFOYxoD6nsGWz5v2VnJQ5C2QzCFC21KMRCq
 8dmRXqwVpuT6FEF0GI/Iazwf/zLH1qmZwLr6oRQhXzFw8bnH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98504.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98504.c b/sound/soc/codecs/max98504.c
index 6b6a7ece4cecc3d114da276faf859c8176955300..677d0894e058c5e84f3fc591fb8bdc02eb8d5633 100644
--- a/sound/soc/codecs/max98504.c
+++ b/sound/soc/codecs/max98504.c
@@ -304,7 +304,7 @@ static const struct regmap_config max98504_regmap = {
 	.num_reg_defaults	= ARRAY_SIZE(max98504_reg_defaults),
 	.volatile_reg		= max98504_volatile_register,
 	.readable_reg		= max98504_readable_register,
-	.cache_type		= REGCACHE_RBTREE,
+	.cache_type		= REGCACHE_MAPLE,
 };
 
 static int max98504_i2c_probe(struct i2c_client *client)

-- 
2.39.5


