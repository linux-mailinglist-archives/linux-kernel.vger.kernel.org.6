Return-Path: <linux-kernel+bounces-404575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8929E9C4571
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDD1B2820E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279C61BDA9B;
	Mon, 11 Nov 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icJJ5Yoo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841961BD9F5;
	Mon, 11 Nov 2024 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350900; cv=none; b=q4gbDa7rb9/eR0AXieRupvtnk5LOXZsTuEdyG5hKFJWQOIjnybkNpjSbfN8oKnmoJuUiWjRbyONa/0t/BudIK6xxayBbXH75DfaMGb8so9NvQyR2cNX+OLlKQHrffA61UF1lIy5YTipxRfTXVo76BLECuOK4p6tqnS8ffR3C9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350900; c=relaxed/simple;
	bh=T7siN2OD1nhjgEqSbG9tSYiPQ8u74NKBqDYBKUBHj04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLf/0dXdeimd7Or92mB9noeUF5Wbws9PittSCIiHmjfBSRVX+sQdgVuMQUru/vYEzs5S4Jt0ZyYWlzJzf1xH60iUuXOjUXYXAbPQjhVoon3JMmsoJmlBTEp2y7gqFVovNOb0g+ux9876Yo8Ai4Hhvscz1ag7NA5LLo8/ArIe0wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icJJ5Yoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FA5C4CEDA;
	Mon, 11 Nov 2024 18:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350899;
	bh=T7siN2OD1nhjgEqSbG9tSYiPQ8u74NKBqDYBKUBHj04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=icJJ5YoopY5gPUJ4qeGqYOBz5M2FFEe+QbJLSY0k5L9QbSCQgwtC5YD12R2WDvDzc
	 gesMFonQYpjsq9ic2BfrfCMY8aEXd0GW1aW304bSeH25/TO1PBUinXI3r13Lmm3icj
	 hzsUzb2uQDi2lDwDsG2X6ILDM1QR9bpvTq8NH1ec+luu34PrODSY8XbaAGnpv3rMOt
	 WTXHb/vijX7Davj/RoceLK6hzA4CDJ3+nroG/kpwRVoEJasZcAX3hrKnMkEIGt8jYT
	 tq2L5l1PXGkjQBX9z42agOWV8D9fwj3DfldF7IgvpkfWQZB32m6t0Of6b2zmMnZdPJ
	 gbSk4D1I+kzZw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:41 +0000
Subject: [PATCH 09/17] ASoC: max98396: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-9-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946; i=broonie@kernel.org;
 h=from:subject:message-id; bh=T7siN2OD1nhjgEqSbG9tSYiPQ8u74NKBqDYBKUBHj04=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFeUtsLNdob01i/guV+udMz7ks1x2BIAM9x0
 eTf/KTvu12JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRXgAKCRAk1otyXVSH
 0FVhB/0Q06SsY5TFdXTF/rIoZQ+p2C0g1bbYJTlcEl0N2g31sxrBPv4UYyTp2JbCPPXglneTDZM
 66XnQ73hFBnAwMMvVPuwe9Xr6knkXUWaE9hk06wGbrQ8IxN4o64uYZJLgZ+eudhbSoB74TcM1L0
 oO+hVFnhdF5SlcVJDQ+FMOodsD5Q1479fBbRD6YhVOzUo6/JxbkveMdt+MUNsFuwLasJTjqPqFC
 FjSeNiggCNCw54Em1u29H8vZxtveKi+F9uqiK6NtqPJWiK8u+apwBDv5P1INg2aDzyU9wPEpAAf
 2q3syKIZ/oHjQQYs+KP3RwVmItIaL9+wdn+hO6b7jfuEIKOY
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98396.c | 4 ++--
 sound/soc/codecs/max9850.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98396.c b/sound/soc/codecs/max98396.c
index e52bb2266fa16792ad5dba79c515b5900ade4b2a..345e04da6d3782b296768d836eb4717d1ea39f7c 100644
--- a/sound/soc/codecs/max98396.c
+++ b/sound/soc/codecs/max98396.c
@@ -1656,7 +1656,7 @@ static const struct regmap_config max98396_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(max98396_reg),
 	.readable_reg = max98396_readable_register,
 	.volatile_reg = max98396_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static const struct regmap_config max98397_regmap = {
@@ -1667,7 +1667,7 @@ static const struct regmap_config max98397_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(max98397_reg),
 	.readable_reg = max98397_readable_register,
 	.volatile_reg = max98397_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static void max98396_read_device_property(struct device *dev,
diff --git a/sound/soc/codecs/max9850.c b/sound/soc/codecs/max9850.c
index c395132689b4ef2e0bca6d1e9a2f3da4990b8600..9ac0b045bc619cd9d55a8083e88a4c2b78fd8cea 100644
--- a/sound/soc/codecs/max9850.c
+++ b/sound/soc/codecs/max9850.c
@@ -46,7 +46,7 @@ static const struct regmap_config max9850_regmap = {
 
 	.max_register = MAX9850_DIGITAL_AUDIO,
 	.volatile_reg = max9850_volatile_register,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static const DECLARE_TLV_DB_RANGE(max9850_tlv,

-- 
2.39.5


