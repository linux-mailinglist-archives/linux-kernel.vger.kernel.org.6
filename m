Return-Path: <linux-kernel+bounces-169254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121118BC5BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 04:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E2D281D6F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 02:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC5C405CC;
	Mon,  6 May 2024 02:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OCzXqYV0"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3523F9EC
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 02:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714962215; cv=none; b=O2M7bKwsAtMAvrXzJwSHecDGme+U+F9ABTCGmTQq7VKf6oONAeOmipdd11uZzYMEG4Qxio67iW9Yf9N3MbHbHLSUTvv9ePDWTG+tnhMZgvJwDpC/Qj30uuPvKACjvMpX8ccc4FcZqHy185e42HAKXZvKkBfGeBamBMBFMStfue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714962215; c=relaxed/simple;
	bh=kJ1EjMpssDBDjTJkBklj+X7w3qeQ1Fz7LV7FBdijZDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rk4vfzw7GTbovsUDmbld9+WITcjtc5hak76s/1oFFpvzJvMh/akUxXv3VE6GxVNQjr+A5wLoBj4kmfYAI7Af9r7IGAAfgIWZilEWRTuaVySPzTbD6s1LKQchj5J159GX5mIJ555R+MJ5lG+cTUzkCkpgd0z4BafcpaY4qiMHiDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OCzXqYV0; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LQ3sc
	wYLoPMei8ryb8phE+FJFjgEcy7bl0P/q0SziYw=; b=OCzXqYV0c5cwhTSnRg4eQ
	/PKEM4OKdSLpoUz8+Wl/WBNx5WhqN9Fa20CIXPVv2L7AU2cu1fRyAaTcOSc9Pn3m
	9GjCw9xthoDG/O3L/Eion9Duw6YNyRngdgAYp/xAAcGSa4YZGcBt46bt3FLdbXQo
	tt/FWM+kG925ZIm/f7nsj0=
Received: from yangzhang2020.localdomain (unknown [60.27.227.220])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDnl6fyPjhmWCzYDQ--.44974S2;
	Mon, 06 May 2024 10:22:42 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: alexghiti@rivosinc.com
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: [PATCH V2] riscv: set trap vector earlier
Date: Mon,  6 May 2024 10:22:39 +0800
Message-Id: <20240506022239.6817-1-gaoshanliukou@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnl6fyPjhmWCzYDQ--.44974S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gry8XrW8ur48JF4UGr47CFg_yoWDJrc_GF
	Z7JrWUWry8Ca1SqF9Fq3yfWw1jvw1Y9FWF934SvrWUuw4vgFWjq3WYg345trZ5GFyIgw4k
	J3saqFZrtr12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnXAw7UUUUU==
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/1tbiJxnW8mXAlp9hTwAAsY

From: "yang.zhang" <yang.zhang@hexintek.com>

If trap earlier, trap vector doesn't yet set properly, current
value maybe set by previous firmwire, typically it's the _start of kernel,
it's confused and difficult to debuge, so set it earlier.
---
v1 -> v2:
As Alex commented, remove the patch for supporting hugesize kernek image
Add the omissive logic of set trap vector earlier

Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
---
 arch/riscv/kernel/head.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 4236a69c35cb..03dc440e643e 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -300,6 +300,9 @@ SYM_CODE_START(_start_kernel)
 #else
 	mv a0, a1
 #endif /* CONFIG_BUILTIN_DTB */
+	/* Set trap vector to spin forever to help debug */
+	la a3, .Lsecondary_park
+	csrw CSR_TVEC, a3
 	call setup_vm
 #ifdef CONFIG_MMU
 	la a0, early_pg_dir
-- 
2.25.1


