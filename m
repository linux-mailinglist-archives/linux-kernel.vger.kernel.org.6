Return-Path: <linux-kernel+bounces-342128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302AE988AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02DF1F23A54
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627451C2DB1;
	Fri, 27 Sep 2024 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TcMZ1TCn"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C0A138490
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466654; cv=none; b=h2ESTMJy5F1QOSBiA63vLgMkNGuCIbxETjzR65KDI7yY80Eys/9361GFdGSmYD7JcS8/emeGzOI9WRx9mzPBIDcKoX6HuuuHAf5SWpGJzSNy9l6DCKq7VS/eukQrFfK7Z4EFAhAJbOL16lMvGo9wRsfWEKk4aOfC7E8h7LeHvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466654; c=relaxed/simple;
	bh=enbd7fMfVf59B/v+M5Jn0PhJrPlcwc0U5V3LFFwjQZg=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ScgKS85QC/GV+S2bkPl3m79T/NyO45fFeWf0YMg6Oklk5p1ds0dcMr1uSJK6gW1KLdqpnUNf9Ns0jf4T92/dpJc/Mmw/6Es4NTtaAz7NvFQVdoq7K4OmFNElmDsKuxkL9LwztoGmDFymWqGnt9nVuCVZEqBJGQbTm2laYu+dSw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TcMZ1TCn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=EqwVWQ0lEn5NKERRe1JMKwqsIxUttvdNmtQApOwpG7k=; b=TcMZ1TCn+kRP4tIheHf7Z7YQSq
	/ZwViQM8eyow9cLFJV+3UdN8IIZMD1JKDruD/PtHps4LSzIQ0+cOVsvWZh//9KK1KIhYlv+0VfJZG
	lJAtPNatbwG2/XW5NWlEABnTlwFO0AkgU4Adm6aLfAa+O1dmr0f9zhTfmymg2C7a0YhU+vgZDOhLK
	KZHQdjfV14edG+LVi0NIBvqKIg1JrnWCNKPdM9ehscK/tSWgWU95qlD8LHpG+DbFUKzngVYHc3ybR
	vlCkJi7HW9nqZp2Hr9wkN+BbmGU5F4/3AVUzaIGyE0gTFtIi9BxSGw53JRnrQ6f6cBjSThsRCbUqm
	0mlg9h/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suGzG-0000000AVcx-3DT6;
	Fri, 27 Sep 2024 19:50:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D6562308CC5; Fri, 27 Sep 2024 21:50:44 +0200 (CEST)
Message-Id: <20240927194925.603504509@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 27 Sep 2024 21:49:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com
Subject: [PATCH 12/14] x86: Hacks for hacked up llvm
References: <20240927194856.096003183@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

XXX do this nicely once the llvm hacks are done nice

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig               |    8 ++++----
 arch/x86/include/asm/linkage.h |    2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2444,10 +2444,10 @@ config CC_HAS_ENTRY_PADDING
 
 config FUNCTION_PADDING_CFI
 	int
-	default 59 if FUNCTION_ALIGNMENT_64B
-	default 27 if FUNCTION_ALIGNMENT_32B
-	default 11 if FUNCTION_ALIGNMENT_16B
-	default  3 if FUNCTION_ALIGNMENT_8B
+	default 57 if FUNCTION_ALIGNMENT_64B
+	default 25 if FUNCTION_ALIGNMENT_32B
+	default  9 if FUNCTION_ALIGNMENT_16B
+	default  1 if FUNCTION_ALIGNMENT_8B
 	default  0
 
 # Basically: FUNCTION_ALIGNMENT - 5*CFI_CLANG
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -102,6 +102,8 @@
 	CFI_PRE_PADDING						\
 	.byte 0xb8 ASM_NL					\
 	.long __kcfi_typeid_##name ASM_NL			\
+	.byte 0xb0 ASM_NL					\
+	.byte 0x7f ASM_NL					\
 	CFI_POST_PADDING					\
 	SYM_FUNC_END(__cfi_##name)
 



