Return-Path: <linux-kernel+bounces-401981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 825EB9C21D3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A8C1F21EC4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F4C1865EB;
	Fri,  8 Nov 2024 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZFcdBJRa"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD8F1BD9DB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082791; cv=none; b=qblAjEY6u5SeiJouWuDtXRNvoHpXeVQh/gTK8/0TyXQxdrdSUTsKf5LJLrAKfkO37gDjVjnJnEwwxaJan0/nbvBn1cWX8WBFu9zVEw58MfgDYAE0W7lvrXCCXgE5s5MnG4WV+SlVerIWN0OiMV7lteZZouVK2teP03eP+sIBfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082791; c=relaxed/simple;
	bh=eenhW6sB6OskJ3EpSaWWoWI0Jt5GmQ6vr0c50Ltc6CQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mG0wmliBBCSqFbK9PM/WoUxRN5ZGX0R+NOWeZec26/LuDd5MIUOUzZe8eC9+dkKw1Pnuh0DpKIB8zC/v8dBTs+iroEvnaWFe3FmjNp5bNuO0V5XwFV79xpE+wGdMdJLUqYI9DevrP/54JL3xSB11xxc/HXWYz1OcMlcyirmbCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZFcdBJRa; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=awQHE
	yN9VWEyZcLD/YeSo9rA1BYLpYFl4wq9ldjZ/PA=; b=ZFcdBJRaQQpwQ+DCiE1Mg
	LZgqDRFi9Rqk63jwH+c6DYCvsaAf/gjCgPWrdv677/kIsBCks16pGONnPZrKMNdK
	C9XcC2yVdt83VxOM0Y5Q7udKTST3lQERf7XKAbgMoqGLpVTBZ46IefEKFTIVH0/U
	FSmmH3eZPL9gTDkUO5wbok=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDn94kDOi5nS59zFw--.55997S4;
	Sat, 09 Nov 2024 00:19:22 +0800 (CST)
From: David Wang <00107082@163.com>
To: guoren@kernel.org
Cc: linux-kernel@vger.kernel.org,
	tglx@linutronix.de,
	David Wang <00107082@163.com>
Subject: [PATCH 08/13] csky/irq: use seq_put_decimal_ull_width() for decimal values
Date: Sat,  9 Nov 2024 00:19:14 +0800
Message-Id: <20241108161914.9790-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn94kDOi5nS59zFw--.55997S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gry5Cw45XFW5JFWkJF4fKrg_yoW3ArbEyr
	Zavw1kGr45JrnFvr1UAw1ag34vv3yqvasaya4vgrWjyr15Wr45Ja90yay5Aws3ZanayrZ3
	WFZ5ur4vqw17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUU6pB7UUUUU==
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMw+RqmcuKsH05gAAs3

Performance improvement for reading /proc/interrupts on arch csky

Signed-off-by: David Wang <00107082@163.com>
---
 arch/csky/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index 92dbbf3e0205..65f399afc3f0 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -112,8 +112,8 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-			seq_printf(p, "%10lu ",
-				per_cpu_ptr(&ipi_data, cpu)->stats[i]);
+			seq_put_decimal_ull_width(p, " ",
+						  per_cpu_ptr(&ipi_data, cpu)->stats[i], 10);
 		seq_printf(p, " %s\n", ipi_names[i]);
 	}
 
-- 
2.39.2


