Return-Path: <linux-kernel+bounces-183868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAFF8C9F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AEC1F22242
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A8F136E18;
	Mon, 20 May 2024 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="cPklxUCL"
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7119613699A
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216897; cv=none; b=BRVfWnZqcUYROGHRdfBsg/1X/49s0IxqlCanvRfCIpYwHnxoCQ3cWYUAaxg6wRDW+TEZZoXlaMniaRNsyL+lGcq8TRjl8a5TpPyCjpqqEg4qAa99kJzIn60CyStOM9+I7rzYs1yI2cYwZL+Fh78FlR8HJbx4+XEE+kWZVx3/PdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216897; c=relaxed/simple;
	bh=clpyNQpvD2QjEkJaOz5hsXiNkIjsCTbRMlRun10p+Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cDFdoaJY2EUpVxbSJWalzZcvVY+kNKazrtJ8x3YehmyfUBHN6k85Aw/P7K5LbYZA4w8NMhB//tG8Cjfg+mX5M1uaz6e2XNX72vlPVy60pdDYRIRa8hEzWWxa2UaqEaE79ls4rnGwLZRc9BPcjWhQPj8j7mx6PA8ZvJvccO1rTjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=cPklxUCL; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c10a:0:640:882f:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9FD8E60A56;
	Mon, 20 May 2024 17:51:26 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:8810::1:2c])
	by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id uoJQX60IfOs0-Q0v947GF;
	Mon, 20 May 2024 17:51:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1716216685;
	bh=Ype1Fb5hqSSEjjtIwCnPzpbYPBKN0xi6g1o6op9FVBc=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=cPklxUCLMTmMSZtCeZFXAr0nzBmcB7nUUk7qIlxmXaAIrbSQz8KVLY655LJl0Wudq
	 QUbhiExTTZblIsAUZO4Qv0IP61IwnwqKfuJ+wc+viK+arJf0Vsmeg5Hk/7xe/I1/TY
	 6QlOcoUvID/PwEmdLBKJrieOazag8RuurjgANBNQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH] x86/numa: Bump NR_NODE_MEMBLKS to MAX_NUMNODES * 4
Date: Mon, 20 May 2024 17:50:21 +0300
Message-Id: <20240520145021.1528151-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With modern AMD EPYC platform we're able to spot 3
memblocks per NUMA, so bump MAX_NUMNODES multiplier
from 2 to 4. Problem becomes apparent if MAX_NUMNODES
close enough to real amount of nodes and leaves us with
`too many memblk ranges` dmesg error.

Bump also maximal count of immovable regions accordingly.

Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 If overhead related to doubled arrays is too undesirable
 maybe we should consider config option for this? It appears that
 NR_NODE_MEMBLKS used only on LoongArch and x86 (macro in asm-generic
 is orphane).

 arch/x86/boot/compressed/acpi.c | 6 +++---
 arch/x86/boot/compressed/misc.h | 2 +-
 arch/x86/include/asm/numa.h     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index f196b1d1ddf8..74575a900924 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -17,9 +17,9 @@
 
 /*
  * Immovable memory regions representation. Max amount of memory regions is
- * MAX_NUMNODES*2.
+ * MAX_NUMNODES*4.
  */
-struct mem_vector immovable_mem[MAX_NUMNODES*2];
+struct mem_vector immovable_mem[MAX_NUMNODES*4];
 
 static acpi_physical_address
 __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
@@ -305,7 +305,7 @@ int count_immovable_mem_regions(void)
 				num++;
 			}
 
-			if (num >= MAX_NUMNODES*2) {
+			if (num >= ARRAY_SIZE(immovable_mem)) {
 				debug_putstr("Too many immovable memory regions, aborting.\n");
 				return 0;
 			}
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index b353a7be380c..a756569852e5 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -174,7 +174,7 @@ static inline acpi_physical_address get_rsdp_addr(void) { return 0; }
 #endif
 
 #if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE) && defined(CONFIG_ACPI)
-extern struct mem_vector immovable_mem[MAX_NUMNODES*2];
+extern struct mem_vector immovable_mem[MAX_NUMNODES*4];
 int count_immovable_mem_regions(void);
 #else
 static inline int count_immovable_mem_regions(void) { return 0; }
diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index ef2844d69173..057eafe6fed5 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -10,7 +10,7 @@
 
 #ifdef CONFIG_NUMA
 
-#define NR_NODE_MEMBLKS		(MAX_NUMNODES*2)
+#define NR_NODE_MEMBLKS		(MAX_NUMNODES*4)
 
 extern int numa_off;
 
-- 
2.34.1


