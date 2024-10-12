Return-Path: <linux-kernel+bounces-362104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB5B99B11B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C593284794
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2A284E04;
	Sat, 12 Oct 2024 05:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Aahk7DRO"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD18C946C
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 05:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728711605; cv=none; b=jSQN4envvYiTCFvWVjlIt0OT/Zg6UqdXrAAcK2Zm00I1VOpcWcIgPBwPSH7C+H+F2KgFvGLaPWIMNK8lcDhzYKp9bLEmHKbMK/qZag7pMvr3Hl8Elr351ze548MXBz1aUFav1pI+byvYya5YxNG6nVr2PP93UqKX3A3EdfPaPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728711605; c=relaxed/simple;
	bh=U8ifYE6yrV8/dbHm525kGvI30XukEBIMBlJreguS4Kg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/AggyNe7U5HfBawQhzvZ17lE9MqE1FnqFY63vn3Hhchmf0MW+6cnF/YOol1/P/Us5xVZWc6zE7mY+GGMoytKUb+lne2lp99rJLKUsuSn4Va3kADV/83+SBstt8Q/zUKlC6T0BF3KFYTjaI60QJ7UDfbHQqQJTI8JbvXf080Lc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Aahk7DRO; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49C5dg0L015538;
	Sat, 12 Oct 2024 00:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728711582;
	bh=4HtfdnhrKshlhXfqmNKSPESTr9mWew0Ty0bP54kOgm0=;
	h=From:To:CC:Subject:Date;
	b=Aahk7DROhCYjCJeSGHei0L1rXUmPeD4s9VGzUnWKxZDMuGR6kLDncMm14bZeQe54H
	 tamnXDBgynRPCvHwP1+Wx1WGugOR7Ku5+nDqNTAWL1UDSUIqYtzxlRtGpwf+IBZAW7
	 AAcgWvCtqbRDNByDk2qm0YMM2F8VwpCwnanG1Cmk=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49C5dgfW117080;
	Sat, 12 Oct 2024 00:39:42 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 12
 Oct 2024 00:39:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 12 Oct 2024 00:39:41 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49C5db9R100121;
	Sat, 12 Oct 2024 00:39:38 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <thomas.richard@bootlin.com>,
        <krzysztof.kozlowski@linaro.org>, <nichen@iscas.ac.cn>,
        <rogerq@kernel.org>, <c-vankar@ti.com>, <t-patil@ti.com>
CC: <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v3] phy: ti: phy-j721e-wiz: fix usxgmii configuration
Date: Sat, 12 Oct 2024 11:09:37 +0530
Message-ID: <20241012053937.3596885-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Commit b64a85fb8f53 ("phy: ti: phy-j721e-wiz.c: Add usxgmii support in
wiz driver") added support for USXGMII mode. In doing so, P0_REFCLK_SEL
was set to "pcs_mac_clk_divx1_ln_0" (0x3) and P0_STANDARD_MODE was set to
LANE_MODE_GEN1, which results in a data rate of 5.15625 Gbps. However,
since the USXGMII mode can support up to 10.3125 Gbps data rate, the
aforementioned fields should be set to "pcs_mac_clk_divx0_ln_0" (0x2) and
LANE_MODE_GEN2 respectively. The signal corresponding to the USXGMII lane
of the SERDES has been measured as 5 Gbps without the change and 10 Gbps
with the change. Hence, fix the configuration accordingly to support
USXGMII up to 10G.

Fixes: b64a85fb8f53 ("phy: ti: phy-j721e-wiz.c: Add usxgmii support in wiz driver")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---

Hello,

This patch is based on commit
09f6b0c8904b Merge tag 'linux_kselftest-fixes-6.12-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
of the master branch of Mainline Linux.

v2:
https://lore.kernel.org/r/20240930095745.3007057-1-s-vadapalli@ti.com/
Changes since v2:
- Rebased to commit 09f6b0c8904b of Mainline Linux.
- Updated commit message based on Roger's feedback.
- Collected Reviewed-by tag from
  Roger Quadros <rogerq@kernel.org>

v1:
https://lore.kernel.org/r/20240910091714.1082191-1-s-vadapalli@ti.com/
Changes since v1:
- Rebased to Linux 6.12-rc1.

 drivers/phy/ti/phy-j721e-wiz.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index a6c0c5607ffd..c6e846d385d2 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -450,8 +450,8 @@ static int wiz_mode_select(struct wiz *wiz)
 		} else if (wiz->lane_phy_type[i] == PHY_TYPE_USXGMII) {
 			ret = regmap_field_write(wiz->p0_mac_src_sel[i], 0x3);
 			ret = regmap_field_write(wiz->p0_rxfclk_sel[i], 0x3);
-			ret = regmap_field_write(wiz->p0_refclk_sel[i], 0x3);
-			mode = LANE_MODE_GEN1;
+			ret = regmap_field_write(wiz->p0_refclk_sel[i], 0x2);
+			mode = LANE_MODE_GEN2;
 		} else {
 			continue;
 		}
-- 
2.40.1


