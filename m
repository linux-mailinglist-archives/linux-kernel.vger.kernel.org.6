Return-Path: <linux-kernel+bounces-382997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DF29B1600
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 09:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B72A282C4F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 07:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD70318DF6A;
	Sat, 26 Oct 2024 07:37:16 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D584436A;
	Sat, 26 Oct 2024 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729928236; cv=none; b=ux9HKPyPdPWBTkNCCWol02TOGHLLP+4OuD1VX40ASADq0J65HalIDxmthY72lZ0hzJP9/UBso38GkHaJmvo2K4XMZAK1kcm6rBeASdGFsYz6JhX5v8PmdwxyrC5TaYuYqNpF5kjU7jyM+wLGjX24f1p52g8GngJ5DE35W1JEDeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729928236; c=relaxed/simple;
	bh=9Q6OHLQVWUxEYfZdLlXsJ7dE+jpqdCiOCJQztAaehP0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uM5XhCXQCs2VfFyHEZnyw1FczJRAVvuta0wWu9O9mPWU9qwoceibDVK0i713wbLd0toQaK8/SHk1sLj57qSNOh/ARlNDLxtbpeW+GwVVgjKx+rTLrrPEYxwBxyS67pBQnxzaJzFanIG4LBfi9vtYcMKY4YTTjtrX2pyqLQf5p/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XbBLl18RYz1ynNn;
	Sat, 26 Oct 2024 15:37:19 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
	by mail.maildlp.com (Postfix) with ESMTPS id 49B241400D3;
	Sat, 26 Oct 2024 15:37:11 +0800 (CST)
Received: from huawei.com (10.67.175.84) by kwepemd200012.china.huawei.com
 (7.221.188.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Sat, 26 Oct
 2024 15:37:10 +0800
From: Zicheng Qu <quzicheng@huawei.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<judy.chenhui@huawei.com>, <quzicheng@huawei.com>
Subject: [PATCH] clk: meson clk-phase: fix division by zero in meson_clk_degrees_to_val()
Date: Sat, 26 Oct 2024 07:26:24 +0000
Message-ID: <20241026072624.976199-1-quzicheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200012.china.huawei.com (7.221.188.145)

In the meson_clk_phase_set_phase() function, the variable phase->ph.width
is of type u8, with a range of 0 to 255. When calling
meson_clk_degrees_to_val with width as an argument, if width > 8,
phase_step(width) will return 0. Lead to a division by zero error in
DIV_ROUND_CLOSEST(). The same issue exists in the
meson_clk_triphase_set_phase() and meson_sclk_ws_inv_set_phase().

Fixes: 7b70689b07c1 ("clk: meson: add sclk-ws driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zicheng Qu <quzicheng@huawei.com>
---
 drivers/clk/meson/clk-phase.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/meson/clk-phase.c b/drivers/clk/meson/clk-phase.c
index c1526fbfb6c4..b88d59b7a90d 100644
--- a/drivers/clk/meson/clk-phase.c
+++ b/drivers/clk/meson/clk-phase.c
@@ -51,6 +51,9 @@ static int meson_clk_phase_set_phase(struct clk_hw *hw, int degrees)
 	struct meson_clk_phase_data *phase = meson_clk_phase_data(clk);
 	unsigned int val;
 
+	if (phase->ph.width > 8)
+		return -EINVAL;
+
 	val = meson_clk_degrees_to_val(degrees, phase->ph.width);
 	meson_parm_write(clk->map, &phase->ph, val);
 
@@ -110,6 +113,9 @@ static int meson_clk_triphase_set_phase(struct clk_hw *hw, int degrees)
 	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
 	unsigned int val;
 
+	if (tph->ph0.width > 8)
+		return -EINVAL;
+
 	val = meson_clk_degrees_to_val(degrees, tph->ph0.width);
 	meson_parm_write(clk->map, &tph->ph0, val);
 	meson_parm_write(clk->map, &tph->ph1, val);
@@ -167,6 +173,9 @@ static int meson_sclk_ws_inv_set_phase(struct clk_hw *hw, int degrees)
 	struct meson_sclk_ws_inv_data *tph = meson_sclk_ws_inv_data(clk);
 	unsigned int val;
 
+	if (tph->ph.width > 8)
+		return -EINVAL;
+
 	val = meson_clk_degrees_to_val(degrees, tph->ph.width);
 	meson_parm_write(clk->map, &tph->ph, val);
 	meson_parm_write(clk->map, &tph->ws, val ? 0 : 1);
-- 
2.34.1


