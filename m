Return-Path: <linux-kernel+bounces-510013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2062CA3174E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3F6161175
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17150264FA4;
	Tue, 11 Feb 2025 21:08:35 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188122641E8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308114; cv=none; b=kY3/KhNH63C0wrp71X7w+qM3Li3ZfVFCy2dJmVG4PIJ05I8mVjPLnvne8ia/TqcZzDgmTwFzEOOtK4r6VVhPRyXoU5CbsSXBReenYYzEOvvCWOlDXITu+a53Em9m5LjfjfZr6VJczMC7bVskTZhUFiykxAaxxHenjJUl6riuyM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308114; c=relaxed/simple;
	bh=Vwmve58dF7GFpv3pyTR6PvKjLpFmn5NnPVLBU+kAhx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRO1q+9nJaAre07RNDW6LPVbVL6G94JVxXmopjEZG3sotriS/8eDo4oY5L1yOIxcxl9sF+LXRJY11px99Plpx6c/SpAku/aAE1gcPBJo3jskBpAVTjGJ2hOMcBQgU9/6AdVZasY6L5bMimjhsjjdwH+sZDMwOcpsnioC1/vGLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1thxUX-000000008HU-36py;
	Tue, 11 Feb 2025 16:08:25 -0500
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
Subject: [PATCH v10 07/12] x86/mm: use INVLPGB in flush_tlb_all
Date: Tue, 11 Feb 2025 16:08:02 -0500
Message-ID: <20250211210823.242681-8-riel@surriel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250211210823.242681-1-riel@surriel.com>
References: <20250211210823.242681-1-riel@surriel.com>
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
---
 arch/x86/mm/tlb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 54a118b22e59..62b4eaf4e851 100644
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


