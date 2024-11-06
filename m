Return-Path: <linux-kernel+bounces-397489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 390009BDC9F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB11428244D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E2118F2DF;
	Wed,  6 Nov 2024 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b4AZu6kD"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDD7202F8A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859206; cv=none; b=oeVQsppiDokPhS/y1jLgFSkgNpQpudwVE0Bbj1P1F7F0tl6GUVF1nwqRKJ7uwIFsYYUuAZ99rqJmPdp/KnqQkgH5OYkuk9QVTlJnJUHHKH3Z0zZnXQHSvN1ksvzDfLwHuRJr0pkZ9PPHkA2JBjhxBxFWwp+il9qYvhTF/J0n2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859206; c=relaxed/simple;
	bh=fYMU1omQrP2zqb9XQZxtQd9ll5LV/OeZx8sizRWVi7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P9fpklBLe1TeF9FBYSRldjOY49E29kJH58gem3+hnTCXth4OQ4NBwJInSOKslt3Vq+qio/KKhgg31JxJmSfvJoHvKITIdOex5ee8bO3p4+bgLiTGNtuhq4GV+xpjXfDwRtnOpMkrg5IRK9g7HX7Vqx58TysBZjs/8tITBH/2q6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b4AZu6kD; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=e4jxL
	uR0QSoio6BcOtp0IFOfkcsMYik35o+d+H0C3cQ=; b=b4AZu6kDbjKAjjPWIReCf
	H+ToAJ+G3DpGcsX2v0ZjukOELPkYdqz0etr+A+aDyi+ImqPoCXl94D0fo35Gd4C3
	ZTrMYbOEGMsP/BZ4zWC9m7ifEVXYrx+8cOPF6JCB/jAuJcVnyPKWfcykvqUorg1V
	6S9Q547Rm+HK66aDGf3d5Y=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAHtgaO0CpnmysXCg--.34730S4;
	Wed, 06 Nov 2024 10:12:44 +0800 (CST)
From: David Wang <00107082@163.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	torvalds@linux-foundation.org,
	David Wang <00107082@163.com>
Subject: [PATCH] proc/softirqs: replace seq_printf with seq_put_decimal_ull_width
Date: Wed,  6 Nov 2024 10:12:28 +0800
Message-Id: <20241106021228.4345-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAHtgaO0CpnmysXCg--.34730S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF45trWDKw1kXr43XF1xuFg_yoWDWwbE9F
	97J3Wjgry7tr9xJryjyw4ft34UA395Zrn3ta48KF1UXryUZ3Z8JFWDGw1kurn7Wr48KFW7
	u3ykXr1Yq3WfWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUSfOUUUUUU==
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxGPqmcqzt0zgwAAsp

seq_printf is costy, on a system with n CPUs, reading /proc/softirqs
would yield 10*n decimal values, and the extra cost parsing format string
grows linearly with number of cpus. Replace seq_printf with
seq_put_decimal_ull_width have significant performance improvement.
On an 8CPUs system, reading /proc/softirqs show ~40% performance
gain with this patch.

Signed-off-by: David Wang <00107082@163.com>
---
 fs/proc/softirqs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/softirqs.c b/fs/proc/softirqs.c
index f4616083faef..04bb29721419 100644
--- a/fs/proc/softirqs.c
+++ b/fs/proc/softirqs.c
@@ -20,7 +20,7 @@ static int show_softirqs(struct seq_file *p, void *v)
 	for (i = 0; i < NR_SOFTIRQS; i++) {
 		seq_printf(p, "%12s:", softirq_to_name[i]);
 		for_each_possible_cpu(j)
-			seq_printf(p, " %10u", kstat_softirqs_cpu(i, j));
+			seq_put_decimal_ull_width(p, " ", kstat_softirqs_cpu(i, j), 10);
 		seq_putc(p, '\n');
 	}
 	return 0;
-- 
2.39.2


