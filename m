Return-Path: <linux-kernel+bounces-386599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E086D9B45A2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FA728107D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E491E0DF8;
	Tue, 29 Oct 2024 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNOubBWC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC83C1E0DE8;
	Tue, 29 Oct 2024 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730193850; cv=none; b=d5kWV/bkx77H3YepRKHe3YA6ZQhrv5x4agNbXg8clMq4qCH6GgpMionhxXaRanJy6uAi/pb5O1RmX+TeGgY834ocHcZJ3USDBqLsvNGNznBGLVlQABpIQwLp3NaN7t5He7jdK7A5Lsg2BaRsqt3MuDDP0j7yYDB9R0YpjeFvt1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730193850; c=relaxed/simple;
	bh=JoDMUIR3MZLuq4faH5KVEmV75jGiFgkHynYnnIuBz38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kVfxlKmqd5I+TEGSYr/VMIjm0sqXxnG3Z0hyMmR4fpwT7nw61VAsbUTt0v68l3zKWVsWCGZ5sBRs7hpgIoB4LqQS7kTZihq4fHo8vhp+cTe3Dd94shaVw7KJyR0cbalfUV+Ozy6UQtuz1aI6PmFqNVay+j3w3GSQ9pMNgPJxGLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNOubBWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3957AC4CEE4;
	Tue, 29 Oct 2024 09:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730193850;
	bh=JoDMUIR3MZLuq4faH5KVEmV75jGiFgkHynYnnIuBz38=;
	h=From:To:Cc:Subject:Date:From;
	b=fNOubBWCFB2I3ZftKwqgsiXYTPpwcAjtY0E5ldrJw6Rx+PiwBfgpbNVCVhs1iOLSj
	 MdwMxMvSbpiwh8wq3ag/ZbtXr/SI6gmVNciBQT/ZRPo7355w3qRpgsYnf4536zvTnv
	 /uQ+evOE3B22xpVi3sVyUT+P0qR3zG1Ld6sTaEjc+ZRibAdq39NLZ7+Xc0tksh53p2
	 3o1jxNIqJlEB/L4s02E9Y7VYIKZS0f+ckyDaJICIapkhvxoqUGLIpuXYNgD1RjkQfg
	 q8zhlSPp+oXzD3UvZXVECfMEbGhM3gy1oCvN13WJy5IWXSUbNetRWMfj0VppeVhl7F
	 sTI0lc0I0CvHg==
From: Arnd Bergmann <arnd@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	=?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Neal Gompa <neal@gompa.dev>,
	James Calligeros <jcalligeros99@gmail.com>,
	Hector Martin <marcan@marcan.st>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: cs42l84: remove incorrect of_match_ptr()
Date: Tue, 29 Oct 2024 09:23:55 +0000
Message-Id: <20241029092404.3874040-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The use of of_match_ptr() is incorrect here and just causes
a warning:

sound/soc/codecs/cs42l84.c:1084:34: error: unused variable 'cs42l84_of_match' [-Werror,-Wunused-const-variable]

Fixes: 250304a0fb34 ("ASoC: cs42l84: Add new codec driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/cs42l84.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l84.c b/sound/soc/codecs/cs42l84.c
index 47731cdc0e67..d176add8c4a6 100644
--- a/sound/soc/codecs/cs42l84.c
+++ b/sound/soc/codecs/cs42l84.c
@@ -1096,7 +1096,7 @@ MODULE_DEVICE_TABLE(i2c, cs42l84_id);
 static struct i2c_driver cs42l84_i2c_driver = {
 	.driver = {
 		.name = "cs42l84",
-		.of_match_table = of_match_ptr(cs42l84_of_match),
+		.of_match_table = cs42l84_of_match,
 	},
 	.id_table = cs42l84_id,
 	.probe = cs42l84_i2c_probe,
-- 
2.39.5


