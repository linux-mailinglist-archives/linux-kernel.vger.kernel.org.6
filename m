Return-Path: <linux-kernel+bounces-214243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D1E9081CC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6092833BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE431836F3;
	Fri, 14 Jun 2024 02:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oa6nJTJU"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB5E138495;
	Fri, 14 Jun 2024 02:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718332936; cv=none; b=UlqlcOzOUSaLFEy+plI9dql/zgX4hSMsh5bAB/HYPPYPehmx3MUq4MxE3wsgTjibNRNOuCGXHiuOqPqRWVFkPrJHvDJkaz9NjQHnossAXUHthXwP3rOy5sasFQf2tGT4KtCuX1NJb+c4SLgN5A+VP1mcntK5VhFWf++FNqF+puc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718332936; c=relaxed/simple;
	bh=hVUQsJRi4TKyZnupyhaakV/5/NVAZjRwIJw+s0kvsMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t+GWQzzu6DBWTZxRA1gDIrLvXP2NQoytcRyA4IcgCEms04xPu0JqMiYjywsSKcjNAxxhatqZyOXRqlpA/ouCl9+wclwgP+GcFCODgXu20Oe5tis7Vz9BmLvgK2wEnC6jOA/6niicfw2N1mHY/e/r28Xs/hg84yGHencaVFcIG2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oa6nJTJU; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lgirdwood@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718332930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UfEe1YjLybGIJ/Pc9DUHUap96DExZMza252cfytp4lk=;
	b=Oa6nJTJUNJvuYAK/UDqmfxa19sLK6YKBmIm9vGEU8JR0IYbegAIxmuActkC0wdv440UDR8
	Idtrh0L1mREKWZe4AM4iGPKYHH5bsGXL2sQ3zTYrpttJGQ6FtZ2BVOXuCILsImyxqhWfRL
	JmhrlSx/QSDuHfizv8WDJ2L8SPW5BJM=
X-Envelope-To: broonie@kernel.org
X-Envelope-To: perex@perex.cz
X-Envelope-To: tiwai@suse.com
X-Envelope-To: shenghao-ding@ti.com
X-Envelope-To: colin.i.king@gmail.com
X-Envelope-To: linux-sound@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: gehao@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: shenghao-ding@ti.com,
	colin.i.king@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] ASoc: PCM6240: Fix a null pointer dereference in pcmdevice_i2c_probe
Date: Fri, 14 Jun 2024 10:41:16 +0800
Message-Id: <20240614024116.22130-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

When devm_kzalloc return NULL,we return -ENOMEM directly to
avoid a null pointer that call pcmdevice_remove which will
perform some operations on the members of the pcm_dev;

Fixes: 1324eafd37aa ("ASoc: PCM6240: Create PCM6240 Family driver code")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 sound/soc/codecs/pcm6240.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm6240.c b/sound/soc/codecs/pcm6240.c
index 86e126783a1d..d3adcea457a2 100644
--- a/sound/soc/codecs/pcm6240.c
+++ b/sound/soc/codecs/pcm6240.c
@@ -2088,8 +2088,7 @@ static int pcmdevice_i2c_probe(struct i2c_client *i2c)
 
 	pcm_dev = devm_kzalloc(&i2c->dev, sizeof(*pcm_dev), GFP_KERNEL);
 	if (!pcm_dev) {
-		ret = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	pcm_dev->chip_id = (id != NULL) ? id->driver_data : 0;
-- 
2.25.1


