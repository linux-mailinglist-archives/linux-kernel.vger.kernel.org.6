Return-Path: <linux-kernel+bounces-192261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20AE8D1AC9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D161C22597
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A26916D4E1;
	Tue, 28 May 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzy07cQ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94116D33C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898346; cv=none; b=deL399l3f9ymyot4fF8cTzu+Up+rThR10yTDO+UJoU9Ik7TcaNZsA3r6co6HhAe8FE7GnniuMIenTFOQsFKgEcHKeKizcJ7Aa5jDt9c7WuhRengFlVyq65GpJXHejoGYKSNjbrdDpCH0GtmYknIc9IXn7+sm/2N9Iatk6POJAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898346; c=relaxed/simple;
	bh=nGSDS9vGtseFAPoPz3Fk0zZfldajpInUYLkCfgbvaEM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SahsbbNPM2wK1v8i1k309TS0bScWoBZhldszLMf1vFClKO/PYh8j5008iOxA4SCUo0qDPdad5lYnV/kqnVlf8n2bk7gV/qfOmPKp8M72e3AHSTFRPCnImdYTW4QNIYzqaxPd7GRPm9VsmVT2kDXG0+xLaMOxNy6NDF70T9iGnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzy07cQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76CEC3277B;
	Tue, 28 May 2024 12:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716898346;
	bh=nGSDS9vGtseFAPoPz3Fk0zZfldajpInUYLkCfgbvaEM=;
	h=From:To:Cc:Subject:Date:From;
	b=dzy07cQ6ygCTD+N1vSU/vY2eUn2/YQlKAlP0GcykKFV41MLs52JD4E1BRuId25n+z
	 4F/LsiZN8zzAK7e2pjg699/eF4ODp4G5w+Zl2iSMTzq3V2xanZPBYpPzRvoDkfPY4M
	 L/n6RWwN7gyEpAGrfQdAgOa0sfgD+dLrn7Dg7iQ1mLhbCBgMBOL2WMOulCx1Z6ph2B
	 OR2bnfMJxpYeA7pnQuTS7eELRvTdOxfR3qax8g4DDsNHlQHH6ZunjThZ7seAcMCojY
	 5AbGnh61Yd7+ghwYfkBrXEeaPSVRR0Fwf7jDsSF/DUDiu9RRz7HYIhcQq4eRzZrzPK
	 VIlEb14Yn55GA==
From: Arnd Bergmann <arnd@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alina Yu <alina_yu@richtek.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: rtq2208: remove unused rtq2208_regulator_ldo_ops
Date: Tue, 28 May 2024 14:12:13 +0200
Message-Id: <20240528121222.3675312-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

After the recent rework, the structure is no longer referenced
anywhere and causes a build time warning:

drivers/regulator/rtq2208-regulator.c:222:35: error: 'rtq2208_regulator_ldo_ops' defined but not used [-Werror=unused-const-variable=]
  222 | static const struct regulator_ops rtq2208_regulator_ldo_ops = {
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~

Remove it to get a clean build again.

Fixes: 38bcec0e7cbb ("regulator: rtq2208: Fix LDO discharge register and add vsel setting")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I did not analyze the change to see if this is the only required change
or if there should still have been a reference instead. Please review
and confirm, or provide a different fix.
---
 drivers/regulator/rtq2208-regulator.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index b90e53d922d6..5b49eff90a7f 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -219,15 +219,6 @@ static const struct regulator_ops rtq2208_regulator_buck_ops = {
 	.set_suspend_mode = rtq2208_set_suspend_mode,
 };
 
-static const struct regulator_ops rtq2208_regulator_ldo_ops = {
-	.enable = regulator_enable_regmap,
-	.disable = regulator_disable_regmap,
-	.is_enabled = regulator_is_enabled_regmap,
-	.set_active_discharge = regulator_set_active_discharge_regmap,
-	.set_suspend_enable = rtq2208_set_suspend_enable,
-	.set_suspend_disable = rtq2208_set_suspend_disable,
-};
-
 static unsigned int rtq2208_of_map_mode(unsigned int mode)
 {
 	switch (mode) {
-- 
2.39.2


