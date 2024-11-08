Return-Path: <linux-kernel+bounces-401983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB19C9C21F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9601C22FC6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE8D1EF091;
	Fri,  8 Nov 2024 16:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Dam6bVcg"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2DA19ADBA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082870; cv=none; b=g8mFvWq9+VKw/u0iMldgV2ihE6+z2bg9O37ZWazT/L7l6Chbssvns3tUsYEz8jzTIx2qVHNw2S2hq39Gv2I/12AGW8rlxp4UIRBz4bTNtFKU9H3iD8OATEj1Cp+VK/bLNl3+sF1ka7XqIEbPHtljEfTtdvM/NJJaMxS4772aDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082870; c=relaxed/simple;
	bh=Bd+TUK4jz9A3YQIdOxj4+9I78h9QD7+nXTF+gfDrJxI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fTwurF29O28joRZxg3xwdywfp37HMsdEQA4CIxVK5qDa4+Yqkfm8pQihxEar+faIpuh2sDVmwD8EbKVCjVgIR98qdA4y4cy1wUK3MzGDD7/8FEVzNHB2FmFuiVjVz0KjGwRxhuOKUBKxx7jTMip4jBzKc53PAaSAWoQQnRPe05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Dam6bVcg; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=IiDZF
	yh1EQZBh7jKSHMO3jQrieFZ3EcpNlJmRc++uVw=; b=Dam6bVcgpoewp2sIgK0qu
	SKtlWmX2YgoqGQdfDbSsDLeWgo6wSdZuUA/Q9f2vzKgFFrGrTzJzT3o8qX6Gfo+F
	ZL7J6FRricNf2W78TH3VuivpEtKkyhXdpXOxXaISoGs8QSYtzhweSRV1avEASPoC
	a0E7CPpRAc+cPcLiVQ/lCg=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wC33etZOi5ney_tBA--.59238S4;
	Sat, 09 Nov 2024 00:20:47 +0800 (CST)
From: David Wang <00107082@163.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	David Wang <00107082@163.com>
Subject: [PATCH 09/13] loongarch/irq: use seq_put_decimal_ull_width() for decimal values
Date: Sat,  9 Nov 2024 00:20:39 +0800
Message-Id: <20241108162039.9818-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC33etZOi5ney_tBA--.59238S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gry5Cw1DGrWUJr1xAF1UJrb_yoW3tFX_WF
	Z7A3Z5GrW5Jayjva4q9a4fJ34qv34FvF9Yya4kuFW2yr15Jr45Ja98C3W5Zw1vqFn8XrZx
	XayrKr4qvr17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_qjqJUUUUU==
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQSRqmcuNe9JFAAAsY

Performance improvement for reading /proc/interrupts on arch loongarch

Signed-off-by: David Wang <00107082@163.com>
---
 arch/loongarch/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 9afc2d8b3414..86664adfb3cf 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -82,7 +82,7 @@ void show_ipi_list(struct seq_file *p, int prec)
 	for (i = 0; i < NR_IPI; i++) {
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i, prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", per_cpu(irq_stat, cpu).ipi_irqs[i]);
+			seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, cpu).ipi_irqs[i], 10);
 		seq_printf(p, " LoongArch  %d  %s\n", i + 1, ipi_types[i]);
 	}
 }
-- 
2.39.2


