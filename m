Return-Path: <linux-kernel+bounces-216383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED6C909EB3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 19:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5512817AB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 17:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7795336F;
	Sun, 16 Jun 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e99AMxUM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C84D9E9
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 17:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718558396; cv=none; b=ny8tabAvFmw3ZyL7IOqQa+M1IX7WCU3wBh8ZrOlsuoBkdr6c3wZO2X10Am/29VrCJ9fJP2rA2S0m6qjjeUiPdfVNweDI1F8F/qI7Ql7ZQVhsDqmIzt6kQ2ADsFegIr9m3TvgGWXiDHVKPsZraXyiHQe6d/eA1vJ9+u0OmnMpVY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718558396; c=relaxed/simple;
	bh=JTbryNQs3nlw2UfEZXAy4glezWuH4wHardbP1B5eZro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXT1KSer2UbzXPAGLRIXyMskyEBQvdErVGYb8YxY8O9NUcSkGDOinccuC3jky2X7Dj0tFH2kiv+jcJxqmkqVSGu6I0uVTv2ga9s3CWXLD1r1rndb1ngcf+cDcgwKmnd6pWmbhRZtRkfy28YlzyA66CPGJlwv6VJTmemNglFEZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e99AMxUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5881C2BBFC;
	Sun, 16 Jun 2024 17:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718558396;
	bh=JTbryNQs3nlw2UfEZXAy4glezWuH4wHardbP1B5eZro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e99AMxUM9kqsk1t0nkcvTWNSEsgH6QZvI3eAUpWIeocexioI8utlOu/CtuwLtruR7
	 tBp4cKdcU1Qg342P8QdqXloB6M9c72CcfxnTnmSs9YlpVgrAyGrDzof6koi/JShE/w
	 qLDsLQcAiRUiALnFGnHMvbmClqfRsfFIEYWKhiKx25TtBMrUJEhnJkna7+RwS0IUKz
	 ZgC6NMvelvB4vc0zRy5fPm1HNpjuVMRSkZea8CSrm51cyxFejc24SuBBx9fI+7XqfW
	 PM+KdOqalP85orqXsTvsdGQXylQca65rqllQUOFAY8YPC28ucr3gLIAE1LhlAvEIsD
	 or0dwW7jW6BFQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] riscv: errata: sifive: remove NOMMU handling
Date: Mon, 17 Jun 2024 01:05:52 +0800
Message-ID: <20240616170553.2832-6-jszhang@kernel.org>
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

Since NOMMU is now properly handling in generic do_traps() which will
call do_trap_unknown() for instruciton page fault for NOMMU.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/errata/sifive/errata_cip_453.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/riscv/errata/sifive/errata_cip_453.S b/arch/riscv/errata/sifive/errata_cip_453.S
index f1b9623fe1de..b8ca2ebc2652 100644
--- a/arch/riscv/errata/sifive/errata_cip_453.S
+++ b/arch/riscv/errata/sifive/errata_cip_453.S
@@ -23,11 +23,7 @@
 
 ENTRY(sifive_cip_453_page_fault_trp)
 	ADD_SIGN_EXT a0, t0, t1
-#ifdef CONFIG_MMU
 	la t0, do_page_fault
-#else
-	la t0, do_trap_unknown
-#endif
 	jr t0
 END(sifive_cip_453_page_fault_trp)
 
-- 
2.43.0


