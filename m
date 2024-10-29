Return-Path: <linux-kernel+bounces-387009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2538D9B4AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3302843E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5B4206046;
	Tue, 29 Oct 2024 13:16:40 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A279320262A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207800; cv=none; b=Nd+JNeC6NHaomT0j49SvSWByOkLImKcecu8YeNLOFW+O6yga5+3RoACtBecrrvi82GEZXhj3I+K2qC1tkLXgdxjTu4gvo5TjGJQFeFJj/Snjxq2GBdprLcPHIBPMxBMVNtjpycCfAlpD/carhlxEaDDZ5EUfZJFLu8yaP9xqjec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207800; c=relaxed/simple;
	bh=u0nOwaNOrm76d4nVlVeX8pBWNT44H10KAZQbiT2q5Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWw901DFXQG5OtMH3LX4WViIgaTinKQ99rHXQOOPlofRlnbj1QtcP94GVSwo6zvr7QMTRWItVEvxYGiyzaEjFA14GQ1iKkKyImvk5cSNGJear/IX+ntWjh7S0b6I1/+x/Qj1c73DkiD1mUpKjAT2vDVYs1R4MnjLR9ApZq86QnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xd9kQ2qs7z4f3jdc
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:16:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 14A6A1A0194
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:16:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.84.45.119])
	by APP4 (Coremail) with SMTP id gCh0CgBHIoYs4CBni_QeAQ--.56221S4;
	Tue, 29 Oct 2024 21:16:31 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: jassisinghbrar@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	yangyingliang@huawei.com,
	bobo.shaobowang@huawei.com
Subject: [PATCH] mailbox: mtk-cmdq: fix wrong use of sizeof in cmdq_get_clocks()
Date: Tue, 29 Oct 2024 21:16:28 +0800
Message-ID: <20241029131628.1610-1-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHIoYs4CBni_QeAQ--.56221S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtw43CrykGF4xJFWxury5XFb_yoWftFc_ZF
	1UAryxWryUAF1fJwnxta13Ja9Fvrn8uFs2kr9a93sxW347Zry5Ar1DWr4Fvw47WrWDKrW3
	Aa1ktr18Jw1xCjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

It should be size of the struct clk_bulk_data, not data pointer pass to
devm_kcalloc().

Fixes: aa1609f571ca ("mailbox: mtk-cmdq: Dynamically allocate clk_bulk_data structure")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 4bff73532085..9c43ed9bdd37 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -584,7 +584,7 @@ static int cmdq_get_clocks(struct device *dev, struct cmdq *cmdq)
 	struct clk_bulk_data *clks;
 
 	cmdq->clocks = devm_kcalloc(dev, cmdq->pdata->gce_num,
-				    sizeof(cmdq->clocks), GFP_KERNEL);
+				    sizeof(*cmdq->clocks), GFP_KERNEL);
 	if (!cmdq->clocks)
 		return -ENOMEM;
 
-- 
2.33.0


