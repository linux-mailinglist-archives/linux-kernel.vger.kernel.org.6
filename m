Return-Path: <linux-kernel+bounces-272832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2288C9461AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFBE1F233C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97642166F02;
	Fri,  2 Aug 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G+X3wBst";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NanZ+DpI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C571537D8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615345; cv=none; b=u7VhrzOKRIM46UqMDdIPjknchV4qGNkg9sgUePoNyW+pdrcUJIDAIgNGF5+viC9vuY/YMiN2lsou7qbH3sE9C76hweHdoimvNpR3MTTHAgmiGAoOxlAUuwSdFn9msEqGdVsPgwr8Lia4Y9/0Y8PFB3Yfky9XYLBZz0RfBD6oSno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615345; c=relaxed/simple;
	bh=+lhf1qJQ0eCZ0gZ26l9fyyX3+JU0tfa4kDsXcHnTpa8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=RMxbaObApmStroiq/vwzIfGuCBEZteStPB6hWu0m1qViQhTfyap0qWPQIdWtnDCW0nMqqb+DovGwK3DZ14tsUQWplq0bKikY4s+kwWgYxEsalPkQOdRQ0WnABKbckKu+vV+1BjQs1wHPnD+L9pjye4RtrzoqIQPFOIYmdDVGM54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G+X3wBst; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NanZ+DpI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240802155440.527510045@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722615340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mEGj6gahE3uGhGPq7NP94d2L+LEARyCcOLsYn2xC6wA=;
	b=G+X3wBst6c0PEkdNKDHZj9jwtK/W9fi49VeCHUeGjlIr1xwzjGTtIZ7qTGlroHSepeQymi
	d761VpBqsjqQAMg7bti3DKskTo3Tjk1NmhfnjgvkLokPUE5HkkRTic9ano5Bd055oIgsXV
	4dsTSnvegr6/kppCOo5wHauy0UuGToSTvaQxURKalTCwEB/tyNm9CaNxcBh9GrY1kjGdmf
	66unB3RM5FWo3u2FTHpW8FhZTJOiD9oA97SwRZ7fXb8O1y2L7mDFUvNSfTznyhwCOoznFE
	nIlRc1A62XnIKONmu8R8pGd0kGWfogfI8tdZHcN0uWBqX2MmhQbddfnI82QPAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722615340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mEGj6gahE3uGhGPq7NP94d2L+LEARyCcOLsYn2xC6wA=;
	b=NanZ+DpIZKF/gUhpN/kTkYMvS6GH6OtZnFMjziGrYNBsjO3C7uXPy5HdmtKcZWmGfzT6Ha
	z63G4gzRWQB8c/CQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org
Subject: [patch 05/15] x86/apic: Provide apic_printk() helpers
References: <20240802155038.556977544@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  2 Aug 2024 18:15:39 +0200 (CEST)

apic_printk() requires the APIC verbosity level and printk level which is
tedious and horrible to read. Provide helpers to simplify all of that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h |   33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -18,6 +18,11 @@
 
 #define ARCH_APICTIMER_STOPS_ON_C3	1
 
+/* Macros for apic_extnmi which controls external NMI masking */
+#define APIC_EXTNMI_BSP		0 /* Default */
+#define APIC_EXTNMI_ALL		1
+#define APIC_EXTNMI_NONE	2
+
 /*
  * Debugging macros
  */
@@ -25,22 +30,22 @@
 #define APIC_VERBOSE 1
 #define APIC_DEBUG   2
 
-/* Macros for apic_extnmi which controls external NMI masking */
-#define APIC_EXTNMI_BSP		0 /* Default */
-#define APIC_EXTNMI_ALL		1
-#define APIC_EXTNMI_NONE	2
-
 /*
- * Define the default level of output to be very little
- * This can be turned up by using apic=verbose for more
- * information and apic=debug for _lots_ of information.
- * apic_verbosity is defined in apic.c
+ * Define the default level of output to be very little This can be turned
+ * up by using apic=verbose for more information and apic=debug for _lots_
+ * of information.  apic_verbosity is defined in apic.c
  */
-#define apic_printk(v, s, a...) do {       \
-		if ((v) <= apic_verbosity) \
-			printk(s, ##a);    \
-	} while (0)
-
+#define apic_printk(v, s, a...)			\
+do {						\
+	if ((v) <= apic_verbosity)		\
+		printk(s, ##a);			\
+} while (0)
+
+#define apic_pr_verbose(s, a...)	apic_printk(APIC_VERBOSE, KERN_INFO s, ##a)
+#define apic_pr_debug(s, a...)		apic_printk(APIC_DEBUG, KERN_DEBUG s, ##a)
+#define apic_pr_debug_cont(s, a...)	apic_printk(APIC_DEBUG, KERN_CONT s, ##a)
+/* Unconditional debug prints for code which is guarded by apic_verbosity already */
+#define apic_dbg(s, a...)		printk(KERN_DEBUG s, ##a)
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86_32)
 extern void x86_32_probe_apic(void);


