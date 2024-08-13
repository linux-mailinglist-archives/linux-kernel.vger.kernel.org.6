Return-Path: <linux-kernel+bounces-283976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F285294FB58
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3119E1C21B66
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9226FC5;
	Tue, 13 Aug 2024 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FRIFXODA"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065310A19
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 01:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723513737; cv=none; b=r8927qESIByC0LRtSEqdI79TH8U7H5IbbXMZ9QxuEt0mHcw5o2p6KiUnGPE2bK8nUUpQcaoCyG5Z6w9IyWNDDqJ+xvTdkfbpeV+OrT/sOM+Jfanpb3lLEcDSc6H33Vw69JZNi2sgJ5Agb5kS//gGwxjlXfa+9/cG8wRwmlav2LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723513737; c=relaxed/simple;
	bh=GKHq6W211eXA6IvNQgt9423vFTuhEiQ6hqo+cogHSFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1sXGMucqeNEyIzE9pWYrpJ/F3GNb9CJumaPiihothycta5UB+GYS9nM1tqHE06i0KgA+QOBXTK7rxbCoKmcXT0Ks0tpFKPfi6VKd6/kmdkJOHpr7ptLt5F8vcuKbiq2QDO4pEEAoQtlXQ+H+ej6NnfabfTjG7QqDUqXwb/2fBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FRIFXODA; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723513732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVApGMy4AaeQ6i5q9HaIeTkayza3fuRQm2vg2IWH9hE=;
	b=FRIFXODAkwg2NO0/OeKrREuE0Nb4ANXmrQ3bOrhpmWdE9tJqMP1GXvs9X7fxlwKZp9KFf8
	sHq0E1m7vyqp8sSrCa9Jkp4Ja43Q2qWnYre85yI6W3/Jbg0TQLCvxBr0hIQENQx/GcJWjU
	3Z7dSy0FGqFdEEffuCw4QQ0bM6Dglf4=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: tglx@linutronix.de
Cc: bp@alien8.de,
	daniel.sneddon@linux.intel.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	thorsten.blum@toblux.com,
	tony.luck@intel.com,
	x86@kernel.org,
	yuntao.wang@linux.dev
Subject: [PATCH v2] x86/apic: Fix the issues in x2apic_disable()
Date: Tue, 13 Aug 2024 09:48:27 +0800
Message-ID: <20240813014827.895381-1-yuntao.wang@linux.dev>
In-Reply-To: <877cclsjsg.ffs@tglx>
References: <877cclsjsg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are two issues in x2apic_disable().

The first issue is that the 'pr_warn' in 'if (x2apic_hw_locked())' will
never be executed, because when x2apic_hw_locked() evaluates to true,
x2apic_state should be X2APIC_ON_LOCKED. However, the current logic in
x2apic_disable() is that if x2apic_state is not X2APIC_ON, it returns
early, so the subsequent logic will not be executed.

Therefore, 'if (state != X2APIC_ON)' should be changed to
'if (state < X2APIC_ON)', so that when x2apic_state is X2APIC_ON_LOCKED,
the corresponding warning log can be printed.

The second issue is that the current logic of x2apic_disable() first sets
x2apic_mode and x2apic_state to 0 and X2APIC_DISABLED, respectively, and
then tries to disable x2APIC. However, when the APIC is locked in x2APIC
mode, that is, x2apic_state is X2APIC_ON_LOCKED, x2APIC cannot be disabled,
which causes the final values of the x2apic_mode/x2apic_state variables to
be inconsistent with the actual state of x2APIC.

Let's fix these issues.

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
v1->v2: Modify according to Thomas Gleixner's suggestion.

 arch/x86/kernel/apic/apic.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 66fd4b2a37a3..50acd094b055 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1775,12 +1775,9 @@ static __init void apic_set_fixmap(bool read_apic);
 
 static __init void x2apic_disable(void)
 {
-	u32 x2apic_id, state = x2apic_state;
+	u32 x2apic_id;
 
-	x2apic_mode = 0;
-	x2apic_state = X2APIC_DISABLED;
-
-	if (state != X2APIC_ON)
+	if (x2apic_state < X2APIC_ON)
 		return;
 
 	x2apic_id = read_apic_id();
@@ -1799,6 +1796,9 @@ static __init void x2apic_disable(void)
 	 * which fails to do the read after x2APIC was disabled.
 	 */
 	apic_set_fixmap(false);
+
+	x2apic_mode = 0;
+	x2apic_state = X2APIC_DISABLED;
 }
 
 static __init void x2apic_enable(void)
-- 
2.46.0


