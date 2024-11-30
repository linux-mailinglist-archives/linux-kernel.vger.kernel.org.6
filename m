Return-Path: <linux-kernel+bounces-426234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2439DF09F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F260AB2115D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E03199FAD;
	Sat, 30 Nov 2024 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I9ZRNEu2"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03FC17741;
	Sat, 30 Nov 2024 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732974607; cv=none; b=nDO0UrBnL5YPqaJcOA5AysPTSG2iRQ9UVFbdTShYdlC1AXLomT8ke7zhJd8Mg9mN2S7hSk/erwFDDuR26vr7NMgd4O0pAKTGtC3kxsW8xWkGz3Wt750iN8gTrvquXmq96G/izdnSRpRV6AIC3ke95Tq92MD84ZnVexOxYcVtiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732974607; c=relaxed/simple;
	bh=O9FGPATBs1MNaQiOc7hoyoQn6PO6aoeYkB/uBJbzwL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uUx84pfjKlYf4TDUO6KFSzENw4Cj5fPsYaZjceWEvikTMETpWECDESKocCDfJ+sv01kQjoQ6UcyknVgHhnNspdv1tOX5DLPgT53RlvUPM4l7WwMKoUqBOx4FHBfJLtBZWje9X66g/kFwYQTnRv+c52ibhniHVDDYKk+TnlmC7lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I9ZRNEu2; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=AMqdv
	ClJp9o1qtGJYJ8pX46YUMWEjXmptpNhHIj2bHc=; b=I9ZRNEu2lHfDXlz3hacWd
	7pgkX3mFF1/AdPTFbtagBG1cBh5luYO/W3fflyzxl6bFwTWhZM1CgxHvMyRtWqkE
	Mz9Vu6JTDt6u/djfgIxADcuVN/ERMK2+ww12iJqxvF1mwm2Lz7QFmw8URovqUAxa
	ef4hWOaWTY02hlEs6A2c6U=
Received: from localhost.localdomain (unknown [111.35.188.140])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnrUbWF0tnL+ExKg--.33496S4;
	Sat, 30 Nov 2024 21:49:26 +0800 (CST)
From: David Wang <00107082@163.com>
To: glaubitz@physik.fu-berlin.de
Cc: dalias@libc.org,
	linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH v2] sh/irq: use seq_put_decimal_ull_width() for decimal values
Date: Sat, 30 Nov 2024 21:49:09 +0800
Message-Id: <20241130134909.171183-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <a9fe22747f20cae9fcc9b9d20109e7afbf8e6b93.camel@physik.fu-berlin.de>
References: <a9fe22747f20cae9fcc9b9d20109e7afbf8e6b93.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnrUbWF0tnL+ExKg--.33496S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw45Gw43uFy3ur47Aw4rAFb_yoWkJwbEgF
	97Cw15KrW5J39IyFyjk3Wft34DA34qvr9Y934FgrWIy3sxJw45JasxGF15Jr1kWF1rCFWf
	Z3s5Zrs0qr4SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sREsXoUUUUUU==
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqRmnqmdLFmgcgAAAsz

On a system with n CPUs and m interrupts, there will be n*m decimal
values yielded via seq_printf(.."%10u "..) which has significant costs
parsing format string and is less efficient than
seq_put_decimal_ull_width(). Stress reading /proc/interrupts
indicates ~30% performance improvement with this patch.

Signed-off-by: David Wang <00107082@163.com>
---
 arch/sh/kernel/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/irq.c b/arch/sh/kernel/irq.c
index 4e6835de54cf..9022d8af9d68 100644
--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -43,9 +43,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	int j;
 
-	seq_printf(p, "%*s: ", prec, "NMI");
+	seq_printf(p, "%*s:", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j));
+		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat.__nmi_count, j), 10);
 	seq_printf(p, "  Non-maskable interrupts\n");
 
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
-- 
2.39.2


