Return-Path: <linux-kernel+bounces-189864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B168CF5F4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B841C20C32
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386DA13AA53;
	Sun, 26 May 2024 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PhiVssvG"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D2139CFA
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716754935; cv=none; b=gEOka46Ssf3TVWR7wIPX1cElia6gWloIVU0E/V5PYzta5QrBuOeXZV1mSi5J8oUzRig/CFjFYYDKTHLxiHguTZwEYS0vXGymQEzQM3ZW5q7+owk7XbIi6+ely06AHF8al0G/GBli5EsebVvYBlqNm0QwiQCqCjVsi6J31cE9elI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716754935; c=relaxed/simple;
	bh=6BzoTFV37Xlh0oGBJjU6vH9DkyXyO9By/npTth72kd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=llHJZgkTP/MDQB4hQWT8ohi1TkTmW/LbbxnldeL771jj/9dzh08R4E7XTOcs9FbKpnIo1f9nYhNXcWw1Uf/l7HBpWYSNsK1iK7r2zULlJC5XLHipYjdQ2aAV3wtJdbZ7TvZBWgNHo61V+lBtAPmrY7hR76V10DgUOkrf+iWX0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PhiVssvG; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: rfoss@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716754932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQejp35xdHl089YksIdueCjCLA/1BLC6JglYUKdLrzM=;
	b=PhiVssvGa0otgkxBvZ6vngXfyNqXoYz2Td1XFsCxUXvwz5Y4MevBR8yY1/HMUCcdTJRlcu
	zZXSkQan1Nyxd9NG89c86Y6VCJ+4Ok/+J8JhggcZ0Zbi3n0ejfPIpJCu2nRHTmEdOfU9+M
	9oP9XD5m5a2RxER8e0NFI2n37N7g4lE=
X-Envelope-To: laurent.pinchart@ideasonboard.com
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sui.jingfeng@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH v6 09/10] drm/bridge: sii9234: Use fwnode APIs to abstract DT dependent API away
Date: Mon, 27 May 2024 04:21:14 +0800
Message-Id: <20240526202115.129049-10-sui.jingfeng@linux.dev>
In-Reply-To: <20240526202115.129049-1-sui.jingfeng@linux.dev>
References: <20240526202115.129049-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Switch to use the freshly created drm_bridge_set_node() helper, no
functional changes. The reason behind of this introduction is that
the name 'of_node' itself has a smell of DT dependent, and it is a
internal memeber, when there has helper function, we should use the
revelant helper and avoid directly referencing and/or dereferencing
it.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/sii9234.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index 7d2bbc31bac9..d930c093abb3 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -817,10 +817,11 @@ static int sii9234_init_resources(struct sii9234 *ctx,
 				  struct i2c_client *client)
 {
 	struct i2c_adapter *adapter = client->adapter;
+	struct fwnode_handle *fwnode = dev_fwnode(ctx->dev);
 	int ret;
 
-	if (!ctx->dev->of_node) {
-		dev_err(ctx->dev, "not DT device\n");
+	if (!fwnode) {
+		dev_err(ctx->dev, "firmware data is missing\n");
 		return -ENODEV;
 	}
 
-- 
2.34.1


