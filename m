Return-Path: <linux-kernel+bounces-343904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7195D98A103
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E7F280E65
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA7018A6C6;
	Mon, 30 Sep 2024 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lWbjVugB"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D12B9A5
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 11:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727696690; cv=none; b=IVEiwEuFKImucqaS0oe+HXpVYzonF+5gy/G4j+s9diwz94SkRVcJrS+aY0xzXPoT0/eEATZfJalOHsdhsI7hjrnPWiVeDBvvadQ2nvwfvDuif1nx8Nw9MxKzbW3TBXk5PGLapXuO0Huh4pXnl/JJp22FuFXbYSXwdlf9lxCa7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727696690; c=relaxed/simple;
	bh=mty6Agw+Heh6Q+rKXDkuXK0/noMApt3T4a4BvbKfDzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vF1gcO6hdtYd1a/JQfQai5ZT6iNeYHVp+tmeogrDjp0b8q7MI3blgFOv8ryemHtdloAg98Mx6hTkPJWnCh7EMGbUnm/AR2L9s+/9UPhzA3+AyDLvWNckJBcyPV2nv+vwceYiGuIOZSQ6dAkMgvodNEejOlnPMeACqsCHOTfj3g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lWbjVugB; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727696685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iNd2/gpkfuM+gLT8ZelW/yN0dV2eSiGfwz/7SwjUvzo=;
	b=lWbjVugBPusAqHC9VSOQxKECm49btm2G/vf/RC9xAstyHNRLK2mm1OaU+32ius5FB+1DHr
	NpneTiiPf3p8zaZ+Q60XE+gm1jpKQpIl3egeq9duWIJegFLp8DuLk4TVv3rKBuhz0F1zlg
	DHsJxh8CCfsGNycsnPHTwKmR+LGzHQ4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] w1: Use kfree_sensitive() instead of memset(0) and kfree()
Date: Mon, 30 Sep 2024 13:44:04 +0200
Message-ID: <20240930114404.80910-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use kfree_sensitive() to simplify w1_unref_slave() and remove the
following Coccinelle/coccicheck warning reported by
kfree_sensitive.cocci:

  WARNING opportunity for kfree_sensitive/kvfree_sensitive

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Please note: this change assumes that #ifdef DEBUG is no longer needed
and we should always zero out the memory.
---
 drivers/w1/w1.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index d82e86d3ddf6..127694180eb8 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -795,10 +795,7 @@ int w1_unref_slave(struct w1_slave *sl)
 
 		w1_family_notify(BUS_NOTIFY_DEL_DEVICE, sl);
 		device_unregister(&sl->dev);
-		#ifdef DEBUG
-		memset(sl, 0, sizeof(*sl));
-		#endif
-		kfree(sl);
+		kfree_sensitive(sl);
 	}
 	atomic_dec(&dev->refcnt);
 	mutex_unlock(&dev->list_mutex);
-- 
2.46.2


