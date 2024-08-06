Return-Path: <linux-kernel+bounces-275828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284E9948ABB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D031E281303
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A494B165F00;
	Tue,  6 Aug 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hB7cv8FQ"
Received: from mail-m12814.netease.com (mail-m12814.netease.com [103.209.128.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AFD166F36;
	Tue,  6 Aug 2024 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931021; cv=none; b=tClVIbgISpH7gXQ+Kzj5GYsmPYnGja+cR+ZEux/SxBizye5/sbMjrNhIWcQvU47CCs0jL8mZP5e42ITMGdGqwrGKoE4idbjTwY10Pw9757c4moG//snoUwKsnI39s6hDOvX/l0rqz1eX0qpfGJTxG+4UDHJ4/bTErqVfTY5jVQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931021; c=relaxed/simple;
	bh=Za7uQ/FdF5TBjfIlUc0XpHWe/Cvyos8PCSjtEIPcZ4M=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BVjWIS6vxiCH9bAbyiareaX76oPmrZpHpHObSj5eluZXlNL+vfR0OuQMlSfnGXjsbxzE3hl4yWuYtlmwyVaVDQiXFY35MMBFNpfpF37VwNujlN4k6LsYcptPYNSyllSpg0ly4cu+W8JWWiGidoF24+FQGndcj020vhDOX/BMvyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hB7cv8FQ; arc=none smtp.client-ip=103.209.128.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=hB7cv8FQEu9PuezqGIIrz1ErY4ueQCOC7o50WMlAQ4F/2H8dWKdjDacxJpRvIvhlDi90AXg528vCOpFmjWDYQHv4i931JD1urwpTbDZi+tjMnE+2KgHks11H60ED9q4hCFboMRxflkRpBqQWcCMFAZb5fvgsDZowZfa9iRY3v78=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=qUN0fucssUTYDJMPGdCMYXuJJdSvyMs7YM5gSkBeMgM=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 55BD9A07E0;
	Tue,  6 Aug 2024 15:38:40 +0800 (CST)
From: Elaine Zhang <zhangqing@rock-chips.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	kever.yang@rock-chips.com,
	zhangqing@rock-chips.com,
	heiko@sntech.de
Cc: linux-clk@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	huangtao@rock-chips.com,
	sugar.zhang@rock-chips.com
Subject: [PATCH v1] clk: gate: export clk_gate_endisable
Date: Tue,  6 Aug 2024 15:38:32 +0800
Message-Id: <20240806073832.13568-1-zhangqing@rock-chips.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh5KQ1ZISBgeHUtDQhhJHktWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a9126a03b4c03a8kunm55bd9a07e0
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MzY6Iyo4PDI3HxJJNxYSHUke
	DhlPCiNVSlVKTElJQklCQklKSEtOVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlOSkk3Bg++
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

make clk_gate_endisable not static, export API for other use.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 drivers/clk/clk-gate.c       | 3 ++-
 include/linux/clk-provider.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
index 68e585a02fd9..531bb84a5b3e 100644
--- a/drivers/clk/clk-gate.c
+++ b/drivers/clk/clk-gate.c
@@ -53,7 +53,7 @@ static inline void clk_gate_writel(struct clk_gate *gate, u32 val)
  *
  * So, result is always: enable xor set2dis.
  */
-static void clk_gate_endisable(struct clk_hw *hw, int enable)
+void clk_gate_endisable(struct clk_hw *hw, int enable)
 {
 	struct clk_gate *gate = to_clk_gate(hw);
 	int set = gate->flags & CLK_GATE_SET_TO_DISABLE ? 1 : 0;
@@ -87,6 +87,7 @@ static void clk_gate_endisable(struct clk_hw *hw, int enable)
 	else
 		__release(gate->lock);
 }
+EXPORT_SYMBOL_GPL(clk_gate_endisable);
 
 static int clk_gate_enable(struct clk_hw *hw)
 {
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 4a537260f655..db7132e9c057 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -630,6 +630,7 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
 void clk_unregister_gate(struct clk *clk);
 void clk_hw_unregister_gate(struct clk_hw *hw);
 int clk_gate_is_enabled(struct clk_hw *hw);
+void clk_gate_endisable(struct clk_hw *hw, int enable);
 
 struct clk_div_table {
 	unsigned int	val;
-- 
2.17.1


