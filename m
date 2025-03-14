Return-Path: <linux-kernel+bounces-560811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B093A609B3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB4717F4D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104DC19C542;
	Fri, 14 Mar 2025 07:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwLJ4d+m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15761F4161
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936336; cv=none; b=EBV9WHAPtbyDSsLI6xhjcOeJffqhecsCM+eeCAckkpvvvaL0U4mM+8yQEL378RSAxmEP5Ez9QNvt/LxSG2NddSJDV7Bowbrja5hD2PKmqMxn1WgzJdX2yQ3AEWCkNn9VqnR9G98eVyXvTBvlyEf1yve/KEos2fUl84iztHAqivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936336; c=relaxed/simple;
	bh=24nIigKqUR5/mpE/nuVav2M2yUc/68lKrirfCRGqyYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7y9sNb8OuzWW6cj0Xb4Metq6TNKyiYay2C7KohiZuC+Q1ljNwsz+HnyTGSR0Jga3mYDkYtMbB9ORHzKTYS+4lz+NjORizzPql8Ull9VIjMMlbzlyM4F2azY6a9ZJZQFFSk3z4zMQsRhUFVfCT/tf1ZR8Xs6fTt57+acaK/Sc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwLJ4d+m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1J6uZ7xQ2adwV3Pj81tSTlKA4+Ihx+BomOCjD/knIB8=;
	b=OwLJ4d+m5fabbqdlO2+2yyDCEP/f8E800sYR0l7K+p00YgO8kctJdz7QeHEVlk7GFSUTV/
	ypwII0vLoDFUTit067EU1r9XUpskwCYvyeaWua/HR/NH0fttDngXxr7ZjfPkkgA1aq2Ix1
	3DabTr2TfUnZomLVPxbZIAJoz4x0aD4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-G7Fg5QNmOUCuDk0l_fRNrA-1; Fri,
 14 Mar 2025 03:12:09 -0400
X-MC-Unique: G7Fg5QNmOUCuDk0l_fRNrA-1
X-Mimecast-MFC-AGG-ID: G7Fg5QNmOUCuDk0l_fRNrA_1741936328
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39AF41801A12;
	Fri, 14 Mar 2025 07:12:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D82DF18001D4;
	Fri, 14 Mar 2025 07:12:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org
Subject: [PATCH 24/41] parisc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 14 Mar 2025 08:09:55 +0100
Message-ID: <20250314071013.1575167-25-thuth@redhat.com>
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

This is almost a completely mechanical patch (done with a simple
"sed -i" statement), except for a manual change in the file
arch/parisc/include/uapi/asm/signal.h (where a comment was missing
some underscores).

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/parisc/include/uapi/asm/pdc.h    | 4 ++--
 arch/parisc/include/uapi/asm/signal.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/parisc/include/uapi/asm/pdc.h b/arch/parisc/include/uapi/asm/pdc.h
index fef4f2e961601..65031ddf83720 100644
--- a/arch/parisc/include/uapi/asm/pdc.h
+++ b/arch/parisc/include/uapi/asm/pdc.h
@@ -361,7 +361,7 @@
 /* size of the pdc_result buffer for firmware.c */
 #define NUM_PDC_RESULT	32
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 
 /* flags for hardware_path */
 #define	PF_AUTOBOOT	0x80
@@ -741,6 +741,6 @@ struct pdc_firm_test_get_rtn_block {   /* PDC_MODEL/PDC_FIRM_TEST_GET */
 #define PIRANHA_CPU_ID		0x13
 #define MAKO_CPU_ID		0x14
 
-#endif /* !defined(__ASSEMBLY__) */
+#endif /* !defined(__ASSEMBLER__) */
 
 #endif /* _UAPI_PARISC_PDC_H */
diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
index 40d7a574c5dd1..d99accf37341b 100644
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -61,7 +61,7 @@
 #define _NSIG_BPW	(sizeof(unsigned long) * 8)
 #define _NSIG_WORDS	(_NSIG / _NSIG_BPW)
 
-# ifndef __ASSEMBLY__
+# ifndef __ASSEMBLER__
 
 #  include <linux/types.h>
 
@@ -80,5 +80,5 @@ typedef struct sigaltstack {
 	__kernel_size_t ss_size;
 } stack_t;
 
-#endif /* !__ASSEMBLY */
+#endif /* !__ASSEMBLER__ */
 #endif /* _UAPI_ASM_PARISC_SIGNAL_H */
-- 
2.48.1


