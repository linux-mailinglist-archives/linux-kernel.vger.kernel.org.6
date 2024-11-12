Return-Path: <linux-kernel+bounces-405877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B759C5861
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87E4A284B41
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983EF14A60D;
	Tue, 12 Nov 2024 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMbRfcML"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8413212A;
	Tue, 12 Nov 2024 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416238; cv=none; b=nSf0Ge0zugp6UpUtylRYm5GsOqlS1JqQvdBQLWwIfH9aIjRnroyFQ8sYACsI+9KJCtEUreksXbHTLb8CWL9PSuIAcTjEplrsFso2FXxxoTAOVZeiCPTBWmrNClNQNOZ9enuTl43rKcWIt4EdrdfEL7oIkkQpqiKB4oTOyDRjpQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416238; c=relaxed/simple;
	bh=aumUC1jKWcDK+qq7WwJfwJihetxm0F5JvzlC4NdgWL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lGo+IT61rwjumL1BqBKN92DE5aoGdJVxPzzd2WBTqyrsFvue/ea01we6+ZLLxdv55imhaDIFCXzqtBVSwejcf1LMu6V0mXox3ULo8M622Xvb5kLrRjoEEgzXFibecPyFu4EjMGO6Dv+VGF92Eq9FFS6NLp2/g7SxtF3Qe9iZX/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMbRfcML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79DD9C4CED0;
	Tue, 12 Nov 2024 12:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731416237;
	bh=aumUC1jKWcDK+qq7WwJfwJihetxm0F5JvzlC4NdgWL0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UMbRfcMLxlHLC9J6QqIpTiZG5I3hsJ0dtv1tA+Q3k3fLdEEWRcJDFDa9G0wJmEAfi
	 jXzewQL8uQXlq6k39xbp81V3ZfA+lvW9TpcC+sfLkeVLzt2NTUQQG9Pu4R26TthLCu
	 /PMFf3MoGxGqL/pqxpJvr9pMAEvAOJy7qDP8CQWRQGqFdvboj+0Ll5VjC7vgBFbrw/
	 kB+KalbqrjbITzoxfFy5YA0SNjcgziRpbZhzGW7Wqed8rzva7F8Bh+66xkOxuqX38+
	 LrE1M8vndsYVugf3K+rjrVR0jr3Ih69BjYXQf1KTxXDX1U8/oKxq4MAhYBJQ3cDoDb
	 kQUgSsWOJUM9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA44D32D8D;
	Tue, 12 Nov 2024 12:57:17 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 12 Nov 2024 20:57:13 +0800
Subject: [PATCH v2] clk: meson: Fix the determine rate error in
 clk_regmap_divider_ro_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-fix_childclk_of_roclk_has_been_tampered_with-v2-1-64f8009cdf2a@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAKhQM2cC/52NQQ6DIBBFr2JYl0aooU1XvUdjCAyDTKpiwNg2x
 rsXPUL/at4k/7+VZUyEmd2rlSVcKFMcC8hTxSCYsUNOrjCTtWxECff00RCod9C/dPQ6xf0IJmu
 LOOrZDBMmdPpNc+BKOAug5OXaKFYmp4Slf+iebeFAeY7pe9gXsX//FC2Cl8YNhFXeO7D1wwx97
 AjOEAfWbtv2A6RiwUTqAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jian Hu <jian.hu@amlogic.com>, Dmitry Rokosov <ddrokosov@sberdevices.ru>, 
 Yu Tu <yu.tu@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731416235; l=3076;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=8AI+tmYmNulgS0Oos4nPr/9f/YnCkFdoNAlNOvZiX+k=;
 b=WNYt8589v61xwco+HqIDwnC1iODrOIA0rq+V7GBT46G5LTeEwTBownMkgl0abQ1O51r4LdNy9
 gE/wSujgJ5GCiKjMCC4QQU+iisFAWMUD223v2rIPbgsygenS6PSUYTV
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The rate determined by calling clk_regmap_divider_ro_ops with
clk_regmap_div_determine_rate is not RO, which will result in the
unexpected modification of the frequency of its children when setting
the rate of a clock that references clk_regmap_divider_ro_ops.

Fiexs: ea11dda9e091 ("clk: meson: add regmap clocks")
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Background: During the execution of clk_set_rate(), the function 
clk_core_round_rate_nolock() is called to calculate the matching rate
and save it to 'core->new_rate'. At the same time, it recalculates and
updates its 'child->newrate'. Finally, clk_change_rate() is called to
set all 'new_rates'.
---
Changes in v2:
- Remove the CLK_DIVIDER_READ_ONLY judgment logic in
clk_regmap_div_determine_rate().
- Add clk_regmap_div_ro_determine_rate().
- Link to v1: https://lore.kernel.org/r/20241111-fix_childclk_of_roclk_has_been_tampered_with-v1-1-f8c1b6ffdcb0@amlogic.com
---
 drivers/clk/meson/clk-regmap.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
index 07f7e441b916..edf65ca92c7a 100644
--- a/drivers/clk/meson/clk-regmap.c
+++ b/drivers/clk/meson/clk-regmap.c
@@ -80,21 +80,6 @@ static int clk_regmap_div_determine_rate(struct clk_hw *hw,
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
-	unsigned int val;
-	int ret;
-
-	/* if read only, just return current value */
-	if (div->flags & CLK_DIVIDER_READ_ONLY) {
-		ret = regmap_read(clk->map, div->offset, &val);
-		if (ret)
-			return ret;
-
-		val >>= div->shift;
-		val &= clk_div_mask(div->width);
-
-		return divider_ro_determine_rate(hw, req, div->table,
-						 div->width, div->flags, val);
-	}
 
 	return divider_determine_rate(hw, req, div->table, div->width,
 				      div->flags);
@@ -127,9 +112,28 @@ const struct clk_ops clk_regmap_divider_ops = {
 };
 EXPORT_SYMBOL_NS_GPL(clk_regmap_divider_ops, CLK_MESON);
 
+static int clk_regmap_div_ro_determine_rate(struct clk_hw *hw,
+					    struct clk_rate_request *req)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(clk->map, div->offset, &val);
+	if (ret)
+		return ret;
+
+	val >>= div->shift;
+	val &= clk_div_mask(div->width);
+
+	return divider_ro_determine_rate(hw, req, div->table, div->width,
+					 div->flags, val);
+}
+
 const struct clk_ops clk_regmap_divider_ro_ops = {
 	.recalc_rate = clk_regmap_div_recalc_rate,
-	.determine_rate = clk_regmap_div_determine_rate,
+	.determine_rate = clk_regmap_div_ro_determine_rate,
 };
 EXPORT_SYMBOL_NS_GPL(clk_regmap_divider_ro_ops, CLK_MESON);
 

---
base-commit: 664988eb47dd2d6ae1d9e4188ec91832562f8f26
change-id: 20241111-fix_childclk_of_roclk_has_been_tampered_with-61dbcc623746

Best regards,
-- 
Chuan Liu <chuan.liu@amlogic.com>



