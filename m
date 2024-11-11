Return-Path: <linux-kernel+bounces-404570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4A39C453F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C82283C15
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1431B5820;
	Mon, 11 Nov 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwcbDg4W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BC31B4F07;
	Mon, 11 Nov 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350892; cv=none; b=Sk2gv1MoZQc0qWqiLlOYP/jJxtl1blT7AuIL+pSZ2fjLkWXBAnA20mJwo5m22Qx0EozjEPm0ImukttZNBSOORL98QZlAbZzVtWJz0rfr51vFbqdQtGRUt34mIQotlCyywGU4inv6kdUGvtF48woF/4IOzb4xYKVWQdxOT15Z8KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350892; c=relaxed/simple;
	bh=yZmvs72JMY4eSHLvqTqyVitaqpycTPD6SJgB3sKvS7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rIF8MvVo8XPabg7F6fx9GiQ/8TRAhPT59a2clximLk41Yp7Zs/Psdfaexu/b6KiQ1QM4TXEaM1E3nmxSUvrwKhMZcpLrNr3MW9Km7HaFF8kCH/NWVokcyjRvWibt1/twEmhG1MPmDJJFINH+pyTtSB3FU2jEfGLuL9FcuTBGJPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwcbDg4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E012DC4CED8;
	Mon, 11 Nov 2024 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731350891;
	bh=yZmvs72JMY4eSHLvqTqyVitaqpycTPD6SJgB3sKvS7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XwcbDg4WskA63o0c8ROVVbsRPcTi4iRHJIbFqsEBYt5MFt7f2njX2ITqn52wkaf+w
	 DvQVR1WWKhrh8Z3c5o0wExfRecMiFSOrP/WmfQNWhY5JZEfAmkdYhdaLWTQpEoCc+J
	 IwhMPJ7vQfWBTfZVjc3ZnamyXxBXsrt9csJ52wRanCvRn2sYGhKkVNQMulxTVGZYpa
	 pXsuJcRmK1E0UG44HYvSMrFnZ5MJqerQ0jw8KEhEgiCnrNirBglDic5gzomHrJf2Jw
	 o0IP1U77rvLPNzmJTaSe0csu1pGrpq00Ov6g53wArfUa+3+dzIPJdHoqGuhtHQMZli
	 I/hup9RjbwEnA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 18:47:36 +0000
Subject: [PATCH 04/17] ASoC: max98363: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-asoc-maxim-maple-v1-4-baa315dc546b@kernel.org>
References: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
In-Reply-To: <20241111-asoc-maxim-maple-v1-0-baa315dc546b@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Peter Rosin <peda@axentia.se>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yZmvs72JMY4eSHLvqTqyVitaqpycTPD6SJgB3sKvS7M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMlFaRocN7TGcVl7TbsOhP9BFxcQ58yCOSUDrE
 fjJB+qbzoKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzJRWgAKCRAk1otyXVSH
 0BnSB/wNFiSKqNv2CgsL2h+YI4tCzZJRDxlzcpzl7mDb57rNQv6EyjN4SH854WJnmjiKxpBqn93
 hJxzWuzWs/B1uRhGZMBQbJ8HQFZNrOK0oRl0wdkyInib9Rg8UpbP69apjEoJdeLcK182jccDjmr
 K4uB2mg7grt9LRjJjeWKmjEabOBJxdYNUOrGnwp6z3PtI5/qvDvbpGePTcJTwp2FNrBxU5G16A4
 Fa8gqCpyDNgLRDBhNYctMtYh9i8XSyAfEnLsNLFPtLMQdvvZpUptLZ+GnF5Gq5mytAWpht8fbZg
 pP5FdobMmUIxamp1+yYZWej8tJ86XmpRiY5Pa2p/II1WCEr2
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes optimisation choices that are more appropriate for
current hardware, unless there is a specific reason to do something else
then maple is a better choice for most devices. Switch to it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98363.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98363.c b/sound/soc/codecs/max98363.c
index 950105e5bffdc2c7606e10e7af6f3cf97ece5b4c..af50ccb1d8dea69446d03f0dce993241ffa89098 100644
--- a/sound/soc/codecs/max98363.c
+++ b/sound/soc/codecs/max98363.c
@@ -69,7 +69,7 @@ static const struct regmap_config max98363_sdw_regmap = {
 	.num_reg_defaults = ARRAY_SIZE(max98363_reg),
 	.readable_reg = max98363_readable_register,
 	.volatile_reg = max98363_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 	.use_single_read = true,
 	.use_single_write = true,
 };

-- 
2.39.5


