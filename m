Return-Path: <linux-kernel+bounces-233270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B672D91B513
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA71283905
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003BA125DB;
	Fri, 28 Jun 2024 02:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K7K+KSju"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125CFBEA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719541715; cv=none; b=Pb6A5SSkNmEOEy5XrbRNXTcjxXIMoHVzaPCEO3UgUiCy7yHeNegH8VctsKYj9PQlAYIt1QMli6kIBU0aT7lnwsb0xsIgu8ci01inqAdzIu/KnB7ycRUsJOPfB6ACbRKB0tfbkt2QqG7KvFLkW2agpxnMrNmedhyn36XAzr5F2rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719541715; c=relaxed/simple;
	bh=cFg+BR0FgKsLplv1+pgC5yvn3dvYS/ChZEaS7UAsdz8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CPCooB2JpStCyBsNRHwIBT/ySalV8m497EHvw9tlumgvJYfc+DI3A9/+jAKezKatwCNckU09iWCpRRyN+wJodlQqjk3MtO+Py7Dxd/MoR5Edt/dX6SIetyE++VsU/glCEtrMTKeE8s7f5O88vCZu88nSVuEJ/ezKVCndg15BDss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K7K+KSju; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719541703; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UIpekgmkMQlGmmxfSQVtLI0+fDcAlsmJCvshlYQc9UM=;
	b=K7K+KSjuT0dhyW5PpwFe5ZUiXiAIptV/jKIcJrYuXUOK13RJqVszTOOT4cnpZefhz8xcP32w6q87HaFFtAkrEjJ6LysTwL7dNp0T9UEefl7y1+Dn+XLcBrZzwz8LOZMHbztKLplkMeCmBbyU54N/NMrL/dCaxRvZBiF+CLS+nLQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W9ORZ0C_1719541692;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W9ORZ0C_1719541692)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 10:28:23 +0800
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
Subject: [PATCH] drm/amd/display: use swap() in sort()
Date: Fri, 28 Jun 2024 10:28:11 +0800
Message-Id: <20240628022811.82803-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing swap() function rather than duplicating its implementation.

./drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c:18:29-30: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9435
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 .../display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c    | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
index 671f9ac2627c..9f48cef638ff 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c
@@ -8,16 +8,12 @@
 
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
2.20.1.7.g153144c


