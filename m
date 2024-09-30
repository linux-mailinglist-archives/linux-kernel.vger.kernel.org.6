Return-Path: <linux-kernel+bounces-344365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEBC98A8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B661F26F10
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2A219CD1E;
	Mon, 30 Sep 2024 15:33:22 +0000 (UTC)
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57919ABCD
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.5.119.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710402; cv=none; b=pxP3dmpHwCJ2P/hyfAceoqZqi3Pb103VDWAd+3IjkIeJiSZUF7t0Szu3mTKoioamsU4A+eJfBKfbacAMP7BeV8z1NguZs4Jy68YvHvHLNXySrs7paICpAVpQy9+ysHAmUt83G1BvSvbXRJXi21/wQ8rpMuYlXdba2iazJ4JtYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710402; c=relaxed/simple;
	bh=j2IlBI1xK8TKv3ARgJFQxwlQn6szkcbFH4+kTBLMqVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FiqVk9kdVGODnCPeltQtXjd0zDVjfUljplWSr0+eAcad3HZ1VsibaTc2aBF668nCq5DYfeTEKLTA0uprMB2+b4lH8rG3XNJECMJLvaVL0cKI5vcIi8mTsj6cjVcil6fu2HFDs0GcuKjRVn5ymB6q5o26izk9PUOlxPJoo7kIE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru; spf=pass smtp.mailfrom=mcst.ru; arc=none smtp.client-ip=212.5.119.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcst.ru
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
	by tretyak2.mcst.ru (Postfix) with ESMTP id B175E102391;
	Mon, 30 Sep 2024 18:33:08 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
	by tretyak2.mcst.ru (Postfix) with ESMTP id ABD7C101765;
	Mon, 30 Sep 2024 18:32:23 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.63.223])
	by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 48UFWMPI023053;
	Mon, 30 Sep 2024 18:32:23 +0300
From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To: Karol Herbst <kherbst@redhat.com>
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>, Lyude Paul <lyude@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] drm/nouveau/clk: prevent division by zero in gt215_clk_info()
Date: Mon, 30 Sep 2024 18:25:51 +0300
Message-Id: <20240930152551.1581766-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
	 bases: 20111107 #2745587, check: 20240930 notchecked
X-AV-Checked: ClamAV using ClamSMTP

sdiv can be zero if read_vco() returns 0 or khz is greater than sclk*2.
This value will cause a division-by-zero error in the gt215_clk_info() function.

Add a check before division. 

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c
index b5f3969727a2..4c53442b4167 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c
@@ -206,6 +206,9 @@ gt215_clk_info(struct nvkm_clk *base, int idx, u32 khz,
 	default:
 		sclk = read_vco(clk, idx);
 		sdiv = min((sclk * 2) / khz, (u32)65);
+		if (!sdiv)
+			return -EINVAL;
+
 		oclk = (sclk * 2) / sdiv;
 		diff = ((khz + 3000) - oclk);
 
-- 
2.39.2


