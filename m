Return-Path: <linux-kernel+bounces-547370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AAEA50652
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681FB188AFA9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730FF250C02;
	Wed,  5 Mar 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9OCdmku"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CEF1FCF4F;
	Wed,  5 Mar 2025 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195663; cv=none; b=Ps7uvTt0ctiSri2gEqWrk39Aqb0IV74jX7qyHkCied3k/5tEbBsEn4GSkyg8io5PUpqADLE93gFzP2BOA4SlJxS4gLRMEAyg2YExKOJGwdt9GA7d4FEBGoTd8G2vrQ4PZPqYo5uhet1pyX7EhdyfpEUtXoHdq8LOlr79H9hokeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195663; c=relaxed/simple;
	bh=y8aRWtvYgzTCA8bPSW+FmeuF+48CDqkeacK98qix+OI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=opSYPpuMoGA4FEYvIa+39Qr0CVCdGsZDimo3c6Qfh8xXt31IbSDDAObC6pKRGETagNArT1Xc9i2oC2NfNj91dB9kEZWinkAsQoJIIDl1Awx6Vgoyn8e0rpyHjl+1oDTxORq9zFIEs20lhHOqR71z544Dqvf2UGQ/oAIXB9PZ34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9OCdmku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E6EC4CEE0;
	Wed,  5 Mar 2025 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741195663;
	bh=y8aRWtvYgzTCA8bPSW+FmeuF+48CDqkeacK98qix+OI=;
	h=From:To:Cc:Subject:Date:From;
	b=b9OCdmku55fNor7AKvw2qISbdb24upXR8KXWbkVp/bSYuGMRVngSFZq74WUkbzfdQ
	 Bd1SMZ5qRMqvmywEA+Q/07XsWfayN/sp2F2dyCF9CXplW6M9Vz2DHGoukrVKZfXHJq
	 ZgjQ/m+NBA0lyyUl+SKuS4FEeEcMvQHiYzfl4/Icq5TOKGSJ4luDGhksqnoaJl17tL
	 7O71STpsBiZ803Kdegj3UUBvoHNqIcrjlRi5Nlfo7UIoaLMa91NX/dNMi22XaxYQ5B
	 7RjnPXV1v7FrxRTtBG3m5AGWG7Qr3t4sWzow5JN2kvhYI1oPn0h97FdrwRRSqPI3Yq
	 Oeixe8KnqUfOQ==
From: Arnd Bergmann <arnd@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: cs42l43: convert to SYSTEM_SLEEP_PM_OPS
Date: Wed,  5 Mar 2025 18:27:32 +0100
Message-Id: <20250305172738.3437513-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The custom suspend function causes a build warning when CONFIG_PM_SLEEP
is disabled:

sound/soc/codecs/cs42l43.c:2405:12: error: unused function 'cs42l43_codec_runtime_force_suspend' [-Werror,-Wunused-function]

Change SET_SYSTEM_SLEEP_PM_OPS() to the newer SYSTEM_SLEEP_PM_OPS(),
to avoid this.

Fixes: 164b7dd4546b ("ASoC: cs42l43: Add jack delay debounce after suspend")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/cs42l43.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index 4257dbefe9dd..e0d630c262f6 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -2417,7 +2417,7 @@ static int cs42l43_codec_runtime_force_suspend(struct device *dev)
 
 static const struct dev_pm_ops cs42l43_codec_pm_ops = {
 	RUNTIME_PM_OPS(NULL, cs42l43_codec_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_codec_runtime_force_suspend, pm_runtime_force_resume)
+	SYSTEM_SLEEP_PM_OPS(cs42l43_codec_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static const struct platform_device_id cs42l43_codec_id_table[] = {
-- 
2.39.5


