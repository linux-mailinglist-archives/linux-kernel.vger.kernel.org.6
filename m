Return-Path: <linux-kernel+bounces-307879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B8A965452
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3FF1F255ED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6184C9F;
	Fri, 30 Aug 2024 00:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G6sDTstS"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5DE4A1D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724979575; cv=none; b=HGSFczpHOsfVKy+Btt4wRcuo/hqBg4dhkmsAq7Cc1hHy504QThhBSDFoJAjypluvlrF6UDkz4HKOViodriStlQQ88HkN2jkK5U598ltn2jg181ETM0BY+5iljhqXJtJsYtUEZwm7iZDXf352QfnKfbFuaD+UkDwwN4lcZcE5CK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724979575; c=relaxed/simple;
	bh=75IGC6THu6HqINRdVI+dTwyIDsDLIy4t4leaTJ8dgP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t3j+6tO+mFHd1hu7th4ij5YBDFayIRpTb/Md4dGazP+rEBEe0pF2ZsMqmtI0ycGnIoMjPb2LFEkUUIuHUDZrTazvIxdVFChb6NURbnS8D7oRLgWiA1DJwvXCsZaorCAXyOTcQVMlOAx2zXog7kQhayH6Jr4kKMKGOykbCAEkLa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G6sDTstS; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724979564; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=agv4jlqB0W2s9rUv5CtaLWILPixA3RCs3WIFMI3FJqI=;
	b=G6sDTstSKVx4XnXLcVyav87mST1C+JYuA5pdoZ584qPDm1Mk0bS80v+eYejBHatm0DsVHI0GwhSvTesna6f7Li3Zmul2YfF+dfXyfhVvq1yy526ONyg1woZ7WWi7CyxgDU/VI02Drkc32XCoWoGN1eA59VOVv295y7zFB5557zY=
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WDuRsrk_1724979562)
          by smtp.aliyun-inc.com;
          Fri, 30 Aug 2024 08:59:23 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: linux@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] ARM: footbridge: Remove duplicated include in common.c
Date: Fri, 30 Aug 2024 08:59:21 +0800
Message-Id: <20240830005921.42144-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files asm/hardware/dec21285.h is included twice in common.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9835
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/arm/mach-footbridge/common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 85c598708c10..c8f52d52b91b 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -30,7 +30,6 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <asm/hardware/dec21285.h>
 
 static int dc21285_get_irq(void)
 {
-- 
2.32.0.3.g01195cf9f


