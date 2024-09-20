Return-Path: <linux-kernel+bounces-334655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CCD97DA10
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 22:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56571284526
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 20:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B15D18592D;
	Fri, 20 Sep 2024 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JjaRMJ2P"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447D717A5BE;
	Fri, 20 Sep 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726863957; cv=none; b=V/JZThEGrmnTcN9g3RKZD5TWXkJpG2Ke0Jl0q9uNhaOwmE87veZkWsCLlQZYe8du3Tm4DKHQy+l4TtzWvXJ0Z6a5Py1KfOXc+u7qm6EkuuBNVfpzEqOFya3PyaIjjc8CFYmec/tyB53l2Bc3xUu5mnAUhCjAdQ7FQJt32qfWkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726863957; c=relaxed/simple;
	bh=wdxl7L9ab6N6pMLE7KC4xJz+RoZj2ag/Gqszly5vPwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i58+Pad5xV93GXX82UOA+yjvECTgJKhyhFFn1KkJr5FVfVb2j6zogQmDSIr6HycB8daTjOINvmBp8nRIw2uPBPlirRNS6Nhkkdv5h4LkPimNS4ql2QRoG2aL31wZw7OI/m3NUs6E8bM3na+mAFTo+EiAxKO/iicSYTlWDxDL/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JjaRMJ2P; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id rkCEsAP4R8upxrkCEsK3V6; Fri, 20 Sep 2024 22:25:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726863945;
	bh=soylroJMGBRTvCSChB7Q0b3qXpOF2F9XAqnaurhKvjk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JjaRMJ2PScHVbxdpQ0qY15DrqanQFw2CfDhgdpwSl1YL9eQ33X/z0yYI0YvcrkFcf
	 sjUl7thsTXrYEu51ho/3677yCeGNlKwRoOWbmuEmHvf874AX0TAsgCEaaV8Zybl8gn
	 aKOf7NJI8usc5F5klFVsComJygjp/X3iDqdozks0AJ42HNqL2slQJDSILA9ddtDIRo
	 I63D7v12XDcHRTnR+tZgqj0xYZWGbu5X1YLHuzAJ+4gCIN8UvUz62bL+HK31+GkzVQ
	 ICY42LgjhSpDdZH1nG5aLepX2SbSwh9xwfe2k16ZxN2B1/Vn8TPp2ThoFV/W8JSfXL
	 TMrT+G10OQnjQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 20 Sep 2024 22:25:45 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH] clk: sunxi-ng: Constify struct ccu_reset_map
Date: Fri, 20 Sep 2024 22:25:24 +0200
Message-ID: <44745f27034fa670605cd16966a39b7fe88fe5a6.1726863905.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct ccu_reset_map' are not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   1533	   2224	      0	   3757	    ead	drivers/clk/sunxi-ng/ccu-sun20i-d1-r.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   1597	   2160	      0	   3757	    ead	drivers/clk/sunxi-ng/ccu-sun20i-d1-r.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c   | 2 +-
 drivers/clk/sunxi-ng/ccu-sun20i-d1.c     | 2 +-
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c     | 2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c | 2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c   | 2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c    | 2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c   | 4 ++--
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c     | 2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c   | 2 +-
 drivers/clk/sunxi-ng/ccu-sun5i.c         | 2 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c     | 2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c     | 2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c     | 2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c    | 2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c     | 8 ++++----
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c      | 4 ++--
 drivers/clk/sunxi-ng/ccu-sun8i-r.c       | 6 +++---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c     | 2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c     | 4 ++--
 drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c  | 2 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c | 2 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c     | 2 +-
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c | 2 +-
 drivers/clk/sunxi-ng/ccu_common.h        | 2 +-
 drivers/clk/sunxi-ng/ccu_reset.h         | 2 +-
 25 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c b/drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c
index de36e21d3eaf..4084714adb15 100644
--- a/drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun20i-d1-r.c
@@ -91,7 +91,7 @@ static struct clk_hw_onecell_data sun20i_d1_r_hw_clks = {
 	},
 };
 
-static struct ccu_reset_map sun20i_d1_r_ccu_resets[] = {
+static const struct ccu_reset_map sun20i_d1_r_ccu_resets[] = {
 	[RST_BUS_R_TIMER]	= { 0x11c, BIT(16) },
 	[RST_BUS_R_TWD]		= { 0x12c, BIT(16) },
 	[RST_BUS_R_PPU]		= { 0x1ac, BIT(16) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
index 9b5cfac2ee70..9633d4506891 100644
--- a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
+++ b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
@@ -1232,7 +1232,7 @@ static struct clk_hw_onecell_data sun20i_d1_hw_clks = {
 	},
 };
 
-static struct ccu_reset_map sun20i_d1_ccu_resets[] = {
+static const struct ccu_reset_map sun20i_d1_ccu_resets[] = {
 	[RST_MBUS]		= { 0x540, BIT(30) },
 	[RST_BUS_DE]		= { 0x60c, BIT(16) },
 	[RST_BUS_DI]		= { 0x62c, BIT(16) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
index d1a1683baff4..54c794c50828 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
@@ -1382,7 +1382,7 @@ static struct clk_hw_onecell_data sun7i_a20_hw_clks = {
 	.num	= CLK_NUMBER_SUN7I,
 };
 
-static struct ccu_reset_map sunxi_a10_a20_ccu_resets[] = {
+static const struct ccu_reset_map sunxi_a10_a20_ccu_resets[] = {
 	[RST_USB_PHY0]		= { 0x0cc, BIT(0) },
 	[RST_USB_PHY1]		= { 0x0cc, BIT(1) },
 	[RST_USB_PHY2]		= { 0x0cc, BIT(2) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
index 2c791761a646..cdd9721f9e7d 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
@@ -166,7 +166,7 @@ static struct clk_hw_onecell_data sun50i_a100_r_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun50i_a100_r_ccu_resets[] = {
+static const struct ccu_reset_map sun50i_a100_r_ccu_resets[] = {
 	[RST_R_APB1_TIMER]	=  { 0x11c, BIT(16) },
 	[RST_R_APB1_BUS_PWM]	=  { 0x13c, BIT(16) },
 	[RST_R_APB1_PPU]	=  { 0x17c, BIT(16) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
index bbaa82978716..1b6a49bc7184 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
@@ -1061,7 +1061,7 @@ static struct clk_hw_onecell_data sun50i_a100_hw_clks = {
 	.num = CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun50i_a100_ccu_resets[] = {
+static const struct ccu_reset_map sun50i_a100_ccu_resets[] = {
 	[RST_MBUS]		= { 0x540, BIT(30) },
 
 	[RST_BUS_DE]		= { 0x60c, BIT(16) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index c255dba2c96d..82d7dcbca1cc 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -858,7 +858,7 @@ static struct clk_hw_onecell_data sun50i_a64_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun50i_a64_ccu_resets[] = {
+static const struct ccu_reset_map sun50i_a64_ccu_resets[] = {
 	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
 	[RST_USB_PHY1]		=  { 0x0cc, BIT(1) },
 	[RST_USB_HSIC]		=  { 0x0cc, BIT(2) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index c72815841111..d0ce2779c550 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -179,7 +179,7 @@ static struct clk_hw_onecell_data sun50i_h616_r_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun50i_h6_r_ccu_resets[] = {
+static const struct ccu_reset_map sun50i_h6_r_ccu_resets[] = {
 	[RST_R_APB1_TIMER]	=  { 0x11c, BIT(16) },
 	[RST_R_APB1_TWD]	=  { 0x12c, BIT(16) },
 	[RST_R_APB1_PWM]	=  { 0x13c, BIT(16) },
@@ -190,7 +190,7 @@ static struct ccu_reset_map sun50i_h6_r_ccu_resets[] = {
 	[RST_R_APB1_W1]		=  { 0x1ec, BIT(16) },
 };
 
-static struct ccu_reset_map sun50i_h616_r_ccu_resets[] = {
+static const struct ccu_reset_map sun50i_h616_r_ccu_resets[] = {
 	[RST_R_APB1_TWD]	=  { 0x12c, BIT(16) },
 	[RST_R_APB2_I2C]	=  { 0x19c, BIT(16) },
 	[RST_R_APB2_RSB]	=  { 0x1bc, BIT(16) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index a20b621ad8f1..bd6fc3df911d 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -1076,7 +1076,7 @@ static struct clk_hw_onecell_data sun50i_h6_hw_clks = {
 	.num = CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun50i_h6_ccu_resets[] = {
+static const struct ccu_reset_map sun50i_h6_ccu_resets[] = {
 	[RST_MBUS]		= { 0x540, BIT(30) },
 
 	[RST_BUS_DE]		= { 0x60c, BIT(16) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
index 84e406ddf9d1..af1c4f7c3f95 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
@@ -990,7 +990,7 @@ static struct clk_hw_onecell_data sun50i_h616_hw_clks = {
 	.num = CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun50i_h616_ccu_resets[] = {
+static const struct ccu_reset_map sun50i_h616_ccu_resets[] = {
 	[RST_MBUS]		= { 0x540, BIT(30) },
 
 	[RST_BUS_DE]		= { 0x60c, BIT(16) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.c b/drivers/clk/sunxi-ng/ccu-sun5i.c
index 1f4bc0e773a7..c9bf1fdb8a8a 100644
--- a/drivers/clk/sunxi-ng/ccu-sun5i.c
+++ b/drivers/clk/sunxi-ng/ccu-sun5i.c
@@ -731,7 +731,7 @@ static struct clk_hw_onecell_data sun5i_a10s_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun5i_a10s_ccu_resets[] = {
+static const struct ccu_reset_map sun5i_a10s_ccu_resets[] = {
 	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
 	[RST_USB_PHY1]		=  { 0x0cc, BIT(1) },
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index e8b8d2dd7f2c..c2ad1209633e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -1146,7 +1146,7 @@ static struct clk_hw_onecell_data sun6i_a31_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun6i_a31_ccu_resets[] = {
+static const struct ccu_reset_map sun6i_a31_ccu_resets[] = {
 	[RST_USB_PHY0]		= { 0x0cc, BIT(0) },
 	[RST_USB_PHY1]		= { 0x0cc, BIT(1) },
 	[RST_USB_PHY2]		= { 0x0cc, BIT(2) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
index 6c2a08f722a8..9433dbac038e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
@@ -668,7 +668,7 @@ static struct clk_hw_onecell_data sun8i_a23_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun8i_a23_ccu_resets[] = {
+static const struct ccu_reset_map sun8i_a23_ccu_resets[] = {
 	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
 	[RST_USB_PHY1]		=  { 0x0cc, BIT(1) },
 	[RST_USB_HSIC]		=  { 0x0cc, BIT(2) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index 5e0bc08a9ce3..1ffc5ab9bc3c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -712,7 +712,7 @@ static struct clk_hw_onecell_data sun8i_a33_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun8i_a33_ccu_resets[] = {
+static const struct ccu_reset_map sun8i_a33_ccu_resets[] = {
 	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
 	[RST_USB_PHY1]		=  { 0x0cc, BIT(1) },
 	[RST_USB_HSIC]		=  { 0x0cc, BIT(2) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index cb4c6b16c467..a51fb2c10c94 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -797,7 +797,7 @@ static struct clk_hw_onecell_data sun8i_a83t_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun8i_a83t_ccu_resets[] = {
+static const struct ccu_reset_map sun8i_a83t_ccu_resets[] = {
 	[RST_USB_PHY0]		= { 0x0cc, BIT(0) },
 	[RST_USB_PHY1]		= { 0x0cc, BIT(1) },
 	[RST_USB_HSIC]		= { 0x0cc, BIT(2) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index 7683ea08d8e3..a742f83746d1 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -146,7 +146,7 @@ static struct clk_hw_onecell_data sun50i_a64_de2_hw_clks = {
 	.num	= CLK_NUMBER_WITH_ROT,
 };
 
-static struct ccu_reset_map sun8i_a83t_de2_resets[] = {
+static const struct ccu_reset_map sun8i_a83t_de2_resets[] = {
 	[RST_MIXER0]	= { 0x08, BIT(0) },
 	/*
 	 * Mixer1 reset line is shared with wb, so only RST_WB is
@@ -156,7 +156,7 @@ static struct ccu_reset_map sun8i_a83t_de2_resets[] = {
 	[RST_ROT]	= { 0x08, BIT(3) },
 };
 
-static struct ccu_reset_map sun8i_h3_de2_resets[] = {
+static const struct ccu_reset_map sun8i_h3_de2_resets[] = {
 	[RST_MIXER0]	= { 0x08, BIT(0) },
 	/*
 	 * Mixer1 reset line is shared with wb, so only RST_WB is
@@ -166,14 +166,14 @@ static struct ccu_reset_map sun8i_h3_de2_resets[] = {
 	[RST_WB]	= { 0x08, BIT(2) },
 };
 
-static struct ccu_reset_map sun50i_a64_de2_resets[] = {
+static const struct ccu_reset_map sun50i_a64_de2_resets[] = {
 	[RST_MIXER0]	= { 0x08, BIT(0) },
 	[RST_MIXER1]	= { 0x08, BIT(1) },
 	[RST_WB]	= { 0x08, BIT(2) },
 	[RST_ROT]	= { 0x08, BIT(3) },
 };
 
-static struct ccu_reset_map sun50i_h5_de2_resets[] = {
+static const struct ccu_reset_map sun50i_h5_de2_resets[] = {
 	[RST_MIXER0]	= { 0x08, BIT(0) },
 	[RST_MIXER1]	= { 0x08, BIT(1) },
 	[RST_WB]	= { 0x08, BIT(2) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 13e57db2f8d5..74da5d27af72 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -876,7 +876,7 @@ static struct clk_hw_onecell_data sun50i_h5_hw_clks = {
 	.num	= CLK_NUMBER_H5,
 };
 
-static struct ccu_reset_map sun8i_h3_ccu_resets[] = {
+static const struct ccu_reset_map sun8i_h3_ccu_resets[] = {
 	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
 	[RST_USB_PHY1]		=  { 0x0cc, BIT(1) },
 	[RST_USB_PHY2]		=  { 0x0cc, BIT(2) },
@@ -939,7 +939,7 @@ static struct ccu_reset_map sun8i_h3_ccu_resets[] = {
 	[RST_BUS_SCR0]		=  { 0x2d8, BIT(20) },
 };
 
-static struct ccu_reset_map sun50i_h5_ccu_resets[] = {
+static const struct ccu_reset_map sun50i_h5_ccu_resets[] = {
 	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
 	[RST_USB_PHY1]		=  { 0x0cc, BIT(1) },
 	[RST_USB_PHY2]		=  { 0x0cc, BIT(2) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
index da6569334d68..2b3e094a32cb 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -178,7 +178,7 @@ static struct clk_hw_onecell_data sun50i_a64_r_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun8i_a83t_r_ccu_resets[] = {
+static const struct ccu_reset_map sun8i_a83t_r_ccu_resets[] = {
 	[RST_APB0_IR]		=  { 0xb0, BIT(1) },
 	[RST_APB0_TIMER]	=  { 0xb0, BIT(2) },
 	[RST_APB0_RSB]		=  { 0xb0, BIT(3) },
@@ -186,14 +186,14 @@ static struct ccu_reset_map sun8i_a83t_r_ccu_resets[] = {
 	[RST_APB0_I2C]		=  { 0xb0, BIT(6) },
 };
 
-static struct ccu_reset_map sun8i_h3_r_ccu_resets[] = {
+static const struct ccu_reset_map sun8i_h3_r_ccu_resets[] = {
 	[RST_APB0_IR]		=  { 0xb0, BIT(1) },
 	[RST_APB0_TIMER]	=  { 0xb0, BIT(2) },
 	[RST_APB0_UART]		=  { 0xb0, BIT(4) },
 	[RST_APB0_I2C]		=  { 0xb0, BIT(6) },
 };
 
-static struct ccu_reset_map sun50i_a64_r_ccu_resets[] = {
+static const struct ccu_reset_map sun50i_a64_r_ccu_resets[] = {
 	[RST_APB0_IR]		=  { 0xb0, BIT(1) },
 	[RST_APB0_TIMER]	=  { 0xb0, BIT(2) },
 	[RST_APB0_RSB]		=  { 0xb0, BIT(3) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index 2f51ceab8016..a374aeeca3f4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -1162,7 +1162,7 @@ static struct clk_hw_onecell_data sun8i_r40_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun8i_r40_ccu_resets[] = {
+static const struct ccu_reset_map sun8i_r40_ccu_resets[] = {
 	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
 	[RST_USB_PHY1]		=  { 0x0cc, BIT(1) },
 	[RST_USB_PHY2]		=  { 0x0cc, BIT(2) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index d24c0d8dfee4..00d04f7ad94d 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -644,7 +644,7 @@ static struct clk_hw_onecell_data sun8i_v3_hw_clks = {
 	.num	= CLK_I2S0 + 1,
 };
 
-static struct ccu_reset_map sun8i_v3s_ccu_resets[] = {
+static const struct ccu_reset_map sun8i_v3s_ccu_resets[] = {
 	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
 
 	[RST_MBUS]		=  { 0x0fc, BIT(31) },
@@ -679,7 +679,7 @@ static struct ccu_reset_map sun8i_v3s_ccu_resets[] = {
 	[RST_BUS_UART2]		=  { 0x2d8, BIT(18) },
 };
 
-static struct ccu_reset_map sun8i_v3_ccu_resets[] = {
+static const struct ccu_reset_map sun8i_v3_ccu_resets[] = {
 	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
 
 	[RST_MBUS]		=  { 0x0fc, BIT(31) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
index 0975ac58949f..d561c15f5122 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
@@ -177,7 +177,7 @@ static struct clk_hw_onecell_data sun9i_a80_de_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun9i_a80_de_resets[] = {
+static const struct ccu_reset_map sun9i_a80_de_resets[] = {
 	[RST_FE0]	= { 0x0c, BIT(0) },
 	[RST_FE1]	= { 0x0c, BIT(1) },
 	[RST_FE2]	= { 0x0c, BIT(2) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
index e5527c8cc64f..9e2b8d47fc54 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
@@ -68,7 +68,7 @@ static struct clk_hw_onecell_data sun9i_a80_usb_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun9i_a80_usb_resets[] = {
+static const struct ccu_reset_map sun9i_a80_usb_resets[] = {
 	[RST_USB0_HCI]		= { 0x0, BIT(17) },
 	[RST_USB1_HCI]		= { 0x0, BIT(18) },
 	[RST_USB2_HCI]		= { 0x0, BIT(19) },
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
index 756dd8fca6b0..5da9a16b4ec7 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
@@ -1108,7 +1108,7 @@ static struct clk_hw_onecell_data sun9i_a80_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map sun9i_a80_ccu_resets[] = {
+static const struct ccu_reset_map sun9i_a80_ccu_resets[] = {
 	/* AHB0 reset controls */
 	[RST_BUS_FD]		= { 0x5a0, BIT(0) },
 	[RST_BUS_VE]		= { 0x5a0, BIT(1) },
diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
index 52f1a04269f8..fb37c0fc4fde 100644
--- a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
+++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
@@ -477,7 +477,7 @@ static struct clk_hw_onecell_data suniv_hw_clks = {
 	.num	= CLK_NUMBER,
 };
 
-static struct ccu_reset_map suniv_ccu_resets[] = {
+static const struct ccu_reset_map suniv_ccu_resets[] = {
 	[RST_USB_PHY0]		=  { 0x0cc, BIT(0) },
 
 	[RST_BUS_DMA]		=  { 0x2c0, BIT(6) },
diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index 329734f8cf42..dd330426a6e5 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -50,7 +50,7 @@ struct sunxi_ccu_desc {
 
 	struct clk_hw_onecell_data	*hw_clks;
 
-	struct ccu_reset_map		*resets;
+	const struct ccu_reset_map	*resets;
 	unsigned long			num_resets;
 };
 
diff --git a/drivers/clk/sunxi-ng/ccu_reset.h b/drivers/clk/sunxi-ng/ccu_reset.h
index e9b973cae4af..941276a8ec2e 100644
--- a/drivers/clk/sunxi-ng/ccu_reset.h
+++ b/drivers/clk/sunxi-ng/ccu_reset.h
@@ -17,7 +17,7 @@ struct ccu_reset_map {
 
 struct ccu_reset {
 	void __iomem			*base;
-	struct ccu_reset_map		*reset_map;
+	const struct ccu_reset_map	*reset_map;
 	spinlock_t			*lock;
 
 	struct reset_controller_dev	rcdev;
-- 
2.46.1


