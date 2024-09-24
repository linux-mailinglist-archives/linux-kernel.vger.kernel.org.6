Return-Path: <linux-kernel+bounces-337218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A2E984721
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A121B1F22020
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC321A76A8;
	Tue, 24 Sep 2024 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="All2FbVc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AC01A7ADD;
	Tue, 24 Sep 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186336; cv=none; b=C5tNOtHz4/EVAQ347co+1R8yI6OMfzDj0pLK9UeXSr1YaT1Yqteozbxc3ArE+unbqmNhXc8sqzr0GfshyMpUGmykwnUOxEwRt9TMDaXTkLPmcbfLJZamwJzPnpT9Aw4c3HDFO9yfsQ1mggrV0iz6qK9e6SMyXsfCGvuAqqAmYz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186336; c=relaxed/simple;
	bh=mjhiOE9V8C0wheS1juQW7ZKGUKe/JAeKebRmNOKIqcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q9OHymNFizLlaWtjXoma5AGRdSQek7lv42g4dlKQuickBVdV8lB1tIs9KHT/jdehHRLyEDuS9JIjJCrK5L/+SE+Tb4P1fkH/485XDch6ucTV7queomINy5BzLF4yPKVEtHZ0HsxCEvMn3yrEu4/ftXyWEUW40X7ksQxCb1USQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=All2FbVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559DFC4CEC4;
	Tue, 24 Sep 2024 13:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727186336;
	bh=mjhiOE9V8C0wheS1juQW7ZKGUKe/JAeKebRmNOKIqcw=;
	h=From:Date:Subject:To:Cc:From;
	b=All2FbVcWFNLYtOWd6MNxS8+ns5KImufaT1QWO2L4rVHlbDFZTmSSIWWRPdsXdKYg
	 sBF566Q7uEP3XsHBRQ/UxX7dQFIiRwaEfD0kAdY3BovKUc+BU6jcdeQBg3Hd1ArWqY
	 th9YOVQLK2fxetYSs0PbL04TLmgbZeietNRr581BtizZ2CuV5GMiLhku6ohIK1ixmo
	 s0OtDPXWvKz5gPMKQNtOzczCCr7g91mn8WxSV+tE8sZHomZqa+CVi8IVOlqt8QbQ66
	 vguVMh37+APeuCyNYYOtOUQp4lgUlBxQw6cN+CvFN86tA97v+a1iIOvF8b4EQp71WU
	 U9WHab0Hm5tlA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 24 Sep 2024 15:58:42 +0200
Subject: [PATCH] ASoC: fsl: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-asoc-imx-maple-v1-1-8b993901f71e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJHF8mYC/x3MQQqAIBBA0avErBswtaCuEi2sxhrIFIUQwrsnL
 d/i/xcSRaYEU/NCpIcT+7uiaxvYTnMfhLxXgxRSi1FqNMlvyC6jM+EiNOs6SCs61SsFNQqRLOd
 /OC+lfFn+chxgAAAA
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=2195; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mjhiOE9V8C0wheS1juQW7ZKGUKe/JAeKebRmNOKIqcw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm8sWbwQST/kxv3i8Ph3uEZVQrfduRFkYXJARJE
 KW6TgYDGS2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvLFmwAKCRAk1otyXVSH
 0CjdB/4rV/vNLoIQlMxXHFZ4x4LcvAMLcjwL+UyIwkYLlta2CtJ13XQ7X970VpWE6B52CvaiCOn
 IggNAH8UGfac37XRrwHWX+UC3eqTDA3uPuZH+czaw7gfp7JAKrW+7g8qByTREF1KYhuu1xW46gx
 klfDKmUsYceDDkgdCCxb2wpLuZSAfkMfeqXeGdtLO9ahdLSjk7mlT9lTnGyqMnvS0tX2TaTlNmj
 6s5+f29U1sU8dZDLHv7OVwUtRIgY9gIaL5l1xeokNiZi9V5zA78bwEwD8ESpXauWrDBudyflyEC
 h0by4V+2DeSgErLCjUlyflJ6nt7Mg+JmRdRr0Rx7Mv8340Wj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Several of the NXP drivers use regmaps with a rbtree register cache. Since
the maple tree cache is uisng a generally more modern data structure which
makes implementation choices more suitable for modern systems let's convert
these drivers to it. This should have no practical impact.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_aud2htx.c | 2 +-
 sound/soc/fsl/fsl_easrc.c   | 2 +-
 sound/soc/fsl/fsl_micfil.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_aud2htx.c b/sound/soc/fsl/fsl_aud2htx.c
index a6cbaa6364c7..910b4ce7671c 100644
--- a/sound/soc/fsl/fsl_aud2htx.c
+++ b/sound/soc/fsl/fsl_aud2htx.c
@@ -169,7 +169,7 @@ static const struct regmap_config fsl_aud2htx_regmap_config = {
 	.readable_reg = fsl_aud2htx_readable_reg,
 	.volatile_reg = fsl_aud2htx_volatile_reg,
 	.writeable_reg = fsl_aud2htx_writeable_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static const struct of_device_id fsl_aud2htx_dt_ids[] = {
diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 962f30912091..5149e732f763 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1748,7 +1748,7 @@ static const struct regmap_config fsl_easrc_regmap_config = {
 	.rd_table = &fsl_easrc_readable_table,
 	.wr_table = &fsl_easrc_writeable_table,
 	.volatile_table = &fsl_easrc_volatileable_table,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 #ifdef DEBUG
diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 22b240a70ad4..c0dc9bebb77b 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -955,7 +955,7 @@ static const struct regmap_config fsl_micfil_regmap_config = {
 	.readable_reg = fsl_micfil_readable_reg,
 	.volatile_reg = fsl_micfil_volatile_reg,
 	.writeable_reg = fsl_micfil_writeable_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 /* END OF REGMAP */

---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240924-asoc-imx-maple-abb62f013533

Best regards,
-- 
Mark Brown <broonie@kernel.org>


