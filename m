Return-Path: <linux-kernel+bounces-563031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 109AAA635EE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 14:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C29816E066
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D261AAE13;
	Sun, 16 Mar 2025 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mAZe0aVD"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C2F14F9F7
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742133569; cv=none; b=ZJNLmFCoUStUBuW+Od2Bv8OBoYqL3LHKalA7Dp3JxpfngzW4HPI0hTKQ93bKyj0qjrwyU2dJSLNyu43AbI4dB7VSa37cxjwKOU1bOaIwLz0Wv4IO3ZO5PRrVgMEEGpzYoPpxQD2jk85EgL4uhK/JOGSiKFo9Qid61FCWooMmSa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742133569; c=relaxed/simple;
	bh=zNhb9ARN1Ib4JmOOzaYpOsj3pFKHDQ11nagu3+L/Z2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdLxS02wqA7MxN3nPeUWh+rZ+fvfu/tAONl5yytDKdUJmoM4609z8me9mbimeh6gBKz/M6SaoSV+w4xiSQTEpFsbizo6FYxPrDlPzXxO0ul9G2/yFN9lelMTo1h42ILTHj6Kn8wmgmIelDQ//ZMRd8xtE52pQGX0SuY5TJ7C9HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mAZe0aVD; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742133565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e9dQnfubL6/p56mx1Cp/R8UogR2Cvr+0nRgF/VIruog=;
	b=mAZe0aVDIuPJMUSFkIVbtrtnYMkZgmdTKN2C5U840otUmw90+ZAdE+yafabXiSd+/4VOkN
	XAOit/8Un8w6yeBCNncBTXt4Fu9HTjAjHM1MZEAmVh6vmTPGF7xoweXAsWCr6KQ+Vb5/fu
	Exl0S51Dpkme3Nzztv97SKfEaP5/H6w=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Rosin <peda@axentia.se>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] mux: mmio: Add missing word in error message
Date: Sun, 16 Mar 2025 14:58:58 +0100
Message-ID: <20250316135857.1584-2-thorsten.blum@linux.dev>
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


