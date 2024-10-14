Return-Path: <linux-kernel+bounces-364260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CA899CF38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6291C23700
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50291BF80C;
	Mon, 14 Oct 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r9LhYd9r"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27CA1BD01F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917323; cv=none; b=BRVeEyJP4hkcAkQ/o2ad+97e0f4PLyDqg/rTL6tUbYub8KqPu/X3/++CSxDoF9anMGFuB5kzqw4wDpC99353/g0Q+5l2mFI+ZOHN9p22nZ0TDsoGCB4CJGxyPDz1RIHtwYGgSevKZJ3612zlsV5cBJT0FYF2yOqaXz2fhFSS7j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917323; c=relaxed/simple;
	bh=3NOQyLFCaAfJpxbtvUL+woMOtQVLs/DKRpDgyp9MF5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3/i7PQ3/Ynxs/l1i85Wlg24g41EiSp0du1UF4C6nb62HnxpJqB12bTwzRLjU1AfeRDFvRSAP1AlKT3XjGdZ5eFicK24Dpoqbgzu4LLLfETrHbJ/n/rQS25qVpT09+eOSALj+Di/hVbcVVkvkV7MkdUGS3lbZBBBM9XkqR9XFjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r9LhYd9r; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49EEmOaF073588;
	Mon, 14 Oct 2024 09:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728917304;
	bh=n+mQz45U63prTSBkxvGOSZbgBqQAc7HgtbtCPe5BOiA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=r9LhYd9rbc6XLaIkI2f0tGCaErOyj1ZaaoV8JZdL6iAmnkm+HhyjLsjYAy8Sh2XRi
	 deZQoarEn31YkYrBxhG0/lhbyz5l95J1vfGqNR8xo680G1x0TVzNFQig7MsjF9Grtt
	 GRnMjv0sBPz1ACvP47hXo7jvnL9DQHsFJytidKHo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49EEmOcY009330
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 09:48:24 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 09:48:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 09:48:23 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49EEmMm7009566;
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
Subject: [PATCH 2/2] mailbox: ti-msgmgr: Allow building under COMPILE_TEST
Date: Mon, 14 Oct 2024 09:48:21 -0500
Message-ID: <20241014144821.15094-3-afd@ti.com>
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

The TI message manager driver can be compiled without ARCH_KEYSTONE
nor ARCH_K3 enabled. Allow it to be built under COMPILE_TEST.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 6fb995778636a..af721d769fdf2 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -127,7 +127,7 @@ config STI_MBOX
 
 config TI_MESSAGE_MANAGER
 	tristate "Texas Instruments Message Manager Driver"
-	depends on ARCH_KEYSTONE || ARCH_K3
+	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	default ARCH_K3
 	help
 	  An implementation of Message Manager slave driver for Keystone
-- 
2.39.2


