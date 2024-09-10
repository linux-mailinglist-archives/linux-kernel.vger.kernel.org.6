Return-Path: <linux-kernel+bounces-322393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C1797287B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77141B23299
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F67A17E006;
	Tue, 10 Sep 2024 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJYbfpui"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20051791ED;
	Tue, 10 Sep 2024 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943233; cv=none; b=GS+L4JiD/ztVuP7e00b0zO4MUVxXVqmdV4bSDV3ZL+nLHjZdWsFVL2zmnJQ0sOoHFuSB+a3KPmzDAm1dapO45Ba6xIEwpyIhNY/pmAhr93EEJyqfKKH3oqseLrGK4X5FEe32Dd3tm5Isb6nsw38fpS9SvrIFUCxHlDnax+Qi5Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943233; c=relaxed/simple;
	bh=uFcq3JpVglbm/vn58dOu9mXfKwR+0Mlgd0MqGKM8DWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxNKVn914/fEbcF96+zIla0dKMZQNJGFDbjDZAB3XE8aNBpH+qdu+giReuOOLH87IkUy3LEF/aOtV7Sp+UdVTM6EAkvgwSvUoXyBedZUZBlQdUO+Nt8cyYZDHF1DFqkdWfxpVnbPjNN86jFCnEiYrRke05uNKoIBGEh1oQOMLQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJYbfpui; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so26879465e9.1;
        Mon, 09 Sep 2024 21:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725943228; x=1726548028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf8AEG2Lor2UnvVeXxILUX9a2RTDHKINg+SUWYbAxo0=;
        b=LJYbfpui/tYvvTeyT5206NyCzovgac33PuzSjIeFpfDo1l+dcbFxrn8t8vrv6EA6uP
         ZtPJE343J4HI19TofuTE8AF5+ieYxIOpfA3+gYLQmQMcyTeSHeo3vn14s8lWB9meS+MH
         Pan9w0tezFPYj/lY8rZ9eaza60ikcIdZlY8Yc1oJo+jawXrbR7mY6mPUe5kOybOMhWvO
         aJf0Ju63txtPxDahfWjGr7RJmy8a2HUDxQwkM8CQ5iRIEz6CLOQBVeCdx3OuisMjykKc
         lCL+dY2zR85e6LNyMdxIoAxTwCCZKXZi/VUd0wRLJlQ0yeNt6Fu8XYQc4pIRq/18qkiF
         YVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725943228; x=1726548028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mf8AEG2Lor2UnvVeXxILUX9a2RTDHKINg+SUWYbAxo0=;
        b=k1ZUtAZk5GvR+1CSD+BmN01vn61taHhteiBkRittW4jlnoM8KHEqKDlpOk28QHlUQv
         ujeAv+8x9SS7OdokIukSBFsXp/yNQz5lALmHYp44el48WwwPK2PyPHqLIVOvOJMe3vZN
         6y/Hi52o6NssKRi1W97N2/tQlGGDbaSSb6424AplF5y6swXUTpjwJU/GDOoGdJCVhLf5
         9tazRdq97S/N5QI4499mOoiWQRqyFp+HJqsRhiXUM5bNb5S21sYJNWJAg4qnchZLA6QY
         wB9d9rOEwJfCeHWeMifga0wsORHctsP6PHdXzUlDsloPV6IxpqD+R3iJMOoJc2dQmmKd
         9omQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNN7YVYYeDt+AFhG0vTh7MwnhW+ei8NR+tJAdP8JNB6TBz5woFNLaQv/7tOAL9RgEdj9VhzazLgGyzyO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3bPR2OLwCJ7spYhxEs4ynLMKin7rkbEG8kQkpt0YSitst0sE8
	B73t5q5J7B/x3jcbrwwcgNgw6rBFXC7XNkC+ZO99B0gSILzokEJdlMPrhQ==
X-Google-Smtp-Source: AGHT+IH60/1Q7HkwUlh+ivF2isDLAPFAc1kXwlT4gCJ2F3H4hy6/EmXYH8GGHysb2uGB/lBDOsu+UA==
X-Received: by 2002:a05:600c:3ac6:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-42cc28ce642mr807915e9.23.1725943227987;
        Mon, 09 Sep 2024 21:40:27 -0700 (PDT)
Received: from localhost.localdomain (201.red-88-10-59.dynamicip.rima-tde.net. [88.10.59.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01cae3asm5516055e9.0.2024.09.09.21.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:40:27 -0700 (PDT)
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
To: linux-clk@vger.kernel.org
Cc: sboyd@kernel.org,
	mturquette@baylibre.com,
	tsbogend@alpha.franken.de,
	yangshiji66@outlook.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3]  clk: ralink: mtmips: fix clocks probe order in oldest ralink SoCs
Date: Tue, 10 Sep 2024 06:40:23 +0200
Message-Id: <20240910044024.120009-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240910044024.120009-1-sergio.paracuellos@gmail.com>
References: <20240910044024.120009-1-sergio.paracuellos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Base clocks are the first in being probed and are real dependencies of the
rest of fixed, factor and peripheral clocks. For old ralink SoCs RT2880,
RT305x and RT3883 'xtal' must be defined first since in any other case,
when fixed clocks are probed they are delayed until 'xtal' is probed so the
following warning appears:

 WARNING: CPU: 0 PID: 0 at drivers/clk/ralink/clk-mtmips.c:499 rt3883_bus_recalc_rate+0x98/0x138
 Modules linked in:
 CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.43 #0
 Stack : 805e58d0 00000000 00000004 8004f950 00000000 00000004 00000000 00000000
 80669c54 80830000 80700000 805ae570 80670068 00000001 80669bf8 00000000
 00000000 00000000 805ae570 80669b38 00000020 804db7dc 00000000 00000000
 203a6d6d 80669b78 80669e48 70617773 00000000 805ae570 00000000 00000009
 00000000 00000001 00000004 00000001 00000000 00000000 83fe43b0 00000000
 ...
 Call Trace:
 [<800065d0>] show_stack+0x64/0xf4
 [<804bca14>] dump_stack_lvl+0x38/0x60
 [<800218ac>] __warn+0x94/0xe4
 [<8002195c>] warn_slowpath_fmt+0x60/0x94
 [<80259ff8>] rt3883_bus_recalc_rate+0x98/0x138
 [<80254530>] __clk_register+0x568/0x688
 [<80254838>] of_clk_hw_register+0x18/0x2c
 [<8070b910>] rt2880_clk_of_clk_init_driver+0x18c/0x594
 [<8070b628>] of_clk_init+0x1c0/0x23c
 [<806fc448>] plat_time_init+0x58/0x18c
 [<806fdaf0>] time_init+0x10/0x6c
 [<806f9bc4>] start_kernel+0x458/0x67c

 ---[ end trace 0000000000000000 ]---

When this driver was mainlined we could not find any active users of old
ralink SoCs so we cannot perform any real tests for them. Now, one user
of a Belkin f9k1109 version 1 device which uses RT3883 SoC appeared and
reported some issues in openWRT:
- https://github.com/openwrt/openwrt/issues/16054

Thus, define a 'rt2880_xtal_recalc_rate()' just returning the expected
frequency 40Mhz and use it along the old ralink SoCs to have a correct
boot trace with no warnings and a working clock plan from the beggining.

Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIPS SoCs")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/clk/ralink/clk-mtmips.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtmips.c
index 62f9801ecd3a..76285fbbdeaa 100644
--- a/drivers/clk/ralink/clk-mtmips.c
+++ b/drivers/clk/ralink/clk-mtmips.c
@@ -263,10 +263,6 @@ static int mtmips_register_pherip_clocks(struct device_node *np,
 		.rate = _rate		 \
 	}
 
-static struct mtmips_clk_fixed rt305x_fixed_clocks[] = {
-	CLK_FIXED("xtal", NULL, 40000000)
-};
-
 static struct mtmips_clk_fixed rt3883_fixed_clocks[] = {
 	CLK_FIXED("xtal", NULL, 40000000),
 	CLK_FIXED("periph", "xtal", 40000000)
@@ -371,6 +367,12 @@ static inline struct mtmips_clk *to_mtmips_clk(struct clk_hw *hw)
 	return container_of(hw, struct mtmips_clk, hw);
 }
 
+static unsigned long rt2880_xtal_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	return 40000000;
+}
+
 static unsigned long rt5350_xtal_recalc_rate(struct clk_hw *hw,
 					     unsigned long parent_rate)
 {
@@ -682,10 +684,12 @@ static unsigned long mt76x8_cpu_recalc_rate(struct clk_hw *hw,
 }
 
 static struct mtmips_clk rt2880_clks_base[] = {
+	{ CLK_BASE("xtal", NULL, rt2880_xtal_recalc_rate) },
 	{ CLK_BASE("cpu", "xtal", rt2880_cpu_recalc_rate) }
 };
 
 static struct mtmips_clk rt305x_clks_base[] = {
+	{ CLK_BASE("xtal", NULL, rt2880_xtal_recalc_rate) },
 	{ CLK_BASE("cpu", "xtal", rt305x_cpu_recalc_rate) }
 };
 
@@ -695,6 +699,7 @@ static struct mtmips_clk rt3352_clks_base[] = {
 };
 
 static struct mtmips_clk rt3883_clks_base[] = {
+	{ CLK_BASE("xtal", NULL, rt2880_xtal_recalc_rate) },
 	{ CLK_BASE("cpu", "xtal", rt3883_cpu_recalc_rate) },
 	{ CLK_BASE("bus", "cpu", rt3883_bus_recalc_rate) }
 };
@@ -751,8 +756,8 @@ static int mtmips_register_clocks(struct device_node *np,
 static const struct mtmips_clk_data rt2880_clk_data = {
 	.clk_base = rt2880_clks_base,
 	.num_clk_base = ARRAY_SIZE(rt2880_clks_base),
-	.clk_fixed = rt305x_fixed_clocks,
-	.num_clk_fixed = ARRAY_SIZE(rt305x_fixed_clocks),
+	.clk_fixed = NULL,
+	.num_clk_fixed = 0,
 	.clk_factor = rt2880_factor_clocks,
 	.num_clk_factor = ARRAY_SIZE(rt2880_factor_clocks),
 	.clk_periph = rt2880_pherip_clks,
@@ -762,8 +767,8 @@ static const struct mtmips_clk_data rt2880_clk_data = {
 static const struct mtmips_clk_data rt305x_clk_data = {
 	.clk_base = rt305x_clks_base,
 	.num_clk_base = ARRAY_SIZE(rt305x_clks_base),
-	.clk_fixed = rt305x_fixed_clocks,
-	.num_clk_fixed = ARRAY_SIZE(rt305x_fixed_clocks),
+	.clk_fixed = NULL,
+	.num_clk_fixed = 0,
 	.clk_factor = rt305x_factor_clocks,
 	.num_clk_factor = ARRAY_SIZE(rt305x_factor_clocks),
 	.clk_periph = rt305x_pherip_clks,
-- 
2.25.1


