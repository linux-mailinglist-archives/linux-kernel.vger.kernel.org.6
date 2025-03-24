Return-Path: <linux-kernel+bounces-573825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B26AA6DCE0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A54188451A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE6226137B;
	Mon, 24 Mar 2025 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WKr9UrQ+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KBf4KaYf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197A2638AA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826096; cv=none; b=TtaVA/7FaN9ufUfSic8QaGKo6Nm/pphuFnukGGj+lol/4R926YlBAOCJ/RFuIyIjWc0PQuq6Tdk/Gfy4F7zn38fRXarfGkHl+UH0tu1VuEgsOB6beVdTClN7jMyXhGrvRIGoIiunXqw2sbAVHGsZgM59Nidc5gGippyfd7aUrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826096; c=relaxed/simple;
	bh=UsnpezwpD+qZnATw5ahEcRX4gvJjC41VMOm1eA78W/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNfPzmkpRP1sqrLP0d/Ho8rS0LCeGphcm101Zuq+tDrzwfxFsau3IH75H1tWgVsFvOcPJt5+TGZKXeuXG01kUjqo85d87VsWEENiGYIrCKEbdf/plkJXpGyB1uZHteDafLs1bGScZvbxau4BE+N/cUEYP3S9ywEhe812Tpl92po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WKr9UrQ+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KBf4KaYf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742826093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elLHSodtEI8GlfrfiuCcnZFjB1Q5gP4rO9yPJobxTsg=;
	b=WKr9UrQ+KmzKXKhPc7JXARG2YRG+pnnGNmprgRw3HuKD8lFiH3eAPJOBINwxEJLV1LC56z
	b/PPr599GQWMEeegol4bq9VIMypGBdH82NLBpVWW/Z0QS1scXWyjMUMSeoW7AzJy2/Ykga
	Ra357JT7P/oSMrNa3cwwVZfTefLRLbmnsMf7lPJyB6ws5QrvLXs/FhBqCJ6OkwFSWZYJEM
	SPpS39bRntD0JL2maDDgrxtHD5X+34q7hpOCtTlnCIU98NILemw/8FEelXnZ8XodHFgvuR
	btH//DG3rWOwZN4cLG6lUhwb/eJPkUpxYEKa+DSF/l5v9ky3Pclyn9FVBjlE5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742826093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=elLHSodtEI8GlfrfiuCcnZFjB1Q5gP4rO9yPJobxTsg=;
	b=KBf4KaYf9cC0dC8NHVEak3neeSt77z8GAd9vSQN7KYgoURKEuTylaJQWCyQNIFlfDZ7DtS
	tCVpMWYGs533UoCg==
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
Subject: [PATCH v3 15/20] tools/x86/kcpuid: Define Transmeta and Centaur index ranges
Date: Mon, 24 Mar 2025 15:20:36 +0100
Message-ID: <20250324142042.29010-16-darwi@linutronix.de>
In-Reply-To: <20250324142042.29010-1-darwi@linutronix.de>
References: <20250324142042.29010-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly define the CPUID index ranges for Transmeta (0x80860000) and
Centaur/Zhaoxin (0xc0000000).

Without these explicit definitions, their respective CPUID indices would
be skipped during CSV bitfield parsing.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/arch/x86/kcpuid/kcpuid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 94a5926d00d0..12a4e245b15f 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -69,6 +69,8 @@ struct cpuid_func {
 enum range_index {
 	RANGE_STD = 0,			/* Standard */
 	RANGE_EXT = 0x80000000,		/* Extended */
+	RANGE_TSM = 0x80860000,		/* Transmeta */
+	RANGE_CTR = 0xc0000000,		/* Centaur/Zhaoxin */
 };
 
 #define CPUID_INDEX_MASK		0xffff0000
@@ -85,6 +87,8 @@ struct cpuid_range {
 static struct cpuid_range ranges[] = {
 	{	.index		= RANGE_STD,	},
 	{	.index		= RANGE_EXT,	},
+	{	.index		= RANGE_TSM,	},
+	{	.index		= RANGE_CTR,	},
 };
 
 static char *range_to_str(struct cpuid_range *range)
@@ -92,6 +96,8 @@ static char *range_to_str(struct cpuid_range *range)
 	switch (range->index) {
 	case RANGE_STD:		return "Standard";
 	case RANGE_EXT:		return "Extended";
+	case RANGE_TSM:		return "Transmeta";
+	case RANGE_CTR:		return "Centaur";
 	default:		return NULL;
 	}
 }
-- 
2.48.1


