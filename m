Return-Path: <linux-kernel+bounces-549838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3EBA557C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441F517735F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD12527701B;
	Thu,  6 Mar 2025 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BKZwTppk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q58QeEmV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF37270EBF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294232; cv=none; b=db3DlUI0LSlc4ZR9teKgjIooQMoMt9/hyT7PFKbsIyrJh6Ol1scj9JLMWbxRfHvelACusuUyNGA+uY/8I43RsUCv7P9ijHX5q4iPdNtcDzQzZfCaIqrVxC95znmERwgk94r5iYtcowyAvTAH2o+eq0Lb/9NyRd4KP7vwkmbcua4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294232; c=relaxed/simple;
	bh=etYCWwZuY6WBwGV1mwSClKPJGtnqn08gMHsF1t0ivMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJWAOg0Z+HjvXFHsNLqV9A94rvX8bnrcNQ4PfqK+wjR+0EucwFUJ57SZ9Lgiu0Hwi7MXzVQGtVfPvtDBg+mjX5Z0EEpsli/u2EcC3Ya37cDAOB7d0y/ICDv7h7pXJl8WCHGrVD1Pt4OL9Nqb9OTt+87KMn3gS/f1mRgZkisQcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BKZwTppk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q58QeEmV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741294228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2PA07qsEgo3bJF/icLfJrJMUGWk+opu3HdPA13I9PQ=;
	b=BKZwTppkIVgdKDTiY11nCpOYAUjNH/Kgnb/qC8NBd44nJ+UzDq4nvx4OHs/UHTK7Nb665B
	09zJSVWIKzIEix8x1Gz3HaaicKax7olAwpbC0Cykpa3j6x07B6yBJv1d1CmdNERmW0pbCC
	3iE+gddxDEIJmMbrHhP9P4DNEA9RyBNVGZGV5WcmOz/c0stDYm1bnPJXiZ8v2fLR1f+Nrd
	++iaaRDmocuuQ7m00sDMz/XMascToHzzyZDM11eGZWlLNAOpoTGWFg0fH+4HvNsrgOhOsU
	01QdDDkZZBKiOs7OAukgv4mTgzTjtl5JREKWApTrBXr8OFj2l0RMhiUHLL3s6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741294228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W2PA07qsEgo3bJF/icLfJrJMUGWk+opu3HdPA13I9PQ=;
	b=Q58QeEmVpOgrjdHxdjldX7DImI7pQkv+bUrjkxGi9I0IotIsPmt0bwiq5B1sxIXyCBaH96
	IWnGnlAu9qSOcUBw==
To: Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 03/12] tools/x86/kcpuid: Remove unused global variable
Date: Thu,  6 Mar 2025 21:49:51 +0100
Message-ID: <20250306205000.227399-4-darwi@linutronix.de>
In-Reply-To: <20250306205000.227399-1-darwi@linutronix.de>
References: <20250306205000.227399-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The global variable "is_amd" is not used anywhere. Remove it.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 1159204b9902..ceed560cd8a3 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -78,7 +78,6 @@ struct cpuid_range {
  */
 struct cpuid_range *leafs_basic, *leafs_ext;
 
-static bool is_amd;
 static bool show_details;
 static bool show_raw;
 static bool show_flags_only = true;
@@ -571,16 +570,6 @@ static void show_info(void)
 
 static void setup_platform_cpuid(void)
 {
-	 u32 eax, ebx, ecx, edx;
-
-	/* Check vendor */
-	eax = ebx = ecx = edx = 0;
-	cpuid(&eax, &ebx, &ecx, &edx);
-
-	/* "htuA" */
-	if (ebx == 0x68747541)
-		is_amd = true;
-
 	/* Setup leafs for the basic and extended range */
 	leafs_basic = setup_cpuid_range(0x0);
 	leafs_ext = setup_cpuid_range(0x80000000);
-- 
2.48.1


