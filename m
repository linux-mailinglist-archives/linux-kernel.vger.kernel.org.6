Return-Path: <linux-kernel+bounces-417286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B799D5204
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA16282D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B381D271C;
	Thu, 21 Nov 2024 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gpQVV3Y5"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B711BCA0F;
	Thu, 21 Nov 2024 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732210910; cv=none; b=mkIV5frKVjVITR3JGvvycXiPF7C+kCsuUAVeKzQ5qe2N1Gs3wvaEqLjq+futNK+wGlLVXAVLbwbkHyDMSXiBnoi8gXcEsHsmb+CuYA2jnkgHOHYLyJK+5Den21Pww4mPG04XC5GyXfVDbG4n7nL6l0MHE3/hnk8DMpsJOuKlGE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732210910; c=relaxed/simple;
	bh=9Lbsei33+eYe4Pshg30hHpeeL5E6eThAh7H7NztDQt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b2G5ah/q0ZYk6QwFkt+YyLVff1qubvM8aeGxDpHjJsTdrwycj35zz19lve01qI+bxfPRFUfdlIWb4eKmuZqpkFebmWiW8VNVbdkt65siEDCEHO3b2SrHhibOXyZl5LdyaVpaq/KsVfqOJf+UqJXE4ig7NKKaXFRVFaMjZ5mE0kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gpQVV3Y5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 268742000E;
	Thu, 21 Nov 2024 17:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732210901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QcSacwVpu2OIjtCo7echKG6f3TnQvVOnEK3B7CH3u8=;
	b=gpQVV3Y5DwAdSa+7rGceOvI9ECqAtPMyocg8KvRcQPA8yGF20p1h20yVBtzR84fG8ClwUh
	0I4xgOyZMm6GQNzGYZogpGCjCs6YJ8wDYl1UnCOMIDzL65A/s9ERj1nLXR45Q0V2uJfrAt
	CtdeJOAkuPUB4Uowb5Ow9nKWuBFV27oBJR+DXn1SfbAo8FxORpcH09MpzLBA54AM/gASvc
	+KIFiwh7QyRlWMBvcAvrDct8SRSN+sKjhq2ToA5w9FFbl9AnVm4I+FVUcKV7b461/kZYdw
	QOhIYphFMsAMNeSbRwnonySF58MMAvPn9qIPUSUHQaWGCRpXhJSkj/hY5pZQ1A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 21 Nov 2024 18:41:14 +0100
Subject: [PATCH 4/5] clk: Add flag to prevent frequency changes when
 walking subtrees
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-ge-ian-debug-imx8-clk-tree-v1-4-0f1b722588fe@bootlin.com>
References: <20241121-ge-ian-debug-imx8-clk-tree-v1-0-0f1b722588fe@bootlin.com>
In-Reply-To: <20241121-ge-ian-debug-imx8-clk-tree-v1-0-0f1b722588fe@bootlin.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Ying Liu <victor.liu@nxp.com>, 
 Marek Vasut <marex@denx.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Abel Vesa <abel.vesa@linaro.org>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Ian Ray <ian.ray@ge.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-Sasl: miquel.raynal@bootlin.com

There are mainly two ways to change a clock frequency. The active way
requires calling ->set_rate() in order to ask "on purpose" for a
frequency change. Otherwise, a clock can passively see its frequency
being updated depending on upstream clock frequency changes. In most
cases it is fine to just accept the new upstream frequency - which by
definition will have an impact on downstream frequencies if we do not
recalculate internal divisors. But there are cases where, upon an
upstream frequency change, we would like to maintain a specific rate.

As an example, on iMX8MP the video pipeline clocks are looking like this:

    video_pll1
       video_pll1_bypass
          video_pll1_out
             media_ldb
                media_ldb_root_clk
             media_disp2_pix
                media_disp2_pix_root_clk
             media_disp1_pix
                media_disp1_pix_root_clk

media_ldb, media_disp2_pix and media_disp1_pix are simple divisors from
which we might require 2 or 3 different rates, whereas video_pll1 is a
very configurable PLL which can achieve almost any frequency. There are
however relationships between them, typically the ldb clock must be 3.5
or 7 times higher than the media_disp* clocks.

Currently, if eg. media_disp2_pix is set to 71900000Hz, when media_ldb
is (later) set to 503300000Hz, media_disp2_pix is updated to 503300000Hz
as well, which clearly does not make sense. We want it to stay at
71900000Hz during the subtree walk.

Achieving this is the purpose of the new clock flag:
CLK_NO_RATE_CHANGE_DURING_PROPAGATION

Please note, if the kernel was setting the ldb clock before a pixel
clock, the result would be different, and this is also what this patch
is trying to solve.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
In all cases, the LDB must be aware of the device configuration, and ask
for a clever frequency, we will never cope with slightly aware drivers
when addressing this kind of subtle situation.
---
 drivers/clk/clk.c            | 9 +++++++--
 include/linux/clk-provider.h | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index adfc5bfb93b5a65b6f58c52ca2c432d651f7dd7d..94d93470479e77769e63e97462b176261103b552 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1927,7 +1927,6 @@ long clk_get_accuracy(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_get_accuracy);
 
-__maybe_unused
 static unsigned long clk_determine(struct clk_core *core, unsigned long rate)
 {
 	struct clk_rate_request req = {};
@@ -2272,7 +2271,13 @@ static void clk_calc_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 
-	core->new_rate = clk_recalc(core, core->parent->new_rate);
+	if (core->flags & CLK_NO_RATE_CHANGE_DURING_PROPAGATION) {
+		core->new_rate = clk_determine(core, core->rate);
+		if (!core->new_rate)
+			core->new_rate = clk_recalc(core, core->parent->new_rate);
+	} else {
+		core->new_rate = clk_recalc(core, core->parent->new_rate);
+	}
 
 	hlist_for_each_entry(child, &core->children, child_node)
 		clk_calc_subtree(child);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 200135e0f6d00d48b10e843259333b9733c97f38..baef0b442ac1d36ee935cbcaaaa4e2d95fe7654c 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -38,6 +38,8 @@
 #define CLK_OPS_PARENT_ENABLE	BIT(12)
 /* duty cycle call may be forwarded to the parent clock */
 #define CLK_DUTY_CYCLE_PARENT	BIT(13)
+/* do not passively change this clock rate during subtree rate propagation */
+#define CLK_NO_RATE_CHANGE_DURING_PROPAGATION BIT(14)
 
 struct clk;
 struct clk_hw;

-- 
2.47.0


