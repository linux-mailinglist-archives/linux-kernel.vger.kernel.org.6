Return-Path: <linux-kernel+bounces-325272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A624975742
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D481B1F24D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD391A3AB8;
	Wed, 11 Sep 2024 15:36:08 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B9A15C13F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068968; cv=none; b=ZU87W6g0obeHSzdsqR3dzxzLI3LuUMlDEPFad7VMFrp1e6FSXIOdEbl3m74GsStLOjZ2HsK1UeR9C4Cbu81TLDOMQ4Nfo7Fka7FnKXdGIXcsxas39IrhUjA9sQd4nBEjMngC0TaW/ZB+53TdZoi7ApffbXzmHGZ4eE0+Ty9asJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068968; c=relaxed/simple;
	bh=HnzVWuyYcXz08qzhQCg438gs5KZu2QAF7Bbv8n4jkDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CcH2X/nyWmFagwi/2VuKSsTqDjw/Gw3IL9de3v3+dXiL7a2/LB4620xN2lHKUx7wIvn6npDqwdORD45u54xEKhouKAMl35Nsa28I+901msxTy82IOJG4qSrbcLZgwvSCIPeM7pInPJEwVJcC9AcVVvzvOvw4IeeRPrPBrqeca9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtpsz13t1726068939ts58ji
X-QQ-Originating-IP: kkPk1/yru94mJGw5v6fmFz7uXWCCOvVFAHXjy9oWKbg=
Received: from fastnlp.. ( [202.120.234.41])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Sep 2024 23:35:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16635738155626477488
From: Kaixin Wang <kxwang23@m.fudan.edu.cn>
To: pgaj@cadence.com
Cc: alexandre.belloni@bootlin.com,
	linux-kernel@vger.kernel.org,
	21210240012@m.fudan.edu.cn,
	21302010073@m.fudan.edu.cn,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>
Subject: [PATCH] i3c: master: cdns: Fix use after free vulnerability in cdns_i3c_master Driver Due to Race Condition
Date: Wed, 11 Sep 2024 23:35:44 +0800
Message-Id: <20240911153544.848398-1-kxwang23@m.fudan.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

In the cdns_i3c_master_probe function, &master->hj_work is bound with
cdns_i3c_master_hj. And cdns_i3c_master_interrupt can call
cnds_i3c_master_demux_ibis function to start the work.

If we remove the module which will call cdns_i3c_master_remove to
make cleanup, it will free master->base through i3c_master_unregister
while the work mentioned above will be used. The sequence of operations
that may lead to a UAF bug is as follows:

CPU0                                      CPU1

                                     | cdns_i3c_master_hj
cdns_i3c_master_remove               |
i3c_master_unregister(&master->base) |
device_unregister(&master->dev)      |
device_release                       |
//free master->base                  |
                                     | i3c_master_do_daa(&master->base)
                                     | //use master->base

Fix it by ensuring that the work is canceled before proceeding with
the cleanup in cdns_i3c_master_remove.

Signed-off-by: Kaixin Wang <kxwang23@m.fudan.edu.cn>
---
 drivers/i3c/master/i3c-master-cdns.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index ee555255f1a2..fe4d59833ad5 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -1667,6 +1667,7 @@ static void cdns_i3c_master_remove(struct platform_device *pdev)
 {
 	struct cdns_i3c_master *master = platform_get_drvdata(pdev);
 
+	cancel_work_sync(&master->hj_work);
 	i3c_master_unregister(&master->base);
 
 	clk_disable_unprepare(master->sysclk);
-- 
2.25.1


