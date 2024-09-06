Return-Path: <linux-kernel+bounces-319105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB496F7C8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8F71C24FE5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512E61D1F69;
	Fri,  6 Sep 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XHSC+k6h"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E0D1D2F53
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725635073; cv=none; b=Yiyv6qKh3e1Kdql/sACjuxilVz4vOpAvzQxzTBav6b9z0K11F9xuoVUQeeMrGd6+x20/50mUAG6i4GDMZP/pOrzivSdRL3wT+/A3jN78nZHkajBaciHpvh7NGrUq14jQu1N4dIHczt3A6Mds1XWZV0Pc70QLqx9mHGjSadMjHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725635073; c=relaxed/simple;
	bh=nKO917iQkSklHyzXDiHt4hYUrjNzSfbThEliY8dJsW0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qq+U3O9Z7MwUjHxHKiN19N7IAt9YyDOyUuBdWyqQeq7rJigaV25zRTBN1vDbn102zOYNyVmxdIh0OshQ3n0ehUwuNCdXdm0j0BBOapCW/YYGiJjFQ/rzm8xZ1ZwAo6cs8xKq3C5toxTouXdZCW9uHybOL25CF2ZWyBe3l/25Pjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XHSC+k6h; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725635012;
	bh=s2uI9eOAaihPZf+0siC24nn5Pw8SO5uIyZM4H3qVeCc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XHSC+k6hW9V05hp+U32A6H1JwCxX+ErwMI/jE7ZMgdUEQpoG64yZgxHSbBTt8/kgg
	 TvU5pasZnE7+b+eXWWz71APzfmEdUWpNki/+DIMt3cv3vf7TfmtX2jVWbrYhilPyrZ
	 KrXtXjWWdzgNC2vth2Mh05bI6N61W1LVyQGjuq+4=
X-QQ-mid: bizesmtp81t1725634981td6ekkr7
X-QQ-Originating-IP: 0zb2X/6fk/o7ydtwNgl/yjYJt97+zSlagmdJWRi7ITo=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Sep 2024 23:02:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1837138495775610230
From: WangYuli <wangyuli@uniontech.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	wangyuli@uniontech.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	zhanjun@uniontech.com
Subject: [PATCH] riscv: Use '%u' to format the output of 'cpu'
Date: Fri,  6 Sep 2024 23:02:54 +0800
Message-ID: <BFB9D0C1A76B47D6+20240906150254.508918-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
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


