Return-Path: <linux-kernel+bounces-404572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C12F9C456A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 807E4B2C1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D121BC072;
	Mon, 11 Nov 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQMpcNb+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0BE1BBBE4;
	Mon, 11 Nov 2024 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350895; cv=none; b=HZq/5o2Ju6MbNfQXbj8rxcr5GsyK6u2SYrN0dYyKg+WYHecCoUt9ilokl60MM8vcB2IYTIX5pCNCPGDGXzPAx3PhQzT9ngv1INvTB09injidUW7yoEFzUSPdVZxwnbP4M75tac2tL+MRhb1gQ1ECZTsWJeeNRvwkIe7JXfqs3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350895; c=relaxed/simple;
	bh=k6wy8EQWzS2K8sMVS1UFAVp0qKC2sLxEjXqMbWHDy+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cm5LjioV6lR3vibkacFo1Igo5RKPARg3TdSs8kubY+w20Y2vldfoMZDUXJGl307Fz3jKtS3cnK+kc7IC8DfxdFZHE3AOW2fLoMQGXjbbum+1xnbtvpm72sh7lGUNeQowwbRscP2wDfH+vzbho3bWRRQx6LvXHeJosp9Xt49IM0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQMpcNb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FC4C4CED4;
	Mon, 11 Nov 2024 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350894;
	bh=k6wy8EQWzS2K8sMVS1UFAVp0qKC2sLxEjXqMbWHDy+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QQMpcNb+oxz73OpwzAx7Kf8gL3tMlK2eUWASzFrX84R3LWz6gUgTaumHMgb8QmhZr
	 Otrqkwx3xS/8qKQ4fFBRREV+KWxCon2396WfLbapGJeiTw+iTzk4jxwAdswz6X3vvR
	 brNE7zA6G52907GwAM0xw6bqH7pVB186be+ITPwjHRzJ4QTNoHgXBS1G/JQMI2EcMt
	 urSY8FnYoefwGANeBHeSWAhKqaBnjAeaSL2dQxQ0Rl9s6Zt5eQjVIBmfYL9QQT/L+a
	 FOk//WIIAqeRLcBY8B6/HtcSCLWEszZbFyQxbOD+kJfz+W595BeRahjA9mLehgbTZp
	 XcbsamB6qIreg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:38 +0000
Subject: [PATCH 06/17] ASoC: max98373: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-6-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691; i=broonie@kernel.org;
 h=from:subject:message-id; bh=k6wy8EQWzS2K8sMVS1UFAVp0qKC2sLxEjXqMbWHDy+s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFcOWySOw1uLZGYyhpmye38Hx1rCy4H4nd9j
 NnETXA3cYyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRXAAKCRAk1otyXVSH
 0AOeB/9rFtWlRpDC4x2pRu1f3sxFxdPumrJM6ggNcW03oiTq7rXSTOW16mG7InW7jAbkuKmphyX
 gXcE/pggwYYiBaZC4bSHzG5nDnDQmsNhaT7v0/FuFC+iZA/mZUIyCSOzgjtgOu3FuQI5PaSoxQJ
 65SQkWKHpXPgxbw4GPMXw/gsVOkGhe7aa8TYkzK8M23M6WvqDhmzc2ImFkc158jpilTAwfxaP3U
 8MSvponHZcKDJKXvA6urRTonvzDdfUVqmvD/dD5X0BrFIz7/q/mh6jDMze/HH5X+ai2wfRCFq26
 0q+2zHEhc2KLlWucKC34wpepybDR9yVXULhWagOjMQFW7Vf0
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373-i2c.c | 2 +-
 sound/soc/codecs/max98373-sdw.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max98373-i2c.c b/sound/soc/codecs/max98373-i2c.c
index 1f7ff3dbcbbebd604ab51b8c4f8ca567387630b1..a1555f5aa9887c990eb23d6c0af2ef5365de25b6 100644
--- a/sound/soc/codecs/max98373-i2c.c
+++ b/sound/soc/codecs/max98373-i2c.c
@@ -510,7 +510,7 @@ static const struct regmap_config max98373_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(max98373_reg),
 	.readable_reg = max98373_readable_register,
 	.volatile_reg = max98373_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int max98373_i2c_probe(struct i2c_client *i2c)
diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
index 26860882fd91aa7611588f2822b909b296dd39b5..89298b9f6e203a021438debd990eabf4c1d75a65 100644
--- a/sound/soc/codecs/max98373-sdw.c
+++ b/sound/soc/codecs/max98373-sdw.c
@@ -240,7 +240,7 @@ static const struct regmap_config max98373_sdw_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(max98373_reg),
 	.readable_reg = max98373_readable_register,
 	.volatile_reg = max98373_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.use_single_read = true,
 	.use_single_write = true,
 };

-- 
2.39.5


