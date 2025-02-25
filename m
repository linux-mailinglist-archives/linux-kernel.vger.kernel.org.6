Return-Path: <linux-kernel+bounces-531443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E16A44099
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1A63AC315
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1F12690D7;
	Tue, 25 Feb 2025 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cOU3NvDp"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8613320AF88
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489501; cv=none; b=ECHttNwEqx3q2PeBj4sgvqle5mADH1azGf6YZqFoZW/Yqf6Ht8Jc1f9YS+kaYDasho6npPCnOLNr8OKkTatC3cl1ZBbqx/wak5ozSO4hDBwJnZRIyidMuiizQ4lLfCyib6lNMCLp5cwthcqUbNldQ+/m66yNL9Jt0PcEApRNh4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489501; c=relaxed/simple;
	bh=zbwgehHRalj+lRAc0w1bK3xorz1n6awj/5/a747TdMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sd3IRphesm/O794Jkwe1HgDBuebFzNOvNE+KWRD8isuHPE7giow2NqgEWS1FS5oDm0mT4qQ2c19lAcx/kyXb4gS8NiigqM3TNUU8LC9Cx/G6rUe2Ivlg6s2FYqqNvowApH6nKKrU8vHSdm/jCRmvbZ7MndgWkgHGtkT3bZ+03XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cOU3NvDp; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740489497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KABk1OD/isbejnrIkBFFKONXs7HdtVLpFPPX6O9lr9Q=;
	b=cOU3NvDpcTRdPf3Z3ugTCKqqJ/s8bHjQHBQtytZrR+k9+0M5hp6i9qvrIvlNsvgP8/bvzA
	dOUbOjjdSnsN6c6oGPJt6Yzs/J59ETIwJg6kpoJ9gyoHmWPAhFDHbdZfxSvkGzCUEVab/B
	S+3nRMLKpZh2zBy//sahA1gU9YQwvfU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mtrr: Remove unnecessary strlen() in mtrr_write()
Date: Tue, 25 Feb 2025 14:16:19 +0100
Message-ID: <20250225131621.329699-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local variable length already holds the string length after calling
strncpy_from_user(). Using another local variable linlen and calling
strlen() is therefore unnecessary and can be removed. Remove linlen
and strlen() and use length instead.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/x86/kernel/cpu/mtrr/if.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index a5c506f6da7f..4049235b1bfe 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -99,7 +99,6 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 	char *ptr;
 	char line[LINE_SIZE];
 	int length;
-	size_t linelen;
 
 	memset(line, 0, LINE_SIZE);
 
@@ -108,9 +107,8 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 	if (length < 0)
 		return length;
 
-	linelen = strlen(line);
-	ptr = line + linelen - 1;
-	if (linelen && *ptr == '\n')
+	ptr = line + length - 1;
+	if (length && *ptr == '\n')
 		*ptr = '\0';
 
 	if (!strncmp(line, "disable=", 8)) {
-- 
2.48.1


