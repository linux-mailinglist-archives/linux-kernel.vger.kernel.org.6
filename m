Return-Path: <linux-kernel+bounces-235698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9543F91D887
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521B228394B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92427E110;
	Mon,  1 Jul 2024 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Cj+0m9gN"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6587406D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817521; cv=none; b=puPsAG24FN8m23V9zAvebZvoug5F4nboLqmFbMqQGaAfwMriBy9HQZ2aDx+hXkKs6Ij7i6boTJjLmPDpWoKD69V//K1VQHa1ixKxoCn3GWNaSWhETP6nTMaosha3yIdI+lFVsyjYFNiVRLP08qEs+6neJ2xp8MIEB22aGKL5Iu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817521; c=relaxed/simple;
	bh=/D5/Qp3rVxkhRpAN6W8TkcT0LCSs1hYrg5++AwSzr24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WA2hvQlIfd9aQBXHOu9MBW0qhdlwBEb4kK2ljqA/UNxYSOBYC5Dc/Ohoxadm5fs3rdlq/2GnpU+a2dDUnNgS1YXEsZWC0Ts90rIJ91D1m10/Vo4AFgG/CxELHyY7Tp1mopdRnRcGufbZsrhyCnpWZoq5Gw2usVq/XUTYTPcUvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Cj+0m9gN; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719817511; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IM5TGvOlJvu0p7GNZlYVVp88qVq9MYjf5CUJSWGJK4g=;
	b=Cj+0m9gNNd0LIZIOKDgKBBtc1o5iaDhdD+ToHwa56WRHq//0FF6cYrdbNnfmqhOzvj7HudFOpXAXyil80ycBkMAd5lHkoDmNs7vEWlL9AFgOXZpTLva7ZQ7h4Nz+HrFtuS2S4qI4HyLEF4fSSaYPhDSYt8HppvKslogo2zeBSGY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W9b27vI_1719817509;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W9b27vI_1719817509)
          by smtp.aliyun-inc.com;
          Mon, 01 Jul 2024 15:05:11 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 1/4] drm/amd/display: Fix warning comparing pointer to 0
Date: Mon,  1 Jul 2024 15:04:54 +0800
Message-Id: <20240701070454.106083-4-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240701070454.106083-1-jiapeng.chong@linux.alibaba.com>
References: <20240701070454.106083-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid pointer type value compared with 0 to make code clear.

./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_factory.c:31:12-13: WARNING comparing pointer to 0.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9458
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_factory.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_factory.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_factory.c
index a34506a78c50..e0b9ece7901d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_factory.c
@@ -28,7 +28,7 @@ bool dml2_pmo_create(enum dml2_project_id project_id, struct dml2_pmo_instance *
 {
 	bool result = false;
 
-	if (out == 0)
+	if (!out)
 		return false;
 
 	memset(out, 0, sizeof(struct dml2_pmo_instance));
-- 
2.20.1.7.g153144c


