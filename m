Return-Path: <linux-kernel+bounces-180704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 877DA8C720D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3B81F22FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 07:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29A03C473;
	Thu, 16 May 2024 07:31:28 +0000 (UTC)
Received: from mail-sh.amlogic.com (unknown [58.32.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4355C8C0;
	Thu, 16 May 2024 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.32.228.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715844688; cv=none; b=bcfHw84y/utxr2v9kS8iST+b+1nMZY0AyMKnT1r58glnWErcD8MOhqfEomZtooqPtT+Fw07oNLvKbXo9t2lXBm93j4y5EU4n4m8ZV/d4bmzZrgBF3J0WL6f6NBJfSPY14lJU4FusZqTNuvhlAVvTERMQZKPmz8i3EiACsKOmMH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715844688; c=relaxed/simple;
	bh=vAeGVTCbFqDHlAJkn7gl1bhiBvE1tQ3yaz67h87Zr0Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WGkuJyGJ4hZTevtgjVioSkScJqaN0NhNdXjepjCVhhcaQ23D9Ut9LL16AaJjFk/sBfY8GzYVVjtzAG6Ct+HCQl9unRHLL5E93wUiy60E1QVMNrfTSB+i3Vt6xmE2ytrJt0Aj1JlKO6JOjgmoKixDiec7oM4e1TDof4Z4VJRY9TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; arc=none smtp.client-ip=58.32.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Received: from droid01-cd.amlogic.com (10.98.11.200) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.6; Thu, 16 May 2024
 15:16:15 +0800
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
To: <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, "Stephen
 Boyd" <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Yu Tu
	<yu.tu@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: [PATCH] clk: meson: s4: fix pwm_j_div parent clock
Date: Thu, 16 May 2024 15:16:12 +0800
Message-ID: <20240516071612.2978201-1-xianwei.zhao@amlogic.com>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Update peripherals pwm_j_div's parent clock to pwm_j_mux

Fixes: 57b55c76aaf1 ("clk: meson: S4: add support for Amlogic S4 SoC peripheral clock controller")
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/clk/meson/s4-peripherals.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index 6c35de3d536f..75a84e4cc2df 100644
--- a/drivers/clk/meson/s4-peripherals.c
+++ b/drivers/clk/meson/s4-peripherals.c
@@ -2978,7 +2978,7 @@ static struct clk_regmap s4_pwm_j_div = {
 		.name = "pwm_j_div",
 		.ops = &clk_regmap_divider_ops,
 		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_h_mux.hw
+			&s4_pwm_j_mux.hw
 		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
-- 
2.39.2


