Return-Path: <linux-kernel+bounces-544312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79717A4E001
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCEA1897666
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69C320551E;
	Tue,  4 Mar 2025 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kd8Yw7Lw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF12204C3F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096720; cv=none; b=B+Xg5jJXkqLKNq2cgKBNwqglkelDQsd2jFhtbCmeua0dHa+sS1bKfQJsUl6zQutImuhMnQqxcx6G9A42FlxoEpjLkXEgCjEbSeRub4885KwIrEIyHCJ8vM5RJqvYyRqes5xdwJa4ztm1ynEJjkgl+r1F9qrQWxXvjkOQlnil+X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096720; c=relaxed/simple;
	bh=txoN3V9rWwXFEyWDRXIoMCIFbMoUCiBnnRfSGjS9m3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNHpd4kZVQnoIx5PsB7AsbwEKZ6x5k1+7CYYMOmv4FVuw9ZVIGSWMzUkd7+x8wQRL6HbeXNwe/8m6qrFq5yaVI6Se7lAWEdJGVfs8yt/u9APF6SVjledYa7LfFNWhvfEPNqNNnCHV4s8lSa7U4DgEn2w0n8q9HcOSrA+uTkKS5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kd8Yw7Lw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174FDC4CEE5;
	Tue,  4 Mar 2025 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741096720;
	bh=txoN3V9rWwXFEyWDRXIoMCIFbMoUCiBnnRfSGjS9m3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kd8Yw7Lwr4sjOpYWFXwXQSEC5xzprBOCIBE7bXwYr8GTXC+xFDjpLzy06CmfMPBne
	 u6ZdRClLHEfy/M+wAKbra6zqvNXfIiC4v94rdgan9Rd1Z/UVXIeuRLeQOB0w8w0Xlu
	 5D8xfVyMQnYo7qU7qdPIZZsF1BViGBgk33U39jmiZdbrGUj9z3t4C8bt3CBSbFT5l9
	 /2r7w6F9gxN5CfJM9sClY0EMsUCrLtI0k6as50Bjxm6gCLyKhbZy2BdTMpSEFVRycd
	 o0c3oY9PoYlFvhAh3shml2NRuxEbfXoD8Rlj1YvT24ywiz2F33RnzIx9Taqe6dint8
	 rD4d7P/Jk/CkA==
From: Borislav Petkov <bp@kernel.org>
To: riel@surriel.com
Cc: Manali.Shukla@amd.com,
	akpm@linux-foundation.org,
	andrew.cooper3@citrix.com,
	jackmanb@google.com,
	jannh@google.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhklinux@outlook.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	x86@kernel.org,
	zhengqi.arch@bytedance.com,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH v15 05/11] x86/mm: Use broadcast TLB flushing in page reclaim
Date: Tue,  4 Mar 2025 14:58:10 +0100
Message-ID: <20250304135816.12356-6-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304135816.12356-1-bp@kernel.org>
References: <20250304135816.12356-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@surriel.com>

Page reclaim tracks only the CPU(s) where the TLB needs to be flushed, rather
than all the individual mappings that may be getting invalidated.

Use broadcast TLB flushing when that is available.

  [ bp: Massage commit message. ]

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250226030129.530345-7-riel@surriel.com
---
 arch/x86/mm/tlb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 8cd084bc3d98..76b4a88afb56 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1320,7 +1320,9 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	 * a local TLB flush is needed. Optimize this use-case by calling
 	 * flush_tlb_func_local() directly in this case.
 	 */
-	if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
+		invlpgb_flush_all_nonglobals();
+	} else if (cpumask_any_but(&batch->cpumask, cpu) < nr_cpu_ids) {
 		flush_tlb_multi(&batch->cpumask, info);
 	} else if (cpumask_test_cpu(cpu, &batch->cpumask)) {
 		lockdep_assert_irqs_enabled();
-- 
2.43.0


