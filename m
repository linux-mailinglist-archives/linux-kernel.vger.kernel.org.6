Return-Path: <linux-kernel+bounces-336954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D552984330
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF75B29BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2A417A932;
	Tue, 24 Sep 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szWHaUeF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D360816F0C1
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172494; cv=none; b=qX2U/pqvysBXthQ2GkASzfVPm4oaJXwBH+kodRzJe22qGFNpUcuyuXNAnzzN1XlqYlWSK9JmB+znNgfn9Z2qjqQddUPGHLCeu7zrHBYc5J+hHwPhufHOhlazTN8IgAWXSd8rjtYo5IHpTNkFdHugjtBbkyUZt8yhJxybKJitYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172494; c=relaxed/simple;
	bh=fzj5ZXR9s54DMzrb/dLu7o0zD7SgtIFNZeok5/1FlCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ajI2KGNQLRYgtqdM1d1fflI501EqdGOqZmgPf90At1kg1J3Nq3r/voFev4Tx0a2/QUxY4DZPavPVhZP2Lt5T4RKA2yTNGkRA+YK1YVEBvOm8uh8zw+oOZQLfEMuItS9n+5PHx908gsb+mpO94nVqcu6kcrZdSVv5687Z9e36OPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szWHaUeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37E5C4CEC4;
	Tue, 24 Sep 2024 10:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727172494;
	bh=fzj5ZXR9s54DMzrb/dLu7o0zD7SgtIFNZeok5/1FlCY=;
	h=From:Date:Subject:To:Cc:From;
	b=szWHaUeFak6lYM/CfRc/9vkkPAuBULgV0DrutbK63B8LiB4IgOMP4r/b21PXfcNCF
	 UfMaOCFQXh+toOxNvTGfsn9z+94Vzliztwv/JMA3nPhSJ2jwQ+lvNfEn3/RjLNEL++
	 3j3USNpSg5+mNulw/MWC6lLqvtYMNXFUVchfgL/Nz7AYe9Fp0dDu8smpyk+4h3D2jh
	 sUrv7TDKVTtRt5pqREYeQ2FobeOODTO3/cN5+thpmFPZ7YeZTnugsyWpoZVY7BD4eO
	 afvy3p+Dx3luwQnlxEzL1q1tlBYCp+ymNThG8Co3193+ZMEkUR6uZ/ILLnlKt2IPpR
	 elFLg5mrKANLg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 24 Sep 2024 12:08:08 +0200
Subject: [PATCH] regcache: Improve documentation of available cache types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-regcache-document-types-v1-1-e157054e1215@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIeP8mYC/x3MQQ6DIBBG4auYWTsJRZqoV2lcAP7CLIoGtGljv
 HuJy2/x3kkFWVBobE7K+EiRNVU82oZ8tCmAZa4mrbRRg+44I3jrI3he/fFG2nn/bSj8tE6hM6Z
 3vaNabxmLfO/za7quPyPI+kBpAAAA
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fzj5ZXR9s54DMzrb/dLu7o0zD7SgtIFNZeok5/1FlCY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm8o+MGXnpVUaR0a9Nakd5XIgCKGzdeNGGWpipC
 oCOt7OF/4uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvKPjAAKCRAk1otyXVSH
 0FfqB/9+9FKcVi1wW0t+FSocGLrIaaaSJFN66OeWy9a/ZstpuKOhkjagTpH30HPcnSYZwp0HFNL
 5RyEN5JZh1n66JnqCCjrXX/TU9TzjLSW9WpMm6D5DlPrB2ym2YnyX0JySYSxKb8foAHsAZnsd7Z
 Uqiv1AQQt61k4L5FbW98YYEQlsy3X6mqcfA/7hJObIFcE22iVCd5BAaffRHJ0LFw0BtAKwqrAok
 7QkpuxkwYAFm39yjGfVzx+PbsL4Px8m0NnqILGBa3fFYohG7Kn8pNRMVtB1raGzbjfhauAfEyXC
 TK8KjVEanCnb+KRbKgkB1rZoELHa+7YRs1wPDRwo2s1rAZ86
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There is some user confusion about which cache types to choose when which
is not helped by the lack of any central documentation providing an
overview of what's available. Provide a short overview in the API header to
try to help reduce this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regmap.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 122e38161acb..5b59423e786a 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -54,7 +54,14 @@ struct sdw_slave;
 #define REGMAP_UPSHIFT(s)	(-(s))
 #define REGMAP_DOWNSHIFT(s)	(s)
 
-/* An enum of all the supported cache types */
+/*
+ * The supported cache types, the default is no cache.  Any new caches
+ * should usually use the maple tree cache unless they specifically
+ * require that there are never any allocations at runtime and can't
+ * provide defaults in which case they should use the flat cache.  The
+ * rbtree cache *may* have some performance advantage for very low end
+ * systems that make heavy use of cache syncs but is mainly legacy.
+ */
 enum regcache_type {
 	REGCACHE_NONE,
 	REGCACHE_RBTREE,

---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240923-regcache-document-types-5ab0e3448b8b

Best regards,
-- 
Mark Brown <broonie@kernel.org>


