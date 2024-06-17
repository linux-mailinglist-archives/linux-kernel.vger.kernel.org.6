Return-Path: <linux-kernel+bounces-216641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A70AB90A289
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A80D1F220B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77599177982;
	Mon, 17 Jun 2024 02:37:57 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0742AB3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718591877; cv=none; b=bHnG+H/OZmraZlNyoyczDIg4fhVx1//QrpHrKPwd2ike7EGWwMZBUp5lZgTrTdfXNxcTml+/MhHL4nxetiyxy1yxRbwm09mgNLt1fsCR0sAgPbHlejltcKOFkZ6n6AUc9hVJmNDAvD1Iq9Ydli+6j0FEmAKIIQYpi+ChRT5ktHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718591877; c=relaxed/simple;
	bh=qSL3eKAjeHt7Kk0yruu1GZl3MBX/ZwLc3o/CkrKYsg8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FGAcIrbd1xW9BaOJ/qQ+R5ALDUy6eWlIuR4iWYoIONFdHe8sbwc9ADTvj/AHX93Pfnzq8PVSCodoOUQFU0xn0c2P1MTUBlmdzb9XPVrDhRxS5kbJ6+u042EECO6wko3SMEKHx5NpaBtjVBFsaNXPmbkO7qfokB0iuZEp6JeZ6HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz6t1718591723tbphd7e
X-QQ-Originating-IP: /AI5/DWK6Ka4Eft1aYTQyvsr4t/GicHxKFCrU3cA+4c=
Received: from HX01040082.powercore.com.cn ( [14.19.141.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Jun 2024 10:35:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16799335354651430
From: Jinglin Wen <jinglin.wen@shingroup.cn>
To: npiggin@gmail.com
Cc: mpe@ellerman.id.au,
	christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com,
	masahiroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	jinglin.wen@shingroup.cn
Subject: [PATCH] powerpc: Fixed duplicate copying in the early boot.
Date: Mon, 17 Jun 2024 10:35:09 +0800
Message-Id: <20240617023509.5674-1-jinglin.wen@shingroup.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-2

According to the code logic, when the kernel is loaded to address 0,
no copying operation should be performed, but it is currently being
done.

This patch fixes the issue where the kernel code was incorrectly
duplicated to address 0 when booting from address 0.

Signed-off-by: Jinglin Wen <jinglin.wen@shingroup.cn>
---
 arch/powerpc/kernel/head_64.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 4690c219bfa4..6c73551bdc50 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -647,7 +647,9 @@ __after_prom_start:
  * Note: This process overwrites the OF exception vectors.
  */
 	LOAD_REG_IMMEDIATE(r3, PAGE_OFFSET)
-	mr.	r4,r26			/* In some cases the loader may  */
+	tophys(r4,r26)
+	cmplwi	cr0,r4,0	/* runtime base addr is zero */
+	mr	r4,r26			/* In some cases the loader may */
 	beq	9f			/* have already put us at zero */
 	li	r6,0x100		/* Start offset, the first 0x100 */
 					/* bytes were copied earlier.	 */
-- 
2.25.1


