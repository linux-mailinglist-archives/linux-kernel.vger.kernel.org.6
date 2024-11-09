Return-Path: <linux-kernel+bounces-402667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077559C2A45
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3841D1C21A64
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 05:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6559813D53A;
	Sat,  9 Nov 2024 05:07:00 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4B44779F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 05:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731128820; cv=none; b=lBfFc30LcPwhA4Z8g6HlV6e8a0S9uLp0Zdclyp2C9vfCaxy0MHANmJbFI7YBFMK0ZdgpNo6v7nbTEZSglRp0vVk+kmW8beyaibqfXf8wyxcnjAIDGsshNHAHuK+E+TdR/ihwgRfWv5IasIBb9bLh51e3Xn4+0wc9m7+/cdrYXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731128820; c=relaxed/simple;
	bh=w6PWNyGb4b6lDWRZYAd6zkmUJBFOEcW9OtH2cb6Ka6I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ha+dPqyq56wAjadiMWltPojMEfq12OiPrhOY66R40bS+lYvAiXirzqz5SHqCX5H2xNTKfb7yACk5yixE83YRrNRDtWqijnN+heyQ7XGsV3RfBJBxCGOTZYTMcGF6p7GHF9Bok8XI4dhgRUT0YdBevkmce/szYROw6eVeHwjhpEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6672eede6f5c-c5828;
	Sat, 09 Nov 2024 13:06:53 +0800 (CST)
X-RM-TRANSID:2ee6672eede6f5c-c5828
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5672eedddfec-b8919;
	Sat, 09 Nov 2024 13:06:53 +0800 (CST)
X-RM-TRANSID:2ee5672eedddfec-b8919
From: guanjing <guanjing@cmss.chinamobile.com>
To: rogerq@kernel.org,
	s-anna@ti.com,
	nm@ti.com,
	horms@kernel.org,
	p-mohan@ti.com
Cc: linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH v3 2/2] soc: ti: pruss: fix the return type of these functions in icssg_prueth_sr1.c
Date: Sat,  9 Nov 2024 13:01:50 +0800
Message-Id: <20241109050150.265374-2-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241109050150.265374-1-guanjing@cmss.chinamobile.com>
References: <20241109050150.265374-1-guanjing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a mismatch between the return type of these functions and
the type of the values returned. This fix ensuers compilation (of
drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.o) to work without
CONFIG_TI_PRUSS.

Fixes: 0211cc1e4fbb ("soc: ti: pruss: Add helper functions to set GPI mode, MII_RT_event and XFR")
Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
---
 include/linux/pruss_driver.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/pruss_driver.h b/include/linux/pruss_driver.h
index 29a76a60869c..2e18fef1a2e1 100644
--- a/include/linux/pruss_driver.h
+++ b/include/linux/pruss_driver.h
@@ -144,32 +144,32 @@ static inline int pruss_release_mem_region(struct pruss *pruss,
 static inline int pruss_cfg_get_gpmux(struct pruss *pruss,
 				      enum pruss_pru_id pru_id, u8 *mux)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline int pruss_cfg_set_gpmux(struct pruss *pruss,
 				      enum pruss_pru_id pru_id, u8 mux)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline int pruss_cfg_gpimode(struct pruss *pruss,
 				    enum pruss_pru_id pru_id,
 				    enum pruss_gpi_mode mode)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline int pruss_cfg_miirt_enable(struct pruss *pruss, bool enable)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline int pruss_cfg_xfr_enable(struct pruss *pruss,
 				       enum pru_type pru_type,
 				       bool enable)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 #endif /* CONFIG_TI_PRUSS */
-- 
2.33.0




