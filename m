Return-Path: <linux-kernel+bounces-565141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B76A661AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9984D18982A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570AC2066DA;
	Mon, 17 Mar 2025 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vj4Kqiwj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB202066C6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250663; cv=none; b=XRIXBnx2Hsi8XCDm6DRH/mvlGR3DV+wh84hzMErEV6hdby8BFqWTesmLiXlR/rskz6XSATJb2mtGdY7PgJQWuhGy+Wx8JsLgPr6kOfaILOVEMJ1snwP2dQ2is3DHCJzTnBHplXCMtvssPLp4sy12uaAWlHGve5a1nkFHVBk5m4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250663; c=relaxed/simple;
	bh=CvczkV3kEQ54Jpf2Pd6IPrz8Itw3XX2xRtDAKbNLDZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaiNt7GWkYDXQVuW4S0OU2O/Ki4aeU4+J1Rpbg36vWmBsOjstEdIDYghBCOkhS/FCZeQWEEb2ICvxkFLdLV+QRLtcO56L4vyPEX5fOuu2ciX8rdUHQM/Pka8r96c2+xlW6UYR84PXe8zpr5v9s5VZ9jBRDJBjmQgnED7P2bteJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vj4Kqiwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E72C4CEF0;
	Mon, 17 Mar 2025 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742250663;
	bh=CvczkV3kEQ54Jpf2Pd6IPrz8Itw3XX2xRtDAKbNLDZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vj4KqiwjI/3ifwWXjmdXvHVNYZHsFOHxWOXMRh9YQDHiecbtj8Fy9ZedcgDgEAm56
	 QMiK62Uu71rTUUHiNtWux3Ph4yaQHxaMVaAv3/H9lcF6qJPu/jEWyzTAoOziLd8zkB
	 7r5MlI7WcaNAwz2f+eQxDIEpjWoNmrrG8jqqk24G+HDXcbgBTu+wlWvBAbrKp/Fbis
	 B+sRrOeTJvRpgyDKrBnZZQWviWRCMZ3AYtCkEZVl6zy1Hd3AbjaHuOgJC5wXQQrT60
	 HBOhyi8zZa0/0FAjeWmlg5yKTZF7mwDJYENNtxWO7mcmfHBnaAliB0LhDRJPlFCTy6
	 1L2o1yhfIDPTw==
From: mingo@kernel.org
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5/5] x86/cpuid: Use u32 in instead of uint32_t in <asm/cpuid/api.h>
Date: Mon, 17 Mar 2025 23:30:39 +0100
Message-ID: <20250317223039.3741082-6-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250317223039.3741082-1-mingo@kernel.org>
References: <20250317223039.3741082-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ingo Molnar <mingo@kernel.org>

Use u32 instead of uint32_t in hypervisor_cpuid_base().

Yes, I realize uint32_t is used in Xen code et al, but this is
a core x86 architecture header and we should standardize on the
type that is being used overwhelmingly in related x86 architecture
code.

The two types are the same so there should be no build warnings.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Ahmed S. Darwish <darwi@linutronix.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317164745.4754-3-darwi@linutronix.de
---
 arch/x86/include/asm/cpuid/api.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/api.h b/arch/x86/include/asm/cpuid/api.h
index 356db1894588..9c180c9cc58e 100644
--- a/arch/x86/include/asm/cpuid/api.h
+++ b/arch/x86/include/asm/cpuid/api.h
@@ -187,9 +187,9 @@ static __always_inline bool cpuid_function_is_indexed(u32 function)
 #define for_each_possible_hypervisor_cpuid_base(function) \
 	for (function = 0x40000000; function < 0x40010000; function += 0x100)
 
-static inline uint32_t hypervisor_cpuid_base(const char *sig, uint32_t leaves)
+static inline u32 hypervisor_cpuid_base(const char *sig, u32 leaves)
 {
-	uint32_t base, eax, signature[3];
+	u32 base, eax, signature[3];
 
 	for_each_possible_hypervisor_cpuid_base(base) {
 		cpuid(base, &eax, &signature[0], &signature[1], &signature[2]);
-- 
2.45.2


