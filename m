Return-Path: <linux-kernel+bounces-291865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2822A956846
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C7128315F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820C5160877;
	Mon, 19 Aug 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOfBIJvQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43252208E;
	Mon, 19 Aug 2024 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063019; cv=none; b=eGQlcUHPc06uVMjaMUzwfFXpW1WlYbM3GxCSTPFSnmlP2MLPJUanEABpWVzUbGOFDold/y1Lh9K51IgKTY/U+bz9QhIVSKr4rhAFtNr0c7z/uWXuQx0XvEBqduACKSnB3Tdr4UWlDBRSw2uHOoR/03l9zp44QAI2599xCf9BmGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063019; c=relaxed/simple;
	bh=dRHMjabGWcluxGCkbb1z3o4w0GWZGVPCmk9e2r08S9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLewbLFc/c3wDU0EolzGH7wwj36CrNMYcsYQtKXfaFmQWlqJb1mbHCUCt1nAjw99RrQQWwSOATKVXEgw/GkyqP9A1brcsEgQmPjdWCvTsNxt35dnnM8H9UxBFCBGJ3sRwQKn2b5gpjh8M+bb3E9UKGtxawm8ElCXzwtkMYbC4yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOfBIJvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B16C32782;
	Mon, 19 Aug 2024 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724063019;
	bh=dRHMjabGWcluxGCkbb1z3o4w0GWZGVPCmk9e2r08S9A=;
	h=From:To:Cc:Subject:Date:From;
	b=YOfBIJvQUBrrDcqhULF8hEN92YK/xqjVsotdQzJUrwKsBRyQsOcjy03s04E5bdWO+
	 rEhH1bs1yQoagDTjuBgtW4BCPQ4whOfV/EygqwMERphv1B69uAuGAmgK+KWDCY4UqA
	 NYEzcXbkINg0TBmMC6EGjtlMq8akg6jY7LE5KvFnEd9NwY01DvTRd8YZv5KsnG1sQJ
	 +48lu5MkVRBhIok1285CG97Im0w1xLCg/1T4tYpf2VI9NKz4ENbnTLAdwwLnH49Uy2
	 CqJ5duuOLdAoI5NeHRBK0rLGK8pm4E05pfQOVP1fb7lTxKJSRp1f/E61cb6BWaox9K
	 A1XMrOajeOcIQ==
From: tzungbi@kernel.org
To: lee@kernel.org
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: cros_ec: simplify cros_ec_dev_init()
Date: Mon, 19 Aug 2024 18:23:26 +0800
Message-ID: <20240819102326.5235-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

Simplify cros_ec_dev_init() by the following changes:
- Get rid of label `failed_devreg`.
- Remove a redundant space and comment.
- Use `if (ret)` instead of `if (ret < 0)`.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/mfd/cros_ec_dev.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index e2aae8918679..55b30076763b 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -353,22 +353,17 @@ static int __init cros_ec_dev_init(void)
 {
 	int ret;
 
-	ret  = class_register(&cros_class);
+	ret = class_register(&cros_class);
 	if (ret) {
 		pr_err(CROS_EC_DEV_NAME ": failed to register device class\n");
 		return ret;
 	}
 
-	/* Register the driver */
 	ret = platform_driver_register(&cros_ec_dev_driver);
-	if (ret < 0) {
+	if (ret) {
 		pr_warn(CROS_EC_DEV_NAME ": can't register driver: %d\n", ret);
-		goto failed_devreg;
+		class_unregister(&cros_class);
 	}
-	return 0;
-
-failed_devreg:
-	class_unregister(&cros_class);
 	return ret;
 }
 
-- 
2.43.0


