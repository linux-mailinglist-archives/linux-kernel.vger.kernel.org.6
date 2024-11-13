Return-Path: <linux-kernel+bounces-407301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5712C9C6B89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3F01F22E36
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435581F77B9;
	Wed, 13 Nov 2024 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhJ5TA50"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3081C9B62;
	Wed, 13 Nov 2024 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490609; cv=none; b=ngHIF9M672iDYKtRaWMhu9KxaiDvL5oue6RxJ/1/8X4lJ0X7eB0g3KYph99A55wVT/cVhTSh+BJ+LxzM8uTPe9X3TeWReUJjJ0VhyklTdnSziEIm5KTWjgsMgrQQQSq6RphvBp/MNyrAQz1r37tZGsy/ktm/15j3NIvNZsqcF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490609; c=relaxed/simple;
	bh=2YwXzis6Ve+VboxE95rpK7Is2IaGUN76qS7qkgQHAFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UcTjeLcAFVbdsZEaFK09bxsA0gJnzkfRnayConZU+I8NMuiQfJOKPnGy+0t507DiBcay1rZKPLDsDGIL2HS7/f+6MuL5NWzrIXO42hMvvMIyKkW9WmkVcRPv4HlvXgNSvhjzxfZv7p8GJMAex8/tyt6xs2IEBo6ZNtSvUQxYonA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhJ5TA50; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC09BC4CECD;
	Wed, 13 Nov 2024 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731490609;
	bh=2YwXzis6Ve+VboxE95rpK7Is2IaGUN76qS7qkgQHAFY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=lhJ5TA50hUHGpeMBkQIlZHc0Gr5VXQkn0VL7DLAOS2NaKX6Nh8iDBT/TK2cggYJ4Q
	 K9tQZtqg88EHW0pzLU/6PGR18ElQxrWwcDoa4vIV04wE/MyaNaPAx/njJ8JhSbiz4r
	 /TESdVQyd2eP6UcZyN/cqR/9r0BE5pNvExpUsuiAPL+Pk89khk8IaUrTH8BmyPjbgr
	 0LXNU6REyyDO3etATlaQetlivM+zP0GiXP0Gbhy6MPBLMD21UsxkIIN36Re1dKkzI2
	 UkA2dMmQ8RdO/oHdvXPoGb7mVlcl8Opgxc17plkQb5HM3Vxq7SAm+kVAkhow11jwy7
	 TDWsGLozax2dA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EEED41C00;
	Wed, 13 Nov 2024 09:36:48 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Wed, 13 Nov 2024 17:36:46 +0800
Subject: [PATCH v3] clk: meson: Fix the determine rate error in
 clk_regmap_divider_ro_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-fix_childclk_of_roclk_has_been_tampered_with-v3-1-2c624308337b@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAC1zNGcC/52NQQ6CMBBFr2K6FkMLqejKexjTlOmUTgRKWoIaw
 t0trHSps5r/k//ezCIGwsjOu5kFnCiS71Mo9jsGTvcNZmRSZiIXJU+XWXoqcNQaaO/KWxX8+jg
 dVY3Yq1F3AwY06kGjyyQ3NYAUxbGULCGHgGm/6a63lB3F0YfXZp/42v4pmniWFhXwWlproM4vu
 mt9Q3AA37FVNYlPvPgRLxJelrbK8xMYK/Q3flmWN5K5x29JAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731490607; l=2575;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=EwVrOsGFSv8d11s7BZKnGfuGkTWiDeiqd6+q7e3YxDQ=;
 b=FQKgJ4e25qoC6/pS5s/LNKSQtYlURL82MNRads2emSz7hMQgT+Pdvo1F0lrZBv7TDf4Hj8wO7
 D4AyvSvv+Z+B08f/Pet19xHCatpX7Q1zwO5iG3rKmpqNvF77PYuXkGo
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The rate determined by calling clk_regmap_divider_ro_ops with
clk_regmap_div_determine_rate is not 'RO', which will result in the
unexpected modification of the frequency of its children when setting
the rate of a clock that references clk_regmap_divider_ro_ops.

Fixes: ea11dda9e091 ("clk: meson: add regmap clocks")
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
Background: During the execution of clk_set_rate(), the function 
clk_core_round_rate_nolock() is called to calculate the matching rate
and save it to 'core->new_rate'. At the same time, it recalculates and
updates its 'child->newrate'. Finally, clk_change_rate() is called to
set all 'new_rates'.
---
Changes in v3:
- Restore clk_regmap_div_determine_rate().
- Link to v2: https://lore.kernel.org/r/20241112-fix_childclk_of_roclk_has_been_tampered_with-v2-1-64f8009cdf2a@amlogic.com

Changes in v2:
- Remove the CLK_DIVIDER_READ_ONLY judgment logic in
clk_regmap_div_determine_rate().
- Add clk_regmap_div_ro_determine_rate().
- Link to v1: https://lore.kernel.org/r/20241111-fix_childclk_of_roclk_has_been_tampered_with-v1-1-f8c1b6ffdcb0@amlogic.com
---
 drivers/clk/meson/clk-regmap.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
index 07f7e441b916..2b0b4eb0a3f0 100644
--- a/drivers/clk/meson/clk-regmap.c
+++ b/drivers/clk/meson/clk-regmap.c
@@ -127,9 +127,28 @@ const struct clk_ops clk_regmap_divider_ops = {
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



