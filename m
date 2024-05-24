Return-Path: <linux-kernel+bounces-188390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AA98CE171
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3519282B21
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E60412836A;
	Fri, 24 May 2024 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LebbOykl"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEF218E1E
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716535037; cv=none; b=IntIn+kTIT0jDL6sUAvvpE9MKE5daLfTcpBLNsNo6cacSoH0OZFl0/Py0yQfgrcEjlqmLwKeAuxg0JLyR0H9Di3ugHO4daCEcQO077qRg6ilzt56zF6ctJ8g4doZ4mw4x9oISD3KCJPO/3U78tKQ+Zn7qfNZf57lFmsQ2w0JzAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716535037; c=relaxed/simple;
	bh=epQCMj6liaNyJKlgtrEwum2Sais5F5kH3zdh6Ga1KMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GmP8JE/ouLh/EH++IosMRPp94qMNOUdRYbS/ofz0PIqp5L1bhH+J6OGpPYGCfjKXXs+stV6eCT0n8n+AcqP6sSDOOGAe83qPM0eBTE+iVLD/oF+epnLXwgNy2CnDog7C3t7HuDz4x1cc+aNpIaeZrw/Ih0JijWSpPQ6iN8D+Zpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LebbOykl; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716535026; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9kE5+w2PYj6eGYpIIldbh4TJulssfp+nNT8yXcCeH18=;
	b=LebbOyklCTcN+nkCJ110GMXymxIriRcoLAM3HlRniwvoj6JZYLVsohJe7QZApTIBSulAhsRMc+OeGvs5DFPqZ/piJ6zPG+2Fjd9kPVAlVtTPTFdPq5P2Tb0TTVwS6X7NICyS00RUEhsPuJFlGIWtoIDUPq0a9pgiXdblZiZeZKc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W75o86V_1716535018;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W75o86V_1716535018)
          by smtp.aliyun-inc.com;
          Fri, 24 May 2024 15:17:06 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] XArray tests: Compare pointers to NULL instead of 0
Date: Fri, 24 May 2024 15:16:55 +0800
Message-Id: <20240524071655.31386-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid pointer type value compared with 0 to make code clear.

/lib/test_xarray.c:973:52-53: WARNING comparing pointer to 0

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9169
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 lib/test_xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index ab9cc42a0d74..a281436267ce 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -975,7 +975,7 @@ static noinline void check_xa_alloc_1(struct xarray *xa, unsigned int base)
 
 	XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_index(10), XA_LIMIT(10, 5),
 				GFP_KERNEL) != -EBUSY);
-	XA_BUG_ON(xa, xa_store_index(xa, 3, GFP_KERNEL) != 0);
+	XA_BUG_ON(xa, NULL != xa_store_index(xa, 3, GFP_KERNEL));
 	XA_BUG_ON(xa, xa_alloc(xa, &id, xa_mk_index(10), XA_LIMIT(10, 5),
 				GFP_KERNEL) != -EBUSY);
 	xa_erase_index(xa, 3);
-- 
2.20.1.7.g153144c


