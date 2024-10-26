Return-Path: <linux-kernel+bounces-383047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0599B1690
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE181C21036
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 09:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713401CCB35;
	Sat, 26 Oct 2024 09:38:04 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513482AEE3
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729935484; cv=none; b=SGIHUkKavldYtcmZLI1UvjQ1nvtAFPrAssxTO06We6QR5XkDm//xUSY6TA+anQ1A7Dpo2RBos6amZkV4r4f7jSJPwEEVab5Y8H0QPzHMrfm/Qs3G2Bte/mgz7x318+7MPy3rga5+59Ju3A7f1NziDY5Nru/gRFQOmjt9VwkQGrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729935484; c=relaxed/simple;
	bh=bPK2uUvsdvgK7Jrg8Q7TNP5LLAZ9TmdZaubfllyqFg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D0fI2tZd5rngsAkMZ/F9YB6RSCCFDM5kivYyAffs9kan82T5hDqbxsw1bjOtbcBkJv3G48GJh3JFyHSntzq+RR58dA2S9NJtnMV4e26oKT+5JMzTqHGmpH3io48ZQB/jw5HQE5uKpOM4Hqpptvn2jsluRVeW6TuzxLaast3Thuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XbF093mFGz2Dbwl;
	Sat, 26 Oct 2024 17:36:25 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 74DED1A0171;
	Sat, 26 Oct 2024 17:37:52 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Oct 2024 17:37:51 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <kherbst@redhat.com>
CC: <lyude@redhat.com>, <dakr@redhat.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <colin.i.king@gmail.com>, <rdunlap@infradead.org>,
	<bskeggs@redhat.com>, <dri-devel@lists.freedesktop.org>,
	<nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<lihuafei1@huawei.com>
Subject: [PATCH] drm/nouveau/gr/gf100: Fix missing unlock in gf100_gr_chan_new()
Date: Sun, 27 Oct 2024 01:38:44 +0800
Message-ID: <20241026173844.2392679-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500004.china.huawei.com (7.202.181.242)

When the call to gf100_grctx_generate() fails, unlock gr->fecs.mutex
before returning the error.

Fixes smatch warning:

drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:480 gf100_gr_chan_new() warn: inconsistent returns '&gr->fecs.mutex'.

Fixes: ca081fff6ecc ("drm/nouveau/gr/gf100-: generate golden context during first object alloc")
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
index 060c74a80eb1..3ea447f6a45b 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
@@ -443,6 +443,7 @@ gf100_gr_chan_new(struct nvkm_gr *base, struct nvkm_chan *fifoch,
 		ret = gf100_grctx_generate(gr, chan, fifoch->inst);
 		if (ret) {
 			nvkm_error(&base->engine.subdev, "failed to construct context\n");
+			mutex_unlock(&gr->fecs.mutex);
 			return ret;
 		}
 	}
-- 
2.25.1


