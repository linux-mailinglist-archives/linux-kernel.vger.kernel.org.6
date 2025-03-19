Return-Path: <linux-kernel+bounces-567977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043F9A68CB3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504E319C4137
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A9D257AD5;
	Wed, 19 Mar 2025 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wJRZb9Sw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8mfIAG+/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF1925744B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386927; cv=none; b=p0ugyMPzuV8Loc+nUun0D0JEZ94prtlkds7WWjQ7a10O0uwOW3/F04WHiHVTmlus3N+s8FQS6XZKJK/cFPDHfdDXcfu//Hn2vSbbiWv+Iod/D8MGc94zgMKT8Zkw7S+rk0V+GCX3PFA75iEj22asJ+p/bJCk8eegMyhu7Iwx+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386927; c=relaxed/simple;
	bh=+J2MUMA6FaqN89uo/gT4W5HA2WW9NsIVSlCj58sAbXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1t7HPExPjEeUUyLN8MLWmJNhl83G4H/RLLZPz5GfMBQT80sgIe34mTz9oI5b87138p++RtgyqovnPAWL4By4+s8av+W/tMhSotROK+39JVCBrL/uHTfzQjFhrWhMg5VJvkqVZDu/wT+JU7nuzl8YNCdMKHU7Ix94v/JkhT74eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wJRZb9Sw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8mfIAG+/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742386923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjwIQbDd6xf3kEosT4buGrof2c51/KArCUqdt8u05RA=;
	b=wJRZb9Swaq9pxAQBIogcZ5u1qrhsck121ovo8iQVzWf2l0PAfJkszyfvYq67zhoupC65gY
	5Omx/zFYyQSC+r/cZPLAFuwN7YY1znFEzrpc5wlfIwavbx7W8CPBplnopNW+qoDw0V9vCo
	IcnWD2BBb6sHCiZkhXF6SLwSdz77Y7NfLBNxolVajNBF7sHhSTPsU2wlFZT2uN0boxjltR
	BWx0d47IAR0z48viidbleCqxYmg2p9CIdq9qpozIfolB6Yxp7sGtXlDmmVleLnq7NRkXlX
	gwwDPWovBA+gA++llSepnu5hwHgY42KDz6CrTXqrqoPtxe0cMyHYb00ZkjEx1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742386923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjwIQbDd6xf3kEosT4buGrof2c51/KArCUqdt8u05RA=;
	b=8mfIAG+/1YH2hTSO90a4DDuVTDmjYbrqsFwW0KJtPCdv4XH8mqOb9VJilLd81+56sqa9Nd
	pgROUY3QIumOMzBA==
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v3 06/29] x86/cacheinfo: Properly name amd_cpuid4()'s first parameter
Date: Wed, 19 Mar 2025 13:21:14 +0100
Message-ID: <20250319122137.4004-7-darwi@linutronix.de>
In-Reply-To: <20250319122137.4004-1-darwi@linutronix.de>
References: <20250319122137.4004-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

amd_cpuid4()'s first parameter, "leaf", is not a CPUID leaf as the name
implies.  Rather, it's an index emulating CPUID(4)'s subleaf semantics;
i.e. an ID for the cache object currently enumerated.  Rename that
parameter to "index".

Apply minor coding style fixes to the rest of the function as well.

[ darwi: Move into a separate commit and write commit log.
	 Use "index" instead of "subleaf" for amd_cpuid4() first param,
	 as that's the name typically used at the whole of cacheinfo.c. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index d0bfdb85b96a..0fd4e9673665 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -233,12 +233,10 @@ static const enum cache_type cache_type_map[] = {
 };
 
 static void
-amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
-		     union _cpuid4_leaf_ebx *ebx,
-		     union _cpuid4_leaf_ecx *ecx)
+amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
+	   union _cpuid4_leaf_ebx *ebx, union _cpuid4_leaf_ecx *ecx)
 {
-	unsigned dummy;
-	unsigned line_size, lines_per_tag, assoc, size_in_kb;
+	unsigned int dummy, line_size, lines_per_tag, assoc, size_in_kb;
 	union l1_cache l1i, l1d;
 	union l2_cache l2;
 	union l3_cache l3;
@@ -251,7 +249,7 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 	cpuid(0x80000005, &dummy, &dummy, &l1d.val, &l1i.val);
 	cpuid(0x80000006, &dummy, &dummy, &l2.val, &l3.val);
 
-	switch (leaf) {
+	switch (index) {
 	case 1:
 		l1 = &l1i;
 		fallthrough;
@@ -289,12 +287,11 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 	}
 
 	eax->split.is_self_initializing = 1;
-	eax->split.type = types[leaf];
-	eax->split.level = levels[leaf];
+	eax->split.type = types[index];
+	eax->split.level = levels[index];
 	eax->split.num_threads_sharing = 0;
 	eax->split.num_cores_on_die = topology_num_cores_per_package();
 
-
 	if (assoc == 0xffff)
 		eax->split.is_fully_associative = 1;
 	ebx->split.coherency_line_size = line_size - 1;
-- 
2.48.1


