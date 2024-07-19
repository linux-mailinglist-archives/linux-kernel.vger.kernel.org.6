Return-Path: <linux-kernel+bounces-256936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D78569372C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 05:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709971F21D47
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 03:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E35E17BA1;
	Fri, 19 Jul 2024 03:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tu0jvndy"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8110A09
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721359716; cv=none; b=ifO3EPyzU5kFd/f3UTDdLDYnuT6jw4EYrJJ9MM5P1cUIYquxoGp1EDJ9HWiCr9UeiGe8fknvMEQ62lXRBJtgALvJbn/ds2HMUW/FslwXnSOogTJ5h/DixcrVCYsouguum0/hKFw8YX2wulqPtrwVahK0TgviAoKsiF+b+rWtLtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721359716; c=relaxed/simple;
	bh=jpqLWQGi1R51AMMrM+Fv6wtB6ksjM36mFzPhkNRTKlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKz/41y5S2hEikhLVR7eYr+CjLoSHfv9TfKbMJfZ/Q26Jvdg5QFyQvqauC/AAdZ9PMAIfoI8tGD2YUoNLtlkl+9Z2dcw4ASvpuxZQETWd96D8925JD37oPLNpipil3+m+M0e+S9U0A0Nr4MBAGjStR/3NTT/VymDJ0457JIwArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tu0jvndy; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721359711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NKdeifrON+LGBPOD/jY7HSMsQkTavNdc3tFjc22kFHc=;
	b=tu0jvndy33/2c4zuaKJ/xO9pMbpo0MRL91nAiWYHHf4q44p0ZT013v8nXB4qiA25EC+M2I
	8mMXxUD3WzZ+oHqsiXaZi1TUwBJIEg2jJw8zYHGD25+NmaYuhz5BjDsMoMY+cozKpGXWIq
	n50Lq6vJOb6aFmbPZfn3oQjLqy8HJs0=
X-Envelope-To: x86@kernel.org
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: mingo@redhat.com
X-Envelope-To: bp@alien8.de
X-Envelope-To: dave.hansen@linux.intel.com
X-Envelope-To: hpa@zytor.com
X-Envelope-To: xin3.li@intel.com
X-Envelope-To: peterz@infradead.org
X-Envelope-To: vegard.nossum@oracle.com
X-Envelope-To: tony.luck@intel.com
X-Envelope-To: pawan.kumar.gupta@linux.intel.com
X-Envelope-To: rick.p.edgecombe@intel.com
X-Envelope-To: yuntao.wang@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yuntao Wang <yuntao.wang@linux.dev>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin3.li@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Tony Luck <tony.luck@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH] x86/cpu: Use TLS_SIZE instead of open coding it
Date: Fri, 19 Jul 2024 11:24:37 +0800
Message-ID: <20240719032437.35258-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, there is already a macro named TLS_SIZE defined in segment.h,
which is equivalent to 'GDT_ENTRY_TLS_ENTRIES * 8'. Therefore, we can use
this macro directly in cpu_init() instead of open coding it.

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 arch/x86/include/asm/segment.h | 2 +-
 arch/x86/kernel/cpu/common.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 9d6411c65920..c6d710340c02 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -227,7 +227,7 @@
 
 #define GDT_SIZE			(GDT_ENTRIES*8)
 #define GDT_ENTRY_TLS_ENTRIES		3
-#define TLS_SIZE			(GDT_ENTRY_TLS_ENTRIES* 8)
+#define TLS_SIZE			(GDT_ENTRY_TLS_ENTRIES*8)
 
 /* Bit size and mask of CPU number stored in the per CPU data (and TSC_AUX) */
 #define VDSO_CPUNODE_BITS		12
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d4e158..08b58de86c45 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2220,7 +2220,7 @@ void cpu_init(void)
 
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		loadsegment(fs, 0);
-		memset(cur->thread.tls_array, 0, GDT_ENTRY_TLS_ENTRIES * 8);
+		memset(cur->thread.tls_array, 0, TLS_SIZE);
 		syscall_init();
 
 		wrmsrl(MSR_FS_BASE, 0);
-- 
2.45.2


