Return-Path: <linux-kernel+bounces-282916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AEC94EA80
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABCFD1C214D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D6916EB65;
	Mon, 12 Aug 2024 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gxOH7lJX"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2C1876
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457369; cv=none; b=LmTnZjA12Of1H4Jfb5qFKTFyvM9STT4n6mVlOTNlusCPuI2h1yXeVGXXObFRoAxTx2eY2XQRC3rszx2PFFvvA3Y713wFSXRuGaMHaKt10Hkml50bNyick5PixnaLaQqMgqd6vd0rPbtz569hXmqMx87STM74w45f7u+cxsK4+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457369; c=relaxed/simple;
	bh=DFQkQyPTLtO9csMPdHckMf2AoZU+rmnGY92wr/XoIWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jn7zY1uU6B5E+J8nuB/F8701XFqTkKASYBWL2wLIAZ26arFV6m54cbvObOGZ5IDwsSqTQg3dhdiiWduvMxFYQVVxGaLBs30TuNhpD+t8F7X+e7lHGTABuru15y6mTF16V1jHC2VMAUydrFlhbomBJ9sje1aBxKJe6lzXjnFzCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gxOH7lJX; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723457364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5eIqO98Kp5gIw1ujY2odsXYfF8no71k2njGFE7VQoJs=;
	b=gxOH7lJXWvfkDhqSrz0r98ZDBAhpzuXEE3IRUpzL4c+Bsuv5Qek6keZgHeNtTBOYY1hMK8
	vfncpbbHD03w7Kg4D06ykcqwVcsj+Of2c5tcTkmesae+PijXNb3NU9BVnRHwvM+dB10qv5
	BdnTRpJgcEiCkHuIn6nLlgCjVtCvHVw=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Tony Luck <tony.luck@intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH] x86/apic: Fix the issues in x2apic_disable()
Date: Mon, 12 Aug 2024 18:08:19 +0800
Message-ID: <20240812100819.870513-1-yuntao.wang@linux.dev>
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
 arch/x86/kernel/apic/apic.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 66fd4b2a37a3..fce8d0214069 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1775,13 +1775,10 @@ static __init void apic_set_fixmap(bool read_apic);
 
 static __init void x2apic_disable(void)
 {
-	u32 x2apic_id, state = x2apic_state;
+	u32 x2apic_id;
 
-	x2apic_mode = 0;
-	x2apic_state = X2APIC_DISABLED;
-
-	if (state != X2APIC_ON)
-		return;
+	if (x2apic_state < X2APIC_ON)
+		goto out;
 
 	x2apic_id = read_apic_id();
 	if (x2apic_id >= 255)
@@ -1799,6 +1796,10 @@ static __init void x2apic_disable(void)
 	 * which fails to do the read after x2APIC was disabled.
 	 */
 	apic_set_fixmap(false);
+
+out:
+	x2apic_mode = 0;
+	x2apic_state = X2APIC_DISABLED;
 }
 
 static __init void x2apic_enable(void)
-- 
2.46.0


