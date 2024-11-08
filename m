Return-Path: <linux-kernel+bounces-402001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D5E9C2223
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233A91C2242D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D76197543;
	Fri,  8 Nov 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mmYpDAM/"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895345B1FB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083510; cv=none; b=rm0e/oztxqchvgktLmpPZ7uRESNDi1deKcKU6hM5xGq2Y55ykTjZwsVIyzI11raTYLzp3wNEMEmJ96XmaXsdyewfKm6SKZSaQ5YWFSKLx5mNn1yBai4l83nAG1M1AUcUdyFNw/D3wCleUfMeudHk0GsKi0eG97QJCREKYUY9Tso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083510; c=relaxed/simple;
	bh=InlAyjt8b6iRxhYqf8Xm2hLm+byFL0akHUczCx16U9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O84iVVfq3QkhP4SkMCF6DUF8UxI73TXA+6xqzB/hkioTerdFhcOBdk8skhaFVPO8XT3IV8c/5AD16CF4QQr6eEqZ+jMS9LP/k+bPEjLQxoNpFeVvN2hrGy9tDWAKW2FL4ss1eE1AYhLLj4uPE9kyE71DBeYMlwMaYUn+vCfoKKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mmYpDAM/; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7FpHp
	6rlDKoP0Ri9BqBvPwPNV0yczBNLLM78zWCyTw4=; b=mmYpDAM/paY1N/Wywh8n5
	v5At8vAmd/V7+ztLgwZjxDHvTIFcHyLJDsz5jVmc8E+jXnfBGV56SlVlr/1XX9/i
	7kw9LOU8KQ4N3j0seBETV30j2WghEilCa6ztCIW+NzYwfnFAxriGOFof5Gly8Vwb
	opN5kUcwwSqcTpHBLG5kKc=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnb3NIOS5nRMtXAA--.10316S4;
	Sat, 09 Nov 2024 00:16:20 +0800 (CST)
From: David Wang <00107082@163.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	David Wang <00107082@163.com>
Subject: [PATCH 06/13] arm/irq: use seq_put_decimal_ull_width() for decimal values
Date: Sat,  9 Nov 2024 00:16:03 +0800
Message-Id: <20241108161603.9725-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnb3NIOS5nRMtXAA--.10316S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gry5Cw1DWrW3Xw17Wr4Durg_yoW3uFbEqr
	9ay3W8W3ySyryqvFyUuw1fJr95Aa4jvF95KasYgFW2yr1Ygw45Za90yFWSqa95Xrn3KrZ3
	J3s5JFs2vr1xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUU6pB7UUUUU==
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMwiRqmcuKsHpagAAsh

Performance improvement for reading /proc/interrupts on arch arm

Signed-off-by: David Wang <00107082@163.com>
---
 arch/arm/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 3431c0553f45..1b0680477ae1 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -551,10 +551,10 @@ void show_ipi_list(struct seq_file *p, int prec)
 		if (!ipi_desc[i])
 			continue;
 
-		seq_printf(p, "%*s%u: ", prec - 1, "IPI", i);
+		seq_printf(p, "%*s%u:", prec - 1, "IPI", i);
 
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
+			seq_put_decimal_ull_width(p, " ", irq_desc_kstat_cpu(ipi_desc[i], cpu), 10);
 
 		seq_printf(p, " %s\n", ipi_types[i]);
 	}
-- 
2.39.2


