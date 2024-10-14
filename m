Return-Path: <linux-kernel+bounces-364153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA57099CBDC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF7F283D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7C414A4DE;
	Mon, 14 Oct 2024 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HDHwkhyT"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BEA18638;
	Mon, 14 Oct 2024 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913759; cv=none; b=RhG0eiOpE4f9LBAcTd1tAIV/r7d/+Iw5NEoI3GAowTdP7HLSGh8Wm9pwoTxu8xch3WKzAIyoKstD3sDmzFhGPZfS26kBbjhik/3fwz+hu2jpmBpyWqe/Yt4xRC2Qchzt3FlE46rnz50wRUX69eKHLRYdBCU2BKb/cFK7R+ZZd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913759; c=relaxed/simple;
	bh=oPkmE0aNJR2zZY61xEXGvtbgSlAweUgRLOYeDwL02EA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tEL9RZYinjpVbiBgw8EXKAdyy9tuvHcqws7J5mti4WF4j1TOveaJ8hUKpk3IH8b5jU/w/I+EHN5VXcjZeSMd5VxA2NsfKgxNNYIRMy08fKl+Gm8bWkuzFNKzQENVsA7oYbR2DdF3gupYYrWFnAOGP2kFSsGx4g0xKMF0qcFTxiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HDHwkhyT; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=S8rTG
	iq7SnFK4SfAjJXmtENG0UkwLoAYhI6EzKbcjzg=; b=HDHwkhyTPUMb50KbpibDr
	uWTIjm4C9PM0tBNOuBorWvxBqgIoScZAGllcq0JS1udehugcwNV3NjPtpoDbe0+O
	TLKTYw8FCLyagzygmv63+jfMos9knvWQFYXqqhM+fUnSp6HsXVWf3xzKG+4mDHMG
	dUHUJHppgJ/4OltdGMVnC4=
Received: from tcy.localdomain (unknown [120.136.174.178])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3vaA1IQ1nMAVNBA--.5990S2;
	Mon, 14 Oct 2024 21:48:51 +0800 (CST)
From: ChunyouTang <tangchunyou@163.com>
To: manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangchunyou@163.com
Subject: [PATCH] dma/dw-edma: chip regs base should add the offset
Date: Mon, 14 Oct 2024 21:48:32 +0800
Message-Id: <20241014134832.4505-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vaA1IQ1nMAVNBA--.5990S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFyrtrWxuFW8KFyftr15twb_yoW3Crb_C3
	s8XrWxXrZ8tFnxAF9rCrsxZr98u3s7Zr4fuF18tF90qF43ZF909r4UZrnrZr12g347GF9x
	AF45Zr48Zr4UKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWT5dJUUUUU==
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbiZQx4UWcNEzXYngAAsK

From: tangchunyou <tangchunyou@163.com>

fix the regs base with offset.

Signed-off-by: tangchunyou <tangchunyou@163.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 1c6043751dc9..2918b64708f9 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -234,6 +234,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
+	chip->reg_base += vsec_data.rg.off;
+
 	for (i = 0; i < chip->ll_wr_cnt; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
-- 
2.25.1


