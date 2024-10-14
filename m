Return-Path: <linux-kernel+bounces-364259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5B099CF37
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE7D1C23700
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B239C1BDAB9;
	Mon, 14 Oct 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yw4Yjxea"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28201BDAA0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917323; cv=none; b=rVtr4ymnGYwUErJoBVa7h3Lge9ioL6209BP1wMU/EFmMpHfi5lieZ8BnkbDVUOoTCN35ezZ41SX30n+i5WqCPPZk0q8xftZkyjeRMpiynrSh82whn/nyA0IS5OevaBBUMoaRRQCG/qoDszQ7iOiCLjd37g5KRe3XVHToLYQIhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917323; c=relaxed/simple;
	bh=b3Wbb3XdgW+hegrgyZqfk/kvFx/H5XBuHEZfFX33KyA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ame0dh4KcyOSjbtEaHtQaGxNQFrVPZe89ZBpVZk14M6HvbOobQLWlUuPefbyOLyBl5/x+9ekSrSrgr0pUkU+B+GiV6Ap89OU5Hr5Az+T3FXVi2HDC32QoKsjH78Ocv29sfAVy2TSGCYIb8Ymf6VKbvYSn5T9e7prAaEL3pYv/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Yw4Yjxea; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49EEmNYg073584;
	Mon, 14 Oct 2024 09:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728917303;
	bh=znEZdV5RFjeuadvOkq16bKno3bWgUr4vZvk1wAHrPuw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Yw4Yjxea4h7VvJSuccaRjLPeelhxhBuh1lR0x2x6HwaDPNQUUqjy8d3pAdaCZGbVZ
	 h+LYl4Y0KPR6g+8NW2+IzxBAdbqvBMVRtp1oi9Y3rt+/1/5rmoa+k43EMbi9Ls7zNM
	 mAAH6GYJXhAKZhSATz9CLzjjlLc7pqkf02KqNBnI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49EEmNEu020540;
	Mon, 14 Oct 2024 09:48:23 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 09:48:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 09:48:23 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49EEmMm6009566;
	Mon, 14 Oct 2024 09:48:23 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Hari
 Nagalla <hnagalla@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 1/2] mailbox: ti-msgmgr: Remove use of of_match_ptr() helper
Date: Mon, 14 Oct 2024 09:48:20 -0500
Message-ID: <20241014144821.15094-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241014144821.15094-1-afd@ti.com>
References: <20241014144821.15094-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

When OF support is disabled the of_device_id struct match table can be
conditionally compiled out, this helper allows the assignment to also be
turned into a NULL conditionally. When the of_device_id struct is not
conditionally defined based on OF then the table will be unused causing a
warning. The two options are to either set the table as _maybe_unused, or
to just remove this helper since the table will always be defined.
Do the latter here.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/ti-msgmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 9d2d4ff6cda40..8eb8df8d95a4c 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -920,7 +920,7 @@ static struct platform_driver ti_msgmgr_driver = {
 	.probe = ti_msgmgr_probe,
 	.driver = {
 		   .name = "ti-msgmgr",
-		   .of_match_table = of_match_ptr(ti_msgmgr_of_match),
+		   .of_match_table = ti_msgmgr_of_match,
 		   .pm = &ti_msgmgr_pm_ops,
 	},
 };
-- 
2.39.2


