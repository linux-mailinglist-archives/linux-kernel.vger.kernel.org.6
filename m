Return-Path: <linux-kernel+bounces-322881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D131E9731EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733121F2942E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167FB1922DD;
	Tue, 10 Sep 2024 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="a6+cA9vL"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B63A192B87
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725963107; cv=none; b=NaNH/V3dDXuQtQ6ePXjnq7jzxYnzxslxPNgNBDMeuhOCXDVKRMcXS8X2Mb+hmdAfYqTpNbICZISGb2Wcj0iwBbOW4i1c5OEby/IX3+x230HlrcKOPtLIZERaVri3qiBbaBkS7Y1yZiXFfABfuh33sk8TR+mBC4PCs6Wu1g8xlU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725963107; c=relaxed/simple;
	bh=vKc1fDYKT6SuVIKLo7FGM4qvWGtQ9vU7IPb2DmZMsWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dqCMQ/uinH0/Io+kTSxuJFgssizlWh8uMfHtiMabtpfh0ZorTdsM6weSn0Z7CQVlXdwj40QmYllFYYz2ECIkQGKgiI43oO/CivJ1l4A3QnWMpphREQkKk2logstKVl4L5bqU8N2lPjvT+cWpV/v406lO3S2lplEFpHxsAoilk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=a6+cA9vL; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1725963094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mewE89KpuUNuRuPsaUATNI8/27eHihLCNzRG0ls+B1o=;
	b=a6+cA9vLVN5fCIUY7P1KcBdjoUj+ZMajIbfXX3fkGaNk2sIIAA/RG+5ivfnKYpFVS1iyFb
	P79/t6qiJ7cCrgdEnnXaUlPpUC3HKBE4EnSOlKsavU1DMdD6th1sF/urFlLU2cjyYmz1aP
	4tedQFM+BX3YjBZ6pyrNI0C3XU5N5xk=
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] mtd: partitions: redboot: Added conversion of operands to a larger type
Date: Tue, 10 Sep 2024 13:11:33 +0300
Message-Id: <20240910101133.18020-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value of an arithmetic expression directory * master->erasesize is
subject to overflow due to a failure to cast operands to a larger data
type before perfroming arithmetic

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/mtd/parsers/redboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
index 3b55b676ca6b..c8f7e7b351d7 100644
--- a/drivers/mtd/parsers/redboot.c
+++ b/drivers/mtd/parsers/redboot.c
@@ -92,7 +92,7 @@ static int parse_redboot_partitions(struct mtd_info *master,
 	parse_redboot_of(master);
 
 	if (directory < 0) {
-		offset = master->size + directory * master->erasesize;
+		offset = master->size + (unsigned long) directory * master->erasesize;
 		while (mtd_block_isbad(master, offset)) {
 			if (!offset) {
 nogood:
-- 
2.25.1


