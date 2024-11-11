Return-Path: <linux-kernel+bounces-404658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E42E9C4651
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB4BB26A71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4651AB6E2;
	Mon, 11 Nov 2024 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ONsRDFrj"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19BC159596
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355392; cv=none; b=kWF5zjuXlXC6ZXsRJKHuj9GIoW4spAOn9es2UoRcZRcvz52kNSpDpsTpVd+QZBwQOrHLTY6P49xIhJ172jhZw3tfA+u4P04YnEWNlMdzbHbMy1oGUDrTf1N2M5WcVcuqOi1NOFebvagHy0HHShUQSjAwzWEeLuoBOqLJTEBj5XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355392; c=relaxed/simple;
	bh=vr7aqKztPjRfbUBA2SBRJfn/DGMSrphS3AcgsXHNO78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QndIEPZnmiQR6NIsRNeqPYJoUcr98HmuGxU02smbIzwWDTwr+S98x7U0OIe06vhrxMhcVaazCGU6cs+4q9wZWBl24NqoLbdJmFDjqihBpTCrsqz5Dkv53W8/yBQZrWJUdTExvyFnNi0BBcGevwZZPxjjwQguoNaBCuUZSi7sZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ONsRDFrj; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731355381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KsasaxW/qgozhLdiFt3pZQYHUUwKcBSae38ptynT+Mo=;
	b=ONsRDFrjiVcW0Izi/WW0/LeO4woNA3f2ejlkyOBga1zbTneq7DDyfQwNkVwoWSs04TYrSz
	wjAKTprkLWawYruspyoZ9sKQjb7NDn4rl6xEE0ReGb7Uo6+2aOGW90a8HiT6SOTj5Pn46h
	dwdOY87nCs1oAqkAD0CIZ0u6HkLENRo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: Replace one-element array with flexible array member
Date: Mon, 11 Nov 2024 21:01:53 +0100
Message-ID: <20241111200155.164621-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated one-element array with a modern flexible array
member in the struct hvtramp_descr.

Additionally, 15 unnecessary bytes are allocated for hdesc, but instead
of fixing the parentheses in the open-coded version, use struct_size()
to calculate the correct number of bytes.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sparc/include/asm/hvtramp.h | 2 +-
 arch/sparc/kernel/smp_64.c       | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/hvtramp.h b/arch/sparc/include/asm/hvtramp.h
index 688ea43af0f5..ce2453ea4f2b 100644
--- a/arch/sparc/include/asm/hvtramp.h
+++ b/arch/sparc/include/asm/hvtramp.h
@@ -17,7 +17,7 @@ struct hvtramp_descr {
 	__u64			fault_info_va;
 	__u64			fault_info_pa;
 	__u64			thread_reg;
-	struct hvtramp_mapping	maps[1];
+	struct hvtramp_mapping	maps[];
 };
 
 void hv_cpu_startup(unsigned long hvdescr_pa);
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e40c395db202..24d980220bf1 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -297,9 +297,7 @@ static void ldom_startcpu_cpuid(unsigned int cpu, unsigned long thread_reg,
 	unsigned long hv_err;
 	int i;
 
-	hdesc = kzalloc(sizeof(*hdesc) +
-			(sizeof(struct hvtramp_mapping) *
-			 num_kernel_image_mappings - 1),
+	hdesc = kzalloc(struct_size(hdesc, maps, num_kernel_image_mappings - 1),
 			GFP_KERNEL);
 	if (!hdesc) {
 		printk(KERN_ERR "ldom_startcpu_cpuid: Cannot allocate "
-- 
2.47.0


