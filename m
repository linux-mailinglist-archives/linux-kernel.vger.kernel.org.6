Return-Path: <linux-kernel+bounces-564686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B54A65943
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027F71690DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030E81E51F4;
	Mon, 17 Mar 2025 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ef0VT7fh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UYiLshfC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3791E1E16
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230377; cv=none; b=OnJJ0+rQsDoF+Djl8GgMXOR3BUV18k50Gcyr0bZU1Lu877zH8P+Dfn/Q6GCbseer5PVlV6nfMfi9ixS6hfzMUV2+ceQxPXh3ADq8L9kqrH1PAHnIRKtRbaakc0eYVJIc5EtZatT+hsir1g2AuxwlhwauOMzfeBOqk6KYr/mmzQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230377; c=relaxed/simple;
	bh=3ebwIAPxL45vYhct4TTdb9cACbC3gL38TfqAgcIdLV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXLJk5oWTSVZCnfa7zczSP9tu9tJ1TGgkNHj/YzJ0L0rFZ/r/vB7EM3N2r9WTyYdoxnGcn0OsxwnspzCpw0AJan0Kp/e/26KUaeNL5l93++SyvhWyqUdGHSG7TT5+d8tvvzlSuOw2md55SEHLcYFWLx/wuJFFLuhKydokxh/ze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ef0VT7fh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UYiLshfC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742230374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5eIpyjHtxxMUjvITzHQkqr1G1nZn/HufhcHlKrFS28=;
	b=ef0VT7fhxPOFH/I1HCzgdHjhv7yQzZYHTkXfiyRYDbO8HyR19gQW6+Tn31VQvYiuYlz08i
	7l45D1FZ8upvRs+7AIJcUIY3TRKFPb1RTjboDnZTpkD0lnzNUoAIgpfOnYLqsyppbkZj6P
	iDCNg+luXvCI7XihyfXfb/rfmxcxAa+4LmwWiIiVcCr2FSWmwRhgaZ7VEYb357bLHPkdz7
	9hyASJTwivRl3JczO4VaW2cM5xjh4Rh7We26moCjvCV04hylwzxlm1A1feHf8b+8tMv9r3
	ZEsTbQTNSurqnu4mH26NcOJx34E5M/hGUiNTY9b6UKw8DTbx12QBq1LU0fWtjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742230374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5eIpyjHtxxMUjvITzHQkqr1G1nZn/HufhcHlKrFS28=;
	b=UYiLshfC25Q2x2JN0WShrCFXcmhmEvIL3t/geXs4shLkU9HaxqLUXdQMuh32Y5q1OXvRhJ
	/FICGmwEUyrhykAQ==
To: Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	x86@kernel.org,
	x86-cpuid@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v2 08/29] x86/cacheinfo: Constify _cpuid4_info_regs instances
Date: Mon, 17 Mar 2025 17:47:24 +0100
Message-ID: <20250317164745.4754-9-darwi@linutronix.de>
In-Reply-To: <20250317164745.4754-1-darwi@linutronix.de>
References: <20250317164745.4754-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_cpuid4_info_regs instances are passed through a large number of
functions at cacheinfo.c.  For clarity, constify the instance parameters
where _cpuid4_info_regs is only read from.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 arch/x86/kernel/cpu/cacheinfo.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 2656f37ef536..8368eb26c909 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -840,7 +840,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 }
 
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
-				    struct _cpuid4_info_regs *base)
+				    const struct _cpuid4_info_regs *base)
 {
 	struct cpu_cacheinfo *this_cpu_ci;
 	struct cacheinfo *ci;
@@ -897,7 +897,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 }
 
 static void __cache_cpumap_setup(unsigned int cpu, int index,
-				 struct _cpuid4_info_regs *base)
+				 const struct _cpuid4_info_regs *base)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci, *sibling_ci;
@@ -931,7 +931,8 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 		}
 }
 
-static void ci_info_init(struct cacheinfo *ci, struct _cpuid4_info_regs *base)
+static void ci_info_init(struct cacheinfo *ci,
+			 const struct _cpuid4_info_regs *base)
 {
 	ci->id = base->id;
 	ci->attributes = CACHE_ID;
-- 
2.48.1


