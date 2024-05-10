Return-Path: <linux-kernel+bounces-175411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605CC8C1F40
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B7E1C21697
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB25B15EFB7;
	Fri, 10 May 2024 07:47:33 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB43152791
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327253; cv=none; b=BbaTjQqbD0iU+4+q66apDYZrgYEGaW5HKge53DwQ5qHTnhMOwK3G98GSgyVVWQyUY5SZd/dAnex2TUqw0wZRcYhO3UBC77H/AiPmiqITIaS7ovRfQBcFJ6dBGIusYY5QpAsfLD+439S1SSxR7eeZqyYzoSmfdlVu6ngo4l52S3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327253; c=relaxed/simple;
	bh=XUYA6SCd7863HIOEwyLOsGDPB4JHliqRDL3gRi1bSh0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WS5/zApybZkUFXk9IDHQn3gqFoDzPSQWZ4KV7vuB6nOkr0iiguzKs6Z4UNw70UdjiuS0siWI2ECsqmcRt1zqiw2DWg4NV5x3khWL1hIIkoPXrOm/OjvveTW5v4Yte6z8t6vcRwcVh2ROwMiCNuMYgseAiSkG0ADC7KLOIjdXWJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-62-663dd10d2bbd
From: Byungchul Park <byungchul@sk.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jbohac@suse.cz,
	dyoung@redhat.com
Cc: kernel_team@skhynix.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] x86/e820: apply user defined memory limit in e820__finish_early_params()
Date: Fri, 10 May 2024 16:47:14 +0900
Message-Id: <20240510074714.73177-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LhesuzUJf3om2aQUcvv8XnDf/YLF5saGe0
	aJjYwGIxbaO4xY2Dm9ksLu+aw2Zx6cACJovNm6YyW/zY8JjVgdPje2sfi8emVZ1sHu/OnWP3
	mHcy0OP9vqtsHmcWHGH3+LxJzuNEyxfWAI4oLpuU1JzMstQifbsEroxX65+zFRwTr2h6dI+x
	gbFZuIuRg0NCwETi6RyJLkZOMPPhu9ssIDabgLrEjRs/mbsYuThEBBYzSpx4944VJMEsYC1x
	53AXWJGwQIzEqf6LTCA2i4CqRFPPezYQm1fAVOJ+y10miKHyEqs3HAAbJCHwl1Vi5sbPjBAJ
	SYmDK26wTGDkXsDIsIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMjMJiW1f6J3sH46ULwIUYBDkYl
	Ht4dm23ShFgTy4orcw8xSnAwK4nwVtVYpwnxpiRWVqUW5ccXleakFh9ilOZgURLnNfpWniIk
	kJ5YkpqdmlqQWgSTZeLglGpgFPJ96r+8dc46gZJEruVrn/p2ONw6v7fxD1+ZsknhQoby49Pc
	H9Zc17Ge8J791bEvMqGefwU7njZKtM1f+8JZYLbWukzpjFViQbvuvLKfHPnYQ8CGwUnPa8mk
	yaGKa107Dji075jjnqOptqrmv0/VJNOGuZxm8+MzRXm3MUqwimvP43SNP6OvxFKckWioxVxU
	nAgA6W+MMCICAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOJMWRmVeSWpSXmKPExsXC5WfdrMt70TbNoLOH2eLzhn9sFi82tDNa
	NExsYLGYtlHc4sbBzWwWh+eeZLW4vGsOm8WlAwuYLDZvmsps8WPDY1YHLo/vrX0sHptWdbJ5
	vDt3jt1j3slAj/f7rrJ5LH7xgcnjzIIj7B6fN8l5nGj5whrAGcVlk5Kak1mWWqRvl8CV8Wr9
	c7aCY+IVTY/uMTYwNgt3MXJySAiYSDx8d5sFxGYTUJe4ceMncxcjF4eIwGJGiRPv3rGCJJgF
	rCXuHO4CKxIWiJE41X+RCcRmEVCVaOp5zwZi8wqYStxvucsEMVReYvWGA8wTGDkWMDKsYhTJ
	zCvLTczMMdUrzs6ozMus0EvOz93ECAyOZbV/Ju5g/HLZ/RCjAAejEg/vjs02aUKsiWXFlbmH
	GCU4mJVEeKtqrNOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ83qFpyYICaQnlqRmp6YWpBbBZJk4
	OKUaGNtqln/Ly/+oGCJ+RWXlP68fB6tXad8z2qSxd5GBkuIE3V9GsUVzxIMts40Xl1qrFlVZ
	+Mzhm/P6brDQJYflwYFJNTci70R5FLmxPLJy+9xvpZ/BsuZs8U53s6AX646wO922+dUqvVyi
	XTR4ygVHLlMlI4myU1UbMp5KR932nLPpW+gKiQM3lFiKMxINtZiLihMB7XgwSwoCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

I might miss something.  Please lemme know if I go wrong.  Thanks.

	Byungchul

Changes from v2
	1. Fix a bug using a wrong type, E820_TYPE_RESERVED_KERN so as
	   to use the correct type, E820_TYPE_RAM when limiting the
	   memory size.
	2. Make the patch more clear.  The current version just moves
	   the place to apply the memory limit, from the phase parsing
	   boot command to the very end of considering early params of
	   e820.

Changes from v1
	1. before - handle boot_mem_limit assuming the default is U64_MAX.
	   after  - handle boot_mem_limit assuming the default is 0.

--->8---
From 3d5a7eb5d7529cfc1449c8cf72dd23748640ae05 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Fri, 26 Apr 2024 15:10:35 +0900
Subject: [PATCH v3] x86/e820: apply user defined memory limit in e820__finish_early_params()

Limiting memory by 'mem=' or 'memmap=' boot command doesn't work in some
systems that keep overwriting the memory map during booting process.

In such a system, there's no way to limit the memory size e.g. for test
purpose or someting.  Thus, this patch made the restriction applied in
e820__finish_early_params() rather than the phase parsing boot command,
that is the very end of considering early params of e820.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/kernel/e820.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 6f1b379e3b38..3bc593235b76 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -879,6 +879,7 @@ static void __init early_panic(char *msg)
 }
 
 static int userdef __initdata;
+static u64 userdef_mem_limit;
 
 /* The "mem=nopentium" boot option disables 4MB page tables on 32-bit kernels: */
 static int __init parse_memopt(char *p)
@@ -905,7 +906,10 @@ static int __init parse_memopt(char *p)
 	if (mem_size == 0)
 		return -EINVAL;
 
-	e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
+	if (userdef_mem_limit)
+		userdef_mem_limit = min(userdef_mem_limit, mem_size);
+	else
+		userdef_mem_limit = mem_size;
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 	max_mem_size = mem_size;
@@ -966,7 +970,10 @@ static int __init parse_memmap_one(char *p)
 		else
 			e820__range_remove(start_at, mem_size, 0, 0);
 	} else {
-		e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
+		if (userdef_mem_limit)
+			userdef_mem_limit = min(userdef_mem_limit, mem_size);
+		else
+			userdef_mem_limit = mem_size;
 	}
 
 	return *p == '\0' ? 0 : -EINVAL;
@@ -1050,6 +1057,11 @@ void __init e820__reserve_setup_data(void)
 void __init e820__finish_early_params(void)
 {
 	if (userdef) {
+		if (userdef_mem_limit)
+			e820__range_remove(userdef_mem_limit,
+					ULLONG_MAX - userdef_mem_limit,
+					E820_TYPE_RAM, 1);
+
 		if (e820__update_table(e820_table) < 0)
 			early_panic("Invalid user supplied memory map");
 
-- 
2.17.1


