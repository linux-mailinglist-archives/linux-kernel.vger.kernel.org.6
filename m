Return-Path: <linux-kernel+bounces-401979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBE79C21D0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAFF1F214BD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9026A183CD1;
	Fri,  8 Nov 2024 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EqRT1aW9"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDFC1BD9DB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082707; cv=none; b=c91PjoTCe81+fZICqBYuAxwK3zyZhCcQ1k7MjJ4W7yXpa1eB1OVA/rzYkAczQ6+AdFUjL9yZjk6mrnKhOlqsycyOvgW8x1maqA+XgfZy0XtlTiq0EbNkGx9RVCVIRLUDQaKIwt1+nYA0lscNma3T4oK4Sfq/CVVdQMgvfi+uu8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082707; c=relaxed/simple;
	bh=QNmAgeKon2UPDE7Frx6OVDX0Ky/uee01pGiLjo4u4is=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eED8h9AUDGxMV2h1NWpOSKRaqG9gRrGwPr1QfDRdoCV1iJwoQMkh7mbdElhWBpLhFGSb/U8E2vqLhIaa+llSaTb2H8ltm1IU144CNZcoKKUzu4Sp4kXJx/InR5pldSxNLWLIHTk+04bf8nopDCC/BNocNEcMem2an+k3ZrpPLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EqRT1aW9; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=92qch
	eUV0dc6p0i85+WrrzuptWSwQKzn7BIaV0kNAAY=; b=EqRT1aW9aa3NPcQoWFPMI
	tyB0lPhEBb2sAM9vhhDyhHdYMt4MZRtmSodgX8vBK28pk1zs/7gpe11Flyn4ONz7
	Oj41hKsCv3ppREWwCzb91AHOem/hvwGDCKQ3jph8P6CrU4kiudwFCH8N3OZbS0DZ
	G2kECrne5hcZ8Q/ow4FNcU=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD33+izOS5nkKkeEA--.43507S4;
	Sat, 09 Nov 2024 00:18:03 +0800 (CST)
From: David Wang <00107082@163.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	David Wang <00107082@163.com>
Subject: [PATCH 07/13] arm64/irq: use seq_put_decimal_ull_width() for decimal values
Date: Sat,  9 Nov 2024 00:17:53 +0800
Message-Id: <20241108161753.9760-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33+izOS5nkKkeEA--.43507S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryfAryftF1rGw4xuryfWFg_yoW3Arb_Kr
	92y3W8WrWFyryIvryDCa4ft34vka4UX3sak3WvgFWqyry3Xw45Aa98AFySgws5XrnxKrZ3
	X3s3tr1qvr1xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREmii7UUUUU==
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0hmRqmcuN-cU9QABsZ

Performance improvement for reading /proc/interrupts on arch arm64

Signed-off-by: David Wang <00107082@163.com>
---
 arch/arm64/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 3b3f6b56e733..35734a30ed8d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -844,7 +844,8 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
+			seq_put_decimal_ull_width(p, " ",
+						  irq_desc_kstat_cpu(ipi_desc[i], cpu), 10);
 		seq_printf(p, "      %s\n", ipi_types[i]);
 	}
 
-- 
2.39.2


