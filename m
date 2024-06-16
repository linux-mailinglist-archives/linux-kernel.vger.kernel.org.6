Return-Path: <linux-kernel+bounces-216382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E731909EB2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB161F21579
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B005A4CB36;
	Sun, 16 Jun 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG3p5u4o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0453F49646
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558395; cv=none; b=sYRMcKTt8msJQ/AYlj5hJaxOOmpgkq5v+5fC9IpgloxxZ6mYbsbqGR9kaecAfVGyRxTqqTcjidLC1nAeBuXKB+v+tZQPiNbyXcRRZ0fWInsv7EcoKFDPBDQLkAQqsJQxbLiifHr3CraD69fvCh+A+KjMdZZyFOpIHuqKDD/3q7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558395; c=relaxed/simple;
	bh=PS9GETIFotMXHbuFrtVxV4bYZ42Bdzp9+Zn0gjyOdnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSDu3Z4DotSMAdeh4/MF1heZ7sHrmd/Mla3BufH/pFPL5RFFicp1VamaZoQytUNd45UYcTmblYJYyDbDKf+N6Kmr6QkLbyU9Nc+/YMDk1pW/xD5n6nQxxH3Ashb6iEFCixZHS3LISaY0SiUKZzCbONXA+bBPxP19zePAkNavXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG3p5u4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5568FC4AF51;
	Sun, 16 Jun 2024 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718558394;
	bh=PS9GETIFotMXHbuFrtVxV4bYZ42Bdzp9+Zn0gjyOdnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CG3p5u4oEXwi4LuMzZozu/wQCsY1FuA8N3QqG0uHG4qD7kLca5oO47qirIA2bhT80
	 GyKDJmvRW2JhYloosJEDu4SVcxE96dd58uHRFDfm1Ke8IkI746Ba1HR88CCNDtCk5F
	 yUdOaMDW2vOOGCrMI/aB4rBkLFLbCLdn+iwta83TFi39+xHcQmaP55sq4UvDR6JGsO
	 frXhe+T2YJTUgWo+AXZYGuaZiG8yoDPc4gnLez5zqdsaRqzleAUi2HhhusDxUo/olF
	 xcwCXw6XwkUmy7dgkKg7hiORh8qlOCojzYkBu78EIWaRQxHD6xs26+wTo7PeahMICD
	 /lu8HwEyKiH0Q==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] riscv: errata: remove ALT_INSN_FAULT and ALT_PAGE_FAULT
Date: Mon, 17 Jun 2024 01:05:51 +0800
Message-ID: <20240616170553.2832-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240616170553.2832-1-jszhang@kernel.org>
References: <20240616170553.2832-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

They are used for SIFIVE_CIP_453 errata, which has been solved by
replacing the excp_vect_table[] two entries in last commit. So these
two macros are useless now, remove them.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/include/asm/errata_list.h | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 95b79afc4061..46bf00c4a57a 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -27,21 +27,7 @@
 #define	ERRATA_THEAD_NUMBER 2
 #endif
 
-#ifdef __ASSEMBLY__
-
-#define ALT_INSN_FAULT(x)						\
-ALTERNATIVE(__stringify(RISCV_PTR do_trap_insn_fault),			\
-	    __stringify(RISCV_PTR sifive_cip_453_insn_fault_trp),	\
-	    SIFIVE_VENDOR_ID, ERRATA_SIFIVE_CIP_453,			\
-	    CONFIG_ERRATA_SIFIVE_CIP_453)
-
-#define ALT_PAGE_FAULT(x)						\
-ALTERNATIVE(__stringify(RISCV_PTR do_page_fault),			\
-	    __stringify(RISCV_PTR sifive_cip_453_page_fault_trp),	\
-	    SIFIVE_VENDOR_ID, ERRATA_SIFIVE_CIP_453,			\
-	    CONFIG_ERRATA_SIFIVE_CIP_453)
-#else /* !__ASSEMBLY__ */
-
+#ifndef __ASSEMBLY__
 #define ALT_SFENCE_VMA_ASID(asid)					\
 asm(ALTERNATIVE("sfence.vma x0, %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
 		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
-- 
2.43.0


