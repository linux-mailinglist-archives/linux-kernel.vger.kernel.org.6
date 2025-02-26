Return-Path: <linux-kernel+bounces-534218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A39B2A46442
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED75E18940D6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E576C223321;
	Wed, 26 Feb 2025 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j1J5iLHE"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8358222582
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582842; cv=none; b=IjKnyRC7D+lVJV0yDJ9XVsWzbRZU+mVMMIrHxOtQK9kBly2eVn8uuGtZWulqrQs/azxDbwwa2Ii/QdXI6y+98V9r3kAXhvM6EF87NFo2wgz9M3y3VmX5vdBdj7ZALV9OkSmsxRWe6VPwbs6STjMHY8rHEVwE3XkuVvAIV6AQdh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582842; c=relaxed/simple;
	bh=zNhb9ARN1Ib4JmOOzaYpOsj3pFKHDQ11nagu3+L/Z2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mRawX7fxnGiJh0p2DgO6uJnqJDcz07/7IogjudHkcuvXbJmHkkPlh7Im8+3SQMJ8X5at61WyQRkgUJMAPyb8OJgtBeF8/jUYU5Dyg90WVGjPXfh0jf5wRwA7EiUdOSL1AbEGgfx8dx7RRTChs1MSLGYzxNJan2rtRCk7+ryaGno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j1J5iLHE; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740582837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e9dQnfubL6/p56mx1Cp/R8UogR2Cvr+0nRgF/VIruog=;
	b=j1J5iLHEV7/IECp0G/kjjsSwczR/CeaI+VY7ivDak++TLM2yqD5emQU3/+QFCYWJ1YzF1d
	6JXQbtV9UbvF5lYngstIpS3FU52aGufkunSTluCkDOxoK5o6rhJ8tJyZziZmyWwG5q8q9w
	t7bRf6kiWNmsnoqVbK8u+wa1bfU64Zk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Rosin <peda@axentia.se>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mux: mmio: Add missing word in error message
Date: Wed, 26 Feb 2025 16:11:29 +0100
Message-ID: <20250226151128.362604-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s/failed allocate/failed to allocate/

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/mux/mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 30a952c34365..c4e59d2ed42b 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -107,7 +107,7 @@ static int mux_mmio_probe(struct platform_device *pdev)
 		fields[i] = devm_regmap_field_alloc(dev, regmap, field);
 		if (IS_ERR(fields[i])) {
 			ret = PTR_ERR(fields[i]);
-			dev_err(dev, "bitfield %d: failed allocate: %d\n",
+			dev_err(dev, "bitfield %d: failed to allocate: %d\n",
 				i, ret);
 			return ret;
 		}
-- 
2.48.1


