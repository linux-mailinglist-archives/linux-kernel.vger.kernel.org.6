Return-Path: <linux-kernel+bounces-378992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4BE9AD85E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6ED81C21B54
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8239E1FEFD9;
	Wed, 23 Oct 2024 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="UEvThBjL"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EEB1E4A4
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729725415; cv=none; b=jSH5SOLSDybZpIipcLbsGBWdWltIuSgt1JyrfKhPf3oaJuEyAh6h2znSvQ7rsR9Rh7cnAXFlDjYFcQ/NEqM2xGkEr9D7ABCHACO5LJL8pXjK3qe/RUxk8f4anzGN/CIRMI4QHqvczsf/E40Kk5P6YxHjnqld2OQHZkcQzc4xPeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729725415; c=relaxed/simple;
	bh=jnsUIHQY8FoifheeEUtQaV+f9k2OU0WKSfyn3R8kkbk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PJO/7bA3rBNFptsZj+Hp3rIq8PEN6SmRrp8D7IHqu2XPNOxg+ZsX9NHKSdR0ahcvegrnbUD988y7QJ6da0Nf/yFUobuvJPfj+bXLoMXC6b5WKg4R2XlWAh/BpVDmtDn7PPcde+CT8va7WueYAlq32sSilTukB7Zk/0jdd4CatBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=UEvThBjL; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 7724317710C; Wed, 23 Oct 2024 23:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1729725407; bh=jnsUIHQY8FoifheeEUtQaV+f9k2OU0WKSfyn3R8kkbk=;
	h=Date:From:To:Subject:From;
	b=UEvThBjLIfzGfHW2+0WEp4dbW1PempS9pI6lZyILyRiNH8pG4/1ZCqRJUPDUFNmQW
	 b0vhO9wq6Opurkme9rzXF0WAcHq5dF4ZkrOK9/qXaO40pi1TCoYNH9L7csDJaQr0Hw
	 oMnQfcW8tfdT0EGacfGtZIHqdc0AGEKTUP3CzNt4BTftf7iHx+2fXqJ2VAJFk+l0Op
	 ui0qukEsIcX93eMVgCa3SwFm3Ih0MKQK3lfv3OBS57NBuV7RV5hX+98KGqoNsFxVeq
	 y3sHUnUYqKG8GQ3KdE1PysIqrZKTyG42lmJZF1BVoPjWiTFJQjSo+9/SMDFOly56gQ
	 PXhowMy+kixpw==
Date: Wed, 23 Oct 2024 23:16:47 +0000
From: Nir Lichtman <nir@lichtman.org>
To: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	linux-kernel@vger.kernel.org, m.younesbadr@gmail.com
Subject: [PATCH] KASLR: Properly injest nokaslr on x86 to avoid passing it to
 init process
Message-ID: <20241023231647.GA860895@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

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

Signed-off-by: Mahmoud Younes <m.younesbadr@gmail.com>
Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 arch/x86/mm/kaslr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 230f1dee4f09..4d159aa6910c 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -71,6 +71,21 @@ static inline unsigned long get_padding(struct kaslr_memory_region *region)
 	return (region->size_tb << TB_SHIFT);
 }
 
+/*
+ * nokaslr param handling is done by the loader which treats the
+ * boot parameters as read only so this is a hack to ingest this
+ * to keep it from passing to user mode
+ */
+static int __init parse_nokaslr(char *p)
+{
+	if (!!(boot_params.hdr.loadflags & KASLR_FLAG)) {
+		pr_warn("the loader has not parsed the nokaslr flag");
+	}
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

