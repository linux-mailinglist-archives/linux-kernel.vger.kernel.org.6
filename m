Return-Path: <linux-kernel+bounces-342810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC31989334
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 08:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7CE9B23A20
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA389139CE3;
	Sun, 29 Sep 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjM3FtzD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C3279FE;
	Sun, 29 Sep 2024 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727590228; cv=none; b=ZILSuIHCKxemV0VyrqR0ZBUQj9Ip5Gko9fZpGhrf0/XApsPae3C5Vh+HPKoc4zpLzi77dbIMVwQr+uvr254kZBYFaaWfP/zl0U+0hYdCsSqCS/lvj16sZOdC7hOp4FlQkbzLXtO7a6CU9wMx0uCFlTwZOBXgdq2TdUmAgNJ7RXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727590228; c=relaxed/simple;
	bh=7Fuox0/hODh+msXZV7oOranhdZQ4QHJP/cN1MxKp+98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aoid8FhFaghA8XPL1nRsx4MASuVuopGfNAsVwqbT0fjK2VD/U9PN33aqDTYhSdc37C6fZcOf/wCUzxIrvpqm68OxZ2qxgch1MHyrhPMJdsLdCQuF1Wum7Wfo5sI2g4l8LejwRqOpTZYfULlaYITObP03R1ER0qYu7eW6sezw0Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjM3FtzD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7BCFC4CECE;
	Sun, 29 Sep 2024 06:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727590227;
	bh=7Fuox0/hODh+msXZV7oOranhdZQ4QHJP/cN1MxKp+98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YjM3FtzDabtKeBCpaRoyYb8f9EAXxa87YUUXVMu0J28eMjE6b7WunAaFPX5n/XZlI
	 RtsXmQ+RxyHdVyTxXBczKq9K+FwfObVrJuqnWE6CcYsWRUMFLukEh0u9zD9xtqdq27
	 WSfBRokO/AkF1FBUbxbfaBWApVAI7pEKSer+hECXsvBCwvwnBQPLpMX271QZXYlG+Y
	 w+esBgxFOuQNDOqGu+KNskrG/P/8KJ3YkVpSrWtWEriFG2VqsZ1CaU0yOJZHcoIHVB
	 9tnlc8nmqqn+759ZqIYfCqlfwB45xZv1pqx8QAvs93sShqD0cVb5VIEdes378sfwF1
	 mNLt16AvvpM2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1133CF6495;
	Sun, 29 Sep 2024 06:10:27 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Sun, 29 Sep 2024 14:10:05 +0800
Subject: [PATCH 1/2] clk: Fix the CLK_IGNORE_UNUSED failure issue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240929-fix_glitch_free-v1-1-22f9c36b7edf@amlogic.com>
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
In-Reply-To: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727590225; l=3496;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=j5nGks4RjMSPPYGFi+WoyylasN/sh7VgSzlGbwQyCJI=;
 b=QtvHpMbFuOIo/UK7CYtXIo11eZTGd+CWmoLcQrFkTWX/ZNF71z6QjhvRubudSx/KOMxNYM3TQ
 rCW5pbw2T0bCkhikgDPU6TxTQ7bPJUSAs/vbPKX2cfp1JR8FR89SO4f
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

When the clk_disable_unused_subtree() function disables an unused clock,
if CLK_OPS_PARENT_ENABLE is configured on the clock,
clk_core_prepare_enable() and clk_core_disable_unprepare() are called
directly, and these two functions do not determine CLK_IGNORE_UNUSED,
This causes the clock to be disabled even if CLK_IGNORE_UNUSED is
configured when clk_core_disable_unprepare() is called.

Two new functions clk_disable_unprepare_unused() and
clk_prepare_enable_unused() are added to resolve the preceding
situation. The CLK_IGNORE_UNUSED judgment logic is added to these two
functions. To prevent clock configuration CLK_IGNORE_UNUSED from
possible failure.

Change-Id: I56943e17b86436254f07d9b8cdbc35599328d519
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/clk.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 285ed1ad8a37..5d3316699b57 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -94,6 +94,7 @@ struct clk_core {
 	struct hlist_node	debug_node;
 #endif
 	struct kref		ref;
+	bool			ignore_enabled;
 };
 
 #define CREATE_TRACE_POINTS
@@ -1479,6 +1480,68 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 	}
 }
 
+static void __init clk_disable_unprepare_unused(struct clk_core *core)
+{
+	unsigned long flags;
+
+	lockdep_assert_held(&prepare_lock);
+
+	if (!core)
+		return;
+
+	if ((core->enable_count == 0) && core->ops->disable &&
+	    !core->ignore_enabled) {
+		flags = clk_enable_lock();
+		core->ops->disable(core->hw);
+		clk_enable_unlock(flags);
+	}
+
+	if ((core->prepare_count == 0) && core->ops->unprepare &&
+	    !core->ignore_enabled)
+		core->ops->unprepare(core->hw);
+
+	core->ignore_enabled = false;
+
+	clk_disable_unprepare_unused(core->parent);
+}
+
+static int __init clk_prepare_enable_unused(struct clk_core *core)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	lockdep_assert_held(&prepare_lock);
+
+	if (!core)
+		return 0;
+
+	ret = clk_prepare_enable_unused(core->parent);
+	if (ret)
+		return ret;
+
+	if ((core->flags & CLK_IGNORE_UNUSED) && clk_core_is_enabled(core))
+		core->ignore_enabled = true;
+
+	if ((core->prepare_count == 0) && core->ops->prepare) {
+		ret = core->ops->prepare(core->hw);
+		if (ret)
+			goto disable_unprepare;
+	}
+
+	if ((core->enable_count == 0) && core->ops->enable) {
+		flags = clk_enable_lock();
+		ret = core->ops->enable(core->hw);
+		clk_enable_unlock(flags);
+		if (ret)
+			goto disable_unprepare;
+	}
+
+	return 0;
+disable_unprepare:
+	clk_disable_unprepare_unused(core->parent);
+	return ret;
+}
+
 static void __init clk_disable_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
@@ -1490,7 +1553,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 		clk_disable_unused_subtree(child);
 
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
-		clk_core_prepare_enable(core->parent);
+		clk_prepare_enable_unused(core->parent);
 
 	flags = clk_enable_lock();
 
@@ -1517,7 +1580,7 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 unlock_out:
 	clk_enable_unlock(flags);
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
-		clk_core_disable_unprepare(core->parent);
+		clk_disable_unprepare_unused(core->parent);
 }
 
 static bool clk_ignore_unused __initdata;

-- 
2.42.0



