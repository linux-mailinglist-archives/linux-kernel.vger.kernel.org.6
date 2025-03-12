Return-Path: <linux-kernel+bounces-557421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A72A5D8B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DC233B879F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4588C2356A1;
	Wed, 12 Mar 2025 08:57:36 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E323644E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769855; cv=none; b=PdjBr8hzajBJN2Ln+uiK4ml5Gj0J/950G9K+DmYbEYUbJd1R8Cd6O/haIiCgvKyyFU/TfzAwdHqDBE0YtmRiPBDTCVu4ENgLNPBMB3QK3sVifqNZ2gT2G6GS2TMvu22vBjUJwNFI2b/4OcE+aUof/2T1BdeexC3ZuDsMQ9TfVRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769855; c=relaxed/simple;
	bh=8/QLN8kIjzii/jWFCF8iv2COgMB2Hoz2uueduVnmzbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PAv/vdNBD4usQy8HbPzLeX8CzExxff3V5o5+rCKsZyjJWONdRpo/wXiTr5t3aMi13KoU0KwUy3CQJBTrKew77qCVz5J1MZDL0SSdumB8ttBIOVr1TOZ8EXZcdHbWnj+qt7pWAZ2K2Q+ohfN4943y8/yrXAt5Is9V9Rh4OGI/+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowACXn9NtTNFnA2KCFA--.65235S2;
	Wed, 12 Mar 2025 16:57:18 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] nvmet: pci-epf: Remove redundant 'flush_workqueue()' calls
Date: Wed, 12 Mar 2025 16:56:25 +0800
Message-Id: <20250312085625.1624394-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXn9NtTNFnA2KCFA--.65235S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1xZFy7tr1DuryrtFyxZrb_yoWfZFgEk3
	9rAF4kKa1Duw1qk3yUGr1YvFy0kasYqF12va95trZxta4UWw4rZw1vvws3X3s7uw10qr17
	ury7W343Wr9rCjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VUj22NtUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@
- flush_workqueue(E);
  destroy_workqueue(E);

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/nvme/target/pci-epf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 565d2bd36dcd..82956c207b42 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1385,7 +1385,6 @@ static u16 nvmet_pci_epf_delete_sq(struct nvmet_ctrl *tctrl, u16 sqid)
 	if (!test_and_clear_bit(NVMET_PCI_EPF_Q_LIVE, &sq->flags))
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
 
-	flush_workqueue(sq->iod_wq);
 	destroy_workqueue(sq->iod_wq);
 	sq->iod_wq = NULL;
 
-- 
2.25.1


