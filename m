Return-Path: <linux-kernel+bounces-260709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A352593AD44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58ADD1F2286C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78A373509;
	Wed, 24 Jul 2024 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h7XeOrRh"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA591CAAF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721806690; cv=none; b=YkQ+4KI1DTzR83LXPOofRkcZLNbdp16XQFDyqgHlDNeTbBEf+CDzoFUEbyerdRQ7c9BKsQBapZtV4N/eRSIC5JvLtxJ3hsLNCzg1ywio4Ci9wdc3Hgt1hTx4HpHWF6MY9rcSMsRX1KIceFXfOPW0WNbeY6fqfLRH3jVi83Lh/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721806690; c=relaxed/simple;
	bh=njDqmzic4vnAcYQ79ONzC/2gKcRubGx6bre5ROICkx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NQHkn5BPHKTARRo4ilqO+h0P7d1/5t/5JWovKTSvbhoYPSC0By58uzNZWpqQdht2u0MpGmXsUh4CVb9vCQK53xoEYrbUIBreAHn4sf4peQN54zYvRl9bMNbYs71IWPSQQhXvss020Qpp99/RPYVuloJSWpWUvkgAuFZsKNsOYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h7XeOrRh; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721806680; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=rAGYYc4I8IT8kc2kTezhDQbo9h4T2Gzxv5TX4WM92Cc=;
	b=h7XeOrRhSeH1vbwE0H7ADL3Z+qv9fWqZxS1VJoczW9qCf9HDZOiC9+HtKh036TyJ9gQwPtVRXNQ8g9IjAKcWUW2NBxkVBYG9+qK3sltq/oP9ID74iU4A3M6/4qUtk7RJjUrl142DCZagfJ7HRe32Yn5gWA7vMW2QcpyC+2cqVjQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0WBDLO5j_1721806670;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WBDLO5j_1721806670)
          by smtp.aliyun-inc.com;
          Wed, 24 Jul 2024 15:37:59 +0800
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
Subject: [PATCH -next] drm/amd/display: use swap() in sort()
Date: Wed, 24 Jul 2024 15:37:49 +0800
Message-Id: <20240724073749.14338-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing swap() function rather than duplicating its implementation.

./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c:17:29-30: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9573
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c    | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
index 717536d7bb30..8e68a8094658 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
@@ -7,16 +7,12 @@
 
 static void sort(double *list_a, int list_a_size)
 {
-	double temp;
 	// For all elements b[i] in list_b[]
 	for (int i = 0; i < list_a_size - 1; i++) {
 		// Find the first element of list_a that's larger than b[i]
 		for (int j = i; j < list_a_size - 1; j++) {
-			if (list_a[j] > list_a[j + 1]) {
-				temp = list_a[j];
-				list_a[j] = list_a[j + 1];
-				list_a[j + 1] = temp;
-			}
+			if (list_a[j] > list_a[j + 1])
+				swap(list_a[j], list_a[j + 1]);
 		}
 	}
 }
-- 
2.32.0.3.g01195cf9f


