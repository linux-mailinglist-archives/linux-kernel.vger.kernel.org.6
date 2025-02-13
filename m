Return-Path: <linux-kernel+bounces-513419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F23A34A12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D76C175FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3524C2222BE;
	Thu, 13 Feb 2025 16:20:46 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC16212B3A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463645; cv=none; b=t8uzQn3naibZ2f8UhKe9Fc0jN3/kqPMOUN4qBxGlawl42ILlO0Pkq4AAJLOiqP05rde5Ec+XemZoQTYmmpKjBVfyNhf8k83jGhMxzSFOy7x/sAvEE8jh+WPWHM3KyUOTvRn/Ndyrtg2fVZytNBapw2Nf2j62FEaTn1B0TXZ6Jh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463645; c=relaxed/simple;
	bh=RJp3AqDLK7pUJau3qjTujQQPdVmyvSrDm6d026DjmEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m86sP3lM6xyQD4Fj6MZhXaWKg47vgsKWBDG2bxTSQJrZcdHe/nZUjyfUjNNuT4kN+XeEQz3q46NUPsWrSXi/EywuUROWRgeUlH3MLg1PHGfuwiy0OfDVc1GfAtnUT9wnqFZ53yss+AXWvTG8L2CC5VWMYsn1+rnHrrIsEym38KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tibr7-000000003xx-0vS0;
	Thu, 13 Feb 2025 11:14:25 -0500
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
	Rik van Riel <riel@surriel.com>,
	Manali Shukla <Manali.Shukla@amd.com>
Subject: [PATCH v11 07/12] x86/mm: use INVLPGB in flush_tlb_all
Date: Thu, 13 Feb 2025 11:13:58 -0500
Message-ID: <20250213161423.449435-8-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250213161423.449435-1-riel@surriel.com>
References: <20250213161423.449435-1-riel@surriel.com>
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
 arch/x86/mm/tlb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index ce9df82754ce..3c29ef25dce4 100644
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
@@ -1073,6 +1083,8 @@ static void do_flush_tlb_all(void *info)
 
 void flush_tlb_all(void)
 {
+	if (broadcast_flush_tlb_all())
+		return;
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH);
 	on_each_cpu(do_flush_tlb_all, NULL, 1);
 }
-- 
2.47.1


