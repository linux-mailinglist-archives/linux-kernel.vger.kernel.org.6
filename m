Return-Path: <linux-kernel+bounces-401977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8559C21C8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217041F21150
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE2E13B29F;
	Fri,  8 Nov 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QWPKChN1"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFB0198832;
	Fri,  8 Nov 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082513; cv=none; b=ErnAzfrgfGBWWqUE5wt8sTfVLImaI8SWq5YmAd6cOltDCl2jpJk1eVixK2/lMJLnkIgtEGRyzsFVN1sQReEMRvxwgFkLPTgoXI5tc5aciXzJMX89YvMcUoXLji/wMzXecpzG30wbl4K8nTejdp1GRi+u42buaK86lXRVlg/iDo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082513; c=relaxed/simple;
	bh=bFhnOvy3oXvekdAzi7JwR/DSXn6oZNXcae4+2IYc9aA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=amt7SESmmXeh+flMh01uominHtNFBqziG4Hk05Vqpw4VGIO1iPUjtVQMAX0k5IvJRFb6epXChweLbfmFJ6OPPCvHjwXDPA5ChzZfNTrqwpvieHDEUTerHpNnOBMC07YgVHTvqx3H6TNEZF1hTW7Nm+qUsKrtyvktxE3EBXsVEKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QWPKChN1; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6suNy
	6fpLRH3gMhdwsiqTGDSFnS7ZCDGgGa9XwyECm0=; b=QWPKChN1/lQDMMxXA/H/f
	6Wrh7fp3eVeF0w0/naQDMymOtKyMrWhdUEprOMDltiNSuBuSixvR656XYrTJosrq
	s6Ew2SLhCueLrfohheCYaTF+puyJn/oEJ2pKFmknmWl1kT79cH61FpzAd1llzkDl
	tBl6KuwToL4rCL3ggSnAkk=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3_z77OC5n51Z_GA--.50163S4;
	Sat, 09 Nov 2024 00:14:58 +0800 (CST)
From: David Wang <00107082@163.com>
To: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	David Wang <00107082@163.com>
Subject: [PATCH 05/13] alpha/irq: use seq_put_decimal_ull_width() for decimal values
Date: Sat,  9 Nov 2024 00:14:49 +0800
Message-Id: <20241108161449.9698-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_z77OC5n51Z_GA--.50163S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gry5Cw4UJw48ZF15ur1xKrg_yoWDurbE9r
	WI9w1UKFWUJr1Fqr1jy3WfJryqya9Iqr90y34IgFWjvw1kWw15tFs8JF45XF4kWa15KFZ3
	u34rArn0vw4rKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUU6wZ5UUUUU==
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMwORqmcuKsHkPgAAsz

Performance improvement for reading /proc/interrupts on arch alpha

Signed-off-by: David Wang <00107082@163.com>
---
 arch/alpha/kernel/irq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index c67047c5d830..0dbb8d3ed647 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -72,14 +72,14 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	int j;
 
 #ifdef CONFIG_SMP
-	seq_puts(p, "IPI: ");
+	seq_puts(p, "IPI:");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10lu ", cpu_data[j].ipi_count);
+		seq_put_decimal_ull_width(p, " ", cpu_data[j].ipi_count, 10);
 	seq_putc(p, '\n');
 #endif
-	seq_puts(p, "PMI: ");
+	seq_puts(p, "PMI:");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10lu ", per_cpu(irq_pmi_count, j));
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_pmi_count, j), 10);
 	seq_puts(p, "          Performance Monitoring\n");
 	seq_printf(p, "ERR: %10lu\n", irq_err_count);
 	return 0;
-- 
2.39.2


