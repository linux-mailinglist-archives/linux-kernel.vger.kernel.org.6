Return-Path: <linux-kernel+bounces-258027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF3F938248
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 19:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B12281D41
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 17:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CD91494A8;
	Sat, 20 Jul 2024 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/rP/PyG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2EF149016
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721496417; cv=none; b=mTAQo7NVrPvmgIAdk6S2yHOSFgus68qLOP9CoTPFdgO5OpmVgUMiQOStbKjJjwoY7jyB0dHB1jm9NfVReU8TmA/0/WLZ8u9iwxdl2JS747TslBfKJOgxckdC/z2e9RgogHGsYmiwAiX6q5HbBo23GXmSfFAx5FBnr9AzIkBSPxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721496417; c=relaxed/simple;
	bh=PS9GETIFotMXHbuFrtVxV4bYZ42Bdzp9+Zn0gjyOdnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYnJTqT8WsT3F+1HwjOX4/Wq83LpgxocaTcu9ZRv6dXZAFLsjOm4EZfvTqJ1/l+wYLDMbX2GXpm4NB5zUPvwvBKDpCbCRwyC1ZgVmdey7p19FM1rpVwNenYDT5XVsCv3aMG1115hHbclkXqsgMFR+u5b89piPPzJVoufPthtJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/rP/PyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA31C4AF0F;
	Sat, 20 Jul 2024 17:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721496417;
	bh=PS9GETIFotMXHbuFrtVxV4bYZ42Bdzp9+Zn0gjyOdnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/rP/PyGYs4PM91YBMl0YbrBayzt4Kt/jSe62G6momR9f39KhwggHvETfJRuFWbjb
	 lrmjhNUkFw6spRPMkBRpQpY1mSdm04chjCkZcA4Ug5ONjd1NJn+uQUdHQ5TpVNALeL
	 Ajogh2zDCPgwIxQ0zebSHVrDSUSX7EiFqgsWuNViCda7BwUn+bJOSKOo1ZhEx0Q9Hl
	 bhMTwUjyww2Y3zktoq7+ABmGksGl/86pifrZvxVYHIDQmxIbHj910AlLeCxyTrlvZc
	 F/kFUngUxFt+iAZZsOTOuaybDumo7n1kDhed5stC1a5zPZtbKjSSxkYnGB2cEcCK8t
	 AYdeziyZy0pxA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Clement Leger <cleger@rivosinc.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] riscv: errata: remove ALT_INSN_FAULT and ALT_PAGE_FAULT
Date: Sun, 21 Jul 2024 01:12:29 +0800
Message-ID: <20240720171232.1753-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240720171232.1753-1-jszhang@kernel.org>
References: <20240720171232.1753-1-jszhang@kernel.org>
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


