Return-Path: <linux-kernel+bounces-404578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894399C4547
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E904280C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5468C1C243A;
	Mon, 11 Nov 2024 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dl1p6z7C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB551BD9F5;
	Mon, 11 Nov 2024 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350903; cv=none; b=rcP+yylFYLLNuVBFvUM14yfkQucxlIvt26ddRWMb++YjZUkEZirOPpHrq/GQ5YvIHQnd8kCH1gfq62BKUiisvkHZsAqLv2NK+TVY2t/kszg3uyXhkJQKOQeCsGLQbr5G60qNVJH5PKsMTA3wayL2RXenAYFLzzG5rsL/uV9b5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350903; c=relaxed/simple;
	bh=/VGPM1lIfmncGp/2f1BDRSjqET3DLP/Aly9ABRjEv+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQHljA/qunY13fmGlXO8vVTQOjUDoQsZZGp1/Ls4RJdN4qz/0PWQ7VL1NYI5hFntoZOK9mhbNSWqs2sKHWOWvvUcqlqXSBszyOY62NaRrmmpAGDh45dBs7Q2gQD7VqmrqJ4Mo2bAm4F0XBJtJFq4r5jLsDuLVptCJKm7npeJ7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dl1p6z7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2EEC4CED4;
	Mon, 11 Nov 2024 18:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350903;
	bh=/VGPM1lIfmncGp/2f1BDRSjqET3DLP/Aly9ABRjEv+I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Dl1p6z7CeMJZjxL++5Ga4XA8Cj99pQIuzIlvOyizThSMiNnDYv1Yylb6ayKFDiBU5
	 11MRcEGK949hoiJwdYUHyc+OoENUbn52/ZZxrYqx/Dqhosg65A2N+z/c4j6h9HQ6c7
	 MyajcGIqY5MLp7jsApQyb5qicYCRBmtWJbC8OHO7vxwjkOLjLVbxfY09/7CFgHbwAk
	 CUJNivq3d0hhJCwc8ntn592uX4FO2op57CM9w+VMacOR3spWoN8f6XZsqPSnm5IHd+
	 ZoRvYG2wS1dMMzlSs1loXgmAJ752yjoqdzjis37WEV3J85K1SHcwbonvYl0mIa0Ez5
	 JO/ICQ6q09M2w==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:44 +0000
Subject: [PATCH 12/17] ASoC: max9860: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-12-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/VGPM1lIfmncGp/2f1BDRSjqET3DLP/Aly9ABRjEv+I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFg4RxegiDgvqgj6l0rHNPU2sysn+08CSt6E
 sPoFvEnIcCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRYAAKCRAk1otyXVSH
 0D1pB/4px8zD71179rsfpZV/ml99KLgEO6FgWLimrrX4kiY9idjnT3ntHUMmxxPoN2+0Dao6tbd
 jBNcvfdALV8VU+5lpwVkd3O7424CHPu0atxuNmKZq4MrEdtxdWpXGTqVoXUR9hJ+XbsnsNTLbUe
 OawHszIJhywdMUCu4MlS42a34xsSvN3T3XOQiVNuR4f3P4+EWjH9icgfT76LWswlT4HEPsPj9pR
 sc4OBGzyXe1yLR4ml4ZQu2B5nmJGr9scvlNMT/bZoqGY1s+IGtphlLk53XIMeHtPvri+YHFtpWq
 h5Yy+r2ErE4xjdBo7Y3L6A//hwjLn+gZdUi0Uu26J4ImiJFc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9860.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 4015ed2c47ecfe6410bd8a42428579844f803103..7a5c2828ecd1b2d12def27b073f1ef25f301e803 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -120,7 +120,7 @@ static const struct regmap_config max9860_regmap = {
 	.max_register = MAX9860_MAX_REGISTER,
 	.reg_defaults = max9860_reg_defaults,
 	.num_reg_defaults = ARRAY_SIZE(max9860_reg_defaults),
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static const DECLARE_TLV_DB_SCALE(dva_tlv, -9100, 100, 1);

-- 
2.39.5


