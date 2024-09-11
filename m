Return-Path: <linux-kernel+bounces-325218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69890975655
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30D0A282186
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9016519F104;
	Wed, 11 Sep 2024 15:02:38 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E912C859
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066958; cv=none; b=V9aeRdyzTxPRmeyyfXsdssIJbSlLQGXDRx1VypOlEUp8/kU5ATS3kr16uBqEZXbtj7sz1zBF7hlQ+wMH5vz7QJKyA4+kLx5yFxOt8mCTREQZvqlkFqsVySARCXRUP8w0pwb1gTpeytL36Oq4dA5czNZ7BDArxvhzL7EOE4fHQ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066958; c=relaxed/simple;
	bh=SglzaBm70iFLCbQgg6Y3DYUTlg7YMYX0ldhBS/naFbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fvOhYOshMA92b42fkCc76+PMFd53UvZIwdpT8zrZN0ZXkd64fiWfe9nMYDfGipRQ7mCT4BUVEtnje+lI5JdEyaatsSOXi+H5Wl7Dk4b8FtztP7tRuYwNgpq7Xrt9ccGq6sMNk90zvrl2nsbfRJOrakdzSNEHgfbTvCuNbvKxFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtpsz11t1726066890tsr0e7
X-QQ-Originating-IP: Y6v+T0f7c12A5OabWBayGIbWcZSTO4NMcfS5l/rjM4I=
Received: from fastnlp.. ( [202.120.234.41])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Sep 2024 23:01:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13582565552656211047
From: Kaixin Wang <kxwang23@m.fudan.edu.cn>
To: miquel.raynal@bootlin.com
Cc: 21210240012@m.fudan.edu.cn,
	21302010073@m.fudan.edu.cn,
	conor.culhane@silvaco.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>
Subject: [PATCH] i3c: master: svc: Fix use after free vulnerability in svc_i3c_master Driver Due to Race Condition
Date: Wed, 11 Sep 2024 23:01:35 +0800
Message-Id: <20240911150135.839946-1-kxwang23@m.fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

In the svc_i3c_master_probe function, &master->hj_work is bound with
svc_i3c_master_hj_work, &master->ibi_work is bound with
svc_i3c_master_ibi_work. And svc_i3c_master_ibi_work  can start the
hj_work, svc_i3c_master_irq_handler can start the ibi_work.

If we remove the module which will call svc_i3c_master_remove to
make cleanup, it will free master->base through i3c_master_unregister
while the work mentioned above will be used. The sequence of operations
that may lead to a UAF bug is as follows:

CPU0                                         CPU1

                                    | svc_i3c_master_hj_work
svc_i3c_master_remove               |
i3c_master_unregister(&master->base)|
device_unregister(&master->dev)     |
device_release                      |
//free master->base                 |
                                    | i3c_master_do_daa(&master->base)
                                    | //use master->base

Fix it by ensuring that the work is canceled before proceeding with the
cleanup in svc_i3c_master_remove.

Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
---
 drivers/i3c/master/svc-i3c-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 0a68fd1b81d4..e084ba648b4a 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1775,6 +1775,7 @@ static void svc_i3c_master_remove(struct platform_device *pdev)
 {
 	struct svc_i3c_master *master = platform_get_drvdata(pdev);
 
+	cancel_work_sync(&master->hj_work);
 	i3c_master_unregister(&master->base);
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
-- 
2.25.1


