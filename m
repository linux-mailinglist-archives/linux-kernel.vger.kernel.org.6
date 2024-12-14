Return-Path: <linux-kernel+bounces-446058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E83959F1F59
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBB61667B3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 14:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467DC194C8B;
	Sat, 14 Dec 2024 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHahqYS2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67D8946C
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734186668; cv=none; b=qmM4XsAhNe8nAFxcqFhjPOWLhsqK+WVb6M/m+7DXDRH92xEC9MYnU2KWpiAk/swwb3yiNTQMSgJH/tg6QkNeYDR9CngMu3Nbdn19ydZV5Ac5qlhsz4N1AjYDV46uuBH+LEG/D2h2e2PyM5vt1bteqSlsFzwAIxzg9MfluTIyI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734186668; c=relaxed/simple;
	bh=ot1bZWRhxXQjgYisV+ilgyR2+rvp4CLLEjM5WVVXLK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ez9e19FXExJ97blAlM66MOoUiQHPaFux5nmg0SuN1MwdB0c32a2MsWHRyhuVyHzb8zliG4ZtYhfbjLkFCw5xwLuBcbJlDVmjCTDnw6cYGvWZhKPqltZTWd+jJucKxVwlmjejb/oQz8IFWA2CS4D+QkPsPDc3cy7X53EvTnYhPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHahqYS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB33DC4CED1;
	Sat, 14 Dec 2024 14:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734186668;
	bh=ot1bZWRhxXQjgYisV+ilgyR2+rvp4CLLEjM5WVVXLK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHahqYS2Oeqr+QjAlTYuerJqvalUkbbATf9gwvX5b7/YF+7pBA7Ipgfrfq9ekDM7Y
	 fxs9siyprKtBnQUuM2ZFKTcG5mv6ovcFZvcnaARFlER4gnhfNhiPdUPz6jr0RRdzQq
	 ILWRxi/k8t+oNiJ5amk1Ge+Rgn+RxOek7xzOviyGTunPpBbl7/vdSECjK2/t4yKTEi
	 ChFVklDmVN/+atosTjTQSiV2HhdR8wx5YK1qdsFy/DfgLLQ9vqMVTnG5jHSZLVydlz
	 7Ao7ECMiyoFjel5liIv18Qb0OxiFMla1+ep9sYnWF/1/uSp2QoMrp+3xwXFFKsIjIU
	 3DkspyI3IhbTQ==
From: guoren@kernel.org
To: guoren@kernel.org,
	conor@kernel.org,
	alexghiti@rivosinc.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	bjorn@rivosinc.com,
	leobras@redhat.com,
	corbet@lwn.net,
	peterlin@andestech.com,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 1/2] riscv: Move vendor errata definitions into vendorid_list.h
Date: Sat, 14 Dec 2024 09:30:38 -0500
Message-Id: <20241214143039.4139398-2-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241214143039.4139398-1-guoren@kernel.org>
References: <20241214143039.4139398-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

Move vendor errata definitions into vendorid_list and make it re-useable
for other header files.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/errata_list.h   | 17 -----------------
 arch/riscv/include/asm/vendorid_list.h | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 7c8a71a526a3..589a3ebe2ae2 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -11,23 +11,6 @@
 #include <asm/hwcap.h>
 #include <asm/vendorid_list.h>
 
-#ifdef CONFIG_ERRATA_ANDES
-#define ERRATA_ANDES_NO_IOCP 0
-#define ERRATA_ANDES_NUMBER 1
-#endif
-
-#ifdef CONFIG_ERRATA_SIFIVE
-#define	ERRATA_SIFIVE_CIP_453 0
-#define	ERRATA_SIFIVE_CIP_1200 1
-#define	ERRATA_SIFIVE_NUMBER 2
-#endif
-
-#ifdef CONFIG_ERRATA_THEAD
-#define	ERRATA_THEAD_MAE 0
-#define	ERRATA_THEAD_PMU 1
-#define	ERRATA_THEAD_NUMBER 2
-#endif
-
 #ifdef __ASSEMBLY__
 
 #define ALT_INSN_FAULT(x)						\
diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index 2f2bb0c84f9a..7a387368633a 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -9,4 +9,21 @@
 #define SIFIVE_VENDOR_ID	0x489
 #define THEAD_VENDOR_ID		0x5b7
 
+#ifdef CONFIG_ERRATA_ANDES
+#define ERRATA_ANDES_NO_IOCP 0
+#define ERRATA_ANDES_NUMBER 1
+#endif
+
+#ifdef CONFIG_ERRATA_SIFIVE
+#define	ERRATA_SIFIVE_CIP_453 0
+#define	ERRATA_SIFIVE_CIP_1200 1
+#define	ERRATA_SIFIVE_NUMBER 2
+#endif
+
+#ifdef CONFIG_ERRATA_THEAD
+#define	ERRATA_THEAD_MAE 0
+#define	ERRATA_THEAD_PMU 1
+#define	ERRATA_THEAD_NUMBER 2
+#endif
+
 #endif
-- 
2.40.1


