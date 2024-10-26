Return-Path: <linux-kernel+bounces-382999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 200619B1603
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 09:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8789EB21F26
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 07:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A5C192594;
	Sat, 26 Oct 2024 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="tsKaT+m3"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7161922E2
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729928310; cv=none; b=ENEwDk0vNuc4TCaau+/xEfgJdhsP1jPIOdTCv8URwxgbwFtuuSBuia+s0usbgjZLzFPIxdWKKbLWiYXzywjjkaCy3sS6g+o1dqFiTcHk0B3XyusMATLHASsJbhmrapNd6tEzHFnA/eTtdYkAESXGfLkj7GTbpuToptL/fP3OTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729928310; c=relaxed/simple;
	bh=zmvivd0oUwdG4iWh/zVgq0Wj8TN/yxp7dxBioI/z2WA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewumCWH9WgGBtshU3SueW3nv3S4UegZW5RKRQI2ew8cmGXUyDDhGn3hdzBWNsqugz/RAfGA7jtKU8lffaSQA6pODa3V0kFj2oin1m2WBmqvYwwm2VxR3e9gLBx3+r8HJPgZ8sd/OrqDuv26biCcnQI8QBqZhCDlJZekT+oTcNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=tsKaT+m3; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 2B722177103; Sat, 26 Oct 2024 07:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729928306; bh=zmvivd0oUwdG4iWh/zVgq0Wj8TN/yxp7dxBioI/z2WA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=tsKaT+m3pcuCYLMzgGupMJIrD6DE6Yd/IecRJSxu0mkgAMIZOqDOarhUMTldUmMmv
	 5zCFsxxqUDuiI20u0iQvNrLm1RegZKgDo4bknNYetpfmR0+NTKT4aapBwBYrQAFSYp
	 GcAbQCvulh1LzxO1blsZQK/wggVXa3rnqejYUEvE1bjxYRgk+PRzTdRP3yzWIXsfkd
	 SArwRbSfxwS0VGadeeBPsv+ugdPZK8ZDCUS4JvF2z1MlbZX+gB7ujufsBcmXG0VwMV
	 CVsLuGeAW3CKJQntS5b2hfUZWt6hqGQgxevG/oh/XtUElKqlxBnZcI0nLJEjchPTcV
	 x+91Ig4E+GkSw==
Date: Sat, 26 Oct 2024 07:38:26 +0000
From: Nir Lichtman <nir@lichtman.org>
To: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	linux-kernel@vger.kernel.org, m.younesbadr@gmail.com
Subject: [PATCH v2] x86/kaslr: Ingest nokaslr to avoid passing it to init
 process
Message-ID: <20241026073826.GA888573@lichtman.org>
References: <20241023231647.GA860895@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023231647.GA860895@lichtman.org>

Problem: Currently booting the kernel with "nokaslr" on x86 incorrectly
doesn't recognize this parameter and passes it on to the init process

Reason: On x86, this parameter is parsed by the early loader, and so the
main kernel itself doesn't do anything with it.

Example: I have encountered this issue when booting the kernel with QEMU
using -kernel and -initrd with a simple initrd I have built containing
bash as the init executable. Upon running init, the kernel passed the
"unrecognized parameter" to bash causing bash to exit with a failure and
the kernel to panic.

Solution: Ingest this parameter as part of the kernel logic in x86 so the
kernel will recognize this as a valid parameter and not pass it to user
mode.
This is similar to the logic that already exists in the case of ARM64
which can be found in arch/arm64/kernel/kaslr.c:43

Crediting also Mahmoud since he came up with a similar patch a couple of
months ago, the patch was left with unaddressed CR comments by Borislav
which I have addressed in this patch,
link to thread: https://lore.kernel.org/all/20240331200546.869343-1-m.younesbadr@gmail.com/

v2: Remove single line if-condition braces, following check patch script warning

Signed-off-by: Mahmoud Younes <m.younesbadr@gmail.com>
Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 arch/x86/mm/kaslr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 230f1dee4f09..e2aaa72be749 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -71,6 +71,20 @@ static inline unsigned long get_padding(struct kaslr_memory_region *region)
 	return (region->size_tb << TB_SHIFT);
 }
 
+/*
+ * nokaslr param handling is done by the loader which treats the
+ * boot parameters as read only so this is a hack to ingest this
+ * to keep it from passing to user mode
+ */
+static int __init parse_nokaslr(char *p)
+{
+	if (!!(boot_params.hdr.loadflags & KASLR_FLAG))
+		pr_warn("the loader has not parsed the nokaslr flag");
+
+	return 0;
+}
+early_param("nokaslr", parse_nokaslr);
+
 /* Initialize base and padding for each memory region randomized with KASLR */
 void __init kernel_randomize_memory(void)
 {
-- 
2.39.2

