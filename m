Return-Path: <linux-kernel+bounces-220788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CD990E716
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F171F22F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822C47E78E;
	Wed, 19 Jun 2024 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQuAYBh3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73A57E11E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789419; cv=none; b=uSZfvb8WZTQTVeIyFfh1J4Rg8ga22jgBxU8ku1m1gAN7fI8SlUrvERx7KvW0krjAAPRR2/iTvnZrj5dWX2pg2m0SgYYEFxnOvz8pLGnE1V/FtGn+zsJ6aIimAuYljmxMsY2LXcRqdo2XFQHscEz8nVM2ACMjYjDgdzJ3ZcOA3NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789419; c=relaxed/simple;
	bh=/52i2IEcPby05hVZRiaMOtNwyTw57B3DcrTt2iGDjtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NSQuHCm5LKORILW+tEiKe6eRvFx2Uwga8RPWektqrrmsorEsyrpODQG96A3J1jT8Oi7rGfYcmnm9uVsdMdUlnEgEqNYK4+ftN4f9D6jsTIxLbIeYzKvwQLObHMois5S1BKZwDdYDX99M7Q/YvoxCFcgyskeKzSXkPRJN07vAfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQuAYBh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B4EC2BBFC;
	Wed, 19 Jun 2024 09:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718789419;
	bh=/52i2IEcPby05hVZRiaMOtNwyTw57B3DcrTt2iGDjtI=;
	h=From:To:Cc:Subject:Date:From;
	b=bQuAYBh3hxaaLl5V6OZzaOk2lZmF39uMsWuo909unPVFm/qTzSD7fPnqqBaPZreNc
	 edioBnoYgYSGoxdli6YGjWovvx3oyv0+ZpfUl5SdhTDIE5EkckIG5hcvdCKtBVdeiL
	 mylzvyxKgCzeVuFg3RUfQxQi93NsjL+rT8Xc+f9c2A9/koJHQr+JTVNHG0FCZJ9NYU
	 b6GzDj7QS49uUIDMySWZe+OA0S8PkRypaNqnOiZ13fXnqx95Ag1/gkV5tUVdzM8wPv
	 zxM9oBXumIVhBbBJ2Bwrgcc7BQA0cP+AAxfdEeee6XciTTA2CQg8co3WEi5HYJhswT
	 TLYCG2aahiDyw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ashish Kalra <Ashish.Kalra@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Michael Roth <michael.roth@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH] x86/sev: Move SEV compilation units
Date: Wed, 19 Jun 2024 11:30:14 +0200
Message-ID: <20240619093014.17962-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

A long time ago we said that we're going to move the coco stuff where it
belongs

  https://lore.kernel.org/all/Yg5nh1RknPRwIrb8@zn.tnic

and not keep it in arch/x86/kernel. TDX did that and SEV can't find time
to do so. So lemme do it. If people have trouble converting their
ongoing featuritis patches, ask me for a sed script.

No functional changes.

Cc: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Michael Roth <michael.roth@amd.com>
Cc: Nikunj A Dadhania <nikunj@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/boot/compressed/sev.c                      | 2 +-
 arch/x86/coco/Makefile                              | 1 +
 arch/x86/coco/sev/Makefile                          | 3 +++
 arch/x86/{kernel/sev.c => coco/sev/core.c}          | 2 +-
 arch/x86/{kernel/sev-shared.c => coco/sev/shared.c} | 0
 arch/x86/kernel/Makefile                            | 2 --
 6 files changed, 6 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/coco/sev/Makefile
 rename arch/x86/{kernel/sev.c => coco/sev/core.c} (99%)
 rename arch/x86/{kernel/sev-shared.c => coco/sev/shared.c} (100%)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 697057250faa..cd44e120fe53 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -127,7 +127,7 @@ static bool fault_in_kernel_space(unsigned long address)
 #include "../../lib/insn.c"
 
 /* Include code for early handlers */
-#include "../../kernel/sev-shared.c"
+#include "../../coco/sev/shared.c"
 
 static struct svsm_ca *svsm_get_caa(void)
 {
diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
index c816acf78b6a..eabdc7486538 100644
--- a/arch/x86/coco/Makefile
+++ b/arch/x86/coco/Makefile
@@ -6,3 +6,4 @@ CFLAGS_core.o		+= -fno-stack-protector
 obj-y += core.o
 
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx/
+obj-$(CONFIG_AMD_MEM_ENCRYPT)   += sev/
diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
new file mode 100644
index 000000000000..b89ba3fba343
--- /dev/null
+++ b/arch/x86/coco/sev/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y += core.o
diff --git a/arch/x86/kernel/sev.c b/arch/x86/coco/sev/core.c
similarity index 99%
rename from arch/x86/kernel/sev.c
rename to arch/x86/coco/sev/core.c
index 726d9df505e7..082d61d85dfc 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/coco/sev/core.c
@@ -613,7 +613,7 @@ static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
 }
 
 /* Include code shared with pre-decompression boot stage */
-#include "sev-shared.c"
+#include "shared.c"
 
 static inline struct svsm_ca *svsm_get_caa(void)
 {
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/coco/sev/shared.c
similarity index 100%
rename from arch/x86/kernel/sev-shared.c
rename to arch/x86/coco/sev/shared.c
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 20a0dd51700a..b22ceb9fdf57 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -142,8 +142,6 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
-obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
-
 obj-$(CONFIG_CFI_CLANG)			+= cfi.o
 
 obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o
-- 
2.43.0


