Return-Path: <linux-kernel+bounces-560813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ED8A609B7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C445117192E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857DE1F462D;
	Fri, 14 Mar 2025 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ie8vQMZH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4271F1F417D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936345; cv=none; b=KoHLHstHvMCYuSjeVwERjtF0FF6/yRCEKbZch4SpUjJ8yT7iPa8FbH/r4pDk0cfUvRR9AjM3C4mVtrH3xVBTLzYjyk+rM+nBxShXxn5p/WXl4IswU+ztadOKdmMg1yn1GgcaPcMCI0X+Jt+kojDRFvy/gcM2ObXPht/LcfWvIYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936345; c=relaxed/simple;
	bh=YEHMcikcet8aty13RKTNwhjEn7GHWx00IgHKhIH/TFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxP9J62GkFR5u19dspS6iMQtVHrsfrXVcKcMyK9WKpTTJQAJKddEFw4p6FULoc6R5RIA991I1J3FyZRSAzaZ4rVZHuOU0cIzvAmGR3tsItSdr1p/5zoUv0yWzKIxW+kZ3+u1hYTxcL4/YpmfCRUcYLtzqWTbC1Tz6Y2v6fH1Dpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ie8vQMZH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dSjUdv+wNUmbSqWZifQPj14OsZRcZ5i6atD82Al+C+8=;
	b=ie8vQMZHhxc0vI1mtSlx15ln3gF8zbQBhj2wjtua8EVZXpb3JjJyuzhQk/t5soegIyeTer
	CR8nR7Isp7Tnpb+VtkvUt5t5iajsy8um20PgdHUgo0yvXtUI//2AsENpyZRTJnSOcZE9sX
	iJikCP+DQWsGr6rlraYJYS6Wrj8Sy5g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-KGbOqyMwNxCRVfMUlTveAA-1; Fri,
 14 Mar 2025 03:12:19 -0400
X-MC-Unique: KGbOqyMwNxCRVfMUlTveAA-1
X-Mimecast-MFC-AGG-ID: KGbOqyMwNxCRVfMUlTveAA_1741936337
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5580718007E1;
	Fri, 14 Mar 2025 07:12:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8C3B18001DE;
	Fri, 14 Mar 2025 07:12:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 26/41] powerpc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 14 Mar 2025 08:09:57 +0100
Message-ID: <20250314071013.1575167-27-thuth@redhat.com>
In-Reply-To: <20250314071013.1575167-1-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembly
code.

This is a completely mechanical patch (done with a simple "sed -i"
statement).

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/powerpc/include/uapi/asm/opal-prd.h |  4 ++--
 arch/powerpc/include/uapi/asm/ptrace.h   | 12 ++++++------
 arch/powerpc/include/uapi/asm/types.h    |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/opal-prd.h b/arch/powerpc/include/uapi/asm/opal-prd.h
index 1869cf83a870e..11abcf0192ca1 100644
--- a/arch/powerpc/include/uapi/asm/opal-prd.h
+++ b/arch/powerpc/include/uapi/asm/opal-prd.h
@@ -40,7 +40,7 @@
 #define OPAL_PRD_SCOM_READ		_IOR('o', 0x02, struct opal_prd_scom)
 #define OPAL_PRD_SCOM_WRITE		_IOW('o', 0x03, struct opal_prd_scom)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct opal_prd_info {
 	__u64	version;
@@ -54,6 +54,6 @@ struct opal_prd_scom {
 	__s64	rc;
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI_ASM_POWERPC_OPAL_PRD_H */
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 7004cfea3f5ff..01e630149d48e 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -27,7 +27,7 @@
 
 #include <linux/types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef __KERNEL__
 struct user_pt_regs
@@ -57,7 +57,7 @@ struct pt_regs
 	unsigned long result;		/* Result of a system call */
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 /*
@@ -200,7 +200,7 @@ struct pt_regs
 #define PPC_PTRACE_SETHWDEBUG	0x88
 #define PPC_PTRACE_DELHWDEBUG	0x87
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct ppc_debug_info {
 	__u32 version;			/* Only version 1 exists to date */
@@ -212,7 +212,7 @@ struct ppc_debug_info {
 	__u64 features;
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * features will have bits indication whether there is support for:
@@ -224,7 +224,7 @@ struct ppc_debug_info {
 #define PPC_DEBUG_FEATURE_DATA_BP_DAWR		0x0000000000000010
 #define PPC_DEBUG_FEATURE_DATA_BP_ARCH_31	0x0000000000000020
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct ppc_hw_breakpoint {
 	__u32 version;		/* currently, version must be 1 */
@@ -236,7 +236,7 @@ struct ppc_hw_breakpoint {
 	__u64 condition_value;	/* contents of the DVC register */
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Trigger Type
diff --git a/arch/powerpc/include/uapi/asm/types.h b/arch/powerpc/include/uapi/asm/types.h
index 327616fb70e44..9dbf55e38ea58 100644
--- a/arch/powerpc/include/uapi/asm/types.h
+++ b/arch/powerpc/include/uapi/asm/types.h
@@ -28,14 +28,14 @@
 # include <asm-generic/int-ll64.h>
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 
 typedef struct {
 	__u32 u[4];
 } __attribute__((aligned(16))) __vector128;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 #endif /* _UAPI_ASM_POWERPC_TYPES_H */
-- 
2.48.1


