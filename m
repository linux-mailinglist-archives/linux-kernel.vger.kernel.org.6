Return-Path: <linux-kernel+bounces-403548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA969C3712
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE171F21E88
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D15149E17;
	Mon, 11 Nov 2024 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgvqDa4p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087A73224;
	Mon, 11 Nov 2024 03:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731296230; cv=none; b=j41NGmdlPMRgR94xglabUKDE7UGHycrZzVtdGK3K64Xx7SIEo27lTtoR7chEsM8e9UCnngZjRBGV2h+fddv8kEzUAtd01j+AOugw2vAQjnduGia7+Xxfe//JvRHbghbwj4ln6EcLToi555vLTQS/v3QZm8JuTYVo8jbAB9b1TbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731296230; c=relaxed/simple;
	bh=FLYPFnw2Yqnj3auU91LfHIFR9j23kCj3QGzsgZlM2TU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NFDToJOjmd0WKxhI1yzQlhDL/NMgghoy00NRJURb8AfhbXqUGH89haysQlAfy+UxMNImagnesRefmiGNi+1HBTJc5v+aMz3mjqerxWmvxAe3JmOYxJA4et8XoiKiRFJRD7ViZFNNVf4OorXfOFePDL0bN6USdboJxOZW1/mnqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgvqDa4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9305C4CECF;
	Mon, 11 Nov 2024 03:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731296229;
	bh=FLYPFnw2Yqnj3auU91LfHIFR9j23kCj3QGzsgZlM2TU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pgvqDa4pX+626RzLwZsL24T9zfPieZu92smUBkx72aDNnWAfWqiJH7sjEBkfHQ14a
	 jv9zS0gyJ/a6vC0CEjTH918NYMABEmiZ8PV5Gv6UxJrJD8weKKQHfyG4claUg/S4l/
	 G/N65cg0/2d8y0O++T8ieMKgiPV3VYb9Vwqek5Q6ioXYpk3mpXrgKMwISnQHyTC9Pr
	 d7dz9Yr+6eOjtmN8tFVk+I3SWnH0HguJcVXZ/8prA+0uJxEFFRhaVyWN86mi6v3m8v
	 SRB5JrktapbOgAGdWFjAygR5MPvPsCX1nRpHwnCKmnnzx0HwEylx6R8ldcI0ifUFKe
	 /EwCR3aW8XsVw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B29D12D63;
	Mon, 11 Nov 2024 03:37:09 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Mon, 11 Nov 2024 11:37:01 +0800
Subject: [PATCH v2 1/3] clk: Fix the CLK_IGNORE_UNUSED failure issue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-fix_glitch_free-v2-1-0099fd9ad3e5@amlogic.com>
References: <20241111-fix_glitch_free-v2-0-0099fd9ad3e5@amlogic.com>
In-Reply-To: <20241111-fix_glitch_free-v2-0-0099fd9ad3e5@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731296227; l=3533;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=9b1cy9TNBZPPfcNjZa5uI79KkJxq5esCtVNt/pf2DF4=;
 b=B3YI7KWQBzzPirhueg0Y4FP+swR7rBAu+MWHP4YpU+sGHKo/kUjKDGkCpEzczH87qc/QhIka2
 B60vBX1oqjgDzindHyBmrnyp1s2NwPm++D2kOiKV4dLgTCeZYz/CqIX
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

Fixes: a4b3518d146f ("clk: core: support clocks which requires parents
enable (part 1)")
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/clk.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d02451f951cf..6def76c30ce6 100644
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



