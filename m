Return-Path: <linux-kernel+bounces-204357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A408FE7AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDECE1F23506
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E84195F3D;
	Thu,  6 Jun 2024 13:24:53 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DFF195B0E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680292; cv=none; b=sq7AtY1MDaWKj9MUtNmuvbYB6LFZVXyvSOHFSlS2m9zSgQ+djxnuLA68RYaQC4T4V8+5SvBDkPiEybnu1V/ktd7hhVvG2Z9vJSyPATJ03qGxP7uE/XbLPKcXpQWqQxjoNd9iMBGOsHJR+HNKMzzO+yFv9U2/r9WQ06yWbBrEkPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680292; c=relaxed/simple;
	bh=rNBwdzFBhysEd9wzyQXAbWC3pB6V0UCYgvGyEBhdwgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SSO82QNa2pRmcklh1BdQMGjlpza+il+9xJHmHTLX5iPiZHzDlKQGA0mHrNLZWnrIi8pCoLbQXUY78B3DytTjODyrSOCk11+Sn82Q4kEH6khAMeppsM7LhexMMwNuXV6xy318tB3FSBHiqihK/Dct7+ldH9vA8EJke9s76wL+9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz1t1717680152t9w1o59
X-QQ-Originating-IP: AmpsQDgASEaAJP+E87sCAd76grdai6fjPk9qNQFKsTE=
Received: from HX01040082.powercore.com.cn ( [14.19.67.247])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Jun 2024 21:22:30 +0800 (CST)
X-QQ-SSF: 01400000000000B0B000000A0000000
X-QQ-FEAT: ZbT1X8e7m5Fo8AN97Qo/SfGebcJKiGCLiCQTkAdeNHxeen7puOp3rgyNhjIt5
	7ivIxPLQoqj+KveACDdj1lmBLe2B8/h/Vu0gnl0TIdLE8IDLugpGSGFcirwJP07QLzJL70D
	cgcDtrWYTwlJ9foJ0eDH0q5qY5aybrSj0hEeGnf9DDQB7Y7NJHxJ+1YAkXKnCuds3woC6tq
	0GKmhV3D2upU42VhZB6cbfDqQuYa+lH4lTGgjJqB4gCsEQF8JaQo/9N4cI9EiKqyVtOSna/
	0dXm1bKxjcSRrgLGUJoblqa04ndCqf35Ce51QfzRd3kAjBx+G93Vv1lUCMa5nHc9yq59avq
	A5RJA9krwXJw+hZMRDcyO6SwkDveAgBf/RznDViJIF90orGxmoprHMOgw12ww==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 20561316882800220
From: Jinglin Wen <jinglin.wen@shingroup.cn>
To: npiggin@gmail.com
Cc: mpe@ellerman.id.au,
	christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com,
	jinglin.wen@shingroup.cn,
	masahiroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Fixed the bug of duplicate copying
Date: Thu,  6 Jun 2024 21:21:32 +0800
Message-Id: <20240606132132.13785-1-jinglin.wen@shingroup.cn>
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

Fixed the issue where the kernel, when booting from address 0, had
code incorrectly duplicated to address 0.

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


