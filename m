Return-Path: <linux-kernel+bounces-410162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5306B9CD568
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 03:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEC21F215C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151B5156F3C;
	Fri, 15 Nov 2024 02:33:05 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9264B57333;
	Fri, 15 Nov 2024 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637984; cv=none; b=isybX8+GuG05GKZWTKWvpgw856/DFWhwpRsVAar9apxeJFHmwiPjTUr+rPvYcH8RkRaEQB81iDz2uMvg/cS8ZOz/0gl8T5Hihk1Dn2vKt0hMFFEzZ8vbjmwxZRe9g+UaQH2cDc+N877pBjjZXHlr463HZiOfXp0Tqfel924PtRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637984; c=relaxed/simple;
	bh=QbQ5UfyTZEJzQO34MWfS+X2qlDIJc6GDRUyFUdxypZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type; b=inISUWy2tml01IZiTPwKpXpdbrzXOYU8iodpslfe7hq4medwCdRsXf5h69b7oGmtXApJsgSYb4/UI9+Z4WUP/02cfwGUb+BgNWNaURs9FWr8oqyC9GAx8AGcavAzze5wuBd11SblV1O/xb3rZcfIpw+uecBglxFCTBKAAOk9Xs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id B2CF26018EEEC;
	Fri, 15 Nov 2024 10:32:49 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	dan.carpenter@linaro.org
Cc: Su Hui <suhui@nfschina.com>,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 1/2] bus: fsl-mc:  Fix the double free in fsl_mc_device_add()
Date: Fri, 15 Nov 2024 10:32:06 +0800
Message-Id: <20241115023206.3722933-2-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241115023206.3722933-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Clang static checker(scan-build) warning：
drivers/bus/fsl-mc/fsl-mc-bus.c: line 909, column 2
Attempt to free released memory.

When 'obj_desc->type' == "dprc" and begin to free 'mc_bus' and 'mc_dev',
there is a double free problem because of 'mc_dev = &mc_bus->mc_dev'.
Add a judgment to fix this problem.

Fixes: a042fbed0290 ("staging: fsl-mc: simplify couple of deallocations")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
v2:
 - using is_fsl_mc_bus_dprc().  
 https://lore.kernel.org/all/20241114082751.3475110-1-suhui@nfschina.com/

 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 930d8a3ba722..319a081a29ef 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -905,8 +905,10 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 
 error_cleanup_dev:
 	kfree(mc_dev->regions);
-	kfree(mc_bus);
-	kfree(mc_dev);
+	if (is_fsl_mc_bus_dprc(mc_dev))
+		kfree(mc_bus);
+	else
+		kfree(mc_dev);
 
 	return error;
 }
-- 
2.30.2


