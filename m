Return-Path: <linux-kernel+bounces-216578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB69F90A1AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ABC4B21BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DC279F0;
	Mon, 17 Jun 2024 01:22:43 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAADEC2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718587363; cv=none; b=kWDSJp1fKmUDajpdQhz8c3rfj0bjpmuihR8jA0Ucxu4Kr+Dx+3kb0f+uHYVb8+n1rLYnDTORVvbmPjjNst0h0tCBkBTRbxcJK3GgFJSYlVjaYAPmaVfWTQxfUNVRRgk+WzLdgGIkDG548GJTtszz4D9D9+U34Jpk8y0dDmcf5Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718587363; c=relaxed/simple;
	bh=aPiIhR+m9iGDtxCHtCYVb7JeTUjsH3WI98/sUyxl4uA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PAlTJ/1NvbMdHJUBFywbF810hhkqPMdrBd5jGSkxQUN+qzfcpUIOxmfWAkeOQ0AI+D0kr/vpN/GJo9+9sNyqQzXQR8Q+BzE4v/zpFyuImIaI+Hb2CdEivHFv/LpOWdwO7WJgMEWbxSCQmHtlKP553P2Cd67vSzCCTKlRFOj+ZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp80t1718587302tmig7sre
X-QQ-Originating-IP: Fp5reLOndoyKSyy9u/fuvdBB965w4qMgSGCwgvdhYLs=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Jun 2024 09:21:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13392284534448976911
From: tuhaowen <tuhaowen@uniontech.com>
To: sudipm.mukherjee@gmail.com
Cc: linux-kernel@vger.kernel.org,
	huangbibo@uniontech.com,
	wangyuli@uniontech.com,
	tuhaowen <tuhaowen@uniontech.com>
Subject: [RESEND. PATCH] dev/parport: fix the array out-of-bounds risk
Date: Mon, 17 Jun 2024 09:21:18 +0800
Message-Id: <20240617012118.27341-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

The array buffer size is 20 bytes.
When executing code in a 64-bit CPU environment, up to 42 bytes of
data will be written into this array
(the size of "%lu\t%lu\n" is 20 +1 + 20 + 1).

In fact, this line of code for 32-bit CPUs also has the risk of
crossing the boundary, but it can exceed 2 bytes at most. With good
luck, it is local variables that are damaged, and there are no serious
consequences.

Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
---
 drivers/parport/procfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index bd388560ed59..9f501d5fa1ec 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -117,7 +117,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
 				 void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[20];
+	char buffer[64];
 	int len = 0;
 
 	if (*ppos) {
-- 
2.20.1


