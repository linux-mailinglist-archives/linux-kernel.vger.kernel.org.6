Return-Path: <linux-kernel+bounces-524976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D524FA3E96C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 01:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E1C1895609
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA563D3B8;
	Fri, 21 Feb 2025 00:54:13 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD71BDC3
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099252; cv=none; b=VHjNcW3U6weQmwAJAkY8Vj/lwJChQSQd51N0qcnsiIVXnbWMSt1x4OGTqkUuXxoHXwKnlFzqkHSQN1cWGkYvk9J00J3x8in2+9O/GkAEOSwlQnO8TjRzFN+rGTsPErsfZEyxug1U9FOQBA/DpA0YDzpZM/4LDsv6zMY8+YDGwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099252; c=relaxed/simple;
	bh=zlfz1ZVFQiGJXQEMWXYabmOodmJJcIh2c1j+uC8AoQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7HGuH/rjHanesm/AFq716gbw/HED6cXpjv6iFrG7yN/7wK9ewZ7v/7XCMtI+ZXm5jlXajfK9DprcPPPAbqEffTSGdPqSnj3RqSeQOz7a/5xz1tw4PkApVsv9QzQ9VpsF7z5Nu9ElIX6Aug5CMXBr/4htdKKOjWR/IWyuGo9c/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tlHIZ-000000003Qf-1C5m;
	Thu, 20 Feb 2025 19:53:47 -0500
From: Rik van Riel <riel@surriel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bp@alien8.de,
	peterz@infradead.org,
	dave.hansen@linux.intel.com,
	zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com,
	thomas.lendacky@amd.com,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	jackmanb@google.com,
	jannh@google.com,
	mhklinux@outlook.com,
	andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH v12 07/16] x86/mm: use INVLPGB in flush_tlb_all
Date: Thu, 20 Feb 2025 19:53:06 -0500
Message-ID: <20250221005345.2156760-8-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250221005345.2156760-1-riel@surriel.com>
References: <20250221005345.2156760-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@surriel.com

The flush_tlb_all() function is not used a whole lot, but we might
as well use broadcast TLB flushing there, too.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Manali Shukla <Manali.Shukla@amd.com>
Tested-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/mm/tlb.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 59396a3c6e9c..2d7ed0fda61f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1065,6 +1065,16 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 }
 
 
+static bool broadcast_flush_tlb_all(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
+		return false;
+
+	guard(preempt)();
+	invlpgb_flush_all();
+	return true;
+}
+
 static void do_flush_tlb_all(void *info)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
@@ -1074,6 +1084,12 @@ static void do_flush_tlb_all(void *info)
 void flush_tlb_all(void)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
+
+	/* First try (faster) hardware-assisted TLB invalidation. */
+	if (broadcast_flush_tlb_all())
+		return;
+
+	/* Fall back to the IPI-based invalidation. */
 	on_each_cpu(do_flush_tlb_all, NULL, 1);
 }
 
-- 
2.47.1


