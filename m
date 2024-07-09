Return-Path: <linux-kernel+bounces-246251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAE692BF91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 18:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB921C236DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F0C19DF7A;
	Tue,  9 Jul 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaYbZR0m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03AD19CD11
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541987; cv=none; b=I5gQ3HG1v7KLI06LxrDi4PVe1tlL74xZgZuXqfVdhzmpLQjVhUdwavVUcuNm+mKqZQ9hOhPF0jR3jd6mRSIFKuq5QfOv80i26v628l80MXVEE3C77/4kknCSDezIFi3jTFx8ejfzt9eWyC/k6BFggw2752zERwfyPLq7BtM+51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541987; c=relaxed/simple;
	bh=EH0mnbrlmuEp86OTO77hyOOmJF9pAhGe7cuKGLBxhr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqqGCvpR9cFbJGHMrnclAxwGIzmopfN1I/aWcZNFEVZGabnqvUoMizl3e43HjRU/IBadPEfWeNOru1JqM4S53mEP+5a1/DZDJW8RcuNFLgD4RtHX0sk2UTnOnqfOe9RA6bkOOpA3R6LdNaC3THoR0lldgW3Igu/AaOyPKPBOXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaYbZR0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4037CC3277B;
	Tue,  9 Jul 2024 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541987;
	bh=EH0mnbrlmuEp86OTO77hyOOmJF9pAhGe7cuKGLBxhr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LaYbZR0m9Y+rRj4eH1Xq1t1wqhNEEiw+RfzveoiPWWpDBIwX6jQVlvhOqim6q7Zyo
	 LOXNpvJcKeeKb68j5o6vMWWwujuqWRKv7kvCY0u8b3cEVeEuX3hnFZIzJzkcGHu5L6
	 KPRd7g+sqe2abfXeMvkgsmzVKBfQzGEfkuuf+9A+Byft5erNMNPNEIPOU18c66LdP3
	 OeGtwFnEANVOJkAVJwIwlST40yCU7F7ZMXmOLMnaQFXdD7I64Zkgbw6AlGaU+PAL7I
	 hG+5Ho3YGIyZ7ddRA+lH4sroSe6erW14+yK2EiqdQ8/XHS/tFgB4mvTybe4SNL8tEW
	 IWgD6M4NKgRfw==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] riscv: errata: sifive: Use SYM_*() assembly macros
Date: Wed, 10 Jul 2024 00:05:21 +0800
Message-ID: <20240709160536.3690-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709160536.3690-1-jszhang@kernel.org>
References: <20240709160536.3690-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ENTRY()/END() macros are deprecated and we should make use of the
new SYM_*() macros [1] for better annotation of symbols. Replace the
deprecated ones with the new ones.

[1] https://docs.kernel.org/core-api/asm-annotations.html

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/errata/sifive/errata_cip_453.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/errata/sifive/errata_cip_453.S b/arch/riscv/errata/sifive/errata_cip_453.S
index f1b9623fe1de..b1f7b636fe9a 100644
--- a/arch/riscv/errata/sifive/errata_cip_453.S
+++ b/arch/riscv/errata/sifive/errata_cip_453.S
@@ -21,7 +21,7 @@
 1:
 .endm
 
-ENTRY(sifive_cip_453_page_fault_trp)
+SYM_FUNC_START(sifive_cip_453_page_fault_trp)
 	ADD_SIGN_EXT a0, t0, t1
 #ifdef CONFIG_MMU
 	la t0, do_page_fault
@@ -29,10 +29,10 @@ ENTRY(sifive_cip_453_page_fault_trp)
 	la t0, do_trap_unknown
 #endif
 	jr t0
-END(sifive_cip_453_page_fault_trp)
+SYM_FUNC_END(sifive_cip_453_page_fault_trp)
 
-ENTRY(sifive_cip_453_insn_fault_trp)
+SYM_FUNC_START(sifive_cip_453_insn_fault_trp)
 	ADD_SIGN_EXT a0, t0, t1
 	la t0, do_trap_insn_fault
 	jr t0
-END(sifive_cip_453_insn_fault_trp)
+SYM_FUNC_END(sifive_cip_453_insn_fault_trp)
-- 
2.43.0


