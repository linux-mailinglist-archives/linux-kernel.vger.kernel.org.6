Return-Path: <linux-kernel+bounces-562389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC03A62527
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 04:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6453C3AE4E3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C422C1898E9;
	Sat, 15 Mar 2025 03:08:10 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79419187325
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008090; cv=none; b=H8T16fqNHj3ijIgmkqcBeBsvAxKVunWQp1mkMSVmGhj2H6TBndsMcnFC98RTDlcbjrGNN0QdDboikfY85d70dmb1q4WAI+ApTeTOwUHi1QmEzNaVHqyTdRz8Q+tQDAnjI4J0sX6/NKr7IH1EEI5OdtrMdt1FRIReSg5qk8gyqkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008090; c=relaxed/simple;
	bh=s7ux8sxTI6I3Cc459xxdcV/btp8jYB6zwKCWwcVuZgQ=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=DzDm2Mv84Dn5cGuQeubJ8swVZ2+WM5McDoCDAzoyPqsc/dWrU8IdspN7KmzI9IWtrvDn18Q9RqxC59lyK2tob93vGKHoaW/Ba+xx2SfYrPWeGZxXVZG0xjehJls3y5fyAiEcCg74jvIGXAR9oOcABeWmXGRdPAYJqYbs98WnGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZF5lR0N6jz501gV;
	Sat, 15 Mar 2025 11:08:03 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 52F37wl5041226;
	Sat, 15 Mar 2025 11:07:58 +0800 (+08)
	(envelope-from feng.wei8@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 15 Mar 2025 11:08:00 +0800 (CST)
Date: Sat, 15 Mar 2025 11:08:00 +0800 (CST)
X-Zmail-TransId: 2afb67d4ef10249-a60fe
X-Mailer: Zmail v1.0
Message-ID: <20250315110800107off32dfmFxS4oTSqBr20T@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <feng.wei8@zte.com.cn>
To: <james.smart@broadcom.com>
Cc: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBudm1lLWZjOiBSZXBsYWNlIG5lc3RlZCBtaW4oKSB3aXRoIHNpbmdsZSBtaW4zKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52F37wl5041226
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D4EF13.000/4ZF5lR0N6jz501gV

From: FengWei <feng.wei8@zte.com.cn>

Use min3() macro instead of nesting min() to simplify the return
statement.

Signed-off-by: FengWei <feng.wei8@zte.com.cn>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b9929a5a7f4e..fbb11962894f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2858,7 +2858,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	unsigned int nr_io_queues;
 	int ret;

-	nr_io_queues = min(min(opts->nr_io_queues, num_online_cpus()),
+	nr_io_queues = min3(opts->nr_io_queues, num_online_cpus(),
 				ctrl->lport->ops->max_hw_queues);
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret) {
-- 
2.25.1

