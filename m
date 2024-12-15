Return-Path: <linux-kernel+bounces-446433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E24C9F2443
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892D2164D50
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2F218EFDE;
	Sun, 15 Dec 2024 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBo4aQJ0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5791865FA
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734270790; cv=none; b=qoJ3FW+WG8jUsv7EdkoQE/q8czHLK2NvhuEe9iR+j/kdcD05hl+tvp4TmRFAXJYQcqu8MGpk/oA9+M/YKZzeNhVeI+QMniHTiTvgB1TxRbXc2QFKjWBgG9eH0Q8EQz9e4wfOsFNTpns689Kz+rj463JLR5vDagpFMsjWIZ1FCjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734270790; c=relaxed/simple;
	bh=sHhlhj7Xxd2KddBccYbZSVpXC3HqJ/HVF/eJ/ECqUoc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m1DCf3H5IiU/h8YekFS9FRu6zwI7XUGcGuwHjXJck+MuSiErE+8vOGomJOj7DqR/x6JEBLUUQquLu17voS6lLL6C9xVVkv6cyKF/JW7LfIYS022K1atw90tsQWxRj2Dc3bAcljFFJw5VCFrFVQvcAH23rPTqnHg+jm9jLE+CICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBo4aQJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EFCC4CECE;
	Sun, 15 Dec 2024 13:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734270790;
	bh=sHhlhj7Xxd2KddBccYbZSVpXC3HqJ/HVF/eJ/ECqUoc=;
	h=From:To:Cc:Subject:Date:From;
	b=oBo4aQJ0DcmTIqmZ39NZ7vRHWJTSngQWNnSxmhiHuBMGLwBii+7OF5Etcv/nyvzTj
	 SsSXvNfmXLaiHD/jkyqCTCcM5xUu0lDgkUWuJB9/DigGTd7SOznuNe6Sd8HWhJAO7O
	 /lHV5dmRHkxXF4VpaxPv8e25IutI0klREht694SzcOAtfZsY5zPG4/TNujMZgvn8d8
	 +bkw6HE1puzZJqtuZCd9myGLnHahKUVmsVPT5yngh2Oxz1MTgUxyg+SHXPyhM49+MC
	 5BlmPgSaCqiKHofwnDELfdaIAMYvKEjmetudbEIAOPk4CS+mUqZYcPzfeGEuqScJuv
	 DMybtQTRHPB4A==
From: guoren@kernel.org
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	guoren@kernel.org,
	bjorn@rivosinc.com,
	conor@kernel.org,
	leobras@redhat.com,
	peterz@infradead.org,
	parri.andrea@gmail.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	arnd@arndb.de,
	alexghiti@rivosinc.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: qspinlock: Fixup _Q_PENDING_LOOPS definition
Date: Sun, 15 Dec 2024 08:52:52 -0500
Message-Id: <20241215135252.201983-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

When CONFIG_RISCV_QUEUED_SPINLOCKS=y, the _Q_PENDING_LOOPS
definition is missing. Add the _Q_PENDING_LOOPS definition for
pure qspinlock usage.

Fixes: ab83647fadae ("riscv: Add qspinlock support")
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/spinlock.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
index e5121b89acea..52f11bfd0079 100644
--- a/arch/riscv/include/asm/spinlock.h
+++ b/arch/riscv/include/asm/spinlock.h
@@ -3,8 +3,11 @@
 #ifndef __ASM_RISCV_SPINLOCK_H
 #define __ASM_RISCV_SPINLOCK_H
 
-#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
+#ifdef CONFIG_QUEUED_SPINLOCKS
 #define _Q_PENDING_LOOPS	(1 << 9)
+#endif
+
+#ifdef CONFIG_RISCV_COMBO_SPINLOCKS
 
 #define __no_arch_spinlock_redefine
 #include <asm/ticket_spinlock.h>
-- 
2.40.1


