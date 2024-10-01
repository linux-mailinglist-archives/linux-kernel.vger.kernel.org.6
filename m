Return-Path: <linux-kernel+bounces-345195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D09298B303
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37862839F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9271B654C;
	Tue,  1 Oct 2024 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ipbCdSh1"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743E1B652D;
	Tue,  1 Oct 2024 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727756755; cv=none; b=W0ZyAq+4SxFvzugAtrsJja+psptAmkfBWK8olQQhMGVMSkOtUqZCm0EHHQqQigqJ9z9POuX1VYJTkQM0XBr9JL6W4bCqs0q2/3uPesOuYY0zH/gLQWbKrlFRJv9m3bbFLcnqI5q6VPgyhxHkV0LPySKVHLjJMAk67ACpCLvAXNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727756755; c=relaxed/simple;
	bh=zX7e8iV9phckFaC5bqESpnimFOhE4jLq8O6rmpwV3M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTcmK0gP4J71tVfYhJZdmS8rchYdeDXUyhWkauuf/XjQ4ftKPQVTxfQGS/3yiXmpkZHd2Ks+/pv+otJ9PqLBHWsJ6CAHFU9g09ynfBdbGAkWvsAQrOjme/aQeacBNPQ28TFMOPqnf+5WcmHFEt6O4Ny/LKOOuTSsTAS/fdRIHAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ipbCdSh1; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 665D223CB2;
	Tue,  1 Oct 2024 06:25:52 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8us6GjPoTX2f; Tue,  1 Oct 2024 06:25:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727756751; bh=zX7e8iV9phckFaC5bqESpnimFOhE4jLq8O6rmpwV3M0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ipbCdSh1gEKqLJpQwYh+By6BVU2tbxf5TD4lgl1Cqv/xWBEzTkjfMu9KkvYuLC94N
	 dB05M9uiHIl0PSnHTN8C7yDuTEt2fO2ENymo2Ndc/i70oxqlgSmlsg2eQ3FORjQaFC
	 cOT1Q3+XHKJF7sJW/jbCE4GJm6H2FGGC8B7qVHozgSTyAvfoIzfePavE0yTFl8SyP9
	 g26Dt1mmbI+oqe0NfDD8/+gTbgJrBdjP9gL3aaCZpavgFd/TdhZ8kSuqH8IYuGEuw/
	 b+CIAVzqC5E6C1mJAMZ3V82arLd/o4IjJ5vC2wNVTmqzqYW602A7svSnXE68evrHBI
	 P1nEFHV0kGJEQ==
From: Yao Zi <ziyao@disroot.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 5/8] clk: rockchip: Add clock type GATE_NO_SET_RATE
Date: Tue,  1 Oct 2024 04:23:59 +0000
Message-ID: <20241001042401.31903-7-ziyao@disroot.org>
In-Reply-To: <20241001042401.31903-2-ziyao@disroot.org>
References: <20241001042401.31903-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This clock type is similar to GATE, but doesn't allow rate setting,
which presents on RK3528 platform.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/rockchip/clk.c |  8 ++++++++
 drivers/clk/rockchip/clk.h | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 73d2cbdc716b..7d233770e68b 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -521,6 +521,14 @@ void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
 		case branch_gate:
 			flags |= CLK_SET_RATE_PARENT;
 
+			clk = clk_register_gate(NULL, list->name,
+				list->parent_names[0], flags,
+				ctx->reg_base + list->gate_offset,
+				list->gate_shift, list->gate_flags, &ctx->lock);
+			break;
+		case branch_gate_no_set_rate:
+			flags &= ~CLK_SET_RATE_PARENT;
+
 			clk = clk_register_gate(NULL, list->name,
 				list->parent_names[0], flags,
 				ctx->reg_base + list->gate_offset,
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 1efc5c3a1e77..360d16402fe5 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -519,6 +519,7 @@ enum rockchip_clk_branch_type {
 	branch_divider,
 	branch_fraction_divider,
 	branch_gate,
+	branch_gate_no_set_rate,
 	branch_mmc,
 	branch_inverter,
 	branch_factor,
@@ -844,6 +845,19 @@ struct rockchip_clk_branch {
 		.gate_flags	= gf,				\
 	}
 
+#define GATE_NO_SET_RATE(_id, cname, pname, f, o, b, gf)	\
+	{							\
+		.id		= _id,				\
+		.branch_type	= branch_gate_no_set_rate,	\
+		.name		= cname,			\
+		.parent_names	= (const char *[]){ pname },	\
+		.num_parents	= 1,				\
+		.flags		= f,				\
+		.gate_offset	= o,				\
+		.gate_shift	= b,				\
+		.gate_flags	= gf,				\
+	}
+
 #define MMC(_id, cname, pname, offset, shift)			\
 	{							\
 		.id		= _id,				\
-- 
2.46.0


