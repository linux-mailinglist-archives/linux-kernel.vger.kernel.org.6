Return-Path: <linux-kernel+bounces-202206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A21F8FC92F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8461F24BC2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7B819148D;
	Wed,  5 Jun 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZqUMxLl"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E9C190490
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583784; cv=none; b=XTuVonbdraWr42LxnOiZhFlM7ABoSPTt4xQcNMVpLxUscDu7nYS+Wsq8IHJEvS2LVhP+/RlesHscgCEyx5JYEt7sxMyPcA9kMVyUhA9NCGvPUNXu8INCRBVDVRRQWynh2QbAZNvde0Bck682i1HQMWUjfxfaMR8+Yy4PhZAusx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583784; c=relaxed/simple;
	bh=HZn6Lg0mVfERSneXOWsIOgCopwKICO+zXzw+0NuieRc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JbfMyXOlxB3+65STbMwYc1pG5ePhUEGORGCk5M+Xn1kLx/REd2f+R5RwX281Q92gCRa7YFMad8BlqVvtXHYdqUcjcC7rR7DTFHCOmKRxx82W/DQSg9duJiMSoGXFt7VdOVeXOvxoLfrf1EzWz/n5+j2RHmYSOV7NSwHFtmjDAAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZqUMxLl; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-629f8a92145so91830057b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 03:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717583782; x=1718188582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0N2W9Nmsi5h7OxcBbG9ML5HoGuBphmYpMVggbvZo/vw=;
        b=HZqUMxLlyHNlBhKkE+O7duRjP0zJszEOG5zVSJNY7LK56l1UzKfwBSYgK2pd5JSVui
         zys5Ix7M1bIDDs7VWceT4DTnkJvVd5esUxmuilqg66VrTFuYb0+eXA2WA71GqtoSUED8
         zziT3sTYiKnQ7tU2ViG5FMFku1SeBiQ9SZ3ZQu4A+XlnYWMayambvO/143X3TMEHOTd1
         IHeaoXdl7+MWchP9ntzLKIR3W/khHjIVHjRju6i2r7lJCWZwGse4Y7KOqS83R+iIITRT
         YCFToc0/ltfJ4MQTxn9oO6mRC4nfZTTXKxUpQ7oJa2AKyeT7VkwgxJWyBVePJgKS+/0p
         //Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717583782; x=1718188582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0N2W9Nmsi5h7OxcBbG9ML5HoGuBphmYpMVggbvZo/vw=;
        b=YSKbt+xB0Cm8IFD4d9Sto3hs4UdKE0nDdHDSKnpuKpi9MzWsnSK3+rJ7462Skd5xB3
         DMxHg/A6KhXBUly5/A3Kp5ocm4SwThk+EJ0Onb1aEWF9jO1iX1Kz0958DnkO0MvxliXr
         r9ohsAiLLeJWyGzEPRzyrrTowaOP4pVYnNu7qf+URMi1pS4c3ZCunIl6NXYklOsRzuWT
         zrlL6NssiRuKlIIDXAwQGuJp+s1+DURTx16xo7KTG7on6UxdPg0u78wLlqunr9yLZMFj
         GLKXzVRqwCS5HO3xv0SLrbqf7F4j/eULWoc14cqjSFB5P60weAxvpqVYkxmQnDgBVp1d
         IXUA==
X-Gm-Message-State: AOJu0Yz8PikyqApT4TYfQMc+xTVDIpboWPQ0dJ0lz3w/dmye6SGgHKuV
	l0xV6JXuXNp8vapVgn7gEyBRUW/tsBKk3FP1lczyBLlXI7OAhDxf+qbqusv3bp0golp74jyWpDM
	QkQILqNZ0UFEKYFbWYTESni4igDOoZRZUUlxVcUTNfgPOBPuU2lTTDu3uKyl0Gr4HVsGC48PzZm
	TXl8WcQfrcKFvW5xPRL/YEX8BCJop1PQ==
X-Google-Smtp-Source: AGHT+IHHwrnMZYLle86i+JI3i9KdUMYWIdoAsn+sp9WCadkBBuhMeR6JEa8WsodKZA1P/newdYfYDO+y
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:f03:b0:627:7563:95b1 with SMTP id
 00721157ae682-62cbb5a2e62mr5151377b3.5.1717583781966; Wed, 05 Jun 2024
 03:36:21 -0700 (PDT)
Date: Wed,  5 Jun 2024 12:16:12 +0200
In-Reply-To: <20240605101610.2824747-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605101610.2824747-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2319; i=ardb@kernel.org;
 h=from:subject; bh=2Ohto+zqqFHiKYx8e0/IzBlCFtrmI1WgdIFm4ayPVDI=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIS3B6s3s4G/zvsucuvmgZ5qKVaLfudmKS85fsLigukLkg
 auAmbpfRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiImhLDf8fFZ5ee5by2ZkJc
 af7B0xMZF12btHfp9JkVf1gTTCd5Mk9nZPikrVJyJWWu5w/FJ/vesIq61/a4+s8xkkhfH7P87P8 rTrwA
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240605101610.2824747-7-ardb+git@google.com>
Subject: [PATCH v3 1/4] x86/sev: Avoid WARN()s in early boot code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Using WARN() before the kernel is even mapped is unlikely to do anything
useful: the string literals are passed using their kernel virtual
addresses which are not even mapped yet. But even if they were, calling
into the printk machinery from the early 1:1 mapped code is not going to
get very far.

So drop the WARN()s entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/sev.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 3342ed58e168..33a669e85e5b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -720,7 +720,7 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		if (op == SNP_PAGE_STATE_SHARED) {
 			/* Page validation must be rescinded before changing to shared */
 			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, false);
-			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
+			if (ret)
 				goto e_term;
 		}
 
@@ -733,21 +733,16 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 
 		val = sev_es_rd_ghcb_msr();
 
-		if (WARN(GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP,
-			 "Wrong PSC response code: 0x%x\n",
-			 (unsigned int)GHCB_RESP_CODE(val)))
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP)
 			goto e_term;
 
-		if (WARN(GHCB_MSR_PSC_RESP_VAL(val),
-			 "Failed to change page state to '%s' paddr 0x%lx error 0x%llx\n",
-			 op == SNP_PAGE_STATE_PRIVATE ? "private" : "shared",
-			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
+		if (GHCB_MSR_PSC_RESP_VAL(val))
 			goto e_term;
 
 		if (op == SNP_PAGE_STATE_PRIVATE) {
 			/* Page validation must be performed after changing to private */
 			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, true);
-			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
+			if (ret)
 				goto e_term;
 		}
 
@@ -780,7 +775,7 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
-void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned long npages)
 {
 	/*
-- 
2.45.1.288.g0e0cd299f1-goog


