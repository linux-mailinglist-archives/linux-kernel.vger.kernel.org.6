Return-Path: <linux-kernel+bounces-560794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA9A6098C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6280117F3C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7238C1A7253;
	Fri, 14 Mar 2025 07:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUDnSDlx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ACF1A3174
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936279; cv=none; b=pcy9YAw9pHsiSyIvdRGHfOZB9atI2w7c3ttgZS1N8A+81l1TH1kN8dfxUK1qBWegT1Q4j6KKI4SGtFwk6y8kJulrzwKMpBhpbgZuVgu8ROLve1+r1mEkTaucY5TRF1/T8MvYnG9tqPpJrHzoRuc4ODjJFrz6hU79dR7WuptZoRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936279; c=relaxed/simple;
	bh=uvCiwqcuhHkOe5vwO0XWabYY43G777y7s9f15LVJbDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8jlyNgRzt/+FKWNlbPf/F83zh4X0VMntd3/Bxv4M1OtnRJ18i43sa8kSUOpgH++F2hP4G8+lfs4eGkRgfZQuTPf2za54mktpbpqrpm9u6+Csb+Yb5Yyus1VRqaxkkAGOA40nlnJPAQW8HfzDiFbISxQjTnqi6WY7z7W9VZC3j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUDnSDlx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSM8yJGMUJL1V2EgA9kgefSTwIIJGDw1mYV2tXceuL0=;
	b=bUDnSDlxeY7S9xjBoTlD7B6dG+FHsJQDF0BD6luolfR+xxWukc4eNtapXXNlXfaUy3nGMo
	gODJbb8Tz4eAkGcYkV1OQ08Np1nbCta1y0skaU9FO9hjenKGHvXArFxcJGzXlcPWrk9Pw+
	f3Y2yh5buGGUQdgp0z1WGCJQ/0TOzrc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-231-eVJSXXQxNviptR228Rt9lw-1; Fri,
 14 Mar 2025 03:11:15 -0400
X-MC-Unique: eVJSXXQxNviptR228Rt9lw-1
X-Mimecast-MFC-AGG-ID: eVJSXXQxNviptR228Rt9lw_1741936274
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86A11180025A;
	Fri, 14 Mar 2025 07:11:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CA6018001DE;
	Fri, 14 Mar 2025 07:11:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org
Subject: [PATCH 10/41] csky: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi header
Date: Fri, 14 Mar 2025 08:09:41 +0100
Message-ID: <20250314071013.1575167-11-thuth@redhat.com>
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

Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/csky/include/uapi/asm/ptrace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/uapi/asm/ptrace.h b/arch/csky/include/uapi/asm/ptrace.h
index 3be9c14334a6e..90a5c36e4345d 100644
--- a/arch/csky/include/uapi/asm/ptrace.h
+++ b/arch/csky/include/uapi/asm/ptrace.h
@@ -3,7 +3,7 @@
 #ifndef _CSKY_PTRACE_H
 #define _CSKY_PTRACE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct pt_regs {
 	unsigned long	tls;
@@ -47,5 +47,5 @@ struct user_fp {
 	unsigned long	reserved;
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _CSKY_PTRACE_H */
-- 
2.48.1


