Return-Path: <linux-kernel+bounces-410163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0279CD56A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 03:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A623B2461A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A497166307;
	Fri, 15 Nov 2024 02:33:06 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9269C155744;
	Fri, 15 Nov 2024 02:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637986; cv=none; b=RbytC6M+HpGHRs3P/+Njl8kKhIZ4df9Tt+0NRX1UurqWyBdtNKBjQc52/CnCM1QUqr/u0mUymuHyURago5aYNnS+9odcBhnAdScEedrCLfv1hufMFTgV1ipwo2Mv0CNCERo2lS+aDoGz79sS+0sBKYcST2IJFokqje7YW7aSg6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637986; c=relaxed/simple;
	bh=CvB9tFJ7QO4YD8qv8a+rt1znPjEw4lHNGy078rWGdGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version; b=HuuZKZ6bFJQY+kUqLBkjcSIGLl3+CnB2zxvChULba0g8zdvoX23lLP3zRgYt4TtyFBmCACjPexbPqBal1Nh5/XEtrmFZJI3NfgTzZGNYEc+jU8O6w2zPqcdoD1rdqF6mvXmxS0FJJB7KZaa1o3/zsy91rJMMfcWq51q5mjHgL0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 82EC0619C974D;
	Fri, 15 Nov 2024 10:32:50 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	dan.carpenter@linaro.org
Cc: Su Hui <suhui@nfschina.com>,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 2/2] bus: fsl-mc: using put_device() when add_device() failed in fsl_mc_device_add()
Date: Fri, 15 Nov 2024 10:32:07 +0800
Message-Id: <20241115023206.3722933-3-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241115023206.3722933-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When device_add(&mc_dev->dev) failed, calling put_device() to let
'mc_dev->dev.release' free the resource rather than goto label
error_cleanup_dev. Otherwise, it can cause double free problem.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/b767348e-d89c-416e-acea-1ebbff3bea20@stanley.mountain/
Fixes: 95b3523b723e ("staging: fsl-mc: add device release callback")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 319a081a29ef..09f8772fed8f 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -895,7 +895,8 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		dev_err(parent_dev,
 			"device_add() failed for device %s: %d\n",
 			dev_name(&mc_dev->dev), error);
-		goto error_cleanup_dev;
+		put_device(&mc_dev->dev);
+		return error;
 	}
 
 	dev_dbg(parent_dev, "added %s\n", dev_name(&mc_dev->dev));
-- 
2.30.2


