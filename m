Return-Path: <linux-kernel+bounces-326638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A08976B27
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9C21F23212
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8401A4E89;
	Thu, 12 Sep 2024 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="j1CLyVYX"
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC108191F9C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149008; cv=none; b=jiAWo05CKrwyNzEbciGOc/fpur5n/pKntX39E0X3btFcs1Ts57AXChcXSlJ1XJ2tv31lv5GCPxJtWxZGweA5uuNscFTOr4ntOFzC9llujfhMpHUu+v/qOuxtaVfMKdHJAx/D3YxQJlGi1sJzuil8TnNk7SPPJhBNGWRfxwKWRoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149008; c=relaxed/simple;
	bh=nKO917iQkSklHyzXDiHt4hYUrjNzSfbThEliY8dJsW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+X5RO8H0Vmz1IEzbfMQ8TVSwffcIfiE6TFIJhaCPdWD23eUVopnhtuvocce02mMNxW0V1HM16sVO6DKmOjuZE1zquqcQfnfrXQ2VJidW2L4dGkfLjm0RTk4QFPS5imbx7MexUn2QLI5511cRhxyRidiXBLs/jNO6555OmZct6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=j1CLyVYX; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726149001;
	bh=s2uI9eOAaihPZf+0siC24nn5Pw8SO5uIyZM4H3qVeCc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=j1CLyVYXd2vZBo0xr21Y8dxlwb8ajT9S4hnOy6yZ/OPfbskL952HrXid/qvHSnkBq
	 5fTcTXX2azEKHy7eioGfda2eL79FbR/BNexloEI+pO8Api3fDwU46zcnlNKTNalp0H
	 7B4teDwVQbLDw5gs2MVdWCpJ6o3gquk0UHGVSSh8=
X-QQ-mid: bizesmtp77t1726148996tcph1scv
X-QQ-Originating-IP: S1gtQrf5JsmG/in/LdoJAWcnwzJTBcojHOYNfr9epsg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Sep 2024 21:49:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18164927246695078520
From: WangYuli <wangyuli@uniontech.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	samuel.holland@sifive.com,
	conor.dooley@microchip.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	atish.patra@wdc.com,
	anup@brainfault.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [RESEND. PATCH] riscv: Use '%u' to format the output of 'cpu'
Date: Thu, 12 Sep 2024 21:49:46 +0800
Message-ID: <E4CA32D7942C8637+20240912134946.163833-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

'cpu' is an unsigned integer, so its placeholder should be %u, not %d.

Suggested-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/riscv/kernel/cpu-hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index 28b58fc5ad19..a1e38ecfc8be 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -58,7 +58,7 @@ void arch_cpuhp_cleanup_dead_cpu(unsigned int cpu)
 	if (cpu_ops->cpu_is_stopped)
 		ret = cpu_ops->cpu_is_stopped(cpu);
 	if (ret)
-		pr_warn("CPU%d may not have stopped: %d\n", cpu, ret);
+		pr_warn("CPU%u may not have stopped: %d\n", cpu, ret);
 }
 
 /*
-- 
2.43.4


