Return-Path: <linux-kernel+bounces-343751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3794989F09
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE551F22E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98E618B480;
	Mon, 30 Sep 2024 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wBY/ySmw"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF9F17C7A3
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690288; cv=none; b=nktpy0QJi63JhN2idWrDOIEqrX5DILybyUAQooyBVcSeEyiRv19nEqNFid9TWAcgkc65odhlDx/ucA1SwHRE0SnQwicNGUQ7UwVrsLDtKWiGGv5ZICXZdYEB/jg2P4ogyxE/LA3dlcEDfr563s1G2JvBkgrs9VllUK89ZCSxfnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690288; c=relaxed/simple;
	bh=Qv38yuKWozzKR3IQYCCJ6uXfKqJ7XBE++PsFLWSEaCg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=to5uTN8sp8srVL0PhEkJB2KJ0+x8eUpVt7IVvGtu7T/5evS5d0j+HfUbGicN+RVjkDNQkQuAPjqYJNNNRrh0/wMpRpkDNm8ZbRHDogtx/FEefTnDCN9d2fV8EUYk49nfo3z/1iG3CXnTL10M1Lk5DpfMlkgZDdAnubgN8gcGZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wBY/ySmw; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48U9voxU121553;
	Mon, 30 Sep 2024 04:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727690270;
	bh=5nAG3PH8pxe0mgQspWLXQZNK62tGR2jcUNgxhIfNm5Q=;
	h=From:To:CC:Subject:Date;
	b=wBY/ySmwTUmcJf/jg5bPUSMBIOAI8Qu6MwFvzynBnXAQ5UbsGvyh16bikoHvXwLp0
	 LEPgawUalXm+8MPpXkAoWf9+VYZ1o35ksdSLauW3/92H9ynqB5xbhGiA2DPBFoIK6b
	 fN1ikI917K/bP+1edE8QeING0nYOcmhckody/0tI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48U9vo9j006811
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Sep 2024 04:57:50 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Sep 2024 04:57:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Sep 2024 04:57:50 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48U9vkLh069954;
	Mon, 30 Sep 2024 04:57:46 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <thomas.richard@bootlin.com>,
        <krzysztof.kozlowski@linaro.org>, <nichen@iscas.ac.cn>,
        <rogerq@kernel.org>, <c-vankar@ti.com>, <t-patil@ti.com>
CC: <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2] phy: ti: phy-j721e-wiz: fix usxgmii configuration
Date: Mon, 30 Sep 2024 15:27:45 +0530
Message-ID: <20240930095745.3007057-1-s-vadapalli@ti.com>
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
LANE_MODE_GEN2 respectively. Fix the configuration accordingly to truly
support USXGMII up to 10G.

Fixes: b64a85fb8f53 ("phy: ti: phy-j721e-wiz.c: Add usxgmii support in wiz driver")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
9852d85ec9d4 Linux 6.12-rc1
of mainline Linux.

v1:
https://lore.kernel.org/r/20240910091714.1082191-1-s-vadapalli@ti.com/
Changes since v1:
- Rebased to Linux 6.12-rc1.

Regards,
Siddharth.

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


