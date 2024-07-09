Return-Path: <linux-kernel+bounces-245617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AEB92B4FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40621C22B6A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AC8155A21;
	Tue,  9 Jul 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Ar12+GLc"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88EC13D89D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520264; cv=none; b=fZ3szI1nwXhEm2uxoY3b01duf02f9p7xBW/Hg0awpZPgpaHyxTyN8pNFHxIe9Q6tfoxD0ki1i2A9V7IkqMgYKb+wmLiKZb5I/io9OSNmgmUDzmD/in61BjV2ew/mbJr5LnOsx9iu1a/qWllgHTw/jKZDFB7+GnjH4+x5DhsE/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520264; c=relaxed/simple;
	bh=IESGm/8thX+g40USuX1uHIqqT896ZfnF8Gz3/dMx7xA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Clcrf8u/3Q+a0yFY6FiqAzORa2dJrQ23HUXf0vk2z1ZYgUPs1XJaZeHDCJxVz1k44vAOpOk/4kuhOLtYieU/CRUBIpZZbeLSioDAaxiwZ2Yq5BzR96R4kbOVRV9PYUxFgauQu3XLsdNrWZqet4mcBZAqSfCxbs/FhNlglZ7Y2wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=Ar12+GLc; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2799:0:640:ddd6:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6988960C7A;
	Tue,  9 Jul 2024 13:16:12 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:6501::1:b])
	by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 4GafBH0xDGk0-UVUGoUQh;
	Tue, 09 Jul 2024 13:16:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1720520169;
	bh=QMrzmVk4WO8uE3VndqvZoeEHIjcKsa+fOG95bYQveH4=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=Ar12+GLcLDVam8vydIELaDLPt55u79aSvOq5sE9cLemLR1M0ZCqi+XmiGe3B4yHzt
	 NrxKgnrCy+lhoC8Hn5CLsmzxj1SNI6pLXH9BDiujbQHuaVvyCKhu8XnjchG8E+V/87
	 CDGmzwbCqwlCus8rv8No4zqwC49gjQBOi5hsyzs0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nikolay Kuratov <kniv@yandex-team.ru>
Subject: [PATCH RESEND] x86/numa: Bump NR_NODE_MEMBLKS to MAX_NUMNODES * 4
Date: Tue,  9 Jul 2024 13:15:51 +0300
Message-Id: <20240709101551.1374100-1-kniv@yandex-team.ru>
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
`too many memblk ranges` NUMA init error.

Bump also maximal count of immovable regions accordingly.

Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 If overhead related to doubled arrays is too undesirable
 maybe we should consider config option for this? It appears that
 NR_NODE_MEMBLKS used only on LoongArch and x86 (macro in asm-generic
 is orphane).
---
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


