Return-Path: <linux-kernel+bounces-401970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CC79C21B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736041C23E3F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE45176ADE;
	Fri,  8 Nov 2024 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j592EXb7"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B9BA41
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082395; cv=none; b=ecRAl3sJyhvqnYOIJ/DbvsM7PujpRjsAzQij078CgLsWptAF/3X/Q7/AwHw8eVy/nxdkHQGNhG2MwH5t1J2ajYb1dXA0Q1WZqWnKrM7IrDNP0j4UoB9g1cziaEB4ODUzKy2WY4YY5qBhokcuQRJ+OAGd42RFed+S/2G5EfXrST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082395; c=relaxed/simple;
	bh=yd/mFAcLulfVZFMa4Mi11xdP//PVSO6Kyxl+evLrC4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iqVLcc3NRjyuMs/ki9cplTvsBhiYX6KWanH/C8sHhUGCIfWgW4fgyW2Q1mQiNV+pQr7E/iY8R/tLGZYkMOEyTgi2/Y/IfMWIt04kMHlwzIa3sOdJempW6rKH6F5SDVjRZaH9oFUbzFjfp/7g+TWIKMz5sX+QoaSor4CUWyje81g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j592EXb7; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=20C9p
	NvflvZEvF9aIERSmQUwapvzKf2M7ZwWhLnK2L8=; b=j592EXb7llhnwDZXQBiKy
	hHPUmD9138YM6szgFSpM85JwzD8dKZmy9tlYs5iNtDALvAi5rOtRCLoYDtqjbgAW
	T52vPxvb5W4SBKCK+v2qbopuuNFrQzS7REyh3gwC70n0YQTFtZjvUurD/RK/CLeX
	zFIUbetJCzkXuWFkFdTHBg=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD33zeJOC5nVQN_GA--.37779S4;
	Sat, 09 Nov 2024 00:13:04 +0800 (CST)
From: David Wang <00107082@163.com>
To: chris@zankel.net,
	jcmvbkbc@gmail.com
Cc: linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH 04/13] xtensa/irq: use seq_put_decimal_ull_width() for decimal values
Date: Sat,  9 Nov 2024 00:12:55 +0800
Message-Id: <20241108161255.9671-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33zeJOC5nVQN_GA--.37779S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr4xuw47CF17uFy3GFWfXwb_yoW8GF4Upr
	4Skas8Wr4fWw1vq3W7taykurW5tF98tryag3Z0g3yfG3WUJ3s7XFnIva1xX34vg392gF1S
	9F13Wr10qwn0kw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUe6wXUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0gWRqmcuN-cJFQAAs5

Performance improvement for reading /proc/interrupts on arch xtensa

Signed-off-by: David Wang <00107082@163.com>
---
 arch/xtensa/kernel/irq.c | 2 +-
 arch/xtensa/kernel/smp.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/kernel/irq.c b/arch/xtensa/kernel/irq.c
index b1e410f6b5ab..c4f46989f9b7 100644
--- a/arch/xtensa/kernel/irq.c
+++ b/arch/xtensa/kernel/irq.c
@@ -58,7 +58,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 #if XTENSA_FAKE_NMI
 	seq_printf(p, "%*s:", prec, "NMI");
 	for_each_online_cpu(cpu)
-		seq_printf(p, " %10lu", per_cpu(nmi_count, cpu));
+		seq_put_decimal_ull_width(p, " ", per_cpu(nmi_count, cpu), 10);
 	seq_puts(p, "   Non-maskable interrupts\n");
 #endif
 	return 0;
diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
index 94a23f100726..71ec9eced8b9 100644
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -453,8 +453,8 @@ void show_ipi_list(struct seq_file *p, int prec)
 	for (i = 0; i < IPI_MAX; ++i) {
 		seq_printf(p, "%*s:", prec, ipi_text[i].short_text);
 		for_each_online_cpu(cpu)
-			seq_printf(p, " %10lu",
-					per_cpu(ipi_data, cpu).ipi_count[i]);
+			seq_put_decimal_ull_width(p, " ",
+						  per_cpu(ipi_data, cpu).ipi_count[i], 10);
 		seq_printf(p, "   %s\n", ipi_text[i].long_text);
 	}
 }
-- 
2.39.2


