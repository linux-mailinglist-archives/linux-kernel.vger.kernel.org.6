Return-Path: <linux-kernel+bounces-401991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06079C2203
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A75282E8B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042C71885A4;
	Fri,  8 Nov 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oOmFTAhf"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A5218B09
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083131; cv=none; b=iJREUjN9oweTWxinyDlM6o+jnM3ES2SVPSNBlCRAbfzEVnguBfecwx7C7NGzJlug39CyJEbpL4TCQIdi/HrMk+6YJbFvZR8qXKNZXN9MU9B8MhBj1gIvW7BOcv/u+kMuFk2yO7Sd+7pfhIZxI41gHFWzPCB3nVwZWNG4W1QguUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083131; c=relaxed/simple;
	bh=LoBnILTjP+c7I772XhFxSQLCNE328jcEj4sx6hyzSMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HJKLDrMfe6FvG/ckSj5IV1Q7QRlONlomZnXF+mmsOo/DBIt17jgatAQ+UJqs/JnO5d+WVBgz8Nh3/vxvMgavgeUL+9muvzrfpBh5Id0AoDL0WNyIN/w0EYC+wyWWoCd95hLa94MqGRxD+Wmw3uaxscP+iUi7Ilk/26lPpO/ZYb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oOmFTAhf; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=dUGTF
	+Sr/jmIL6b2aWpcEFyrM7xIuftjowU0OHO/q/s=; b=oOmFTAhf576eIsDEKrKm+
	GpG4sA0QHJY2e5qL05U4im1P7F+f4pY/0xzsSu5CnC/qy2Und2byEl6IbPD6l98x
	56Yg7/u3V43LyPu95+qSo0i9gTumDIB4r8aVly3NzKG/lc9L5ARbM1XVS/biWql2
	2kDoX29fRHJHSn8irvCwHI=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wAX7U9hOy5nFlO5BQ--.37910S4;
	Sat, 09 Nov 2024 00:25:11 +0800 (CST)
From: David Wang <00107082@163.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	David Wang <00107082@163.com>
Subject: [PATCH 12/13] riscv/irq: use seq_put_decimal_ull_width() for decimal values
Date: Sat,  9 Nov 2024 00:25:03 +0800
Message-Id: <20241108162503.9914-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX7U9hOy5nFlO5BQ--.37910S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr1DKr15tryUKF1UAr4rAFb_yoW3WFg_Kr
	Z2ya45Way3tFW2vFyDuw1SqryDA34FqF93G3Z29rW2yr1YgrsIyas0yF45J395XrnIqrZ7
	Jryftrs2vr1xKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_ZqXDUUUUU==
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMw+RqmcuOswJMQAAsA

Performance improvement for reading /proc/interrupts on arch riscv

Signed-off-by: David Wang <00107082@163.com>
---
 arch/riscv/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index c180a647a30e..f1e9c3db094c 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -226,7 +226,8 @@ void show_ipi_stats(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10u ", irq_desc_kstat_cpu(ipi_desc[i], cpu));
+			seq_put_decimal_ull_width(p, " ",
+						  irq_desc_kstat_cpu(ipi_desc[i], cpu), 10);
 		seq_printf(p, " %s\n", ipi_names[i]);
 	}
 }
-- 
2.39.2


