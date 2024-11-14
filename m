Return-Path: <linux-kernel+bounces-409346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4215B9C8B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0652F2870D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE97C1FB758;
	Thu, 14 Nov 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="D0UgKNU7"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B8C1FB3D6
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589893; cv=none; b=dEMHezmILQKmt2p7jDbPCxd5iVll8+TgIDjI5Sj/lWTnX8avCnv6IxeGtPnPqvdqp9zxAjhUMLThdsNkHZddXn6qlq/xOEBr0/VuuQb9AQ1fb6UZFNS4fSU/YmzGykKZjzk/iT3gWIQ0C3nr2A+ViJ44LcV6GXEAaKGiL5XGE7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589893; c=relaxed/simple;
	bh=6ekL+O6Yj+5tJvXb1dq5IVXNP1lj4cEfN01MykaXiJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaeDDpqGLFeWZ2vRbdDtARMwSuVdkXuEb97iYoY9ZVJNjEWB1cgKMEjEgQclEObp2ABu0a9rVt+MQbNIsgJ6I1p24U3i4axCtc1my8rkIRFeZolz8VcCKfWMGA5jgYccqyRcgq2UN6QNPcfemgYi7CrdHvH0bZ4bChPq+LPxruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=D0UgKNU7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731589884;
	bh=SFfY1Ei+f27k37oE25d77G2m8Eso4IttgQ6BlXa9+4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0UgKNU7nWKInoWE2oC6CrSlTHGQ05VMdGF2KXVt1KKjMB4vD+Y+IKJP1QcOD/ktC
	 UGruDyBBjAzCChmQ/otjFKPeDt809ROmXM1eYyjr61bwHHkGpWY0jJ6+OGuIq8btff
	 Ez3io3TtGrSOe/lgQZwofO7GXFg2G7ko2uWC6oNKL8I8K0SJhu6opCzpBFzPUtOobq
	 h9mDV9Mxa9A1K7oJPjPUYO8zgj3Idbo8lcOZj0aveCAmYZ+/GZ/AohLmElzhMBXrwu
	 ziCGB6VPJowijZwbz7oVsCH8lEeH+YB/Wb0uKuLu1lmdX9+anvOxRWraju/HZDslCM
	 99l2WfRKdSLdA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0sS0pL2z4x9G;
	Fri, 15 Nov 2024 00:11:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<geert@linux-m68k.org>,
	<arnd@arndb.de>
Subject: [RFC PATCH 06/10] powerpc: Remove prom_init longtrail work arounds
Date: Fri, 15 Nov 2024 00:11:09 +1100
Message-ID: <20241114131114.602234-6-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114131114.602234-1-mpe@ellerman.id.au>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although these work arounds aren't guarded by PPC_CHRP, they should only
ever have taken effect on CHRP Long Trail machines due to the firmware
version check. With CHRP support removed they are no longer needed,
remove them.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom_init.c | 62 +++------------------------------
 1 file changed, 5 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 94ffc52440bd..1485494cfc38 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -94,7 +94,6 @@ static int of_workarounds __prombss;
 #endif
 
 #define OF_WA_CLAIM	1	/* do phys/virt claim separately, then map */
-#define OF_WA_LONGTRAIL	2	/* work around longtrail bugs */
 
 #ifdef DEBUG_PROM
 #define prom_debug(x...)	prom_printf(x)
@@ -267,6 +266,7 @@ static ssize_t __init prom_strscpy_pad(char *dest, const char *src, size_t n)
 	return rc;
 }
 
+#ifdef CONFIG_PPC64
 static int __init prom_strncmp(const char *cs, const char *ct, size_t count)
 {
 	unsigned char c1, c2;
@@ -282,6 +282,7 @@ static int __init prom_strncmp(const char *cs, const char *ct, size_t count)
 	}
 	return 0;
 }
+#endif
 
 static size_t __init prom_strlen(const char *s)
 {
@@ -668,52 +669,11 @@ static inline int __init prom_getproplen(phandle node, const char *pname)
 	return call_prom("getproplen", 2, 1, node, ADDR(pname));
 }
 
-static void __init add_string(char **str, const char *q)
-{
-	char *p = *str;
-
-	while (*q)
-		*p++ = *q++;
-	*p++ = ' ';
-	*str = p;
-}
-
-static char *__init tohex(unsigned int x)
-{
-	static const char digits[] __initconst = "0123456789abcdef";
-	static char result[9] __prombss;
-	int i;
-
-	result[8] = 0;
-	i = 8;
-	do {
-		--i;
-		result[i] = digits[x & 0xf];
-		x >>= 4;
-	} while (x != 0 && i > 0);
-	return &result[i];
-}
-
 static int __init prom_setprop(phandle node, const char *nodename,
 			       const char *pname, void *value, size_t valuelen)
 {
-	char cmd[256], *p;
-
-	if (!(OF_WORKAROUNDS & OF_WA_LONGTRAIL))
-		return call_prom("setprop", 4, 1, node, ADDR(pname),
-				 (u32)(unsigned long) value, (u32) valuelen);
-
-	/* gah... setprop doesn't work on longtrail, have to use interpret */
-	p = cmd;
-	add_string(&p, "dev");
-	add_string(&p, nodename);
-	add_string(&p, tohex((u32)(unsigned long) value));
-	add_string(&p, tohex(valuelen));
-	add_string(&p, tohex(ADDR(pname)));
-	add_string(&p, tohex(prom_strlen(pname)));
-	add_string(&p, "property");
-	*p = 0;
-	return call_prom("interpret", 1, 1, (u32)(unsigned long) cmd);
+	return call_prom("setprop", 4, 1, node, ADDR(pname),
+			 (u32)(unsigned long) value, (u32) valuelen);
 }
 
 /* We can't use the standard versions because of relocation headaches. */
@@ -1678,14 +1638,6 @@ static void __init prom_init_mem(void)
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = 0;
 		prom_getprop(node, "device_type", type, sizeof(type));
-
-		if (type[0] == 0) {
-			/*
-			 * CHRP Longtrail machines have no device_type
-			 * on the memory node, so check the name instead...
-			 */
-			prom_getprop(node, "name", type, sizeof(type));
-		}
 		if (prom_strcmp(type, "memory"))
 			continue;
 
@@ -2238,7 +2190,6 @@ static void __init prom_init_client_services(unsigned long pp)
 /*
  * For really old powermacs, we need to map things we claim.
  * For that, we need the ihandle of the mmu.
- * Also, on the longtrail, we need to work around other bugs.
  */
 static void __init prom_find_mmu(void)
 {
@@ -2254,10 +2205,7 @@ static void __init prom_find_mmu(void)
 	/* XXX might need to add other versions here */
 	if (prom_strcmp(version, "Open Firmware, 1.0.5") == 0)
 		of_workarounds = OF_WA_CLAIM;
-	else if (prom_strncmp(version, "FirmWorks,3.", 12) == 0) {
-		of_workarounds = OF_WA_CLAIM | OF_WA_LONGTRAIL;
-		call_prom("interpret", 1, 1, "dev /memory 0 to allow-reclaim");
-	} else
+	else
 		return;
 	prom.memory = call_prom("open", 1, 1, ADDR("/memory"));
 	prom_getprop(prom.chosen, "mmu", &prom.mmumap,
-- 
2.47.0


