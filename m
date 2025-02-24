Return-Path: <linux-kernel+bounces-528138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC6DA413FC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47AC166E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A2A1A265E;
	Mon, 24 Feb 2025 03:27:37 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299F1F60A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740367657; cv=none; b=XMUC2XYK5WNLLeaJg58f/HpffWGA2p8Sk9m73F45nPhH4buFRC1ZwOLLTgvLWPFuVRx2vmBN69vffcWbBmmFQiQd0phk+O2aq/21t7I9TlABGv54LxUU40B5PXVVeDZB4gwjlg6Lpj97r5RQFVm1UvRcr/dP5ErjMpJ+Qb1yyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740367657; c=relaxed/simple;
	bh=cXPSkX5GJqIVnzN3KFB0Hpq75qsZ89dHQJe8qJtKyLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+98p2RaOKdZxsSZRvEOxXqdcG5T/aHTeEb/lDc7WKHUEpq/fnZt8wkpZNP5nmp1Tovpl575bwYm3Nqp57fehb6DvbpPGi+oEVoRVyAB3NpGwi8DjMFYSeXFse59mSzDq5tEXWxVP/DGSl9Y3/z7Y3/orQJWNNQXgc3MFacnd1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1A7081A0E8D;
	Mon, 24 Feb 2025 04:19:11 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D2AB51A0E7A;
	Mon, 24 Feb 2025 04:19:10 +0100 (CET)
Received: from lsv03121.swis.in-blr01.nxp.com (lsv03121.swis.in-blr01.nxp.com [92.120.146.118])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 333C91800083;
	Mon, 24 Feb 2025 11:19:07 +0800 (+08)
From: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To: miquel.raynal@bootlin.com,
	conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: manjunatha.venkatesh@nxp.com,
	rvmanjumce@gmail.com
Subject: [PATCH] driver: svc-i3c-master: Kernel panic issue fixed
Date: Mon, 24 Feb 2025 08:47:54 +0530
Message-ID: <20250224031754.1001101-1-manjunatha.venkatesh@nxp.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

I3C Master driver svc-i3c-master

As part of I3C driver probing sequence for particular device instance,
While adding to queue it is trying to access ibi variable of dev which is
not yet initialized causing "Unable to handle kernel read from unreadable
memory" resulting in kernel panic.

Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d6057d8c7dec..98c4d2e5cd8d 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -534,8 +534,11 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	switch (ibitype) {
 	case SVC_I3C_MSTATUS_IBITYPE_IBI:
 		if (dev) {
-			i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
-			master->ibi.tbq_slot = NULL;
+			data = i3c_dev_get_master_data(dev);
+			if (master->ibi.slots[data->ibi]) {
+				i3c_master_queue_ibi(dev, master->ibi.tbq_slot);
+				master->ibi.tbq_slot = NULL;
+			}
 		}
 		svc_i3c_master_emit_stop(master);
 		break;
-- 
2.46.1


